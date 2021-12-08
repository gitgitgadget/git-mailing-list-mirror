Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E3C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 20:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhLHUuG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhLHUuF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 15:50:05 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C2C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 12:46:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u17so6238372wrt.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5T7HdgL0ceKA90UeWUE8ztOJdiSeqEzJK5cHx4yMtuw=;
        b=PCOe9tBftQbXoE+wEkXGCIuFlArKEQ5NfWfCBhx5R4Sef18E9Q6NPwSDGncqoFnHnI
         dkW/HbAnztWepIelpzHIesL191gN8YLS1MbLoTtMaTdYHv3bad3vSTMGwehJOXqEQ+Gz
         5TfK7xJlILfBkv6lwECAMACtiSHMP0ejyqo8szWUHEI4YPtDcgKoRWKc72OMcwR0o/8p
         Tsmzn2XBfyfe11O+bdkGSSNwjK0OxRrTo+xOEigcE99EbEW0lCK/Zsf4JRLtMHfyDjWK
         hGk19Pic8dzXukyTWv4S+GeXM/0s8g2Gmn9+pp0CtRiw4v4jqyz6nVFvCKLVNW0W5kaR
         /seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5T7HdgL0ceKA90UeWUE8ztOJdiSeqEzJK5cHx4yMtuw=;
        b=HAfzo9qesN0AFJ+ZwflQ7vsmYAKgx2mi0mGPWA7wIsJIfyiJarjQlfLTC8HtirSNQX
         dRwPhsPhBdu9ySPOdf19OJyUCkKxzgre8mp9ZNfEAKN1m9LdApfpj7VUw2I/+4wdHrmY
         33+HewVa7ly0GGXdm7guPeKmdPcukC0fbRlx90Y845waey13Gw0V8La7sUkKg7mUQ0vs
         thGsXqTNr1fYAuwOr2ti8oHQNnwjRV9GHABJHYFG9MS82B645ZRyal9mAsTEFuev+aTo
         qx6illykczilHPhJfRzrP6hBIo5SS5LhuNF+746VsymkFOGl7KEHs2xA8DPFMXuYrJTW
         92pA==
X-Gm-Message-State: AOAM531p2mOv4db85pvQArMYfXxUPB/2xJkO9bZJY/Xs4grN6XBl/AAQ
        upsYpMVhJxEQbEtBfDS/TH83aNi7y9a01GBVdlgZvWG6
X-Google-Smtp-Source: ABdhPJz8eRQEUBHN43f+32nj3fVhl7AYdAVDCGOwn3Rot/k0tM8Fo/Qw7ah4enlVVGc+QAUZlg+bYUN9en2H8ged/lw=
X-Received: by 2002:adf:f98c:: with SMTP id f12mr1252215wrr.184.1638996390880;
 Wed, 08 Dec 2021 12:46:30 -0800 (PST)
MIME-Version: 1.0
References: <CAK1xKQpUFCkv6fopEykKLxAEoG_Hf_Zz+oRR70mR3pWsN5YDDw@mail.gmail.com>
 <ac3a5871-b009-f84e-d1fe-af4bde1bbabe@gmail.com> <CAK1xKQr1_52n5rAhQh2awsb6SkgUYOMWoLichtBRLvtDXRQarQ@mail.gmail.com>
 <fc38a32f-91e2-fe49-a7b0-e2e6851271c4@gmail.com> <CAK1xKQppM3oseB=vdXbDbPjDeFxd9kd0jULcaC=ASkMsKiDCmQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2008101645410.50@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2008101645410.50@tvgsbejvaqbjf.bet>
From:   Joel Marshall <joelmdev@gmail.com>
Date:   Wed, 8 Dec 2021 15:46:12 -0500
Message-ID: <CAK1xKQpTUqLLZkYuFEOx7zy8wOib_ohwmiqt89qoj-rK8tnZ4A@mail.gmail.com>
Subject: Re: Possible issue with rebase's --rebase-merges option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Sorry to drop off on this for so long. I think this is still a
possible outstanding issue, yes? If so I will work on getting you a
copy of the repo as I did archive a copy at the state originally
mentioned in this issue.

On Mon, Aug 10, 2020 at 10:46 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Joel,
>
> On Thu, 23 Jul 2020, Joel Marshall wrote:
>
> > I saved the state of the repo in a copy so I could come back to it if
> > additional examples were needed but I had to clean up my live copy so
> > I could get back to work. I'll get you some additional screenshots in
> > the next few days. In the meantime, I'll try to give you some context
> > around what I'm doing here. The parent branch is my main dev branch
> > which consists of a series of clean branches and merges- the dev
> > branch basically looks like what you're seeing in the
> > --preserve-merges screenshot. I've also got a long running feature
> > branch that branches off of dev, and it also consists of many branches
> > and merges, each a subtask of the story related to the feature branch
> > as a whole. Occasionally to get the feature branch up to date with the
> > newest features I'll rebase the whole thing on top of dev, which
> > should result in an unbroken chain of branches and merges as seen in
> > the --preserve-merges screenshot. While you can't see it in the
> > --rebase-merges screenshot, those merges show no ancestors when viewed
> > in reverse chronological order- they just trail off into oblivion.
>
> I could imagine that you might want to try this rebase with
> `--rebase-merges=rebase-cousins`.
>
> Otherwise, you might want to export your use case with `git fast-export
> --anonymize` so that others (such as myself) have a chance of helping you.
>
> Ciao,
> Johannes
