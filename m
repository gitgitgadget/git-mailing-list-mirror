Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE09C433DF
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545C9205CB
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 20:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8kWVcB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgHNUgp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNUgp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 16:36:45 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB06AC061385
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:36:44 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so4934068qvw.1
        for <git@vger.kernel.org>; Fri, 14 Aug 2020 13:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mT/bvr0r9DTiWdI/4wrg/Gc8MH0jG9RJAP/vmzl0HVQ=;
        b=C8kWVcB4l16k1Vs2kp/Qv20Ykf+h+4MzrlVweX8kbgNUVHWOSDGUrHsELRSOE2NI5B
         IGDwTa66ajOnfLGSK62IQt4qD4r/8E+S3sCGMasgMt8Aj5R2MqykaYYeMZSomE/nKunp
         KH6wJnv2iyOcmMEc8iQlYz5v01U+KqNyLFmZ8WowyeRxt9b7g3qsuGv5BgbedFLyPqPN
         t+1LXyLvSUsTNOBS2Y/tAsY8TUOOmRcpnU+bsfo+r0F+zz27AYeVNJqvKUxL21yMskHw
         VJS+6VdaZqDLZftzf/N3qD+bPNc4M73YyeSZBqV873P6cFbH6nYl03na0yTKaVUujdxI
         HCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mT/bvr0r9DTiWdI/4wrg/Gc8MH0jG9RJAP/vmzl0HVQ=;
        b=VYYnOmBLQEelMBwjO//p+74EnjfH2n97MCZW+mUTieQFLmO5yKt+DLa9rNp54AQBM8
         Wudy2ph4shLbGkzXMyV31iRXe5U8Gf2xV1QcpmhSld9AnRG6zqEUMl9hotFOQbIVMS1f
         3R910VGy6FFtU7RuKpjccoAPwgphh6j0Q53X/CKHtW2IgGUuJW3MOunjChWKdUqM6AhK
         EJUynXcg+N4zvtVdwbDCEFm/6Xt/XD+SnpFqQPjg9wYhFE30UXmCDD9hoG95EspDjEgh
         QcJFX9szwlJJOzmWvx+JGx/WYGOaVoVev+iSTJyWv17Mq59+JuHiNpCONUUnHu6o9crs
         jbLA==
X-Gm-Message-State: AOAM5338ZVe3p/yAFTdkI9B5jcgdOrEoxDU53i0fvhGwdCpsjA8z4WCn
        S7ytwQYH/TaEbBD6voU55uKOPQh2R0deyuZq
X-Google-Smtp-Source: ABdhPJwQcP+PDdMmnZ5GrPpQoY4KI/l3AsGcJbbtw80BUVnwhmc2kpdicBYZxQCzOO8tEVjDQHLzOQ==
X-Received: by 2002:a05:6214:1742:: with SMTP id dc2mr4508180qvb.90.1597437403855;
        Fri, 14 Aug 2020 13:36:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4116:add4:1500:aeb7? ([2600:1700:e72:80a0:4116:add4:1500:aeb7])
        by smtp.gmail.com with ESMTPSA id x24sm11702692qtj.8.2020.08.14.13.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 13:36:43 -0700 (PDT)
Subject: Re: [PATCH 2/3] commit-graph: use the hash version byte
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, martin.agren@gmail.com, me@ttaylorr.com,
        abhishekkumar8222@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
 <4bbfd345d16da4604dd20decda8ecb12372e4223.1597428440.git.gitgitgadget@gmail.com>
 <20200814201153.GK8085@camp.crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7082f3c9-652e-36d9-26ae-d1f86e872480@gmail.com>
Date:   Fri, 14 Aug 2020 16:36:42 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200814201153.GK8085@camp.crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2020 4:11 PM, brian m. carlson wrote:
> On 2020-08-14 at 18:07:19, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/commit-graph.c b/commit-graph.c
>> index e51c91dd5b..d03328d64c 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -179,7 +179,11 @@ static char *get_chain_filename(struct object_directory *odb)
>>  
>>  static uint8_t oid_version(void)
>>  {
>> -	return 1;
>> +	if (the_hash_algo->rawsz == GIT_SHA1_RAWSZ)
>> +		return 1;
>> +	if (the_hash_algo->rawsz == GIT_SHA256_RAWSZ)
>> +		return 2;
>> +	die(_("invalid hash version"));
>>  }
> 
> Can we maybe say something like this?
> 
>   switch (hash_algo_by_ptr(the_hash_algo)) {
>     case GIT_HASH_SHA1:
>       return 1;
>     case GIT_HASH_SHA256:
>       return 2;
>     default:
>       die(_("invalid hash version"));
>   }
> 
> That way if SHA-256 gets broken and we switch to another 256-bit hash
> (SHA-3-256?), we'll be forced to update this properly.
> 
>>  static struct commit_graph *alloc_commit_graph(void)
>> diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
>> index c21cc160f3..906af2799d 100755
>> --- a/t/t4216-log-bloom.sh
>> +++ b/t/t4216-log-bloom.sh
>> @@ -6,6 +6,12 @@ test_description='git log for a path with Bloom filters'
>>  GIT_TEST_COMMIT_GRAPH=0
>>  GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
>>  
>> +OID_VERSION=1
>> +if [ "$GIT_DEFAULT_HASH" = "sha256" ]
>> +then
>> +	OID_VERSION=2
>> +fi
> 
> Can we do something like this in the setup test instead?
> 
>   test_oid_cache <<-EOF
>   oid_version sha1:1
>   oid_version sha256:2
>   EOF
> 
>   OID_VERSION=$(test_oid oid_version)
>   # or, inline
>   $(test_oid oid_version)
> 
> That uses the existing test framework to ensure we produce the right
> results if someone adds another hash algorithm and that we produce a BUG
> if the value is missing.  It will also make it easier to write tests if
> we end up creating SHA-1- or SHA-256-specific tests, since we can look
> up those values directly with test_oid.
> 
> Since you're using this across several tests, you could even just add
> this to t/oid-info/hash-info like so:
> 
>   commit_graph_oid_version sha1:1
>   commit_graph_oid_version sha256:2
> 
> and then it's set in one place and can be used without any required
> test_oid_cache invocations at all.  I think three tests is sufficient
> basis for us to add an entry there.

I appreciate the suggested improvements here. I'm happy to do
something more similar to other places in the code.

These will be part of my v2 to be re-rolled early next week.

Thanks,
-Stolee
