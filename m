Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EBCC76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 21:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjDFVa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDFVa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 17:30:26 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02A5659A
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 14:30:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id 11so4501393ejw.0
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 14:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816623; x=1683408623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k/Scxv9TONGKONfrK8uOh60GXhEVX/mGkntzywKRVu8=;
        b=OzsP73PeeECTxDAC3SESO80Sai6EB7oakGMtLF6liGcoZv2fQKtrTTotpMkAgxnT4B
         Kv6BlV1mDQkUO1X4nK+63fmfGE21Y4LUWMY0NrKdrJM2re1lAcPxEAyU8hp5hQBdaof4
         NxTIQlEy7JMBvscqCOJ4Fm7imIACr3OpMW0fzuSN3+AXBdvL6+2u5C4xAjFP7yauKi8k
         5NfY3suJgU7RroyvBygB+j1YQLFsxrv0JU5islg9dsDeJIhjIYh9uxstBssauae1xT8t
         Y1oxmsoq9DkvWngNRkCTpmiFzLHQNhjwaqSpOwrbW8PbELo0MINmC6LEyOHi79IbzNx+
         LMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816623; x=1683408623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/Scxv9TONGKONfrK8uOh60GXhEVX/mGkntzywKRVu8=;
        b=4FjhA3NRiV2U0pb9T27zN90FPGOCl22BmHUVtK+onFdtbAX+dvcmD/xQFdM05Sit2I
         6Q2ryej4XfvTKpY1stjUp8iIsiG6mnP2Sp8lIKwbZMgw9A0jyi4xed71iBNvFlRrWlyl
         A/dQxpYhqFfsBd3Gtpnq9FGm16udRWPLxPoVhK6S0cOV0BtGASWKZlgqubGUyP9GaA5t
         x3XY/I3Y3t7T6Blqd/CemsAiBxw1mFRbgdxZWAv7FI236LFaJ457U43orrvGKM2jC0uL
         IegtHmiu+3OeQDYbwpk8FxgBLLmH/Ge9blNxwl52Yz591dLroAUpwGcHNOzltmiv84Hz
         VNAA==
X-Gm-Message-State: AAQBX9fJwgr1ZfVNz8kGrOZaCYtVHykRJQUFzYJqaDI0T16US3p2dgdh
        akDy6Pesa88wLV3mLVw3doof1BgACPuH/B4pYHI=
X-Google-Smtp-Source: AKy350ZWtW8fahO2Ta/7rlAy4FsiPsZAKS0KvcksjnCOHedmaQsWycB3ZzTZpCuSZhg63j1KnXiGZg==
X-Received: by 2002:a17:906:70d0:b0:930:7d8f:15a4 with SMTP id g16-20020a17090670d000b009307d8f15a4mr219173ejk.53.1680816623101;
        Thu, 06 Apr 2023 14:30:23 -0700 (PDT)
Received: from [10.6.18.184] ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id dd20-20020a1709069b9400b009475bf82935sm1263367ejc.31.2023.04.06.14.30.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 14:30:22 -0700 (PDT)
Message-ID: <c43e6b71-075a-e39a-7351-8595e145dacf@gmail.com>
Date:   Thu, 6 Apr 2023 23:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 3/6] t1300: don't create unused files
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-4-rybak.a.v@gmail.com>
 <230406.86pm8htnfk.gmgdl@evledraar.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <230406.86pm8htnfk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2023 10:38, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 04 2023, Andrei Rybak wrote:
> 
>> Three tests in t1300-config.sh check that "git config --get" barfs when
>> syntax errors are present in the config file.  The tests redirect
>> standard output and standard error of "git config --get" to files,
>> "actual" and "error" correspondingly.  They assert presence of an error
>> message in file "error".  However, these tests don't use file "actual"
>> for assertions.
>>
>> Don't redirect standard output of "git config --get" to file "actual" in
>> t1300-config.sh to avoid creating unnecessary files.
>>
>> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
>> ---
>>   t/t1300-config.sh | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
>> index d566729d74..8ac4531c1b 100755
>> --- a/t/t1300-config.sh
>> +++ b/t/t1300-config.sh
>> @@ -1575,7 +1575,7 @@ test_expect_success 'barf on syntax error' '
>>   	[section]
>>   	key garbage
>>   	EOF
>> -	test_must_fail git config --get section.key >actual 2>error &&
>> +	test_must_fail git config --get section.key 2>error &&
>>   	test_i18ngrep " line 3 " error
>>   '
>>   
>> @@ -1585,7 +1585,7 @@ test_expect_success 'barf on incomplete section header' '
>>   	[section
>>   	key = value
>>   	EOF
>> -	test_must_fail git config --get section.key >actual 2>error &&
>> +	test_must_fail git config --get section.key 2>error &&
>>   	test_i18ngrep " line 2 " error
>>   '
>>   
>> @@ -1595,7 +1595,7 @@ test_expect_success 'barf on incomplete string' '
>>   	[section]
>>   	key = "value string
>>   	EOF
>> -	test_must_fail git config --get section.key >actual 2>error &&
>> +	test_must_fail git config --get section.key 2>error &&
>>   	test_i18ngrep " line 3 " error
>>   '
> 
> Ditto my comment on 1/6, shouldn't we instead be doing e.g.:
> 	
> 	diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> 	index 2575279ab84..df2070c2f09 100755
> 	--- a/t/t1300-config.sh
> 	+++ b/t/t1300-config.sh
> 	@@ -1575,7 +1575,8 @@ test_expect_success 'barf on syntax error' '
> 	 	[section]
> 	 	key garbage
> 	 	EOF
> 	-	test_must_fail git config --get section.key >actual 2>error &&
> 	+	test_must_fail git config --get section.key >out 2>error &&
> 	+	test_must_be_empty out &&
> 	 	test_i18ngrep " line 3 " error
> 	 '
> 	
> I.e. before this we had no coverage on the error being the only output,
> but seemingly by mistake. Let's just assert that, rather than dropping
> the redirection entirely, no?

Here, failing invocations of "git config" are tested, and an argument,
as Junio C Hamano outlined in https://lore.kernel.org/git/xmqqsfe8s56p.fsf@gitster.g/
for output of failing "git mktree", could be applied here.

Thinking about it more, such assertions enforcing empty standard output for
these commands might be helpful if some tools and/or scripts rely on empty
standard output instead of checking the exit code.  Hyrum's Law applies here,
I guess.
