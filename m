Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 561971F576
	for <e@80x24.org>; Thu, 22 Feb 2018 06:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBVGw0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Feb 2018 01:52:26 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44505 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeBVGwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Feb 2018 01:52:25 -0500
Received: by mail-io0-f193.google.com with SMTP id z6so4876725iob.11
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 22:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAf0Czt+BxPc2NUVvwpIwS3pf9AaEoIC7we5rlRJXBQ=;
        b=pwS2D9W1Dj/tzv6RT7c4dAGkxD5a4mZ70otLtVXAxGn8LKEVJSUH9xMLKwQ4wka2gZ
         NQzpIRqlGUaI5jBWk12muZPs20Zs1e4j2qfV97UUcDzOd0HOP6shNpAvWNAHD9ADBxFa
         0a1MpLv3kzIAM0+RJNg1NPaExZvflzpPwOPR0BN+xh1G4gk89j8KtlWa7Szs5VX5kS0m
         qAnGgbJUK6LeM6mcXUHwAQRo965w4o22q20hOZvsAc/miU0Nveivixt5N/3RF//kKeQg
         RPmSPtgvKNGXqYEvlN/nNlvvDajrhhGvFiRumrpqnoiijyjs5agIZZ/1zZFYtKl/s8iN
         fanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAf0Czt+BxPc2NUVvwpIwS3pf9AaEoIC7we5rlRJXBQ=;
        b=A8HlKtOJ8FcY4GyTsvaesLjiW0hqVdxpuEiv3XwEZbk4fU8obmqmDvcYaqNF248obL
         V2M1QO8EBmRHqrRYrbDQ97uzxco/UVkKPyBO+CU5WNKZCERHqIuJAjiOSt72xj1wzMs3
         F4Sb7eO9QrYgrmkr6INLQbmqsSoOGBMhpkrTo5L1kASiXy3V+aHrCH3AULsBwVJJB4LF
         yVSElLezLBlqCiRJYar9Ykr7L9W/F6EHd/V8PRVuqjVXa+21ttfkPCTj6YHSUlSseMO0
         XU5jxcZbmw41IUUEq4+/0vJXixYGBJ+BI38ie//m5fWEKC7oAdB70rop8xgMqmHhsMA3
         XSPA==
X-Gm-Message-State: APf1xPBX7PlWA3Eum1SvWPvsBvNt/AZhOM5a1tYWLkRr2Ll2TbAvJfFz
        tJAu+jTw1XQ8Y3KkRW6p7sk=
X-Google-Smtp-Source: AG47ELulqSAoU1dYlIZoNabhYRTQyVxNyCACVakmkh7PnJ8bMI88Y8QFs39NuT9+q6Omt399XrTqPw==
X-Received: by 10.107.70.14 with SMTP id t14mr7348835ioa.281.1519282344823;
        Wed, 21 Feb 2018 22:52:24 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r139sm26055216itc.34.2018.02.21.22.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 22:52:24 -0800 (PST)
Date:   Wed, 21 Feb 2018 22:52:21 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com
Subject: Re: [PATCH 17/27] sha1_file: add repository argument to
 stat_sha1_file
Message-ID: <20180222065221.GF133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com>
 <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-18-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221015430.96054-18-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Add a repository argument to allow the stat_sha1_file caller to be
> more specific about which repository to act on. This is a small
> mechanical change; it doesn't change the implementation to handle
> repositories other than the_repository yet.
>
> As with the previous commits, use a macro to catch callers passing a
> repository other than the_repository at compile time.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  sha1_file.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Simple and obviously correct.
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
