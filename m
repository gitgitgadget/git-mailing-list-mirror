Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773F418787A
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687623; cv=none; b=Z1qzpcmhic/omzHH4v1hRMFQV7hI7O75GpFJuhNXOfDhYChzT9dkhtPw1Cso0h6yu38/ntjORjIbYYppUhlX6QunGx0uXOlk0gusa5mGmUeJ0LVLKhdC7VHfOk6yB293aHcfqcoaovtezlMYQfDqGGETvbRQdl9KqApNVnp8iSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687623; c=relaxed/simple;
	bh=IqaXnWst05klv64ylyjVaGZuxy1dAD373uK9UJLPWbY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NlIeppFszhJm7jPMcE8vLsAO51d4qDkfQ6pv8VmmvrBeugimMWiLrOe30bLdxmpQsQEfNxYymoFIy2R7WSwqio9H46xwV8ypsqLhwDuFJGVph15wizURt5aTI8mLWvF2HpyXITb2mAnJpN+k3cXXS23D6a6NlTvyfME+JX7RXps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BLYuukrD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eyA3B2QU; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BLYuukrD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eyA3B2QU"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C3AD8114026E
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 30 Sep 2024 05:13:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727687620; x=1727774020; bh=T7fZ6k1wSx
	J/Q+xdB+D/cxc88FRkZrFYLqAaP7U6l34=; b=BLYuukrD8TUj8sXwKHcxGOrGrU
	TEHIFUQ2+o928Y6+9mMytswMI/1ZRNsYd8izlqHCPnYifL7omY8/AW/D48aNYeKg
	qTnimNjtz6Ycqt2m2hmxrF/vsn87tjAudjYlWmclK04Sr67YBHPJtWVM1ewUXjBv
	F5jPeLYbuApKYciTuWvyK5zb7QUpUew16/Xonurvud+Os+Cqyl20fFnuBH+o2q1Q
	2ba23aaR5gfPl/EuickXcmOlHuHD4eeh9hFo6Omz5Dm3RBvn4magZEpbbWtTncoF
	nJhYQS49ZUvp/4er0fylkiqdMeyMRvncc5rF1BKqGRrpqmmYAxsnmLDCFYWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727687620; x=1727774020; bh=T7fZ6k1wSxJ/Q+xdB+D/cxc88FRk
	ZrFYLqAaP7U6l34=; b=eyA3B2QUjDO+cubNvLv0eNIKiFqnQgPSTUPxMjhp82RU
	G5tcUs68/Z4ivL3TakW1J5VKxC8sZDa+MJyz0+fCgIW72JGELW06R1Vpew5Z+SWT
	k/TxhJpZ+z7eyEGLgx2RADlX+U20/jXWTuW0GLiIBdj+NfKKyovlWyOvCkqPXxVj
	6MoTRy2SRWxKykyLvATeoDyKM8z3Xap+gwXEKDCjwkJqO0uJ92E2fMoTScTRPqJP
	Xj0mKtAYwhZIb6H9nm1+iJ2p/8f9yzMUpkNE7UJbrJWbgUTj8INSbql+4KuLsfU2
	/GS7E0cQmLK37ACt0yPJiFNgCRtmB6WCLiPNXSaCwA==
X-ME-Sender: <xms:xGv6ZuTktawCmKyLA0Z8Yc2HLM_rqH4atZI6wm2A-TmeB_2UtDc-6w>
    <xme:xGv6ZjxpPfdzuWnDSgpUTALSujkcc0NeTcX9qyLwt4nxbgPuiJrP18EdMPU1N_18d
    ZaLewRaR6Hb4pX_Ww>
X-ME-Received: <xmr:xGv6Zr0OYnSdTsO6GDefulrNwDK9xLac2rtnKH8bmLdf0udh9dbHXoq1pb0Z26GgINONG9xaDXGVnEV2uhua5twMDv-sGmsXuzicSNqAafXCDE4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfffgkeetffeule
    eivdeltefgfffhleevkedttefhledtleffiedvgfduheegfeefnecuffhomhgrihhnpehh
    thhtphdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xGv6ZqCAHWg4Tgl_21VFlWyhc_BdcFl3VNcCqvMbJRoy2LN30AxfSw>
    <xmx:xGv6ZnhI42X4_RljYJdZqTEB2VC7N-Rt-AEeladuc7ChpN3lbLKK-A>
    <xmx:xGv6ZmpHaPSSX-tte-xCxsjNSXpd4hPC7bULA3PwYE6Dtm4Qnj6sJw>
    <xmx:xGv6Zqg15fRnbBWaOy82qGW_RM9epgFq7JLO4DIRSbHB-GN1B7_FNw>
    <xmx:xGv6Zvb_J9EB1ZvgXYnSdbBcFtIJDysSzys1oNGRimvvj7cgFo8EZN_R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Sep 2024 05:13:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 586af1c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Sep 2024 09:12:54 +0000 (UTC)
