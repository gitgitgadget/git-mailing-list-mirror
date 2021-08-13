Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDB2C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19FDE60234
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 18:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbhHMSB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 14:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhHMSB1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 14:01:27 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B948CC061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 11:01:00 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a12so8946451qtb.2
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b0nB2CAw3F28eEYTv7tgR/FpRTubJZ4ZW5QbgbMX7BA=;
        b=X1h1TxVQLbyuKufDTDOskZMN8slAb9gXRVeRtm1uBJ9iOiWobc7Q0nF95W/IcF9m8c
         emh38D5Oxze3YVFg2QV6uoL41frP/NR2ujyH8pLJ40xrGTRzU551M5zSyQyD0fkfDjGz
         iOAPPc9wqERj3kZDc6Cdit7r/CcFhIt2gsXMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b0nB2CAw3F28eEYTv7tgR/FpRTubJZ4ZW5QbgbMX7BA=;
        b=XDRSbqIM9s6osfk/DKWXvPpFH0vKlkfStnGD+foNci0Er6UFw7sv+mfjPNzNb6UY4O
         Qa0wnd4BP+w0Nj3eVU5uHwXooLq9O5UBatkKxFdsDnrBDgMdpdBrJbVRf2aoNqE0j3oY
         3YWPhiv9fzGGZL1YNWr9sR5z7tN2ksv3BVkrhLH2P7n7j7urVRAHetDQ0yy9O+qrTSlI
         k6NO2blVZhU8mRC53NKXBe3uCl/XdbY1mY+0o5VkgwlNBRchZRcNGfPdjfkmEEcSVcBI
         7UXTVZGi+adGhqiMUu1SZQMR+3kKP0xzM3kGvYqsS88w9zbClvMpK6GBwJG4LdQqlKYX
         pjmw==
X-Gm-Message-State: AOAM530sGWrr9j/7IRH23M6bLXDTvgcDjhpriAC2Bg8jAA4xK64k3z+s
        3UhNgg8Xl8V8xfCd9hqCHG4BPwZ9gSU5+4ix
X-Google-Smtp-Source: ABdhPJyMZPSqd9Frb9LW4Ufp8eP0oHiJDNKhGnc8sAkf7H7PyPyNnZTDfXdcNF7Pcyska4MvtzoXNg==
X-Received: by 2002:ac8:1e8d:: with SMTP id c13mr3044783qtm.170.1628877659767;
        Fri, 13 Aug 2021 11:00:59 -0700 (PDT)
Received: from nitro.local ([89.36.78.230])
        by smtp.gmail.com with ESMTPSA id h140sm1494365qke.112.2021.08.13.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:00:59 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:00:56 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Ben Goldberg <ben@benaaron.dev>
Cc:     git@vger.kernel.org
Subject: Re: send-email issue
Message-ID: <20210813180056.ctzivmakj4bj5apa@nitro.local>
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 01:57:13PM -0400, Ben Goldberg wrote:
> ```
> Net::SMTP>>> Net::SMTP(3.13)
> Net::SMTP>>>   Net::Cmd(3.13)
> Net::SMTP>>>     Exporter(5.76)
> Net::SMTP>>>   IO::Socket::IP(0.41)
> Net::SMTP>>>     IO::Socket(1.46)
> Net::SMTP>>>       IO::Handle(1.46)
> Net::SMTP: Net::Cmd::getline(): unexpected EOF on command channel:  at
> /usr/lib/git-core/git-send-email line 1556.
> Unable to initialize SMTP properly. Check config and use --smtp-debug.
> VALUES: server=smtp.migadu.com encryption=tls hello=localhost.localdomain
> port=465 at /usr/lib/git-core/git-send-email line 1583.
> ```

You should use:

port=465
encryption=ssl

OR

port=587
encryption=tls

I know that this is confusing terminology, but "tls" stands for "StartTLS",
which works on port 587, and "ssl" starts for "smtps" on port 465.

-K
