Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0E6C433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 09:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A6B20656
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 09:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBFe5Enl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgFKJfu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgFKJfu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 05:35:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A96C03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 02:35:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r7so5440797wro.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6rR5uQpC/jT7q/UPbilxxmJ5m7Me3iAJRnrDauHB2AQ=;
        b=aBFe5EnlSpC8caiLaYL1pzHH+4ZJjttXobinc8DdqVprHh06q9igYC1uzQI4rwzweG
         RHuYn2UIaWWiO5gkefbQ+GnooAjdNY4ZXC7fbumleS/sR1jC6dDcn8NJk38le9WzVZx/
         oMKNQ02D5JKWga5aCP+NcQfzMzmtQXDUrxQG9VmQ4Udey1Yjlz9GIuhloZxG70BCHzPr
         78f8StYMtLNzcN5JYZ+ZQHfGTD5cGSZvnlx/tka5lRXuT+gWF/Vhc6BP8j+GUZl/WIQp
         ceu6JcEXN+3kNODHfp4/hXj2GmgH4icRISrHvbKF8D3TWxaYS3RkCIw2W3RmWm0wnMaF
         nY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6rR5uQpC/jT7q/UPbilxxmJ5m7Me3iAJRnrDauHB2AQ=;
        b=UNjEM33s81RXfjGydwSmqpNa5XnVQOXXESFVj6AEwKsXQo0QPIM5DVO0oNV38kpzAd
         iHGCjjo58YoPaw1Cd+G6FHI0i8PTbbJd27zDzcqpiX8R0A0tfmUoU1lRakVtlxkrxpAr
         LcONaLgnMxGrFLxRIpbKSje8g6Hw5uiapg+ih/vPIFyi3a2rMottEmOIVY5TV62fzXcy
         cPjNLhDAO8e+k+uRSdFBz+USId8GeLP3nJsR5eoQ7FbL99Th9s36Hp64agiOZ1dWbJUO
         epiGfi5GkiBu+j0YxYmUeSE6XtExM14+0pD8J4fAZ4j/2MmGv9tgfmSuPrBUCc2ax3+N
         KrNQ==
X-Gm-Message-State: AOAM531bVCkJiAVoZlEwmcNrM3dfzVi33GaE2l2oD7P74vgXWGe/+b1p
        Fcqxrz6uQ5siF5/w4h4jZ+o=
X-Google-Smtp-Source: ABdhPJxm+dJnxOSba2TVWDiw65ySBcTZ8q5h5U5o10UzBeJqT+oL19vJn0PeGeERzpsmdyG/QQwTOA==
X-Received: by 2002:a5d:610f:: with SMTP id v15mr8460892wrt.52.1591868147662;
        Thu, 11 Jun 2020 02:35:47 -0700 (PDT)
Received: from [192.168.1.201] (226.20.198.146.dyn.plus.net. [146.198.20.226])
        by smtp.googlemail.com with ESMTPSA id l17sm4130738wrq.17.2020.06.11.02.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 02:35:46 -0700 (PDT)
Subject: Re: [PATCH 1/9] init: allow overriding the default branch name for
 new repositories
To:     Don Goodman-Wilson via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <be09ffbb-4e38-5b67-54da-0b60d5e2d8c3@gmail.com>
Date:   Thu, 11 Jun 2020 10:35:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <90912e32da1192cfc3b39a18cb606caa46e85b1c.1591823971.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2020 22:19, Don Goodman-Wilson via GitGitGadget wrote:
> From: Don Goodman-Wilson <don@goodman-wilson.com>
> 
> There is a growing number of projects trying to avoid the non-inclusive
> name `master` in their repositories.

I think it would be helpful to explain why 'master' is no-inclusive even
if it originates from the concept of a master copy. i.e. it suggests
master/slave even if git is not based on that concept.

Have you got some examples of projects that have changed and the names
that they are using? I think it would be helpful if we can agree on a
replacement for master - if every repository uses a different name for
its main branch it adds an extra complication for new contributors to
those projects.

 For existing repositories, this
> requires manual work. For new repositories, the only way to do that
> automatically is by copying all of Git's template directory, then
> hard-coding the desired default branch name into the `.git/HEAD` file,
> and then configuring `init.templateDir` to point to those copied
> template files.
> 
> To make this process much less cumbersome, let's introduce support for
> `core.defaultBranchName`. That way, users won't need to keep their
> copied template files up to date, and won't interfere with default hooks
> installed by their administrators.
> 
> While at it, also let users set the default branch name via the
> environment variable `GIT_TEST_DEFAULT_BRANCH_NAME`,

I'm not sure we usually promote the use of GIT_TEST_... environment
variables outside of the test suite.

