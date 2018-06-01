Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34EE91F51C
	for <e@80x24.org>; Fri,  1 Jun 2018 11:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbeFALqM (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 07:46:12 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:38331 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeFALqL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 07:46:11 -0400
Received: by mail-qk0-f193.google.com with SMTP id y4-v6so1441282qka.5
        for <git@vger.kernel.org>; Fri, 01 Jun 2018 04:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=voK4dN0QzVx8CXJoE4ndUgVOelrL3i0jfstmu+6hPok=;
        b=gw9wX+j6pVLEuOegXwkE+ivLv4TVC/L+0a9tXzqdD0Bjp8ku8eiO6/xYWCwR6Sh/zp
         4rZuCeD6dO2f1cc3yHKIswijhMQP7dlE5sqMGbhbkcKHO2VMJcU5sKDkTFlNTTyhrfb0
         oCOLMgsR/5A4r2r9LnJHvr7SWngzXn53Et0qERdLKKa7BxOlxwd+G1T13wHhstzJKOhg
         HnFKlK22rlzvxhZ+bviqlE2Z2gFuMCqVk0A0LNOLwmsRHhvyOJxwr4G7TGWSXsFRZAAE
         MSwKv5QPGMMytdkSkAytpRXzuFnlkaAec+CXAhO3Wklmn3XdnjxK8qKwP3kaf8wCOUmB
         kPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=voK4dN0QzVx8CXJoE4ndUgVOelrL3i0jfstmu+6hPok=;
        b=KQ1D4clNgnLjfD2Li6XAZ8mNFe/DF+fHFLFUN/AnSsDMJHyPANxh3kMoQ7joHLLHuq
         GRNOKu4M47pI5Yis2ISbaeM30QGxwxKgEV/Mtq1nMeNnvI40A2xeRlisvAC7l2mJGPHO
         ji8pNvQowN0RYd+mxTCJuGSXk7ZUvODzPrLvhg9pLWl+th5XsOExIS4ElQDlM0TM+Iki
         jBu1znprvRE28+bvhExdBqnCwUbuDKdaR9fsJoaxtHyOlxZUMG45cus+nh0Y0DVHLY7I
         EuzOJwcdLWBjdYse4yfsbJcJWQhVejM2BKjP50o0+eMSwkvEg5ReENDtSH0oGULBwHe1
         0+ZA==
X-Gm-Message-State: APt69E3APs7KXN4Ebuwksdnm5zNO6op0pwif3+2bo/ibw+emXF/zymIM
        BY1+9H/JJZJiV7UqQpnL4BA=
X-Google-Smtp-Source: ADUXVKIZxbAmBrCWbxp5CfXg+mIjmS9QCLSKeuwRFHdkkFwLyR0x7Xyl32m/wahgDG5Cv3stnoMwBw==
X-Received: by 2002:a37:28ce:: with SMTP id o75-v6mr9453604qko.90.1527853570249;
        Fri, 01 Jun 2018 04:46:10 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:2cb8:1b85:8d36:d4f1? ([2001:4898:8010:0:15ee:1b85:8d36:d4f1])
        by smtp.gmail.com with ESMTPSA id 129-v6sm10988517qkm.75.2018.06.01.04.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Jun 2018 04:46:09 -0700 (PDT)
Subject: Re: [RFC PATCH 4/6] commit-graph: avoid writing when repo is shallow
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>
References: <20180531174024.124488-1-dstolee@microsoft.com>
 <20180531174024.124488-5-dstolee@microsoft.com>
 <xmqqd0xb9r1k.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <95354da4-7590-4fa6-de83-30f883d77188@gmail.com>
Date:   Fri, 1 Jun 2018 07:46:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqd0xb9r1k.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/31/2018 10:30 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> Shallow clones do not interact well with the commit-graph feature for
>> several reasons. Instead of doing the hard thing to fix those
>> interactions, instead prevent reading or writing a commit-graph file for
>> shallow repositories.
> The latter instead would want to vanish, I would guess.

Do you mean that we should call destroy_commit_graph() if we detect a 
shallow repository during write_commit_graph(), then I can make that change.

>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   commit-graph.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 95af4ed519..80e377b90f 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -208,6 +208,9 @@ static void prepare_commit_graph(void)
>>   		return;
>>   	prepare_commit_graph_run_once = 1;
>>   
>> +	if (is_repository_shallow())
>> +		return;
>> +
>>   	obj_dir = get_object_directory();
>>   	prepare_commit_graph_one(obj_dir);
>>   	prepare_alt_odb();
>> @@ -711,6 +714,15 @@ void write_commit_graph(const char *obj_dir,
>>   	int num_extra_edges;
>>   	struct commit_list *parent;
>>   
>> +	/*
>> +	 * Shallow clones are not supproted, as they create bad
>> +	 * generation skips as they are un-shallowed.
>> +	 */
>> +	if (is_repository_shallow()) {
>> +		warning("writing a commit-graph in a shallow repository is not supported");
>> +		return;
>> +	}
>> +
>>   	oids.nr = 0;
>>   	oids.alloc = approximate_object_count() / 4;

