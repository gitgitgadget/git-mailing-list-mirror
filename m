Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219BC3279D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474122087E
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDk0YrWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbgJFUts (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbgJFUts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:49:48 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E6EC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 13:49:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 19so14259357qtp.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 13:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wyCwsxV2yEYGkWi0n+lPRJxd+iu5eFK4eP4zuOqenm4=;
        b=uDk0YrWCBJw2h+LHlGh4qB2h8FChgjA8Hw1/1vOPqUNpJLXxym6S9Py/7iywBiluim
         k0yPzv1kUkk9BF2HZSIEQOMb0g+Bh6lx4MLKXSmmun32DWUwDxcC5W1uIf/zzJic8iAR
         D3WmvCG6ytT57eXG5xrGV7Ozt7AAlfd+XDwBXZgxjH05jN6ztSgU1IllBcc6aVBwtYc5
         0m+/tAHfPW4zOiatMRw667iWWfaaGEto+axnjDFkFcCvUf8nNlziHi4Yhq6LJ3jvi74U
         9JXKfMH1oSVA31K/skCoQxcu4FX5iHq8FqQ1Qk9HNJIX2nyfhDY2gflLacqvyjlWzBCA
         eWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wyCwsxV2yEYGkWi0n+lPRJxd+iu5eFK4eP4zuOqenm4=;
        b=EvR1Is9dbk0fK4z+8+LiAO3SOFbyPqvfK2xZeo9agxepqgYcPKukS4mIYrpROYHpUZ
         N3w1m3s4Ru0AiyLbAxGBzgQzHrBR8dsv6YSsGd2y6B3Zfg7m7/8u34C0D9jpjsVc/xaR
         4sAjsutiqgI/WQ9xv+VWbASPMK2tLT2gc/6tQxJ4T4Cu0JLjPavHOr4mvQHckTb4khgN
         eilbfvl2bd8vy8jY5pDSYxwohdzr+L63K24/vc1xNvXe+ngGOmP/mh6hMoef5j3Cbc55
         olkUOa6wgPosAf7QO4sGEVY52ReFODH7DImdE9tIBdIQUFDFhcXWIoKsCrKxR13T+dHM
         Q+rw==
X-Gm-Message-State: AOAM531jDg5NDQNgmjKHB9DRvGj+hs2kcOiT+t4HOhp/gMRzIEuzBcsw
        ZIDLBUkC+JI8ICklJjAqLinEN3QZ0Wxy/g==
X-Google-Smtp-Source: ABdhPJxVbpUN8pwerDfTazsglOFouIyuZR+ers53e6EDS3dFtUvig1GTbnk+q5RRsQTKqqlvdSz8IA==
X-Received: by 2002:ac8:1ba6:: with SMTP id z35mr132442qtj.204.1602017386918;
        Tue, 06 Oct 2020 13:49:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:9c01:5453:d4f7:807d? ([2600:1700:e72:80a0:9c01:5453:d4f7:807d])
        by smtp.gmail.com with UTF8SMTPSA id t2sm3127561qte.47.2020.10.06.13.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2020 13:49:46 -0700 (PDT)
Subject: Re: Git Test Coverage Report (v2.29.0-rc0)
From:   Derrick Stolee <stolee@gmail.com>
To:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
References: <5199d2cf-debc-e6d6-e72d-2fad2b22dd58@gmail.com>
Message-ID: <cfc8a8e9-f812-2cb1-f6d8-57ef585346d1@gmail.com>
Date:   Tue, 6 Oct 2020 16:49:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <5199d2cf-debc-e6d6-e72d-2fad2b22dd58@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/6/2020 4:38 PM, Derrick Stolee wrote:
> brian m. carlson	d7e6b6a8 fast-import: convert internal structs to struct object_id
> brian m. carlson	912c13d5 fast-import: convert to struct object_id
> brian m. carlson	e6a492b7 pack: convert struct pack_idx_entry to struct object_id
> brian m. carlson	28d055bd fast-import: make hash-size independent

These are clear refactors that should not be considered against the
author.

> Derrick Stolee	4ddc79b2 maintenance: add auto condition for commit-graph task

Here, it seems I missed testing "git maintenance run --auto --task=commit-graph".
I will send a patch to correct this sometime this week.

> Han-Wen Nienhuys	4441f427 refs: add GIT_TRACE_REFS debugging mechanism
> refs/debug.c

This file seems rather non-trivial to not be covered. However, if GIT_TRACE_REFS
is only intended for debugging, then perhaps none of this is in a critical code
path that would affect normal users?

> Jeff King	c33ddc2e date: use strbufs in date-formatting functions> Jeff King	d70a9eb6 strvec: rename struct fields
> Jeff King	ef8d7ac4 strvec: convert more callers away from argv_array name
> Jeff King	c972bf4c strvec: convert remaining callers away from argv_array name

This is another giant refactor.

> Jonathan Tan	f08cbf60 index-pack: make quantum of work smaller
> builtin/index-pack.c
> f08cbf60 424) list_for_each_prev(pos, &done_head) {
> f08cbf60 425) struct base_data *b = list_entry(pos, struct base_data, list);
> f08cbf60 426) if (b->retain_data || b == retain)
> f08cbf60 427) continue;
> f08cbf60 428) if (b->data) {
> f08cbf60 429) free_base_data(b);
> f08cbf60 430) if (base_cache_used <= base_cache_limit)
> f08cbf60 431) return;
> f08cbf60 435) list_for_each_prev(pos, &work_head) {
> f08cbf60 436) struct base_data *b = list_entry(pos, struct base_data, list);
> f08cbf60 437) if (b->retain_data || b == retain)
> f08cbf60 438) continue;
> f08cbf60 439) if (b->data) {
> f08cbf60 440) free_base_data(b);
> f08cbf60 441) if (base_cache_used <= base_cache_limit)
> f08cbf60 442) return;
> f08cbf60 925) base_cache_used += c->size;
> f08cbf60 941) base_cache_used += c->size;

This seems to be sufficiently complicated to be worth a test.
What do you think, Jonathan?
 
These are the items that caught my eye.

Thanks,
-Stolee

