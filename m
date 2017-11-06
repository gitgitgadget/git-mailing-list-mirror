Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74BA220281
	for <e@80x24.org>; Mon,  6 Nov 2017 02:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdKFCHB (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 21:07:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54740 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751337AbdKFCHA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 21:07:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 536D6B4494;
        Sun,  5 Nov 2017 21:06:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fq2tJ4lJfnI+x7UX3st8D798Qew=; b=A2qmRG
        jtUAbBQw5pTdAoqxxiaAjxnzgt3ZJUbmG/koYOC/4SVijSlFK+iRoXbUrLdkD8v6
        Be25luQF0HvLwzTC/qEoo2s8HxjsCVK5ZCBV0yaLu8NGunlHK8FA0xKHotmhjJAW
        /PeY5gUKCfygk0m/Eeu2b7XPM7aow8gtAssQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a8I6qhGykTs9OTf6tPIjl9T8+B0gZtdK
        54/FaXt5SkOLPBzlPssuL3GUtPglpdnddZeJfmHq1yJtJccN7cwTTGZxJ8R0cuMT
        IkMsD01cCsn2DuQZZ0uDC5t0zoGwSlEnRzrIe6cGzaM4aa6p30eZGaT7vNcgSJAK
        4OAQRxROeOg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BFB1B4493;
        Sun,  5 Nov 2017 21:06:59 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD6BDB4492;
        Sun,  5 Nov 2017 21:06:58 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git@vger.kernel.org,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Subject: Re: [RFC PATCH v3 2/4] branch: re-order function arguments to group related arguments
References: <20170925082024.2691-1-kaarticsivaraam91196@gmail.com>
        <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
        <20171102065407.25404-3-kaartic.sivaraam@gmail.com>
Date:   Mon, 06 Nov 2017 11:06:57 +0900
In-Reply-To: <20171102065407.25404-3-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Thu, 2 Nov 2017 12:24:05 +0530")
Message-ID: <xmqqbmkgjh32.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2BBF8E66-C297-11E7-B6AD-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> From: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
>
> The ad-hoc patches to add new arguments to a function when needed
> resulted in the related arguments not being close to each other.
> This misleads the person reading the code to believe that there isn't
> much relation between those arguments while it's not the case.

I do not get what this wants to say.  "I am sending this ad-hoc
patch that scrambles the order of parameters for no real reason" is
certainly not how you are selling this step.

> So, re-order the arguments to keep the related arguments close to each
> other.

This sentence (without "So,", obviously, because I do not get the
previous paragraph) I do understand and agree with as a goal.

I think the only two things that should be kept together are "force"
and "clobber_head_ok" because the previous 1/4 changed the meaning
of "clobber_head" to "it is OK if I am renaming the currently
checked-out branch", i.e. closer to what "force" means.

I certainly would not mind the order used in the result of this
patch (in other words, if somebody posted a patch to add
create_branch() function to the codebase that lacked it, with its
parameters listed in the order this patch uses, I wouldn't
complain), but it would have equally been OK if "reflog" and "force"
were swapped without making any other change this patch makes.

I dunno.

> Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
> ---
>  branch.c           |  4 ++--
>  branch.h           | 14 +++++++-------
>  builtin/branch.c   |  4 ++--
>  builtin/checkout.c |  6 +++---
>  4 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index ea6e2b359..7c8093041 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -244,8 +244,8 @@ N_("\n"
>  "\"git push -u\" to set the upstream config as you push.");
>  
>  void create_branch(const char *name, const char *start_name,
> -		   int force, int reflog, int clobber_head_ok,
> -		   int quiet, enum branch_track track)
> +		   enum branch_track track, int force, int clobber_head_ok,
> +		   int reflog, int quiet)
>  {
>  	struct commit *commit;
>  	struct object_id oid;
> diff --git a/branch.h b/branch.h
> index 1512b78d1..85052628b 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -11,21 +11,21 @@
>   *   - start_name is the name of the existing branch that the new branch should
>   *     start from
>   *
> - *   - force enables overwriting an existing (non-head) branch
> + *   - track causes the new branch to be configured to merge the remote branch
> + *     that start_name is a tracking branch for (if any).
>   *
> - *   - reflog creates a reflog for the branch
> + *   - force enables overwriting an existing (non-head) branch
>   *
>   *   - clobber_head_ok allows the currently checked out (hence existing)
>   *     branch to be overwritten; without 'force', it has no effect.
>   *
> - *   - quiet suppresses tracking information
> + *   - reflog creates a reflog for the branch
>   *
> - *   - track causes the new branch to be configured to merge the remote branch
> - *     that start_name is a tracking branch for (if any).
> + *   - quiet suppresses tracking information
>   */
>  void create_branch(const char *name, const char *start_name,
> -		   int force, int reflog,
> -		   int clobber_head_ok, int quiet, enum branch_track track);
> +		   enum branch_track track, int force, int clobber_head_ok,
> +		   int reflog, int quiet);
>  
>  /*
>   * Check if 'name' can be a valid name for a branch; die otherwise.
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 5be40b384..df06ac968 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -766,7 +766,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  		 * create_branch takes care of setting up the tracking
>  		 * info and making sure new_upstream is correct
>  		 */
> -		create_branch(branch->name, new_upstream, 0, 0, 0, quiet, BRANCH_TRACK_OVERRIDE);
> +		create_branch(branch->name, new_upstream, BRANCH_TRACK_OVERRIDE, 0, 0, 0, quiet);
>  	} else if (unset_upstream) {
>  		struct branch *branch = branch_get(argv[0]);
>  		struct strbuf buf = STRBUF_INIT;
> @@ -806,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>  			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead."));
>  
>  		create_branch(argv[0], (argc == 2) ? argv[1] : head,
> -			      force, reflog, 0, quiet, track);
> +			      track, force, 0, reflog, quiet);
>  
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 8546d630b..5c34a9a0d 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -639,11 +639,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  		}
>  		else
>  			create_branch(opts->new_branch, new->name,
> +				      opts->track,
> +				      opts->new_branch_force ? 1 : 0,
>  				      opts->new_branch_force ? 1 : 0,
>  				      opts->new_branch_log,
> -				      opts->new_branch_force ? 1 : 0,
> -				      opts->quiet,
> -				      opts->track);
> +				      opts->quiet);
>  		new->name = opts->new_branch;
>  		setup_branch_path(new);
>  	}
