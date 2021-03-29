Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88504C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF1461990
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 23:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhC2XyP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 19:54:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56287 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC2Xx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 19:53:56 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D09D4B97D0;
        Mon, 29 Mar 2021 19:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xDu+vxPZx6rN14MRRoF9hQxsUdw=; b=JTrSZg
        OtxgiUGNUrrJ3739vUTQCGqX15KkfsHzlL98zyxXuG/Wn883O+5lQ9EMgo+JklkV
        ftMIAQkGUiJHjaSKZdPSRsqtttd8nvdltjSFABsII2gsTG0hlpp5nGI51KTa8w8f
        lQ7Ap0ls2dvQN5/w+Aa5QPf5zJkZKW4x6puBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aSR1Hf5nlTe9KbvxtHKk/9blB0WxqWuV
        JoDcxMM2x2c/5RtftuySHu1LebOf7u15WK7O8COQpuU/Z4wzzrstLQuZM0C5fLY5
        70lbc+SlYV4I936Lo8Fr/+zn3Pm4d5FpCZFkUtU40l0MFdG4GCi+bygKEmHMx6qc
        hIK/5yt+weg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6BFFB97CF;
        Mon, 29 Mar 2021 19:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E0E7B97CE;
        Mon, 29 Mar 2021 19:53:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Dmitry Torilov via GitGitGadget" <gitgitgadget@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Dmitry Torilov <d.torilov@gmail.com>
Subject: Re: [PATCH] chore: use prefix from startup_info
References: <pull.922.git.1617057233885.gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 16:53:54 -0700
In-Reply-To: <pull.922.git.1617057233885.gitgitgadget@gmail.com> (Dmitry
        Torilov via GitGitGadget's message of "Mon, 29 Mar 2021 22:33:53
        +0000")
Message-ID: <xmqqtuotfre5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0576F760-90EA-11EB-8AD1-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dmitry, welcome to git development community.

Torsten, you are Cc'ed because I may have spotted a possible bug in
your recent 5c327502 (MacOS: precompose_argv_prefix(), 2021-02-03).

"Dmitry Torilov via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH] chore: use prefix from startup_info

s/chore/git.c:/ perhaps.  Otherwise the subject is perfect, which is
rare for new contributors.

> From: Dmitry Torilov <d.torilov@gmail.com>
>
> trace.h: update trace_repo_setup signature
> trace.c: update trace_repo_setup implementation
> git.c: update trace_repo_setup usage

Unlike some GNU projects, we do not write summary of what the patch
does to the code in the log message.  What we do is to explain what
problem the current codebase has, why it is a problem worth fixing,
and justify why the approach the patch chose to solve the problem
is a good one.  See Documentation/SubmittingPatches[[describe-changes]]
and "git log --no-merges origin/master" for recent examples.

> diff --git a/git.c b/git.c
> index 9bc077a025cb..310cf54e08f6 100644
> --- a/git.c
> +++ b/git.c
> @@ -424,6 +424,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  			prefix = setup_git_directory_gently(&nongit_ok);
>  		}
>  		prefix = precompose_argv_prefix(argc, argv, prefix);
> +		startup_info->prefix = prefix;
>  		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
>  		    !(p->option & DELAY_PAGER_CONFIG))
>  			use_pager = check_pager_config(p->cmd);
> @@ -432,7 +433,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>  
>  		if ((p->option & (RUN_SETUP | RUN_SETUP_GENTLY)) &&
>  		    startup_info->have_repository) /* get_git_dir() may set up repo, avoid that */
> -			trace_repo_setup(prefix);
> +			trace_repo_setup();
>  	}

This turns out to be the ONLY place that trace_repo_setup() is
called, and the value of prefix here comes from the returned value
from precompose_argv_prefix() we saw in the previous hunk.  So as
far as trace_repo_setup() is concerned, taken together with ...

>  	commit_pager_choice();
>  
> diff --git a/trace.c b/trace.c
> index f726686fd92f..4c6414683414 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -367,9 +367,9 @@ static const char *quote_crnl(const char *path)
>  	return new_path.buf;
>  }
>  
> -/* FIXME: move prefix to startup_info struct and get rid of this arg */
> -void trace_repo_setup(const char *prefix)

What is curious is that the caller in git.c this patch changed was
the only caller back when this FIXME comment was written.  It is
unclear why the original commit a9ca8a85 (builtins: print setup info
if repo is found, 2010-11-26) left it unfixed.

> +void trace_repo_setup(void)
>  {
> +	const char *prefix = startup_info->prefix;

... this change, the patch is correct.

What is not so clear is if the users of the startup_info->prefix may
be affected by this change, and if so, does this change introduce a
bug to them.

We assign to the .prefix member in either setup_git_directory()
called by the other side of if/else before the precontext of the
first hunk of this patch, or setup_git_directory_gently() we see in
the precontext of that hunk.  

But then we call precompose_argv_prefix() to munge the prefix value,
and reassign it to the field.  All the existing users of the
startup_info->prefix member has been relying on the fact that it is
the value before "precompose".  With this patch, they see the value
after "precompose".  I would understand it better if you didn't add
a new assignment to run_builtin().

Torsten, I _think_ this change actually fixes the bug (or sweeps it
under the rug) in 5c327502 (MacOS: precompose_argv_prefix(),
2021-02-03), where we wanted to precompose not just the argv[] but
the prefix on macOS.  5c327502 changed the prefix we pass around in
the callchain as parameter correctly, but as we can see here, a copy
w/o the precomposition is left in startup_info->prefix to confuse
codepath that use it (instead of the third parameter given to
cmd_foo(ac, av, prefix)).

Perhaps the "precompose" call should be moved from git.c to the
place just before startup_info->prefix is assigned to in
setup_git_directory_gently(), perhaps like the attached patch,
to cover this codepath.  I didn't looked at other calls to the
precompopse added by 5c327502, but I suspect there might need
similar adjustments.

Thanks.


 git.c   | 2 +-
 setup.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git c/git.c w/git.c
index 9bc077a025..4bd199cc84 100644
--- c/git.c
+++ w/git.c
@@ -423,7 +423,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 			int nongit_ok;
 			prefix = setup_git_directory_gently(&nongit_ok);
 		}
-		prefix = precompose_argv_prefix(argc, argv, prefix);
+		prefix = precompose_argv_prefix(argc, argv, NULL);
 		if (use_pager == -1 && p->option & (RUN_SETUP | RUN_SETUP_GENTLY) &&
 		    !(p->option & DELAY_PAGER_CONFIG))
 			use_pager = check_pager_config(p->cmd);
diff --git c/setup.c w/setup.c
index c04cd25a30..2f6a1f794a 100644
--- c/setup.c
+++ w/setup.c
@@ -1264,6 +1264,13 @@ const char *setup_git_directory_gently(int *nongit_ok)
 		BUG("unhandled setup_git_directory_1() result");
 	}
 
+	/*
+	 * on macOS, prefix derived from the getcwd() may need to be
+	 * normalized into precomposed form.
+	 */
+	if (prefix)
+		prefix = precompose_string_if_needed(prefix);
+
 	/*
 	 * At this point, nongit_ok is stable. If it is non-NULL and points
 	 * to a non-zero value, then this means that we haven't found a

