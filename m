Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09843C56201
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 07:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94D06223FD
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 07:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAD7dOfK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgKTHQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 02:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgKTHQk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 02:16:40 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A850C0613CF
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 23:16:38 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id t5so6487744qtp.2
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 23:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zwGniTUtq9C0sawxmx7dXwW+yCusAeXF4mCUMUGuO5U=;
        b=tAD7dOfK1NfxncS/HaJoI2rRcWr5nIkX5LjNEt8PHGPzDFixMBcBjOw4wti6i4Czie
         2wjOF2tN7LZfbSzVjRm2EqwWSAvSNXTucI8oA2mPa6a3TVI6xP/Ppv7eaUzlfKdXuAFP
         SfjdzDnEl5akj+TbJdCjx34iFRbsXqDeDMIlaOqgD8yllx+oyaoT18FI+RkKf0QWBzLs
         5r64I63jpXZ2PEbniBadKUqnyWNDIaB7akaOfVi0xhjDvyVCPDhDUJssgTbg7i5apgQF
         TvYb/AplqCc2C1s5hH9rEmTlMotgLa6tHvPKAQ2SwwLh69946DyndJKA7FmF7EMk1Zmb
         natQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zwGniTUtq9C0sawxmx7dXwW+yCusAeXF4mCUMUGuO5U=;
        b=GjldGH4Ivz0+3zNK6AMjH/GXl0WEaI3bGnI3d9UEfLQ7J4vvndTWreJWfhOJJRqrVS
         G1BZqHGfNwlJIXs5gBRLhN8vrUysSDSQ2VtvuxXSLQcIPJGePyERTXlTmi3ZkFmb5P6u
         v3zUPt90BDgIuR6REnjUGxzPjh+cr09cJXffxzrLBrVblnNVY1018p2lMCyWvad5QdNB
         Pd7UVdy/AWgjRDupdeSvndgySe4P702qTUbrvnZVwRhQjjOmYZaIUlLnMIb07D+BzuNW
         I7ail/c/C6cuV+Yx6HpulfA8WLwbLtQAu5+hw4hh9wvu2MiaOR5fr6S45y3jm3q03pxa
         bFrA==
X-Gm-Message-State: AOAM530RnrM1/DTXxjOjhgFW2M3XcKIkc6mXAOBzmXlCtgVcO/yx+SP+
        rMHL+gsyVA0VOM2Q+QDEdl/0ZCxqw7l4i7ko4T2/eFjvDRk=
X-Google-Smtp-Source: ABdhPJzLhGjoaIBc+q6igBVnnOGaseRLvjfKGhLY8XX7snehqArG1SQaxAjuRw7Vobpae8C/HeVlq2/cC+vWtsK0Obg=
X-Received: by 2002:ac8:6b4c:: with SMTP id x12mr15259737qts.359.1605856597473;
 Thu, 19 Nov 2020 23:16:37 -0800 (PST)
MIME-Version: 1.0
References: <pull.790.v3.git.1605801376577.gitgitgadget@gmail.com>
 <pull.790.v4.git.1605819390.gitgitgadget@gmail.com> <3bd6024a236b061c89bb6b60daf3dc15ef1e32ca.1605819390.git.gitgitgadget@gmail.com>
 <CAPig+cSN=-7KWgDcXM8po44PEKi27U6mJEEL0mj_wrTJBUf=WA@mail.gmail.com>
 <CAGHpTBKHmdjqrz1ABdGUUz7AwcixU_VBy1DQzybpFizqVo8C7A@mail.gmail.com>
 <CAPig+cS5BUCaFN=MN+7gSTbvskffRdTJOgck6TrRRacxCc_CwA@mail.gmail.com> <CAPig+cTaV-L_m3OFw=WAUKaiLqSVvhP7fjjFbE13QStibVmRjw@mail.gmail.com>
In-Reply-To: <CAPig+cTaV-L_m3OFw=WAUKaiLqSVvhP7fjjFbE13QStibVmRjw@mail.gmail.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Fri, 20 Nov 2020 09:16:27 +0200
Message-ID: <CAGHpTB+2SV_GZT9QBSOQLYCO4znBCToCRJ5-guWMxxuQD+aA-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] hooks: allow input from stdin for commit-related hooks
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 8:49 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Nov 20, 2020 at 1:38 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > I do find it quite concerning that the way this series handles the
> > stdin conflict between the hook and `-F -` can break the hook silently
> > and mysteriously. How confusing for a user to write a hook which works
> > with `git commit -m msg` and `git commit -F file` but breaks silently
> > with `git commit -F -`. What is worse is that this breakage may be
> > outside the user's control. For instance, it is easy to imagine some
> > IDE passing the commit message to git-commit via stdin (using `-F -`)
> > rather than via a file (using `-F file`).
> >
> > At the very least, this change deserves a documentation update, both
> > to explain that the prepare-commit-msg hook has a valid stdin, and
> > (importantly) that it won't be able to rely upon stdin in conjunction
> > with `-F -`.
>
> What I forgot to say here was that this patch series doesn't help
> users at all if their IDE passes the commit message to git-commit via
> stdin using `-F -`. In such a case, their hook will _never_ see a
> valid stdin coming from Git, no matter what their script does. So, the
> change made by this patch series may help some users but not others,
> and this is a limitation that should be stated in the commit message
> (and perhaps mentioned in the documentation, though that may be
> difficult to do in a general way).

At least in my case, I never expect stdin to be available when running
in the IDE, so my hook is expected to use GUI anyway. I only need
stdin when the user is running git from the terminal. So all I need from
the IDE is that it doesn't pretend to be a tty while running Git.

And regarding the hook itself - the hook author should be aware that
stdin is not always a tty, and sometimes can be closed or pipe, and
write the hook in a way that handles special cases.

- Orgad
