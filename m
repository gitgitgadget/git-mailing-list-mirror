Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E39C43461
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BFF020732
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 18:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vv37A+Pj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbgIIS01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgIIS0Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 14:26:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C8C061573
        for <git@vger.kernel.org>; Wed,  9 Sep 2020 11:26:24 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id g3so2725884qtq.10
        for <git@vger.kernel.org>; Wed, 09 Sep 2020 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FVlre2ttCZuTWHrdsSLVDzRc1vF1K2DVoXYm+jdOe+g=;
        b=vv37A+Pj9B0aTD4XkdHOLG7JzxLB3pMkGR7eGkNwJSe1lfHuEbnpUrrDJCMORDUdFd
         rt3Nm8addSmm7Mp5UMY2tD+e6LZgJ+uQSrpKGGTPzBd/rI4DNRmlfY+r1iL0RQPpl8Tn
         FLZrwr7fzDgEFZgYq8DQQuKuRvXggpAgFWuOOjjIGsqvM5T+i7UwjOnywCjeNWKEUV+K
         6gQwHDPrMGSlbSCNdkehKGJdnwZBqXrXVftI/vI9NFgQtRSuDyfhDHWmT3l7cXHWqPPk
         9CiFOXbiCJRF3d+nje2C4fAn54lO7+O3j8JV9z5EajP6wQAweFVx2s7qRqeUgOfQmsVD
         O+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FVlre2ttCZuTWHrdsSLVDzRc1vF1K2DVoXYm+jdOe+g=;
        b=k8LGebZUDmW1KtfhPLYWswptwjuCMN2ki2oJmYopn/GdSBk9peBV4UcRnLcsmCkQWS
         wXdKtFDgVERvOm1HfndmBot0I/VEuRVSrzm+XZoM1XFKZ1HL2GAdjyjBHtuSmjET6N2z
         r7fJcNuPsrjHNuwrJ4Wpn1Ztw8VtC4p4XZaIinrjLia4WF8Fr6X2TLQ6caxej7pCiAWY
         5D30/D/NrQPjS61z0NHKxB43W0tXjsIXGCnN91zAYiMHs1BnIrhN9hGcRV8GdOWhFYS0
         kfd5AAhW9/MmYSocUaK/owxi5fBPuD23YRjnwYhJR8VqfTniPwMyEdp0ijBFo0OlgJgH
         jmXA==
X-Gm-Message-State: AOAM530K0nfRCkZOvLMysJU9OLXMTPCym+3ukjyNbAJoRc0uYxSYNYYN
        4xNr/ZknkC3KhZQtj/qgLKLbaw==
X-Google-Smtp-Source: ABdhPJx78S1CyZteZnBTL/tbv6Ru12lIz0miDV1F1DuZfAyPZOtJVRzNIgZ846V+u+I77r81S3n/4Q==
X-Received: by 2002:ac8:47d4:: with SMTP id d20mr4443735qtr.199.1599675982809;
        Wed, 09 Sep 2020 11:26:22 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:10e2:cf5e:922:2af0])
        by smtp.gmail.com with ESMTPSA id g18sm3160399qko.126.2020.09.09.11.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 11:26:22 -0700 (PDT)
Date:   Wed, 9 Sep 2020 14:26:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git in Outreachy?
Message-ID: <20200909182617.GA14981@nand.local>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <CAP8UFD2rpNhDhyHdQNxS-KJZgcumsCpK_JQ5koCqXJd70s-+_w@mail.gmail.com>
 <20200903060041.GH4035286@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200903060041.GH4035286@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Thanks for suggesting a great list of ideas. I don't have strong
opinions on most of the above, so I'll save you a bunch of 'ack's and
just talk about the ones that I do:

On Wed, Sep 02, 2020 at 11:00:41PM -0700, Jonathan Nieder wrote:
> I think setting up something like snowpatch[*] to run CI on patches
> that have hit the mailing list but not yet hit "seen" might be a good
> project for an interested applicant (and I'd be interested in
> co-mentoring if we find a taker).

To be honest, I'm not crazy about this one. We already have a system
in place that works well (GitHub Actions) that allows people to run CI
on their patches automatically at no cost.

I'm not saying that we shouldn't have another because of sticking to one
provider or another, but there has been a reasonable amount of churn
there, and what's in-tree now seems to be working quite well.

The goal of providing CI easily to new contributors should be to make it
as *easy* as possible to test their patches, and adding an additional
decision (i.e., "should I use GitHub Actions, or Snowpatch?") seems
counter-intuitive.

> - formats: on-disk reverse idx

As a heads up, I think that I am going to start working on (an
alternative to) this myself, so it may be worth pushing future Outreachy
interns in a different direction.

> Jonathan
>
> [*] https://github.com/ruscur/snowpatch

Thanks,
Taylor
