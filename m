Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205D6C433F5
	for <git@archiver.kernel.org>; Tue, 17 May 2022 08:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242289AbiEQIX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 May 2022 04:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiEQIXz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 May 2022 04:23:55 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0805033370
        for <git@vger.kernel.org>; Tue, 17 May 2022 01:23:53 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg11so7539935edb.11
        for <git@vger.kernel.org>; Tue, 17 May 2022 01:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mUdmw2zOJg9i8eIRMGwPSAzZkPGh7TNdHGMtuH7DjXg=;
        b=i5r1ALnsGcQKk68QSrGcTk2RI2IP73IlOLWuW+vOJPguRGrwTpfuGdLdSa4+dnL12/
         6nA7MGBsZ/1UMsxSycNbpRbOwJNov6IbofRjL7mLrnfi7bK1WN2QrqOOt73GeIZhBDRN
         5bTzjINetKyRN6gUBeF0QZEpNAICFb+r+RRk4vLadnXRe06OQhIAxmjjrn3Ydqg3ki/3
         CCqVWJ5DziX0jAxFywADwDCNo0M83czIhHWuNu/5njzMgbE2cuh/UYD4iY/oDYKd+loa
         JTV5RDRpuYvRKwegME9lzzwgamDzdOabkO193ZQqtKSQ0RZ3brVD172DhaW3+829jJj9
         g2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mUdmw2zOJg9i8eIRMGwPSAzZkPGh7TNdHGMtuH7DjXg=;
        b=OxFkZAzN6aB5EdtelHmTYgO0NxTlAv+wTtwQN6ifenuXhEN7JVMEYzOwBE4nMyKAsO
         GfJ7KmcRBhtpCPdsqu9wQZfKLT6pBZUvB+FbakQpr9Xl2dfrcvDlLFyLhRjfMcUj7z6t
         NYa+gTnStc1MEI0uBlSUxDQzSERE1sD9Pv01kPBhEqFquvv+hRCNfCJsL70LLDhOEwU+
         sb4L374mpPynNrjPHgGEmyz8U+NAO7UMLdIcg0rIlSBQDaKYChtcXp4zjFGGGaJh2ZAg
         JlFAk9Poztc89pakvo4WpNzyDNVLADIf7yRQwpd71htiJc1JMlYF5w55IsZLD8jtUqCm
         AdAA==
X-Gm-Message-State: AOAM5334ObhFEHwKcdwLdp0HQZXUlwOYoWk31JexzACa8gjceaqO1iEg
        1KAZakRxsSYdc8Dme4dLygeqyOlWMJ6RA/ealkA=
X-Google-Smtp-Source: ABdhPJwwJsDtXVLanrpIVPb1FnCqCvSyX3DGsUB2MNE5HG7oZi3dANOW7KbfgnC7tixXA97JVdlv1nXt0fW6kWaM/6c=
X-Received: by 2002:a05:6402:50d2:b0:428:b39:5c08 with SMTP id
 h18-20020a05640250d200b004280b395c08mr17567664edb.146.1652775831558; Tue, 17
 May 2022 01:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <35e0ed9271a0229fe2acd2385a7e4171d4dfe077.1642888562.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201281744280.347@tvgsbejvaqbjf.bet> <CABPp-BG2rMEYBLuBW=0wtpJe4aUFGCFa8D0NTSKz9Sm+CkXPxw@mail.gmail.com>
 <0d7ba76c-9824-9953-b8ce-6abe810e2778@kdbg.org> <CABPp-BERtRDeyF3MhOQhAFwjoykOKwXoz6635NK7j2SEKp1b3A@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202050009220.347@tvgsbejvaqbjf.bet> <CABPp-BGCL0onSmpgKuO1k2spYCkx=v27ed9TSSxFib=OdDcLbw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202211059430.26495@tvgsbejvaqbjf.bet> <CABPp-BFG_05RyVVyiHzOkuoT8=9NftJGp_W+DXd7ktqC5UfvwQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2202251726500.11118@tvgsbejvaqbjf.bet> <CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071718090.11118@tvgsbejvaqbjf.bet> <CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203101546110.357@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2205131220200.352@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 17 May 2022 01:23:40 -0700
Message-ID: <CABPp-BHQPrun3xhXBhbBnZ9cAy1sV7_r-kGsQhC-YsRMvoERmw@mail.gmail.com>
Subject: Re: [PATCH 08/12] merge-ort: provide a merge_get_conflicted_files()
 helper function
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Fri, May 13, 2022 at 3:21 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Thu, 10 Mar 2022, Johannes Schindelin wrote:
>
> > On Tue, 8 Mar 2022, Elijah Newren wrote:
> >
> > > So, this is one series where even if everyone else says to merge it
> > > already, I'd like to wait a bit longer on it until I feel confident we
> > > have a solution that handles at least the current usecases.
> >
> > Fair enough, you're in charge of this series, and I really like what you
> > came up with.
> >
> > My thinking was driven more by the users' side, as I am relatively eager
> > to integrate this into production, but am loathe to do that with an early
> > iteration of `en/merge-tree` that might be substantially revamped, still.
>
> I've been bogged down with things elsewhere, but should now have time to
> help on this end.
>
> Elijah, _is_ there anything I can help with?

Yeah, I've been bogged down with other things too; the little Git time
I've had has been spent responding to review requests or other things
folks manually were asking for my input on.

I think I got a fair amount of this implemented about a month or so
ago.  I just pushed up what I have to the wip-for-in-core-merge-tree
branch of newren/git.  Some notes:

  * A big "WIP" commit that needs to be broken up
  * The previous "output" member of merge_result, containing a strmap
of conflict and informational messages (basically a mapping of
filename -> strbuf) now needs to be replaced by a strmap "conflicts",
which is now a mapping of primary_filename -> logical_conflicts, and
logical_conflicts is an array of logical_conflict, and
logical_conflict has a type, array of paths, and message.
  * Since "output" is no longer part of merge_result, the new
remerge-diff functionality is going to need to be modified since it
used that field, and instead iterate on "conflicts" to get the same
information
  * I have some FIXME comments in a couple places where I need to
figure out how I want to pass the variable number of arguments (in a
function already accepting a variable number of arguments for other
reasons, making the function in a way have to variable length lists of
arguments)
  * The new enums and structs I added to merge-ort.c really have to be
added to merge-ort.h and become part of the API.  Feels a little
unfortunate since it'll make the API _much_ more involved, but I don't
see any other way to solve your usecase.

If you want to take a stab at the above, or even see if my changes
make sense (sorry for it all being squashed into one big commit and
not having good commit messages, but, you know...you did ask), that'd
be great.
