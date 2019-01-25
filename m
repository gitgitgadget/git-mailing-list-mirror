Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA9E51F453
	for <e@80x24.org>; Fri, 25 Jan 2019 17:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfAYRlA (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 12:41:00 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45386 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYRlA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 12:41:00 -0500
Received: by mail-qk1-f195.google.com with SMTP id y78so5838002qka.12
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 09:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tFhAG53eerdC1S2rI70NS1m73vcdultXV6GpIXLTgAw=;
        b=qtiz3A0mH4Kd+UYW3JF/83gQrSfW0ORiFG5nuYHuCI4AvG9c8pRmVJv/RB2pd36Bq6
         LoxA8Bl8Bnc65FN6oW44/+LBH/22Srwg2mDLdzPom/chdJ6ric508XghdrCWjrAwtwDx
         vfXST4C+ybKL681gQX+Kl+JLr+TmaQdbNigNr6F+XDD4cMtXnmVaP+O5hAe1NkubtV4E
         BtCyKkAHlhld3AYU2iEKn23WnuN1R9RFnOlCqp+fS3oqvKSBL4dazG/2mbY5CPay2uD8
         dYhJxW0zy0W0MjYVoIuZyDS14ayTs13RuagB9h/ykYpD0yR2PVgvohoulLZoHZ6vMKKG
         E33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tFhAG53eerdC1S2rI70NS1m73vcdultXV6GpIXLTgAw=;
        b=Hx7r97NvqAzPY3GBPSxXUFSDEb/aj9UN5VY0EW4796LeTYS7OlcGp5cqr/9NlVGbbS
         LQPUQCTceKV5v+riqxE39v3HZerJMfJAqNXyzOKxzrbXDiN+KNTZnOwYwtrenxK0CWne
         PF53ArvbfuMrNFsiI08ekFWKA8BRmUblC3Qw3OScO97IV7IxC+GFLqupa+Dy/31htwaH
         S1uuD0sRv4TJhY4yOs8L6/IC0ZVoZExkEpC1HaK1DWLkt6ff3YBLk0/e5Y/LQXvIo1W0
         0kMBcei86VtLbK02xgFAAtQ3RcACiXoZ4xVE6KLiwZ/uHWQqiGcnopIVc49p8fIlADus
         DM6g==
X-Gm-Message-State: AJcUukcW7z11uwRJpy3e897CBA5/JOrcG5tzZdoHXWq0AVx0OXN2nnyr
        JHwjSoYaJgVNiETskH53XCg=
X-Google-Smtp-Source: ALg8bN5p/f+rB16hu4onyRWFnWpIDTxz70Jf0KS5+luAGmgI9CahgV10x+b96FP4a6FgNwl+S3hi2A==
X-Received: by 2002:a37:c51b:: with SMTP id p27mr10143113qki.86.1548438059635;
        Fri, 25 Jan 2019 09:40:59 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:7d0f:90cb:2b03:b6a2? ([2001:4898:8010:0:6645:90cb:2b03:b6a2])
        by smtp.gmail.com with ESMTPSA id p48sm82407602qtp.62.2019.01.25.09.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:40:58 -0800 (PST)
Subject: Re: [PATCH v2] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <20190124164654.1923-1-newren@gmail.com>
 <20190125165416.17473-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2f785c2d-161c-b6a3-7743-b071969d60d7@gmail.com>
Date:   Fri, 25 Jan 2019 12:40:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190125165416.17473-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2019 11:54 AM, Elijah Newren wrote:
> +test_expect_success '--combined-with-paths works with -z as well' '
> +	printf "0f9645804ebb04cc3eef91f799eb7fb54d70cefb\0::100644 100644 100644 f00c965d8307308469e537302baa73048488f162 088bd5d92c2a8e0203ca8e7e4c2a5c692f6ae3f7 333b9c62519f285e1854830ade0fe1ef1d40ee1b RR\0file\twith\ttabs\0i\tam\ttabbed\0fickle\tnaming\0" >expect &&

I'm guessing that you use printf here because the
'cat <<-\EOF' approach doesn't work with the special
tabs? Kudos for putting in the extra effort here for
the special formatting!

The rest of the patch looks good.

Thanks,
-Stolee
