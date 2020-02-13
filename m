Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B796C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B30222C2
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 18:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sP+jfpI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgBMSfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:35:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33891 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgBMSfw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 13:35:52 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so6817683oig.1
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 10:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a0/mmWxC3hm8AEyU5xNBK7+OXystdf8dZJMikuoN98w=;
        b=sP+jfpI6amOJoRnj8maM6HREO7vXJQ/raHnrBsDZ+tvgLiOZx+eRkBH30dkicyMmNv
         TpAhtlEiNja2OCFW5CNZE8/baPGjwXwGE3Hgu9X3cL9dxPBWIIs/7rDgSu0ZOmdQkKV7
         jvqZU8q34jmmPhiigfsxdxWccyU82Y53JAA95y+/DMKTCtsT2ycPhWkYnToa90j6YeGP
         5Tt89MeyRJFmxI4HDQT18HTEeEau2hNjTnyKzYviybg1OKce/rtahv6C8NhE/mmqOqb9
         Qc0va16TtR/moXQZzeJCMSpe6GkEZanW6/T9elY+UtFk2bCnwZwR/6OPVYIWScLUfVcv
         ojTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a0/mmWxC3hm8AEyU5xNBK7+OXystdf8dZJMikuoN98w=;
        b=dXCSiicvDcaqdN2HP1bbvnBLneU5lIJax2RS5O5hvRCKQRpgb75RwLleA1XFuGGKny
         Z3Ww78HPbaXE/wKOGvxDXjdwySHx4Om0Eydra0Xik+AS/tod5ryVKisJk4oW/RfRoJOg
         e3a3ucMW+DCs2roQFKHxKsWslsVVuqkTUHZ0PHFWQ5sfm83+5wdA+e3AxT8RhvQRkWrf
         oBfu92x16qMu4En71OZcmOvAmEm6gOg4GDnEVp5OTsAWnPXEu+B+s4+pWdYDzzIQ7fkG
         fW0cj42S05u344/Y1fmtShwBw/EwmJie7/0X+tgvKuGvzjirGCMxFrRlB5XVSqtxWVVF
         Rfhg==
X-Gm-Message-State: APjAAAV/MHadEB555FQ2bC+TUzBO9bRvPqHGNWifb5qH3bSkW27zVtnd
        Pv3dihUfYRV82BKy+W2FEWaXemlsLJv4uWquWcraAw==
X-Google-Smtp-Source: APXvYqz/Utzkh2ho5bY8Hrm1VwKBCDK9aI9mP6J3z+pi6D06FFaftoc7fsCWhOxlzfVkJ2hEiZMbwkbaPA9/XxoMZ+k=
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr3775738oij.31.1581618949845;
 Thu, 13 Feb 2020 10:35:49 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com> <3ea48d53940cb7e1a82a8a6eb819497c0448af6a.1579155273.git.gitgitgadget@gmail.com>
 <09f2a9bd-1fd2-b44b-a279-baf37ae23391@gmail.com>
In-Reply-To: <09f2a9bd-1fd2-b44b-a279-baf37ae23391@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 13 Feb 2020 10:35:38 -0800
Message-ID: <CABPp-BHgGcp8FzrOGfbp4-5Dzda8v76GRR-8RimWfdMSZOntuQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/19] git-rebase.txt: update description of --allow-empty-message
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Sun, Feb 9, 2020 at 7:59 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> Hi Elijah
>
...
> > diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> > index 0c4f038dd6..c83be7ffc2 100644
> > --- a/Documentation/git-rebase.txt
> > +++ b/Documentation/git-rebase.txt
> > @@ -265,9 +265,10 @@ See also INCOMPATIBLE OPTIONS below.
> >   See also INCOMPATIBLE OPTIONS below.
> >
> >   --allow-empty-message::
> > -     By default, rebasing commits with an empty message will fail.
> > -     This option overrides that behavior, allowing commits with empty
> > -     messages to be rebased.
> > +     No-op.  Rebasing commits with an empty message used to fail
> > +     and this option would override that behavior, allowing commits
> > +     with empty messages to be rebased.  Now commits with an empty
> > +     message do not cause rebasing to halt.
>
> Do we want to mention that the user can pass --no-allow-empty-message to
> override this?

Interesting point.  I could be persuaded towards that, but I'm leaning
against it based on the logic in b00bf1c9a8dd which this commit was
based upon.

However, even if we do want to mention --no-allow-empty-message, I'd
rather do that in a different series.  This patch is already slightly
tangential to the series, but it at least fixes the documentation for
a previously-documented option -- an option that happens to be similar
in spirit to the ones being touched by the series.  Adding
documentation for a previously undocumented option, while possibly
laudable, feels like taking a tangent to a tangent to me.  (And this
series is already long enough and is still hanging after two months,
so...)


Elijah
