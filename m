Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C933EB64D9
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 23:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGFXYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 19:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjGFXYV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 19:24:21 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6A71BCA
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 16:24:19 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-558a79941c6so899484eaf.3
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 16:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688685859; x=1691277859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94+xAHb1jkEhSijTjMrVYSSzuXLLWO+7BU6NhlTlePk=;
        b=L6Bd+xXKtoVaxPaC7SMh/SKJTPRRHuzlumw2GTzpGWSBamkwgKn18dSxLLZlRui0p1
         WG6Vs9qSs9dnn66qq8qHy8sxRUUAyQ5j0OslU8RPrO/gh8YmIhpjPgXhqM7FN9pv7pkL
         Fwi2CAUWKU1zMs0JnRjrsjWV+B0dEECJ9TENxhQJgZgwvoyRRcvgzJUbn0tPtTxpUJT/
         3/X87QJqRkCZKYv8JlYKPox/tN/v9MAwCQ4Yzigt3PfJLvaz8My5C/r4U/QBcLGfCcLp
         I7dgEJa27fdq6vAI/CeCVEqg1dHEfFzUlk731agcseX2eOSvrUGFNzcFJ4D3vxl603Fz
         oOgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688685859; x=1691277859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94+xAHb1jkEhSijTjMrVYSSzuXLLWO+7BU6NhlTlePk=;
        b=FYrZjAp02+LTV61+4T29SPkxV0gOElJ3nQP7BNyjWFQ8dkucgGdN13ECKRka00iUF1
         eY8DB5hYirQzLctrgS+9cKGbqV/j7KKpdOe04ym/llDLbaTfVrBca5tQsbn87qKtSws9
         2JouLAnJKTyOYKqhyV3umln0T9XvjYlu2V2JwFl1jwjJlpnxmffT1JIwbDvF1IaaBU2c
         ITWFxIfHj3/kRlJIjnkm0nhGTrG/vZVXr/oCJ3tLrbv+Qd7HTJ84t2tyJ4Q/CZbBViv+
         5izkGFjgtKtkVFpmE1O+jgXcuxcTITmRmgTpdgf4K6SYz9pkaQGhg4a6ZxGLxFZOqspb
         toiQ==
X-Gm-Message-State: ABy/qLZFLCcNpdNsBU5DYYYAHSBij0xlgnCNXQzM/xK14TFBCt8JMR8T
        HHf2Lp9lo7O/uTSWubJIGmHxTvgkNSyLXSPEAi4qsma2KfM=
X-Google-Smtp-Source: APBJJlF19aG6pWQ27OR0F6LlD+V9sP4cVNyPoStTiJosWe+6XRzrgaQ7+kYlftA6DGUUyeGuMD951nyAjF2Dwkvrpgs=
X-Received: by 2002:a4a:3748:0:b0:563:69ba:5919 with SMTP id
 r69-20020a4a3748000000b0056369ba5919mr2483144oor.4.1688685858802; Thu, 06 Jul
 2023 16:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230704194756.166111-1-alexhenrie24@gmail.com>
 <20230706040111.81110-1-alexhenrie24@gmail.com> <20230706040111.81110-2-alexhenrie24@gmail.com>
 <xmqqttugbxds.fsf@gitster.g> <xmqqo7kobwpj.fsf@gitster.g>
In-Reply-To: <xmqqo7kobwpj.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 6 Jul 2023 17:23:42 -0600
Message-ID: <CAMMLpeS9_P=XXMoOdTAM3jZbaxfLEJNwYArS6p9pMXisT3TRtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] remote: advise about force-pushing as an
 alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@matthieu-moy.fr, christiwald@gmail.com,
        john@keeping.me.uk, philipoakley@iee.email,
        phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 6, 2023 at 2:40=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> >> diff --git a/remote.c b/remote.c
> >> index a81f2e2f17..1fe86f8b23 100644
> >> --- a/remote.c
> >> +++ b/remote.c
> >> @@ -2323,7 +2323,10 @@ int format_tracking_info(struct branch *branch,=
 struct strbuf *sb,
> >>                      base, ours, theirs);
> >>              if (advice_enabled(ADVICE_STATUS_HINTS))
> >>                      strbuf_addstr(sb,
> >> -                            _("  (use \"git pull\" to merge the remot=
e branch into yours)\n"));
> >> +                            _("  (To reconcile your local changes wit=
h the work at the remote, you can\n"
> >> +                              "  use 'git pull' and then 'git push'. =
To discard the work at the remote\n"
> >> +                              "  and replace it with what you did (al=
one), you can use\n"
> >> +                              "  'git push --force'.)\n"));
> >>      }
> >
> > Since wt-status.c:wt_longstatus_print_tracking() calls this
> > function, I would expect that this change would manifest as test
> > breakage in "git status" (or "git commit" whose commit log edit
> > buffer is examined) tests.  Are we lacking test coverage?

Because I was only changing advice messages and not any functionality,
I didn't think to run the tests. They are indeed failing, sorry. I
will fix that in v4.

> The other callsite of format_tracking_info() is "git checkout".
> When you start working on your own topic forked from upstream by
> switching to it, if Git notices that your topic's base has become
> behind (so that you would later need to merge or rebase to avoid
> losing others' work), the "git pull" message is given to tell you
> that it is OK if you want to catch up first before working on it.
>
> But the new message does not fit well in the workflow.  It is
> primarily targetted for the users who are about to push out.  They
> are at the point where they are way before being ready to "discard
> the work at the remote".

If the branch is merely behind, format_tracking_info prints "(use "git
pull" to update your local branch)", which is perfectly reasonable.
The problem is only with the message that appears when the branches
are divergent, "(use "git pull" to merge the remote branch into
yours)", which is bad advice for the common GitHub/GitLab workflow
that expects force-pushing.

> I guess the updated message in the context of "git status" has
> exactly the same issue.  The user is about to make a commit, which
> will later be pushed out.
>
> So, while I agree that new users may need to be made aware of
> situations where they should not afraid of overwriting the remote
> repository by forcing a non-ff push, I am not sure if this is a good
> advice message to convey it.

For more context, the coworker who most recently had this problem
tried to pull because he looked at `git status` _after_ committing.
Git can't assume that certain commands go with certain workflows (at
least, not when it comes to divergent branches). Even if the user
switches to a different branch and switches back, the first branch
might be divergent simply because the user forgot to force-push before
switching off of it. So, let's please give the user all of the
information (two ways forward: reconcile or delete) and encourage them
to make the most appropriate decision for their particular workflow.

-Alex
