Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC96BC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9063520707
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhw+7ttD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgA3PSk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:18:40 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:41208 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgA3PSk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:18:40 -0500
Received: by mail-il1-f194.google.com with SMTP id f10so3342558ils.8
        for <git@vger.kernel.org>; Thu, 30 Jan 2020 07:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=O89xcwN3E7l9dgINBnYvGBfDiQsAFJL5KdGJlnfx7RQ=;
        b=hhw+7ttDQIdDM6ZSpLLjcW5ruE8XiQZNkUA2n+Kbpxy42+gL/L8N0lzrMGRwJhVeHv
         p5f3pzvrK5bbuMvg9ZObjasdg80mVpcdzA6UZKL8MscI3PXhYWLzgbaiMiaMd05i8/EH
         7dNHxclLftZw/eERcclGrdw+ouIAtz7+XYCckGRFS+/Js4PWOpzp6+uE21OWDQf60bnq
         736yUzaVu9xBr36L5T2FZz7BUSlKhOdVFj4wAhHLO/Qhvc7ONoZxqmLZvX7MY6Ma9Otv
         x9AWMgbZOrz/POv7r5tYEGpk3WGj+qPqDG2cS4BzOxJerrS1iHD+1V3aFrG2NR5Koenx
         V/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=O89xcwN3E7l9dgINBnYvGBfDiQsAFJL5KdGJlnfx7RQ=;
        b=SD6GZbikOD8n2KyUyxCGXVmDFu/JgbAelCLM0V+YYFgJxkTDfvoSO1TAshOy11jTaq
         aJccTI+BkWrhBpHAwSQ2+U3/0soy/vOi8rWZd+4FXFvN1DHb08CapwR99CgwRzCJS6uo
         87E3ZkXmkuV+Rj3vXjEYKShI8SO++0zA75kkg6ksJSajt04q8bXusb9LPcNpEuaJ4IlH
         3HIKhw/ByH5u1lDRHDzeOi2tjIjG6pOWOJA6TxZi6SfiLL/1U5AO2I6Bpnopu7Pi95EX
         XT3IwgbmsS2nu7mqdSLSOexvgpyeTzzXzWe5Yqy6xAnBv4Kt8NTXC55//NRqS418luIj
         2oHg==
X-Gm-Message-State: APjAAAUls3i6JCFqQK01W9cT2XaaLVAaIZkTXYR/JGrgDe7Ntu+pBacZ
        xrczVR+X3tPhtQVby4zjZdLwMd+425VpAmimPEa6Eg==
X-Google-Smtp-Source: APXvYqzS17tpe7Y+qkviDx6aCszvh8vXe8ZIR9ZQCTW06/GTkFtuNqluO0tNGdq6phSfbpaYZUpEZEsE05/cFjqzW3s=
X-Received: by 2002:a92:ca8b:: with SMTP id t11mr5136359ilo.227.1580397519872;
 Thu, 30 Jan 2020 07:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20200128144026.53128-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001301601580.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001301601580.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Thu, 30 Jan 2020 16:18:28 +0100
Message-ID: <CAN7CjDCrrk9gdd-6LMHTYB-A+cCndb-xdbGF4sjz7gZz-_prDw@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v2 00/11] Finish converting git bisect to C
 part 1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

El jue., 30 ene. 2020 a las 16:04, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Tue, 28 Jan 2020, Miriam Rubio wrote:
>
> > These patches correspond to a first part of patch series
> > of Outreachy project "Finish converting `git bisect` from shell to C"
> > started by the interns Pranit Bauva and Tanushree Tumane
> > (https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) and
> > continued by Miriam Rubio.
> >
> > This first part are formed of preparatory/clean-up patches and all
> > `bisect.c` libification work.
> >
> > These patch series emails were generated from:
> > https://gitlab.com/mirucam/git/commits/git-bisect-work-part1
> >
> > It has to be noted that in this version 2 nothing has been done about a
> > reviewer suggestion of using enums for error codes, because there was n=
o
> > consensus about using them by the reviewers.
>
> It is a pity, as "magic" constants tend to remain "magic" (and eventually
> "tragic" when they have not been addressed properly).
>
> However, this does not need to hold up your patch series.
>
> I noted a couple of rather minor things; It looks pretty good to me
> already, though, and I thank you very much for splitting this patch serie=
s
> off, so that only the libification remains. It made for a pleasant read.
>
Thank you very much for the review.
I hope to send another patch series version soon with the new changes
and suggestions :)

Best,
Miriam

> Thanks,
> Dscho
>
> >
> > --- Changes since v1 Finish converting git bisect to C part 1 patch ser=
ies ---
> >
> > General changes
> > ---------------
> >
> > * Previous patch series version has been split in smaller groups
> > in order to facilitate revision and integration.
> > * Rebase on master branch: c7a6207591 (Sync with maint, 2020-01-27).
> > * Improve commit messages.
> >
> > Specific changes
> > ----------------
> >
> > [6/11] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*`
> > and its dependents
> >
> > * Remove redundant sentences in commit message.
> > * Use `if (res < 0)` instead of `if (res)`.
> >
> > [8/11] bisect: libify `check_merge_bases` and its dependents
> >
> > * Remove redundant sentence in commit message.
> >
> > --
> >
> > [9/11] bisect: libify `check_good_are_ancestors_of_bad` and its
> > dependents
> >
> > * Remove redundant sentences in commit message.
> > * Return in `if (!current_bad_oid)` condition.
> >
> > --
> >
> > [10/11] bisect: libify `handle_bad_merge_base` and its dependents
> >
> > * Remove redundant sentence in commit message.
> >
> > --
> >
> > [11/11] bisect: libify `bisect_next_all`
> >
> > * Remove redundant sentence in commit message.
> > * Add return codes explanations in `bisect.h`.
> >
> > --
> >
> > Miriam Rubio (2):
> >   bisect--helper: convert `vocab_*` char pointers to char arrays
> >   bisect: use the standard 'if (!var)' way to check for 0
> >
> > Pranit Bauva (7):
> >   run-command: make `exists_in_PATH()` non-static
> >   bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
> >     its dependents
> >   bisect: libify `bisect_checkout`
> >   bisect: libify `check_merge_bases` and its dependents
> >   bisect: libify `check_good_are_ancestors_of_bad` and its dependents
> >   bisect: libify `handle_bad_merge_base` and its dependents
> >   bisect: libify `bisect_next_all`
> >
> > Tanushree Tumane (2):
> >   bisect--helper: change `retval` to `res`
> >   bisect--helper: introduce new `decide_next()` function
> >
> >  bisect.c                 | 136 +++++++++++++++++++++++++++------------
> >  bisect.h                 |  23 +++++++
> >  builtin/bisect--helper.c | 118 +++++++++++++++++----------------
> >  run-command.c            |   2 +-
> >  run-command.h            |  11 ++++
> >  5 files changed, 193 insertions(+), 97 deletions(-)
> >
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