> in preparation for
> adjusting Git's test suite to a more inclusive default branch name. As
> is common in Git, the `GIT_TEST_*` variable takes precedence over the
> config setting.
> 
> Note: we use the prefix `core.` instead of `init.` because we want to
> adjust also `git clone`, `git fmt-merge-msg` and other commands over the
> course of the next commits to respect this setting.
> 
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Don Goodman-Wilson <don@goodman-wilson.com>
> ---
>  builtin/init-db.c |  8 +++++---
>  refs.c            | 34 ++++++++++++++++++++++++++++++++++
>  refs.h            |  6 ++++++
>  t/t0001-init.sh   | 20 ++++++++++++++++++++
>  4 files changed, 65 insertions(+), 3 deletions(-)
> 
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 0b7222e7188..99792adfd43 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -258,15 +258,17 @@ static int create_default_files(const char *template_path,
>  		die("failed to set up refs db: %s", err.buf);
>  
>  	/*
> -	 * Create the default symlink from ".git/HEAD" to the "master"
> -	 * branch, if it does not exist yet.
> +	 * Create the default symlink from ".git/HEAD" to the default
> +	 * branch name, if it does not exist yet.
>  	 */
>  	path = git_path_buf(&buf, "HEAD");
>  	reinit = (!access(path, R_OK)
>  		  || readlink(path, junk, sizeof(junk)-1) != -1);
>  	if (!reinit) {
> -		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
> +		char *default_ref = git_default_branch_name(0);
> +		if (create_symref("HEAD", default_ref, NULL) < 0)
>  			exit(1);
> +		free(default_ref);
>  	}
>  
>  	initialize_repository_version(fmt->hash_algo);
> diff --git a/refs.c b/refs.c
> index 224ff66c7bb..8499b3865cb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -560,6 +560,40 @@ void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
>  		argv_array_pushf(prefixes, *p, len, prefix);
>  }
>  
> +char *git_default_branch_name(int short_name)
> +{
> +	const char *branch_name = getenv("GIT_TEST_DEFAULT_BRANCH_NAME");
> +	char *from_config = NULL, *prefixed;
> +
> +	/*
> +	 * If the default branch name was not specified via the environment
> +	 * variable GIT_TEST_DEFAULT_BRANCH_NAME, retrieve it from the config
> +	 * setting core.defaultBranchName. If neither are set, fall back to the
> +	 * hard-coded default.
> +	 */
> +	if (!branch_name || !*branch_name) {
> +		if (git_config_get_string("core.defaultbranchname",
> +					  &from_config) < 0)
> +			die(_("Could not retrieve `core.defaultBranchName`"));
> +
> +		if (from_config)
> +			branch_name = from_config;
> +		else
> +			branch_name = "master";
> +	}
> +
> +	if (short_name)
> +		return from_config ? from_config : xstrdup(branch_name);

If short_name is set we return without validating the name is that
intentional?

> +
> +	/* prepend "refs/heads/" to the branch name */
> +	prefixed = xstrfmt("refs/heads/%s", branch_name);
> +	if (check_refname_format(prefixed, 0))
> +		die(_("invalid default branch name: '%s'"), branch_name);
> +
> +	free(from_config);
> +	return prefixed;
> +}
> +
>  /*
>   * *string and *len will only be substituted, and *string returned (for
>   * later free()ing) if the string passed in is a magic short-hand form
> diff --git a/refs.h b/refs.h
> index a92d2c74c83..e8d4f6e2f13 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -154,6 +154,12 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
>  int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
>  int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
>  
> +/*
> + * Retrieves the name of the default branch. If `short_name` is non-zero, the
> + * branch name will be prefixed with "refs/heads/".

Isn't the other way around - the branch name is prefixed with
"refs/heads/" if short is zero.

> + */
> +char *git_default_branch_name(int short_name);
> +
>  /*
>   * A ref_transaction represents a collection of reference updates that
>   * should succeed or fail together.
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 1edd5aeb8f0..b144cd8f46b 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -464,4 +464,24 @@ test_expect_success MINGW 'redirect std handles' '
>  	grep "Needed a single revision" output.txt
>  '
>  
> +test_expect_success 'custom default branch name from config' '
> +	git config --global core.defaultbranchname nmb &&

In tests we usually use 'test_config' rather than 'git config' as the
former automatically cleans up the config at the end of the test.

> +	GIT_TEST_DEFAULT_BRANCH_NAME= git init custom-config &&
> +	git config --global --unset core.defaultbranchname &&
> +	git -C custom-config symbolic-ref HEAD >actual &&
> +	grep nmb actual
> +'
> +
> +test_expect_success 'custom default branch name from env' '
> +	GIT_TEST_DEFAULT_BRANCH_NAME=nmb git init custom-env &&

It would be good to test that this overrides the config setting

Best Wishes

Phillip

> +	git -C custom-env symbolic-ref HEAD >actual &&
> +	grep nmb actual
> +'
> +
> +test_expect_success 'invalid custom default branch name' '
> +	test_must_fail env GIT_TEST_DEFAULT_BRANCH_NAME="with space" \
> +		git init custom-invalid 2>err &&
> +	test_i18ngrep "invalid default branch name" err
> +'
> +
>  test_done
> 

