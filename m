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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26051C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C8B6112F
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 08:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhDZIn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 04:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbhDZIn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 04:43:57 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA7FC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:43:14 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id s15so64749427edd.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:references:user-agent
         :in-reply-to:mime-version;
        bh=vxlftizU8O2lg/fT3nczbUdRUr5weOW3rlqj0K7j2UM=;
        b=G44+zDEYa0L0p8Kuqgg3LzCSeJCfx0Ljr2QTFZ2+qC/wHbU7qmBHHh4O1li2lWXARc
         N/qYPGI5YQe43ZG8laU8rYl94/ffyAd7MXCEjJ7bB+oP9yCtG0L8SoXNxU/uUKTgarzl
         F6tRKPtE7/We5LiqHUP/TkEJFBrDcqQhRKdnSib0BGJAYbxCFwZZDeglix2Z/J6sXrKX
         Ru7hPxAdU6mwr2bI6dnTLMPmPbthKlHbmR5aqh77vM0Ps6+bnWqfBEMPezBt2RSBXFg6
         ZhGOPJP/54gWuAf4KR7oiZssMsYQUiVjTdLMzpFKOwL7gQXbIuY3l5iPm7VWJbu7IRTw
         m71g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:references
         :user-agent:in-reply-to:mime-version;
        bh=vxlftizU8O2lg/fT3nczbUdRUr5weOW3rlqj0K7j2UM=;
        b=f3N6vPgeHrZGjMLOdsP+MR+2AjmRtVzGXMq+cD+XR5A+MrISlwpOJWfH1wyV+7aWEh
         ZqmB7qIvY31sT11hSFGbyvt3wePaa51fLvvzXQL5WGVySXMaixPHygo1XWMncRj2ZKyY
         If5fZAKzRZ0qyY4ur2MJN/WGwPJOIWS6GTTb+ZJdUDJdJjP8ZunuhvQMXMImUHWIR0M5
         2ZBEX5DB/AQUIvBZdzGe5ZPoG8PV7QJieIo7yzkSdpJmbTIQdrTrq5z1MNfN2ZT4EWXd
         qj81lxoNACDdwrPNQB/ujphGlFpDVKnkojl+AQOFMPLT/xVM74+UwurXOczfHNW+jSiH
         G2UA==
X-Gm-Message-State: AOAM5314neOlWEjIjcxekuer8JfFaBUinLZfPofFqfaYA19l4xir623f
        htnTAB3O0eOaarffvv5KrOk=
X-Google-Smtp-Source: ABdhPJxwqRTNIbEdwQohtnDRlJDd6ym8Rql6VZtrQy2zyVCwn0nmmuKsKAjVHczXYjFyO0oVAkYVWg==
X-Received: by 2002:aa7:d589:: with SMTP id r9mr6595512edq.286.1619426593368;
        Mon, 26 Apr 2021 01:43:13 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id z4sm13129673edb.97.2021.04.26.01.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 01:43:13 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, pclouds@gmail.com,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH 20/30] subtree: use "^{commit}" instead of "^0"
Date:   Mon, 26 Apr 2021 09:43:38 +0200
Message-ID: <878s551oet.fsf@evledraar.gmail.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
 <20210423194230.1388945-21-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210423194230.1388945-21-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 23 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> They are synonyms.  Both are used in the file.  ^{commit} is clearer, so
> "standardize" on that.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
>  contrib/subtree/git-subtree.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
> index 9d365c9f2f..d200fbfed7 100755
> --- a/contrib/subtree/git-subtree.sh
> +++ b/contrib/subtree/git-subtree.sh
> @@ -302,7 +302,7 @@ find_latest_squash () {
>  			main="$b"
>  			;;
>  		git-subtree-split:)
> -			sub="$(git rev-parse "$b^0")" ||
> +			sub="$(git rev-parse "$b^{commit}")" ||
>  			die "could not rev-parse split hash $b from commit $sq"
>  			;;
>  		END)
> @@ -349,7 +349,7 @@ find_existing_splits () {
>  			main="$b"
>  			;;
>  		git-subtree-split:)
> -			sub="$(git rev-parse "$b^0")" ||
> +			sub="$(git rev-parse "$b^{commit}")" ||
>  			die "could not rev-parse split hash $b from commit $sq"
>  			;;
>  		END)

Not a new problem, but those error messages seem weird/bad, isn't that
message originally from find_existing_splits() and copied over to
find_latest_squash() where talking about "split hash" doesn't make
sense?

I'd expect something like "could not peel $b to commit" as the error for
both.
