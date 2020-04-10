Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE25DC2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0522078E
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 20:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p8PPww9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJUG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:06:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59362 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJUG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 16:06:27 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73678C4C8C;
        Fri, 10 Apr 2020 16:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=X/ED3dDDjyxdLnNn2mr5T+Osynk=; b=p8PPww
        9PCejuBF2NusSE5rsbZifOxy0DMxjLakub/jyVsQ+efgpU361DJ0m5aHt0bVfs9Q
        jHysP8KdFJXyAiyo8EO7xdW1f/Z2Hj2MrQT4AKlDznE8ThEdxSm+960K1Hm/kNNY
        bIALYr3G8lozI0eKDZ9Sy79rB+b5WVWxtrOL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KcBSb48Q1NXXeY2oMR/z2Zu6xycGivEu
        +LCpECKQrUzSQBunRWTfoO9LAGlwwfiLMCEmY5duBf6LM4J/xFnpud47+YZHxYXK
        NtpqARi6FpOm9siRVJJwWjquQJIVGK3BzVlquDbjjdOmskBMRmJpZ3DNAzOHat+y
        /6IEEo2DkUs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6AFE1C4C8B;
        Fri, 10 Apr 2020 16:06:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B75ADC4C8A;
        Fri, 10 Apr 2020 16:06:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        philipoakley@iee.email, sandals@crustytoothpaste.net,
        Johannes.Schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3] revision: --show-pulls adds helpful merges
References: <pull.599.v2.git.1586390501128.gitgitgadget@gmail.com>
        <pull.599.v3.git.1586521183873.gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 13:06:19 -0700
In-Reply-To: <pull.599.v3.git.1586521183873.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Fri, 10 Apr 2020 12:19:43
        +0000")
Message-ID: <xmqq369bjebo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BEE34022-7B66-11EA-935D-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>   A----C1----C2--- ... ---Cn----M------P1---P2--- ... ---Pn
>    \     \     \            \  /      /    /            /
>     \     \__.. \            \/ ..__T1    /           Tn
>      \           \__..       /\     ..__T2           /
>       \_____________________B  \____________________/
>
> If the commits T1, T2, ... Tn did not change the file, then all of
> P1 through Pn will be TREESAME to their first parent, but not
> TREESAME to their second. This means that all of those merge commits
> appear in the --full-history view, with edges that immediately
> collapse into the lower history without introducing interesting
> single-parent commits.
>
> The --simplify-merges option was introduced to remove these extra
> merge commits. By noticing that the rewritten parents are reachable
> from their first parents, those edges can be simplified away. Finally,
> the commits now look like single-parent commits that are TREESAME to
> their "only" parent. Thus, they are removed and this issue does not
> cause issues anymore. However, this also ends up removing the commit
> M from the history view! Even worse, the --simplify-merges option
> requires walking the entire history before returning a single result.

True.  It is not advisable to use --simplify-merges unless you are
limiting the history at the bottom for that reason.

> In some sense, users are asking for the "first" merge commit to
> bring in the change to their branch. As long as the parent order is
> consistent, this can be handled with the following rule:
>
>   Include a merge commit if it is not TREESAME to its first
>   parent, but is TREESAME to a later parent.

"but is" -> "even if it is" would make it a bit more accurate, I
would think.  Normally, such a merge that is treesame to some side
branch is omitted from the output, but the rule wants it to be shown
even if all the changes were brought in from one single parent.

> Update Documentation/rev-list-options.txt with significant details
> around this option. This requires updating the example in the
> History Simplification section to demonstrate some of the problems
> with TREESAME second parents.

Good.

> diff --git a/revision.c b/revision.c
> index 8136929e236..f89dd6caa55 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -870,7 +870,19 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  			}
>  			parent->next = NULL;
>  			commit->parents = parent;
> -			commit->object.flags |= TREESAME;
> +
> +			/*
> +			 * A merge commit is a "diversion" if it is not
> +			 * TREESAME to its first parent but is TREESAME
> +			 * to a later parent. In the simplified history,
> +			 * we "divert" the history walk to the later
> +			 * parent. These commits are shown when "show_pulls"
> +			 * is enabled, so do not mark the object as
> +			 * TREESAME here.

As we no longer use the word "diversion", this explanation should
shift the focus from defining the word "diversion" and giving its
background to explaining why the above parent rewriting is done and
why the TREESAME marking is conditional, e.g.

      			The tree of the merge and of the parent are
      			the same; from here on, we stop following
      			histories of all other parents but this one
      			by culling commit->parents list.  We also
      			normally mark the merge commit TREESAME as
      			the merge itself did not introduce any
      			change relative to the parent, but we
      			refrain from doing so for the first parent
      			under "--show-pulls" mode, in order to let
      			the output phase to show the merge, which is
      			the last commit before we divert our walk to
      			a side history.

or something along that line.

> +			if (!revs->show_pulls || !nth_parent)
> +				commit->object.flags |= TREESAME;
> +
>  			return;

> @@ -897,6 +909,10 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
>  				relevant_change = 1;
>  			else
>  				irrelevant_change = 1;
> +
> +			if (!nth_parent)
> +				commit->object.flags |= PULL_MERGE;

For a three-parent merge that brings in changes to the first parent,
if the result matches the second parent, we would have returned in
the previous hunk before having a chance to inspect the third one
and marking the merge result with PULL_MERGE, but if you swap the
order of the second and the third parent, the second parent, which
has different tree from the result, would not return in the previous
hunk and cause the merge with PULL_MERGE here.  And then when we
inspect the third parent, the previous hunk's return would kick in.
So for two merges that merge exactly the same two branches on top of
exactly the same commit on the mainline, you sometimes mark the
result with PULL_MERGE and sometimes don't, depending on the order
of the second and the third parent.

That feels iffy.  Treating the first parent differently from others
is what we intend to do with this change, bhut this hunk treats the
other parents differently depending on the merge order.

> @@ -3019,7 +3037,8 @@ static struct commit_list **simplify_one(struct rev_info *revs, struct commit *c
>  	if (!cnt ||
>  	    (commit->object.flags & UNINTERESTING) ||
>  	    !(commit->object.flags & TREESAME) ||
> -	    (parent = one_relevant_parent(revs, commit->parents)) == NULL)
> +	    (parent = one_relevant_parent(revs, commit->parents)) == NULL ||
> +	    (revs->show_pulls && (commit->object.flags & PULL_MERGE)))
>  		st->simplified = commit;

... hence, wouldn't we see different result here ...

> @@ -3602,6 +3621,10 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
>  			/* drop merges unless we want parenthood */
>  			if (!want_ancestry(revs))
>  				return commit_ignore;
> +
> +			if (revs->show_pulls && (commit->object.flags & PULL_MERGE))
> +				return commit_show;

... and also here?

Thanks.
