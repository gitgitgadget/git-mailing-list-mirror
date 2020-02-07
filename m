Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB92C2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE6520720
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 16:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGQY7 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Feb 2020 11:24:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36121 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgBGQY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 11:24:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so3458285wma.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 08:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8q9VjGIxyKNKgZW9NwBHTit7fNgwfxxuyWwmCWJ2LYI=;
        b=VFnasbJoeySrr8+WV/LCplD3DSb9yb0TSkksOY7aWBY1NOMyL09FJA9ihwnGYhfCiK
         vz6CCmIAEgBUnVfLYWV0grLWySdanesN1exT40byMYUDDbFGSqHBZfXnCx5rGAHvrygl
         12LFWxPUiuOvdPsFfgE7BO9HfDSJw1qRQClKYXudNwE09BActSjRn93lmJzvGCpjSBF1
         yr9Ifo2iHrv348kwLSDrw9PzJVUntN4bR7xs00mClRkuG0hd1Ae35i8F4+w/cx2zXK+7
         5Z2BWGeY25D9+vCqTyzOL2Zs/8572XQjPAkICo+NIfkA7p/iKhi+UvnJXb34eLX4JvgZ
         RGiw==
X-Gm-Message-State: APjAAAVDrH+tWYRu7uvSZl5RgoQlZVnsV9MChe64k5uNP0RSd1ZHHatL
        TaQ2hfX463cs9w4BOfkfMoXRfp/yT/R4S9fv4g4=
X-Google-Smtp-Source: APXvYqxx7Fy1FSOucTOa3Jdvb5SCOcbN9Os2+kEbzD6ZNxIoZqaZzex3MZ2MqxxHK9XM2mVCdisuFy+qNH2+ojPnMRU=
X-Received: by 2002:a05:600c:21c6:: with SMTP id x6mr5142046wmj.177.1581092697702;
 Fri, 07 Feb 2020 08:24:57 -0800 (PST)
MIME-Version: 1.0
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-11-emilyshaffer@google.com> <20200207144725.GF2868@szeder.dev>
 <20200207150857.GH2868@szeder.dev>
In-Reply-To: <20200207150857.GH2868@szeder.dev>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Feb 2020 11:24:46 -0500
Message-ID: <CAPig+cQ8vHjzBdMAemznFbyUSHOuJu167RHkTNg_qmqi-DOB3g@mail.gmail.com>
Subject: Re: [PATCH v6 10/15] bugreport: add config values from safelist
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 10:09 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> macOS 'sed', that's what I was missing :)
>
>   sed -n 's/^\(.*\) \+annotate:bugreport\[include\].* ::$/  "\1",/p' | sort
>
> and the 'sed' included in macOS apparently interprets that '\+'
> differently than GNU 'sed', and as a result won't match anything.

More generally, this would be a problem with any 'sed' of BSD lineage.

> FWIW, that '\+' doesn't seem to be necessary, though, and after
> removing it the resulting generated array looked good to me [...]

A reasonable replacement for "<SP>\+" would be "<SP><SP>*" (where <SP>
represents 'space').
