Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B480C48BE0
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCA161357
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFKR6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhFKR6u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:58:50 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7ECC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:56:52 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d9so1070365qtp.11
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dQ5Jpx9PUrLSFEsowB3eZof+FA9eHPvDNLYlGlCGZOo=;
        b=oOYsDFsksk+cCN75UP12hAQUJHsXV9kleDoRpQ8VgBHhRaCdkE1QTVzgPJsEHtaWI/
         g5ITYTaUijcEsMIEEw299xiFWqUG8fIwIkLM5jO4qK0x3F/xdET5o0mmFp2W6ll4minz
         kfMA9E4Gf/12x4uuLwr43R5MkppnK3rqHAMmX9typUG8Um2C5OVk+suzUqR4p0fBpJNz
         3M8dtxPOcNVyyWAJ19sKNPMq3nR/2InMN688RXbT363nsp+Y/OeGNijqtWhAz+iZkI23
         bl9kGqUwpxIaxaXyH3uBs9yYz8PSpllRUgtv/mdtlXKpfsBQg+sdFaxtgjPHzbKmveeP
         r8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dQ5Jpx9PUrLSFEsowB3eZof+FA9eHPvDNLYlGlCGZOo=;
        b=gggZZi1PU4xA7C7IJ59UNeBLxOSo14gUrUAbXFMdhPCKeQrCS+qLNjSwQcqob67297
         AFc8T6x6OJ2NaT00WWURdWNlafLMehvnxZ3NLzg7P2q3SJ4qOPo90LSoysRawwV46TZm
         MoJjewSQG0p8QHV4MknMJ2/wFImoWCFRNb637FQdrppmJk8FvPcA3ZKlyNm2gwVooAp4
         rvTqZevedOT5YoVOzsq0nHCgCPGfXavxvl9WX5P0W0L6OBej7I9NMA8XBToFJxyC+pJC
         k0aeIJPYjm/i38d0NzZzF04NU7Qk4gd+97oHrHND6Xq7GkHnwBeSjWqvaY0bofK68Jy6
         PB5A==
X-Gm-Message-State: AOAM5317M09Incq41a/BZnOnPvtsaVuNnrVkJuxNmPRIDPBBaB7I3T86
        VUy+ySMrCCJLCPJmLxjquoA=
X-Google-Smtp-Source: ABdhPJwDYZ3B2vDHHykM3fTf7w6tNKREQXJQMgArhIqbFNUk/eXrDVmldX9VI5nCbBt92MsxIbWgRA==
X-Received: by 2002:ac8:424a:: with SMTP id r10mr4902347qtm.147.1623434211293;
        Fri, 11 Jun 2021 10:56:51 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3c70:274a:799:2c37? ([2600:1700:e72:80a0:3c70:274a:799:2c37])
        by smtp.gmail.com with ESMTPSA id c9sm5019905qke.8.2021.06.11.10.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 10:56:49 -0700 (PDT)
Subject: Re: [PATCH] remote: initialize values that might not be set
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.974.git.1623069570553.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2106072355110.55@tvgsbejvaqbjf.bet>
 <xmqqlf7ltg4q.fsf@gitster.g>
 <nycvar.QRO.7.76.6.2106101046470.57@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fab42762-33a3-d74a-87ba-3245d9169df4@gmail.com>
Date:   Fri, 11 Jun 2021 13:56:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2106101046470.57@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/10/2021 5:24 AM, Johannes Schindelin wrote:> Now, what I failed to realize when reviewing this code (and I _bet_ Stolee
> was in the same boat when they contributed the patch) is that this version
> of `format_tracking_info()` is different from what is in v2.32.0. It is
> the version we have in the `microsoft/git` fork, and it has not yet made
> it upstream. To be precise, it is this commit:
> https://github.com/microsoft/git/commit/91209e591b0398c8334a78001a245807f7eb348a

I _did_ miss that this wasn't necessary in v2.32.0 and only exists in
microsoft/git. My cherry-pick applied cleanly, but I should have been
more careful.

> In light of this, it might make more sense for us to fixup! this commit
> thusly:

I've approved your PR in microsoft/git. That settles the real problem
and this patch can be dropped.

Sorry for the noise!

-Stolee
