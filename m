Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11221C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50AE64FAB
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 15:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhCKPMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 10:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhCKPMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 10:12:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CF8C061574
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:12:31 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso9489679pjb.3
        for <git@vger.kernel.org>; Thu, 11 Mar 2021 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qj0qSXGA553rUsiHy/7ayjct7+j1QsnO6OXb2p/0+fg=;
        b=H1Q0Bcy1PvBjVau0imrWe1RM9wHTW50JzVTO4BRxvESw/W6/W2IXaoy1wAd7rPMo5z
         5Xcf5+7nMcJ+JWCPkvr3wNRIZkpEYAhYKVi91YBXCVKa+uM6pFL9Hhb6k+d1XwafQdA5
         UFAg2EI1GU04IvFxUqLJi/gzg5uSvMOYl2Hx8E1zEPklY34vrFCTYFOWt3kX0EeblYDW
         5EwvcDE3b8EykdJrQOorR79RD6y7QGhwkEHv9uZZzoaOO5Fpp+/JJaEwRAmwjzHQgXFW
         H57CKoS6Zi+SD460OX10PEuPkrICiuKuFrz78ZTFD+Y5adz+XDPQjPtb0Ge+jU/6NcBf
         NDXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qj0qSXGA553rUsiHy/7ayjct7+j1QsnO6OXb2p/0+fg=;
        b=rJgzIM7ASYERPEV7oEVXNekkk+kUxzV2MKXvtjia7WaOKja9r1ZnbbIct7RDZkMvsX
         umPBDEoemC6rHcbWZQexs4Cg1G4p8NjMpg1bwezOo3n80Wz1m6M6KR2ZlZuiWKuHf71W
         griIjZPKwkHSxgkAHD65s9VRrCXOE5LuSREa/S5esEL68UmVbtq92Mn1CU8sB+QMcRmY
         8fXke/Y+tVsIuUlD5pwgmNUzHR1nt1BSVzN5BZd2/gs2ZfswHcfgtP0Y3E85PoDVAACw
         38jeIfNgi3mj8u0Gny+39trnBVDsClHBlyReoM9ks8qqLYEVZdecA8JdKv4qwEH28CG4
         hVdg==
X-Gm-Message-State: AOAM533hq3tQzkQCSpRjie4vb4s32GDb2scDP6yhu+RnYWskqpJvRlok
        ACXwqANRIho/HhCrMwH/Kko=
X-Google-Smtp-Source: ABdhPJw/Xzqirj3bdbUT1aOtbTB0C0BtGLnnDSXps75H/B25LDaVWkL+FJtXIXfYXeUX5sQB3DifsQ==
X-Received: by 2002:a17:90b:681:: with SMTP id m1mr9142707pjz.168.1615475550525;
        Thu, 11 Mar 2021 07:12:30 -0800 (PST)
Received: from konoha ([14.139.233.131])
        by smtp.gmail.com with ESMTPSA id t19sm2520667pgj.8.2021.03.11.07.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 07:12:30 -0800 (PST)
Date:   Thu, 11 Mar 2021 20:42:25 +0530
From:   Shourya Shukla <periperidip@gmail.com>
To:     Krushnal Patel <krushnalpatel11@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org
Subject: Re: GSoC'21@git project application
Message-ID: <20210311151225.GA13948@konoha>
References: <CAFufNaq=FCfvBGBhnjatdn1KUoQYV=Y2zOWWMFWwDLwTR-ujrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFufNaq=FCfvBGBhnjatdn1KUoQYV=Y2zOWWMFWwDLwTR-ujrw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/03 12:34, Krushnal Patel wrote:
> Hi,

Hi!

> I am Krushnal, a 2-nd year Computer Engineering and GSoC'21 aspirant.
> I was going through the organizations and git caught my eye. I was
> really impressed by gt as it is due to its daily use but after seeing
> it listed in GSoC'21 I specifically want to focus on applying to git.

That is great!

> The project which I look forward to contributing is the git submodules
> conversion from bash to C.
> I would like to have a discussion on this project with either of the
> mentors Christian Couder or Shaurya Shukla regarding the next
> procedure for the selection process. C/C++ being my primary language

I hope you are not considering C++ to be a subset of C or vice-versa.
Both of them are veyr different languages with similar syntaxes ;)

> and being decently proficient at bash, this project is perfect for me.
> I am ready to work on any pre-requisites required for the selection
> process

Nice. As Christian said, the compulsory pre-requisite is the
Microproject. You may choose any project you like, having a look at last
year's entries for the microproject will definitely help. The search bar
on the top left is your best friend for accessing previous work(s) and
discussions.

Feel free to ask anything. Please do not hesitate, people are friendly
here :)

As soon as you are done with the Microproject, you may start discussing
about the project you have chosen as well as your potential proposal.

Regards,
Shourya Shukla

