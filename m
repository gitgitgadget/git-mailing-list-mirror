Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEEE1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 18:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDDSxt (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 14:53:49 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:42692 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeDDSxs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 14:53:48 -0400
Received: by mail-qt0-f181.google.com with SMTP id j3so24238016qtn.9
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Tf4yr4qJemjPNE/ASc+AZsHvfb1E22N10smCqYwX5UQ=;
        b=XvBzkPAuu1CF+0oqFghuVWUl+mzvl8SV2SKIseYc6fg73gvoIQDkNOddc5X7wASKn5
         seSZV3wWIt+AimzqlrtT0X8Pf2qictxL7fbam+nYW8FS0XpBjvVnpnj7bC79PJ4dInEY
         SNu51BpNwjOSihJPzoD/S0LnJNJbMAt8J4eP6Eof86yxaviM8yoZPi6J3lq2r/SagmSH
         HmNsYUsANlqR6rLJU9c1+CzMIwpAfLdm455WKxQ27rkyVeqWTyOBPxxqKGfXcQ5QlNC1
         71XFHqYYVx1w+ZKFKzbs4oOq2fc1g09bu9oZWfcj5gVoyHXqhup3xvUi21W7QLwqDCDr
         4mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Tf4yr4qJemjPNE/ASc+AZsHvfb1E22N10smCqYwX5UQ=;
        b=m9eYYuB2I+OMa5nxGhvQXM5byWnMIelCc8MZV+1sfaE9oCH5HwsHQVC/ZAaiqhM+p0
         AmLQYJinAFSW31PF3FVJLG48Ka4qfskPlvCP6Md0kSCMqDbSaaKRo66MoGeBUTsLJ3Bo
         848fIOC4ZSaVS/az/a1mkNC7q5ajeBLWagwHQ/QBAaa/3vE8jmrbpQxGOGJFXO7Vswnt
         KGZFNfarTySGESfiwvTfV9SUR036C7qFDt4pswXhyemV9uillwML6j91SKKKX1hhYosG
         RF6hgLDQMYxTNL+sPeo4OlWoiD5QWZRB5mpExJEwKhaD+QV5fKss98qi7YZ2ukyDId5E
         +20g==
X-Gm-Message-State: ALQs6tDR/Zeo3Vz2O9daQ/x/M6AmhTOUhBJwNx2mmsLQcZPkCtHpkZ0R
        sMRsV5JrBuWhtnK96FVjSEY=
X-Google-Smtp-Source: AIpwx49gZsVZNTF1Kz6+h/A4pIUHRF11W9skF0f5kKzkZKLy22NUE0Ki7Ep1kzsAa146P11QeXvwpQ==
X-Received: by 10.237.57.65 with SMTP id l59mr27695698qte.198.1522868027165;
        Wed, 04 Apr 2018 11:53:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id g12sm4930655qtg.29.2018.04.04.11.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 11:53:46 -0700 (PDT)
Subject: Re: [PATCH 8/6] commit: use generation numbers for in_merge_bases()
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        avarab@gmail.com, sbeller@gmail.com, larsxschneider@gmail.com,
        bmwill@google.com
References: <20180403190500.GA10930@sigill.intra.peff.net>
 <20180404154554.140716-1-dstolee@microsoft.com>
 <20180404154554.140716-2-dstolee@microsoft.com>
 <14e4e1d3-5c77-dc7c-10d5-e9406b992f0e@gmail.com>
 <20180404182432.GB9055@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aa28c3e5-7645-ffe0-78a3-e3cbd2ea8cec@gmail.com>
Date:   Wed, 4 Apr 2018 14:53:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180404182432.GB9055@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/4/2018 2:24 PM, Jeff King wrote:
> On Wed, Apr 04, 2018 at 11:48:42AM -0400, Derrick Stolee wrote:
>
>>> diff --git a/commit.c b/commit.c
>>> index 858f4fdbc9..2566cba79f 100644
>>> --- a/commit.c
>>> +++ b/commit.c
>>> @@ -1059,12 +1059,19 @@ int in_merge_bases_many(struct commit *commit, int nr_reference, struct commit *
>>>    {
>>>    	struct commit_list *bases;
>>>    	int ret = 0, i;
>>> +	uint32_t min_generation = GENERATION_NUMBER_UNDEF;
>>>    	if (parse_commit(commit))
>>>    		return ret;
>>> -	for (i = 0; i < nr_reference; i++)
>>> +	for (i = 0; i < nr_reference; i++) {
>>>    		if (parse_commit(reference[i]))
>>>    			return ret;
>>> +		if (min_generation > reference[i]->generation)
>>> +			min_generation = reference[i]->generation;
>>> +	}
>>> +
>>> +	if (commit->generation > min_generation)
>>> +		return 0;
>>>    	bases = paint_down_to_common(commit, nr_reference, reference);
>>>    	if (commit->object.flags & PARENT2)
>> This patch may suffice to speed up 'git branch --contains' instead of
>> needing to always use the 'git tag --contains' algorithm as considered in
>> [1].

I guess I want to specify: the only reason to NOT switch to the tags 
algorithm is because it _may_ hurt existing cases in certain data shapes...

> I'd have to do some timings, but I suspect we may want to switch to the
> "tag --contains" algorithm anyway. This still does N independent
> merge-base operations, one per ref. So with enough refs, you're still
> better off throwing it all into one big traversal.

...and I suppose your timings are to find out if there are data shapes 
where the branch algorithm is faster. Perhaps that is impossible now 
that we have the generation number cutoff for the tag algorithm.

Since the branch algorithm checks generation numbers before triggering 
pain_down_to_common(), we will do N independent merge-base calculations, 
where N is the number of branches with large enough generation numbers 
(which is why my test does so well: most are below the target generation 
number). This doesn't help at all if none of the refs are in the graph.

The other thing to do is add a minimum generation for the walk in 
paint_down_to_common() so even if commit->generation <= min_generation 
we still only walk down to commit->generation instead of all merge 
bases. This is something we could change in a later patch.

Patches 7 and 8 seem to me like simple changes with no downside UNLESS 
we are deciding instead to delete the code I'm changing.

Thanks,
-Stolee
