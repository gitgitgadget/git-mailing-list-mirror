Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8894E20248
	for <e@80x24.org>; Tue, 12 Mar 2019 16:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfCLQng (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 12:43:36 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:34166 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLQng (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 12:43:36 -0400
Received: by mail-vs1-f67.google.com with SMTP id h7so2027454vsl.1
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nerx4p+KoHYn6wld/QQIiZwx7HvuYVazX4o+HmYNBhA=;
        b=SoCzObeJmfVTEdxw+WwTApYCgsCVGNaN2scAmm9gqBx5Mr+M341Rkf7Y6uLBjLbf0d
         dlw7T+3UF8BjYlhiBQsrWI7vhmTwukJ/CKbFGppqZro6pA+SfreD3oOFotTJOjHsvyNx
         Y5rgU1aXp/EG3Z+Q3EHGFyIsj1g6FhgVYMUF2Ju8FdJafQrCiEh7bcXp/ioneKUSjaoB
         nsdln6oaML1PqJu2s3aMWWukdx4U//ze8maoIchPjgNPIMMiklE7iTxgaA9o3fFLR2MS
         eQsgJ5zzwUcG3AIPMxSKhdsLrCPS8+9H/B9LB+43+nX0ediksRo46tu3rxnWvGZ3B6p9
         6uJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nerx4p+KoHYn6wld/QQIiZwx7HvuYVazX4o+HmYNBhA=;
        b=HvYlJumTYkKTIqexF12UxUhPI71JSy8qBL88u3LuxuRi6y7ARGFArPvEuvvz2wtEMw
         cajf+q6CMBAzGmUJILE+8QnVeIY8GfBoozjaRFOgMpJtcJdjFyLcbt+u+psRvtVL9fM3
         Edm8K78Veoxe4UZHClXzIpYuIPellEjXfaz2IGA4jrSSjJscXmSXiam3rtP7Uklw77nn
         KBdJu2NDQeVFg6pl648+wOXoYIgfrxHfBddXn0m5Evv6tzLR1C8kT96YxaMK+zPnlRAl
         3niWQuGhxLs4yVQX79Dqaz+iS/Kq8cYtvW+6G+R6OQw4sKPMCJSm++kRe4Jxn+K80ejg
         DwJg==
X-Gm-Message-State: APjAAAV4jHhPTOnRPlKZywiLUnkvqXNRkLS67w+BBOqcH423GziHguau
        /wse28OLh6RJ0BQHFX7n6Q9/9Iljhy0EgYUvZVU=
X-Google-Smtp-Source: APXvYqznkmmk7dYgIUGzMpsfmbG2lpUaH/N+bK2LwjnT9hjo100S92QDqgAzZwhcP6+JFbiBRcj061bDZVqNxfS84ic=
X-Received: by 2002:a67:eb97:: with SMTP id e23mr21456719vso.175.1552409014539;
 Tue, 12 Mar 2019 09:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190208090401.14793-1-pclouds@gmail.com> <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com> <CABPp-BEBudobnduipQrSvyQWQ7Hb4WmmoptCQ+FyY8BRPp7_ZA@mail.gmail.com>
 <ca6f8e4b-d60c-877c-52e7-fb91c99cd3a5@gmail.com>
In-Reply-To: <ca6f8e4b-d60c-877c-52e7-fb91c99cd3a5@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 12 Mar 2019 09:43:21 -0700
Message-ID: <CABPp-BFoL_U=bzON4SEMaQSKU2TKwnOgNqjt5MUaOejTKGUJxw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command 'switch'
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 4:06 AM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> Hi Elijah
>
> On 11/03/2019 17:54, Elijah Newren wrote:
> > A few other comments that I thought of while responding elsewhere in
> > the thread that didn't make sense to include elsewhere...
> >
> > On Fri, Mar 8, 2019 at 2:00 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
> >>
> >> +-m::
> >> +--merge::
> >> +       If you have local modifications to one or more files that are
> >> +       different between the current branch and the branch to which
> >> +       you are switching, the command refuses to switch branches in
> >> +       order to preserve your modifications in context.  However,
> >> +       with this option, a three-way merge between the current
> >> +       branch, your working tree contents, and the new branch is
> >> +       done, and you will be on the new branch.
> >> ++
> >> +When a merge conflict happens, the index entries for conflicting
> >> +paths are left unmerged, and you need to resolve the conflicts
> >> +and mark the resolved paths with `git add` (or `git rm` if the merge
> >> +should result in deletion of the path).
> >
> > Now that Phillip highlighted issues with -m and -f, it's hard not to
> > wonder about other corner cases.  For example, what if the user made
> > some changes, staged them, then made more changes, then tried to 'git
> > checkout -m <other branch>'?  That's no longer a three-way merge, but
> > four way.  How does that work?  Does it just rely on merge-recursive's
> > (poorly defined) choice of when to bail out and when to permit such
> > craziness?
>
> If the two-way merge fails then it does 'git add -u' before calling
> merge_recursive(), then any merged paths are reset to the new HEAD
> (which throws away newly added files, it should keep anything that is
> not in HEAD or HEAD@{1}). So any staged changes are lost.

Ah, so roughly
  * git add -u
  * uncommitted_tree=3D$(git write-tree)
  * git reset --hard
  * git checkout $other_branch
  * git merge-recursive $old_branch -- $other_branch $uncommitted_tree
  * git reset --mixed HEAD

This at least gives well defined behavior, even if somewhat suboptimal
in relation to losing staged changes (especially when those staged
changes were new files).

I wonder if it'd be nicer, after I get my don't-touch-the-working-tree
merge rewrite done, to instead do something like:
  * Write the beginning index to a tree; call it $tree_0
  * Note whether any working tree files differ from the index, add
these all to a temporary index and write to to a tree; call it
$tree_1.
  * Do a three way in-memory merge of $old_branch with $other_branch
and $tree_0; call it $merged_tree if there are no conflicts
  * If $tree_0 =3D=3D $tree_1, checkout the new branch and update the
index and working tree to reflect the merge result.
  * If $tree_0 !=3D $tree_1 and there were any conflicts, abort telling
the user they need to either unstage or stage changes first (we don't
want to confuse users with a merge of a merge).
  * Switch to the new branch, and update the index to match $merged_tree
  * Do a three way in-memory merge of $old_branch with $merged_tree
and $tree_1, writing the results (including any conflicts) to the
working tree afterward.

Pros of this method:
  * We don't lose newly staged files
  * We don't lose user's carefully staged entries for existing files either
Cons of this method:
  * It may abort with an error if the user has a mix of both staged
and unstaged changes (in particular, it will do so if the user's
staged changes conflict with some difference in the new branch)


Thoughts?

>
> >> +--orphan <new-branch>::
> >> +       Create a new 'orphan' branch, named `<new-branch>`, started fr=
om
> >> +       `<start-point>` and switch to it. See explanation of the same
> >> +       option in linkgit:git-checkout[1] for details.
> >
> > Sigh...does this mean --orphan will remain broken?  It has always
> > driven me crazy that it leaves you with a fully populated rather than
> > an empty index.
>
> I've always thought that was weird.
>
> > It seemed broken to me before I figured out the
> > special usecase,
>
> I haven't figured it out yet - what is it?

It's a presumption that despite the fact that you want a new branch,
and one with no history to boot, that for some reason you want all the
previous branch's current contents.  In particular, you can think of
it as a way to squash all the history of an existing branch into a
single commit in a new branch.

Knowing of this usecase doesn't make it bother me any less when I want
to create a new unrelated empty branch; it seems like it took the
esoteric usecase over the common one to me, but I'm biased.  It makes
me feel better than neither you nor Eric could understand this
behavior of --orphan either.
