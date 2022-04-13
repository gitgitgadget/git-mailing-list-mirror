Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E578C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 17:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236081AbiDMR7Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiDMR7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 13:59:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475A367D21
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:57:01 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p135so2775237iod.2
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 10:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1YvF8iqQM6OYn5HSNwxy2geZjNSDUX5ENtRlM0n4Dk=;
        b=aFbhUc6OTETFr6SJPa2AakQAlze83RMxMAW4fyl7V7mDhZ3lIR1fMbWLEqG7w+vV2c
         WTkS4gDf6pD8FapIGxKqkRJzdW1GBqwJFRgzpcs46Ml90vLB92gngpATW8dEPybVIT/h
         9DfGZed1AnE/NaN9afQ3sf6/ml34MUJO0oW3QZEd5u/zr7G++gBAm54utjXQndsZwM/4
         MtC79fp6sGItuks0MokK3aza9nt2TvNMABnTAVkZ8SH50P5RgOuxMTLsgFwbyqVqb1pv
         19N3608bRm2SRQAZA0DZx57q8wgSpSBm7kn1eW+LyhlyHQVXL/ZOMvf/FZ9I+CvBzgKw
         JEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1YvF8iqQM6OYn5HSNwxy2geZjNSDUX5ENtRlM0n4Dk=;
        b=5PAlHUVb0Og8h5QYc0XcSogkcuvpg48o12wsgldnRkV3mw7ErWZFJIqDc5Vep3/McK
         8BP2BRC6PyWmIdNn+TwaNkrFmFakJCfQWUOOEM0gQoAIu//4scnyk8OLOsZ9pTb9y1V/
         njOpmJXCcMZTHC3jDApJnpwUriGlsaNdDm6h2TG0AYr2b/HPSquxkDLiNjk6KHIEDmKb
         yL5/ugPZfxTm6j4rA4jQ+G3UBWY+d/X09MvrmrtWzIcct8+DuEm4DImT81OirrVpjQS7
         NOSrxBjKSLR6RZjsC56Sn+z8o2j1yczJdWH/bfDZ88XaA4DDozjGNpVDTZHx2v/RfDL+
         O4pg==
X-Gm-Message-State: AOAM530JRXxuaDE6VEvLW5NtlBm1NNFiGAXbhI5QbYCEl3eJKGHROmlk
        hbGBe9KtYqPEk0bWZlKnjTLWeIkfubUY+tWTr78=
X-Google-Smtp-Source: ABdhPJzjpHneIg9HFjg2KmxEle+9hZ5Ti5LJk5lCLr1QaWuqRU0mKZ2+/WRJhz7yfWMQVn4UxKK3LFC2mw7kNc+lgPM=
X-Received: by 2002:a05:6602:59e:b0:64c:b96e:aa4f with SMTP id
 v30-20020a056602059e00b0064cb96eaa4fmr18356273iox.126.1649872621468; Wed, 13
 Apr 2022 10:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqqlew898n3.fsf@gitster.g>
In-Reply-To: <xmqqlew898n3.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Wed, 13 Apr 2022 19:56:50 +0200
Message-ID: <CAOc6etbJXDvXTKKpwi-dKcTnqadjEQH0wQ2pb_CHnJSHQiGZJg@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 13, 2022 at 7:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Edmundo Carmona Antoranz <eantoranz@gmail.com> writes:
>
> I've already gave my take on "is this interesting?" question with a
> "not really", but let's look at the code, as the expertise will
> translate to your future contributions easily, even if this
> particular code may turn out not to be used in the project.
>

Actually, thanks for taking the time. I knew there would be better
ways to do things so thanks for the tips.
