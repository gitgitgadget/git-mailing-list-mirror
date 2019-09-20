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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4488F1F463
	for <e@80x24.org>; Fri, 20 Sep 2019 15:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404126AbfITPhU (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Sep 2019 11:37:20 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38688 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388863AbfITPhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Sep 2019 11:37:19 -0400
Received: by mail-qt1-f195.google.com with SMTP id j31so9156073qta.5
        for <git@vger.kernel.org>; Fri, 20 Sep 2019 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5O/8TULriOYbz/dOy6BRUVdlLk0J9mqqRl3eSHFNqYw=;
        b=ZgEcJcJRZ/lzi3nAE6S2CT7ie8uYdVvUr4yxqsfX+/oVOtqiI+00P65VwdnWNWitmT
         g8LuXdmsI/flGBlMZ7DaqXmK1syBTtzhGfiO9nmJOUpOyPoIsGZOS/NUZg+DHQfpnlla
         ozLvyC6o2kkHkJxmI/0zm11vc9Jip3hhv027mQSHBvB08281ilcm9M/KXJoP2uUAEQCb
         I/2nRUnnyBlxa4RXnRz8WpSpgZrqLwvxdXd6lsV01DKo0qzw7fRjArS2eF/xAN7dDhV5
         WXnedLT7wfKOBN/Jt3colLhKeXcpTLQc5odok0mrtkkPHZcXT7Z5mEpqHfhcTNUyXYYB
         WH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5O/8TULriOYbz/dOy6BRUVdlLk0J9mqqRl3eSHFNqYw=;
        b=GoOvS/BnbbIYMgqBM8ghhTh9idmxWWkH4B0YwG0mFRh0depmV2LUZMDNagMoJMyICq
         9mYCbeohzpzpCykXa3nbvcxVWhKrERupC2bByDBVpf5Se33lMPucxlCZ/l/CKl8YRMEK
         RyzCGluAdd3x5eDvTsPUvuOJMBjtwZ7uwjQJDmD72+ql2CxrakeceKagi+rvREyWY67A
         uU2J9pZUN4sxmRNWy7Lz0hhTmBY/a7zm+/BR+y6v/Gr7pFUG3Bz8PgQck9qjgaFMOmE8
         sxmRjGiW0KQTdfBdF/lFeiqz4RhpeOuost9bKSAVuU1nHRyD4InRRgaCr9np2F3vpYJD
         x8BA==
X-Gm-Message-State: APjAAAUkchPdo28tXgxFE6hMhE5MnC5hpsAqff3F/xs1y4Guieb90/gT
        x7ZT2y3sV/WnP7Gz27ZZL72MOxu1IEU=
X-Google-Smtp-Source: APXvYqyHW5Pa8d0TPnGyZUSkLshq+AaG6u78r/W17BaS4VAqKo56dI1RJs2HKgiAV36bTJRpnd950Q==
X-Received: by 2002:aed:22cc:: with SMTP id q12mr4069597qtc.232.1568993837095;
        Fri, 20 Sep 2019 08:37:17 -0700 (PDT)
Received: from ?IPv6:2001:4898:4070:37:142:491c:a46c:6a48? ([2001:4898:a800:1012:89d6:491c:a46c:6a48])
        by smtp.gmail.com with ESMTPSA id y26sm1194626qkj.75.2019.09.20.08.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:37:16 -0700 (PDT)
Subject: Re: [PATCH 00/15] name-rev: eliminate recursion
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <62669882-bb48-6711-6f9a-b45db2e64da5@gmail.com>
Date:   Fri, 20 Sep 2019 11:37:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/19/2019 5:46 PM, SZEDER Gábor wrote:
> 'git name-rev' is implemented using a recursive algorithm, and,
> consequently, it can segfault in deep histories (e.g. WebKit), and
> thanks to a test case demonstrating this limitation every test run
> results in a dmesg entry logging the segfaulting git process.
> 
> This patch series eliminates the recursion.

A noble goal! Recursion into commit history is much easier to get
stack overflows than when we recurse into the directory hierarchy.

> Patches 1-5 and 14-15 are while-at-it cleanups I noticed on the way,
> and patch 6 improves test coverage.

These cleanups are nice, and I think I followed them pretty closely.
 
> Patches 7-11 are preparatory refactorings that are supposed to make
> this series easier to follow, and make patch 12, the one finally
> eliminating the recursion, somewhat shorter, and even much shorter
> when viewed with '--ignore-all-space'.  Patch 13 cleans up after those
> preparatory steps.

I responded to several of these, mostly with questions and not actual
recommendations. I do want to apply your patches locally so I can try
this --ignore-all-space trick to really be sure patch 12 is doing the
right thing.

Great organization of patches!

-Stolee
