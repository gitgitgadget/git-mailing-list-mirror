Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90316F282
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008968; cv=none; b=E6XQo2XagX0R0+eLdAAQtb4nZkVJdvz5l5834LZDiznm9IvWk1aEExkc7WBVljiSiLcmok0+1RQOZW3NxdvJYlfTUwVjWmOK3s+MvkGiKMJxvBii4HJiLdT68d5APSYtct+VHeEYb14MEVId51vEW1PzU214j8F+Z7q7LlO1d+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008968; c=relaxed/simple;
	bh=D5MU50bYaWux5hG/GAGaU1v58ZHkCnoj1xT1ZltDFoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqGEg3kiINH5tXJ1A/j4ceVMTbeXDTlrsrYA+4rEoRVq3pJb4J2OhYBIrzAJ4S5LHnUa0964csxJvWCbR2pSOucnbzdadtq7s/9cLFAylrZNFfvKhT6KG+RXP7dTwW8SQSqNtmyq+CJV0C69UKMfFog1GNP/mg9RKGG/1a90hVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=suZ2IXjf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EvWWP1Uq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="suZ2IXjf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvWWP1Uq"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id E82BF1380266;
	Fri, 30 Aug 2024 05:09:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 30 Aug 2024 05:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008965; x=1725095365; bh=aTq5u0vFnq
	usadQrB0mvYtORZo3HHmDPXzy0GjkOiLY=; b=suZ2IXjflcA73bTsk7G2lT8cu/
	Omjm2lT7bwQVYoysr8GJQD53jdNyrqFqgz5h3E0Zvnm+76/17vMkSRykjkpzdtBI
	/Q74I2sZ+XCNimGSfhpevCFQ4qv7ko6mimqrPbZoNvqxi56SHcUPbWIG/QF8wv52
	VylS+6f3dyOlN5NcTPdhEodbCWahLwmtchW5b2iL9gVKtHek20FzzDP7YmNyRYGd
	7LpV4eiJfQ9CZYMIUWoXBi60NcgPL3Plk4qOsX8qWs+1glKnZuvaaMZZieYzWmq+
	xgF5/nUvAmjkoU/ua2BpXBfrsr+VrFsWrS8pTsl6o/fOVn4BtccgEUyfQwzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008965; x=1725095365; bh=aTq5u0vFnqusadQrB0mvYtORZo3H
	HmDPXzy0GjkOiLY=; b=EvWWP1UqUOBt2cBKV4VKN3qru9HziRcEjEx9vf8Gm4cO
	qJTXY9aWoeBJQcBZ5aJBBYZc+4BNw25M0E1xx2YKwAME5de4fzgedkjKKoIyzg49
	5L3lJ3dP5X3DMWij368zYgO/GXYAN0ugnsfSokAUYgCZ7/qDoG2t9WgCvc+Ijj7w
	7bajUsljaxVb0GdKymBukF2wIu1/gecxSbfXDuNmI0Bkk63ooX56F4DhqaQISYei
	fpWkMjIAO6zsDzMYXKlY7wrU7lUo4gv9KeOVGyO6fYgDXdpCqBewxENPOlN5ekzg
	2vBVm4jyoAaiMmEGyQ1i4BNFigZkhu7SKOT+ECKWOg==
X-ME-Sender: <xms:RYzRZjwk9vwHSXkq8IZzqozKb8Fz1o_lEdOFDpI1HDo_4-upSgjVdg>
    <xme:RYzRZrRxoZC_NtwicHi79COWYyVVzBTlqctmLDhjfWHBjX3Z4tQfK_a1p3h0Rt9pc
    AdjHRUeKmCTkDWU1g>
