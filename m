Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BA62F4329
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279723; cv=none; b=GdT1oHP4LfCLnkCzO593viZbuPWlTIGJQ3nnT+lUcchPCbpBloTGpSaA5d0mbz5RwanfcDl4qokgmmf3E+nvyWIctMyEOaJgEwNfEX2VoUss3PAXdHbU0hlrNYcTNV5QOkPlV4ITnECPzbjBl7ogsY77WxsUm2VskSNyDspFa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279723; c=relaxed/simple;
	bh=ix58p4uCZ9uKchdFXIA3E8/N47++Bt0BkVAp/b08vjA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yh2Z1iFyThDyIVaFVkVuS41blpNK5RSyFcm91mQLLX5t6NjikZ428cJZ/WpplhurPcf7BmzAEvlSLcCEoWFpyWptQ3i/96z5XaSdjjp42BMqgyKYNVZQ2e1LCvGXU94ndn8cr9ARU0qHlSFWp8d4xVTTF1tDKK+77vfLj7kUgGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y5Fzl1w1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GQAMY9Rs; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y5Fzl1w1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GQAMY9Rs"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 653761401DA8;
	Wed, 23 Jul 2025 10:08:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 23 Jul 2025 10:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279720;
	 x=1753366120; bh=d51hiT5iQ77RI89HLMUbQbfpjcRCw5PpjblJLCWQDe0=; b=
	Y5Fzl1w12vrYwruqdWwqJfUayAs4daqz5fB3Pr8XZ82KH35FnDZd6akDtXYP+v0P
	4fDwot6HHyF1975iJLms9I7C3pi5ckQu1VBce/VS0SUYVRUtlbF8R0tmG+wAZb3C
	Qo1RUowi/PoFA7K0riNjy+XDWDhvE1gf7NNA0xm1d8HCZqEBYAYO/c3HUTVVOwdh
	Ce6YO88Q1ft4LPrYBK6mkHpwYdJby49vwAKxh9DM6+JWmMz6+vij/UuxYg2toOTv
	tVAotxqp6n2NYqAMSpeVdRsBw87JwtmtoIPjFZs9kpH+K2PKsdx4WznZVXM/na+J
	BLWLcAQokAHL1B4VNwlv1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279720; x=
	1753366120; bh=d51hiT5iQ77RI89HLMUbQbfpjcRCw5PpjblJLCWQDe0=; b=G
	QAMY9RsdJGaL6/hZezwnJI2cFeJ0JBws+cm6oDfN8WxMVIXHtfEcykpirOvpKzBD
	ESnf2FaFpb7EUBOihF8mRIpQCSaNWQDf8eT0B79tDCoN6zCasEwTiiiNM09ypFX4
	aPmlSrq5ygpVivXvXZVI6fbqtyyKg+wft7CHBM25PLTI99NdaONOsJBz4qv/jPc2
	p2KfrG8BPKQzrBnHJZZ+36XkNWs6kpPwaRNXUPAks6TozB14TeHeedeSDiTrHQBw
	WLMh7iYo9sMYYPytSz4ySXW+IscqoaDLNq2zVLidGjGFjllCAvCpWxg3hFyXKRpz
	MbDI82RgEpy3kJM0bfgtQ==
X-ME-Sender: <xms:6OyAaEiyiPa7X0aee6G6Git_e8UXr2vMvvsJ8URgQJdbcw9kLLFI4g>
    <xme:6OyAaNOOCcfraHpmahGjERXz6SETZ32AbVeMIGdh7MNy9dt603KQeW6JAUmAFNdEl
    EpF6tGuWCNrjr0R3Q>
