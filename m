Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53315C433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3185B2071A
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323440;
	bh=yMyWZHfV+QLmvh2u9nj31ykoWKlkleIUkhINARP51eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MTyjq/j2jCXYrO7S71FmRlNvanj0vbfkuohqN/wv88uDWxPApJzhe1WKP+35Wfhjp
	 Y3iZIxnh0BtA1Kd4c3lfETWpog8YrnEU8sY/m01QP4iizg5h+hxI1BnW7Yi+LTzquD
	 6DQp7d/caywysQC4qIsafco0corGKEDxYwiXQUAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgFPQD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731719AbgFPQDx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 12:03:53 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DF5C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:03:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id e2so9719822qvw.7
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=93fB8T4vlu62WmuhuWcA262XYKPTkxT52Lckib4tkos=;
        b=DxtE5RjOEDuuXHdIocLA0dAfRxwkm8iAgA76J7iJg/8r4JVCfRfF82RzQEWJZuHFdY
         YMVuzi0RUiBx0J7b9uy2MQKBijj18NRK2SrWRfN1qI0A39GKMbvEaNLDeLEnw/GmOynu
         uQmUOe7QcEurYpjZJZ+19OSlmLo1uwT9BtSUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=93fB8T4vlu62WmuhuWcA262XYKPTkxT52Lckib4tkos=;
        b=YnBKL6WGaxBKyEgJJXyHbq6E8EFv33/J95hPR82UfDoL9KJHFhVgFIqXO4hiEUvVcU
         voJVeeeoHOglLqYsviRjhoV1N3I//apnmIaCJn6QxdRRFYgjzVzeE/KRWn2kRMQR77sp
         v5hWVNUekA0k33AneG1lPNyp+XHHLtfAk+wcVxM9yAVHgne0gNtKQa5DLszCWtk7YYE5
         pT95NXs6FoIqJfhN1wGmZmv6fF0ndHohkSihoqXbNN6KhaKOfY0wQ5tw802DZ+aJlJ/s
         gu0ew7rUrxpoRVLLLvAIHc0X8iXdtVRY03lHwf4uKJ0Ys0WukMAoqQkch5T/cwBAQLAg
         4/+g==
X-Gm-Message-State: AOAM532MFw1/51bcK5yz5tJlQBmF/UW33KbA6ymBATz2ybb6IRqg/L7P
        xc8g9xeLEwSzOwseW3TNM5LG1Q==
X-Google-Smtp-Source: ABdhPJy9+i+/bdSA4wni9JjMkcbJOfv8FDa8WAHGTUOX/DrvOFXVvwBAh+LRA2tlKfSZSEkefMZtig==
X-Received: by 2002:ad4:598f:: with SMTP id ek15mr3009867qvb.196.1592323432406;
        Tue, 16 Jun 2020 09:03:52 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id g5sm16723773qta.46.2020.06.16.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 09:03:51 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Tue, 16 Jun 2020 12:03:49 -0400
Date:   Tue, 16 Jun 2020 12:03:49 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Oleg <lego_12239@rambler.ru>
Cc:     git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
Message-ID: <20200616160349.t65we3jkpq7hqwra@chatter.i7.local>
Mail-Followup-To: Oleg <lego_12239@rambler.ru>, git@vger.kernel.org
References: <20200616100424.39718-1-alexsmith@gmail.com>
 <c0c2d9ad-1d67-8ebe-0063-524005ca97fe@whinis.com>
 <3cd5d8b9-a9f8-fbd1-f218-622f70e45566@whinis.com>
 <20200616133054.2caiwqwp5mlmb54a@chatter.i7.local>
 <20200616142651.GA27946@legohost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200616142651.GA27946@legohost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 16, 2020 at 05:27:01PM +0300, Oleg wrote:
> 
> > Here are facts:
> > 2. Branch naming is entirely the choice of individual repository 
> >    maintainers. Some prefer not to have a "master" branch, and it's not
> 
> Some :-)? This "some" are very few people/projects and no one of them have
> serious reasons to do it(it pampering).

It doesn't matter how few repositories need it. If you've been on this 
list, you would have seen patches being submitted and accepted that fix 
bugs in corner cases that can't possibly be experienced by the vast 
majority of Git users.

> >    simply because of "political correctness" reasons as everyone 
> >    insists:
> 
> You are simply lie, because i don't think that you don't understand that this
> statement is wrong. If so, why this "useful" feature didn't appear earlier? So
> many people/projects suffer without it all time until today, isn't it?

For the same reason any other useful feature didn't appear earlier.  
Nobody has brought it up or spent enough time considering it.

> >    - they may want to use localized names for all their naming 
> >    conventions (using Cyrillic, Hanzi, Kana, whatever)
> 
> No. They wann't. Tell you as cyrillic user, some conventions exist that
> branches and tags should be in ASCII(no one with a sane mind want to
> not to do so). And if you want to make a public repo and collaborate
> with others you will use ASCII in any case. Otherwise nobody understand you.

1C scripting language is written entirely in Russian. Many official 
Russian sites use .рф domain names. If someone wants to make all their 
branch names in Cyrillic, why should we prevent them from doing so?

> > 3. In your example, "millions and billions" of scripts are already wrong 
> >    if they assume that there is always a "master" branch. However, it
> 
> May be they assume this, because about 15 years master branch was *always*
> here, didn't think about it :-D? And nobody told that somebody will come and
> break it somewhen.

Very soon we'll break git hashes from being sha1 by default. Just 
because they've been sha1 for the past 15 years doesn't mean we 
shouldn't or can't do it.

> > 4. In Git, local branch names do not need to map to remote branch 
> >    names.  Your local branch "upstream" can track remote branch 
> >    "development".  If the remote branch gets renamed, you simply 
> >    update your configuration and continue without change.
> 
> We have so little problems and difficulties, that yet another one willn't
> make our life more hard.

Then raise this with your upstream repository -- it's not a Git issue.

-K