X-ME-Received: <xmr:RYzRZtV5NYJzyzBGdHu5JKu2TxckSnCIvam_KjeQr2tqaJ_WGrs-Sq4GO0s5LzG7nQWGDrE4g6Y9uEGqVH2LzY-CACm7rxUDMkBadv0SZ4gYxPi04w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:RYzRZtipecfRQUwsWuLvKDlLADbzyxcietgm7r8eLr3849Y78IBqYw>
    <xmx:RYzRZlAlyVxpMnLpbJkAg-zj0kLQoBOTsR8FkFp0gs52hVmVWOYFsw>
    <xmx:RYzRZmJf0X8mpNrIlkNv6x9aeyDaaQitq3nMEDKAkrJpzoyRI1i0vg>
    <xmx:RYzRZkA6zeR1Eldry2CZdN150f2FPgjV02N01M91jm2y5ZHO-jgSQA>
    <xmx:RYzRZg_R03XAvpm57gjs-hPHTjtCEJhe3Xz_7BKgrp0jD63XZtwKJMc2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eba67386 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:14 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/21] environment: make `get_git_namespace()`
 self-contained
Message-ID: <f0d3794dfc44cd4393fd79fab9f60b73cf33db89.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

The logic to set up and retrieve `git_namespace` is distributed across
different functions which communicate with each other via a global
environment variable. This is rather pointless though, as the value is
always derived from an environment variable, and this environment
variable does not change after we have parsed global options.

Convert the function to be fully self-contained such that it lazily
populates once called.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.c | 57 ++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/environment.c b/environment.c
index f337efd1dd5..49844418419 100644
--- a/environment.c
+++ b/environment.c
@@ -122,8 +122,6 @@ int core_preload_index = 1;
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
 
-static char *git_namespace;
-
 /*
  * Repository-local GIT_* environment variables; see environment.h for details.
  */
@@ -146,27 +144,6 @@ const char * const local_repo_env[] = {
 	NULL
 };
 
-static char *expand_namespace(const char *raw_namespace)
-{
-	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **components, **c;
-
-	if (!raw_namespace || !*raw_namespace)
-		return xstrdup("");
-
-	strbuf_addstr(&buf, raw_namespace);
-	components = strbuf_split(&buf, '/');
-	strbuf_reset(&buf);
-	for (c = components; *c; c++)
-		if (strcmp((*c)->buf, "/") != 0)
-			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
-	strbuf_list_free(components);
-	if (check_refname_format(buf.buf, 0))
-		die(_("bad git namespace path \"%s\""), raw_namespace);
-	strbuf_addch(&buf, '/');
-	return strbuf_detach(&buf, NULL);
-}
-
 const char *getenv_safe(struct strvec *argv, const char *name)
 {
 	const char *value = getenv(name);
@@ -205,8 +182,6 @@ void setup_git_env(const char *git_dir)
 							  : "refs/replace/");
 	update_ref_namespace(NAMESPACE_REPLACE, git_replace_ref_base);
 
-	free(git_namespace);
-	git_namespace = expand_namespace(getenv(GIT_NAMESPACE_ENVIRONMENT));
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(the_repository, shallow_file, 0);
@@ -229,9 +204,35 @@ int have_git_dir(void)
 
 const char *get_git_namespace(void)
 {
-	if (!git_namespace)
-		BUG("git environment hasn't been setup");
-	return git_namespace;
+	static const char *namespace;
+
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf **components, **c;
+	const char *raw_namespace;
+
+	if (namespace)
+		return namespace;
+
+	raw_namespace = getenv(GIT_NAMESPACE_ENVIRONMENT);
+	if (!raw_namespace || !*raw_namespace) {
+		namespace = "";
+		return namespace;
+	}
+
+	strbuf_addstr(&buf, raw_namespace);
+	components = strbuf_split(&buf, '/');
+	strbuf_reset(&buf);
+	for (c = components; *c; c++)
+		if (strcmp((*c)->buf, "/") != 0)
+			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
+	strbuf_list_free(components);
+	if (check_refname_format(buf.buf, 0))
+		die(_("bad git namespace path \"%s\""), raw_namespace);
+	strbuf_addch(&buf, '/');
+
+	namespace = strbuf_detach(&buf, NULL);
+
+	return namespace;
 }
 
 const char *strip_namespace(const char *namespaced_ref)
-- 
2.46.0.421.g159f2d50e7.dirty

