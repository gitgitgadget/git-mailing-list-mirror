Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD,URI_HEX
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6FC1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752687AbdLNPEH (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 10:04:07 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:45371 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752506AbdLNPEG (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2017 10:04:06 -0500
X-IronPort-AV: E=Sophos;i="5.45,400,1508796000"; 
   d="scan'208";a="305494682"
Received: from zmbs3.inria.fr ([128.93.142.16])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Dec 2017 16:04:04 +0100
Date:   Thu, 14 Dec 2017 16:04:04 +0100 (CET)
From:   Matthieu Moy <matthieu.moy@univ-lyon1.fr>
To:     BENSOUSSAN--BOHM DANIEL p1507430 
        <daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Jordan DE GEA <jordan.de-gea@grenoble-inp.org>,
        ALBERTIN TIMOTHEE p1514771 
        <timothee.albertin@etu.univ-lyon1.fr>,
        PAYRE NATHAN p1508475 <nathan.payre@etu.univ-lyon1.fr>
Message-ID: <1547311095.1194033.1513263844281.JavaMail.zimbra@inria.fr>
In-Reply-To: <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>
References: <1512034932-14499-1-git-send-email-timothee.albertin@etu.univ-lyon1.fr> <9a0556ac403845f39a564bbc55df5b3a@BPMBX2013-01.univ-lyon1.fr>
Subject: Re: [PATCH v2] doc: add triangular workflow
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [77.136.87.204]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF57 (Linux)/8.0.9_GA_6191)
Thread-Topic: [PATCH v2] doc: add triangular workflow
Thread-Index: AQHTdMkK0lYr5ml+vEus5/xD/4rUcfkT9NvO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"BENSOUSSAN--BOHM DANIEL p1507430" <daniel.bensoussan--bohm@etu.univ-lyon1.fr> wrote:

> Added a new file about triangular workflow for a clearer organization.

"for a clearer organization" is an explanation of why you are doing
things this way compared to your previous email.

But this is the commit message, and its wording shoud make sense in
this context, i.e. regardless of previous emails you sent which won't
appear it the Git history. Now, read again this sentence: adding a
file about triangular workflow does not make any "organization"
"clearer".

> With a more precise documentation, any new Git contributors
> will spend less time on understanding this doc and the way Git works.

I understand what you mean, but adding a new piece of documentation
cannot make people spend less time on this particular documentation.

Also "any new Git contributors will spend less time" sounds like
marketing speach, not technical. Your goal is to make it easier for
new users, but claiming that everybody is going to gain time by
reading your documentation is a bit overselling your text.

I don't think you should talk about "Git contributors", which can be
read as "contributors to the git.git codebase". "Git users" would make
more sense, or perhaps you meant "contributors to Git projects". But
actually, I don't think this kind of documentation should focus only
on new users. I think many reasonably advanced Git users do not know
about remote.pushdefault for example.

> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 2ab6556..c3e98c7 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -10,6 +10,7 @@ OBSOLETE_HTML =
>  MAN1_TXT += $(filter-out \
>  		$(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
>  		$(wildcard git-*.txt))
> +MAN1_TXT += git-triangular-workflow.txt

git-*.txt is reserved for actual Git commands. Other tutorials use
git*.txt (e.g. we have gitworkflows.txt and not git-workflows.txt).

> +- The project maintainer publishes a repository, called **UPSTREAM** in
> +this document, which is a read-only for contributors. They can clone and

s/a read-only/read-only/

Perhaps s/can/& only/ too.

> +- Contributors publish their modifications by pushing to a repository,
> +called **PUBLISH** in this document, and request a merge.
> +- Opening a pull request

Other items use full sentences, this one seems half-written. Actually,
I think this item is included in the "request a merge" part of the
previous one.

> +This workflow is commonly used on different platforms like BitBucket,
> +GitHub or GitLab which provide a dedicated mechanism for requesting merges.

As a user, I find it terribly frustrating when reading documentation
telling me that "there's a dedicated mechanism" for something without
telling me actually how to do it.

> +
> +........................................
> +------------------               -----------------
> +| UPSTREAM       |  maintainer   | PUBLISH       |
> +|                |- - - - - - - -|               |
> +------------------      <-       -----------------
> +              \                     /
> +               \                   /
> +        fetch | \                 / ^ push
> +              v  \               /  |
> +                  \             /
> +                   -------------
> +                   |   LOCAL   |
> +                   -------------

This kind of diagram deserves a bit of text to explain the situation.
For example, LOCAL is local only for the contributor (the maintainer
doesn't need to know about it for example). I'd add a sentence to
explain that this gives the overall view on the flow, from the point
of view of a contributor.

> +With the triangular workflow, the contributors have the write
> +access on **PUBLISH** and push their code there.  Only the

"have write access", no need for "the".

> +* Code review is made before integration.
> +
> +In a triangular workflow the rest of the community or the company
> +can review the code before it's in production. Everyone can read on
> +**PUBLISH** so everyone can review code before the maintainer merge
> +it to **UPSTREAM**.  In a free software, anyone can
> +propose code.  Reviewers accept the code when everyone agree
> +with it.
> +
> +* Encourages clean history by using `rebase -i` and `push --force` to
> +the public fork before the code is merged.

"Encourages" has no subject. It could be OK, but for consistency with
other items I'd add one ("Triangular workflow encourages ..."?).

> +If **PUBLISH** doesn't exist, a contributor can publish his own repository.
> +**PUBLISH** contains modifications before integration.
> +
> +============================
> +* `git clone <UPSTREAM_url>`
> +* `git remote add **PUBLISH**`

git remote add needs two arguments, you're giving only one.

> +* `git push`

This will push to UPSTREAM, right?

> +Adding **UPSTREAM** remote:
> +
> +===================================
> +`git remote add upstream <UPSTREAM_url>`
> +===================================

In which circumstance shall one write this? If you don't say it, the
reader will probably assume that this is to be done after the commands
you specified right above. But then: it doesn't make sense. You've
just cloned from UPSTREAM, you already have the UPSTREAM remote.

> +For each branch requiring a triangular workflow, set
> +`branch.<branch>.remote` and `branch.<branch>.pushRemote` to set up
> +the **UPSTREAM** and **PUBLISH** repositories.

This neither tells me how to set the variables, nor what the effect
will be ("set up"?).

> +Example with master as <branch>:
> +===================================
> +* `git config branch.master.remote upstream`
> +* `git config branch.master.pushRemote origin`
> +===================================

origin is the remote you've cloned from. From the text above, I guess
you meant it to point to PUBLISH. But all the examples "git clone" you
gave are from UPSTREAM.

You're mixing the case where one "git clone"s from UPSTREAM and "git
remode add"s PUBLISH, and the converse. Both are possible, but the
"origin" remote will be different depending on which one you chose.

> +Making your work available
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The `git push` command sends commits to the **PUBLISH** repository and not to
> +the **UPSTREAM** thanks to the configuration you did earlier with the
> +`git config remote.pushdefault origin` command.

This explanation should be next to the place where you recommend
setting remote.pushdefault.

> +When a contributor pushes something, the `git config push.default
> +current` command can be used to specify that the name of the
> +**PUBLISH** branch is the same as the name of the **LOCAL** one.

I already said it multiple times, but I don't think it's a good idea
to recommend changing push.default. The default, "simple", was
specifically designed to be appropriate for triangular workflow:

  http://git.661346.n2.nabble.com/PATCH-0-6-push-default-in-the-triangular-world-td7589907.html
  (PATCH 3/6 in particular)

You may disagree with me, but then please explain your motivation (by
replying to my messages and/or by explaining the rationale in the
commit message).

> +=================================
> +`git rev-parse --abbrev-ref @{push}`
> +=================================
> +
> +.Display the fetch remote's name:
> +[caption="Recipe: "]
> +
> +===================================
> +`git rev-parse --abbrev-ref @{upstream}`
> +===================================

I don't think "rev-parse" is the best example to give.

I use @{upstream} all the time to see what commits I have which aren't
in upstream yet:

  git log @{upstream}..


[ part of text not re-read by lack of time ]

> --- a/Documentation/gitworkflows.txt
> +++ b/Documentation/gitworkflows.txt
> @@ -467,6 +467,7 @@ other options.
>  SEE ALSO
>  --------
>  linkgit:gittutorial[7],
> +linkgit:git-triangular-workflow.txt[1],
>  linkgit:git-push[1],
>  linkgit:git-pull[1],
>  linkgit:git-merge[1],

I think this deserves more than just a "SEE ALSO" link. The "merge
workflow" part is essentially another name for triangular workflow.
There should be a proper citation of this new triangular workflow doc,
i.e. a link with an explanatory sentence somewhere in the "merge
workflow" part IMHO.

-- 
Matthieu Moy
https://matthieu-moy.fr/
