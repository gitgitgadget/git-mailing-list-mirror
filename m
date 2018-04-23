Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F1A1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755327AbeDWObX (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 10:31:23 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:46746 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755207AbeDWObV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 10:31:21 -0400
Received: by mail-qt0-f173.google.com with SMTP id h4-v6so17839841qtn.13
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fSYNUJo0nZlapnvtWUou0QNpd0mY5kZcKkdxKeXDvTM=;
        b=Acpa4IBp+ck1Cy0b6SdXbmHNPZucSOXaO+ALwfm1tmy+onk34TWXmTfV4bllirI8Be
         XsGQiPmwcKhefjTlzxdb68Bylwl5q80DpvsAxaljzeSaiM4eeubSUYWswTb98C2AzRv1
         bl4HgvKqGB1t5qZ6g00cX81YG2F9EGFB+1CZ0uvnx2hahCLIsLvVf4SlnGfAqZzWyARN
         SQmFKTwd0IEZVe48UoLMDKDKq4lE+ns9YlK1MbDeNByXGeJ+6FntLTS6ZJXL3n6Hbh9L
         V0YHfwkKTU3MjCwx0Dx7W8e2QJ+AKC+jq9Oqanp53yLvk7tCTluWREnlyg7482fezhXa
         07pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fSYNUJo0nZlapnvtWUou0QNpd0mY5kZcKkdxKeXDvTM=;
        b=D4c+OP6BUSicO7RHLIYm+cEP0EGWgY1ILMRYy0q8Z47rqpNSlyBJ/3HaPOzoBOiLfi
         0jeHT9NgPhudTMwcZJydKIxqxPD619/RgkQQI8ffHFuGtR5UVrecb9cXuDkbRz7Nq9eu
         8KqqALbE6z4HUO0+ONxvHKTG/qEhBSSTkaC+1aeL4cyNNBly1SR8PSjWd3pIbe7HAGG5
         Ceb8IwbuKOTLnyrUms+Yu2Z8ux434zZyXziFJi95Tl2IHSyJbeE8GRi3Il+NeLjHE4zt
         0+8Q33b+Kdj41Pz5JeaOHUghHGgTVC5qkxFmiT+Y4rJZF09nZnatU7ALMqMTTbpn/L3c
         kwew==
X-Gm-Message-State: ALQs6tDkColofVVeREuzYfcidDzOBh8t9kZO5YWbLB1Sd98q5BkP4X2D
        YzlOZQQVWENZDbO7PHTUvn0=
X-Google-Smtp-Source: AIpwx4+3SLBsVo4eicLhLdOTZc5Vkg58LULsPtjLerp7XrEPgJxsPRFPeObxGDJpKaBv2l0qk9CE4w==
X-Received: by 2002:aed:3e19:: with SMTP id l25-v6mr23365278qtf.143.1524493880865;
        Mon, 23 Apr 2018 07:31:20 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id z55-v6sm11461228qth.11.2018.04.23.07.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 07:31:19 -0700 (PDT)
Subject: Re: [PATCH v3 6/9] commit: use generation numbers for
 in_merge_bases()
To:     Jakub Narebski <jnareb@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "sunshine@sunshineco.com" <sunshine@sunshineco.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180409164131.37312-1-dstolee@microsoft.com>
 <20180417170001.138464-1-dstolee@microsoft.com>
 <20180417170001.138464-7-dstolee@microsoft.com> <86k1t4go0l.fsf@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <258ad61b-c262-5144-12e7-5068851e34d4@gmail.com>
Date:   Mon, 23 Apr 2018 10:31:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <86k1t4go0l.fsf@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2018 6:15 PM, Jakub Narebski wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> The containment algorithm for 'git branch --contains' is different
>> from that for 'git tag --contains' in that it uses is_descendant_of()
>> instead of contains_tag_algo(). The expensive portion of the branch
>> algorithm is computing merge bases.
>>
>> When a commit-graph file exists with generation numbers computed,
>> we can avoid this merge-base calculation when the target commit has
>> a larger generation number than the target commits.
> You have "target" twice in above paragraph; one of those should probably
> be something else.

Thanks. Second "target" should be "initial".

> [...]
>> +
>> +	if (commit->generation > min_generation)
>> +		return 0;
> Why not use "return ret;" instead of "return 0;", like the rest of the
> code [cryptically] does, that is:
>
>    +	if (commit->generation > min_generation)
>    +		return ret;

Sure.

Thanks,
-Stolee
