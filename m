Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38BFD1F404
	for <e@80x24.org>; Sun, 28 Jan 2018 20:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeA1UKQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 Jan 2018 15:10:16 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:39834 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeA1UKP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Jan 2018 15:10:15 -0500
Received: by mail-lf0-f44.google.com with SMTP id w27so6993103lfd.6
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yIepXGG08/CTYnJ7btdycbU4prBuXKZ7vc/0ojtnzUs=;
        b=QhB0FNBngMPLNozU3+6E8BUrSoQUZs38upWYOTaowm6L5+yzI3M/Z3+jWPseWde1DQ
         u5dd32A/iOiQqC9o1Oy9+1/cBW8gR4zUrmSthyHo33SHQ1FNgbKmMtNrlE5odWrOrMIk
         8lWTBYGxSTfI+GhxKIpFcLQ21cXHrxsLz4Kpjss1x8nYljBA3X/Obwp3nY2wUCPS7Q64
         yMrCCLarXcq/SdolY+lyVJ+13IVMjYzdxNJTjIj7/n5zRfzJJeDvVHNNkxItYaWxYVPF
         p4tUotOzZjsqkz2e1/LVRA9z7avzENQBAPmBUeBYqtsN0iTdZfSleRXwL/cpSb0nYIvm
         e4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yIepXGG08/CTYnJ7btdycbU4prBuXKZ7vc/0ojtnzUs=;
        b=hmLLJ+H/wyJi7uEzf2f44zxyFBxeou6QwsnS/hnjr+CZqiKo3cMT9VUfv9AuHOa5tR
         P/b+i+mYga/6A/GX0JP0kEi5Aq03GvqJH+GJjflso73S3l5i5G/YC1jv7Co5nGTsHa9v
         4mVN/XjxRD8SPZ8QmDYhTeLS0a8CsG5K+ITK8GsOIObnP0e92ada+K19FcWTN4aQ4h1M
         PmnhV0qpxVim3gX4rmcrXG4P2IpB+7UkPi6yKO2JprZrHPzlsWTuee8yzSfm4em86Rio
         2gdmtU5B0F1AyFASt/WmjuXHpCvph4X4knJ4O1oVx2Rihbvb5/Qq4zVwdGs675SXD7e1
         mMwQ==
X-Gm-Message-State: AKwxyterOrlLiirW/BrAF7viZY2WPV/jnmM4vEjAs9j8frhD8gy2BwZ5
        4M8ydq2Ntge8WZEm0MBhTrI=
X-Google-Smtp-Source: AH8x226Ki78YrVFlX+8qGIRK2sETlBoW4QiSeJP3eaZkz23J0CqbBqFR4VV7SEW1txYzOz1Bt7L3sw==
X-Received: by 10.46.36.26 with SMTP id k26mr11920589ljk.14.1517170213984;
        Sun, 28 Jan 2018 12:10:13 -0800 (PST)
Received: from [192.168.1.138] ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id g81sm1964442ljb.74.2018.01.28.12.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jan 2018 12:10:13 -0800 (PST)
Subject: Re: [PATCH 06/12] fast-import: switch various uses of SHA-1 to
 the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>
References: <20180128155722.880805-1-sandals@crustytoothpaste.net>
 <20180128155722.880805-7-sandals@crustytoothpaste.net>
From:   Patryk Obara <patryk.obara@gmail.com>
Message-ID: <eb5b2319-a67c-8a49-81f4-1b981673459a@gmail.com>
Date:   Sun, 28 Jan 2018 21:10:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <20180128155722.880805-7-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/01/2018 16:57, brian m. carlson wrote:
> -	if (last && last->data.buf && last->depth < max_depth && dat->len > 20) {
> +	if (last && last->data.buf && last->depth < max_depth && dat->len > the_hash_algo->rawsz) {

At this point line is almost 100 characters long - maybe it's time to
break it ;)

-- 
| ← Ceci n'est pas une pipe
Patryk Obara
