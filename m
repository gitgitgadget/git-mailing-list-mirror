Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE6C433F5
	for <git@archiver.kernel.org>; Fri, 27 May 2022 23:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352505AbiE0XaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 May 2022 19:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiE0X3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 May 2022 19:29:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1701D80236
        for <git@vger.kernel.org>; Fri, 27 May 2022 16:29:53 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2AC3719CD75;
        Fri, 27 May 2022 19:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W/3Sku+0bllnHi44LTZocbuT/V5RVHCu59YOog
        qyhlA=; b=QZDYtqSO2XlS4E06dcSF1CKQVaBw37c9wWPju3ujQWW0pBxWZAthnL
        7nuLmawxrBLr4dyivzv91J8s0BQ566n3UV+3O9qqEGVOO+TIha7/EgVWXaIVEIQW
        PDlwt/e+FRHrovk5Gen6v0K9oiI3BmrwAELTiyR220hdLjAEVsQPA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 226F019CD74;
        Fri, 27 May 2022 19:29:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A084819CD73;
        Fri, 27 May 2022 19:29:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 1/5] Documentation: define protected configuration
References: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
        <pull.1261.v3.git.git.1653685761.gitgitgadget@gmail.com>
        <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
Date:   Fri, 27 May 2022 16:29:46 -0700
In-Reply-To: <575676c760d9a2ce4a59d50e93aa0f45d54620ab.1653685761.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Fri, 27 May 2022 21:09:17
        +0000")
Message-ID: <xmqqh75a1rmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5BD021A-DE14-11EC-A894-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  safe.directory::
> -	These config entries specify Git-tracked directories that are
> -	considered safe even if they are owned by someone other than the
> -	current user. By default, Git will refuse to even parse a Git
> -	config of a repository owned by someone else, let alone run its
> -	hooks, and this config setting allows users to specify exceptions,
> -	e.g. for intentionally shared repositories (see the `--shared`
> -	option in linkgit:git-init[1]).
> +	'(Protected config only) ' These config entries specify

What's the SP in "only) '" doing?

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index aa2f41f5e70..a669983abd6 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -483,6 +483,24 @@ exclude;;
>  	head ref. If the remote <<def_head,head>> is not an
>  	ancestor to the local head, the push fails.
>  
> +[[def_protected_config]]protected configuration::
> +	Protected configuration is configuration that Git considers more
> +	trustworthy because it is unlikely to be tampered with by an
> +	attacker. For security reasons, some configuration variables are
> +	only respected when they are defined in protected configuration.
> ++
> +Protected configuration includes:
> ++
> +- system-level config, e.g. `/etc/git/config`
> +- global config, e.g. `$XDG_CONFIG_HOME/git/config` and
> +  `$HOME/.gitconfig`
> +Protected configuration excludes:
> ++
> +- repository config, e.g. `$GIT_DIR/config` and
> +  `$GIT_DIR/config.worktree`
> +- the command line option `-c` and its equivalent environment variables

The description is a bit unclear what "protected configuration"
refers.

If it is the scopes (as in "git config --show-scope") Git can trust
more, in other words, a statement like this

    safe.directory is honored only when it comes from a protected
    configuration.

is what you want to make easier to write by introducing a new
phrase, perhaps use the word "scope" for more consistency?  E.g.

    Only safe.directory that is defined in a trusted scope is
    honored.

I dunno.

It would make sense to give a rationale behind the seemingly
arbitrary choice of what is and what is not "protected".  Not
necessarily in the glossary, but in the proposed log message of the
commit that makes the decision.  The rationale must help readers to
be able to answer the following questions.

 - The system level is "protected" because?  Is it because we do not
   even try to protect ourselves from those who can write anywhere
   in /etc/ or other system directories?

 - The per-user config is "protected" because?  Is it because our
   primary interest in "protection" is to protect individual users
   from landmines laid in the filesystem by other users, and those
   who can already write into $HOME are not we try to guard against?

 - The per-repo config is not "protected" (i.e. "trusted"), because?
   If we are not honoring a configuration in the repository, why are
   we working in that repository in the first place?

 - The per invocation config is not "protected" (i.e. "trusted"),
   because?  If we cannot trusting our own command line, what
   prevents an attacker from mucking with our command line to say
   "sudo whatever" using the same attack vector?

Thanks.
