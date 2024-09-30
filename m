Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC921865F1
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687616; cv=none; b=gJ5Io2ZWjjCXNsoq/Jy9YFXbvJH4Zxq3ewMbhlD+Ze4+AQiD6DXdaQmJ1WcG7mJaBZDhanJDdDlt2tZSAQC0sWR5ZnZo3a2W/fM7cCmMSQklv7/VNfQRjTmHbwsVbmnXrbzAZU819grU4cI7/k48otYXgtFlfHbvc+60JvlxqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687616; c=relaxed/simple;
	bh=pUtyUXSwBO/O9xKZFTcC9U9FtfsVV96uRzsdmVBSNaE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uN7N0yt0oUJu5Ytl2JMetYWBYo2QqnxDk+u0SsSdj4dVRbDbuW5QQ95HSvP+SBbP6fXIY5xkJ8mzJccRDAMcsbqdjndmMcUQgWvze320xDnHxfhnM55Knr7gkiMYX8nSkRjDPxzdhCWVhi+hUn++gvb6D/R9MEFzTtgMk6y0mBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bvatDJp3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dj0s7swj; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bvatDJp3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dj0s7swj"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 13EAF1140259
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687614; x=1727774014; bh=eAcIhZ9wuj
	UMulSpKeP2qqrvOCmSHsmPVmyMgipp9Dw=; b=bvatDJp3haeYOGoXo299ri/fIl
	cEh3CMm3XIlU+TmeHMhDGInLu+SeKvsU9gxRVtc+Z5XhDEL1z78gvHnRh+iXrSwH
	0DBBBOI7HvwXJreWTV00uPvet5zQfsg0pmaDK/biFY9m85+UimqVPrsi3Ry/rIcO
	Z0h+T04vbce5QXxqEyFziD7xWrZ6uI4QyQlwhoeKs6nPsysCt1Aeyqz7VY8/nolg
	iQtUwYQNcojQiOABiz6gSuDMgiu16fEOfvKEJPk2sjqxKIffdcpKvg5KLVpRLxDJ
	5z2BrgYhr67s8TV+KGFZ+bkSUyS0yxa9Xy5ocZFv70kXTEI/A8XMMBxNK7xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687614; x=1727774014; bh=eAcIhZ9wujUMulSpKeP2qqrvOCmS
	HsmPVmyMgipp9Dw=; b=dj0s7swjbdL/cy6EC6CdVySROOGtBfJ1SkdP4tT+iuKa
	zrs5XvmaIQULdrUME1niX62p7YizlaNzYN3dFkoMgUNEDOKB3qab+R1bWjqarEFQ
	5TJF/DFmc3Dme9COL1zos+XqhJcDdcC+WhfzOZxG80Evrhv4zjb2R/wluOSt1pNs
	Dd9a3BVtDzDHMyGUcVCP1iSL0FVqfMoQ+t43vIYeciqGy5JOZbJAv9qzl6nlVd2k
	CMZ2xB9MRp1OkrZIXjCgt4UQrgproatf+HrfQaL1rAXTqigO60Fm9SErJyJWN/gQ
	axIqISZSLXZT2PU2vyP50UBgaZU37bX1EQr28CFozA==
X-ME-Sender: <xms:vWv6Zt5hrRm86Nat_SbDT0YMF6pvSpKvCt-7vYauYVIAUFJJKyLWDg>
    <xme:vWv6Zq47XrkzS9yF9ikmWYmC-TQ-I0JmIXRchncUGkB4ck8Jq60Jd5c-HvZJKUchy
    fJkGHNbwVbkWVTmBA>
X-ME-Received: <xmr:vWv6ZkcVhnZ_ZuL0G6G48RQSmXzzQUpU86Pi2Ba0HbQQlZeYN9PEUFCBC0oEg13R4cRFEqtg0wtH2au-1eyq8u6p9201HwPDU6wpChoMLNePfuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vWv6ZmJFjGI-tZqa_evhXViDpbDodThgUqHNiSjnB2Z48s28q87juA>
    <xmx:vWv6ZhJbqypu4u_ztNB_9mAMXiDB2Go_a6u91HdyXvPBeSUTskhFhA>
    <xmx:vWv6ZvyORjCMpEZyk8A4R8OIgLHU0Wu06gzMQ2_qwZNEnLmTKonx8Q>
    <xmx:vWv6ZtLabr15QR9C0neUmISFuxvHM6K6MDu-JQZZ6wuBEfgJZ8XueQ>
    <xmx:vmv6ZvjardNRhLZsYr0o7pJ1QX5kHUQkr3iQyfp0bOst0-rX6HfQQvx9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da82c674 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:47 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/23] builtin/stash: fix leaking `pathspec_from_file`
Message-ID: <38b58f5b7470d3fb07396d62cecda3799d0b944c.1727687410.git.ps@pks.im>
References: <cover.1727687410.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727687410.git.ps@pks.im>

The `OPT_PATHSPEC_FROM_FILE()` option maps to `OPT_FILENAME()`, which we
know will always allocate memory when passed. We never free the memory
though, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/stash.c                | 4 +++-
 t/t3909-stash-pathspec-file.sh | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index f1acc918d0..1399a1bbe2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1759,7 +1759,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	int quiet = 0;
 	int pathspec_file_nul = 0;
 	const char *stash_msg = NULL;
-	const char *pathspec_from_file = NULL;
+	char *pathspec_from_file = NULL;
 	struct pathspec ps;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
@@ -1821,7 +1821,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
 			    include_untracked, only_staged);
+
 	clear_pathspec(&ps);
+	free(pathspec_from_file);
 	return ret;
 }
 
diff --git a/t/t3909-stash-pathspec-file.sh b/t/t3909-stash-pathspec-file.sh
index 73f2dbdeb0..83269d0eb4 100755
--- a/t/t3909-stash-pathspec-file.sh
+++ b/t/t3909-stash-pathspec-file.sh
@@ -2,6 +2,7 @@
 
 test_description='stash --pathspec-from-file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_tick
-- 
2.46.2.852.g229c0bf0e5.dirty

