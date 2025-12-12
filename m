Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFDC258ED5
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552533; cv=none; b=b9Kt+VdA11X0fzfXlUZrQUztJ273Uuo3NRlT26BWzpSOfKDEjzxMYLIpN9mi4/FsPOkYoEYmFgTUhxJWki5MHpUBFzIRHiZjVvbJI5yKRauf5WZ1NuzA92zqsfHlYbrpmbunxgfQaGo9GB9+4UTj7EW9s+TgITlFoAeMJsRo5k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552533; c=relaxed/simple;
	bh=lcdhcIRB8RjjBnCDVwx094qop3+BD/Igt612Zmjzs+Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HeFSQckodq1uwsvpxKIV7hQ5iUhh9NDsNDSWc43O8iWgkfaXEKAoUqcWtfxgXIBtpJ700OfK3HZZ7r6u8MdITVkYwVaM053OxBBGdHpEcCyPA6xu1/QwPuGDfUEP0e7PTmG0MeFhVn8AFv0OtfJS+4koXUlJWM9+gS5vcS60yTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxIOEtAF; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxIOEtAF"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c03eb31db80so916767a12.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 07:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765552531; x=1766157331; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjRs6Km6Lhelpgs+U3xFon6GIe9a/MRcqhjeZQNh35U=;
        b=XxIOEtAFSJWbkn4gWdNnEU+l3qUOkPKX5dx97apBO/gufG1MsZany4EhINLP4FrWiJ
         2OkE+Aw0OV57vooBYyoPRsmyErQ7GbP6ScT/Ly8QYKz5qG1LTfwGOEch/n8KvoBF1BJz
         GJQ9yscATXxu24180gdhwLcdOV6suRRQGEWXAWhTbavdWjNpwgMenuKCTiLqvyyL7HD+
         w/+fhdepp7/8UJLpxJEAshPOBCHR6hboKyJtaH7qhAAixN4i2xP3gLGndQ4R9pQ/LfIa
         dp8KbB4FUupXJQ/lA6wdnftkuPgvgf5KujSTvOa2Lrqd9Ju9vGCllHEykhhR3W/Gb/+u
         n/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765552531; x=1766157331;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjRs6Km6Lhelpgs+U3xFon6GIe9a/MRcqhjeZQNh35U=;
        b=IwqU6mi9D4HYvaqHEqSI/FD3Aw5YvDnMp90w9WTNfv+Qu4NlsIULjiaeMbi5Mug9ku
         Ks/Ha2xxhvTcljw01iRA8Q1AAE/PityT2gp1VMpUDxHT9Wjv0chZy6C3/YIVfdVWEI5a
         U0cxbuNKn6gUUgPUoSAWom0a6kBEuvI6FXlzZjULNN66awPyUJeh1kEwGhkt7HH0XIsX
         RxN6c8MRiUK05QX3+tF9UkzUiFdnbTRn2CN91PTh4m/KPwVG6wwSIUFpq6ggieCniiJ8
         Bb3O2SKOmwV/heuufNH+8Q4UcN59rKlAAyqRpP16A6C3mlu+BkoQEWF7bM0z11gAbJGw
         FbfA==
X-Gm-Message-State: AOJu0Yx8iWPpGSuNiBOZo26+kyOGcu1g140NXuuwZy+HacI5/XCLr2RC
	KOTcOAbkwR76ZGIMnkVl4TZ8o9AQ79UHIgd3DkHLSBla+N9JRnVv2lSpa4waWFSu
X-Gm-Gg: AY/fxX59w/JzhpAuHb2292A9tTX5PKcmEU45W9mUzxCekVjQXBhuTZdn1DPQ69v+/cg
	hqIfFZMQ4MExxusSiRG/6Lu6sdrV261KptZMcwUqsOIl4E38x33nqMQxwiU68w1ce+diJOpAaqY
	yBvu6XrhttuIdEsmlGLfG62xIJmcYpdt2E+a7HAm3Qxqof5R9LiNv+1xu4j+n9LSIONRjSbYOss
	cHYepOeN0f9cv/8FVkqZAEZwiG6fd+hEm8vAKk4oif2JOa6z3ayjAFwRhagxJWkn/ks9rhH7vD+
	PhJKuPWz1JgbfBtCuH9mUiC60Z3oPY5WxuMfODECutLS1FJgJEX3tTxc+KpRmFWahWudQi21d7A
	ZkoRoY1rdIfVp4k27JP9rmzNlzn1jKF3lO5juktfX4bixZR+joEB7ak8UaHl4XrvpE5BjIG87hX
	e9+s71ynvSKU9BQA==
