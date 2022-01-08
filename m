Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B5DC433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 01:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiAHB2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 20:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiAHB2R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 20:28:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986E2C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 17:28:17 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id m21so28768284edc.0
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 17:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzKzFe2kq9Rgf7njNqdxUizx04/NG8X38mfgR6y5TxE=;
        b=g7qHy9eA0mh27w8b3xB4duUsLNxmiTQ/5xmTl42c/dwzRldiI8lkLJwyXcgU/RwZRb
         Oozax576jMknv4SteO2G2KjZ/MwxsUNc3U8Mda1OYe3nJkKQrMejTiCW5JfEUS2xVrt2
         qyEvPoNC1Jd4QQBUkeFzKCG9kAWOw4VyY7WTfwsQQua31ETypHO13yho5in28eCZ0cT6
         V8oWAYxJjX749ncluKzkPzhvzq4sl9NpLdIJys8F8Sod//fcjSm311H+9ErCKKy7nnDT
         qb+gYr6JLnq/43hjnQAxL8IY4gA0GrZ0t7AltWq1Bb90ENnla5+L0eWustbCrCtg9T1D
         4chA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzKzFe2kq9Rgf7njNqdxUizx04/NG8X38mfgR6y5TxE=;
        b=Q+Kmm5JEox2Ip4NNcnTfoEl8gpeuLgWxohE8ftWnLAQY97gMZL+yZRTr3N+v02El/k
         llXT+DFOUVzn9DAtylp4zswPxio2d7O7Za0t9iDoxAAQj3kvwoT3bcizDola06ViuwdQ
         z7lTMul3OvGLfGpfPWf/VlF3T842E7+ArRf6fx5/YELfihr+5SkGkxQcRP9lf92h+X0T
         5/FSZK6SfDLGjpifLa1aDnoFwxrkvM/44+3uWV4pwOjmDBNPSAEdUf1DMSJn5njL2lja
         Hzns6Fy7uWvpzTulFE7VUHXoPhz/Np58etTVqeJNmniOS4u6let5c5kJ6Qggs4zLwBQS
         F4mg==
X-Gm-Message-State: AOAM530kj1WbRF+3vJELGdwOEGzN5N5RThZo7XNZTxBc+cGn7gg5lOAF
        5j5snVnpGpswxy6Lf/dBbh3jJuMlPlDIH/1s4HQ=
X-Google-Smtp-Source: ABdhPJzLaQIzRpecRm5iJ5ofqU49QFimGUNWHC4LJjoT0vjkJHtcIUdNWy9jMoS3b2wXKsz0L55EIx/4MXn/puSgd8o=
X-Received: by 2002:a17:907:3f1e:: with SMTP id hq30mr50665132ejc.613.1641605296211;
 Fri, 07 Jan 2022 17:28:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
 <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com> <01364bb020ee2836016ec0e8eafa2261fb7800ab.1641403655.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2201071908580.339@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Jan 2022 17:28:04 -0800
Message-ID: <CABPp-BFCvOkC1KSVm3qKUcaBFV0pUg4MJf5h+shj=TFZzWscUA@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] merge-tree: provide an easy way to access which
 files have conflicts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

One more thing I forgot to ask...

On Fri, Jan 7, 2022 at 11:36 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
...
> Mind you, I did not even get to the point of analyzing things even more
> deeply. My partner in crime and I only got to comparing the `merge-ort`
> way to the libgit2-based way, trying to get them to compare as much
> apples-to-apples as possible [*1*], and we found that even the time to
> spawn the Git process (~1-3ms, with all overhead counted in) is _quite_
> noticeable, at server-side scale.
>
> Of course, the `merge-ort` performance was _really_ nice when doing
> anything remotely complex, then `merge-ort` really blew the libgit2-based
> merge out of the water. But that's not the common case. The common case
> are merges that involve very few modified files, a single merge base, and
> they don't conflict. And those can be processed by the libgit2-based
> method within a fraction of the time it takes to even only so much as
> spawn `git` (libgit2-based merges can complete in less than a fifth
> millisecond, that's at most a fifth of the time it takes to merely run
> `git merge-tree`).

Out of curiosity, are you only doing merges, or are you also
attempting server-side rebases in some fashion?
