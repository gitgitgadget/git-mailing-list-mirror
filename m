Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD081F404
	for <e@80x24.org>; Thu, 22 Feb 2018 19:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751338AbeBVTJG (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 14:09:06 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:47086 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeBVTJE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 14:09:04 -0500
Received: by mail-pg0-f66.google.com with SMTP id m1so2360670pgp.13
        for <git@vger.kernel.org>; Thu, 22 Feb 2018 11:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r9yv2q80q0VckSvy8+q2UPzoZlNTjc2mk8Q5dapnuQQ=;
        b=Dnm8nFxOAb+WdsRHJQn5cZsb+I1egOn53cSci0OyGM+d0tFUypS8vJc+PQIjPoYYAd
         yNHcEfNZnZXmYBR1E3SrPFILtYlOxmSf27k/1WIfK5YfqfMyFOr0F7ihErlKFBT7IYYn
         vgniyRE8F62ANR7Cw/+HRrnLqvbZQlRc+HAX0AtbSGKZz1lKyL06LtI+gJsKv8IdP8Tc
         JrB3RRmwe9SIcWY4APW11Klqek+0QLZUwD1oVXt1herfjmqiORjrBeMxbNl4Yby2nb6V
         LYINsmKS3PyEJHxptZa+BVf3MrwIac2+YxOwh234JV2ludbj+U4Kb1Y9TA3Gv89D5vk2
         klTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r9yv2q80q0VckSvy8+q2UPzoZlNTjc2mk8Q5dapnuQQ=;
        b=RXLMoE587S0Umj8JlJgEBu37CH19dl9quBHbqXWd+WdbM+41OzzkSGNMzWAq+N3sKz
         Iorix59XJZaniKKZMYVgVJXV5gNJh4dNwJ7pZpJe84R8iwTs3yylSHQnpY9uJZDZlg9v
         K3XvG/Qg6F71c9sWa8eWDrEbccNOdxnE6BHITujIygImQI+4iZwgjwNcFZEig5SjhS9V
         nHgXF0FPu4cyUx77La1tLbHiYPdaiGwbh30IBRnecmD2qGgSTCIQPB9junNxY1A39Eef
         z06Nod/f054nV8o17bYLlZ74IjAVHIfGfcZNvlY/ruuKYhGKYjc3GSlCOP08JWKm9TNY
         OUiw==
X-Gm-Message-State: APf1xPA63upIC4ibQWeaF0QQyZ2AwZ+GaeikG2ZsbEpuvFP75+tzrqIr
        muHZ+RvUexIv8c/Fbx0Atpe20g==
X-Google-Smtp-Source: AH8x225mgvQ9K1OXw1SKfsGjWxC1Tm3TH0OsXDVoYiPbsIryobTn7f6WW2CeX4iyrvcETIrI6y+zkQ==
X-Received: by 10.99.140.29 with SMTP id m29mr6601484pgd.320.1519326544143;
        Thu, 22 Feb 2018 11:09:04 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id t8sm1015745pgn.93.2018.02.22.11.09.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Feb 2018 11:09:03 -0800 (PST)
Date:   Thu, 22 Feb 2018 11:09:01 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 35/35] remote-curl: don't request v2 when pushing
Message-ID: <20180222190901.GL185096@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-36-bmwill@google.com>
 <20180221161209.80f0a3b941a069ea78ccf43e@google.com>
 <20180222185948.GK185096@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222185948.GK185096@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/22, Brandon Williams wrote:
> On 02/21, Jonathan Tan wrote:
> > On Tue,  6 Feb 2018 17:13:12 -0800
> > Brandon Williams <bmwill@google.com> wrote:
> > 
> > > +test_expect_success 'push with http:// and a config of v2 does not request v2' '
> > > +	# Till v2 for push is designed, make sure that if a client has
> > > +	# protocol.version configured to use v2, that the client instead falls
> > > +	# back and uses v0.
> > > +
> > > +	test_commit -C http_child three &&
> > > +
> > > +	# Push to another branch, as the target repository has the
> > > +	# master branch checked out and we cannot push into it.
> > > +	GIT_TRACE_PACKET=1 git -C http_child -c protocol.version=1 \
> > > +		push origin HEAD:client_branch && 2>log &&
> > 
> > Should it be protocol.version=2? Also, two double ampersands?
> > 
> > Also, optionally, it might be better to do
> > GIT_TRACE_PACKET="$(pwd)/log", so that it does not get mixed with other
> > stderr output.
> 
> Wow thanks for catching that, let me fix that.

I like setting the log via "$(pwd)/log" but it turns out that this
appends to the file if it already exists, which means the previous tests
need to do some cleanup.  This is actually probably preferable anyway.

> 
> -- 
> Brandon Williams

-- 
Brandon Williams
