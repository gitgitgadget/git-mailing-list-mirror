Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C24291F406
	for <e@80x24.org>; Wed,  3 Jan 2018 16:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeACQVv (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 11:21:51 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:39784 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750857AbeACQVu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 11:21:50 -0500
Received: by mail-qt0-f174.google.com with SMTP id k19so2711772qtj.6
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 08:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wILLUsr3F5NjxgW0JAmzCp86P7rTAQO+4zVFQnQpPKs=;
        b=kJtLWmfrtOKnlpDxetW0OoqHk0g6hR2MurILkgaYGuH5xBoJMXLYarIirBx+pzaSOT
         qmHNWNKsfraKLauLlma5xCVpJFtjGdFInRFQECzVgSKq7M2P3t7YXWn1nWL8e6AROANI
         xRPUBPx0bCELTJ4zSyeO2hFnNaA5G2BNHSNEbQSds8vjmgHD4U7XQv1qaZ0N0afxE0NX
         0+ucTP5tv38teuEOBj0iAecG//TMS6EZBMqx7jHRmR0IwJOMPlUNtNkSaobCufS3YkGd
         fuMD2xMv6gjsDTDT2Jg0TXQkbg65ppfm/HtXSDcZZaEW+Vnn8wM47IwFlMehaP0AfAuP
         oCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wILLUsr3F5NjxgW0JAmzCp86P7rTAQO+4zVFQnQpPKs=;
        b=q53gJvbwXuacMQegCq9KQrl1Fk2FrnsxobjnjcGsNwYexIbmvaNWRT/Os6CJRQduHk
         Rf8bkbyZt+ASEnp8ivODH4b/2ZHvgOSicy2HA6hMwKv3fTHDjBVytZhvNgNiT+qicVQY
         2Ms7/+AhSsIm7FvmEKcX70Eqh99v7LK4qdPPlEWdGHf5CIHVwkw6VD2JRAc4kDed0d6s
         XB/P3g/SYIult4w5pUBfjOkCK3i8GeNcTirykw8RLXWrfCSoTVPc/Qq81HLHeOzeVSRl
         uJZZAB/KJtFiH76AHXLjDk9Btu+KDCXRazJdkdNEbWOJCOfYQ/GAs79oSVk3OtfTYsVB
         9DNQ==
X-Gm-Message-State: AKGB3mKEJgENJ+5Ir1CmTBnThL0gylpTzCTKNK0X+lhu0yW2gC6PUTX0
        QDF5tg3JOfHwu/hqaspBRpQ=
X-Google-Smtp-Source: ACJfBou5J17A14DUf+5TjyykuAmBtgpkBJk8DOwrcIiLarq+VNHZLynqhn6TKuoKBzr7NN9pFgf/hA==
X-Received: by 10.237.55.74 with SMTP id i68mr2415548qtb.237.1514996509799;
        Wed, 03 Jan 2018 08:21:49 -0800 (PST)
Received: from zaya.teonanacatl.net (pool-173-67-181-41.hrbgpa.fios.verizon.net. [173.67.181.41])
        by smtp.gmail.com with ESMTPSA id a67sm820964qkg.64.2018.01.03.08.21.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 Jan 2018 08:21:48 -0800 (PST)
Date:   Wed, 3 Jan 2018 11:21:46 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http: fix v1 protocol tests with apache httpd < 2.4
Message-ID: <20180103162146.GJ12108@zaya.teonanacatl.net>
References: <20171231023234.21215-1-tmz@pobox.com>
 <20180103002145.GA242551@google.com>
 <20180103003946.GC12108@zaya.teonanacatl.net>
 <20180103061703.GB25752@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180103061703.GB25752@sigill.intra.peff.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Tue, Jan 02, 2018 at 07:39:46PM -0500, Todd Zullinger wrote:
>> I don't know if there's a clean way to do that
>> automatically, short of parsing the output of 'httpd -v'
>> should we ever need to add such a prereq.
> 
> In the general case, we could probably define an endpoint within an <If>
> block, and then try to access the endpoint from the test script.
> 
> E.g., something like:
> 
>     <IfVersion >= 2.4>
>     Alias /have-2.4.txt www/yes.txt
>     </IfVersion>
> 
> in the apache config, and then:
> 
>   test_lazy_prereq APACHE24 '
>         echo yes >"$HTTPD_DOCUMENT_ROOT_PATH/yes.txt" &&
>         curl -f "$HTTPD_URL/have-2.4.txt"
>   '
> 
> in the test script (of course we may not want to depend on having
> command-line curl, but we could replace that with "git ls-remote" or
> similar).
> 
> One nice thing about that approach is that it can be extended to other
> "If" blocks, like if we have a particular module available, or if ssl is
> configured.

That's quite elegant.  I even modified an IfVersion block
and didn't think about using it that way to create a prereq.
Neat!

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
You're not drunk if you can lie on the floor without holding on.
    -- Dean Martin

