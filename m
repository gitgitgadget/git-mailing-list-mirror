Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F9BC433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE71206C0
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nA5DuuPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgHNUlu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgHNUlt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:41:49 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE8C061386
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:41:49 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id e5so7936116qth.5
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1yghR1GgpgZBmRNlhtIk9tkCzPVgGNYLHNdjCu5TxM=;
        b=nA5DuuPlFFaA0z+010neSuwQJUe8y3IJMk5yZackkxORdG4xvMz+7LbS41zHzrPsJ4
         C93YVdCHmY07cUGHMDk2i8p9AlQ+EFQtH0cDngYUVavVjsunZrjf1jwNoVZ9+nM0NdcZ
         O4r7W7kas7xEf1haF2tVE9QArsX4gBlHxfJe9qMPiuPvS5MQ1KKcyV+MoIOW66D9gB7m
         eGwP5GPqllS5YNjuDcvm6iWgvPVMh68Dg/7mnDleSjR8LyawxkRtcXQW1GvNpSKlLhj2
         KjfyvJBlzRB8YRZ3BDpbtuqxdNDuwnF9LS6zYj/OHBY1zb5ABjGx05xNEL90o5zMkr/V
         pi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1yghR1GgpgZBmRNlhtIk9tkCzPVgGNYLHNdjCu5TxM=;
        b=jvd20CX0Ut8oFenl5SPdPFkhC3Hx2kQN8YquQIEX8dQ2AB5Jg3sKN4x30qMt7m1wvw
         ytGXd/jpYtaWGrSLYjBb8D93Nlr8w6keLRU98kfFJqMn/cnY4GWVPnIfin6NfeMLU+sx
         r2qSwinxpZdmbkGZoN6JhdBrVv6c7J/OUQUrVVnQ7EcBZloL4zCTJMFFJ7ExA7y8FE7J
         yPRwMtSqSRCG9bK+Lx7RBGKFivP6Yz0+bM33ZSBVf+wqDjRw9S8xu/s9N+APwrtzJEld
         9ylqkg8jKGWFvb0ZX2Ly2odD4DitMLgUCU2tehheUy+rqjMy8gmrQ99n4q0hIHAezh8y
         AVyw==
X-Gm-Message-State: AOAM531qrDWbLPreVgwep1TugGXhHUsQdRgO57lUiMXy1hP25tHww/4W
        oTxpAFj8+E2PYQI82p2PM9M=
X-Google-Smtp-Source: ABdhPJzX6xRFJSZPkHTb9GIRkF6Ueq449yu5ztzgEMcYiNGQbzCGF+wkoG18tYW22vqQySQ0/oSaJw==
X-Received: by 2002:ac8:318e:: with SMTP id h14mr3873428qte.245.1597437708471;
        Fri, 14 Aug 2020 13:41:48 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id n33sm11059168qtd.43.2020.08.14.13.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 13:41:47 -0700 (PDT)
Subject: Re: [PATCH 1/3] t/README: document GIT_TEST_DEFAULT_HASH
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <242a44b63c8fc0ab7e8d8a6a913fde71444f931d.1597428440.git.gitgitgadget@gmail.com>
 <CAPig+cQLR1=6W-Y1y1XiWg1pC9FKikpqVsMrDKeK=exLJFDgLg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8555fa4c-1eba-63da-e59c-edba6a39eac0@gmail.com>
Date:   Fri, 14 Aug 2020 16:41:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQLR1=6W-Y1y1XiWg1pC9FKikpqVsMrDKeK=exLJFDgLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 4:39 PM, Eric Sunshine wrote:
> On Fri, Aug 14, 2020 at 2:07 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/t/README b/t/README
>> @@ -421,6 +421,9 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true> +GIT_TEST_DEFAULT_HASH=<sha1|sha256> specifies which hash algorithm to use
>> +in the test scripts.
> 
> Nit: The documentation for all the other environment variables has the
> form `GIT_VAR=<generic-value-indicator>` rather than placing the
> possible literal values within the angle brackets. So, perhaps this
> can be written as:
> 
>     GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm
>     to use in the test scripts. Recognized values for <hash-algo> are
>     "sha1" and "sha256".

Sounds good!

Thanks,
-Stolee
