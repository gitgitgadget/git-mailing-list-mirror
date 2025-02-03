Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7907D204681
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569844; cv=none; b=GTXzT1ox/6bfro0VcffOyKa+/BvMOEY3k+Tf9oHYLq/SMxBv0ezCDXB8nCC4uTwPEDmUV/mWNzsTqq1foy/3oegYLUtUojVLhEr15LCP5jZPb7UzIph3it0R4qav11c55EwES5j+qWrQhpuMJ8mxhW8EtBBAJpoMj7767NnoDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569844; c=relaxed/simple;
	bh=W2B8uLIzFZeET9wQUMNG8NO4UD5geIslDkz1uBV5I1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L+fXAlIz/U1gMPqA8ux4xRpYIpWaXiMbhxw7atOxGvRtfnR6u7OOgLCT6hzHMcZnkAT7UpEdehcqCrsblatrvJIJ1wJrieflgJj9JV/Z5k62FXvscmyl7Jc3/H7Hb6e5KWG1bNr8jpBjnWHotPQCgG42c8hYQTk4urK9LHwpoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EoUbOZ6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wSpySztn; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EoUbOZ6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wSpySztn"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D0D9511400D9;
	Mon,  3 Feb 2025 03:04:01 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 03 Feb 2025 03:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569841;
	 x=1738656241; bh=Hy7L98qAVitIr4LITWn5Ag81z0bJWUdcNau1p8TF9mM=; b=
	EoUbOZ6r6jW4btUXt+V7qom+PabsmWmCasOWZQnxCqMz+O34YI7KP1LMyXU1EZ67
	c1aW+yH9JkFL63KjDQtpDJdLwai7vPqOiuwI+EC2KDPzQJJfSWGjsInrKXr//3eq
	J9Ju/XoRrtbRgh3xCpt7unvESDU/0soBhw9ngXmfSgsMd4MSDms/GYJwxsB/bsB9
	4dnw8FXSvV4WjCFoPSIrnzPZ06MUKbV/5D6kIA4xjb+lORFQidqjmYObT3lsOoX/
	FHU295DLA3zPOXFed6aarBAAIGvJRP4GTBzc4CEcMvQBmxwh6Jk4yyXNtu4CADSY
	0ScdHlBW/T1V0s4802gQ1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569841; x=
	1738656241; bh=Hy7L98qAVitIr4LITWn5Ag81z0bJWUdcNau1p8TF9mM=; b=w
	SpySztntf0gj8Xvd+Pj1+H6Q4YTRGv7BTY6iFywi337n3AIBmcZw123k6IoJyhVS
	OqB2tymD7YJUsQKI6YYjPFyu13CkNRQCG09FIQZ7tM3LZwOb8bM77GA3eqH9zzLJ
	B26DqxoJgCMi4g6ni9IL86oSKjPhb2E1CNNA08Kqzpbvz2i7XKIUJ9k5nFJMdCkm
	IaQC4YK+2SyZ7gnZjc1i352KsVfD82migb1RcrbCJfHf3wIc1gyxintlKEO/oZeE
	IgTlJSBEJ5XOzZyUSomVzZ6bQMI2ZKtunwks4rbZ9e82mTyNDM7aR5kolNUQtdjx
	M7xIo6dnCtv8Su+M+hT1w==
X-ME-Sender: <xms:cXigZ9zEAOHkN713OVXwbxGVe5rFLU5hcxELbptkBhMQdUoFihWvIg>
    <xme:cXigZ9SV9whec0wGpA7rOQRrJ5DiuTJOM_dOql6NQ0w0qYUW54M8iWx9XqYH_oW3V
    pGCDKrpSKktKccCjw>
X-ME-Received: <xmr:cXigZ3Wb1zC7u9ygtGYz4tE5xfLhgurCsSKjNowoHn0Q9oGB0B6wx6IdXB9bY_jIQd5wHJY-buXX_oP2t6_C2sOdbB92SufYrRNemSMeKSNw7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvug
    ifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:cXigZ_i6N4yElmxkm0F0dUq_EXecv49XA_NDZZfNMBU-U8FuyFaSOg>
    <xmx:cXigZ_AvmW7II0CKkGEBUQ_BVnHlr-DrGUGhkB7z2hEv0Ifwtx2Paw>
    <xmx:cXigZ4KlcYpIgg6SZCONt0IDZuJ40QdbOcUz7a7m0G_nTVvqsKCOKQ>
    <xmx:cXigZ-DVi8_dLYhfwt_dyTIw7CYPP9_v9SLWwEDFyKQkScefWuPnsw>
    <xmx:cXigZ69ALvlH27t4GyNDsnHJ18iPVTdITxh05jnIAdr31ttuABI5SGlN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:04:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 04679e13 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:48 +0100
Subject: [PATCH v3 17/18] reftable: decouple from Git codebase by pulling
 in "compat/posix.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-17-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The reftable library includes "git-compat-util.h" in order to get a
POSIX-like programming environment that papers over various differences
between platforms. The header also brings with it a couple of helpers
specific to the Git codebase though, and over time we have started to
use these helpers in the reftable library, as well.

This makes it very hard to use the reftable library as a standalone
library without the rest of the Git codebase, so other libraries like
e.g. libgit2 cannot easily use it. But now that we have removed all
calls to Git-specific functionality and have split out "compat/posix.h"
as a separate header we can address this.

Stop including "git-compat-util.h" and instead include "compat/posix.h"
to finalize the decoupling of the reftable library from the rest of the
Git codebase. The only bits which remain specific to Git are "system.h"
and "system.c", which projects will have to provide.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/system.c | 2 ++
 reftable/system.h | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/reftable/system.c b/reftable/system.c
index e25ccc0da3..1ee268b125 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -1,3 +1,5 @@
+#include "../git-compat-util.h"
+
 #include "system.h"
 #include "basics.h"
 #include "reftable-error.h"
diff --git a/reftable/system.h b/reftable/system.h
index 3bd4a4e322..dccdf11f76 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,7 +11,8 @@ license that can be found in the LICENSE file or at
 
 /* This header glues the reftable library to the rest of Git */
 
-#include "git-compat-util.h"
+#include "../compat/posix.h"
+#include <zlib.h>
 
 /*
  * Return a random 32 bit integer. This function is expected to return

-- 
2.48.1.502.g6dc24dfdaf.dirty

