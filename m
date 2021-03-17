Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2B8C433E6
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F38564EC4
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 17:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhCQRfo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbhCQRfj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 13:35:39 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ED3C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 10:35:39 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so2281605otb.7
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 10:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHmW1r6bSVydDRnpYN3ZpU+2/WsnvkQRC/+BIXKZqg0=;
        b=M05aerx6GpIUP8sJtIfcClrmEG74ZhkxyskaWa9/4zPsrqZlAWGok0XqVc+A0iKiJz
         XEC8O2b2c0/AyCAhSe01yPEqz2hhW6P8izPYqMD84pbXc22+/bxV9kSFH8uwYPwJdnKA
         oiL9D9BiQ8ijw7E19V4seUgCzHt1+n3Y+fWQATAa2ZUvP9y/p2XqIFAz4CksgGf5wPFx
         Bta2Hnx+0LIJdBxVMpfnjXWVo8I6hme7qAsFk2UKv1BIH3Kyl5BUJ6zyBRF+mesh1+et
         TC0/hMBEs35mgva+uP0RR+bXS5Zl7KhLfEyE79X/DUvh7lMankpujSJvy2pzO4jt3OD8
         /GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHmW1r6bSVydDRnpYN3ZpU+2/WsnvkQRC/+BIXKZqg0=;
        b=HzYUskU6dhdFxO6D3yIpv0CNi/wA2m30xK9XZxd5kBaCvO86aEZRdvzXuaniCLUuho
         ZnHdjnytI9oK5h4eoTl2w/Vsr0XnsrLDX3+gJ0Xvj5nMmbhMt/cft/y0NonRvbRijM3U
         3iwH80U6ZiBq7Cfv6r0KW/YR/dMwpOpKcwAkgJnDDlFRUSuCYbUMV2hbAWAbrnuCAs3Q
         xyayLYF17e+Mx4SOgvA5iLKW8bSvy00RtcGG5s1+evvXkMBGuHxtLo+7yZhVDFXndWXf
         DC3hR+F2ETecqE8x3oUoS7tDeSOgtYPIbVqxKeSsZux9lISS+JKMjjuTM/DzrGABmU1i
         /W1g==
X-Gm-Message-State: AOAM531dSCVBhMY6TqWulZNiCK9BN3szHaqxZBx4dagpkAoMKO6750LH
        CAmH9mdNexCLVcFrIMhPJQUZOTtJMspnfIt5pd0=
X-Google-Smtp-Source: ABdhPJzO2l1cvM9s5IZhL3nMgvwDmWTjNj9q1CVKKZ30hvFHkQjMne8zhEZT8VvVShSIPXsZjDVB+igUOBa3Wtdk7Ao=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr4199033otf.162.1616002538781;
 Wed, 17 Mar 2021 10:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com> <142df1ab8e3e8ea5e213f2477e271e60e5b62f84.1615929436.git.gitgitgadget@gmail.com>
In-Reply-To: <142df1ab8e3e8ea5e213f2477e271e60e5b62f84.1615929436.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 17 Mar 2021 10:35:27 -0700
Message-ID: <CABPp-BHyCDJH-78XGdW5TxAOPjDE669LL21yTY3NdmCP7iSMRA@mail.gmail.com>
Subject: Re: [PATCH 05/27] add: ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 2:17 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Before iterating over all cache entries, ensure that a sparse index is
> expanded to a full index to avoid unexpected behavior.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/add.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index ea762a41e3a2..ab2ef4a63530 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -141,6 +141,7 @@ static int renormalize_tracked_files(const struct pathspec *pathspec, int flags)
>  {
>         int i, retval = 0;
>
> +       ensure_full_index(&the_index);
>         for (i = 0; i < active_nr; i++) {
>                 struct cache_entry *ce = active_cache[i];

I'm not so sure about this one; from git-add(1):

       --renormalize
           Apply the "clean" process freshly to all tracked files to forcibly
           add them again to the index. This is useful after changing
           core.autocrlf configuration or the text attribute in order to
           correct files added with wrong CRLF/LF line endings. This option
           implies -u.

... to "all tracked files".  Should that be interpreted as all files
within the sparsity paths, especially considering that we're trying to
enable folks to work within the set of files of interest to them?  If
it doesn't imply that, wouldn't users want an extra option to be able
to behave that way?  And if we add an option, why are we adding a
special option for people wanting to behave sparsely in a
sparse-index-cone-mode-sparse-checkout rather than for the special
case of folks wanting to behave densely in such a setup?

The code below already has the following check below:

    if (!S_ISREG(ce->ce_mode) && !S_ISLNK(ce->ce_mode))
      continue; /* do not touch non blobs */

suggesting that it'd correctly skip over the sparse directories, so I
think this one just isn't needed.

However, on a tangent, that S_ISLNK looks rather suspicious to me.
Why would we renormalize symlinks?  I mean, sure, symlinks aren't
likely to have CRLF/LF characters in them, but if they did, wouldn't
it be wrong to renormalize them?
