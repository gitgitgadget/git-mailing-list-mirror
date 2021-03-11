Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99592C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E5A64FAB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbhCKPYV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbhCKPXt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:23:49 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE12C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:23:49 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id f8so1782587otp.8
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwMYSy+GCeNEnj+GHzfqgfUw9RXAn+so9NaxQy9czIU=;
        b=QacsWXELJLMOoUkR4FwLPW+RoEMmQr2dDAUmZ5GCjAKpRsY44ui8SA+rn2jiVnt9GV
         SJ/ULuhb3kRLzSMZEEVCEwH6HE1horwGgLIAo4fYriJQ12I+h5Fm3HVFCWNO/UYrN3vc
         nWlfBSNJ1YZPNtGYUaKaQXzxvXRVEHuCuMVQd8ZDjJDyMoDBjBpifk1wwJUmeDDbujeF
         eqLSmYKIuINvKxLZEYVybH/Ev5/riqmKKfefiVVD/zqsjof9wUl9D8Ub8zSr/MBmIvkG
         JYglx2MAOXjiifKTiSBHUwWN59W6/YCBO0EyyO4EueuchE+nsOG8zPl1dAZsB5UXeXKJ
         JKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwMYSy+GCeNEnj+GHzfqgfUw9RXAn+so9NaxQy9czIU=;
        b=E+kO2E0S0+1OEJymFiSGQy5FXANFaKnRZsula1m/C6k75gHGQm4yXzY6R5NKAsrz/k
         twEK2a+fBPUmtmKW3uk1jaRc7Ne0uZ7ZWVUGss3dmqUFtl1An7knvKRfvVRZDu96L58f
         UTt8DE5dKOY+hjxykYM0kCujoAYgHh3xG6QzfnBVqbVo3ngNdSScZwlp302jprprquT3
         KCqib84QohhdcdZ1viFVAOjEiKLkvaq4wD2I9rtreUY6BEMoxG2rdbqFoMmpDDvuBXMY
         fe5dQ7frFMcRSwyHi6AscYtw/lJijSXNHySF9FthmJXDehm4vWLwfoqrvRVd2UqSlBd4
         6sbg==
X-Gm-Message-State: AOAM532lvve504pPQgnpxDNSdBRwcTjDrMOYEEBLTAMMnoznRzg/I+Ss
        NCI67Z0HooSajkLeGm5GRYiiEl4tPNmP5Nxfy46rJWvcgYs=
X-Google-Smtp-Source: ABdhPJwiZVZ1vmfYOZ2mL8GRdY5M8esfpOOobXiM0Qfqc/drX/WrMJdvhXcf0KyusxW4PnUuWV2DpkKAODSA5bQnm1I=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr7448164oth.184.1615476228471;
 Thu, 11 Mar 2021 07:23:48 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-4-charvi077@gmail.com>
 <xmqqpn06h6os.fsf@gitster.g> <CAPSFM5dqRbuoCvEFcHQPSQt+EK1_pBVQ--f42jR+GNqCFd_SOg@mail.gmail.com>
 <xmqqa6rafdyg.fsf@gitster.g>
In-Reply-To: <xmqqa6rafdyg.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Thu, 11 Mar 2021 20:53:37 +0530
Message-ID: <CAPSFM5dja-8v3Gqs3fydCg3bWPv-sg1OaqM1URiR1XGwrbqv-Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] commit: add a reword suboption to --fixup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 11 Mar 2021 at 11:07, Junio C Hamano <gitster@pobox.com> wrote:
>
[...]
> > - To check if fixup_message that contains ':' is a commit
> > - reference for example: --fixup="HEAD^{/^area: string}" or
> > - a suboption of `--fixup`.
> > + fixup_message could be a commit reference for example:
> > + --fixup="HEAD^{/^area:string}" or a suboption of `--fixup`.
> > +
> > + As `amend` ...
>
> My suggestion primarily started a reaction to that "As `amend`..."
> which was not gramatically complete sentence, and I ended up
> rewriting everything after "As `amend`..."
>

Oops, I must have written a complete comment. I will take care of it.

> But re-reading what is in the paragraph before, I tend to think that
> it places too much stress on 'colon' and should be removed.
>
> The comment is about what is being parsed, so
>
>          We limit --fixup's suboptions to only alpha characters.  If
>          the first character after a run of alpha is colon, then the
>          part before the colon may be a known suboption name like
>          `amend` or `reword`, or a misspelt suboption name.  In
>          either case, we treat it as --fixup=<suboption>:<arg>
>
>          Otherwise, we are dealing with --fixup=<commit>.
>
> would be good.  The code, when it decides it is not in the
> --fixup=<suboption>:<arg>  form but it is --fixup=<commit>, does not
> even care about a colon, so there is no need to mention colon in the
> "Otherwise" part.

Okay, I will replace it.

Thanks for helping out and guiding.

Thanks and Regards,
Charvi
