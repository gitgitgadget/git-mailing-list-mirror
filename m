Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA37C433EF
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 18:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiGOSXv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiGOSXn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 14:23:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4DCD44
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:23:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id j22so10402700ejs.2
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCg6iIJhee7SbG0IxG4oxz8eY1AHqvZEmGEZxQZwpwM=;
        b=kHhZ319mncGQ+6keAvdkmPALCBmVOw8PuCo3d4BiEsT42PyjlWYO/wEV3OkdHBQEq0
         l6Pkxy1EQDv9gpNu2lr6kGst/Mzz/P2q9nhCpABAcBP1fWgyYnIAZhes+C/hG4wG+aWj
         M6khhQkWEE5uXnLMStLerhBT+kPAdNURlLCmMpnT549eF2LZNoWtdrgP/lyZ+02Jw3Bh
         JB9EqD1es5R7BAUI8WhiIKKym88JE4sHouUgDXLgpcKtJ/owyzTUsgpjDL6iBUaZZnhR
         TWCKjb0uFJaJ6Sb0W/IwDQMiZS7gKnHPUmk926iFoaqeNABPNbyHVUQ1Ay7z8d3W4m/d
         ITag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCg6iIJhee7SbG0IxG4oxz8eY1AHqvZEmGEZxQZwpwM=;
        b=mO3E+5PU7m05hKkje8qsTrdhxe4fx4ntF2UPP0J+m+/fGzAEH2BUG/yOEpEt1IeT70
         drSw8tRrTkV9/3J5y4vNzlotyIq+xELUZ48nD4IN5ZW+GWzxGo0j6pGD716PEkBREZ2o
         mpAw8b9la17Zp06z/7nNdc8C69BS5kEuT3VOUjx9sobS4jCnutA5yRcVtzeoks7bWlBO
         KiZaUO4tgA165ZUB95RmvUIywK3wb5/Bn4ZqF36PiAXnNXGFKgmqxUwXjg/DnPD9B4Yx
         3jy3Ag68oN01YJ9dctObjg+2mP35diZLsAmxncX2Xvo0KRD4G2lgiIIyluu+CvJOudHh
         w00A==
X-Gm-Message-State: AJIora8s2TKjFmsEdcEGjVxL7L7EOfhvwhjxpwP9QDcRd6jNsv5XeB1x
        ep7OFwQAf0mbqtMOFQcCPyeWF7hnrBtwB1PI95E=
X-Google-Smtp-Source: AGRyM1tkmGP/eLkga5Xa/whCZMdOX7mMrcpMYHT0SJFVLYdqGhYYXGhwAb5vWOFd/4XZDp0yvUbyEuh1l6Nhk/yvIAY=
X-Received: by 2002:a17:906:58cf:b0:722:e4e1:c174 with SMTP id
 e15-20020a17090658cf00b00722e4e1c174mr14798954ejs.85.1657909416839; Fri, 15
 Jul 2022 11:23:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com> <a155c1e2ebacf54c451a069499325cdf280606fc.1656924376.git.gitgitgadget@gmail.com>
 <YtDWmAg3R/eRpl0V@nand.local>
In-Reply-To: <YtDWmAg3R/eRpl0V@nand.local>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Fri, 15 Jul 2022 23:53:25 +0530
Message-ID: <CAPOJW5zkUDo7C7knyQWJCpMowWEbKd0ea=MP67L1R4VkDqH17A@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] bitmap-lookup-table: add performance tests for
 lookup table
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 15, 2022 at 8:23 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> Having "lookup=false" in this test definitely helps visually
> differentiate which tests have a bitmap with and without the lookup
> table.
>
> I think we should take a slightly different approach for these
> performance tests. I think the first change to the t/perf tests in this
> series should only enable `pack.writeReverseIndex`. That patch would be
> a good place to highlight the benefit of enabling the on-disk reverse
> index by showing a before and after of running p5310 before and after
> that commit.
>
> Then the patch after that should look like this one, which runs the
> suite with and without the lookup table. That should give us a sense of:
>
>   - bitmaps without a lookup table or reverse index
>   - bitmaps without a lookup table, but with a reverse index
>   - bitamps with a reverse index and a lookup table
>
> ...which I think are the most interesting combinations (I wouldn't
> expect many or any users to have lookup tables enabled without reverse
> indexes).
>
> I think that would allow us to drop the last patch in this version of
> the series. But I'm definitely open to other testing strategies for the
> performance tests (including this one!) if you have different thoughts
> about what the best way to go about this is.

Got it. Thanks !

> Thanks,
> Taylor
