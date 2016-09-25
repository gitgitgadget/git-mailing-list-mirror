Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47F821F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 14:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966376AbcIYOre (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 10:47:34 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36286 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934881AbcIYOrd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 10:47:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id b184so10253286wma.3
        for <git@vger.kernel.org>; Sun, 25 Sep 2016 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=amJo19IktT0xfVpS/s3fbKC/AYebkRJl6J7d5GMtQEM=;
        b=QYsr4wkZHKJdJCwlDqPB/BIIZnBpzVst9qpjDYEqfr/MfgsiYOUueIzGtKIlgdSIfH
         SUUglntJhWY/JdRzXMVUGWq1es1y3zd+LsUQhAO8HIeu8NAwQZw7ewezpR3ZrBt+s9ox
         Axs3W8kAFQpyt+px1/G9paZVu8+8MTLfIe9DD/HSBCpAajqjBSmr4oW+AMj3WFt+i7di
         41gnClVec4jyLKt/C3ZuBy3BAHdyYzuoHJALNz9+SmqC+2hJTbXb4xVIUYVUkOht6xa2
         TjLCfOxODaS//8CvbjTNGLdcXkx4rDsFmyrcXftpumyWqI4VSquogqJloIzkIrI1hCBl
         e+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=amJo19IktT0xfVpS/s3fbKC/AYebkRJl6J7d5GMtQEM=;
        b=QPZ5Uei6FANSLm373Pjzim7PurZnSgfD3l28816tQ9EKfVUxtPsr+ixiIT8cth3dF/
         MoFHlvExPSel7cMLFaMCaHPphbYvZV/t1GJTTUu2fNz7lNN4zC2YbQ0F/9xtkZ77NyA7
         irT05/Zty+Sc2C1+lw52CqJjzDlV3yBsztZaVlUHZBH+q1d0YZzOrY9pEZ+NhsAMX92s
         BN7FDFopRo+Vg1uCqGE46T6OGkjbnW3Mzmq+G8gjInM8hcETLHgtY/Qett0lLEArZIm/
         42aPE8PKEtiXSiRS194j3Kmol1cc8f7/YdqYNFYkFl8V3TUxLdvEGX6p00t9Pgf/7Qkz
         FdUg==
X-Gm-Message-State: AE9vXwMEa9P6zjpHjvLyccUOdaVIo2v9evfFa2G8v54JXGAPWq/ZN0u26ydZypLqsvzwCg==
X-Received: by 10.194.5.230 with SMTP id v6mr16521454wjv.92.1474814851695;
        Sun, 25 Sep 2016 07:47:31 -0700 (PDT)
Received: from [192.168.1.26] (dce219.neoplus.adsl.tpnet.pl. [83.23.56.219])
        by smtp.googlemail.com with ESMTPSA id gr7sm17457413wjc.1.2016.09.25.07.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2016 07:47:30 -0700 (PDT)
Subject: Re: [PATCH v8 10/11] convert: make apply_filter() adhere to standard
 Git error handling
To:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
References: <20160920190247.82189-1-larsxschneider@gmail.com>
 <20160920190247.82189-11-larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <c305f3c8-cb01-c806-9b8d-fa9e805714cc@gmail.com>
Date:   Sun, 25 Sep 2016 16:47:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160920190247.82189-11-larsxschneider@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 20.09.2016 o 21:02, larsxschneider@gmail.com pisze:
> From: Lars Schneider <larsxschneider@gmail.com>
> 
> apply_filter() returns a boolean that tells the caller if it
> "did convert or did not convert". The variable `ret` was used throughout
> the function to track errors whereas `1` denoted success and `0`
> failure. This is unusual for the Git source where `0` denotes success.
> 
> Rename the variable and flip its value to make the function easier
> readable for Git developers.

This also allow to use the 'err = error("<error message>");' idiom,
isn't it...

> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  convert.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)

...which allows to delete some lines of code.  Very nice.

> -	int ret = 1;
> +	int err = 0;

> -		error("read from external filter '%s' failed", cmd);
> -		ret = 0;
> +		err = error("read from external filter '%s' failed", cmd);

> -	if (ret) {
> +	if (!err) {

> -	return ret;
> +	return !err;

Looks good.

