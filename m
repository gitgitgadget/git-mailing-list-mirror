Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE901C433DB
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 09:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D6D64F02
	for <git@archiver.kernel.org>; Sun, 21 Feb 2021 09:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhBUJU7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Feb 2021 04:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhBUJU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Feb 2021 04:20:58 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE2C061574
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 01:20:17 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id h17so10959660oih.5
        for <git@vger.kernel.org>; Sun, 21 Feb 2021 01:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8aRDbr3dsSiSbZuBkg4De19IQecC7VjEpMdImBLoNBw=;
        b=GHvUOwBm6sqAoHSx0oK562FHeH5PwHh9vx7GXv3dlCPCMkdv4MCB+VM7bKndx7pUFv
         hOO/jfJwOsMtjU4fSe3f9ma5dPCV+cXa0zH1XplCmZH+u3AFTtl7yig9DFE5TeHGMFhr
         Bim/j0Y5TYJZi/rFYG6OT/vL6VkULLKMaRAsT0zvo7z+XfVub5KQOgRh+FL3MX39eQz4
         8TWeeTcCM8FtT/iiIHvHOQUhABZLp02TcalmxvaoLWq4t2StoWfCHjawoeJpcIxXVeNi
         3I35HFZSCDeJSCvNavxcjq/XmPgFP5qIsEQmEuxh1NT8o49QwxBPzfIOctP8qoXzwAI3
         OzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8aRDbr3dsSiSbZuBkg4De19IQecC7VjEpMdImBLoNBw=;
        b=BAjcoetRZTgcIr8bSPyCKWyB8H5s8kDzeQxyejktnShS1/BUdB4uUs9v/DXV+hsSTQ
         7AqQa4O7P628mwvqEuW0uxifNvqIodXpIXE+eXFP+trl3S5/MS3DVBDQ7Ew42zqVUXLL
         F1oLruCyceV7qzFAPBCJGH5dNX+ArIKL0aQ7nklzL1pqHZ48RNh9E3Rfvcgi1we2VqaX
         28j3YNKOv93S/Cn6Lf5umoP1DSl0LVY51y3gGbQ5OO0V4/mJ51lor01eyFOFHF5Idr1P
         JstFlp2RQ/tpRuLXoIgSsY/1ElMmd3klqJ2msX5X1F9hMAYoFxVSqaSHblbTQAYEBdo3
         MoIA==
X-Gm-Message-State: AOAM5300D14+f0MWi7ZWs+FXy8QPiD+vtrMqAy7mr8xHLj9urTnK6JBH
        oeVBIkS/ociXx2V5MJeS8/7UmAgSgpdAxIFyNR81+Bt9oUKZrA==
X-Google-Smtp-Source: ABdhPJxx685krGUCp51xUL0IxRYZGH+AcaVewg901gjQu3EcOGu8Zv3zIohpbdF+KW2GeQaD3m1+XNLIa6TV/rrHw30=
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr12447098oij.48.1613899216930;
 Sun, 21 Feb 2021 01:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20210217072904.16257-1-charvi077@gmail.com> <20210217073725.16656-1-charvi077@gmail.com>
 <20210217073725.16656-2-charvi077@gmail.com> <xmqq35xulbj0.fsf@gitster.g>
 <CAPSFM5ddkALLCU+k+Th=pvKHEaarr_45DSn=N5DCJu1o7_5-Eg@mail.gmail.com>
 <xmqqpn0xfal8.fsf@gitster.g> <CAPSFM5eJNUdzy0CA1GNjNkqL_a7ivM8qydxvHf3208nznkG9KQ@mail.gmail.com>
 <xmqq4ki7bf9y.fsf@gitster.g> <CAPSFM5cRq9OfxypwTAsv3OFpTPM88e4_agTmFEGbaVyLi6Qbig@mail.gmail.com>
 <xmqqtuq599zj.fsf@gitster.g>
In-Reply-To: <xmqqtuq599zj.fsf@gitster.g>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Sun, 21 Feb 2021 14:50:05 +0530
Message-ID: <CAPSFM5dZ=CR21eqE7Y-4AssD9h0ddnUYpy4PSzWVaf8kzsLv_g@mail.gmail.com>
Subject: Re: [PATCH 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 21 Feb 2021 at 12:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > Thanks a lot for explaining each perspective in detail. So, now if we
> > use `-m` as an option to write side-note then `--squash` is already
> > available and for fixing the commit message opening the editor is a
> > must expected option. So shall we remove the `-m` option compatibility
> > if `amend`/ `reword` suboptions are passed to `git commit --fixup` ?
>
> FWIW, I do not have a strong opposition against -m/-F that is not
> rejected when --fixup=amend is in use.  It is OK for Git to accept
> useless combinations of options that do not help end-users.  A
> combination that is not useful will be left unused, which is not a
> great loss.

>  So, if it is more work to make the code notice when
> these options are given in useless combinations and stop with an
> error message

Sorry I didn't get this and would like to once confirm here that, are
you pointing to output an error message when the `-m`/`-F` option is
passed with `git --fixup=amend/reword` ? Because I think we can do
this also. Otherwise ....

>than just accepting and doing useless thing, I am OK
> if we left them as they are.
>

> I was just hoping that letting "-m <message>" and "--fixup=amend"
> used at the same time would support a great use case, and because I
> didn't think of any, I asked the person who allowed the combination
> (that is you) what the intended use cases are.  Actively supporting
> a combination because it gives users great value is more satisfying
> than just leaving useless combination to exist only because it does
> not actively hurt.  When users say "The command can take these two
> options at the same time, but I cannot figure out what good the
> combination is for. It feels utterly useless to use them together"
> it also is much easier to answer them if we can say "because by
> using these two together, you can do this great thing" instead of
> having to say "we do not think it makes much sense to use these two
> options together."
>
....If we allow both `m` and `F` to work with `git commit
--fixup=amend/reword` with the same working as it is doing now i.e to
use `m` to write new commit message, upon `--autosquash`, If it is
okay? then I also agree to update the documentation more precisely and
include the uses when passed with `m` /`F`(not yet added) option.

(Please correct me if I am wrong)

Thanks and Regards,
Charvi
