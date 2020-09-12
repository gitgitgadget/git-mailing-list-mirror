Return-Path: <SRS0=gF6X=CV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640ACC43461
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 14:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 185882087C
	for <git@archiver.kernel.org>; Sat, 12 Sep 2020 14:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAJM5Eyr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgILOBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Sep 2020 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgILOBh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Sep 2020 10:01:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943E0C061573
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 07:01:36 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id c127so7030428vsc.1
        for <git@vger.kernel.org>; Sat, 12 Sep 2020 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q5TxJwul3vZFr1QTnJBUxLN2Op+nac4IsQlCWvgpZyo=;
        b=JAJM5Eyru9Gv24g191+uIyL40SxTo/WqiIMJj8nNY4AnifNbYWh+t82AeV/u0ljpar
         PPjkLkCDFUFWIrRVY3V5us0AdF5AeKFjwYWjVArZBvYMMt8CS5RSoRlpQG5gV60F/htf
         5YdLI2sn2mOeblLanQ23m47xks4q3a/uipSdkTM9OfzqyZuFkpyL1Y+ucTpl2ydrDYil
         lZ7HVksQq/q0qwkha5gO2kD6lhlPYmNfNmE2oPcwH5sHaS8oIM4j+ZJ8clu0A937BDqw
         6A6f0U6wEK9hk8mPGBkjY3aUP39dcsq6xuI5jX64JmARE0ODKxahVs6MyYxILgKkc/gu
         dE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q5TxJwul3vZFr1QTnJBUxLN2Op+nac4IsQlCWvgpZyo=;
        b=SyzU6gQ3vW3aMiSvaShVmEMvOBv6DMdqCneoQkOTq8GA9zNPuq8ms9IIrRq0/F02eM
         6yKBMSZrkV+PvbRGbloU5So8oxLMm3C7E6k64XoXsIo9Ct+tFAkCR52QQsZROX+CMrDQ
         wbaSsuZ/9Sgmxd8PrxCSET/+Z38W7ZiMONq/gb0gZCmPG1v+oO+TyAcE4EoVSFQstdPT
         TIWbUoNOs136zmPuV4h9DXmWxMyGxSlmK5v1I4AvwOwkXLr8XWGVt5MyVR0jhhru0D77
         uMVoobcM3sD/GBbOrE5TzS6OTSE2584fiQ/Wr5qcdlRB7Ne4qOiNhNb8zZKOAnjHr9gy
         AIjg==
X-Gm-Message-State: AOAM532BoRJZG/VPqqI2Jzr779RZWH7dpLCJJvw9UEJpQnynl2fAXJ3Z
        UUW7kwAhrsnl1vqexSKcO1r5Dt+nb/Bj/DqxsSo=
X-Google-Smtp-Source: ABdhPJyjsvVMhpAOKCwMWM2LpqQjvvFsUwpGEwdkXAbUMv9AORRxA4LTO5ty7SEcYbQzFDYqC0IUtynqv1H7MrdzNg8=
X-Received: by 2002:a67:ca86:: with SMTP id a6mr3694009vsl.27.1599919294070;
 Sat, 12 Sep 2020 07:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599762679.git.martin.agren@gmail.com> <6d913ea3e0c30cc1dbcff05974b5d990797e8dc2.1599762679.git.martin.agren@gmail.com>
 <xmqq7dt1pe8r.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dt1pe8r.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 Sep 2020 16:01:22 +0200
Message-ID: <CAN0heSrFQFRPnXzp-UT6_jrwvVh+4EQMdOvkJaQCQxeg8GUG4g@mail.gmail.com>
Subject: Re: [PATCH 6/8] worktree: rename copy-pasted variable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 10 Sep 2020 at 22:29, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > As the commit message of 04a3dfb8b5 ("worktree.c: check whether branch
> > is bisected in another worktree", 2016-04-22) indicates, the function
> > `is_worktree_being_bisected()` is based on the older function
> > `is_worktree_being_rebased()`. This heritage can also be seen in the
> > name of the variable where we store our return value: It was never
> > adapted while copy-editing and remains as `found_rebase`.
> >
> > Rename the variable to make clear that we're looking for a bisect(ion),
> > nothing else.
>
> How bad is this copy and paste?  Is it a possibility to make a
> single helper function and these existing two a thin wrapper around
> the helper that passes customization between bisect and rebase?

That's a good point. I'll look into it.

Thanks
Martin
