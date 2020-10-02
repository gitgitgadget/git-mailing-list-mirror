Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7F3C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BDA20719
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 20:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6+AZDVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgJBUG7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 16:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgJBUG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 16:06:58 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F92C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 13:06:58 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id v60so1997109ybi.10
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 13:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GfbSuV7TaCiGfYOOqSQiUN9o+XOzX/2IiHWMLAbzVks=;
        b=o6+AZDVGfmBOkX108+EpV1WWllgg2ud0vqaXniuzOKsCgCnRiXvXFK4fpmEsBcVERa
         +QTbhWbyeynp0PKeAy6pk6w87FdOzIrmkKrdWCMy8+NHZD61jVke0T0l0rTM6VOv3OL8
         4EdxgaKcPxMZsbD7zaMKKjnaI1jmMpkVCbnqaPzt5Da/4B+FSUYdzmgb00Np1gW9fOJP
         zUFpHJsZZAalXe7KhJDesWk6MRrC5/3fnnvZgu2KiCQD1wvlQXpwsXYcmg1j1QRzq/3i
         oenus1ers19iRB+7aPDiSJ3JHbqehbSSIWR9OMomkp+4HQYed/IcidAFIQ/iDrheujU/
         04vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GfbSuV7TaCiGfYOOqSQiUN9o+XOzX/2IiHWMLAbzVks=;
        b=pNuGHOhc6tpFGuP+2RknppVFjhXl69NiReIVvYK62lvI4bamjJMZfMV26XmQM2yXY+
         s9T6ktWh2H9x3V4HelXx79Xwrp3mwegjE5sR56Th6j1IIphFBYrm+L8rqnklcos1z1b4
         mrv2f5ZjvHCqA1+Eb6ZBFimM5YnoqvEn+T/rtFQUscLvv4+G8EbfT/Bb4DOUzUb47bof
         eJITjvjug6YNjGkkgQn5IubhJ9G0ZnagS4Aoi5711yLZrQGMLv6Z/i+YXO1URr99r5F8
         1NQwwtmtLoT8htGImaUdEKqlpaH7qVyg/49xUJebUAmRVAU2Xgog5LnbopzolKs0KhlN
         eNdw==
X-Gm-Message-State: AOAM530EjbeXIkdxky7qBS7ygpOZF5luBWW8BNZ5IG/2a4LZYz5yA9G/
        aVclvI3FB/pq89LXrb/JXL+ghWaHgfU+8SfWbbc=
X-Google-Smtp-Source: ABdhPJw/Ow3OoQ2cNyqwMqqSM751oWyJXHTr6cy2Ui8eZ25g5SRLVl1kL9nNcWfj+YLu/W6kjVJzgyJSa0VA+gcEmB0=
X-Received: by 2002:a25:6116:: with SMTP id v22mr4925468ybb.272.1601669217823;
 Fri, 02 Oct 2020 13:06:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601337543.git.matheus.bernardino@usp.br> <948d07673f3b7eebf3d776ec2c785e65228ed185.1601337543.git.matheus.bernardino@usp.br>
In-Reply-To: <948d07673f3b7eebf3d776ec2c785e65228ed185.1601337543.git.matheus.bernardino@usp.br>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Fri, 2 Oct 2020 13:06:46 -0700
Message-ID: <CABURp0ovz0G-mYDv+CmL_pSu09WDJTxNQodpnyT3MrYjKjusEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] packfile: fix race condition on unpack_entry()
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <stefanbeller@gmail.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 5:02 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> The third phase of unpack_entry() performs the following sequence in a
> loop, until all the deltas enumerated in phase one are applied and the
> entry is fully reconstructed:
>
> 1. Add the current base entry to the delta base cache
> 2. Unpack the next delta
> 3. Patch the unpacked delta on top of the base
>
> When the optional object reading lock is enabled, the above steps will
> be performed while holding the lock. However, step 2. momentarily
> releases it so that inflation can be performed in parallel for increased
> performance. Because the `base` buffer inserted in the cache at 1. is
> not duplicated, another thread can potentially free() it while the lock
> is released at 2. (e.g. when there is no space left in the cache to
> insert another entry). In this case, the later attempt to dereference
> `base` at 3. will cause a segmentation fault. This problem was observed
> during a multithreaded git-grep execution on a repository with large
> objects.
>
> To fix the race condition (and later segmentation fault), let's reorder
> the aforementioned steps so that `base` is only added to the cache at
> the end. This will prevent the buffer from being released by another
> thread while it is still in use. An alternative solution which would not
> require the reordering would be to duplicate `base` before inserting it
> in the cache. However, as Phil Hord mentioned, memcpy()'ing large bases
> can negatively affect performance: in his experiments, this alternative
> approach slowed git-grep down by 10% to 20%.
>
> Reported-by: Phil Hord <phil.hord@gmail.com>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

Thanks for looking after this so quickly.  This all looks good to me,
and I confirmed it does fix the problems I was seeing.

Phil
