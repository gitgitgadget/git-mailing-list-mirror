Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A0DC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF01B20897
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIIT5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:57:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32954 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727075AbgIIT4z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:56:55 -0400
Received: by mail-ed1-f65.google.com with SMTP id g4so3963067edk.0
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 12:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BeAHwN5JJn9aw6IrSWu3j8oLOEPwo6zY8ZAdOg16eeM=;
        b=eYJoPSYAPcVcKhARqFmEVWGFK4CVctLC6e87H6qv2xOysf+Gva7tPVe6GDp48CVQw6
         hKATa22BhIirhkEWlXBXEPW3kEeT8eFAsKHe/rXo5P+x5HC255YmFseZirlBsD2wjjgc
         5uOM4ajL8NNZNZjWzhj96S7e8oTjQzWSo5QMKdZC4mCsJbJB83gys8Uie97PyqN4Wx9g
         1Vmm7B1f96lhX86oW+d+139AtMqccoYZJ/4uDr6WA8hEk+sQOrKmlI2Oqr5dBWQdj2Yt
         zDEqr+Q3maTC+4+JKKYDDzSzZUHUTYaSjwJo4B3xRyoIzA6f78Ddx4U72uY1jKFUB8GK
         XlWw==
X-Gm-Message-State: AOAM530KKFYCAvEkfzsRBmvuctCclkFm9/sCizwfhrZj6CrW7bSORTgM
        NMDp6yaBFYcDyfMpkXerx41X6w79pUoaq4rEYdM=
X-Google-Smtp-Source: ABdhPJwid2fZwfKR7mX/m/Mj8IlJ7KmjnXq1OwS3X9s7Vkqg/ItiI0GeiBTrZL5ht9vXIW0+s1Uk9859EhAdjA3pL6c=
X-Received: by 2002:a05:6402:17ed:: with SMTP id t13mr5937820edy.163.1599681413417;
 Wed, 09 Sep 2020 12:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.694.git.1596675905.gitgitgadget@gmail.com>
 <pull.694.v2.git.1599680861.gitgitgadget@gmail.com> <c850888c25d4d1e1c6b0ca40ab4638462c1649fa.1599680861.git.gitgitgadget@gmail.com>
In-Reply-To: <c850888c25d4d1e1c6b0ca40ab4638462c1649fa.1599680861.git.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Sep 2020 15:56:42 -0400
Message-ID: <CAPig+cQ_KCAGpmfBAymBefB2JSVpw0-bk5HOnm41=SpADEyDnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Fit to Plan 9's ANSI/POSIX compatibility layer
To:     Kyohei Kadota via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, "KADOTA, Kyohei" <lufia@lufia.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 9, 2020 at 3:48 PM Kyohei Kadota via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> And its sed(1)'s label is limited to maximum seven characters.
> Therefore I replaced some labels to drop a character.
>
> * close -> cl
> * continue -> cont (cnt is used for count)
> * line -> ln
> * hered -> hdoc
> * shell -> sh
> * string -> str

These are reasonable. "cl" feels a little odd, but I can't think of
anything better.

> diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
> @@ -24,7 +24,7 @@ category_list () {
>  get_synopsis () {
>         sed -n '
> -               /^NAME/,/'"$1"'/H
> +               /^NAME/,/'"$1"'/h

This change is not mentioned in the commit message. "H" and "h" are
very different commands, so it's difficult, at a glance, to tell if
this change is even valid. Some explanation in the commit message
would help (if it is indeed valid).
