Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7919BC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C0E61075
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 20:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244044AbhDWU7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 16:59:24 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:37776 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbhDWU7X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 16:59:23 -0400
Received: by mail-ej1-f54.google.com with SMTP id w3so75777535ejc.4
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 13:58:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4SeSQvXDn3K7z3ncKGRfSoe+okxKHoBJwOOR3U3yAH4=;
        b=lqZost1ybbyji9Kne5AlezVmlECzKI3yQXVq2or741qR0IUoL3/OsOgYgLMmhAvGBI
         WPv1txYBcFBPlWwAnwKKfQNxJyKb9kPnPn2sSefG8RXTsAmKFsTaNTClxFyNEa8FQC1U
         /JFLEav8RtRmuAKMA3ISmRID77DRNhPWngszFNx7UOoJdW4jZerO8TgccgB2ksS9bBjc
         A9m3qv7fvEtiMyXAAr98qrcGW1eamBCJOkAyxjfRvgva9e32+J/5KF8SWOu09m5j92Az
         hgohBTQAcAGEd/M4hWQ7ZDpEQf9D9NGij1mQgMqUVIgUD3yU/oKv/n6DIf5oCU1qZQD0
         p6Ww==
X-Gm-Message-State: AOAM531lhE5GaJlJWG6jm+iILyfK653CMU9qOtNOJ8UopZZTYmvJVJC0
        5KkfIkmjQh4LOiE1fQqRlsVS7tcNQW1lINDmM7c=
X-Google-Smtp-Source: ABdhPJyRqQUVJaZ2+WSoOeM5YvJVeOJS4aGXiOr6iru9CPgtS2MkKNxpuUoNwqOxLv3ZDhUZUQioK3maqvxH72uH/PM=
X-Received: by 2002:a17:906:85cb:: with SMTP id i11mr6070130ejy.311.1619211525374;
 Fri, 23 Apr 2021 13:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-24-lukeshu@lukeshu.com>
In-Reply-To: <20210423194230.1388945-24-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 16:58:34 -0400
Message-ID: <CAPig+cQmTTdVKQptQY_tT_x4DCduRh=Mq6QZ1vUsc790-0yTQw@mail.gmail.com>
Subject: Re: [PATCH 23/30] subtree: add comments and sanity checks
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 3:43 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> @@ -248,17 +263,22 @@ rev_exists () {
> +# Usage: try_remove_previous REV
> +#
>  # if a commit doesn't have a parent, this might not work.  But we only want

s/if/If/ perhaps

>  # to remove the parent from the rev-list, and since it doesn't exist, it won't
>  # be there anyway, so do nothing in that case.
> @@ -302,10 +322,12 @@ find_latest_squash () {
> +# Usage: find_existing_splits DIR REV
>  find_existing_splits () {
> +       assert test $# = 2
>         debug "Looking for prior splits..."
>         dir="$1"
> -       revs="$2"
> +       rev="$2"
> @@ -314,7 +336,7 @@ find_existing_splits () {
>         git log --grep="$grep_format" \
> -               --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
> +               --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' "$rev" |

The caller of this function is passing in "$revs". Did you make this
semantic change because the caller's `revs` is guaranteed to be a
single rev? In any case, this change may deserve mention in the commit
message so readers don't have to wonder about it.
