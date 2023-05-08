Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C74C7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 17:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjEHRWc convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 8 May 2023 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbjEHRWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 13:22:31 -0400
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682A34ECA
        for <git@vger.kernel.org>; Mon,  8 May 2023 10:22:27 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-75773a7bd66so184302085a.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 10:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566546; x=1686158546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJEC4B7FRCvECR7dqAdC7UbeUcLONBcAGBxi/foTwiA=;
        b=fo2MGCEx1fqlqDXfRKHB3Np6FgENBoAb3Qg/kGwqZN+wRVVlcetoqkHGt4twtaTTPa
         bYMTbJgV8H888Fie7sQI9M5/rYk31EL5/edWbYT/vu6x+C/Fr+40uPFVAJH4VgKuyZJ5
         Dj8k+TcFxCnXUAFEZtmO655MqqsGv4GR1luequYJqOkxNzPzrDQNjmTSJII84tZwc0Gc
         1E6pkG70IiKPiLeoWNBWC5Yjc2JdDrO8rXIfkQMXd8wTSYi8AYyZXHupMhqsmCqSboEp
         dETqdglrxiJoPGzkBdB68raeSaP7u3WbvdDWagl3JROqq8lKbwfhVU/Z2T6SdBUOhVpT
         ZY7g==
X-Gm-Message-State: AC+VfDySyyrdgXV3LyAr2gFsRzJLYpKJyqPDkTsgobtE52Qf+1/lGvV0
        U/Ux327ncCuMaoPC/ynFFnJcpK6BcIZITAs6schKRdz+RvA=
X-Google-Smtp-Source: ACHHUZ7BFqAjcD+xW/q3278IMPWDSDh1IJAI4g9tFj3xFQUPAJT6/zaw4IO3M2T6k3w2J40/c1ExkoktEPhGG/VQE1k=
X-Received: by 2002:ad4:5f4c:0:b0:5f7:a9e1:bbbf with SMTP id
 p12-20020ad45f4c000000b005f7a9e1bbbfmr16955706qvg.44.1683566546360; Mon, 08
 May 2023 10:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230508165728.525603-1-calvinwan@google.com> <20230508165908.526247-1-calvinwan@google.com>
In-Reply-To: <20230508165908.526247-1-calvinwan@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 8 May 2023 13:22:15 -0400
Message-ID: <CAPig+cTQg7XzORPHeD79aHEi1ggOjTPw9X02VPgxcV9uoBOBxg@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] strbuf: clarify API boundary
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 1:05 PM Calvin Wan <calvinwan@google.com> wrote:
> strbuf, as a generic and widely used structure across the codebase,
> should be limited as a libary to only interact with primitives. Add

s/libary/library/

> documentation so future functions can be appropriately be placed. Older

Too many "be"'s.

> functions that do not follow this boundary should eventually be moved or
> refactored.
>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> ---
> diff --git a/strbuf.h b/strbuf.h
> @@ -5,7 +5,11 @@ struct string_list;
>  /**
>   * strbuf's are meant to be used with all the usual C string and memory
> - * APIs. Given that the length of the buffer is known, it's often better to
> + * APIs. The objects that this API interacts with in this file should be
> + * limited to other primitives, however, there are older functions in here
> + * that should eventually be moved out or refactored.
> + *
> + * Given that the length of the buffer is known, it's often better to
>   * use the mem* functions than a str* one (memchr vs. strchr e.g.).
>   * Though, one has to be careful about the fact that str* functions often
>   * stop on NULs and that strbufs may have embedded NULs.

The new text is administrative in nature, aimed at people who will be
modifying strbuf itself. As such, it is unclear why it is being
inserted into documentation aimed at _consumers_ of the strbuf API.
Moreover, with it buried in existing API documentation like this, I
fear that those at whom it is aimed will almost certainly overlook it.

To increase the likelihood that the target audience will indeed read
the new text, I'd suggest placing it in its own comment block very
near the top of the file, possibly prefixed with a loud "NOTE FOR
STRBUF DEVELOPERS" or some such. Further, as the new text is aimed at
strbuf developers, not strbuf consumers, it would make more sense to
use a plain /*...*/ comment block rather than a /**...*/ block.
