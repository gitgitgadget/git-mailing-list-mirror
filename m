Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE18C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 916F461446
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 08:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbhD2IGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239933AbhD2IGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 04:06:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E4AC06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:05:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a4so5157644ejk.1
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 01:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cXI+zGp97KZN7Fj/bOBcqZt70ZKVkWmLXSInV0QvWjI=;
        b=XrX1u2/kg8znWEAHwDQi8j3NrWovBzKYAgGYpVzg4Wds5ZjRKt3pzW6m00lgpQCoD1
         ZwcZjcKvNN/9JnBXcX7Bj9/cdgkQpCrrxOi/1S2Ti+hi8sJLyx9HVganzHHAaOHArvGi
         xClm+ct+nm4UEJPX8mlVXkXUXghCUGVJN/rGeMt2b4iM067CI+EoHhgqOUN71/mCp+ok
         Hhpyg6kuqR9dkqdeuKXSmBt/2Ze3F3gZLx+xbLZfaiIiOpS2V9yJb9plKSRZ4JdoWxrp
         GBM8dzGChx6jt+ZjT2buraW8jVYo06lVFMjq3Z68hJjHDA+gtNo2DPG5ID9ZmdO3SwZ6
         KtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cXI+zGp97KZN7Fj/bOBcqZt70ZKVkWmLXSInV0QvWjI=;
        b=ayERI6DbR5FjJtjgKjfiSWM9XVfnkEGDkmD3gTRJlKc8VUvzZRLJpCegj/G3jYQLcG
         ImKjGmweCbAgfCLI7pQrdG1WfW7R9Wd1Djy3Udu9lBN2UTpQFHwBnUHn+S/fd4QGkLTO
         JQ5J9YbACNhJKPe3R0F15rygHICLvuUnyYLuuhIlTyfuCVziG9nsUDmkBBhaKMMjuR8P
         XjMG9/xgYc9SwiOZB8QKw3hN/Z6xjZNSaIzRABMd2es6D2boqpx1t+S7S6Dk6C3IKNpz
         TlEQtElq3HCktPUSeF1v1vWocQrufY7sKMTa0hDVGzmIsukapUnOzKCq1bWS88tDtXgA
         Ancw==
X-Gm-Message-State: AOAM533i+bUA1TRti1vAv2gQf5UuZCZsgUxMJiudhu+Jm+ai4QRxuzcm
        EAVOp1r7iBoBTeSUo2ngQRdpbEUY8MtZEHp7zFWiH3fyXVzkLw==
X-Google-Smtp-Source: ABdhPJyfTXec1aDbaoaLmCy3tD6AtMZdy6Ia3emiDcFMcR6wgWF3MLQ8Huu5BZryGzHY0RYVSpTx26AmGIFVh4gWMNo=
X-Received: by 2002:a17:906:1a0d:: with SMTP id i13mr32535213ejf.197.1619683522063;
 Thu, 29 Apr 2021 01:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210429072451.38422-1-bagasdotme@gmail.com>
In-Reply-To: <20210429072451.38422-1-bagasdotme@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 29 Apr 2021 10:05:11 +0200
Message-ID: <CAP8UFD23Wvm-SpoAoFZZWXfXO_KGPdT5vwa4gWXMbtgL66me=w@mail.gmail.com>
Subject: Re: [PATCH v4] t6030: add test for git bisect skip started with
 --term* arguments
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 29, 2021 at 9:25 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Trygve Aaberge reported git bisect breakage when the bisection
> is started with --term* arguments (--term-new and --term-old).

Sorry if my previous comment was not clear about it, but I think it's
enough to mention Trygve in a "Reported-by:" trailer below.

One thing that might be interesting to tell is that the breakage was
introduced by the following commit:

e4c7b33747 (bisect--helper: reimplement `bisect_skip` shell function
in C, 2021-02-03)

So maybe:

"Since e4c7b33747 (bisect--helper: reimplement `bisect_skip` shell
function in C, 2021-02-03), `git bisect skip` has been broken when the
bisection is started with --term* arguments (--term-new and
--term-old)."

> For example, suppose that we have repository with 10 commits, and we
> start the bisection from HEAD to first commit (HEAD~9) with:
>
>   $ git bisect start --term-new=fixed --term-old=unfixed HEAD HEAD~9
>
> The bisection then stopped at HEAD~5 (fifth commit), and we choose
> to skip (git bisect skip). The HEAD should now at HEAD~4 (sixth commit).
> In the breakage, however, the HEAD after skipping stayed at HEAD~5
> (not changed). The breakage is caused by forgetting to read '.git/BISECT_TERMS' during implementation of `'bisect skip' subcommand in C.
>
> The fix is in commit 002241336f (bisect--helper: use BISECT_TERMS in
> 'bisect skip' command, 2021-04-25). To verify it fixes the breakage, add
> the test.

I am not sure how safe it is to use the hash of a commit that is in
seen but not yet in next. I suggested using "a previous commit"
instead as I thought that both the fix and this commit should be part
of the same branch, and then it would be obvious which commit it is.
Maybe we should wait for Junio to come back from vacation and decide
about this.

> Reported-by: Trygve Aaberge <trygveaa@gmail.com>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks!
