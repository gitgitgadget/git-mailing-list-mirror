Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE7E1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 13:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeDKNYN (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 09:24:13 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:34044 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753302AbeDKNYK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 09:24:10 -0400
Received: by mail-pl0-f41.google.com with SMTP id y12-v6so1407189plt.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 06:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/8olNCouLox3ABJNJ0pezJOJwjncjFHWMSwY4GiGKcg=;
        b=D2i2OynHY/4H5Jiz5lgJGp4Bk/wLmmynfVyOER2tfKU4DwFZWkarPlJ6SkZdf4p6vT
         BBuC/PievLQCcy+/etSlqoKckv+TF78qdYxFeiSBdpiQjXM1TIrq9wG/m5sXUakT2oJG
         Hjggw2c80xt+bIq1C9KqEGu3tY91GulwHDFW4GiVUf9Jt44zBSOfGSci3tIbXrgRqMaD
         QELfCqUDi1ft9MTdC75nve7r9djLCLkq42L4Gk5TCJio1JgBHbxnJjNjlKGE56i1nuvo
         XoC2zxUxxWUe7S+8pdAqi5ZsWecwshsHDi/hgzq0p5y0tlODbiRqeJv+znEmnwh0UTTc
         FfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/8olNCouLox3ABJNJ0pezJOJwjncjFHWMSwY4GiGKcg=;
        b=ZXP+adClb9ECqhPMRs+PieahOC6yRatWdXWfZcG30q7VtfN/XJhAtIV/kFciv15PTd
         hESdOu9cCeORzYKyggOCZMOcC7y3yuY9lHsQRnlCX9hwwfAZ86bTo5JGUFndf+zBVaoO
         MrJl0O1tMKExf9Tui7qBU5PaC3Cjj9P6neToWZZzNcNojHVEPYGojoj7JCyzt/pSocA2
         Ti45r/SIB6peOzu/euTBWzsd/x+7MmnjXjS7PpqFL+o8dJ9b2M/lp6Ieg2RoOA2e7EPW
         yVEfUuwq8414VtR9lpg4zNC8Okm7dcVgqiwmhjG897re6w0lTPbkpq4MMbT8cpIxLjGL
         nU4A==
X-Gm-Message-State: ALQs6tCEnE8CKGv3iZ7BJGKxGogqJUHhXCgSHiVOK7aLpqQ7Vq0uG50+
        PrL6+e+EgKi0dyohhD+21PQ=
X-Google-Smtp-Source: AIpwx48wBeAybTQ585nxwdTIvJbnvTFvuV64I7e7WRuoyqgb1ASbPbYKmYp5ZEHqEt5sBi+2KOAZOA==
X-Received: by 2002:a17:902:6b86:: with SMTP id p6-v6mr5001873plk.32.1523453049292;
        Wed, 11 Apr 2018 06:24:09 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d199sm3224516pfd.95.2018.04.11.06.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Apr 2018 06:24:08 -0700 (PDT)
Subject: Re: [PATCH v2 06/10] commit.c: use generation to halt paint walk
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "sbeller@google.com" <sbeller@google.com>,
        "larsxschneider@gmail.com" <larsxschneider@gmail.com>,
        "bmwill@google.com" <bmwill@google.com>
References: <20180403165143.80661-1-dstolee@microsoft.com>
 <20180409164131.37312-1-dstolee@microsoft.com>
 <20180409164131.37312-7-dstolee@microsoft.com>
 <xmqq604yzbqe.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <cc58d8c1-f8de-4841-934f-56e4ad7729aa@gmail.com>
Date:   Wed, 11 Apr 2018 09:24:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq604yzbqe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/10/2018 11:02 PM, Junio C Hamano wrote:
> Derrick Stolee <dstolee@microsoft.com> writes:
>
>> @@ -800,17 +810,26 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>>   		return result;
>>   	}
>>   	prio_queue_put(&queue, one);
>> +	if (one->generation < min_nonstale_gen)
>> +		min_nonstale_gen = one->generation;
>>   
>>   	for (i = 0; i < n; i++) {
>>   		twos[i]->object.flags |= PARENT2;
>>   		prio_queue_put(&queue, twos[i]);
>> +		if (twos[i]->generation < min_nonstale_gen)
>> +			min_nonstale_gen = twos[i]->generation;
>>   	}
>>   
>> -	while (queue_has_nonstale(&queue)) {
>> +	while (queue_has_nonstale(&queue, min_nonstale_gen)) {
>>   		struct commit *commit = prio_queue_get(&queue);
>>   		struct commit_list *parents;
>>   		int flags;
>>   
>> +		if (commit->generation > last_gen)
>> +			BUG("bad generation skip");
>> +
>> +		last_gen = commit->generation;
>> +
>>   		flags = commit->object.flags & (PARENT1 | PARENT2 | STALE);
>>   		if (flags == (PARENT1 | PARENT2)) {
>>   			if (!(commit->object.flags & RESULT)) {
>> @@ -830,6 +849,10 @@ static struct commit_list *paint_down_to_common(struct commit *one, int n, struc
>>   				return NULL;
>>   			p->object.flags |= flags;
> Hmph.  Can a commit that used to be not stale (and contributed to
> the current value of min_nonstale_gen) become stale here by getting
> visited twice, invalidating the value in min_nonstale_gen?

min_nonstale_gen can be "wrong" in the way you say, but fits the 
definition from the commit message:

"To properly take advantage of this condition, track the minimum 
generation number of a commit that **enters the queue** with nonstale 
status." (Emphasis added)

You make an excellent point about how this can be problematic. I was 
confused by the lack of clear performance benefits here, but I think 
that whatever benefits making queue_has_nonstale() be O(1) were removed 
by walking more commits than necessary.

Consider the following commit graph, where M is a parent of both A and 
B, S is a parent of M and B, and there is a large set of commits 
reachable from M with generation number larger than gen(S).

A    B
| __/|
|/   |
M    |
|\   |
. |  |
. |  |
. |_/
|/
S

Between A and B, the true merge base is M. Anything reachable from M is 
marked as stale. When S is added to the queue, it is only reachable from 
B, so it is non-stale. However, it is marked stale after M is walked. 
The old code would detect this as a termination condition, but the new 
code would not.

I think this data shape is actually common (not exactly, as it may be 
that some ancestor of M provides a second path to S) especially in the 
world of pull requests and users merging master into their topic branches.

I'll remove this commit in the next version, but use the new prototype 
for queue_has_nonstale() in "commit: add short-circuit to 
paint_down_to_common()" using the given 'min_generation' instead of 
'min_nonstale_gen'.

Thanks,
-Stolee
