Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A2E2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750918AbdBOSKh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 13:10:37 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34762 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750767AbdBOSKg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 13:10:36 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so11737138pgv.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TpDsAHqIijoAZ7Gc5TVZwMYult9V8HzwX4d5H1gYnf8=;
        b=lOX5JDDaaCFcgMbFhgcM69WCa4wq1Ew+HZZiQJQJaLSUzG5o51MUwukFicq0GEUEat
         7FSRx3JZkHE053w3UhgNrtSpBw6cFSvfAVTizR8NLPnmeSrOSiK/4jBEAWZZJTV8spbw
         QKORU2OxjaYzpunRymjpODwpv0Sdt+bsrScPR5I7wcD+lhGre/MEvtNYd/dk+7rtvqYk
         VL4PAehNQ+jWEWRXbE2zcQyoW8ncaViOgwSIk8OITuvnBFA9VXXv2I/wb9rwpK0KJZhJ
         vk1grzz9zZ+9/CRUcrXhUkTdg2OYb5+MxqbfliyjZt0lk8t3d7LQ2BTQMDvfkmnStRrg
         AIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TpDsAHqIijoAZ7Gc5TVZwMYult9V8HzwX4d5H1gYnf8=;
        b=jdt1D7PcmI8Mn7jeKkYSxobwg4gXTJ4hXcojul0TN1TOx/DUkFs8zGkHJ3eLIm7lTs
         5oOR7+nqDL4PVGOdKQ7xVTQZBHdqbdyD9M2IGBT47xCXhdJOlZSUFOFHa+8zclEgFfIZ
         drmkRmqdR6h1g4dxbFNyEitOhuFEXd/T7hAcSFWxcFJwCnQygbr5zvtYvNt94u24+Y58
         6gPA8zB1uqgXEUMR1Wvze33PmvlZyRzO5pF+wUEJMMIYg0MjZVVmsyHqVCnPfv51W2XP
         VlrQ3verbioL5RWB9oJVHODfdoUqDHNGI761LiK7mpZDoT9E4ztjivbKbFI/cxdA95Qu
         4mSQ==
X-Gm-Message-State: AMke39kdEBS9C2KGBxwEx3pO72T/UjRwQfrle2OmfgntQlI5/yHvTgfJ13uTT812OPJLAg==
X-Received: by 10.98.34.82 with SMTP id i79mr38499798pfi.120.1487182235386;
        Wed, 15 Feb 2017 10:10:35 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id l25sm8846936pfb.24.2017.02.15.10.10.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 10:10:33 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 03/14] make is_submodule_populated gently
References: <20170215003423.20245-1-sbeller@google.com>
        <20170215003423.20245-4-sbeller@google.com>
Date:   Wed, 15 Feb 2017 10:10:32 -0800
In-Reply-To: <20170215003423.20245-4-sbeller@google.com> (Stefan Beller's
        message of "Tue, 14 Feb 2017 16:34:12 -0800")
Message-ID: <xmqqlgt7495z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> We need the gentle version in a later patch. As we have just one caller,
> migrate the caller.

Ordinarily, we keep the original helper implemented as a thin
wrapper that passes NULL as retun_error_code, which causes it to
die() on error for existing callers.  But because we only have one
caller (and topics in-flight do not add new ones), we do not bother
with that.

The reasoning makes sense, at least to me.

We may want to add a comment about the behaviour upon error for the
helper function?  I see resolve_gitdir_gently() does not do so and
the readers have to follow the callflow down to read_gitfile_gently()
which does have the comment, so perhaps we are OK without any.

Looks good to me.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/grep.c | 2 +-
>  submodule.c    | 4 ++--
>  submodule.h    | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/grep.c b/builtin/grep.c
> index 2c727ef499..b17835aed6 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -616,7 +616,7 @@ static int grep_submodule(struct grep_opt *opt, const unsigned char *sha1,
>  {
>  	if (!is_submodule_initialized(path))
>  		return 0;
> -	if (!is_submodule_populated(path)) {
> +	if (!is_submodule_populated_gently(path, NULL)) {
>  		/*
>  		 * If searching history, check for the presense of the
>  		 * submodule's gitdir before skipping the submodule.
> diff --git a/submodule.c b/submodule.c
> index 3b98766a6b..9bbdd3ce7c 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -237,12 +237,12 @@ int is_submodule_initialized(const char *path)
>  /*
>   * Determine if a submodule has been populated at a given 'path'
>   */
> -int is_submodule_populated(const char *path)
> +int is_submodule_populated_gently(const char *path, int *return_error_code)
>  {
>  	int ret = 0;
>  	char *gitdir = xstrfmt("%s/.git", path);
>  
> -	if (resolve_gitdir(gitdir))
> +	if (resolve_gitdir_gently(gitdir, return_error_code))
>  		ret = 1;
>  
>  	free(gitdir);
> diff --git a/submodule.h b/submodule.h
> index 05ab674f06..689033e538 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -41,7 +41,7 @@ extern int submodule_config(const char *var, const char *value, void *cb);
>  extern void gitmodules_config(void);
>  extern void gitmodules_config_sha1(const unsigned char *commit_sha1);
>  extern int is_submodule_initialized(const char *path);
> -extern int is_submodule_populated(const char *path);
> +extern int is_submodule_populated_gently(const char *path, int *return_error_code);
>  extern int parse_submodule_update_strategy(const char *value,
>  		struct submodule_update_strategy *dst);
>  extern const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
