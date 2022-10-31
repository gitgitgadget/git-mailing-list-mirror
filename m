Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A82FA3745
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 11:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiJaLnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 07:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiJaLna (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 07:43:30 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8621E0A7
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 04:43:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t4so5691808lfp.2
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STB+rVQexKZb3Tw2kYLalntgDz/ZjbgO3NyjoW6uVb4=;
        b=Y+kQ/vhsdvs4HSNBITa2DugTVh9v/PSpw9uU038A6+hIhXZXtuwttsUEm1WKge2f15
         0hWsDv9N9EOjWirtAj9tQTIL/ykSGeeKI1I0O6AMqTBzzUGRUY33zpaYAhdVvxLy+gnt
         CnAYEzDa3jYaaKnKGJwlEMg7jyfDLNVkSFYkzePf+z0VKpl+nFgYHhJGKmHFLtP+hlJl
         p+HrLt5I+ml2YgEgNfjiVJIk9RueviPzT2l0A3+YnQZwT+v3HNyP1vdbiApnimSL+Yuj
         XV9KXn9Ehm7GB9TCyanh8e4Xs0DdQ2rc1/zNhUPRm1bTHm+KU2cWhlOh8lP+z4dZeC5f
         EIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STB+rVQexKZb3Tw2kYLalntgDz/ZjbgO3NyjoW6uVb4=;
        b=3lQieyFr+PpH5OG16CWGAHX2inEqmzHkoywO5eqEzn7Khn2w323ecnDs0maGVyZUS+
         ZetrCZHvw/FevAu9Uj7gxdHWrf1fxMuoXBBzbfSqA0Us9ODOGjEyx/vgZ8DxFCsQWY8E
         vlXzi5+rMQ9LGX0A8vojpKBcs9jfyLjhdVJP9X9lhhXS838a88Brc5K4bkMP/mF/zRVW
         Qk8omu+Tn3uB0xJwBOxVGSmpu98hjuiZ77HA5WaARMm5vlFiY1LmADY9SzVsWpTTb6ia
         Tkqz+FhDiRn8ydJL8jbBVGiXDkbCQQgX/jw9VTxH+i8wHdZBgRXT39FOn3jHwf/uQUAJ
         fdDQ==
X-Gm-Message-State: ACrzQf3tx7RfcZV8BVWai5mpdvFtcp29VvRlISYiawNi4guXY6Qziiab
        uX2Qkt7W44/vQzJ589SpfvOhvnGoh0YAbP+yVk0AZmyr
X-Google-Smtp-Source: AMsMyM6LcpSvHsW+tkvsejreaVuqXh9whYRAtH81dWYcCZx9fSb6pBqlM5RzwWk3TYB1Oh11Rt79Mikk41/m8P/dEc4=
X-Received: by 2002:ac2:4839:0:b0:4a4:4f4c:116 with SMTP id
 25-20020ac24839000000b004a44f4c0116mr5323489lft.51.1667216606962; Mon, 31 Oct
 2022 04:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221029102459.82428-1-siddharthasthana31@gmail.com> <20221029102459.82428-3-siddharthasthana31@gmail.com>
In-Reply-To: <20221029102459.82428-3-siddharthasthana31@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 31 Oct 2022 12:43:13 +0100
Message-ID: <CAP8UFD3tE6cF7y_zF=-eaFAr3Pw_GcTr7C-zyb2ujBBLDG-ojg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] cat-file: add mailmap support to --batch-check option
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 29, 2022 at 12:25 PM Siddharth Asthana
<siddharthasthana31@gmail.com> wrote:

> diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
> index 594b6f2dfd..a8e7906b3d 100644
> --- a/Documentation/git-cat-file.txt
> +++ b/Documentation/git-cat-file.txt
> @@ -103,6 +103,8 @@ OPTIONS
>         `--textconv` or `--filters`, in which case the input lines also
>         need to specify the path, separated by whitespace.  See the
>         section `BATCH OUTPUT` below for details.
> +       If used with `--use-mailmap` option, will show the size of
> +       updated object after replacing idents using the mailmap mechanism.

I think all documentation changes should probably go to the
documentation patch that was split off this series, instead of in this
series.

Whether the other patch gets merged before or after this series, I
think it will simplify things.

Otherwise, this LGTM, thanks!
