Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDA61F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbfKERiN (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:38:13 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:41767 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387776AbfKERiM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:38:12 -0500
Received: by mail-qv1-f66.google.com with SMTP id g18so262048qvp.8
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LVevEbSL7Gk6chZ7ITgRqvr087pNe+33UJFUJ+Z38qA=;
        b=L0EhddfjNyS7fCvSOo1oMvqMOEAlWcJEzRlfVlO/ANstN/T0/MR5SCN28uHOcVsJJq
         4rvfLA0JsefwN72Vx3cIV3K0aN/9+mc+Bpker9haD76ym6Io0lbn81pHiseqQU94CUQi
         LNauAvtVyCTyd7l30qsH/YhMPgRCyensdNUms1i7ctjmoh2mwFwKSO6b+CqtxG4ztfqI
         Z5k1jmoBL3JrqqDxxJCOIim4TRBwCqR+IcYEHK27+AmNwEtBinSAGSebO+c5/r2HhIeK
         +3alhOg5QMapdsvIVgPKK9wN0jCjG9L8QXLTCh5Cag5qu7tV/tbvf3SH+/OfO2WO+2Np
         vVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LVevEbSL7Gk6chZ7ITgRqvr087pNe+33UJFUJ+Z38qA=;
        b=s8aqj7tgYDUIbFBp+cvcNRwnhqCq4vSrzRB1t/jJ29PV6rBZEypl++ya7IqecOb6Ac
         tPChCiWEkSMLhHj140agNQ3MiGIwlvzSYvRP1GdGVfGU0R9PzmGS4nQuXKkUMYSp0eKE
         Q8vFvFLQUwy6r/MgiN8z3sXeqQEV/JSo5K+AdNREyquARxRWOj0FyJyEo1X1eBzS3CKA
         3WMMlHOE1JlK49Ln5DeiNwIiktY4jg+DL2aw1bC1Zsu3sSs2H+Vc7xHMBBOJ6R7W3KHG
         7bmGivmvC21btucJHyfsmZqQAcG5rqQEcuGaJpb/lJPaDf8Ex8cWkAHGG4ZC0yaOZBfz
         ctAg==
X-Gm-Message-State: APjAAAXPtcfYNDwxH064WQ8voONwTRkdX2Sb9LOq3yVCExi/nhmtWMSd
        qb9aAryC+9rEVu35DvllhCM=
X-Google-Smtp-Source: APXvYqyN+/0AyT/EkHc0BQ4EBlBUCjyzaaX9UT76rPUS56+vMLWv14mioX54oS8xUOwAd2LRiBs7WQ==
X-Received: by 2002:a05:6214:1343:: with SMTP id b3mr27779865qvw.207.1572975491825;
        Tue, 05 Nov 2019 09:38:11 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9d78:3a28:e2ab:8193? ([2001:4898:a800:1012:4eac:3a28:e2ab:8193])
        by smtp.gmail.com with ESMTPSA id r7sm10878102qkf.124.2019.11.05.09.38.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:38:10 -0800 (PST)
Subject: Re: [PATCH 1/1] commit-graph: use start_delayed_progress()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     rynus@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.450.git.1572969955.gitgitgadget@gmail.com>
 <174c05bf29bbd92342aa45132592c348f988cf0b.1572969955.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <18dde6fe-9072-2069-8063-f1cfcdee3f38@gmail.com>
Date:   Tue, 5 Nov 2019 12:38:10 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <174c05bf29bbd92342aa45132592c348f988cf0b.1572969955.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/5/2019 11:05 AM, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When writing a commit-graph, we show progress along several commit
> walks. When we use start_delayed_progress(), the progress line will
> only appear if that step takes a decent amount of time.
> 
> However, one place was missed: computing generation numbers. This is
> normally a very fast operation as all commits have been parsed in a
> previous step. But, this is showing up for all users no matter how few
> commits are being added.

For course, now that we do not force at least one progress line to show
up, the tests that check the `--progress` option (or `--no-quiet` for GC)
will fail with this patch.

v2 coming soon.

-Stolee

