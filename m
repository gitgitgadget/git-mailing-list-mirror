Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8782BC43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B4E206F6
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 17:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkbZYNuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgC1RST (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 13:18:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39587 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RST (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 13:18:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id x11so13351120otp.6
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GMiDr0QD898vKZWlJFV2RvOlm2IfzbkkON7ST/gfSO0=;
        b=OkbZYNuOyeV37iW1jHytjI2Qj3WFMh3mfliFcGDX8cgN9KI070BaWpz5FMkpz7P17j
         GF0Lo8VG8m5jXUqtH1hLC+GfAynu9cwhQC/JvfR9iAqmU+xY06Qn9+f05gY97OOzYlWU
         ZELZFJfkpw8yZu+8nYogK1ZzwvQuUAX6LQUwoHNVDDq051rCYdlJvYXwt3Eed3TEwM1H
         v0Q310Ndo1OQc4zZlcXPGBnnr566ZiWPrIysczbm4ID5gw1vuOJrhZoCMTAKxJgZagUs
         XBUysNYn9kfwq5LpDhXOSY6kYbz78vMpQ8ouWAJ2LxK19Rh7jW2EcxKO7b3r2vLqs1uT
         CeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GMiDr0QD898vKZWlJFV2RvOlm2IfzbkkON7ST/gfSO0=;
        b=hwSjWiPt+cWPSqiE5N+vaQ8MfCVxFDFxPU+N3JWlWcprB9Hxrenh2LQ5sY+4Q3B9bB
         cIl7Y363w0I5LhwwKffS1Oezh3EDIT0DYgUN2zGU//D8tsRRY6SD81jT34CzMZjjLeLo
         BgB61/I9wzdFQ6KNmnG2WHNmfHZKJ++7DS/qlF6Gr9xYIiNuUA/1udoTeuAYcCCoAtnF
         q2HDnYufC7oHH0oXyDUpsIfakfRXw/CLN1RmoIBDMKkfglylonToMHdUm3or/d4EbRHm
         pRbCMm2hrBj9y51wwGXzd6tTmolq7xofp77/PS1Uv8PavoMLd+68mY+3+5UT1GXJY3QB
         hZ/A==
X-Gm-Message-State: ANhLgQ0GgeZYPyFfnviqcoH/n6RkpLRz+uFko4WEJ/H5uQO2wecTt8Y4
        xC2UXYSAAKqlix30+eWeShbT6wtmUmK9jkgMYrg=
X-Google-Smtp-Source: ADFU+vsAU1DEW6RbqWGxOFB2Hhf3EaaV5qohDQLGH6P7xzWLqFScq2TUbWJ+kfOCLAhUl9FXJqFj3UpRjg8om2qm3bU=
X-Received: by 2002:a4a:a88a:: with SMTP id q10mr4033967oom.17.1585415898006;
 Sat, 28 Mar 2020 10:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <pull.739.git.git.1585345900763.gitgitgadget@gmail.com> <20200328155627.GB1215566@coredump.intra.peff.net>
In-Reply-To: <20200328155627.GB1215566@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 28 Mar 2020 10:18:07 -0700
Message-ID: <CABPp-BFgwcGjvwFsHzgf8bvR6dY2EocpUbn5-on5sdeRqkw1jw@mail.gmail.com>
Subject: Re: [PATCH] pull: avoid running both merge and rebase
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Norbert Kiesel <nkiesel@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 8:56 AM Jeff King <peff@peff.net> wrote:
>
> On Fri, Mar 27, 2020 at 09:51:40PM +0000, Elijah Newren via GitGitGadget wrote:
>
> > When opt_rebase is true, we still first check if we can fast-forward.
> > If the branch is fast-forwardable, then we can avoid the rebase and just
> > use merge to do the fast-forward logic.  However, when commit a6d7eb2c7a
> > ("pull: optionally rebase submodules (remote submodule changes only)",
> > 2017-06-23) added the ability to rebase submodules it accidentally
> > caused us to run BOTH a merge and a rebase.  Add a flag to avoid doing
> > both.
> >
> > This was found when a user had both pull.rebase and rebase.autosquash
> > set to true.  In such a case, the running of both merge and rebase would
> > cause ORIG_HEAD to be updated twice (and match HEAD at the end instead
> > of the commit before the rebase started), against expectation.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >     pull: avoid running both merge and rebase
> >
> >     Cc: Norbert Kiesel nkiesel@gmail.com [nkiesel@gmail.com], Jeff King
> >     peff@peff.net [peff@peff.net]
>
> I'm not sure how cc is supposed to work with GGG, but it clearly didn't
> here. :)

Yeah, I clearly don't either.  I even looked up another submission
from Dscho (https://github.com/git/git/pull/728) and attempted to
mimic it, but still managed to get it wrong somehow and I don't know
how.

> Anyway, the patch looks good. Thanks for following through on this.
>
> > @@ -992,10 +993,12 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
> >                       if (is_descendant_of(merge_head, list)) {
> >                               /* we can fast-forward this without invoking rebase */
> >                               opt_ff = "--ff-only";
> > +                             ran_ff = 1;
> >                               ret = run_merge();
> >                       }
> >               }
> > -             ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
> > +             if (!ran_ff)
> > +                     ret = run_rebase(&curr_head, merge_heads.oid, &rebase_fork_point);
>
> It feels like there should be some arrangement of the conditionals that
> doesn't require setting an extra flag, but I actually don't think there
> is. And anyway, doing the most obvious and minimal fix here is the right
> place to start. We don't need more regressions. ;)

Thanks for reviewing it.
