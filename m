Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF341F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 12:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJJUNv (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 16:13:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54964 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 16:13:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so5352014wma.4
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=j5C6RD7j5xe0NxxYeMsTHqjQe/C8YrlLSldn1adb0Mo=;
        b=Boy50830NvvCirXKzG0HU9edk60qiBotMIiDmpsZZynEqSfUAJg9xMR675xb/VArOl
         d3GBpiTdPW8zXv4PTniMQ2YxwPOiPgDmjzLHPK4grLO0gXSWcNiO3gWPfxPEdbgW5gtQ
         P5nrz2X9bv1d6B6gvQGyjIuTO3fFXNiI5TFogoYC6bQaR/FfUQtn+HGbiQyNnJXxTEbI
         H4ZWYZnfX/un5D4rVl8qgZXyLemnU4msfErWJ6yitbdC/Ho22U9aGzahzQKwORobNpAz
         n+eisvXn50Xvb8cRzURCebjmTNThZB1y1j7MW68urrK6jqcLQG3JQSSiEKMltCpNmPrO
         uP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=j5C6RD7j5xe0NxxYeMsTHqjQe/C8YrlLSldn1adb0Mo=;
        b=jujWyNiLkTD+XlCd6PxQcWSwDdTKHeUQPcaacBCH4g9/Ft1GWdb2C06nlPn3VfSx1H
         1y/4aFLrjmbkwztrpQlqnLBmn7z2XuKBX3GE25tQ6yCjJkDQ4FT4FWcLLWAsPTDJ3UUv
         QLsAUuYW/eBW5/fYU2Dqr0mbjRRfgjCAnoR0p826eO11MnGHxncjlt9O1ndoQZLKzXwq
         EoeUyfaN38HvegoP5NZwjFtAtxICQT3DIl+8REmy89q0X4E4NmCCsYvQFth8fcgj+430
         JwpkJ4sTsibbYtDRVyJTrgq+5TGy+uVz2Q7ZzaIwCK53KRYbQCMiM9BLGLo6MWeZ7iII
         d5UQ==
X-Gm-Message-State: ABuFfoj+nskAPv1QfhiCfrXCft2TIVtuBl63NLZ6ymnb01MYUHr6IxrV
        V5YYlgJvCAwPNY2zJXM2Fy8=
X-Google-Smtp-Source: ACcGV60CtEROywz7M2iTfuplAafhf/aQwTq+YBmdDP+znIsCygEbzNfw00khOXuB2+n42qNlMPXnhg==
X-Received: by 2002:a1c:cfcb:: with SMTP id f194-v6mr764497wmg.98.1539175906991;
        Wed, 10 Oct 2018 05:51:46 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id q16-v6sm19072602wrn.41.2018.10.10.05.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 05:51:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH 3/3] send-email: also pick up cc addresses from -by trailers
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk> <20181010111351.5045-4-rv@rasmusvillemoes.dk>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010111351.5045-4-rv@rasmusvillemoes.dk>
Date:   Wed, 10 Oct 2018 14:51:45 +0200
Message-ID: <8736teezha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, Rasmus Villemoes wrote:

> -				next if $suppress_cc{'sob'} and $what =~ /Signed-off-by/i;
> +				next if $suppress_cc{'sob'} and $what =~ /^Signed-off-by$/i;
> +				next if $suppress_cc{'misc-by'}
> +					and $what =~ /-by$/i and $what !~ /^Signed-off-by$/i;
>  				next if $suppress_cc{'bodycc'} and $what =~ /Cc/i;

Looks good, FWIW I was curious if this could be:

    next if $suppress_cc{'misc-by'} and $what =~ /(?<!^Signed-off)-by$/;

But found that as soon as you add a /i Perl will barf on it, and in any
case makes sense to be less clever about regex features.
