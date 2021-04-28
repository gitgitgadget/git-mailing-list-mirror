Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6421C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 08:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A161061186
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbhD1IMs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhD1IMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 04:12:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC4C061574
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 01:12:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n25so1001036edr.5
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjkH6N8MSWhWw/+7e0HJgaZGqKzn6Xl/eh98VSU474Y=;
        b=ko43P63LI53vU6wi1l60VuBm/A8xVS5wegQTCo5croCU0VILzZKekDdmkydDMuLP4x
         +Bun4VRtZ19BwjJHrM1uoKxfceQV/E8PHGxbrbzZQZyYyN3omQ6N5fawaZBKABN2UYjl
         ERwGGapdT+BIv1X7d5QH/yoLNPWdocF1TRZ+BQQR/rLAHOYDis52GTxKBxrx+OSlY2yu
         B00puidytoravKNiuVDXmXEd/5tFKsz/eKsX8YZqSPs0B2hKeGc5FTNMgr20qHy99pgN
         PhfDvbI6MFZKHdLLXtJSNnURI4Pyhz3h8iKMb1hJA1UxK4vutEtdydn8c63/wUoHJ+vm
         Cu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjkH6N8MSWhWw/+7e0HJgaZGqKzn6Xl/eh98VSU474Y=;
        b=gtTDF4TbG3uyemuuSn5pWRxZNkB/mbMLVtGP64Ql4I22Z7sf6DFKkwDIKyy15oq6ls
         P2+ZJUHfsXFLMeFEmbw6C/sEK6qV5WmDvboDmTDqXHhzq7KT+vii9XUcZq3A8QdNTKJB
         5rP+6ysg4Z147evGG4r8iBTrYpz6+gUzSr2b1QfiQXKSDi5ZTXdSTsSNN2iUP2Y4/kzR
         /l19U+/l8JI+kR8rHhD2ny5efzoNZKR/U7adgDVfWfzXBpat3YKzua+nHhKqKJMdk32c
         Sce2uj9kL4+2cg9/zjPzebWMjhlNVe62vDcbOzGqNPLaKNSx5f5yMSPz9PklNi9e+21j
         mK3w==
X-Gm-Message-State: AOAM531n2gtVXcfm0/rhTg1iTGGbEIYBBi187Jju9gGY7CIyP7Y8/P99
        zv2f/YdynVA2pwA00mhnMTiy8MwbUIZF0XhGomE=
X-Google-Smtp-Source: ABdhPJzKG9b9X91tGNEWStikvC5NO2BHlcKj4tBhobaOX0MDokYA7jg67TG9cDeENaElEs3fx/CkWcjt6+WwoGZIFjU=
X-Received: by 2002:a05:6402:270a:: with SMTP id y10mr9545778edd.387.1619597521084;
 Wed, 28 Apr 2021 01:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210425080508.154159-1-bagasdotme@gmail.com>
In-Reply-To: <20210425080508.154159-1-bagasdotme@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 28 Apr 2021 10:11:50 +0200
Message-ID: <CAP8UFD0k9fwwW94BKtMPLmA=Qx1ce3Qh3UfF0KiC5+AOj-=MiA@mail.gmail.com>
Subject: Re: [PATCH v2] t6030: add test for git bisect skip started with
 --term* arguments
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Trygve Aaberge <trygveaa@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 25, 2021 at 10:06 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Trygve Aaberge reported [1] git bisect breakage when the bisection
> is started with --term* arguments (--term-new and --term-old). In that
> case, skipping with `git bisect skip` should cause HEAD to be changed,
> but actually the HEAD stayed same after skipping.
>
> Let's add the test to catch the breakage. Because there isn't any fixes
> yet, mark the test as test_expect_failure.
>
> [1]: https://lore.kernel.org/git/20210418151459.GC10839@aaberge.net/

We prefer when people can give a proper explanation of what happens in
the commit message, instead of providing a link to such an
explanation. Here it's not so important if this patch (which only adds
tests) is merged along with (or if it's squashed into) the fix which
hopefully contains an explanation. Maybe if both patches are sent in
the same patch series the commit message might want to only say
something like "A previous commit fixed a `git bisect skip` breakage
when the bisection is started with --term* arguments, let's add a test
for that breakage."

A commit message trailer might be the right way to credit Trygve
Aaberge (also please don't forget to put the reporter in Cc like I am
doing), for example like:

Reported-by: Trygve Aaberge <trygveaa@gmail.com>

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes from v1 [1]:
>
>    * Move the test to the the end of test script (test 74).
>      v1 placed the test as test 26, and when I run the script, there
>      are 9 more failed tests rather than just one (because such tests
>      depended on previous ones). Now the test is placed together with
>      similar tests (git bisect with --terms*).
>    * Begin the test with git bisect reset, as with other nearby tests.

Nice!

>  [1]: https://lore.kernel.org/git/20210423070308.85275-1-bagasdotme@gmail.com/
>
>  t/t6030-bisect-porcelain.sh | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index 32bb66e1ed..b1b847ebbc 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -922,6 +922,19 @@ test_expect_success 'bisect start takes options and revs in any order' '
>         test_cmp expected actual
>  '
>
> +# Bisect is started with --term-new and --term-old arguments,
> +# then skip. The HEAD should be changed.
> +# FIXME: Mark this test as test_expect_failure. Remove the FIXME and
> +# mark as test_expect_success when this test successes (fixed bug).
> +test_expect_failure '"bisect skip: bisection is started with --term*"' '

I am not sure why there are double quotes inside simple quotes around
the name of the test. Aren't simple quotes enough?

Also what about a simpler name like:

test_expect_failure 'bisect skip works with --term*' '

?

> +       git bisect reset &&
> +       git bisect start --term-new=fixed --term-old=unfixed HEAD $HASH1 &&
> +       HASH_SKIPPED_FROM=$(git rev-parse --verify HEAD) &&
> +       git bisect skip &&
> +       HASH_SKIPPED_TO=$(git rev-parse --verify HEAD) &&
> +       test $HASH_SKIPPED_FROM != $HASH_SKIPPED_TO

It might be a bit safer and more consistent with the rest of this test
script to use double quotes around $HASH_SKIPPED_FROM and
$HASH_SKIPPED_TO, like:

       test "$HASH_SKIPPED_FROM" != "$HASH_SKIPPED_TO"

Thanks,
Christian.