X-ME-Received: <xmr:6OyAaN6qwSFWRdqUU9iEu-DRfAULP81qHRBGrlykyd71MIznsnreSS-Q26cpVuAbYl9_drMq0GUt2YdBWDrJ4e_xw-Hd3vFixI_fS6qrJPeC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epuddufedutdevueelteeikedujeffjeehfedvieehfeeutdegffefkeeijeelheejnecu
    ffhomhgrihhnpehsuhgsmhhoughulhgvrdgrtghtihhvvgenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfees
    ghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6OyAaD2yZ1HOy2v-HMX6Kvw5zf_hEBmSjZi6bZ96RT7JolGLjg-MmQ>
    <xmx:6OyAaGadHae_lFGppQ2A3k0RPcMTZ-klkY8jZ9xgCcx9z-dcOiVRZA>
    <xmx:6OyAaDBboiwPTom4GO0l13PDcT_NcF9klYcWSnlKx7UL2neJCJ7SvA>
    <xmx:6OyAaA_rH0Hl-SBMdbEW8OdIBMscz180f-eHyZgBx_4BrCIoy4L_kA>
    <xmx:6OyAaJwjvd3RzfV3hSy1fh-6esT3QhuiFKU6u-tLnT3L5a2B3oH0d92D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:08:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5700de5d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:08:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:24 +0200
Subject: [PATCH v2 03/21] config: drop `git_config_get()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-3-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_get()`. All
callsites are adjusted so that they use `repo_config_get(the_repository,
...)` instead. While some callsites might already have a repository
available, this mechanical conversion is the exact same as the current
situation and thus cannot cause any regression. Those sites should
eventually be cleaned up in a later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c                | 2 +-
 builtin/submodule--helper.c | 6 +++---
 config.h                    | 5 -----
 t/helper/test-config.c      | 2 +-
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d9e3b9d2ec3..e5c3d082eda 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1916,7 +1916,7 @@ static int maintenance_register(int argc, const char **argv, const char *prefix,
 	git_config_set("maintenance.auto", "false");
 
 	/* Set maintenance strategy, if unset */
-	if (git_config_get("maintenance.strategy"))
+	if (repo_config_get(the_repository, "maintenance.strategy"))
 		git_config_set("maintenance.strategy", "incremental");
 
 	if (!git_config_get_string_multi(key, &list)) {
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 89ee09abea6..6bcc741a6ac 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -549,7 +549,7 @@ static int module_init(int argc, const char **argv, const char *prefix,
 	 * If there are no path args and submodule.active is set then,
 	 * by default, only initialize 'active' modules.
 	 */
-	if (!argc && !git_config_get("submodule.active"))
+	if (!argc && !repo_config_get(the_repository, "submodule.active"))
 		module_list_active(&list);
 
 	info.prefix = prefix;
@@ -2878,7 +2878,7 @@ static int module_update(int argc, const char **argv, const char *prefix,
 		 * If there are no path args and submodule.active is set then,
 		 * by default, only initialize 'active' modules.
 		 */
-		if (!argc && !git_config_get("submodule.active"))
+		if (!argc && !repo_config_get(the_repository, "submodule.active"))
 			module_list_active(&list);
 
 		info.prefix = opt.prefix;
@@ -3349,7 +3349,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get("submodule.active")) {
+	if (!repo_config_get(the_repository, "submodule.active")) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/config.h b/config.h
index 4eea99e9b95..9261ed0f8d7 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get(const char *key)
-{
-	return repo_config_get(the_repository, key);
-}
-
 static inline int git_config_get_value(const char *key, const char **value)
 {
 	return repo_config_get_value(the_repository, key, value);
diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 41ba8647900..cacf6f306b1 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -137,7 +137,7 @@ int cmd__config(int argc, const char **argv)
 	} else if (argc == 3 && !strcmp(argv[1], "get")) {
 		int ret;
 
-		if (!(ret = git_config_get(argv[2])))
+		if (!(ret = repo_config_get(the_repository, argv[2])))
 			goto exit0;
 		else if (ret == 1)
 			printf("Value not found for \"%s\"\n", argv[2]);

-- 
2.50.1.552.g942d659e1b.dirty

