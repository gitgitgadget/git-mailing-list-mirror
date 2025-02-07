Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338791E5B67
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929140; cv=none; b=fe1SMW4G9WASVt5A27TUUG8/QKWpj0idv2TyGhqaDADEQALBaKEdkxkwJ8ZwxYPfn7E+s4aSNVsFeel8zfyggfVPVhDk87rBs/v1GCUqPdHQYNfdykeHwRwtpB6n36ESM+J58xZt3azbPEt6JLdU+2HxJGTNFo5bzlazKjIygrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929140; c=relaxed/simple;
	bh=0zzM+2czzRAkYhbvM5bN90P3r+/rn9lE+fLpLyyJyQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=molOoeg/UNANNDHh75LYT/T4is5BZB+7bn3EW8wyPfunZac/W4yl9QumjW7nOHqBm77lyb7Xs5tQbjKJ3HerWeqX/ltZ5voCkfNOQyKa+OlkuVbFHChUvPLizT7JsKtMLJzkYbRKgSBXViGAQfJq/A+0LemVMVtO7K/Dh8FIb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dWA34H2B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IFhL9xsy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dWA34H2B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IFhL9xsy"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8787B138017E;
	Fri,  7 Feb 2025 06:52:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Feb 2025 06:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929138;
	 x=1739015538; bh=YVhcg1aFDrdX2uHQZN3UE/+/DjM6zfjjL12G1uMB3t0=; b=
	dWA34H2Bsd4JJyrV7XQdSa7p7yeoAn8dUT9hhGswkuVeGAap+3NjQRAQeA4HQ5P/
	Uaq6ZOkcvTRkZvlV/IM3/0BX7pZeOECbQKGEz3Fh20QRIzQcpuHg6qKQyViVfj5F
	uV0LJIyEm0OusHdyYz78BDBwg4RofapO5gfxvw86Lvp2MbfYEUhd/v9465s8rmO0
	Jx2FVP0aC1SmaSllsEgTNCdgYelh46ZpOB7aMgIsDKAoa0mRtULXiPeTusd7I1/o
	VqM3OEOGGHHQn/XLYIwTfn2aCd8R6NGOpVK0b7Cw1C3XzqkPxRgQDMBNlRGyxIJw
	KboJNJOgnYXO38koUDYzdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929138; x=
	1739015538; bh=YVhcg1aFDrdX2uHQZN3UE/+/DjM6zfjjL12G1uMB3t0=; b=I
	FhL9xsyQlVQFX2UqRTn90/hSCUnByvX9Pll47m326tLo9ybDNNyBSOBkTLGPJHAt
	owdaU6/8pmweoaA3rENJkQMlbzJH6pGL8gxZQiBiG/eRFvd9nVu7lHBqCpHuWpu3
	7vtOiIUQ10bLC+BZYzF2wJCoAYwBiC7agj7W6UoHCkeWIsgBLyAFEywaAhx5zHxI
	ymWX5u/nWxDGuVmquJBkaGfKU4MLG5PWiNBe50yve5ZfYX8eYXTvM9C90mUkQu7M
	Lzw2b4Vn/aUSSy5giJxe56+paxFoGNz3bvvIRv06+y08ng0SMDOnipFOv/dNQRzo
	SgvRA2G+Ob2pj2acXBGCg==
X-ME-Sender: <xms:8vOlZ7rXRIvjenwqVTXuWbsB6NSnFu6u_cERYImxXcN82uc9O9Hiog>
    <xme:8vOlZ1oSj5n5ZPEyvxpg7mz9wfa-MihtmJqvanDCQr_TFLHO6aQH4q59UIoMfsYpL
    ONhHkAS9lfAWCpSHw>
X-ME-Received: <xmr:8vOlZ4MEwNpfHVnsvikP48Yqy8ceG9cPM4NOV8EMIaBYRVCCYCoW6v5zmjrh2WyfFGU_ZKDFrju-9bpL78nkA6v56Vf_ST8PwgmRrXpmyfA45b1z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhn
    segvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:8vOlZ-4Jd6_zvbYnBMtoBo9nwt1uaPN7xgaVJ8gB3gHrdcrbrUtTig>
    <xmx:8vOlZ67SRnBVMMqRqAVh-UZRB2BM3OBOOgNQ75DGIbR6fq6irIXjxw>
    <xmx:8vOlZ2ikvgwZ6FmKuXwjEBvX_9i3H6n6rcBlvvJFFbcQktmH2JV6Aw>
    <xmx:8vOlZ84BX-e1po9EkNuOO6UXH_cFn15nkZmBJb163o4sStJHSY7rhQ>
    <xmx:8vOlZ8S3gYPDpR_Eb8y1pstEXf184uMEbQl3Nz-JYzuHMB7xIH5c6TDL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b8ee0a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:52:12 +0100
Subject: [PATCH v5 17/18] reftable: decouple from Git codebase by pulling
 in "compat/posix.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-17-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
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

