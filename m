Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED245C54E49
	for <git@archiver.kernel.org>; Sat,  9 May 2020 21:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42D82083B
	for <git@archiver.kernel.org>; Sat,  9 May 2020 21:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rga85bOz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEIVbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 17:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgEIVbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 17:31:46 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2943DC061A0C
        for <git@vger.kernel.org>; Sat,  9 May 2020 14:31:46 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id y24so14549230wma.4
        for <git@vger.kernel.org>; Sat, 09 May 2020 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/hcQXWGO8j7m+nF1/hfoAbqJ22bUNdBhx2Dy7bDExIc=;
        b=Rga85bOzf8WWIBCRqU+k4DOdByw0rdTfiHaJ9U/hSwTmGRdWKOl8VtDtm4gZI3L3uQ
         Zfu28BZMHGCVY8NMc/OCYjVe379xjhGuLr2hUhhWqBvFoe4jbpVvK5YSuXf8VIbk48xo
         aos5GEBdAkUE7pyN68BldbEHJ3uBxN9xVyPsqGx7U/cNv/ifEa2AxQMEfWSNdFqHKjJP
         C7+yIVQtx1FGzcEjXRa8ksLNlQXwRaDLieWexi9pYN/CoEKXHFXIvHdBekCRaH665idP
         nGH4wEfwteg6l1xR6BRtwxxc2bUFu7TAVfRjUqLlQ9twbW31McoIa7lK/QGy25yMFsfc
         DoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/hcQXWGO8j7m+nF1/hfoAbqJ22bUNdBhx2Dy7bDExIc=;
        b=MUaxoZ8//VFDuinOhmK7cgwx+PruoHmKtf8EluajdI3SvLVTsWSXcsjTIH4rM1pjWo
         cecK3+OWu9pMHR1Fo642gcqneG+kRjmhMnJjZduH5v61GyFFtz8oxt7ddU9sChH/MjbJ
         3b9DYmSwG2+GVQbnjFrVWV5M3qCscexVeFZsu8FXu1aWqfG8xfPl+zHFVTgcbjy7gIz9
         sbcUmV+RJxaOm7kUzmsykXZBnbzIO3ypIQQzOn5+hnNUtjcPsSv7TrHL84LewY/JMezE
         V/BV4Ni2xZBmFsC1PeJPpYiy1Ds0BunJJGlvUD/kUCAu9Mdf+Dxf1/B+MXBYSnwUZDqk
         0hEw==
X-Gm-Message-State: AGi0PuZVfDQVE+2izZcse4oGUtRrdnYDJSFZNAJSPo5E2tYwptSYtGjS
        y1aaid0ojir2qR+3xz1HG2VvJkA3PDE=
X-Google-Smtp-Source: APiQypLvUYSTVZd9hLceE2LuucC/cajc/GuY8qwO3VVPlyHotdgkx0uix0DB3Tra6PWeiyFvExH0ZQ==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr23024853wmh.39.1589059904640;
        Sat, 09 May 2020 14:31:44 -0700 (PDT)
Received: from [192.168.14.66] (bzq-109-67-195-49.red.bezeqint.net. [109.67.195.49])
        by smtp.gmail.com with ESMTPSA id q5sm1424822wra.36.2020.05.09.14.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 14:31:44 -0700 (PDT)
Subject: Re: [TOPIC 9/17] Obsolescence markers and evolve
To:     git@vger.kernel.org, peff@peff.net, sandals@crustytoothpaste.net
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <9CE46D29-4BCD-4E95-B2DA-939EA10D7934@jramsay.com.au>
From:   Noam Soloveichik <inoamsol@gmail.com>
Cc:     emilyshaffer@google.com, james@jramsay.com.au, jrnieder@gmail.com
Message-ID: <49bf5848-b8b0-13b0-4038-352f702d11ee@gmail.com>
Date:   Sun, 10 May 2020 00:31:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9CE46D29-4BCD-4E95-B2DA-939EA10D7934@jramsay.com.au>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 12/03/2020 6:04, James Ramsay wrote:
> 1. Brandon: I thought it would be interesting to have a similar feature
> as Mercurial has. Mercurial evolve will help you do a big rebase
> commit by commit. Giving you more insights how commits change over time.
>
> 2. Peff: This has been discussed a lot of time on the list already.
Since I'm very interested in this topic, can you link me to some key
discussions you remember? Most of what I've found is Stefan Xenos having
a take on implementing it.

Also, I read some discussions on tools trying to record rebase history
such as
git-series, available on GitHub.
> 3. Jonathan N: It will help with Googlers productivity, but it’s
> smaller compared to other performance fixes.
>
> 4. Brian: It’s a great feature and I would like to have it, but I’m
> not sure it gives enough value to someone to sit down and implement it.
I personally am very interested in this and consider contributing to it
myself,
although it sounds very complex and intricate to perfect.
> 5. Emily: Is it a good candidate for GSoC?
>
> 6. Brian: If we have a good design.

Three's a design proposal from last year:
https://public-inbox.org/git/20190215043105.163688-1-sxenos@google.com/

Did you get a chance to have a look at it?

> 7. Stolee: It should be easier to use than interactive rebase.
>
> 8. Stolee: It would be nice to have instead of fixup commits I would
> send to you new commits which mark your original commits are obsolete.

Hi all,

Seeing this post really encourages me to try my best and tackle this issue.
The main reason I'm interested in this is that such a feature encourages
people to craft very high quality commit history.

It's a great relief to see people discussing the topic, since I've looked
over the web and did not find much talk about it so far.

I want to contribute but since it's a big feature proposal with project-wide
consequences and not some simple bug fix, I'm not sure where to start.

Do you guys have any tips?

Anyway, I think part of the deal of making this feature materialize is
to raise
awareness, so if anybody reading this is onboard, please share

Thanks!
Noam


