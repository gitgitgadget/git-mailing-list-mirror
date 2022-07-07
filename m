Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80947C433EF
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 23:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236960AbiGGXnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbiGGXnU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 19:43:20 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78B9606A6
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 16:43:18 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D0CD147852;
        Thu,  7 Jul 2022 19:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DDhoDUuDQT6SkfXEKvxXp+tKHg5duP4lcVl9cL
        vBHEs=; b=sj2fmnNElA/+nlPf/pAPisiCRyhA/Xl345dbc4IN00yF4FRHIz6dPN
        w/pDMdbZOqB+tmWP8rgjGuOs9R4XAcwEu3vFLcB7WMuOn2y38nzcjfwQQwhOaJQV
        WCeTDx1oBnmtkSeP5fr7lQINZa17gR7JJjd4dLMM0bDyKTyF5Vp3A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6108A147851;
        Thu,  7 Jul 2022 19:43:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA9BE147850;
        Thu,  7 Jul 2022 19:43:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v7 1/5] Documentation/git-config.txt: add SCOPES section
References: <pull.1261.v6.git.git.1656612839.gitgitgadget@gmail.com>
        <pull.1261.v7.git.git.1657234914.gitgitgadget@gmail.com>
        <5c58db3bb2189f3b4193a682aa3b43f3bfa95796.1657234914.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Jul 2022 16:43:15 -0700
In-Reply-To: <5c58db3bb2189f3b4193a682aa3b43f3bfa95796.1657234914.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Thu, 07 Jul 2022 23:01:50
        +0000")
Message-ID: <xmqq4jzsxze4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92FB555E-FE4E-11EC-8E71-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> In a subsequent commit, we will introduce "protected configuration",
> which is easiest to describe in terms of configuration scopes (i.e. it's
> the union of the 'system', 'global', and 'command' scopes). This
> description is fine for ML discussions, but it's inadequate for end
> users because we don't provide a good description of "configuration
> scopes" in the public docs.
>
> 145d59f482 (config: add '--show-scope' to print the scope of a config
> value, 2020-02-10) introduced the word "scope" to our public docs, but
> that only enumerates the scopes and assumes the user can figure out
> those values mean.

Probably: "figure out those values mean" -> "figure out what those
values mean"

> Add a SCOPES section to Documentation/git-config.txt that describes the
> configuration scopes, their corresponding CLI options, and mentions that
> some configuration options are only respected in certain scopes. Then,
> use the word "scope" to simplify the FILES section and change some
> confusing wording.
>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  Documentation/git-config.txt | 65 ++++++++++++++++++++++++++++--------
>  1 file changed, 51 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 9376e39aef2..c4ce61a0493 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -297,8 +297,8 @@ The default is to use a pager.
>  FILES
>  -----
>  
> -If not set explicitly with `--file`, there are four files where
> -'git config' will search for configuration options:
> +By default, 'git config' will read configuration options from multiple
> +files:
>  
>  $(prefix)/etc/gitconfig::
>  	System-wide configuration file.
> @@ -322,27 +322,64 @@ $GIT_DIR/config.worktree::
>  	This is optional and is only searched when
>  	`extensions.worktreeConfig` is present in $GIT_DIR/config.
>  
> -If no further options are given, all reading options will read all of these
> -files that are available. If the global or the system-wide configuration
> -file are not available they will be ignored. If the repository configuration
> -file is not available or readable, 'git config' will exit with a non-zero
> -error code. However, in neither case will an error message be issued.
> +You may also provide additional configuration parameters when running any
> +git command by using the `-c` option. See linkgit:git[1] for details.

Listing "-c" as another one in addition to these files is probably a
good simplification, instead of "-c override others" in the original,
as we would need to say "more specific ones override less specific
ones" anyway.

> +Options will be read from all of these files that are available. If the
> +global or the system-wide configuration file are not available they will be
> +ignored. If the repository configuration file is not available or readable,
> +'git config' will exit with a non-zero error code. Note that neither case
> +produces an error message.

Problem inherited from the original, but I suspect that rephrasing
"not available" to "missing" (or "does not exist") may make it
easier to follow.  Also, "global" in the preceding description is
explained as one of the user-specific configuration files, so it may
be better to avoid it, e.g.

	If the user-specific or the system-wide configuration files
	are missing, they will be ignored.  If the repository
	configuration file is missing or unreadable, ...

Alternatively, we may want to tighten the description of
$XDG_CONFIG_HOME/git/config and ~/.gitconfig a bit better,
e.g. something along the lines of ...

	$XDG_CONFIG_HOME/git/config::
	$HOME/.gitconfig::
		User-specific configuration file.  When the
		XDG_CONFIG_HOME environment variable is not set or
		empty, $HOME/.config/ is used as $XDG_CONFIG_HOME.
	+
	These are often called the "global" configuration file.
	When either or both of them exist(s), both files are read.

Note that I deliberately omitted the mehtion that our $XDG support
may be too recent and $HOME/.gitconfig may be preferred for
portability.  It came from 21cf3227 (config: read (but not write)
from $XDG_CONFIG_HOME/git/config file, 2012-06-22) but sufficient
number of years have passed.

Also note that I originally wrote the following immediately after
the above

	+
	When writing to the "--global" scope (see below),
	$XDG_CONFIG_HOME/git/config is used if it exists; otherwise
	$HOME/.gitconfig is used.

but decided to discard it, since the OPTIONS -> "--global" covers
it well enough.

With a tightening of the definition of what "global" is,, we can
rephrase "If the global or the system configuration files are
missing...".

> +You can limit which configuration sources are read from or written to by
> +specifying the path of a file with the `--file` option, or by specifying a
> +configuration scope with `--system`, `--global`, `--local`, or `--worktree`.
> +For more, see <<OPTIONS>> above.
> +
> +SCOPES
> +------
> +
> +Each configuration source falls within a configuration scope. The scopes
> +are:
> +
> +system::
> +	$(prefix)/etc/gitconfig
> +
> +global::
> +	$XDG_CONFIG_HOME/git/config
> ++
> +~/.gitconfig
> +
> +local::
> +	$GIT_DIR/config
> +
> +worktree::
> +	$GIT_DIR/config.worktree
> +
> +command::
> +	environment variables

We'd need to tighten this a bit, like:

	GIT_CONFIG_{COUNT,KEY,VALUE} environment varialbes (see below)

GIT_CONFIG_GLOBAL or GIT_CONFIG_SYSTEM environment varialbes and
others are listed in the ENVIRONMENT section that comes after this
section, but you do not want the readers to be confused into
thinking that we'd give them more precedence over others.

> ++
> +the `-c` option

> +With the exception of 'command', each scope corresponds to a command line
> +option: `--system`, `--global`, `--local`, `--worktree`.
> +
> +When reading options, specifying a scope will only read options from the
> +files within that scope. When writing options, specifying a scope will write
> +to the files within that scope (instead of the repository specific
> +configuration file). See <<OPTIONS>> above for a complete description.
>  
> +Most configuration options are respected regardless of the scope it is
> +defined in, but some options are only respected in certain scopes. See the
> +respective option's documentation for the full details.
>  
>  ENVIRONMENT
>  -----------

Overall it was a pleasant read.  Thanks, will queue.
