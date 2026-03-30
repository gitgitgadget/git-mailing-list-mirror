Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB172248A3
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876711; cv=none; b=HEwwbQw9ulrNY2wUIJJFqEZzbM5qdLXfQwJehGna7fFLqvXFLOc4mNsETnJhtm/sk3WS0C3q0gLMugi8G3L1r6zhLtEhKwbp1rJkBvwUcIod6EUO7WyXEnnXW1gcs7nMWyXT9+ZrvViWm5z2QVSg/PwdqBU17mcpUuy4fms4wqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876711; c=relaxed/simple;
	bh=nmr8W2UsqcbQ83ilXTwGig43pjVMDXHcf1GTmM5N9wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=biSZjf2WUkfgYZcLbk+TyOir3q+jV3ThSOZ3XKP/avpsNDqHPi207C0yhTM90obgHdn+9ykELno1zk8qs42wQcmmwxUUkUNSD35V1QVerMoQ2D9t5CsIPU7h1Yo1NiO2C0ASwbxby1Z7n7A6TXWoGpjP/wz2hCcCAQrP93OsRfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jUDiojS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F777N7g6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jUDiojS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F777N7g6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 653477A0068
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 09:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876709;
	 x=1774963109; bh=9hVCgusmoBn3QmmPE9c115hJplcLxZuSUANRGTjZB54=; b=
	jUDiojS/IGnfhgCMSasdkrGxqvAuHRsJCcFdx11Xdv4JUjhj07iGH0O55DNSyTyp
	Wkk4iiWF85xrOXH3mxr5drzZyEyd+dR1Bipo+v4ODW1Sq7bl2lO1MndHBFPscrLb
	dc07a2p0jKzM9kf6NCb6nAoTIYInzEcvu6Q37aROJmQgEc7GExaty3+51RqHfd4N
	ouiTvLddWIaWSeWaZ31vBgYj6AuaArTDqieBIxgbyaaOj8lc0SENzGDDr5fKSUYk
	x/tqSGDK2js7JoF6DCqDCDbfsULwmAr2PStRcyRSIiJ/ScPgje+8KD39L3oOoDuQ
	3qB5bSXaj6lfEO6Iyxwjjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876709; x=
	1774963109; bh=9hVCgusmoBn3QmmPE9c115hJplcLxZuSUANRGTjZB54=; b=F
	777N7g6B2/mqTGizyNskgzy5D+YCNh3mh12nkb0qhXvdbHxI3SSMtTxf9vB988WY
	NjtEeog1x//wCrhXipLclDRsSJOU2DHalrhkZ4d8+XpPGxo/iOtW0DarHRF+gp4S
	WiWTuzTo38mBd7mD6OY0TSfO6ZbG5OWUl8myNllmhULQDi0yJOlAWcmXNUPcrIFr
	8wlJ0B4MVeIq6USzFmKB7QrjdyLW+oeAJyMpABvBp92WYFnLkqQ/HOsh/FL2KJos
	qXCfrpWf7kVUD/UHBrpgAoF/tJMpjYJ62xoKDpTe4ujH1uGpC8te9lcen0sScDFj
	jvRAxPI75kvF0oYDBo4Tw==
X-ME-Sender: <xms:JXjKaV-aUxSRhYLJqvEZ8oimN4AWRQnQN6-H-ImBrxV3aC8XfODEBA>
    <xme:JXjKaQopfhzI6PIQva7BRh8ExlSLEgYUwyTTDFnFhoh8fru7MJCAOnDY0ctsVSB3x
    yGfsofoM5OMXt0xxC8MM6keDERbLANQ_YK4b1zljDP_a3oTw8FE>
X-ME-Received: <xmr:JXjKaYrg8HetIborgigvCdjBtN12cNx5MNUyrTspDPX7uwgVLd7zzvMPz50GtcVyWARz7hvS0MAl-fc7u1Fj8BFefC4If5nWsAjc7W3gbsz9vQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:JXjKaekX-Y4JivWW_gPJFrqFmaRbnv85l4sHgxYfd2IAvF3l9zUs1Q>
    <xmx:JXjKaaF5e2XuhNjqVErVtpiZUBE-GWxV7Qz6dpLRHM1AHCNE7UnI6A>
    <xmx:JXjKaXpc8KQK4TJtV_ba8JSaNDB48TiAMQx46FGSXan_3FCBKwoKIw>
    <xmx:JXjKaW4F5Eidxw-6L2vZ1eRjkNKTadKeEeDckCRaiHFRg52MkqyUFA>
    <xmx:JXjKaZsz99bUINsB9hyEBxqM8N1ch_7jN2M6FO-56FxgRl3MReWub_xh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08257b6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:39 +0200
Subject: [PATCH 17/18] setup: stop using `the_repository` in
 `create_reference_database()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-17-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

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
index 663ef0b524..d864022214 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1442,7 +1442,7 @@ int cmd_clone(int argc,
 	hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 	initialize_repository_version(the_repository, hash_algo, the_repository->ref_storage_format, 1);
 	repo_set_hash_algo(the_repository, hash_algo);
-	create_reference_database(NULL, 1);
+	create_reference_database(the_repository, NULL, 1);
 
 	/*
 	 * Before fetching from the remote, download and install bundle
diff --git a/setup.c b/setup.c
index 1570749b4a..efac2dd7b5 100644
--- a/setup.c
+++ b/setup.c
@@ -2465,13 +2465,14 @@ static int is_reinit(struct repository *repo)
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
@@ -2483,14 +2484,14 @@ void create_reference_database(const char *initial_branch, int quiet)
 
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
@@ -2827,7 +2828,7 @@ int init_db(const char *git_dir, const char *real_git_dir,
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
2.53.0.1185.g05d4b7b318.dirty

