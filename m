Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D59C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A59BE64E1F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 05:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhCOFmZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 01:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCOFmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 01:42:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E93C061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:42:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id e7so15816274edu.10
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVqsgeSZXRjSL4Nd0xIheqgwZk5T6p6uNnVaoxv3OCc=;
        b=alyjcFtXDKIIS5dwfHZofKBL/uk3XTgYwWK4AKhqvxzsiYhCQD9NwhN6VJTafYJQSA
         yh+XEVbZmti/uNuWfjv73/fnlunz9dc5KvAZUEA0gApvNo0JjIjMVL0w9A2siXgu8hh+
         M0PSjoW/Hh+NOMpDlzGs6RmETg33fpE8xx1i0BS1cQldv5f3zDRH4OR60RbhqVC4Unng
         9XEyvtRf/18Txi5c6+NjDCX0NblXF3oVBxHPdJ0VI+p8i2HL8RtJTKmBtK8BixfQRgmp
         UJ/3a1Zz+zbJT3vo1A+sTAWtEEtp60k1WK9D/aeRSN2HQbCNfeywyeVF3r+ixDeP3uk4
         lffg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVqsgeSZXRjSL4Nd0xIheqgwZk5T6p6uNnVaoxv3OCc=;
        b=cZrkoCCjLIk2uN+wlb3r3Nw0iYDs+pEXNljZnVjLKaskBDByCqZYBRLJX2cSkW7C7t
         IezSMIgTuj9dLmmv+vVdbkFOuuI0rkzqh2FIQvV3soY+gi7huRQ5Uz++c/+i5KFJsmkG
         NM0RXa8wJn0PD+idL3OKmOxBhA9ZEihLjgUh1+uhK7bar8+b5CWcF4/1SxnJcFTOI0SS
         /xsQhWE2KrZLClIJmy46Ji3Ds1mymGUoTm/xR2lZLdK5U3R17Ua/Pfux3BGWi2VNtbO2
         6I+ewNgRWfxlbkC8zvzaEfXH14aoGH9t0V0p5vn2nDzEi4TKWL2SfdzmKIllflcWRaU/
         Q82w==
X-Gm-Message-State: AOAM5313we104l2Vsh8hzB2aL2ZPSLcGXLGPHM6kGj2ce3X9mX1zjX09
        TSuF2iTS2fiQ+QjwSOHVsPV5GebKSYPUcaCt+Lo=
X-Google-Smtp-Source: ABdhPJze0RiVviEpnkB9Y7vEUtiHI2gsoGd1Nj+c6CI5ut1i3C83zZfOO80KEvfDumm0U7n8fjnHSFswzP/rIYeyXG8=
X-Received: by 2002:aa7:d503:: with SMTP id y3mr27764274edq.142.1615786925361;
 Sun, 14 Mar 2021 22:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v4.git.1615737505834.gitgitgadget@gmail.com>
 <pull.901.v5.git.1615778692784.gitgitgadget@gmail.com> <CAP8UFD3mpu6eTqifnwUV4uHoAASaQnxX21CacOn4dGSp+juVKw@mail.gmail.com>
In-Reply-To: <CAP8UFD3mpu6eTqifnwUV4uHoAASaQnxX21CacOn4dGSp+juVKw@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Mar 2021 06:41:54 +0100
Message-ID: <CAP8UFD2tz-apz+C8+Q+P4-8zZOq7zDsupkX31EHyT0msH3eX0A@mail.gmail.com>
Subject: Re: [PATCH v5] [GSOC] commit: add --trailer option
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 15, 2021 at 6:33 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Mon, Mar 15, 2021 at 4:24 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>
> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 739110c5a7f6..24fccb561398 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -113,6 +113,9 @@ static int config_commit_verbose = -1; /* unspecified */
> >  static int no_post_rewrite, allow_empty_message, pathspec_file_nul;
> >  static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
> >  static char *sign_commit, *pathspec_from_file;
> > +struct child_process run_trailer = CHILD_PROCESS_INIT;
>
> It seems to me that `run_trailer` is used only in the `if
> (trailer_args.nr) {...}` block, so it could be declared there instead
> of as a global variable.
>
> > +struct strvec trailer_args = STRVEC_INIT;

Also you might want to add "static" in front of "struct strvec" in the
above line.
