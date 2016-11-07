Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDCB92022A
	for <e@80x24.org>; Mon,  7 Nov 2016 21:02:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbcKGVCU (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 16:02:20 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35317 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbcKGVCT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 16:02:19 -0500
Received: by mail-pf0-f178.google.com with SMTP id i88so95329415pfk.2
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 13:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fPbRWOlDp9vUDlGv0ZGWbtIe54ywc45jcmr19fex3vk=;
        b=MGW1CZ1diY+oGagNSA3yXQKmdvUN4gA7PUzMTDzuCq387UGyE4isS/2z/5JWqjGrLn
         cddUrS0+vZOTEhhryfmJSRzsK5Qn+Qtg+adlH0Sqt3dpTHmheT8K8B8T3o88eObkFKcT
         ELmX6ZpVFtzAKPY49mTrSash9zCd5dEifdEV4iI/tavyDI+JoDK6/+P7GbqhEYjelXP3
         SXuTvmqno48Clx6I2QupVTyaNy5e4Di7xrkPLHtCNuUPgPNG8UpGNxvnMM9AV08Zv9ay
         ouQTqYytCbtfLFdCAuoB5jshdpKHcoMvNaZr2boxaTF12JCLKN4N/THjJGjuj1EZlqIA
         bVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fPbRWOlDp9vUDlGv0ZGWbtIe54ywc45jcmr19fex3vk=;
        b=EdzfjCOvdyh5ejLt5vpId2KrQxqLYj0e+PLtUJ7cEyIH5DooS8x2Nz7mGSfe0rip2L
         2WKEzeNUVcbyCjglv7YaYD72R7jvvzBPislJa9aTH2lIlUy4WpVhOvA8CJie5u8U4nF1
         lYKP17ZfLVNgPe/P/9Ir/2K7UjDwEHfFiibaxqyvDykQVzHf9wuH1soLj/xUsHBmiluD
         OKyV9kB0UrDA0KEmCm3Yl1Rc+4Xudb56NPVwFwVmtVufnkQ/ufI2Im0wsmhK4N/YoCcC
         dfDeVBW0FeiJ9fl48cJxG+Wvon8/dAvz+SgOmiNkGX92hR1Kd97b+IhBI6AEERHpnpW7
         6URA==
X-Gm-Message-State: ABUngvduSEE+zQT8oGpqXvoMxK7vc989i2HQhg07e9HFZTAg+UcrW7HeVozn+nImJqkZS1RG
X-Received: by 10.98.7.83 with SMTP id b80mr16806883pfd.79.1478552538333;
        Mon, 07 Nov 2016 13:02:18 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:bd82:3124:1b9:77b4])
        by smtp.gmail.com with ESMTPSA id n2sm42592820pfa.75.2016.11.07.13.02.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Nov 2016 13:02:17 -0800 (PST)
Date:   Mon, 7 Nov 2016 13:02:16 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v4 2/2] transport: add protocol policy config option
Message-ID: <20161107210216.GD143723@google.com>
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
 <1478547323-47332-1-git-send-email-bmwill@google.com>
 <1478547323-47332-2-git-send-email-bmwill@google.com>
 <20161107204430.z6wrazgad4e7yn66@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161107204430.z6wrazgad4e7yn66@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07, Jeff King wrote:
> > +	test_expect_success "clone $desc (env var has precedence)" '
> > +		rm -rf tmp.git &&
> > +		(
> > +			GIT_ALLOW_PROTOCOL=none &&
> > +			export GIT_ALLOW_PROTOCOL &&
> > +			test_must_fail git -c protocol.$proto.allow=always clone --bare "$url" tmp.git
> > +		)
> > +	'
> 
> This test is a good addition in this round.
> 
> I suppose we could test also that GIT_ALLOW_PROTOCOL overrides
> protocol.allow, but I'm not sure if there is a point. If git were a
> black box, it's a thing I might check, but we know from the design that
> this is an unlikely bug (and that the implementation is unlikely to
> change in a way to cause it). So I could go either way.

I'll add in another test for that, no reason not to test it.

> 
> Squashable documentation suggestions are below.
> 

Sounds good

-- 
Brandon Williams
