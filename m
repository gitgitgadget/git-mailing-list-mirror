Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E818E75D
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924341; cv=none; b=lVo0VZhaOPx0s7H0UNOUeDx7tqMbm60tqP9N8s/nLqfMKYD9+o7nDReTSOxjF7VTBmI+piD1xOFEkYX6s0sbqY/mfKtMfG7X0lkb0/VV9+O6u3PZXXv1c7VKFE8/vNJUgPBIgr5sSi6DH3NKefse//sdzsXwQ7kiftO/atcja2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924341; c=relaxed/simple;
	bh=D5MU50bYaWux5hG/GAGaU1v58ZHkCnoj1xT1ZltDFoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EeEo6kthhIx9KuVOgCrqLbzxzt5Z4OwnjV93WsCUrQkiJve4e+X0UP9szqkTbYFMEsTJkr2yRr+sX6cb6uhabHjiJLh+xgIoaA3YERO3eVjNuxz8WLzXG5MQrDIYjfHR52tK+6T7QiWrMFEq+R5a+Db8l+aJqEIpu3C+tAC7NvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P2gAWmmK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZ/E2TbT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P2gAWmmK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZ/E2TbT"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id F14EB138FC3A;
	Thu, 29 Aug 2024 05:38:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 05:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924338; x=1725010738; bh=aTq5u0vFnq
	usadQrB0mvYtORZo3HHmDPXzy0GjkOiLY=; b=P2gAWmmKz4PpR34YE7XhTvCbmJ
	SsYfgd417hlIw/oeWIzMxV7TdRtuCKbz5vcunurJukGl/ORf8yGvW8MojjhNM3bp
	mDbhMiLyvSgXqoz7ysz25JJruuGE6Gz/t/YhbLEPcere9ZY/jBq0acitZ0LGHLmD
	VFDqYtzINib13mVByLw5YyjcmA2rs/sjFXgTPiczYDj1ECBoIzoWvqluccNcsQQJ
	bU1X0BQhY9Ubm/4hkauhXvCwJnrd6mqNg3A2EdbfAXeiE4jLL/Y1tCWrE14l5hsA
	i/4hST3eqL6LpkSZOYB4OuQ1XDYCVMZ79cfRjT1T/1VJVthtHx5RoeJFn7WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924338; x=1725010738; bh=aTq5u0vFnqusadQrB0mvYtORZo3H
	HmDPXzy0GjkOiLY=; b=RZ/E2TbTrNJbLeHbXH4dzVoeTbrEKpYl00pIgjJQjyEh
	Nvo7zLT46TLh6qBjbLYpULVVq/JduRGY5gYarIyjoZAY7UHOD6tRZvSwuKcTqi1p
	/A8RwO4/SDt9K++NuzLWJMBNQwM7SeSUWmuu3imFAr2ztbsJR0Pblh8Ech+qsBWU
	CCVv3lnCF9d/qYYaCTa/vN5yC8FsTCdO2ZbdjXgOHk5j1V1QCniIxFa+zXVUhKlt
	HYwMtEghLP6NaklL+4u/sQi9qOrFJdhlvenly4Xwq8yOqMINyhn8/LwK+bFB1TmF
	vsqqUMEWsH9IOXlbuP8USKIckuw/2j7W1oJkzde+XA==
X-ME-Sender: <xms:skHQZpbxtJvn3DyfPWlr_XF5nYpKKgfExLwl8Bi99cCCtmwMhI3JKA>
    <xme:skHQZga9Ve8R3PzrFaRTkSDn8H3WZNHgrxYUeDd6JZzKqya66KnbU_rZaIL4RD3l9
    20cBMTRwk9dnT6bdw>
X-ME-Received: <xmr:skHQZr83PVwXApywEJVWKEKFRDO1YQ_yhV3gNzW993cX15oqIGIsU00bTaNjIM1ofscSo_uDP32B7L7XTYjZAVo5F0PeCB0vx7Qm6hltnmpcwK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:skHQZnrCHZEFYfKebIdJGrPgHdHgtvbvpji3jDP10icU6Kiap_E9eg>
    <xmx:skHQZkouIdfajlxbO9YkQGZT29Grs6yo__z2bPNa8cAWUwl09OOxBQ>
    <xmx:skHQZtTN1cH7Ejm8EzbHh2R-mcihYmVE_tkxJ8IvB8_MbJ9XfSu9_g>
    <xmx:skHQZsqsAqnyT3ZL7_w5HLbz9jqJz6cXnYm6HLJFNy6hKwtCp1p8Yw>
    <xmx:skHQZr36g7rVDaL6eZd-DrpdPo8ezs8LK0VluojouAzlniMr84MUmZtJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b1ed2542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:49 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 10/21] environment: make `get_git_namespace()` self-contained
Message-ID: <0b3916b2d0d33215a86fcbb79302aa6f145e89fc.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

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

