Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81D65C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 17:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C28E23899
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 17:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix3vU7SU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgI0RAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 13:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgI0RAA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 13:00:00 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A8C0613CE
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 10:00:00 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id jw11so2244171pjb.0
        for <git@vger.kernel.org>; Sun, 27 Sep 2020 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z7ZEt2zThahq7Uj9fg1AJOMG6Dhhp3GXkOJ/BI27ALg=;
        b=ix3vU7SUdP4YE5MMlRR+gPC+ybHkYgm20MFWmtrTa1msq6Ndl2bxT5MULcQizJzN85
         g5tgtvSjy0sM5mpSsPpbFGyjbkQbsXTBJsvqjdskguDseNWKBoMnuFMixeEQit2DXQBV
         vJT3WLk/avYpkI3FxpX53rTIWXN6C+KEiG0JYQVsSvJAQU0aF/xCGhfwKhMBTFAXlS2J
         wx1i6bx490bP0A2NNK/2s3MuM38u2pq/hugcYAQuJ5UxiEMi3n557743J6ynplFYOAyU
         aCR9rweDhKWNdQu7oUWbXZcL6GQpgOV2FT1RBIXUJa+nMOWt+onXkMPJwrokDU95FcTw
         C7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z7ZEt2zThahq7Uj9fg1AJOMG6Dhhp3GXkOJ/BI27ALg=;
        b=pwtRub16JawAZ32jJLIvyblHNFhR3dSs7Yo2OpmnlIG5lCgw2A4OiQ8i10fq5cVNPV
         RXr4zQRFEecS9LV5yizaKblkcHv0toOuq2mwUhXYYZRhUUgciTFKp/oYBqQFWexSusv6
         H94sxSEWKi/f58oYarmjbDi7qsQ183rsSx71q9chbdqfwCE9y83xPeyWTpQYyh0F5khE
         eeq78knm2sOTWyW2z3bNjbZjH0bvoti77mfhxjVXd8xadfgMN7ZRXgIjkSPhpJoFteKY
         q9EM/G5V148kadoexUI1f9WuNc6KhsE5g4ZaqwzsebCxv2XvxZHxC2XqZsWPQkMi49UL
         0W8A==
X-Gm-Message-State: AOAM533R6BtS5O3Q53shxr+Ar3FVCz57eh3RkJnrHhiuvPhqq1VhenUJ
        82DtFOB5+O2P+EkQAb2+aBxsN9Ozjr4=
X-Google-Smtp-Source: ABdhPJzuztTnHHIhKwbcOa0u7VmqKa8aq/uCiGKS/ehL09sEVyQR9pz5zG/VMYDmXi2OqVcq+lxZ4w==
X-Received: by 2002:a17:90a:ee16:: with SMTP id e22mr5620762pjy.81.1601225999278;
        Sun, 27 Sep 2020 09:59:59 -0700 (PDT)
Received: from [192.168.208.37] ([49.205.87.4])
        by smtp.gmail.com with ESMTPSA id j9sm8445641pfc.175.2020.09.27.09.59.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2020 09:59:58 -0700 (PDT)
Subject: Re: Git in Outreachy?
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
References: <20200828065609.GA2105118@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2009020558550.56@tvgsbejvaqbjf.bet>
 <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <c6367303-dc40-e896-4ed7-19f9d75b73df@gmail.com>
Date:   Sun, 27 Sep 2020 22:29:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <CAP8UFD31B9YgninC2Fyb=0+OVY7E4SW7LGBbx9E7CrgSn+95BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16-09-2020 14:31, Christian Couder wrote:
> 
> - Accelerate rename detection and range-diff
> (https://github.com/gitgitgadget/git/issues/519): ideally I would
> co-mentor with someone a bit familiar with the suggested algorithms.

I just applied to be a co-mentor for this project. I'm not familiar with
the suggested algorithms right now but I hope I'll be able to get
familiar with them over time. If someone else more suitable for the
project could volunteer, I wouldn't mind stepping aside :)

Thanks,
Sivaraam
