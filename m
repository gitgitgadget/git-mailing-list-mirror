Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F2D1F403
	for <e@80x24.org>; Sun, 17 Jun 2018 15:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934062AbeFQPib (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Jun 2018 11:38:31 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:22147 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933588AbeFQPia (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jun 2018 11:38:30 -0400
Received: from [192.168.2.240] ([92.22.19.223])
        by smtp.talktalk.net with SMTP
        id UZl5f2WKvoI6LUZl6fSz8V; Sun, 17 Jun 2018 16:38:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1529249909;
        bh=P6j10m2aI1k61EXnhBohiChjYAZENCzz064V76XPyJs=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UaYSzTuSj6Y93mXd98iY15m9XW/Ne+AxgZuhcRWTSvmi559DU5djnXWVx85RS52L9
         2/B0v3CevUOcKd0WOUIYWHdWBuO3yTya+OoxFxjTW2R2+as8z8mse7eq2Ni3USX+S8
         uZGpLpOeJq0OQZSAUXFtg278Vj9wuqkT5EFShe4A=
X-Originating-IP: [92.22.19.223]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=DH/r9e32v+C519lOzZJhbw==:117
 a=DH/r9e32v+C519lOzZJhbw==:17 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8
 a=JSlo6yUi_HLN2E9FAC0A:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 1/7] git-rebase.txt: document incompatible options
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        phillip.wood@dunelm.org.uk
Cc:     johannes.schindelin@gmx.de, gitster@pobox.com
References: <20180607050654.19663-1-newren@gmail.com>
 <20180617055856.22838-1-newren@gmail.com>
 <20180617055856.22838-2-newren@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <13ccb4d9-582b-d26b-f595-59cb0b7037ab@talktalk.net>
Date:   Sun, 17 Jun 2018 16:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180617055856.22838-2-newren@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfD0rj3D1GKOoSPwHntR96/20Stwtia5niTZ0h42VchtUxszOPVNuPU3ADnay7aYTiJ1zVa8AQrwHZvQr3zOUCEB8GVUIW5pS4ct62uobY9DLHNNsjBeF
 O+zilUsBCjLNLZVPahNTei/27m4uuOvHOmW6gucebUH31RfVOA72/RbQKsRmK/1ruOBwQXDm0SQW0KoKwR8KPuTRBUcTu3RxL5CaY4ZDML0hucFgczrCVmyM
 wD8e0Lia313rJKgBVfDBK8kAE4QdB4j/46zakmvIDqHVtAGpd2Rama5XnlFeIP18ghsa8fag5loDkS4WxKKugA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah
On 17/06/18 06:58, Elijah Newren wrote:
> git rebase has many options that only work with one of its three backends.
> It also has a few other pairs of incompatible options.  Document these.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt | 84 ++++++++++++++++++++++++++++++++----
>   1 file changed, 76 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0e20a66e73..adccc15284 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -243,11 +243,15 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>   --keep-empty::
>   	Keep the commits that do not change anything from its
>   	parents in the result.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --allow-empty-message::
>   	By default, rebasing commits with an empty message will fail.
>   	This option overrides that behavior, allowing commits with empty
>   	messages to be rebased.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --skip::
>   	Restart the rebasing process by skipping the current patch.
> @@ -271,6 +275,8 @@ branch on top of the <upstream> branch.  Because of this, when a merge
>   conflict happens, the side reported as 'ours' is the so-far rebased
>   series, starting with <upstream>, and 'theirs' is the working branch.  In
>   other words, the sides are swapped.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -s <strategy>::
>   --strategy=<strategy>::
> @@ -280,8 +286,10 @@ other words, the sides are swapped.
>   +
>   Because 'git rebase' replays each commit from the working branch
>   on top of the <upstream> branch using the given strategy, using
> -the 'ours' strategy simply discards all patches from the <branch>,
> +the 'ours' strategy simply empties all patches from the <branch>,
>   which makes little sense.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -X <strategy-option>::
>   --strategy-option=<strategy-option>::
> @@ -289,6 +297,8 @@ which makes little sense.
>   	This implies `--merge` and, if no strategy has been
>   	specified, `-s recursive`.  Note the reversal of 'ours' and
>   	'theirs' as noted above for the `-m` option.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -S[<keyid>]::
>   --gpg-sign[=<keyid>]::
> @@ -324,6 +334,8 @@ which makes little sense.
>   	and after each change.  When fewer lines of surrounding
>   	context exist they all must match.  By default no context is
>   	ever ignored.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -f::
>   --force-rebase::
> @@ -355,19 +367,22 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   --whitespace=<option>::
>   	These flag are passed to the 'git apply' program
>   	(see linkgit:git-apply[1]) that applies the patch.
> -	Incompatible with the --interactive option.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --committer-date-is-author-date::
>   --ignore-date::
>   	These flags are passed to 'git am' to easily change the dates
>   	of the rebased commits (see linkgit:git-am[1]).
> -	Incompatible with the --interactive option.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --signoff::
>   	Add a Signed-off-by: trailer to all the rebased commits. Note
>   	that if `--interactive` is given then only commits marked to be
> -	picked, edited or reworded will have the trailer added. Incompatible
> -	with the `--preserve-merges` option.
> +	picked, edited or reworded will have the trailer added.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -i::
>   --interactive::
> @@ -378,6 +393,8 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
>   The commit list format can be changed by setting the configuration option
>   rebase.instructionFormat.  A customized instruction format will automatically
>   have the long commit hash prepended to the format.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -r::
>   --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
> @@ -404,7 +421,7 @@ It is currently only possible to recreate the merge commits using the
>   `recursive` merge strategy; Different merge strategies can be used only via
>   explicit `exec git merge -s <strategy> [...]` commands.
>   +
> -See also REBASING MERGES below.
> +See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
>   
>   -p::
>   --preserve-merges::
> @@ -415,6 +432,8 @@ See also REBASING MERGES below.
>   This uses the `--interactive` machinery internally, but combining it
>   with the `--interactive` option explicitly is generally not a good
>   idea unless you know what you are doing (see BUGS below).
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   -x <cmd>::
>   --exec <cmd>::
> @@ -437,6 +456,8 @@ squash/fixup series.
>   +
>   This uses the `--interactive` machinery internally, but it can be run
>   without an explicit `--interactive`.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --root::
>   	Rebase all commits reachable from <branch>, instead of
> @@ -447,6 +468,8 @@ without an explicit `--interactive`.
>   	When used together with both --onto and --preserve-merges,
>   	'all' root commits will be rewritten to have <newbase> as parent
>   	instead.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --autosquash::
>   --no-autosquash::
> @@ -461,11 +484,11 @@ without an explicit `--interactive`.
>   	too.  The recommended way to create fixup/squash commits is by using
>   	the `--fixup`/`--squash` options of linkgit:git-commit[1].
>   +
> -This option is only valid when the `--interactive` option is used.
> -+
>   If the `--autosquash` option is enabled by default using the
>   configuration variable `rebase.autoSquash`, this option can be
>   used to override and disable this setting.
> ++
> +See also INCOMPATIBLE OPTIONS below.
>   
>   --autostash::
>   --no-autostash::
> @@ -487,6 +510,51 @@ recreates the topic branch with fresh commits so it can be remerged
>   successfully without needing to "revert the reversion" (see the
>   link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details).
>   
> +INCOMPATIBLE OPTIONS
> +--------------------
> +
> +git-rebase has many flags that are incompatible with each other,
> +predominantly due to the fact that it has three different underlying
> +implementations:
> +
> + * one based on linkgit:git-am[1] (the default)
> + * one based on linkgit:git-merge-recursive[1] (merge backend)
> + * one based on linkgit:git-cherry-pick[1] (interactive backend)
> +
> +Flags only understood by the am backend:
> +
> + * --committer-date-is-author-date
> + * --ignore-date
> + * --whitespace
> + * --ignore-whitespace
> + * -C
> +
> +Flags understood by both merge and interactive backends:
> +
> + * --merge
> + * --strategy
> + * --strategy-option
> + * --allow-empty-message
> +
> +Flags only understood by the interactive backend:
> +
> + * --[no-]autosquash
> + * --rebase-merges
> + * --preserve-merges
> + * --interactive
> + * --exec
> + * --keep-empty
> + * --autosquash
> + * --edit-todo
> + * --root + --onto
> +
> +Other incompatible flag pairs:
> +
> + * --preserve-merges && --interactive
> + * --preserve-merges && --signoff
> + * --preserve-merges && --rebase-merges
> + * --rebase-merges && --strategy

Does --rebase-merges support --strategy-options?

> +
>   include::merge-strategies.txt[]
>   
>   NOTES
> 
This is a great step forward. In the long run it would be nice not to 
have to mention the backends. Once git-rebase--merge.sh is gone, the 
situation is simpler and it would be nice to reword this to say 
something like
   The --committer-date-is-author-date, --ignore-date, --whitespace,
   --ignore-whitespace and -C options are incompatible with the following
   --exec ... Also note that --rebase-merges is incompatible with
   --strategy; and --preserve-merges is incompatible with --interactive,
   --signoff, --rebase-merges.
rather than talking about am options etc.

Best Wishes

Phillip
