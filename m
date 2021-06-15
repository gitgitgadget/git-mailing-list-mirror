Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA58C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575DC610A0
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 18:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhFOSOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 14:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFOSOw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 14:14:52 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45645C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:12:47 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so15192879otu.6
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FO3Jh2Z+sUqNQ8oxQqZhhCFKSQOaXFS0vYaId5VIb4k=;
        b=KcRdjMRL7igA7BUXzUKA7iafxgKmidoroVdN09lMMl6vqHechiGu2knzDqtzbL8L5N
         rqKG2KAohur04EnLhtxfDzFpo6U+0u3d0ZnP6CzV9zyMKGif3EUucGUj0LawYjLkKcm5
         DhPz2YOM1AnOwvQ3Z/qbULJu5fCUhpBi++I36g0r5x6npaRQem/ETYKJukvkxyzOsB0j
         FCfg2wtM7AHYSTaZaGPTaCC1SfBz2MClzOoL2lPdPIJw3dfB4U1bVcZHw8r0ICXZpoYz
         +LvhroI2DQZFuY2lxCeVTG30O/K+Zlc7+9UDRobd4cC9ZP31x53aEIRg6WHjfi0qseWu
         RmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FO3Jh2Z+sUqNQ8oxQqZhhCFKSQOaXFS0vYaId5VIb4k=;
        b=qHgNBM8gsoh261g+WQJWgR3T7ZWPYV6pjxQGygVG3GyHcS5x4dmsprr+JxMTIEWGoO
         +99q19v5Ayz8j95+xkDYB7Xo7AhP3TPfBVazqY/U9MCqDiDFsApjgxaInvdHsDJzy4QV
         hYWEzHyIiAwiYKyUVumoQYRE6Bc0NYuVlTgjmPd/agZu2VXFEaVSX954irB/e3y3hFU0
         dEY1Xi4U6UZxVHYmpYR+WnJjGY6GL/Jed6gR/h1M22IxsfBKIksoqC+9Qz3AOR5d06TG
         ygEWlI+OtNQVidRYzeIZXtq0BJK0CvAfnvsMCQgXmR2B9C/gZVBpJi8ewDcDKo5SgaOo
         pc1w==
X-Gm-Message-State: AOAM533PXh8a4eG9XatFgb0LXXFf3jQfad7p5GUvY1K8YCIdDhZsHQwt
        3JgLDjpySCkz4M4E7WgFoRzTz/QOwDzn+0am/2+OlBj1ACk=
X-Google-Smtp-Source: ABdhPJwpjXrWSK23GWKx3chZ37iQXT/bLmUG5pkkRcoTdtQY9B8Q5pSXT1QihsTIJHmlzN9El/++o53POX7Jzse+aLY=
X-Received: by 2002:a9d:426:: with SMTP id 35mr450821otc.162.1623780766616;
 Tue, 15 Jun 2021 11:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <b7561a67c192d4bdede47fee5b7b1cb30c44b785.1623734171.git.gitgitgadget@gmail.com>
 <60c8758c80e13_e633208f7@natae.notmuch>
In-Reply-To: <60c8758c80e13_e633208f7@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Jun 2021 11:12:35 -0700
Message-ID: <CABPp-BHjXf88MQYX8Fd3WGw2WfbMKAdAD-MEViiB7oTtQbfTyw@mail.gmail.com>
Subject: Re: [PATCH 1/2] xdiff: implement a zealous diff3, or "zdiff3"
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 15, 2021 at 2:40 AM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > "zdiff3" is identical to ordinary diff3 except that it allows compaction
> > of common lines on the two sides of history at the beginning or end of
> > the conflict hunk.
>
> That was not the main reason behind zdiff3.
>
> The whole point of zdiff3 was to have something closer to the "merge"
> style, even if not technically correct.
>
> Your proposal is better than diff3 in that respect, but worse than Uwe's
> zdiff3.
>
> If you have this:
>
>   l  b  r
>   =  =  =
>   A  A  A
>
>   B     b
>   C     C
>   D     D
>   E     E
>   F     F
>   I     i
>
> merge will output this:
>
>   A
>
>   <<<<<<< l
>   B
>   =======
>   b
>   >>>>>>> r
>   C
>   D
>   E
>   F
>   <<<<<<< l
>   I
>   =======
>   i
>   >>>>>>> r
>
> This is simple, and useful.
>
> diff3 will output this:
>
>   A
>   <<<<<<< l
>
>   B
>   C
>   D
>   E
>   F
>   I
>   ||||||| b
>   =======
>
>   b
>   C
>   D
>   E
>   F
>   i
>   >>>>>>> r
>
> Not very friendly.
>
> Your zdiff3:
>
>   A
>
>   <<<<<<< l
>   B
>   C
>   D
>   E
>   F
>   I
>   ||||||| b
>   =======
>   b
>   C
>   D
>   E
>   F
>   i
>   >>>>>>> r
>
> Just marginally better.

Your example here is one where diff3 has no original text in the
conflicted region.  Empty text is trivially easy to split, making it a
somewhat uninteresting testcase for zdiff3.  The interesting question
is what do you do when that region is non-empty?  When it's non-empty,
it's not going to match the two sides (i.e. it won't have "C D E F"
lines for your example) -- we know that because when the original also
matches the two sides, the xdiff code will start with multiple
separate conflicts instead of one big one.  So, in such a case, do you
still decide to split the conflict regions, and if so, how do you
split the non-matching original text?
