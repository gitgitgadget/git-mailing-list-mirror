Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E642C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB16920C09
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 00:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uKm28oG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbgFXA6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:58:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55608 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387586AbgFXA6f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 20:58:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE9916A4B4;
        Tue, 23 Jun 2020 20:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fV8EucQ/Q4WBwWJNkMB/Jj6TNc8=; b=uKm28o
        G6pknNoVxhxw70a/4gyc60ZPBHTrN552pDao63Fw/ypqu0iO7FLBj0jLfHc+OVNM
        yq03YC6GytDFiPog8dg7mG/SATmWyAy0E+nptt7JrVr8qADlTnHsSwSQLgMIqezk
        eSbKh/y3M1csmyqIj5e5c5tjCuUo758nHPvkg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=haHXQvhtNKqsaX6jNqZufEEvDCGGXKnI
        Hu+m0xe2BnAvh8YjGR5eH0xUMbqrxKU7tOn6Inu04PGIC5JeJejejn2rOk1nWWIS
        896pfjnvzwdaM9/zEqxp58Q/AC3DB2i9fb7NSi9I/MB6vem6oR2ZdALI2QOi5BpU
        NFloS0ETHvE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4B6F6A4B3;
        Tue, 23 Jun 2020 20:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 411AD6A4B2;
        Tue, 23 Jun 2020 20:58:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        peff@peff.net, sandals@crustytoothpaste.net,
        Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Denton Liu <liu.denton@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 4/8] init: allow specifying the initial branch name for the new repository
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
        <e8a6587c1a783476413277296c6ce3db74e217e6.1592951611.git.gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 17:58:28 -0700
In-Reply-To: <e8a6587c1a783476413277296c6ce3db74e217e6.1592951611.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 23 Jun 2020
        22:33:26 +0000")
Message-ID: <xmqqmu4t9t57.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D144E642-B5B5-11EA-8835-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

>  [verse]
>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>  	  [--separate-git-dir <git dir>] [--object-format=<format]

Completely offtopic.  We lack the closing ket> here.

> +	  [-b <branch-name> | --initial-branch=<branch-name>]
>  	  [--shared[=<permissions>]] [directory]
>  
>  
> @@ -67,6 +68,12 @@ repository.
>  +
>  If this is reinitialization, the repository will be moved to the specified path.
>  
> +-b <branch-name::
> +--initial-branch=<branch-name>::
> +
> +Use the specified name for the initial branch in the newly created repository.
> +If not specified, fall back to the default name: `master`.

OK.

> diff --git a/builtin/clone.c b/builtin/clone.c
> index 2a8e3aaaed..b751bdf13e 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -1111,7 +1111,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
> +	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
> +		INIT_DB_QUIET);
>  
>  	if (real_git_dir)
>  		git_dir = real_git_dir;
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 0b7222e718..a898153901 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -203,6 +203,7 @@ void initialize_repository_version(int hash_algo)
>  
>  static int create_default_files(const char *template_path,
>  				const char *original_git_dir,
> +				const char *initial_branch,
>  				const struct repository_format *fmt)
>  {
>  	struct stat st1;
> @@ -258,16 +259,29 @@ static int create_default_files(const char *template_path,
>  		die("failed to set up refs db: %s", err.buf);
>  
>  	/*
> -	 * Create the default symlink from ".git/HEAD" to the "master"
> -	 * branch, if it does not exist yet.
> +	 * Create the default symlink from ".git/HEAD" to the default
> +	 * branch name, if it does not exist yet.
>  	 */

To the caller of this helper, it may be "the default", but as far as
this helper is concerned, it is not "default" but the initial branch
that was given by the caller.  How about...

	/*
	 * Point the initial branch with HEAD symref, if HEAD does
	 * not exist yet.
	 */

... to modernize the reference to symlink and replace it with
symref?

> +		if (!initial_branch)
> +			initial_branch = "master";
> +
> +		ref = xstrfmt("refs/heads/%s", initial_branch);
> +		if (check_refname_format(ref, 0) < 0)
> +			die(_("invalid initial branch name: '%s'"),
> +			    initial_branch);

Good.  We make sure to prefix with "refs/heads/" so the callers
cannot abuse us to point HEAD outside the local branches.

> +		if (create_symref("HEAD", ref, NULL) < 0)
>  			exit(1);
> -	}
> +		free(ref);
> +	} else if (initial_branch)
> +		warning(_("re-init: ignoring --initial-branch=%s"),
> +			initial_branch);

Somehow the error checking convention feels uneven in this API.  It
is a warning-worthy offense for the caller to give initial_branch
when we are re-initializing, but it is not an error for the caller
not to supply the initial branch name on the other side of if/else.
Worse yet, this helper function even knows the command line option
name that resulted in the parameter coming to it.

That unevenness ultimately comes from the fact that the caller does
not know if we are dealing with a repository that already has HEAD
before calling, but at least we should be able to tell the caller
if we initialized or not with our return value and allow the caller
to issue this warning---that way we can lose the warning from here
and get rid of the uneven feeling.  Oh, and ...

> @@ -383,7 +397,8 @@ static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
>  }
>  
>  int init_db(const char *git_dir, const char *real_git_dir,
> -	    const char *template_dir, int hash, unsigned int flags)
> +	    const char *template_dir, int hash, const char *initial_branch,
> +	    unsigned int flags)
>  {
>  	int reinit;
>  	int exist_ok = flags & INIT_DB_EXIST_OK;
> @@ -425,7 +440,8 @@ int init_db(const char *git_dir, const char *real_git_dir,
>  
>  	validate_hash_algorithm(&repo_fmt, hash);
>  
> -	reinit = create_default_files(template_dir, original_git_dir, &repo_fmt);
> +	reinit = create_default_files(template_dir, original_git_dir,
> +				      initial_branch, &repo_fmt);

... we are telling the caller if we are in reinit situation, so we
can afford to do exactly that.  

	reinit = create_default_files...
 	if (reinit && initial_branch)
		warning(_("re-init: ignored --initial-branch"));

That's much better ;-)

Other than that, looks good to me.

Thanks.

