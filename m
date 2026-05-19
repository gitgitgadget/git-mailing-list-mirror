Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA03B481235
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184379; cv=none; b=R9p9/rHhBG31Ld8VFM/sW6qbqt3s9n4Ci1Mvxhqhnvt1aSXXvoTIKAa1J6dbtz/dJz4CJamU/QNMIcIrM71QIBCaZdrUjkNp9qzEIy+kq4kRPAzzg/5OutZLdzPGYxisrvBNtCTu0m5ZMXEV3giDIDKUHAZeFQkeZOiPX+/P9KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184379; c=relaxed/simple;
	bh=V6melUA8Xgu9vv7zBDnFDZsuX8NEzYdzygn0Gbcc38M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dF6Uu8QBu9ZgjdQC7RPFlMN3YcFVgpAcocqWdkbgHYM/OcgTfcUPCl68N4uT3cAP4CJcgGiqw5bR3HCcmzW8Ic/TFqo/A/nFKaMHjBTrIP2t8k6fKicSATaDpt0AlnPBtNUVaMtSYbNaG9HkCBY5prOxDGdcpYi8eYwKTMs2/3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iDEzpkQ4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S9qeHY2D; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iDEzpkQ4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S9qeHY2D"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E50F1D000C0;
	Tue, 19 May 2026 05:52:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 19 May 2026 05:52:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184376;
	 x=1779270776; bh=CzZF3rBuls+PdgzEpm3XYJ9PP7rCpkTafYAJQ5SlKQA=; b=
	iDEzpkQ4ojN+j4yxj3mQK7i/cHgIHpI3HCuW6jCBAOqHcu3Qz4Vi3EQ3PJS7sWxH
	3d0TGlQ2HoSj9k7W7u+RODUxRifwwZi/5W2hrSyIQCYjTinTY5eZY7iYSRt/XEPd
	4MrLv6/7kDwD5chlwpJm595xP7UE2AYMtDpnzNjS/+/CqvHq2kLJ549McGVRP6fE
	9AnpJU2rU6voYJyfzGuAE+it8FYACwOSSEQCN54A62/568xo9Wrr+82hlSuf47GQ
	DdfABTez/P6nFJezmjWRfIg8LUi1gpwlvghnmByRf1Wi45JotWW9AdSaq++Xwfn+
	riQwQRX/Ynlx8GxTso0o6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184376; x=
	1779270776; bh=CzZF3rBuls+PdgzEpm3XYJ9PP7rCpkTafYAJQ5SlKQA=; b=S
	9qeHY2D0fFmaXrKlpNZxbiV5IuMxLCxdqHjkFTTIwqX11L6w72bn/RcYikVrk1e5
	Z8fAFFcDj2H3oGvbRmXDkj/8VNi3YhxD/amXMW4jiTxvAs5KrtZhUwIMxjTLSYwk
	B1LONWUNeyPjk/uCW4y2Tm5ToGFeISmKkmW05S3dc1HvHkKVOT+nF3Jh8NdugGnd
	LUtRdENzF/pxc+ie5mejeetHGJX0YLLQRim40NWYaCNCZswVRfA/YBWvdbDbuFx6
	mJoY86MJjqO++3kmiQgBvVm+nfyPT1kmIGWsijto3RQ0ARPB/kbtZMiVdro7kFPy
	dJco5Dda/Q6P1X8AlFPSA==
X-ME-Sender: <xms:-DIMauwLCFVrOqnCpdG_V-8fLO-ocd-f4YCAKz11-Z4Y2tKYrLQDxg>
    <xme:-DIMahIC4C_nQy1ms0qGwyrRWdZKGfUjptU66OKYwZlhz_XilX8eeyE8MEQub4bg9
    atYAHsPqObfsHRJx-Ef83WnpJ3RCH3JGe6qHCl59UgTK599CdQ7EA>
