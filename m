Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F8C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 07:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA21223107
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 07:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbhAQHr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 02:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbhAQHrT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 02:47:19 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088E4C061573
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 23:46:39 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id j8so3364605oon.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 23:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5464hIXAzdL6lQxMLod/GzGP6bSD4iwO8XBoFDJd4X0=;
        b=LDU87m99HX4pVvdbR871NrbmQWM1OkP8juDs/Hpb8RjkUyQZ0o6rWnGeYApj11Sdex
         8U/eSchABlZow1u+I/eeRijpL2MLCFRE5YZpFMioeOuBN8IRMDTxgBH/s/btZQwdizpX
         QbzkMh2M7Yron5oGX/loN0djhzQh0puomjYedk9Km1oCjW7vrCdHtKMURDPtHcUwZQYF
         X7g29Mf4u41b4a3vD3tYGYUr6+0MgWlXGkxWm1/V1E6rqsJZFiYYJNxvP+waR/HMckTX
         vao3UGs/G0yqBoQfyyJ9JRQG4PPZ2HKz8/lXH2LRAZLQ8IayASjpCl/T5BjgHZkdfnBa
         LxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5464hIXAzdL6lQxMLod/GzGP6bSD4iwO8XBoFDJd4X0=;
        b=eTm8PyLNVYXQ2Dlo+u13bvnPSmROR7pqJkl6SUowN2hei91CPZtcZ23yth/v0zIBYu
         Ietr9yM1wNC6r7d1anKTvPjBwOdaNWG4Aut8cfNsrqs3E6hsfCWVzHj0U2NApjdVExGB
         I5/uy+A+mrox0ceApr9slpC2I/YgoMVYdT2llcFfUD6aB9lWCPTFA/hvf74c1nNYSGOt
         whC+qKh2xHaihvGBGdFbE9vAGtuhZwsbcbjHzOlRBBQEZiM2FDdq9fai6Txg/ydqk5Q5
         34/gP13CBp46pt/GRtha4aTsVrmSyUkr1JxsiUEC2IunxcTnHB093Luu6EGIBP/IxpF4
         PlOw==
X-Gm-Message-State: AOAM533tR69m+Sg+UlKFWSkO5iTVMexXAhP7pQBY8R3+bBAly/FEOjv/
        FW2R3xPpzqlU2jv5SEuS68rvkaNzMJDGNh4Pioc=
X-Google-Smtp-Source: ABdhPJzxi1z51NktVu/bdHSmTVWW4Z2XCCzffyNL0F5O5Zc/C6CwCFkRh/+tlLVWwrn0ei4WEW9dgcvOI+xwdecCvOU=
X-Received: by 2002:a4a:6c45:: with SMTP id u5mr13866733oof.61.1610869598176;
 Sat, 16 Jan 2021 23:46:38 -0800 (PST)
MIME-Version: 1.0
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
 <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
 <99b40665-45dd-6c4d-d46a-56c7dbf89568@gmail.com> <xmqq7dofxnru.fsf@gitster.c.googlers.com>
 <CAPSFM5cEnex1xaBy5ia_xNFDNzt5_Y=W-6TB9d9yW_AiPAKxDg@mail.gmail.com> <xmqq4kjgnpxf.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kjgnpxf.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 17 Jan 2021 13:16:26 +0530
Message-ID: <CAPSFM5eiZF0hqckUyx-Ak0sHs1RYcWEE_Db1G+6i=thhrObj=Q@mail.gmail.com>
Subject: Re: How to implement the "amend!" commit ?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 17 Jan 2021 at 10:03, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > Earlier, I thought to implement the UI of amend! commit as :
> > "git commit --fixup=a/amend:<commit>"
> >
> > So users can either use 'a' as abbreviation or 'amend'. But I want to once
> > confirm if I got this right ? As I am doubtful about, what does allowing to
> > accept any prefix of "amend" and "reword" means ?
>
> It means that all of these do the same thing ...
>
>         git commit --fixup=amend:<commit>
>         git commit --fixup=amen:<commit>
>         git commit --fixup=ame:<commit>
>         git commit --fixup=am:<commit>
>         git commit --fixup=a:<commit>
>
> ... until somebody more brilliant than either of us comes along and
> invents another operation that sits next to 'amend' and 'reword',
> say, 'annoy'.  At that point,
>
>         git commit --fixup=a:<commit>
>
> no longer uniquely identifies a choice among three ('amend',
> 'annoy', or 'reword') and you'd give an error message, but
>
>         git commit --fixup=am:<commit>
>
> will keep working as an abbreviation for "amend".

Thanks for explaining, now I can relate with the previous discussions and
will look around for the implementation in the above way. I think may be we
can do this while parsing the options and checking for the list of prefixes,
I am not sure but will look into it.

Thanks and Regards,
Charvi
