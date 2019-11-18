Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005361F4B5
	for <e@80x24.org>; Mon, 18 Nov 2019 15:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKRPrA (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Nov 2019 10:47:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36419 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfKRPq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Nov 2019 10:46:59 -0500
Received: by mail-qk1-f194.google.com with SMTP id d13so14807367qko.3
        for <git@vger.kernel.org>; Mon, 18 Nov 2019 07:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VsCDGcRgkLfZ8LnRVqk026qPYm2FP9v1fGG+zZ/KFSI=;
        b=fP76RZKM85EbTzTJ2AVbkcs2XgEQnuvjKY9HLDsl6XoEFgzpcGulcYyZP5hpiGivoW
         TCYJsg/gf/T1pnFR3T6osaM4ZVCKCjbshiGVPRM6mlMz/uEweMdzqP+p865P5ZlBZGEB
         Kopxia91vpaRCbkPCInHUMmWCweCCY6HP+a+d81kK+Ymk42nEEBhe8URwa0ZFhpCsDfc
         W3vpaTm1pSaAofOTw28h5AgYNxVngjem6Ki5pgqLm/CwwjEsOMqii6Vwn1r1n5/Ddt6c
         yZBVKCMCTJ9SHG2D0tTPOcg4jUh5UHlTkSF7PR9gc2FqIwUnn03za9op+nT7jZpO5ew+
         CpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VsCDGcRgkLfZ8LnRVqk026qPYm2FP9v1fGG+zZ/KFSI=;
        b=H6IFzj3fVByhSC8E4ghhEFgSHKZBueKqDeI6tqtTa/FA3KjBmN26iVe3/HtZ+/tPU3
         Z/YSzZ/3pHs0BLEwN1Cyb3LU7tOZW5/S47REcV4XgrTxCj2LqiBFC6fJein550rFHUYx
         18H6ZFLoLdbMtA03gQfC1KuYXJIt4ELkIU0hphr4JxgESl5R/x33ou2gvrAPOufLdaSw
         sCdrV7jAO/jiHPkTfv5Mjr0JOuiWW/X9ISPlOVFr1nV/YPPq6RqTogeE+M/BZ13S/Osn
         nM0APO2dFCxu4rIbzfxuXYLGi0Fxya+dgBF/CNG4cyR+y79KPGRMRlmQnI7il716i0ix
         8GMw==
X-Gm-Message-State: APjAAAXzXXsZfMH7JddrL7CrrQDOT9+gTmWyiG2haTMuzq3z9ZBEEZFU
        qWgh2pl42QatWhvEZgNjvkY=
X-Google-Smtp-Source: APXvYqzclQ11HglSkrEIEfWGZ1Dzoh9nPz1qRxFoP005jWIei98UWczT53ii7CLiNMplb77LuD0ZOA==
X-Received: by 2002:a37:41d2:: with SMTP id o201mr26229324qka.100.1574092018360;
        Mon, 18 Nov 2019 07:46:58 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:9037:1fcc:32e4:493e? ([2001:4898:a800:1012:416b:1fcc:32e4:493e])
        by smtp.gmail.com with ESMTPSA id y7sm8517338qto.84.2019.11.18.07.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:46:57 -0800 (PST)
Subject: Re: [PATCH v3 1/1] fetch: add trace2 instrumentation
To:     Junio C Hamano <gitster@pobox.com>,
        Erik Chen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Erik Chen <erikchen@chromium.org>
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
 <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
 <364c526a5d674e3f137578b24143678256601d08.1573069152.git.gitgitgadget@gmail.com>
 <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <944c956e-dd9a-1a12-5cb1-0c263ee7d5bd@gmail.com>
Date:   Mon, 18 Nov 2019 10:46:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <xmqq5zjws12y.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/7/2019 12:32 AM, Junio C Hamano wrote:
> "Erik Chen via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Erik Chen <erikchen@chromium.org>
>>
>> Add trace2 regions to fetch-pack.c to better track time spent in the various
>> phases of a fetch:
>>
>>     * matching common remote and local refs
>>     * marking local refs as complete (part of the matching process)
>>
>> Both of these stages can be slow for repositories with many refs.
>>
>> Signed-off-by: Erik Chen <erikchen@chromium.org>
>> ---
>>  fetch-pack.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
> 
> OK.
> 
>> diff --git a/fetch-pack.c b/fetch-pack.c
>> index 0130b44112..5e3eee0477 100644
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -669,6 +669,8 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>>  
>>  	save_commit_buffer = 0;
>>  
>> +	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL);
>> +
>>  	for (ref = *refs; ref; ref = ref->next) {
>>  		struct object *o;
>>  
>> @@ -690,6 +692,10 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>>  		}
>>  	}
>>  
>> +	/* This block marks all local refs as COMPLETE, and then recursively marks all
>> +	 * parents of those refs as COMPLETE.
>> +	 */
> 
>         /*
>          * We write our multi-line comments like this, with the
>          * slash-asterisk at the beginning and the asterisk-slash
>          * at the end on its own line.  Learn such local conventions
>          * from the existing surrounding code and imitate, which
>          * would reduce stylistic errors.
>          */
> 
> Will fix-up while queuing (no need to reroll only to fix this).
> 
>> +	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
>>  	if (!args->deepen) {
>>  		for_each_ref(mark_complete_oid, NULL);
>>  		for_each_cached_alternate(NULL, mark_alternate_complete);
>> @@ -697,6 +703,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>>  		if (cutoff)
>>  			mark_recent_complete_commits(args, cutoff);
>>  	}
>> +	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
>>  
>>  	/*
>>  	 * Mark all complete remote refs as common refs.
>> @@ -716,6 +723,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
>>  	}
>>  
>>  	save_commit_buffer = old_save_commit_buffer;
>> +	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL);
> 
> 
> So this introduces a single region around the entire function body
> of mark_complete_and_common_ref(), within which only one subpart is
> also enclosed in a nested region.  Is that because the parts inside
> the outer region before and after the inner region are known to
> consume negligible time?  IOW I would understand
> 
>         F () {
>                 <region 1 begin>
>                     <region 1.1 begin>
>                         code
>                     <region 1.1 end>
>                     <region 1.2 begin>
>                         code
>                     <region 1.2 end>
>                     <region 1.3 begin>
>                         code
>                     <region 1.3 end>
>                 <region 1 end>
>         }
> 
> or
> 
>         F () {
>                         trivial code
>                 <region 1 begin>
>                         heavy code
>                 <region 1 end>
>                         trivial code
>         }
> 
> but this appears to do
> 
> 
>         F () {
>                 <region 1 begin>
>                         code
>                     <region 1.1 begin>
>                         code
>                     <region 1.1 end>
>                         code
>                 <region 1 end>
>         }
> 
> which is somewhat puzzling.

I notice that a v4 was sent that adds more sub-regions without actually
responding to this request. (It is worth also pointing out that you
ignored Junio's request you use the cover letter to explain your reasoning
for changes between versions.)

There is a real downside to nesting regions like this. Specifically, we
frequently limit the depth that we report nested regions to avoid
overwhelming the logs.

In general, these sub-regions should be avoided when possible and instead
create regions around important sections, such as the second option Junio
lists above.

Thanks,
-Stolee
