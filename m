Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1AD8C25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 16:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbiHTQoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiHTQoR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 12:44:17 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0F82497C
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 09:44:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z2so9002866edc.1
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 09:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=v1pQ+AraylE3z5RPS5oQqIn/ik9WHba8nqzJoJ4mbTY=;
        b=B2GzABn+jxvsKT3cKSVKn/tfF1E49rOXAzkxrzIxXXKHkOBX+bRfgLT5/2UuWal8gF
         9k1WnzWteR867Y/krgGkM7EKJUCC0+a/0LA3T6uVmMTRPiovh8uqpBhvJzWGbV21WOec
         nn2mS+t0gOji5+RoktRb6FzohPA8P+7Z6fEqQmJ1mBNR0TkikhJgXAgTJ5c+WOVnrZLV
         IV7qhxUwIjAElAB3dZJaEL2LfANr+qaawjSlctfvqrpIBP03wcPJFTC9e06ZS9QdMpiK
         sbzm3B4vHLvMZpPej5kEpaFAu6x9/nw4qxVOyEEw1QxEzXtXEQ9yix9yu6GDM/r6UwPP
         pZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=v1pQ+AraylE3z5RPS5oQqIn/ik9WHba8nqzJoJ4mbTY=;
        b=MTcQgkTjbEyln4KIFovDyJcgBSsXXzBBmTEAbjogbA4MTPECgCIgaQtVGAfrjDDAne
         Y7nMPwYEQAgntKSz76lDmJYSnIC4/9P7rWjArW2B6RfoK7A57LJ5ybK/48SbEiJnKLOz
         VQvsfhyfUsmOUkbk+bzl/uJkxIEQFMj4uJV2tlIUb+oG2y/buDvamvZ8SA3t9vzCT7I4
         WXCs5+18V95G/JAR5InEqDUghoKfDDJkIWixSI2jxIfhRh2Y5pMqZ3EpNBxwqUlNkqI6
         YC66Pq46eavHehe572SJSpKKcDoIdsmDzLC0rSBghcaUwV2FcnzvHWam55vy8JJ7zrYT
         3aaA==
X-Gm-Message-State: ACgBeo1EofokskQR1sgPw/MnO5ZVnbpUpmoGRFgwsNZMeqlwqbv7FQpT
        kR3YAoH014b9zb7ljMy50DEAksuDZmG9ohKD0fY=
X-Google-Smtp-Source: AA6agR7t90zIheScvRYIOekFnaheBbH4XlUrwhQ+UOy2q4Bi0QlAEZej2GzCf4ZuIoi4lmB02/fm3bYgYSwrCI1rHOg=
X-Received: by 2002:a05:6402:50ce:b0:43d:559d:43f4 with SMTP id
 h14-20020a05640250ce00b0043d559d43f4mr9853893edb.325.1661013854556; Sat, 20
 Aug 2022 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660944574.git.me@ttaylorr.com> <053045db1459812a1baec8771ff22dcac6f9ad47.1660944574.git.me@ttaylorr.com>
In-Reply-To: <053045db1459812a1baec8771ff22dcac6f9ad47.1660944574.git.me@ttaylorr.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 20 Aug 2022 22:14:03 +0530
Message-ID: <CAPOJW5zSGOY4zryCiMc02HW73nyzzKVopuHgPevgSjeKkt+6zg@mail.gmail.com>
Subject: Re: [PATCH 2/6] t/lib-bitmap.sh: avoid silencing stderr
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        jonathantanmy@google.com,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 3:00 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> The midx_bitmap_partial_tests() function is responsible for setting up a
> state where some (but not all) packs in the repository are covered by a
> MIDX (and bitmap).
>
> This function has redirected the `git multi-pack-index write --bitmap`'s
> stderr to a file "err" since its introduction back in c51f5a6437 (t5326:
> test multi-pack bitmap behavior, 2021-08-31).
>
> This was likely a stray change left over from a slightly different
> version of this test, since the file "err" is never read after being
> written. This leads to confusingly-missing output, especially when the
> contents of stderr are important.
>
> Resolve this confusion by avoiding silencing stderr in this case.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  t/lib-bitmap.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/lib-bitmap.sh b/t/lib-bitmap.sh
> index a95537e759..f595937094 100644
> --- a/t/lib-bitmap.sh
> +++ b/t/lib-bitmap.sh
> @@ -440,7 +440,7 @@ midx_bitmap_partial_tests () {
>                 test_commit packed &&
>                 git repack &&
>                 test_commit loose &&
> -               git multi-pack-index write --bitmap 2>err &&
> +               git multi-pack-index write --bitmap &&
>                 test_path_is_file $midx &&
>                 test_path_is_file $midx-$(midx_checksum $objdir).bitmap
>         '

Thanks Taylor! I would say this is a very good change. It might have
been there for some reason when it was written, but that was resisting
us to debug what was going on ;-)
