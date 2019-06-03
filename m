Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E6011F462
	for <e@80x24.org>; Mon,  3 Jun 2019 15:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfFCP04 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 11:26:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33352 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfFCP04 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 11:26:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id x15so1017443pfq.0
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 08:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OmdjoNH9TEofE6NkPYl5K+YTgd0fJSh3EOsIQR8ul4=;
        b=Ih2aI/URWf3olWIlOHN5+O1m5ZwT+WAp/Qpp7WdR5igc95XUvLysThxDSyEBNyzAEV
         6Y/tlH1LH0sIV2pkVtTUvm8xQ8vKG6eyHtkGbfPhuxnIOq4Ulsrlk1O3GQ+VDPz4SYsh
         cSnwlj69L365uYCfXdMvoCmiTzpPn4/MlxYtXYj34ql/6PDQvM0waMaYVJ3UjBr1tOvz
         6Pf/2NnZwUS7UZn2uyfznrb4wSKpMikkNmeN6HDO4Nvx83GjPZYfgAHG8LxfxSv6IkWZ
         2WiSyEspvuNyaEsZnHkuHJOH4mqlQs8xTTyyRE34Z1EZReQhob/+Lmz3xZqaiakE3k9K
         DduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OmdjoNH9TEofE6NkPYl5K+YTgd0fJSh3EOsIQR8ul4=;
        b=llh+p1afRQBQzzsr2ElL8qnEuhRRLbu14ZPADbW2XaZxu6+TMW4Wbpc1eByHoHhgtI
         mb0lOX1wb5VzYZvY54wcXr/1FcVFK6RXLoGmLSK3tcbMHci8Y4khKOou3jNDwsdi9jRG
         +Bb1Y9dnqbKv7Gs+5v2YUEMSE8ysJsjk4d10eSfn5NLLlOysTliPnI+ErXcw5qZaQ/ms
         6d9kGFJRsQChAdtivwV0faO56I9rQURjEI/FfaBhyDN6Js0Iq7u3Z1qKzc2ZyZcglZmW
         c1282F0aElRBJ63ak/ffiRVsNbtzyDCt5RnKLXWvAbgOUHwh1lHgXAnVqcquH5LpJ2aO
         1LXA==
X-Gm-Message-State: APjAAAXlJOesn6L09P4W5VTY+Zyo06dxgPqujGu3sZaPFG8Mts3Niq+b
        SiWClJXJTXMCx+NtdZ+i0hwhxw==
X-Google-Smtp-Source: APXvYqwMfJ9uYFiCZov03/hVw+6HkMIzwtF0s7keb/cj8xQg6l+vdUaMncEDwG+X65zgdO5E/NqFzw==
X-Received: by 2002:a63:1844:: with SMTP id 4mr27242228pgy.402.1559575615008;
        Mon, 03 Jun 2019 08:26:55 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id c127sm23460698pfb.107.2019.06.03.08.26.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 08:26:54 -0700 (PDT)
Subject: Re: [PATCH] blame - fix some issues identified by coverage report.
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <Re: [PATCH v7 7/8] blame: add a fingerprint heuristic to match
 ignored lines> <20190601210925.15339-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <10bbee35-4df1-1a6d-8301-6866c7445e2d@google.com>
Date:   Mon, 3 Jun 2019 11:26:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190601210925.15339-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael -

On 6/1/19 5:09 PM, michael@platin.gs wrote:
> From: Michael Platings <michael@platin.gs>
> 
> Thanks to Derrick Stolee for highlighting missing coverage.
> 
> In the case of "certainties[i] = CERTAINTY_NOT_CALCULATED" this was
> defeating an optimization that preserved results of calculations
> between line-matching passes. This had caused other code to never
> be executed - that code is now executed and only discards calculation
> results that are no longer valid.
> 
> In the case of "max_search_distance_b = 0" this was never executed
> because another statement was added earlier in the function to return
> early in such a case.
> 
> Signed-off-by: Michael Platings <michael@platin.gs>

If it's OK with you, I can squash this into your existing patch in the 
blame-ignore patch set.

Thanks,

Barret
