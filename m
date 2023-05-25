Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0692AC77B73
	for <git@archiver.kernel.org>; Thu, 25 May 2023 01:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbjEYB3Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 21:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjEYB3X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 21:29:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504FF5
        for <git@vger.kernel.org>; Wed, 24 May 2023 18:29:22 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-ba8337ade1cso3775896276.2
        for <git@vger.kernel.org>; Wed, 24 May 2023 18:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684978161; x=1687570161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wzhsE8t07R+vIoz/TnUbdL6c3eAHqK60kZAcBLmDqFQ=;
        b=2oKNLRKbuDEzmrcu/Ac913vrgiwXxtlbCM1x7vgy/Je1dr9K3y7gzF34Iu+IktvP7G
         6De3RggKYTa06eHRenTmohZY0S4Kao51YCLrewW03DOaiQPsWil80WuRd8KI3MIozEbI
         X5EXt3JGNxNNSklQtZtFSBVbHxv2/QGROWcF3tPVoTd8YoW2anH1moKXDfLnc1CYVJa1
         Xn+QQcD0VCIonNo2Rse971Oi3skqEw6HMCIWa96Bm6wbad577isN1Q9yXxeiK/cdByQV
         mEce2qkdZFZ+tuKG/8vRa6s11P9tJdnfQW7RG+meXZCYM+Vx86LgQU/Q3CP7O5ottcsT
         u1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684978161; x=1687570161;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wzhsE8t07R+vIoz/TnUbdL6c3eAHqK60kZAcBLmDqFQ=;
        b=jNeenTRO978Kn65qtzK6vA9RhC6p/4MEKxJuBaME20LMWBOV1jKSF1q3FkS525sWy/
         jlFeJmDWyW8WG+gI6F2BI/hqjSk4917BujGz4SpWqcEdTEf6h1RjXi/5nfjinHtD4cmi
         9uVmeP5OInLz/U/2IxSJflD9epicfVhLDQ+PTmCU/Y08HRYDDGpc8UxnPArFgngFXBdZ
         4YVnBECdE8zb4HLDdCmhbwz/H2I5IP6c84BAanVMSzcyg4TS37MlA/gKrulopryKNwgQ
         mHBDyMYQL5DwJWNGg7fqqpQtsYDrmtFa1KZCsmFn5Iq9ESPtdbpac07uynOSaBF47iDJ
         z99g==
X-Gm-Message-State: AC+VfDwvq8HBF2+sghPJvvZ3I/qLK/UTzW0OsOvoMNeykkyhRii/Elni
        fL7ZXr9z55mV9F/gGbKYldMIV4Nhuv1k8w==
X-Google-Smtp-Source: ACHHUZ4pLeeU3YJCXx9isw0H1n1bglVgOdwjEW3/SoGYKMP5TXEmo+WFsi09yA7c6+YrcfaRm/2HMRNy22kQMA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:4584:0:b0:b9d:d623:1960 with SMTP id
 s126-20020a254584000000b00b9dd6231960mr848989yba.0.1684978161527; Wed, 24 May
 2023 18:29:21 -0700 (PDT)
Date:   Wed, 24 May 2023 18:29:19 -0700
In-Reply-To: <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com> <5ed9100a7707a529b309005419244d083cdc85ba.1684883872.git.gitgitgadget@gmail.com>
Message-ID: <kl6lv8ghxkpc.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 2/2] repository: move 'repository_format_worktree_config'
 to repo scope
From:   Glen Choo <chooglen@google.com>
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     derrickstolee@github.com, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a quick response on the config.c bits, I haven't looked through
the global-removing parts closely yet. Rearranging the hunks for
clarity...

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:


> @@ -2667,11 +2670,14 @@ static void repo_read_config(struct repository *repo)
>  {
>  	struct config_options opts = { 0 };
>  	struct configset_add_data data = CONFIGSET_ADD_INIT;
> +	struct git_config_source config_source = { 0 };
>  
>  	opts.respect_includes = 1;
>  	opts.commondir = repo->commondir;
>  	opts.git_dir = repo->gitdir;
>  
> +	config_source.repo = repo;
> +
>  	if (!repo->config)
>  		CALLOC_ARRAY(repo->config, 1);
>  	else
> @@ -2681,7 +2687,7 @@ static void repo_read_config(struct repository *repo)
>  	data.config_set = repo->config;
>  	data.config_reader = &the_reader;
>  
> -	if (config_with_options(config_set_callback, &data, NULL, &opts) < 0)
> +	if (config_with_options(config_set_callback, &data, &config_source, &opts) < 0)
>  		/*
>  		 * config_with_options() normally returns only
>  		 * zero, as most errors are fatal, and

I think it would be better to pass a "struct repository" arg to
config_with_options() instead of mocking a config_source to hold a .repo
member. config_with_options() does double duty - it either discovers and
reads the configs for the repo (system, global, worktree, etc), or it
reads the config from just config_source. From this perspective, it
doesn't make sense that the caller can pass config_source but
config_with_options() will still discover and read all configs, and I
think the only reason why this behavior is supported at all is that
builtin/config.c sometimes "reads all config" and sometimes "reads from
a single file", but sloppily passes a non-NULL "config_source" arg
unconditionally.

> diff --git a/config.c b/config.c
> index a93f7bfa3aa..9ce2ffff5e1 100644
> --- a/config.c
> +++ b/config.c
> @@ -2277,7 +2278,7 @@ int config_with_options(config_fn_t fn, void *data,
>  		data = &inc;
>  	}
>  
> -	if (config_source)
> +	if (config_source && config_source->scope != CONFIG_SCOPE_UNKNOWN)
>  		config_reader_set_scope(&the_reader, config_source->scope);
>  
>  	/*

The aforemented change would also let us get rid of this, which might
not always be correct. I think there might be cases where the scope is
actually unknown, but I'm not sure if we have any of those situations
in-tree.

> diff --git a/environment.c b/environment.c
> index 28d18eaca8e..6bd001efbde 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -42,7 +42,6 @@ int is_bare_repository_cfg = -1; /* unspecified */
>  int warn_ambiguous_refs = 1;
>  int warn_on_object_refname_ambiguity = 1;
>  int repository_format_precious_objects;
> -int repository_format_worktree_config;
>  const char *git_commit_encoding;
>  const char *git_log_output_encoding;
>  char *apply_default_whitespace;

As an aside, I'm really happy to lose another global :)

