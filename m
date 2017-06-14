Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE081FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 00:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754034AbdFNAt4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 20:49:56 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34838 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753038AbdFNAtz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 20:49:55 -0400
Received: by mail-pf0-f174.google.com with SMTP id l89so75439495pfi.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=64nOh2cfnpeXxXxvMXbsJij7RjkNurO5XUzEiLYbMis=;
        b=EDH6tqy5YjU2XVkJI+1xLJi3A9wYvtny5aLmVPO3ZTZ14Wf27WNk6K2tz7l0NA260S
         kq2H7JDnkCgrgbIs53O0iYlDSTka0h2SlhbwmwtkfjYyurEsjt4wh3gVAQWMRY4+mJjB
         Q7bxPuDpmIc3LNS3x9fKE43exdN2yov+9rwIe0dFVUXZ3ICXVoAgj/jDULlwyLDlyrIo
         L+H4O5SkEaeLnWIS4qyYga1tLY7J0vWDZMGyS7VJbsJ0GVSVsy9VVORJbOFWZHiQUhoz
         Zq21jD5NMAck46dklrxs7+cXvnnGWMYPHB7A9Oc9VD0DRylCPLBL+9EcJ++OTYYE3lDv
         zSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=64nOh2cfnpeXxXxvMXbsJij7RjkNurO5XUzEiLYbMis=;
        b=jh1iuaU0F3iK1NxlAwXkctF7ggCwS5SwgoEaScPNf/ksyhy6RKYEnC0L77kt6NXxc4
         5eHpOtESAhCUYaie+lVQSN5LyLpswGtAEMLJDik4EgyPdnCuErH6eZwYaoKshB1pRQYK
         IWw72fgFCtnalgGgD1IQCFineQg806KO8dKm+jypUmxZfM62uyv+X7dQeS7eBeP73Zvp
         NwWH7NgvlJxmvIdO0UJ0yNrNEgZA0sNDtpbYUP5Tbi15LTzGXbVSAfjUUGTNrUz//ON7
         2enk6frGw1ON5M/Fnsmyjysjw1SiJTIZF4zeLYo5ReBcZtEyv0swmueWoH0YPJyJmRe5
         aLTA==
X-Gm-Message-State: AKS2vOwUrHW+V9nauwPBBZH4PPr/3lhKTNvJlA4sqD6sX2e/oVsNj1NX
        oNlstseOXO22jA==
X-Received: by 10.84.211.7 with SMTP id b7mr2135567pli.124.1497401395000;
        Tue, 13 Jun 2017 17:49:55 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:8130:47b0:791f:5985])
        by smtp.gmail.com with ESMTPSA id i17sm28564255pgn.60.2017.06.13.17.49.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 17:49:53 -0700 (PDT)
Date:   Tue, 13 Jun 2017 17:49:51 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] remote: drop free_refspecs() function
Message-ID: <20170614004951.GS133952@aiede.mtv.corp.google.com>
References: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
 <20170526100403.19270-1-szeder.dev@gmail.com>
 <20170526133024.g5rztiv3lea37n72@sigill.intra.peff.net>
 <xmqq8tlfdmpg.fsf@gitster.mtv.corp.google.com>
 <CAM0VKjnOSxQg_VCBO2cgtbqesmNYx+e_H7m=36PsNWi9K9rQ1Q@mail.gmail.com>
 <20170531042747.7k2yfd7eml6ep5cd@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170531042747.7k2yfd7eml6ep5cd@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Subject: [PATCH] remote: drop free_refspecs() function
>
> We already have free_refspec(), a public function which does
> the same thing as the static free_refspecs(). Let's just
> keep one.  There are two minor differences between the
> functions:
>
>   1. free_refspecs() is a noop when the refspec argument is
>      NULL. This probably doesn't matter in practice.  The
>      nr_refspec parameter would presumably be 0 in that
>      case, skipping the loop. And free(NULL) is explicitly
>      OK. But it doesn't hurt for us to port this extra
>      safety to free_refspec(), as one of the callers passes
>      a funny "i+1" count.
>
>   2. The order of arguments is reversed between the two
>      functions. This patch uses the already-public order of
>      free_refspec(), as it matches the argument order on the
>      parsing side.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
