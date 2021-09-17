Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CAC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B6E61019
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 19:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245591AbhIQTaN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243183AbhIQTaM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 15:30:12 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A21C061757
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:28:50 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i4so37456155lfv.4
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sVsbbRzVJIuvkAecV/mPB5ntjxB6ICpPqlG5XK4mtXY=;
        b=CfZRtIqox1bWXczJF7ZmaaS/zOqyuVpCby5N9clLECoYgDo0bqXmAVoaWAV3Id1lJu
         w7PqKSYAiip9t8N3ZAQDbUUYQmQYSe37MPrBlatUT8JfbVQCHTF+/9dOfUbgxwbTYrBd
         pC2pUtxMQi+8C+xb079m77UOEgK2R4X1IFSYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sVsbbRzVJIuvkAecV/mPB5ntjxB6ICpPqlG5XK4mtXY=;
        b=RlqC21Lfk1iGWEp7NI3w5LqhsiSOTujk1ScBvXQA5fDHwyfdrSCew2dqHqYiOb8/WQ
         3j/u5RCyDL6+9DbzccA3iqSxgKz+/FPZLYcPpReP+1QeIriJAqSEyFozNKRofmdU1aBS
         hEvvhiCeuwGadaKF80EB7/XdeiLnjeVm2njgAD+Gm9XHlI1AqMDkskwaKZPMM1ETqyF8
         hFRRgc+1hdwALJqZsj85ufU95+njf7Gh6Zefkd9RbgT3Fi7DSlJ8DujkFMWMhqwg1mu1
         3Y87nsE0V6O9rZN12xNypWz9CI/hcfmAj8LurDwKa5M7APr1rVIClPQIkd0YUxjVfYbJ
         FzhA==
X-Gm-Message-State: AOAM532VHSboMAseRpgv55vJcQmHZtaxJOnO0hFyA2VkEIOkbZ1Fi3nw
        w9EVb6Rkb6hBSEKaKkpOuF9YMSCTFv8rF4y/2jE=
X-Google-Smtp-Source: ABdhPJzMgaCNyAJjMr+hHuiI1zZxg50AhRaxNgymB0xXc42Z9V4DzyNSJKZ7sIAOESsSDL4BSZcvMQ==
X-Received: by 2002:a2e:a591:: with SMTP id m17mr11406612ljp.113.1631906928155;
        Fri, 17 Sep 2021 12:28:48 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l2sm593962lfe.1.2021.09.17.12.28.47
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 12:28:47 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id y28so36266564lfb.0
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 12:28:47 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr10944151ljp.494.1631906926871;
 Fri, 17 Sep 2021 12:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <6786526.72e2EbofS7@devpool47> <CAHk-=wgyk0mwYcMRC8HakzoAKL2Y3gwzD433tqKYYhV+r1PLnA@mail.gmail.com>
 <xmqq7dfgtfpt.fsf@gitster.g> <2722184.bRktqFsmb4@devpool47>
In-Reply-To: <2722184.bRktqFsmb4@devpool47>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Sep 2021 12:28:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgv42Wm3uHPntZNEYFu-dDVYW7yRen1fUBi6keZaKb+_g@mail.gmail.com>
Message-ID: <CAHk-=wgv42Wm3uHPntZNEYFu-dDVYW7yRen1fUBi6keZaKb+_g@mail.gmail.com>
Subject: Re: data loss when doing ls-remote and piped to command
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git List Mailing <git@vger.kernel.org>,
        Tobias Ulmer <tu@emlix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 16, 2021 at 11:59 PM Rolf Eike Beer <eb@emlix.com> wrote:
>
> When I run the whole thing with strace I can't see the effect, which isn't
> really surprising. But there is a difference between the cases where I run
> with redirection "2>&1":
>
> ioctl(2, TCGETS, 0x7ffd6f119b10)        = -1 ENOTTY (Inappropriate ioctl for device)

Ehh. That format of strace implies that you didn't use "strace -f"
(which would have the PID in it).

Although maybe you edited it out.

I think the error output would come from the other process (ssh, or
whatever process you use to run "git-upload-pack" on the other end).

I still strongly doubt it's about pipes - we've had changes to them,
but if they are broken we'd see a lot more breakage than some very
incidental use by git.

But I can easily see it being timing-dependent. And yes, sadly
'strace' can often end up hiding any timing issues because it
obviously slows down the target quite a bit.

Doing "strace -o tracefile -f" in a loop would be interesting if you
can reproduce it (and then stop when you reproduce it, so that the
final 'tracefile' is the one for the case that reproduced it).

            Linus
