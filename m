Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E15C433E9
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6408A23A00
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 16:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbhAHQze (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 11:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbhAHQze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 11:55:34 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0ACC061380
        for <git@vger.kernel.org>; Fri,  8 Jan 2021 08:54:53 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id r9so10193071otk.11
        for <git@vger.kernel.org>; Fri, 08 Jan 2021 08:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIEclgLlXMB/nRcs+qImG87VkMTFXeiJGUV5E+ZeUtE=;
        b=VpW65AGr6vkUP/GW2HyRw8H3saafgFKdRVZsBY/gZhGR/ItIYPvpvLcQEUuJ2weil+
         z2lIbDtaFOTkpcYNfArxUnn7V7kzDWR8e5yhF3suOP0/9yaKiQou5W/1BfyLBVXcCTY+
         ZS2Lzk5dNtWkaq680g/SXjfkEDBxWN/8Ai9UunqzEZmiSAbRAxYYj3ne2g7iXqQiB1mO
         FeP7nem72mYf+G0M6GozTpx79v7m84VtYRwJ1aYwfGYKtKWCvvq4HX1W8Mtqsmef0AR1
         lhU4PJF8M7yYyJofR6tcKoJm6/1xL6m3cnXHSOZQmdfQUtwbmjM3Rvy0XctdQhBoNISn
         NUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIEclgLlXMB/nRcs+qImG87VkMTFXeiJGUV5E+ZeUtE=;
        b=DLQmySU8xCKVfvyDJiCwaCj2/Brg+yQkoUXBo569HrQaqUOjg5qr9mvlLhN49K6anl
         aB6A7Op4ir7iD0hXrx+WFpcHfFxq4MmbqTqpJAAaG+/MYwUigTK4WPO1KPNCJQ91Kofl
         6FwjjFFIIdMsOL6hSME59GFJoxChSSXKeqIj9yz4nyRshVWk2ONo67ZTL2+tT95UN1JO
         9+UW+URItajgaOuhnCW5NZ+o80L6wwAid5ndkC5P5zHDICe39OnlmzS7YiX2pdRipbmt
         fULptQUoQQRXSO///4vCxjqiDNQKdp/wFzGRG4sgQmzM014R/AFJsEBoDK/xwOfKxXqF
         WfZQ==
X-Gm-Message-State: AOAM53162IHlk7TerC4PwjlgvJbmgD0MQ+pZILsGd3/1ivgp6eEJxMQc
        uOsd5ZsCWY0+s0CB4yn4TryTXaGdSAK0p8b/FO4=
X-Google-Smtp-Source: ABdhPJxVM/FYFTnHQ7eDRgN2ZHqmZvHTgQP/dTOfI123oxt2RqRutpcpFHBioIfoQ1GH5uxnQ1wO+Bi2QAc2aMHuL5g=
X-Received: by 2002:a9d:d6b:: with SMTP id 98mr3186091oti.227.1610124893315;
 Fri, 08 Jan 2021 08:54:53 -0800 (PST)
MIME-Version: 1.0
References: <CAHjREB6+=ZT9B-XASAk7Hqt7qD5YhgROjDLCKoJR7cNyJDpDMw@mail.gmail.com>
 <CAP8UFD2AOaPC+7+qcJHQ4+Q5=dhY7ReNbRfJQ=HCS6=4bTPuVA@mail.gmail.com>
 <CAHjREB6ynLFW46C9s8D_nvUpavkugo7syegGuvCMdnfVNiZ+0Q@mail.gmail.com>
 <3bd5cef1-cda7-5118-07ac-a2f91cc80371@gmail.com> <CAHjREB7UonP7TPCd9dvXLX2ho+rJP07JM8nk33AYj9K=Mi7EYw@mail.gmail.com>
 <5fdc958199da4_104e15208fe@natae.notmuch>
In-Reply-To: <5fdc958199da4_104e15208fe@natae.notmuch>
From:   Sangeeta <sangunb09@gmail.com>
Date:   Fri, 8 Jan 2021 22:24:42 +0530
Message-ID: <CAHjREB6fSxYesq03xj2jEN+e7sP-fTpnE1XHMABxqt6B6mzSBA@mail.gmail.com>
Subject: Re: [Outreachy] Blog Post Submission
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey everyone,

Thanks for the much-needed motivation Felipe and also thanks for the
tool. It would surely help me.

Meanwhile, I have come up with another blog post explaining my project
here: https://sangu09.github.io/explaining-project/

Do give it a read and let me know what you think.

Thanks and Regards,
Sangeeta