X-ME-Received: <xmr:-DIMaoqg58sSXUkJ27nkF_qhWq4asds55H_2zloDB_GvE1ygdsakFGdO8EZ_i_uZtmo-oc_jCo5BtuT32Q7u0z0i30yDfGR8-E9gTiUHO34>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrthesmh
    grlhhonhdruggvvhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-DIMagKBtBwRkENRAOooM6Xs5qXfvJPYk_HfYWwxxj-wqAwW6WSmRA>
    <xmx:-DIMatR2sENDIVsQunsNThI_Qc6JU6MvXLgcYKkN6DGQKc7RWM_rgQ>
    <xmx:-DIMavtpUcTQ6TNYOo6XuoHR5MUCvarTX1oziQNvF3BwOY44VcwOdQ>
    <xmx:-DIMaubpfm_aVoEXoOefgHcLI8-MX6iukIGdXXXJxsBlyxPopWqwRQ>
    <xmx:-DIMagZTwi2LLjGCvjZyHO-MOg51X1KC2g2-HOF9FO-C8r4BAAhDOwI4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81b1521f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:21 +0200
Subject: [PATCH v3 17/18] setup: stop using `the_repository` in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-17-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

Stop using `the_repository` in `create_reference_database()` and instead
accept the repository as a parameter. The injection of `the_repository`
is thus bumped one level higher, where callers now pass it in
explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  2 +-
 setup.c         | 13 +++++++------
 setup.h         |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 24fe0eead5..53a41629e6 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1444,7 +1444,7 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(NULL, 1);
+	create_reference_database(the_repository, NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index e09483ba34..9c49319568 100644
--- a/setup.c
+++ b/setup.c
@@ -2468,13 +2468,14 @@ static int is_reinit(struct repository *repo)
 	return ret;
 }
 
-void create_reference_database(const char *initial_branch, int quiet)
+void create_reference_database(struct repository *repo,
+			       const char *initial_branch, int quiet)
 {
 	struct strbuf err = STRBUF_INIT;
 	char *to_free = NULL;
-	int reinit = is_reinit(the_repository);
+	int reinit = is_reinit(repo);
 
-	if (ref_store_create_on_disk(get_main_ref_store(the_repository), 0, &err))
+	if (ref_store_create_on_disk(get_main_ref_store(repo), 0, &err))
 		die("failed to set up refs db: %s", err.buf);
 
 	/*
@@ -2486,14 +2487,14 @@ void create_reference_database(const char *initial_branch, int quiet)
 
 		if (!initial_branch)
 			initial_branch = to_free =
-				repo_default_branch_name(the_repository, quiet);
+				repo_default_branch_name(repo, quiet);
 
 		ref = xstrfmt("refs/heads/%s", initial_branch);
 		if (check_refname_format(ref, 0) < 0)
 			die(_("invalid initial branch name: '%s'"),
 			    initial_branch);
 
-		if (refs_update_symref(get_main_ref_store(the_repository), "HEAD", ref, NULL) < 0)
+		if (refs_update_symref(get_main_ref_store(repo), "HEAD", ref, NULL) < 0)
 			exit(1);
 		free(ref);
 	}
@@ -2830,7 +2831,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
 				      &repo_fmt, init_shared_repository);
 
 	if (!(flags & INIT_DB_SKIP_REFDB))
-		create_reference_database(initial_branch, flags & INIT_DB_QUIET);
+		create_reference_database(the_repository, initial_branch, flags & INIT_DB_QUIET);
 	create_object_directory(the_repository);
 
 	if (repo_settings_get_shared_repository(the_repository)) {
diff --git a/setup.h b/setup.h
index c33b675ccf..21737e9bd6 100644
--- a/setup.h
+++ b/setup.h
@@ -236,7 +236,7 @@ void initialize_repository_version(struct repository *repo,
 				   int hash_algo,
 				   enum ref_storage_format ref_storage_format,
 				   int reinit);
-void create_reference_database(const char *initial_branch, int quiet);
+void create_reference_database(struct repository *repo, const char *initial_branch, int quiet);
 
 /*
  * NOTE NOTE NOTE!!

-- 
2.54.0.771.g3ed373ac14.dirty

