Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960CBC433B4
	for <git@archiver.kernel.org>; Fri,  7 May 2021 13:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A5706141B
	for <git@archiver.kernel.org>; Fri,  7 May 2021 13:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbhEGN74 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhEGN7z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 09:59:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588CC061574
        for <git@vger.kernel.org>; Fri,  7 May 2021 06:58:55 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n138so12903593lfa.3
        for <git@vger.kernel.org>; Fri, 07 May 2021 06:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cS2fy2GHJ4vrOP+3ba+yoBePTEOUM0JC9wlN/B1yyd4=;
        b=t02FB8e+s7yZicUH8zUPtL6oBFMgpnqf6MubTXMmMEudIMGquGvpALgv3JnRA9j+y3
         bhStuno4pZW2S4hiHFpi6QB8QsDIb25octMm2c0oh9GeuobT/grIFaMVm/V03FtcsHwE
         i5mdB07kQ6tcA0QCPTlsVtPNQyIVDShBeUUUr+WS0ZaeROZF1xqadiOhWBYrE6XRGFS/
         bYPj4LGb3DJV9aKPvlxgqitbntH73VI4GhHBlXeA4A98a1Tryq14waqTf/9ViNYJNpD7
         jqc6agrmI1ZNZMGNmIFxAwrIPRMRcdRAqsuPwyCQJ/ezRp166Ugz0HDBCzp/2E9VQIJi
         gprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cS2fy2GHJ4vrOP+3ba+yoBePTEOUM0JC9wlN/B1yyd4=;
        b=FvwF8sLNPlAReUuWCi5Zladdo/F/rg+2WKBKjpqnFCWfeZFLe5hjlWwAfB7IQ2SPlr
         mvYLGFStM77+595Pn31eky7TidzoCWnePjtmnpDkfToVqS//2CGV2h+5rWUR2hQbJoro
         rYzILwkG9wohJr+y99zA553mOIMyrxE87JlnAs5kn2vp93EwKQwS1bTSRmaXlgwFcTnn
         dp5i2WLcraIcKVxoQq+Asow+bEXnsLnKDeNm4ROm5HgRi2TDtjUzwQlocrPpXgkc55yb
         uvvxgXPMfrkz1/9+tVTZN3skZVIF+QBzL15tyLdy5pEEd8oI+o4/UbixjuhNynsbcgMB
         lTSw==
X-Gm-Message-State: AOAM533hqJJfOZnsVSn9EcoIWviFAlAWVeWn567bqcGLJ8g53TTkWUMc
        1WfjNjVcbiiQ6U57Jsc2TxK/XVSgF9i9NS5AKRrW6Ptk8EW2aQ==
X-Google-Smtp-Source: ABdhPJwJvfB60TDfxg+zBOknWCO5DLOiwlHAgKd8ltEXk16BTApL/twbXbAQ+YCUAYYVItRynOIKp5zgsaPvSJDkWQg=
X-Received: by 2002:ac2:418f:: with SMTP id z15mr6405426lfh.2.1620395933583;
 Fri, 07 May 2021 06:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210426010301.1093562-1-sandals@crustytoothpaste.net> <20210426010301.1093562-2-sandals@crustytoothpaste.net>
In-Reply-To: <20210426010301.1093562-2-sandals@crustytoothpaste.net>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 7 May 2021 10:58:42 -0300
Message-ID: <CAHd-oW4N7GB=E6hFc4GAD-b+1QzTR9+hL-hDXwAQkuss4Y4Ddw@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] hash: add an algo member to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, brian

On Sun, Apr 25, 2021 at 10:03 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Now that we're working with multiple hash algorithms in the same repo,
> it's best if we label each object ID with its algorithm so we can
> determine how to format a given object ID. Add a member called algo to
> struct object_id.

In parallel-checkout.c:send_one_item(), I used hashcpy() instead of
oidcpy() to prepare the packet data that is sent to the checkout
workers through a pipe.

I avoided oidcpy() because it would copy the whole GIT_MAX_RAWSZ
bytes, and the last part could be uninitialized, leading to a Valgrind
warning about passing uninitialized bytes to a write() syscall. There
is no real harm in this case, but I wanted to avoid the warning as it
might confuse someone trying to debug this code, me included.

The problem with this approach, of course, is that it will not copy
the new `algo` field, leaving it as zero for all items. So, what do
you think would be best in this situation? Some ideas that came
through my mind were:

1. Make oidcpy() only copy `hash_algos[src->algo].rawsz` bytes. (But
then we would probably need to branch in case `src->algo` is zero,
right?)

2. Reintroduce the oid_pad_buffer() function from your v1, and use it
in parallel-checkout.c:send_one_item(), after oidcpy(). This would
then zero out the copied uninitialized bytes (with the cost of one
additional memcpy() per item, but this might be neglectable here).

3. Use oidcpy() as-is, without additional padding, and let Valgrind
warn. This false-positive warn might not be so problematic after all,
and maybe I'm just overthinking things :)

What do you think?

Thanks,
Matheus
