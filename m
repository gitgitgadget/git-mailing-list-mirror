Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1302253FD
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828358; cv=none; b=Xufeexkwx8N+7qhXyK1hPSXR165Ri5D8F27wsybPuPEQXYui1bkBhAyv7KXam1PFcjKfx2PKxivrTnuLGs5WDlVSp9CJ2nu813tzPL/2emsOLtm7iU66GtFzC/QuFL2LOiUi33cym+qn3Q19K2pIyWYz63VCzeBFTBHmfLAo+JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828358; c=relaxed/simple;
	bh=0zzM+2czzRAkYhbvM5bN90P3r+/rn9lE+fLpLyyJyQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C0bWABgPATyeY1NNknKzsgbQwo3J1ZEPGyt9lhdABXXAG9XIhz+xNqn2ZYWyrf/EjNj+nKmzseuqBD4PkvQ9n0rFw0JOjxAk1r7F2pjETi0hbCquUcAq2/BoKPkxKFzpLknHRnK8gL7H7p072wDTR5tKn4jD8ChsUEW0mOXxN90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ESmIpA1K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O2VzysDr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ESmIpA1K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O2VzysDr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FE9C13801F6;
	Thu,  6 Feb 2025 02:52:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 06 Feb 2025 02:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828356;
	 x=1738914756; bh=YVhcg1aFDrdX2uHQZN3UE/+/DjM6zfjjL12G1uMB3t0=; b=
	ESmIpA1K7o03LdCBFCbz3ujaGf2RISraxDLbhxJbavoLaBu5GWNLoy49p//hCysD
	j2bvbVvqmFzZYhsIqNKVvvvFLHYSHZXO4t3z0iNn2MDjPqAcopFTy82W7Lv1TsWi
	2/lWoSrj1JfjygMwe9m9bynu7TNsnB/buTKCuIp8F0fw4NRpysHKP32qwM8wkBJK
	bbY+sYtaByZTtkiXM0wYmEoMeqPMEyOjZWqTa8ZU9iUVQc8iqtw5q2xHvo1SUBdM
	zTVQAPQZ6kDukn30iFM3f8WJt5yf7Amm6i0uCAbDiP9ieUD2ZK8cGxhs5U/4bHnD
	tJeivdKgX+HWUVGDgFgLYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828356; x=
	1738914756; bh=YVhcg1aFDrdX2uHQZN3UE/+/DjM6zfjjL12G1uMB3t0=; b=O
	2VzysDrvVooyMYt03Xo3mBFVXvCMRnDiZ1b4BtirxVILGxjAUzsGOyEwoaZSqSFR
	X6zDCTveVrmVRSt2vblI12uf+OUugwYxQX0mJ50Pl1kHzC37TBJb8SObaN/tIjxk
	sL6BfY4UuNKFNrfgWgJnoWOjXxw6qfFsjLN56QTeTNB98AaREnEiIHvSNt5A3DJ9
	Qx6o86MdYAiadYiJLW7V+lkZ9Elq6k+9IdoBus4YFeQNniCfLmP/bXkR6xNXNSC2
	qgsqqXFf02BS8eNZT/Jltv9T95eCjltJ1yTz/D0zwaTajpvwKYtV0f+19zZI/UJ3
	f/YR6Vr8fPkXeM1dHVBCw==
X-ME-Sender: <xms:Q2qkZ3VsPwnR_uXzh-Fp1TFyX86wBQ0HIkAt3QBDaN6h3TV_ItZqmQ>
    <xme:Q2qkZ_lnRKVosxJwM9z4B8IozEtt3qExvZTcZ5b8XG9k8rZsN7Wux9QjY4eRp85w0
    I7pJKskKkPbxM8rdA>
X-ME-Received: <xmr:Q2qkZzZTdpI6Qx6hpMq4uElD_3k8_brm0XKouonfWmVg3vM_gc58wNCqyexuZkLNZYBDXTDih2bI-TQowtIoll9tR4WMiX1vWaIFHwqHoA3N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhei
    theskhgusghgrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:RGqkZyVez3kN_Tqb5YDmJnJjv7SKfF5rcf6_ASFrNa52kVVkkyIyHA>
    <xmx:RGqkZxkYQEgQEy_ThERCsfuLYmtwk6ws1_nqGgYyvk5sBSpM-ICF3w>
    <xmx:RGqkZ_dU4771b4cTynIB-ntP-thNvVWvfMYK3Ioxa5u4c2SqvI1d5A>
    <xmx:RGqkZ7Gocn1_I5iJx2tn_GO8kvM1Pmj5v2NRMbYqFGh5jwn9L7EkpA>
    <xmx:RGqkZ0uG3nanLCF_3DOOhoC3EyglOTWw5hnIovhuZWzgJIG8rmCsDLPe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00802eda (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:19 +0100
Subject: [PATCH v4 17/18] reftable: decouple from Git codebase by pulling
 in "compat/posix.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-17-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
2.48.1.538.gc4cfc42d60.dirty

