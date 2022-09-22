Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FABC6FA82
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 15:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiIVPVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Sep 2022 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiIVPVG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2022 11:21:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 820FDF3930
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:21:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a26so21843677ejc.4
        for <git@vger.kernel.org>; Thu, 22 Sep 2022 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=a7vV4EGFgsdcyNeT9m47y1Hn1rxhi+rdT/GtjdmPp/U=;
        b=U5V1TXylB5NuW+up58xTQ6sNi8yLxpYUm747S9blS68JFrD+2cPJr4WjqfIliFUTeb
         2ZX5/YCTV3DZPFUTtFF7Yc8zMf98Z/4qd78RvcEJJrbq+sStV0rU5Q00Eji7e2YjZmmc
         MCjE5wvrhd07NyiigjUwqI6RE1m5MbwUki5L0O65/9175/VxoWJ2zH2n7kiJGGpssrbg
         PzpIZWz4Ztj3o+hWmOp6SuwqDD6xPw5Q5xlmwOzZ2H/ARQPhVaaFfVKhV6GAlJe1KiUt
         SbWVwMucP/ne5V1fZciPtSO5+u0WLXyEruNRnlPpLCLlTiQzD/c6SYjwh8CHuUvxo4Mk
         eVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=a7vV4EGFgsdcyNeT9m47y1Hn1rxhi+rdT/GtjdmPp/U=;
        b=eml/A0HPvVHIzK/yZI9S0aj9Bvy560GOkORjzG83W4O2v1FT2rm7oFSpCcAn6RBxuR
         dxBD5NXjmP2NLGQy5tPrK7zYIE4cXqDCAX9zBGJlStByiSfD6G7J1QcC7M3+ihG3t9e+
         33y8FWHIkq/iC/hYms9Sqn0VQpTURnVXErJk3AUfJYJMlQ6eaoY+D6k1nXMGTt34T4xn
         3uoUA3403tRGUIjSJbAgJULWJol+JwqTI50R7DxM55kUucP8h4JHmwRv52OcTJTHVuJK
         I1NUlu5ouXf5EZIHOU1DptPAFWPuL1eaRwFi4/59IdazHFn2c33/FyFtOmDUH8zI8UmM
         CvNA==
X-Gm-Message-State: ACrzQf03cSWEFmdL0YwTNn9RxbRhAZLhN2THIc+4nfqbPt0fjUtiJw93
        PhOd0q3Yd8mZrSsQ/DyJh/4qidlHJkoKlH3STZ0haQ==
X-Google-Smtp-Source: AMsMyM4IiM4pE0WYvSLtNQGEtWdVWYPJiJgS/cN/xsYhKBevBFDHYxOJ6n3LLQdE7RtUuUPFerATzA+yLF7ZInxa3OE=
X-Received: by 2002:a17:907:1614:b0:780:633d:c7a1 with SMTP id
 hb20-20020a170907161400b00780633dc7a1mr3427501ejc.708.1663860062875; Thu, 22
 Sep 2022 08:21:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
 <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
 <CABPp-BEBB1oqdVcXrWwMAdtb0TwHZvr-6KDa210j5ncw54Di_g@mail.gmail.com> <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com>
In-Reply-To: <1c2f6cfe-a6db-c06e-5313-f5b31be42c8d@github.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 22 Sep 2022 08:20:50 -0700
Message-ID: <CAJoAoZ=yc+UA7G0MBpJYVCQ6symMQwPnpfK8Wd=sf6ebB1XOhA@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren <newren@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yeah, that's a weird one. I wonder whether the partial clone filter
setting should also imply a config shutting off diffstats?
 - Emily

On Thu, Sep 22, 2022 at 7:24 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 9/21/2022 7:36 PM, Elijah Newren wrote:
> > On Wed, Sep 21, 2022 at 8:22 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> > Here, we do have an object download, which occurred after the merge
> > completed, so there must be something happening after the merge which
> > needs the extra blob; if we keep reading...
> >
> >>  project1/file1 | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >
> > Ah, the 'helpful' diffstat.  It downloads blobs from a promisor remote
> > just so we can see what has changed, including in the area of the
> > project we don't care about.
> >
> > (This is yet another reason it'd be nice to have a --restrict mode for
> > grep/diff/log/etc. for sparse-checkout uses, and an ability to make it
> > the default in some repo, so you could get just the diffstat within
> > the region of the project that you care about.  We're discussing such
> > an idea, but it isn't implemented yet.)
> >
> >> warning: This repository uses promisor remotes. Some objects may not be loaded.
> >> blob_count1=11
> >> blob_count2=11
> >> blob_count3=12
> >>
> >> The result shows that blob count doesn't change in git fetch, but in git merge.
> >
> > If you add --no-stat to your merge command (or set merge.stat to
> > false), the extra blob will not be downloaded.
>
> This is an interesting find! I wonder how many people are hitting this
> in the wild. Perhaps merge.stat should be added to the optional, but
> recommended config options in scalar.c.
>
> Thanks,
> -Stolee