Date: Mon, 30 Sep 2024 11:13:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/23] builtin/clone: fix leaking repo state when cloning
 with bundle URIs
Message-ID: <2fa76a00fc0469d0c64c66e81b96d622844b8f0d.1727687410.git.ps@pks.im>
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

When cloning with bundle URIs we re-initialize `the_repository` after
having fetched the bundle. This causes a bunch of memory leaks though
because we do not release its previous state.

These leaks can be plugged by calling `repo_clear()` before we call
`repo_init()`. But this causes another issue because the remote that we
used is tied to the lifetime of the repository's remote state, which
would also get released. We thus have to make sure that it does not get
free'd under our feet.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c                        | 27 ++++++++++++++++++++++++++
 t/t5730-protocol-v2-bundle-uri-file.sh |  1 +
 t/t5731-protocol-v2-bundle-uri-git.sh  |  1 +
 t/t5732-protocol-v2-bundle-uri-http.sh |  1 +
 4 files changed, 30 insertions(+)

diff --git a/builtin/clone.c b/builtin/clone.c
index e77339c847..59fcb317a6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1403,8 +1403,17 @@ int cmd_clone(int argc,
 	 * data from the --bundle-uri option.
 	 */
 	if (bundle_uri) {
+		struct remote_state *state;
 		int has_heuristic = 0;
 
+		/*
+		 * We need to save the remote state as our remote's lifetime is
+		 * tied to it.
+		 */
+		state = the_repository->remote_state;
+		the_repository->remote_state = NULL;
+		repo_clear(the_repository);
+
 		/* At this point, we need the_repository to match the cloned repo. */
 		if (repo_init(the_repository, git_dir, work_tree))
 			warning(_("failed to initialize the repo, skipping bundle URI"));
@@ -1413,6 +1422,10 @@ int cmd_clone(int argc,
 				bundle_uri);
 		else if (has_heuristic)
 			git_config_set_gently("fetch.bundleuri", bundle_uri);
+
+		remote_state_clear(the_repository->remote_state);
+		free(the_repository->remote_state);
+		the_repository->remote_state = state;
 	} else {
 		/*
 		* Populate transport->got_remote_bundle_uri and
@@ -1422,12 +1435,26 @@ int cmd_clone(int argc,
 
 		if (transport->bundles &&
 		    hashmap_get_size(&transport->bundles->bundles)) {
+			struct remote_state *state;
+
+			/*
+			 * We need to save the remote state as our remote's
+			 * lifetime is tied to it.
+			 */
+			state = the_repository->remote_state;
+			the_repository->remote_state = NULL;
+			repo_clear(the_repository);
+
 			/* At this point, we need the_repository to match the cloned repo. */
 			if (repo_init(the_repository, git_dir, work_tree))
 				warning(_("failed to initialize the repo, skipping bundle URI"));
 			else if (fetch_bundle_list(the_repository,
 						   transport->bundles))
 				warning(_("failed to fetch advertised bundles"));
+
+			remote_state_clear(the_repository->remote_state);
+			free(the_repository->remote_state);
+			the_repository->remote_state = state;
 		} else {
 			clear_bundle_list(transport->bundles);
 			FREE_AND_NULL(transport->bundles);
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
index 37bdb725bc..38396df95b 100755
--- a/t/t5730-protocol-v2-bundle-uri-file.sh
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -7,6 +7,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'file://' transport
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
index 8add1b37ab..c199e955fe 100755
--- a/t/t5731-protocol-v2-bundle-uri-git.sh
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -7,6 +7,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'git://' transport
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
index 129daa0226..a9403e94c6 100755
--- a/t/t5732-protocol-v2-bundle-uri-http.sh
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -7,6 +7,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Test protocol v2 with 'http://' transport
-- 
2.46.2.852.g229c0bf0e5.dirty

