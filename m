Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B127C433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 19:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiCPTwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbiCPTwL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 15:52:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718426D97B
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:50:56 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id b28so5547442lfc.4
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a2yHzUg/lWVovJa1reABCefn5ryQ9cIjfj0CVeBnde4=;
        b=ezHH6vIoGdAOcQqEjoRviKP0VMxodjvyztNsG+2Ur8uqLPuC/+HdM5YQhN6Ya+H/Oy
         eQV7rEmcw6tK+ah2WJviaKARbWmjeAvCOYd7a0m+eIyxIAAy3eDnQ9ViOFhn0Lxn096E
         zgJQGaoOlzkAGv7XZDJxyeoVviNkOTHGjw5UHL8OlD10UMa/IE42PezTriZVi9bn9l2T
         zrjD+h/MSCDJMtMA/GQM2jnfsbUjN0I7t7yb3Q4yuGaZZzjdHMLtSlP45nAk00i2YyBx
         rHMo8ESg2gMPFwwVA1zv/isDLq8Mi2fWedCcSJKmDCrrn+LvA0V4Dl/IKSQewiYe3WRu
         U+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a2yHzUg/lWVovJa1reABCefn5ryQ9cIjfj0CVeBnde4=;
        b=2yPTNaG97/sYcGeat6jt5CDI4Xa9bopYnmysp/dbM7WHjPj0qPk0TRE2QLMQ/kLCHA
         CudFHDP2HevlcUS58CZI0BnuCMVURT7/tqo1LYIetUAwL3JeNDllp4GKBEUK4i51y0qK
         C3OlBHA7ngVJv/L+UJMz7vddu7o7YTmWtQE5bcavs2fUJBr8+DgB6kx2bR2OKBbT2SzD
         NXCL8EhlfrbmZ/EUUb76idbvtT/5f7N6qu12zJBNoewIWmjAVgb2TTITV7VI08d3mQqb
         rUhuO6j/aHbFI2llUF7a3BfnvtA3cZ/ufLZ05xT1vSKepzlvqeDBxJ69pUjQ7jV/5/oc
         Crog==
X-Gm-Message-State: AOAM5322Qm3MleZRTTcMbUwguxjy7EMEiTJQnzeNRFOvGh2/YRYHrYbE
        OxIfHJkg1/F5ndxksD+u+hfDX/yMNCk+76gEN6Y=
X-Google-Smtp-Source: ABdhPJyZFTo7xOjq/71a0Gv403jWCzbPN0XaNYz3vd9J5vtgWHkyDlu38nYpuDM2FAEOmsFmlW+AEK3+i7nzYkRbjgY=
X-Received: by 2002:a05:6512:1155:b0:448:bcee:3df0 with SMTP id
 m21-20020a056512115500b00448bcee3df0mr733270lfg.442.1647460254628; Wed, 16
 Mar 2022 12:50:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <a77d02df626ed6dff485e1342ff7affd6999ec44.1647379859.git.gitgitgadget@gmail.com>
 <xmqqbky6bgw0.fsf@gitster.g> <CANQDOdcak1nV1Pr9cmyk9dgEjHOH8Au92pUMskJipUodzskzqQ@mail.gmail.com>
 <xmqq35jhoows.fsf@gitster.g> <CANQDOde+3QaTWnNWPQzz85iAGH=M-ZhG-HDR9SP4FCJf+=k43A@mail.gmail.com>
 <xmqqpmmllqf5.fsf@gitster.g>
In-Reply-To: <xmqqpmmllqf5.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 16 Mar 2022 12:50:43 -0700
Message-ID: <CANQDOdc=df=iBmyEs4chcPEOA1-1S-isWDSeWTvyi09B4ewAfA@mail.gmail.com>
Subject: Re: [PATCH 1/7] bulk-checkin: rename 'state' variable and separate
 'plugged' boolean
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 16, 2022 at 11:10 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> >> Did I get it right, more-or-less?
> >
> > Yes, that's my understanding as well.
>
> I guess what I wrote would make a useful material for early part of
> the log message to help future developers.
>
> Thanks.

Will do.  I changed the commit message to explain the current
functionality of bulk-checkin and how it's similar to batched-fsync.
