Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8DC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C84160FEA
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 21:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhDSVt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 17:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhDSVtz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 17:49:55 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB08C06174A
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 14:49:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id 18so13889596qtz.6
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 14:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qf6+PTt+YM16FtvTXYEVHy5091iHW/csDcgcVarGiYw=;
        b=K8sQ2JMJkEbHt/TOADepcmkWygqElMAl+bbU61MHJQgqyN7as7gQTX0WhHm93zAEMF
         iKA0Y+zjDXyebl/GE9EwHBQXmKWnBz6D7GfwRFCjSwIfy3wurOeWu4dD7QXY9OXJrt9b
         GX6BXIdcWaj0pRugi1NrYKFE+veWiKqpf6IPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Qf6+PTt+YM16FtvTXYEVHy5091iHW/csDcgcVarGiYw=;
        b=p+HbRWqR4hksWZuQOGr/lrUM5U1Q+oXvHMRbWCLVgZ7mNpLIfNGhRIHljTQHQR0kp8
         aDFqBWU5EOATYXXTQCTY9Jl3MGuhYTxSC/82ts1HKSLQTNoFhDsdAzc+uGKQMNByGbqH
         V4OhTXKwxUVE2EMKmYQyfzsRQv5ZPGjPxtyIp/qbAeZFezjITe+eus+Rj3o8Ao3kqOcw
         CxrxPbmjDr49wWEEIy9FbX2aAJgwL8P1n21KPxl2TQME73aTBGFYgRMVVDbLqX48H8MH
         zZW1hC+SlwUptirNzLS3ky0BsX20iiYfJb+3o6y4GVqqQvsMb7hrUnwFWEGyuSS0xpPr
         GArA==
X-Gm-Message-State: AOAM532VADm6ACwCyT/cdPw023GuIbv6WvtPf860WKC0wupfR9HvSQnJ
        0cHy0HS7ENBXad/dlopJeQV0qQ==
X-Google-Smtp-Source: ABdhPJyc7I5a0qABtUy8wOfDdPlVXJjX7okp+8brNHymeuWgB4Fjr1Ar8rX1bNXzv1SpB8BRYvlqSw==
X-Received: by 2002:ac8:7f14:: with SMTP id f20mr13535549qtk.339.1618868963068;
        Mon, 19 Apr 2021 14:49:23 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id g64sm8898709qkf.41.2021.04.19.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 14:49:22 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:49:21 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210419214921.afurkxy7oru6bny6@nitro.local>
Mail-Followup-To: Sebastian Schuberth <sschuberth@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, patchwork@lists.ozlabs.org
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 19, 2021 at 07:54:37AM +0200, Sebastian Schuberth wrote:
> > of these proposed alternatives involve moving away from something that's
> > a distributed system today (E-Mail infrastructure, local clients), to
> > what's essentially some website run by a centralized entity, in some
> > cases proprietary.
> 
> That's a good point, I admit I haven't thought of that. Probably
> because I also don't care much. So *does* it really matter? What
> exactly concerns you about a "centralized entity"? Is it the technical
> aspect of a single point of failure, or the political / social aspect
> of being dependent on someone you do not want to get influenced by? I
> guess it's a bit of both.

It's all of the above, and really should not be discounted. Let's take what
Russian government is doing lately as an example. In its effort to control
social dissent, Russian censorship organization RosKomNadzor (RKN) has taken
steps to deliberately break internet operation -- in a very ham-fisted way.
Just a month ago they tried to "slow down" Twitter by blocking DNS queries for
any domains containing the substring "t.co" -- which, hey, broke
gihubusercontent.com among many other sites. There's every reason to believe
that this won't be the only time they do something idiotic like that, so as a
result it is increasingly difficult for Russian contributors to justify
participating in projects that are hosted on GitHub -- one day they may not be
able to reach it reliably (or at all).

(If you think the answer to that would be "just use a VPN", it's one of those
recommendations that are easy to make for someone not worried about their ISP
reporting "sketchy encrypted traffic" to "the authorities.")

Patches sent via email remain immune to this. Even if vger falls over, it's
merely a list service -- there are alternative ways of transmitting RFC2822
messages that don't involve a central host (such as via a NNTP gateway,
publishing a public-inbox "feed", etc). Email remains one of the few protocols
that are designed ground-up to be decentralized and I'm afraid that we are
again finding ourselves in a world where this is increasingly relevant.

> While these concerns could probably be addressed somewhat e.g. by
> multiple independently operated Gerrit servers that are kept in sync,
> I was curious and quickly search for more fitting "truly
> decentralized" solutions, and came across radicle [1]. Just FYI.

I know Radicle folks -- I was on their technical board. A lot of what they
have implemented is very similar to my initial thoughts expressed in
https://people.kernel.org/monsieuricon/patches-carved-into-developer-sigchains

I have high hopes for the project, but it's not ready to take on the world
until they implement code collaboration aspects (issue tracking, change
requests, etc). It's going to be tough and I really hope they succeed.

-K
