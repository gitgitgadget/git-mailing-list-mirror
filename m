Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7864E1FEFC4
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787471; cv=none; b=ALOMC/wjuCRwcXeGHYnXlemmh3u8IYkd1mvITlo7bk9hWEGHr7QUeh2+FHKU0wpdZt5AWsdIhPAGvK19Hkg7jBeomzGwIW4L33BpfR7C6ZC6RTtsWpTlIlhwJF0JYDVH6ZYh/uSMFDnnn0KQE/IDmmu40AwT+kESQOT5uaJqq1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787471; c=relaxed/simple;
	bh=9W+Pz6dnSsy23sDEAOr4cW8Osu48nJcCMbjFtpG8nFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcmUd7eK6kUZymBZHoueNauSPiReKGQZ/l0T719KjzpJbbLGC5+KFShF3BNgqCbsJ/7lsfDZNSs2OyhR8k/ElJRWCxRoWgnI/KG8h+bVT7R5J9N2sBQGZS8Q+xN5PTDvi//ehHp7x2VZF0jTaKBD3QyCMGe9v4nK5soSERzsfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rpVpwMvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iWOReNov; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rpVpwMvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iWOReNov"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E898114018C;
	Tue,  5 Nov 2024 01:17:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 05 Nov 2024 01:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787469; x=1730873869; bh=5r31irX9YM
	rLTNDAIG8DiiB98K9BFZ66pjq//sCZSOk=; b=rpVpwMvvmJzMfAfgoaYYZo1UPb
	4GV/EPu8JnkT3rztmmhbBCJYoutULO8bDXx+pwlMcjnyt2E2DF1L5QKMwzSBZC4Q
	yd5/mg7p8osVSL/J+bRYsAPmHDA+6pOfZbnR9MjzcGBPLpgLXyD+zTdG0w046U/R
	X3qzDeqAjWx6yXgrP6EVb8IjQZJ8vu0DT/VdeiJ52cTO0tdq1GnqnVUF4VLc/Pru
	kxbfiYciSNhdSGXtcXd5sprPBbOfzwQ4wJmdMiwE+2FfZs84fbnqsW55fLBPDadr
	cTwVEgyZuEa+5yha8c8FtONvY9sGzwtJJxjLRbaLzJsD2EebWAibE6FJNgqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787469; x=1730873869; bh=5r31irX9YMrLTNDAIG8DiiB98K9BFZ66pjq
	//sCZSOk=; b=iWOReNovvqi+ntP3XNV/Flupmz9nJK9k4FAyKr/Ai2hiY42nIKV
	XPnHAGJ7/6YGqa/VGpWZPgUNoZz6klJq6qS9jCeahHYFUub1H5+kNDwBlCk47e3r
	4z7z5+S5AU+19fVuPe/PUbH0UxwzVAPT12S72C1tL+Ji8ZNWF7YxcZ95dVlPtttC
	1nkNK8Cfu5s+zb8NrTcPsXFu8erB2+YkzA2tBlIB+SZl6h6ypOggerT7UAx3oeCJ
	eEyU/IqK/RkLb4sZpc7TFvF1IBSNeTelOPEl6TeF051NqllxQSQEXUTezVevS4rk
	OFljGwrG9WbmU5lR/gVrRPyS3ZklHbxVGfA==
X-ME-Sender: <xms:jbgpZ7bKNGjWr_OfyxfCm40WmZI2iaQ5XWYeIRaOYh6tCA4_ykfCBA>
    <xme:jbgpZ6bvV8h4snbzvV6OTUWipcvLMM1GXjVY-YMehJJvvThD15HFM7U-m0UESLtrl
    A3R8yMpB0j82tu5vA>
X-ME-Received: <xmr:jbgpZ9-FKCedHdIV1vMeGj1Mcb9A1Vncc81uZKAY6j_SNt4CiZQlBSn_M77-OBRcmvyyJCLwN8L5_sIebvxSc5QcN1_JOTNaVcGuE_JrIczhow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:jbgpZxrG_iQURnIW3Ovzq7tnOUxtkPXEfPCEjF3YihbzwT60tcUVPw>
    <xmx:jbgpZ2p5sQ4TKXzfcNa7lnIhKwNqnS9h4nt9bLJZAvvJBdBNT6wv5w>
    <xmx:jbgpZ3SKRA_AB7THI1qtpsbF7jdYreQ-N_EMWF7zCWOH93eLSLheOg>
    <xmx:jbgpZ-q8IMLzy-pxZaTdSBST_GwCMfLe6CUDzu6yrcuTUMz5fI0sHQ>
    <xmx:jbgpZzB8ABWMlXDqVBFNI6RYd9SRc5XgJhGjUEKh6XTmwohzg1WhcUrg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d5c94d2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:26 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 18/22] t/helper: stop re-initialization of `the_repository`
Message-ID: <70f16486d77ec69874ee4f36cc1d89631deae3fd.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

While "common-main.c" already initializes `the_repository` for us, we do
so a second time in the "read-cache" test helper. This causes a memory
leak because the old repository's contents isn't released.

Stop calling `initialize_repository()` to plug this leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-cache.c  | 2 --
 t/t7519-status-fsmonitor.sh | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index d285c656bd3..e277dde8e71 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -11,8 +11,6 @@ int cmd__read_cache(int argc, const char **argv)
 	int i, cnt = 1;
 	const char *name = NULL;
 
-	initialize_repository(the_repository);
-
 	if (argc > 1 && skip_prefix(argv[1], "--print-and-refresh=", &name)) {
 		argc--;
 		argv++;
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 7ee69ecdd4a..0f88a58a819 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -2,6 +2,7 @@
 
 test_description='git status with file system watcher'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Note, after "git reset --hard HEAD" no extensions exist other than 'TREE'
-- 
2.47.0.229.g8f8d6eee53.dirty

