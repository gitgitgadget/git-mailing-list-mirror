Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A453C433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1042120799
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 21:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhABVfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 16:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbhABVfF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 16:35:05 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F09C061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 13:34:25 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id u7so12499254vsg.11
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 13:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zF+7JmJslQyn7e0NP5dNieo3E7FT9YEyyJP+VwFNWvQ=;
        b=ChRLkWedbEF8F2rVYbPTUQOqXDH0m8hBGBqtvdZ8LrpN08G0gI9qT32SrThS+aktqE
         2Ll97D6XnsnMR+KkLWRVre7cBn8ve765M1JtsMkH3o82Dpg3TCPHanpHK3jqLBulfDcR
         XQgV2aK4/d3kcCjUCDYSt3dir6mOG9NRwImyR6I4RP3Ss6TDQwUUsdZ/Cs6dnwPm2IWt
         yTqZ0RBeXDJXkmHSqJ0VZPWqEDm5TrK0NMSumzHnp8m4/qMkiOgXIbYaKsK+3HBIIScV
         nhnTelX1oF/3sLkANzSyJ8D4CbBIBFLIurUHTTv6pusAAiQsh9nCAbWi6+NBG9+0gmFP
         v4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zF+7JmJslQyn7e0NP5dNieo3E7FT9YEyyJP+VwFNWvQ=;
        b=Xm+4UOtZEZR3kXAilBSNLyAwOsh0Z+oNboeFO1PhVwpXBD2fUhC9Yaw8hVA7hMxoSq
         WHaGBIHG0WD2jY/o5UsyCBCg1lWtgSoljTMPX9yWj0pe/WawFFIGaTrG1NKHDvBMMiSt
         li58QCdj6sG1QLD/47qBfK/Nfz/+rH4y4wR1LQJnnhFOeFGH+nb6XyxB7Om+lVoXJQhQ
         UyTGF2BvhpYeGOkNrvbFe8+xS44XuHD4E2sPvTtUPmt7WBC6joilQ5NMFYZ7Yc/3Es/T
         /jOybOYX6kmn3SXW+mFwx7PrAUCbER237O16GtaXqD2F4c01OGuJWjurFBDD2bzjRK0v
         tTwg==
X-Gm-Message-State: AOAM531PXCNuh+qFKkzv5qm2uBrk8x7MePZqVjG1jd51mIjImHt5hTNJ
        27ty3tcOWKO/dXBWbDJJfMOCNonyrfmZvkqLjCs=
X-Google-Smtp-Source: ABdhPJzXKZHGBmWtpEpYsive/riytlYtPzaGth4l6QFRUrtuQ0c1J5HRnYMT5TiNSn3BNGNQn3jDZxmemipdpIhOpvI=
X-Received: by 2002:a67:2d84:: with SMTP id t126mr38794944vst.49.1609623264533;
 Sat, 02 Jan 2021 13:34:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
In-Reply-To: <pull.942.git.git.1609616245412.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 2 Jan 2021 22:34:09 +0100
Message-ID: <CAN0heSqC3K6pJOr2ztz56+ZpKaMomA28rc4W5x8n0cC3K-rVgQ@mail.gmail.com>
Subject: Re: [PATCH] gitmodules.txt: fix 'GIT_WORK_TREE' variable name
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Gustaf Hendeby <hendeby@isy.liu.se>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 2 Jan 2021 at 20:39, Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> 'gitmodules.txt' is a guide about the '.gitmodules' file that describes
> submodules properties, and that file must exist at the root of the
> repository. This was clarified in e5b5c1d2cf (Document clarification:
> gitmodules, gitattributes, 2008-08-31).
>
> However, that commit mistakenly uses the non-existing environment
> variable 'GIT_WORK_DIR' to refer to the root of the repository.

Good catch! I wonder what we should conclude from this having gone
unreported for so long.

> Fix that by using the correct variable, 'GIT_WORK_TREE'. Take the
> opportunity to modernize and improve the formatting of that guide.

It's a small correctness fix and some prettifying while at it. While I
read the diff and realized that it was more than just one or two
asciidoc tweaks in the immediate vicinity, I started wondering if this
should be presented the other way round: "Let's update the formatting
and fix s/DIR/TREE/ while at it." Or to split it up. But I don't think
it's worth thinking too much about -- what you have looks good to me.

> @@ -32,14 +32,14 @@ submodule.<name>.path::

Just above this point, you have another s/\.gitmodules/`&`/ waiting to
be fixed.

>  submodule.<name>.url::
>         Defines a URL from which the submodule repository can be cloned.
>         This may be either an absolute URL ready to be passed to

>         dirty;; All changes to the submodule's work tree will be ignored, only
> -           committed differences between the HEAD of the submodule and its
> +           committed differences between the 'HEAD' of the submodule and its
>             recorded state in the superproject are taken into account.

`git grep -B10 HEAD CodingGuidelines` suggests this should be `HEAD`,
not 'HEAD'. Maybe you followed style -- there's an instance of 'HEAD'
earlier. I think both should be `HEAD`.

> -If this option is also present in the submodules entry in .git/config
> +If this option is also present in the submodules entry in `.git/config`
>  of the superproject, the setting there will override the one found in
> -.gitmodules.
> +`.gitmodules`.

Should "submodules entry" be "submodule's entry"? I've never worked with
submodules, but that reading somehow seems more natural. (There are two
hits for "submodules entry" in this document -- both might be worth
looking at.)

This patch looks good to me. It might be worthwhile to reroll
to address the naked .gitmodules around line 30 and the two 'HEAD' while
you're in the area. As for the last comment above, it could well be
that the proper response is "no, you're wrong".

Martin