X-Google-Smtp-Source: AGHT+IFeimHTtJ+Vq8ZkQ3rX9Zwtm6A19OZeuwch9En3fXnXjSmASaXlPBK1qsIqkvmKTxxgxXF88g==
X-Received: by 2002:a05:693c:40d5:b0:2a4:4e54:dc69 with SMTP id 5a478bee46e88-2ac30147f5cmr1684469eec.38.1765552530202;
        Fri, 12 Dec 2025 07:15:30 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.53])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac190acd01sm16265053eec.1.2025.12.12.07.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:15:29 -0800 (PST)
Message-Id: <pull.2010.v3.git.1765552528.gitgitgadget@gmail.com>
In-Reply-To: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
References: <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 12 Dec 2025 15:15:23 +0000
Subject: [PATCH v3 0/5] Audit and document Scalar config
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    ps@pks.im,
    atthewhughes934@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew Hughes <matthewhughes934@gmail.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Derrick Stolee <stolee@gmail.com>

In September [1], we discussed that the Scalar config options could use some
documented justification as well as some comments to the config file that
they were set by Scalar. I was then immediately distracted by other work
things and am finally here with a series to do just that.

[1]
https://lore.kernel.org/git/ffa61066-7004-48dd-9096-85b305373bc7@gmail.com/

I have indeed used Patrick's idea to add '# set by scalar' to each line
added by Scalar, it took a little more work for all the kinds of config set.
I made myself a co-author.

While working to justify each config option, I found some stale or incorrect
config options. I also relaxed the override setting in most cases which gave
me an opportunity to alphabetize the settings.

