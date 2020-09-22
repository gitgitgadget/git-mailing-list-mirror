Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2411C2D0E2
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 11:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B71523600
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 11:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeLQL64Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgIVLfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 07:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgIVLfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 07:35:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5C8C061755
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 04:35:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y11so15192141qtn.9
        for <git@vger.kernel.org>; Tue, 22 Sep 2020 04:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4I1oE0EeEch5KaST2kt3ZPepsQgMR+aOD4L1/WjvBB4=;
        b=JeLQL64Ygs90hipDajE2n3UI4zlDDTxiLrYc+1+Imf4MBqGuSjIb1/UlnXi+eI9eXv
         C5qJVq0i3KLGxxoMZUQ8GjMTLY3f3MGm3+Z4c2szqxHp7y3vdtnw89VNk98HgBAEMB0O
         58FsuLXi1+qyNKTipheR4RrfpLm7zLreGpqcE71VgeRGVBquq/Qtdo0cFPnJe0Wl8lpN
         Tr29TpJ9r7sfNrpp2LeSfLha6p4tfNtepPVKGC7tceuxztWbIEUxcAy/H1r0Vv1Az3Oa
         8oLWURkztrUStDJvPxMQHLlN8uiXx1RMjnKNTVWKLh89hwr11Rus5K8lBOSoDLtibxRA
         LRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4I1oE0EeEch5KaST2kt3ZPepsQgMR+aOD4L1/WjvBB4=;
        b=rLiPwuQOyGA2nEhPvpX0Da1LJCejSHy8y3Ly4MmdbPkAOBbQaZ2JXqbC99d3YtAXNF
         9LHUObGUEr4EElj0KMeESxpeGVek2R8+FQZsGCx8GlWMWLw/x60czALqKQH1puYTBUBP
         Duc84K2DWnVnwXCJ6Io26NfY0e/mggo7IYx/UJwqjqDuuvkp3GmW7IEJqGo9YtoAj8oF
         yuHH334TN+8fex00Ghq7CZlk9zxX/4Ns6eMyeiBPDHAs+6dqlF5oixFVZ41VL5pQvv1N
         q/6Q9cDBgZUxvl2r4bQeBBVKchEicC3uYhzQFhBxNHR161UGo7SO4nbKmdKSCpDQGArF
         vhyg==
X-Gm-Message-State: AOAM5336xy8vvyegoaHkW4tixAWRHVvCl3e8QRrXspBoLDmoYVxyBZWv
        3mYF+Gf6UxJtvFWOhp0ErRg=
X-Google-Smtp-Source: ABdhPJxwR96hQyyh1Q9huevZ7S8GVq0DrqV2sIEGxBMFjw5YzoBghZyb0PD3dkdRJuoBXOi5X1eZCQ==
X-Received: by 2002:ac8:4245:: with SMTP id r5mr4186584qtm.52.1600774514699;
        Tue, 22 Sep 2020 04:35:14 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with ESMTPSA id h199sm11256690qke.112.2020.09.22.04.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 04:35:13 -0700 (PDT)
Subject: Re: [PATCH 2/2] fetch: do not override partial clone filter
To:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, chriscool@tuxfamily.org
References: <cover.1600743698.git.jonathantanmy@google.com>
 <070a717aabbac31ae44567dbe54a325029f9931f.1600743698.git.jonathantanmy@google.com>
 <xmqq363acqj9.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b59f00b6-2787-261e-a295-35eb4a6f442b@gmail.com>
Date:   Tue, 22 Sep 2020 07:35:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101
 Thunderbird/81.0
MIME-Version: 1.0
In-Reply-To: <xmqq363acqj9.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/22/2020 1:46 AM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
> 
>> +test_expect_success 'ensure that filter is written to config' '
>> +	FILTER=$(git -C client config --get remote.blah.partialclonefilter) &&
>> +	test "$FILTER" == "blob:limit=0"
> 
> I'll do s/==/=/ locally because otherwise the test-lint-shell-syntax
> will choke on this line.  No need to resend only this line.

Wouldn't "test_cmp_config" be a better here? It seems like
this is testing the "git clone" behavior of the previous test,
so it could be added to that test instead.

Thanks,
-Stolee
