Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF11C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E8360F4A
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 22:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhIRWIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbhIRWIL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 18:08:11 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AC5C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 15:06:47 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w206so7652520oiw.4
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dm5i0u94HTTdks7bFisrSXKS5pNXSGc1d56PVkuMSFY=;
        b=aqG4DwIkeezf6eXm6nRbBir+ctrjaIKkgAKe1z799H88WhVeRFoW3CP6pNlMqqp5m+
         kGOeO0DHSxz8albx2L1JP1ThbVr/gDQB90dZ8ta8ScWc28J+HUz/Ey+tWRyTYMMIo7ml
         ZKsrYhSZoPFEO/2og2a5rfYiAJsyBwR8d2GoH7cbAoVACL2zebZ0xfuQYpsOUlHiZrBm
         9wFHr+rVsph7/Ie4KU9lug/42KBUvDIhDJJlQJvz0M6dXuxPLECspOMVJ46V/5hfpVNP
         +qKOtYjFdSSxyWurg5CNVfaEqlIwETj6W9elOF4n66lPBnLHXdRTrXpbvk0Qcopjkwo2
         V/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dm5i0u94HTTdks7bFisrSXKS5pNXSGc1d56PVkuMSFY=;
        b=LZwWCl7YAQ/rD2zsJXo9Kw8o4sCldUPTVRGOJwzWhgQ60Ha7HkIHKrEfDEiuHu0GBJ
         5dDPlGfuW3NITHr7A2a3q9QALNHWUJnwahLK27ypsSBw2qNgyJkYSvjI4/oGqIzdXGhg
         AU86X027izuSqaPfb6zPl8oPjx5UNt3kcFZRKzWYprXucuaXjm/ZtS3k0a8Rq4l3W+jA
         Dn/2ENMuFNXuEChCOgPnGIXDWGMxW+lkxe6gQNL6kFreLB848TChF3M3M12q9bpXWTm2
         /9xD1LiC3tx+d5OiQoohm68Tmy2EbL29JhxI56gyV5TUBm4YbaQYCbDc2ir2Ux7kYUOP
         M/Ig==
X-Gm-Message-State: AOAM5308ZLjO+xapdy2xREOX0wY1eC1rUs2KVbYi7EHX/KoksUVAiDeN
        QZiCJxSolS/AYmOkYYjlLMSX13XrU0FW7H7Hyrc=
X-Google-Smtp-Source: ABdhPJy3sOa8nXXLiWhWVRFfbyK/OxRb0ui6exDipXISSVrLhRpaURQA7f3ESJLaxUWZPxFgcHrVN+id/JMbAnibW/0=
X-Received: by 2002:a05:6808:1a29:: with SMTP id bk41mr280920oib.167.1632002806896;
 Sat, 18 Sep 2021 15:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.git.git.1623734171.gitgitgadget@gmail.com>
 <pull.1036.v2.git.git.1631379829.gitgitgadget@gmail.com> <06e04c88dea3e15a90f0a11795b7a8eea3533bc8.1631379829.git.gitgitgadget@gmail.com>
 <b6818661-ac6e-fbde-2cab-429c5550a0da@gmail.com> <2290b657-3c67-0ab8-5c25-cc57feac301c@gmail.com>
In-Reply-To: <2290b657-3c67-0ab8-5c25-cc57feac301c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Sep 2021 15:06:35 -0700
Message-ID: <CABPp-BHXUNTuYPdCzfKhkvr23W3PODzti84bed6uEP5q+sj0TQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] xdiff: implement a zealous diff3, or "zdiff3"
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Sergey Organov <sorganov@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 15, 2021 at 4:22 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 15/09/2021 11:25, Phillip Wood wrote:
> > I do wonder (though a brief try failed to trigger it) if there are cases
> > where the diff algorithm does something "clever" which means it does not
> > treat a common prefix or suffix as unchanged (see d2f82950a9
> > ("Re(-re)*fix trim_common_tail()", 2007-12-20) for a related issue). We
> > could just trim the common prefix and suffix from the two sides
> > ourselves using xdl_recmatch().
>
> Here is an evil test case that shows this problem (diff on top of your patch)
>
>
> diff --git a/t/t6427-diff3-conflict-markers.sh b/t/t6427-diff3-conflict-markers.sh
> index de9c6190b9..836843c6b0 100755
> --- a/t/t6427-diff3-conflict-markers.sh
> +++ b/t/t6427-diff3-conflict-markers.sh
> @@ -219,8 +219,9 @@ test_setup_zdiff3 () {
>                  test_write_lines 1 2 3 4 5 6 7 8 9 >basic &&
>                  test_write_lines 1 2 3 AA 4 5 BB 6 7 8 >middle-common &&
>                  test_write_lines 1 2 3 4 5 6 7 8 9 >interesting &&
> +               test_write_lines 1 2 3 4 5 6 7 8 9 >evil &&
>
> -               git add basic middle-common &&
> +               git add basic middle-common interesting evil &&
>                  git commit -m base &&
>
>                  git branch left &&
> @@ -230,19 +231,21 @@ test_setup_zdiff3 () {
>                  test_write_lines 1 2 3 4 A B C D E 7 8 9 >basic &&
>                  test_write_lines 1 2 3 CC 4 5 DD 6 7 8 >middle-common &&
>                  test_write_lines 1 2 3 4 A B C D E F G H I J 7 8 9 >interesting &&
> +               test_write_lines 1 2 3 4 X A B C 7 8 9 >evil &&
>                  git add -u &&
>                  git commit -m letters &&
>
>                  git checkout right &&
>                  test_write_lines 1 2 3 4 A X C Y E 7 8 9 >basic &&
>                  test_write_lines 1 2 3 EE 4 5 FF 6 7 8 >middle-common &&
>                  test_write_lines 1 2 3 4 A B C 5 6 G H I J 7 8 9 >interesting &&
> +               test_write_lines 1 2 3 4 Y A B C B C 7 8 9 >evil &&
>                  git add -u &&
>                  git commit -m permuted
>          )
>   }
>
> -test_expect_failure 'check zdiff3 markers' '
> +test_expect_success 'check zdiff3 markers' '

...except your new testcase makes it fail.

>          test_setup_zdiff3 &&
>          (
>                  cd zdiff3 &&
> @@ -251,6 +254,14 @@ test_expect_failure 'check zdiff3 markers' '
>
>                  test_must_fail git -c merge.conflictstyle=zdiff3 merge -s recursive right^0 &&
>
> +               test_write_lines \
> +                       1 2 3 4 \
> +                       "<<<<<<< HEAD" X A \
> +                       "||||||| $(git rev-parse --short HEAD^1)" 5 6 ======= \
> +                       Y A B C ">>>>>>> right^0" \
> +                       B C 7 8 9 >expect &&
> +               test_cmp expect evil &&
> +

Yeah, this is an interesting testcase, and I agree with the 'expect'
choice you wrote, but the current code doesn't produce it.  I'll
update the patches and send out another round, and then do you want to
try your xdl_recmatch() magic to fix this testcase?
