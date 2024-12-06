Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8842206F02
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480875; cv=none; b=VjBl9pzuwo94IUJ7ZG3+ivm63/iXhvF3bX3BkDcByPIhrOr3cyA40iNcSKopHhfhrlWcYDVXJAYsupBIrGNivRPj6/ggxdDDHjycvYN9TtvmGfzkX0ydf95mIJkgxnGi77Eza/QvTYE/+9JbsVtb8f3bi40WvV5R29FyspGQ6Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480875; c=relaxed/simple;
	bh=JkYboJKZHZM+ac9wiyc90QKzF5VInOMnSQN9tRtdM3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EnjDD+IX0SG/ciIHkFcyEU2/p4V/iyhSqmTxes53iYKHsBCoug6sY3AOwanXHY67/Ph+BSxz1SRPOvBYEfA6UBDbZzwBHqQgDff/akynfshMVX3pNS6rkJgI4896msdmOwsUpeGNBxrhjHmAg+m53RjtXftNQUhKrTNVyzxGR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pi9CsvK4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EgrdIXJ4; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pi9CsvK4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EgrdIXJ4"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id F3BD1114017B;
	Fri,  6 Dec 2024 05:27:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 06 Dec 2024 05:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733480872;
	 x=1733567272; bh=6lo4x03kqPtlSZAbT88AtH6OR/rU64pzA4QOdeYe26A=; b=
	Pi9CsvK4Ckz34VDpL2OI832Eg72/Ux6xZoXnLP1IXGqksBOmB1oKPSW2yZVo5Ice
	NpoRb6FJe8W18oFS0Af22wCFwLXTT1chxBO7cGAJ72e0bbGXOuxV72X5/7Fhopko
	sOg6CcqZ/sMVvvUT7ryePPN7LnRLJF6toF43tYUOqFjX/qvNOVA92jl9tQCNteA8
	cVZ8QmPeRzhEhj8sIcQJjnJ3usvpjAjntIOEPjfdDAxyhY11e5sIsQufwmktSmr5
	GdK+hDwjQMywCHVa7clx+WXPiMUHh7vfTCKlbIDaVolAPTvUMCvQnqRL1UpxFkUD
	aZC5RvZhIHEoeWLIw1jTQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733480872; x=
	1733567272; bh=6lo4x03kqPtlSZAbT88AtH6OR/rU64pzA4QOdeYe26A=; b=E
	grdIXJ4ZzmAmWtwRWjIj3jT0T72u/FdY632GOfrebrSGU80f/QKynHctPVfRVqG+
	vkV11/VWkm76dVmoTCHXrBRowCSfI9SPaSRXv+rVYxLxnGH/mUONVd4ctT4gPixb
	/K+vVNo1tcPpkhcNneYgfn8OUXYZn23QPRom004EstI1TzHI17bV77evLSkNtXZS
	0cCX5p67UEaVWcRvi1rbOX9Qy7fDmoPAYiXyHczXvn4xOaaAeEOOftpEOYRZZ0aw
	9eDBXEDdO9bvELUmvoaHKWuK2aWiZVBrRijjBcauhfrFnUUtvl6xWZURf3xIIdmr
	UIp08trX/da00XMwklVPw==
X-ME-Sender: <xms:qNFSZ8x7Byso55KezkuduZkuKOxTMetSlvlTy4zF5LXD-kRlmuMpKg>
    <xme:qNFSZwQab1u9DCqsoIQKMYYlrSdEGBsyE-XZn6w0e3zzajc8TGphXcIBiZXHuJ2LE
    NsMdV-W0shlk8zTtQ>
X-ME-Received: <xmr:qNFSZ-UDviqwSEa9PbWKBRLpM-Sje4ebzGzNSnKAqxpaRB8RTPyc1AHP4PDINmg5secodQyZCGrDhQ4VINTOpwFf_brz_tjX5vl6kA7uYrx0vA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffufggtg
    fgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvd
    ekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghr
    ufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepshhh
    vghjihgrlhhuohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:qNFSZ6jSZlxqjatjoxu5HO1RAkXdoBfhaiXnGNgNHPhEfHkFBocrMg>
    <xmx:qNFSZ-BlLthL8rLARdHcgssvMvAmNXrH7yqfDLfd0nRt2IcVNCOV6g>
    <xmx:qNFSZ7I8r2ZCxpVATuwpmfAf1yxyUo9i6fozgtuwDeIkd0Ecqjj1Ew>
    <xmx:qNFSZ1BV2uv8GFwhY9QsT5X3n7U3WiV82MOnil_mmO5l_X8JhHTxpg>
    <xmx:qNFSZx8-o1sQWhoRF9bwPMen1qVJSAOlfmcA6WWUn_5N2kB2RG8X6PRw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 05:27:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f4d64569 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Dec 2024 10:26:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Dec 2024 11:27:31 +0100
Subject: [PATCH v4 16/16] t/helper: don't depend on implicit wraparound
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-pks-sign-compare-v4-16-0344c6dfb219@pks.im>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
In-Reply-To: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In our test helpers we have two cases where we assign -1 to an `unsigned
long`. The intent is to essentially mean "unbounded output", which is
achieved via implicit wraparound of the value.

This pattern causes warnings with -Wsign-compare though. Adapt it and
instead use `ULONG_MAX` explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-csprng.c    | 5 +----
 t/helper/test-genrandom.c | 4 +---
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
index ea9b9b656307d32bdc1f2e15a91793b1dda9c463..a4a0aca61773b0b30de618955e5a5b61bba2d0cc 100644
--- a/t/helper/test-csprng.c
+++ b/t/helper/test-csprng.c
@@ -1,9 +1,6 @@
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "git-compat-util.h"
 
-
 int cmd__csprng(int argc, const char **argv)
 {
 	unsigned long count;
@@ -14,7 +11,7 @@ int cmd__csprng(int argc, const char **argv)
 		return 2;
 	}
 
-	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
+	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : ULONG_MAX;
 
 	while (count) {
 		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
diff --git a/t/helper/test-genrandom.c b/t/helper/test-genrandom.c
index 5b51e6648d8e698b09f400efcf67a0708c226e9d..51b67f2f87469471a40288e369d9c784eb2ccba0 100644
--- a/t/helper/test-genrandom.c
+++ b/t/helper/test-genrandom.c
@@ -4,8 +4,6 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "test-tool.h"
 #include "git-compat-util.h"
 
@@ -24,7 +22,7 @@ int cmd__genrandom(int argc, const char **argv)
 		next = next * 11 + *c;
 	} while (*c++);
 
-	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : -1L;
+	count = (argc == 3) ? strtoul(argv[2], NULL, 0) : ULONG_MAX;
 
 	while (count--) {
 		next = next * 1103515245 + 12345;

-- 
2.47.0.366.g5daf58cba8.dirty