There was at least one case (I'm thinking of core.fscache here) where the
config doesn't even exist in core Git, but instead in Git for Windows. We'll
need to adjust in that fork to reinclude it in the right place.


Updates in V2
=============

 * The config-setting code is simplified somewhat.
 * Use 'sane_unset' instead of 'export' in test.
 * Documentation is improved for typos, grammar, and clarity.


Updates in V3
=============

 * Updated method names when setting recommended config.
 * Updated documentation section title now that nothing is "required".
 * Made distinction for index.threads=true as explicit setting.
 * Added documentation for log.exludeDecoration.

Thanks, -Stolee

Derrick Stolee (5):
  scalar: annotate config file with "set by scalar"
  scalar: use index.skipHash=true for performance
  scalar: remove stale config values
  scalar: alphabetize and simplify config
  scalar: document config settings

 Documentation/scalar.adoc | 164 ++++++++++++++++++++++++++++++++++++++
 scalar.c                  |  93 +++++++++++----------
 t/t9210-scalar.sh         |  25 +++---
 3 files changed, 231 insertions(+), 51 deletions(-)


base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2010%2Fderrickstolee%2Fscalar-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2010/derrickstolee/scalar-config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2010

Range-diff vs v2:

 1:  639ff98c44 ! 1:  7a2f919d7c scalar: annotate config file with "set by scalar"
     @@ scalar.c: struct scalar_config {
       	int overwrite_on_reconfigure;
       };
       
     -+static int set_config_with_comment(const char *key, const char *value)
     +-static int set_scalar_config(const struct scalar_config *config, int reconfigure)
     ++static int set_scalar_config(const char *key, const char *value)
      +{
      +	char *file = repo_git_path(the_repository, "config");
      +	int res = repo_config_set_multivar_in_file_gently(the_repository, file,
     @@ scalar.c: struct scalar_config {
      +	return res;
      +}
      +
     - static int set_scalar_config(const struct scalar_config *config, int reconfigure)
     ++static int set_config_if_missing(const struct scalar_config *config, int reconfigure)
       {
       	char *value = NULL;
     + 	int res;
      @@ scalar.c: static int set_scalar_config(const struct scalar_config *config, int reconfigure
       	if ((reconfigure && config->overwrite_on_reconfigure) ||
       	    repo_config_get_string(the_repository, config->key, &value)) {
       		trace2_data_string("scalar", the_repository, config->key, "created");
      -		res = repo_config_set_gently(the_repository, config->key, config->value);
     -+		res = set_config_with_comment(config->key, config->value);
     ++		res = set_scalar_config(config->key, config->value);
       	} else {
       		trace2_data_string("scalar", the_repository, config->key, "exists");
       		res = 0;
     +@@ scalar.c: static int set_recommended_config(int reconfigure)
     + 	char *value;
     + 
     + 	for (i = 0; config[i].key; i++) {
     +-		if (set_scalar_config(config + i, reconfigure))
     ++		if (set_config_if_missing(config + i, reconfigure))
     + 			return error(_("could not configure %s=%s"),
     + 				     config[i].key, config[i].value);
     + 	}
     + 
     + 	if (have_fsmonitor_support()) {
     + 		struct scalar_config fsmonitor = { "core.fsmonitor", "true" };
     +-		if (set_scalar_config(&fsmonitor, reconfigure))
     ++		if (set_config_if_missing(&fsmonitor, reconfigure))
     + 			return error(_("could not configure %s=%s"),
     + 				     fsmonitor.key, fsmonitor.value);
     + 	}
      @@ scalar.c: static int set_recommended_config(int reconfigure)
       	if (repo_config_get_string(the_repository, "log.excludeDecoration", &value)) {
       		trace2_data_string("scalar", the_repository,
     @@ scalar.c: static int set_recommended_config(int reconfigure)
      -		if (repo_config_set_multivar_gently(the_repository, "log.excludeDecoration",
      -						    "refs/prefetch/*",
      -						    CONFIG_REGEX_NONE, 0))
     -+		if (set_config_with_comment("log.excludeDecoration",
     ++		if (set_scalar_config("log.excludeDecoration",
      +					    "refs/prefetch/*"))
       			return error(_("could not configure "
       				       "log.excludeDecoration"));
 2:  10e9548955 = 2:  573929ecdb scalar: use index.skipHash=true for performance
 3:  8783db6153 = 3:  85b499a616 scalar: remove stale config values
 4:  edc0254770 = 4:  c30ffc87dc scalar: alphabetize and simplify config
 5:  ac1627dbd9 ! 5:  f062b0e077 scalar: document config settings
     @@ Documentation/scalar.adoc: delete <enlistment>::
       	This subcommand lets you delete an existing Scalar enlistment from your
       	local file system, unregistering the repository.
       
     -+REQUIRED AND RECOMMENDED CONFIG
     -+-------------------------------
     ++RECOMMENDED CONFIG VALUES
     ++-------------------------
      +
      +As part of both `scalar clone` and `scalar register`, certain Git config
      +values are set to optimize for large repositories or cross-platform support.
     @@ Documentation/scalar.adoc: delete <enlistment>::
      +
      +index.threads=true::
      +	This tells Git to automatically detect how many threads it should use
     -+	when reading the index due to the default value of `core.preloadIndex`,
     -+	which enables parallel index reads.
     ++	when reading the index due the default value of	`core.preloadIndex`,
     ++	which enables parallel index reads. This explicit setting also enables
     ++	`index.recordOffsetTable=true` to speed up parallel index reads.
      +
      +index.version=4::
      +	This index version adds compression to the path names, reducing the size
      +	of the index in a significant way for large repos. This is an important
      +	performance boost.
      +
     ++log.excludeDecoration=refs/prefetch/*::
     ++	Since Scalar enables background maintenance with the `incremental`
     ++	strategy, this setting avoids polluting `git log` output with refs
     ++	stored by the background prefetch operations.
     ++
      +merge.renames=true::
      +	When computing merges in large repos, it is particularly important to
      +	detect renames to maximize the potential for a result that will validate
     @@ Documentation/scalar.adoc: delete <enlistment>::
       SEE ALSO
       --------
       linkgit:git-clone[1], linkgit:git-maintenance[1].
     +
     + ## scalar.c ##
     +@@ scalar.c: static int have_fsmonitor_support(void)
     + 
     + static int set_recommended_config(int reconfigure)
     + {
     ++	/*
     ++	 * Be sure to update Documentation/scalar.adoc if you add, update,
     ++	 * or remove any of these recommended settings.
     ++	 */
     + 	struct scalar_config config[] = {
     + 		{ "am.keepCR", "true" },
     + 		{ "commitGraph.changedPaths", "true" },

-- 
gitgitgadget
