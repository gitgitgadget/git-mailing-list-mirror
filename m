Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB71340BE3
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530276; cv=none; b=J8PNqqKEdEztj6RmF/ZVFMRCh7Zs2fFpzvf+6Z1bH1KppenbOyf1tbePN1odP8OVR2ppTD74opsJYNmSOt0vEPrw8maREAdxAacfpVv57JNMIpoUaAT2Uuo5PkOZ+pdt5u4w9GW3J75So2v6ZIJRKRxest5T2NqQEdjmL87utsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530276; c=relaxed/simple;
	bh=td4J694ju0kTvXrZn0I3A9RvLF8kk3emzosqjtZBLTg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSJzYUkKLMLMQv2SJ8RlMg7/CL6HO1RAhMb0j7cKw1DX2Y8WRRHhPU026avw4fwbocaz5Cq6Pqin1gKLcZoD1iOPyq317wv+pk+UCs106zPkTG1HSKk+aPyeF+WlF4lC4jc/RbtT0pMWUYiBkDdtKLZR9VhYda00cHYyHe8w8o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JffIIqbW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=abxSzj5g; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JffIIqbW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abxSzj5g"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 02CFF138FD3F
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 02:24:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530273; x=1723616673; bh=DLBLTkkIDo
	UvYnZkEjeswestdvRZvzArAMMR5CVZd2c=; b=JffIIqbWpmh/W3IXQz6NaTkmWe
	E3e9SZKAACeNDV0AcB/GCdEn9VxAC1LW4yIazjIjGm6VXf5P5C1n0F60pq6AMaRy
	vp+NYK8L4zp2cTVQiRUja4jtCq8GDhiGoCfasQWNQoXO2FwI1il6gZPt/b+RYMXU
	RQidF7TPSb4vPJvhFQAi9ToiQIOB9NpPMIfYvqJ1EfYlWOKQLdQ/c3d628Ed58p0
	yc+bzKMDw9W6E+vy3Zsb5OGv7A+Zm0Sy/GZEy+vhGaoDxO/LzJD52k1YkLa2HEu8
	/eTI5nYfKTdNu99wFBpYpRSRApzaoUf/KVbVW4DB6FaBX84fP0W4da/Bd94g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530273; x=1723616673; bh=DLBLTkkIDoUvYnZkEjeswestdvRZ
	vzArAMMR5CVZd2c=; b=abxSzj5g6bTHBA+Ke1106X7+9itgG2rcvR/xsHa9SG9o
	uw1ZPioTHP/CxJ9zOaaAq5KiHSwpF0Fisp509zaI2GIbL0sB7SsDVdknRNhTs7Kv
	FN8/mpI57rBHPXugjysARmaPjAhnPg056FTD3j+nGdR86uO9r88LVSjLaOXiKzGa
	EvgIujwieVOOs7mBxr07McD3b2VR22CnRI5/VzmpDn7OTEQdxFxkYTM5+/gTb7ws
	osdcmy9R87OLXg9K7Bi3b85MLAZF+X0wYnxRY9O3ZF2QXdyPRaARUz2qz7nnuaPd
	+OdwGM9qEzEyPGdtst3daDJK1h1gu0GJXHqMcGpTEg==
X-ME-Sender: <xms:Ify6ZpcaXIacP1PtroHw-OdemLPs3wrG3eTkK25D-xo3U2Zo5C8qIQ>
    <xme:Ify6ZnMYRbKewrt7BokIK_5rexwWrbcct7PcVBdc8ZVHJEZYaH6y0QqMo3p5aKmi-
    yG1rR5CwxjyYyOE8g>
X-ME-Received: <xmr:Ify6ZigTxzab05hsHhwMVsKqFJun4Kx5-3XIupEGqOGEIK_TH30cHnSHMc8NKxNnHCYRXH9pJp1KLtRa4FM7rJ5JJS3J33F7eUdZy0iXHlC2GQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Ify6Zi-EvMt4EkqXadOGuYKKR01VsCzuskX-ToOUyDM0T4KSgz94hw>
    <xmx:Ify6ZltGnveAGcBn_c2XiA3AmYUd8lQre0a2YevuObhmW4-CNjELtg>
    <xmx:Ify6ZhFTZOhMypLMlAMW7Sj-DblNlE6yj58dPOGtdTiMOpNjMwYY1A>
    <xmx:Ify6ZsM1otlldjvf-R1UBbOY_QE131l--zZLX51QSYyRqSQ2H8MEKQ>
    <xmx:Ify6ZmVGiMBdKbkN_dCOUAB_G65iHX4tScgv-AOjOOlcyvOIxHiCxWCf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5c84d47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:17 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/10] reftable/dump: drop unused `compact_stack()`
Message-ID: <0aa718606767dc4890fee5af16bb9a0f01a688c1.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

The `compact_stack()` function is exposed via `reftable_dump_main()`,
which ultimately ends up being wired into "test-tool reftable". It is
never used by our tests though, and nowadays we have wired up support
for stack compaction into git-pack-refs(1).

Remove the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/dump.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index dd65d9e8bb..2953e0a83a 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -24,25 +24,6 @@ license that can be found in the LICENSE file or at
 #include <unistd.h>
 #include <string.h>
 
-static int compact_stack(const char *stackdir)
-{
-	struct reftable_stack *stack = NULL;
-	struct reftable_write_options opts = { 0 };
-
-	int err = reftable_new_stack(&stack, stackdir, &opts);
-	if (err < 0)
-		goto done;
-
-	err = reftable_stack_compact_all(stack, NULL);
-	if (err < 0)
-		goto done;
-done:
-	if (stack) {
-		reftable_stack_destroy(stack);
-	}
-	return err;
-}
-
 static void print_help(void)
 {
 	printf("usage: dump [-cst] arg\n\n"
@@ -62,7 +43,6 @@ int reftable_dump_main(int argc, char *const *argv)
 	int opt_dump_blocks = 0;
 	int opt_dump_table = 0;
 	int opt_dump_stack = 0;
-	int opt_compact = 0;
 	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
 	const char *arg = NULL, *argv0 = argv[0];
 
@@ -77,8 +57,6 @@ int reftable_dump_main(int argc, char *const *argv)
 			opt_hash_id = GIT_SHA256_FORMAT_ID;
 		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack = 1;
-		else if (!strcmp("-c", argv[1]))
-			opt_compact = 1;
 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
@@ -98,8 +76,6 @@ int reftable_dump_main(int argc, char *const *argv)
 		err = reftable_reader_print_file(arg);
 	} else if (opt_dump_stack) {
 		err = reftable_stack_print_directory(arg, opt_hash_id);
-	} else if (opt_compact) {
-		err = compact_stack(arg);
 	}
 
 	if (err < 0) {
-- 
2.46.0.46.g406f326d27.dirty

