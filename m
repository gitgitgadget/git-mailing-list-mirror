Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391AFC32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 18:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbiHWSPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbiHWSOl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 14:14:41 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D2A10361A
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:29:07 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id l5so6140347qvs.13
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Fadm7qOdmEkUV2iZ7wuvtTGKVZmV2gRcf+KkeB9DQ8c=;
        b=JnCHtzx/6vw+Hg7dhyh0aBjb/JVv2Xra3Ew7zC+i/mfCR2f1GrkgL4naTEkqrmbEKx
         EhWDu24OzibhpuplfCcem5/CE2DrDbCOJkVImeHBZhEA6BjN91ycTX052PbSOnU+AhEt
         HRWvvHFulHkWY8RzUyKDw07iFuohaKtZk8tY8Rs3foxLu6hRkVU7oMIPTMabVV6uNUui
         C8SGwgcCjCiGysP3Nw6iK94VS6ijovPmXPsexKgywVmtBGSWFDum7/wnZM5Pe+0qzzF8
         c1JKBlrjGYEw5y9ojEdUpkVuwrCkrrl4AdRvF9TYS8DKf1HupXHPGu6dSdSDHqU0wUDg
         SVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Fadm7qOdmEkUV2iZ7wuvtTGKVZmV2gRcf+KkeB9DQ8c=;
        b=S/rlspveE7L+gWM+adyWzqfjjPW554wqYfqQhmfa4cY1xlcn6j0pRdYVJSXCPpCL9O
         xUeLq7vHnGAHmz86/2O0nNHpz+R7UXG38aL7C2u7VGaAOQr/ERmnn4SXzBgwiO9YjDhV
         VbCmd2Vq8PO3qdPTpRqOrWikZFV9B93IqvJqzYmMg/PEcpnqjg81R8Zc+yIX3gP2mVnC
         tmwC2LUCkYTAxmvXBXjY4hyadG50MWZoez+yHYbQ45OWf8rAMi5d8msW00UBeV6xtooH
         1pTRikCt4k6WqULaE7mlaQrdbN6ETVIWUDbPdkV1SIVcVY8oJHrr+3gPoyQZaJPE7o4S
         BdLg==
X-Gm-Message-State: ACgBeo0T14RW6oPLLF6mTlyACtHJepFhOVd/KsbGcoic9F2jLpEDxhnX
        Ufu0iEGEjRAGokNZImYXJa9g
X-Google-Smtp-Source: AA6agR65zRqrVyC7hVYUv2iQZ0AztVPzVuBWEKlq9c3rj4FRZDAqJupYUJ3KJi4XsZZaiftL7EaG5Q==
X-Received: by 2002:ad4:5f4d:0:b0:496:cc1c:28f8 with SMTP id p13-20020ad45f4d000000b00496cc1c28f8mr14907147qvg.0.1661272146687;
        Tue, 23 Aug 2022 09:29:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a454400b006bbe7ded98csm10170303qkp.112.2022.08.23.09.29.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:29:06 -0700 (PDT)
Message-ID: <e5c1d197-fdee-e03d-42e0-a6aff37e595b@github.com>
Date:   Tue, 23 Aug 2022 12:29:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/7] bundle-uri: create base key-value pair parsing
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com
References: <pull.1333.git.1661181174.gitgitgadget@gmail.com>
 <7e4e4656e530395d055abac2a59e93866c9a0de2.1661181174.git.gitgitgadget@gmail.com>
 <xmqqzgfwcf79.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqzgfwcf79.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 2:20 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index e376d547ce0..4280af6992e 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -387,6 +387,8 @@ include::config/branch.txt[]
>>  
>>  include::config/browser.txt[]
>>  
>> +include::config/bundle.txt[]
>> +
> 
> The file that records a list of bundles may borrow the format of git
> config files, but will we store their contents in configuration
> files in the receiving (or originating) repository?  With the
> presence of fields like "bundle.version", I somehow doubt it.
> 
> Should "git config --help" list them?

I suppose that at this point, they should be left out, since
writing them to your Git config does nothing.

In the future, having these config values present will advertise
the bundle list during the 'bundle-uri' protocol v2 command. That
could use some clarification in the documentation, too, perhaps
with a "bundle.*" item discussing how all of the other items are
related to that advertisement.

>> +/**
>> + * Given a key-value pair, update the state of the given bundle list.
>> + * Returns 0 if the key-value pair is understood. Returns 1 if the key
>> + * is not understood or the value is malformed.
> 
> Let's stick to the "error is negative" if we do not have a strong
> reason not to.

Right. Can do.
 
>> + */
>> +MAYBE_UNUSED
>> +static int bundle_list_update(const char *key, const char *value,
>> +			      struct bundle_list *list)
>> +{
>> +	const char *pkey, *dot;
>> +	struct strbuf id = STRBUF_INIT;
>> +	struct remote_bundle_info lookup = REMOTE_BUNDLE_INFO_INIT;
>> +	struct remote_bundle_info *bundle;
>> +
>> +	if (!skip_prefix(key, "bundle.", &pkey))
>> +		return 1;
>> +	dot = strchr(pkey, '.');
>> +	if (!dot) {
>> +		if (!strcmp(pkey, "version")) {
>> +			int version = atoi(value);
> 
> Can atoi() safely fail?  Are we happy of pkey that says "1A" and we
> parse it as "1"?
> 
>> +			if (version != 1)
>> +				return 1;
>> +
>> +			list->version = version;
>> +			return 0;
>> +		}
> 
> Is it OK for a bundle list described in the config-file format to
> have "bundle.version" twice, giving different values?  It feels
> counter-intuitive to apply the "last one wins" rule that is usual
> for configuration files.

...
> This explicitly implements "the last one wins".  Would it really
> make sense for a server to serve a bundle list that says redundant
> and wasteful pieces of information, i.e.
> 
>     [bundle "1"]
> 	url = one
> 	url = two
> 
> It is not like doing so would allow us to reuse an otherwise mostly
> good file by appending new information and that would be a performance
> or storage win.  So I am not quite sure why we want "the last one wins"
> rule here.  It instead looks like something we want to sanity check
> and complain about.

I could switch this to "expect at most one value" and add warnings for
duplicate keys. Should duplicate keys then mean "the bundle list is
malformed, abort downloading bundles"? That seems reasonable to me.

Thanks,
-Stolee
