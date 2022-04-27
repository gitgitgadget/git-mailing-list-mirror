Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21DAC433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 17:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiD0RxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiD0Rwv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 13:52:51 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672804707B
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:49:30 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id d132so1273644vke.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NuuiM0g0YOXC1PTL/PyRM24khIjPYjFxLZYsP1pUh4=;
        b=V2JTQzeDF1oHp5Jn1AwwbNJAmq8Byn6/fOdFKEKx8qjxp/RhStNFKrpuCXS4D2lCZR
         b6cOKHrhzpX9EKRrPeEMmiA2pZ9TD1+CpJ6m2rQXyRgquryZvEW5tlvI31naiF1jdc3z
         pY+KwrNbxQuRrf9bfYXmECi2dAf8hNzQiXioUbe5yd5hNlm2UFErSTecrJfJdElC2V8D
         euDIPuiRRNjAeFV1A7ZiLXGPvnHWWbQxfFYVhexQFaPFncNJ71htCuxV7q2JPD0RKxvS
         2iqiWbWagL6ojHo9KIlFG4vyJWHYG3RRLR/uajZKzpggPfWcR9Ncxyg/mmk5oqXZ3juC
         03Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NuuiM0g0YOXC1PTL/PyRM24khIjPYjFxLZYsP1pUh4=;
        b=FNBFGLIOy57rYOahYaOpluc6Uhty5ga27L5CoZIT9dHFOwsf1F9/MrYLxZpGwQVrhA
         LRokgnEHdKLm60IGDrC2QebeS0d+wraVcgAoJfavgaTCRnJ+VsMDIXsvlpYOTT/m7Khm
         uNAajvl9OTxuYRkBrWbJWjZyHH7Z/ebr5aNpEhDTd1brsq2Y9WQvdWrtrb79yAbC44KK
         aedHBX563zvi4wVq6yybAQMCsF3BVFWM379RZcK9fnIrxlT2S3e7A8jTXWFmE5ksjXUb
         HZhTQuYx4IV6YkiFiSUR5qsORmlH/ITsMG4fklMQ7w2FQY2kjPxLvMbjNE7wrkJG1w8L
         q8hA==
X-Gm-Message-State: AOAM533VcSkDJJ0dgiUctUentdaQvzbH2YV3ev52A3oLjmrPT7CjHl2/
        RCPUe2oLb+J6x25yJwjST0I7zThYbeBZ7JZJJjI=
X-Google-Smtp-Source: ABdhPJyS+2G4t6r7se1JTLB9YYR8UCnad1Cm951gQ8cw/oFJbg8O+rdLQW88WwkUme4moG9m9hRlQbdAYpnWhzVRqDs=
X-Received: by 2002:a05:6122:1348:b0:34d:a565:3e3e with SMTP id
 f8-20020a056122134800b0034da5653e3emr4234491vkp.14.1651081769650; Wed, 27 Apr
 2022 10:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220426183105.99779-1-carenas@gmail.com> <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com> <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
 <57217c15-c6d1-32f1-a481-0003ba66e342@gmail.com> <CAPUEsphumEJ=qBM9c9WLJ6fzL=mcK2+3fUViyHEvttaD-DsOgg@mail.gmail.com>
 <6c3b447d-9419-982d-678c-6a6c0ff8cbc2@gmail.com>
In-Reply-To: <6c3b447d-9419-982d-678c-6a6c0ff8cbc2@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 27 Apr 2022 10:49:18 -0700
Message-ID: <CAPUEspjoTYtv9K=rvpkFnyGnEz_uxefED820rx09b6qGG93SqA@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 27, 2022 at 10:28 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 27/04/2022 17:54, Carlo Arenas wrote:
> >
> > the only thing that worries me is sign extension but that is why I put
> > a specific cast.  for all practical reasons I expect uid_t to be
> > uint32_t and therefore using long should be better than using int
> > (through atoi)

Well, just because I think that is the most likely option, doesn't
mean it will be so since it is not defined as such in the standard.
I should have documented though that I was (probably incorrectly)
prioritizing the possibility of supporting negative uids instead of
positive uids > INT_MAX.

This of course only matters in 32bit, but looking at sudo's sources
they use "%u" to set the UID in the environment and therefore we
should change our approach to match.

> If we think uid_t is a uint32_t then should we be using strtoul() to
> make sure we cover the whole uid range where sizeof(long) ==
> sizeof(uint32_t)?

strtoul is sadly not very portable, but I think you are correct that
it should be used instead
originally I thought it would be better to do strtoimax but that will
also require moving this function around.

Carlo
