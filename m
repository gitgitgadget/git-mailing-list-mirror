Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BA9C2D0EC
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 02:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4A5206BE
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 02:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJMfF3JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgDHC01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 22:26:27 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:36459 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgDHC00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 22:26:26 -0400
Received: by mail-il1-f173.google.com with SMTP id p13so5310323ilp.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vCvMDMU518lOCG9/ehcN4aJhm/iIs+M3sF8Hhna3R2I=;
        b=bJMfF3JVqzPXSF0rwvKa+U221QTtwV4//CzUzI52Ms19L49y4EgYIorz0DrevpW+xI
         ckDJs0Du739GXeEWQHVqK4a+96K3Q2fRQ9gttEKxNIg0KwcNmxqFRnBTu6NHUpMSolMs
         AJrc5r9CZzMGIxG/x/dmu8CS2VldZ4hUHAi4WLs+JJkzJTlhaakrfLfTmzyupRi9NvkI
         aLaxy6IBtSNMiAT4xJia5uhtNKSjA3qVU2Vj7LL4UPMSCjSD8X5WBe9nFzbOLYtG8FS2
         KnWRaIaKc3X86ZnwnNeIdoAVMxaCCqmcRqDhzKLneB8GO1Dd9ytzLo7uELtprYUCkipV
         Px1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vCvMDMU518lOCG9/ehcN4aJhm/iIs+M3sF8Hhna3R2I=;
        b=UhtnQT8t5myItpW9+uw3cntAURL2LQGvkJu4e3N3ZXWthJDcjYRqgWYlgFetSf24FE
         BicUJdo8iUgfbdlPt5LiL9h3CMns40HHZ0VqpaaAvg/Mpx3iR/CJVxBngHJOeVlk90GD
         3cZ7czSX4TucaPOfBsnvmgS+R2rMbVHBG2J/iVcddDtaXGm3PrHMPeoIS+b8CrWMFI/R
         wAz6vSmdpkC5i/6bPt5sTGviFYTuxXpRlnvQy/V4BM6W0wngOCzivKoJ3hGIQ5/vp65B
         9y7oXj2CUd+O9psMeCH4CyY85qS/rwEmBvgClFn/tQ0L58C++QfjErsvYh6cKa2c/s2o
         8YwQ==
X-Gm-Message-State: AGi0PuZHUFWAvlnJDjCQVZf1hYDGGY9rhuTfmnO7+uao7Pw4q2Jjleik
        aj/rVHWgKDAY3CS5Q080yU/HyC2vVguQN4WWObKfPA==
X-Google-Smtp-Source: APiQypKJFJvnjFqxdw/+6Fp8XMV5bzD6hcz+zuA2rW1DiJfTCq7rHp77sNMoAaGptArniROkd2KxgbCRIUVxb1y5kz0=
X-Received: by 2002:a92:8642:: with SMTP id g63mr5408116ild.281.1586312785584;
 Tue, 07 Apr 2020 19:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMSEaH6+fQuDjhY-5THoYpEjjrHU4Sofnmr-nASHaTZbHvQw1w@mail.gmail.com>
 <CAMSEaH5eZdNooNHQJAto_0dCZSFtiji8ZYvft+oZQXfzDHSyEg@mail.gmail.com> <CAGyf7-GVYMXKpptZ8w3tcZAKp41j5_EDe9kp6YcDp7=S4LuVpQ@mail.gmail.com>
In-Reply-To: <CAGyf7-GVYMXKpptZ8w3tcZAKp41j5_EDe9kp6YcDp7=S4LuVpQ@mail.gmail.com>
From:   Sankar P <sankar.curiosity@gmail.com>
Date:   Wed, 8 Apr 2020 07:57:29 +0530
Message-ID: <CAMSEaH6jP3xSLZ_9omJ-8nqjJVYor1TpLZWjW3+K=OZVtM3OSw@mail.gmail.com>
Subject: Re: Git clone question
To:     Bryan Turner <bturner@atlassian.com>
Cc:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Objects are stored compressed (using libz). In addition to
> compression, when objects are packed Git can use a technique called
> "delta compression" to allow it to build one object in terms of
> another. This is something like a diff/patch, but it's not the delta
> that gets hashed; it's the full object (before and after).

oh okay.

>
> Between libz compression and delta compression the pack file
> containing all of those objects tends to be substantially smaller than
> the full set of objects.

Fascinating.

> As noted above, there's no "patching" going on. The server does store
> a packfile, though, and depending on how recently the pack was created
> it can reuse substantial portions of that pack when creating a pack to
> serve the clone.

> Have you checked https://git-scm.com/book/en/v2 ?

Thanks. I will check this out. The 10th chapter seems related. I
earlier came across this but thought it was a user guide, based on the
first few chapters and did not reach here.

If there are any other blog posts, talks, etc. about the delta
compression, packfile etc. too, please let me know. Thanks.

-- 
Sankar P
http://psankar.blogspot.com
