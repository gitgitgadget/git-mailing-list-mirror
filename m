Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47F6C4321E
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 15:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbiLBP2f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 10:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbiLBP2c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 10:28:32 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5900B129
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 07:28:31 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x13so2195777ilp.8
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 07:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6l+ZUklyDp4ve5LuCC7PyWpcYeLId1bc3zemCy3GaeI=;
        b=ECfkJNKENqH+eEpn2o+SaVnOSVl9/imophKKTw88FZoKM1v7RSCu/u/ySMebgARI9v
         clSam5Cn2405CF4NTIQgBo/jeSimYsIwQ9WEyJI6J5vtF5nwwQZet/iBYZsgQS8ZQIFB
         12mjKgeTj5yMFUXT71o9ZgL0fV0L0UiHzgBRynI5KJgDf89fba7/Uyf1LMQh6JCbwzVR
         Mu3yzZTA0tqQ7kGu3Se7v/miV3kPyk53C8ji8wXFBwKzkiWIosFTYWAGm3FMKZUVMEzq
         DsAuOXnnUISgdTnuPrYuZHEKB3/1zxoActo7e0qGOImY/5veUGbGTili2l9wpQLiLOo0
         qXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6l+ZUklyDp4ve5LuCC7PyWpcYeLId1bc3zemCy3GaeI=;
        b=DvcwDNDvW+FMlnwY/JhAQN/ptyD5E9nd5HO65kVU85e3kMQKsqbLa6GPwXHYobCWAp
         udg7/fRLhQoF5Okh6qrAbTN+yaSwQfJBFp6qXInhkrhC9EU1SNrvFnRa8OIRHtVL9keg
         Fdz5jr9Qboyg62cOXOnCkWTtmRSyYW4JwmWOmaH43cg4TRSmViwbZUt5D5xLZmqlC6Kc
         rxrwIJcWhKe5Yer9CkCohgwAJgGHA/gy3Ejj/Toyd17cxsxlweoXkvQGCkKxu5jp4SJp
         Usu0nM0YwAZMyc5bqxelWXoFEgpfcfsFdQjbGxJvOZfz+CTg6x0EiInNU2TpxRi5s27x
         40dA==
X-Gm-Message-State: ANoB5pl1Qz3WUyJyrEe0VESJ5n6+1G6xxDlWPXW5OpGUhWqsheWfM5zZ
        3DiPx/CsEp9HkjwfCfCLbhUy
X-Google-Smtp-Source: AA0mqf6xq7c6CmYdBxkKdFUecizwpRcaYhlzxqw9MjJnZllq2ylbLX1hbIfNxY9Woe9Rl8+FQYyvsg==
X-Received: by 2002:a92:b0f:0:b0:303:929:dc8d with SMTP id b15-20020a920b0f000000b003030929dc8dmr14012819ilf.118.1669994910687;
        Fri, 02 Dec 2022 07:28:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:8051:a31f:2c93:87e9? ([2600:1700:e72:80a0:8051:a31f:2c93:87e9])
        by smtp.gmail.com with ESMTPSA id b1-20020a92ce01000000b0030014a5556bsm2487242ilo.69.2022.12.02.07.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:28:30 -0800 (PST)
Message-ID: <c3e1aaea-f509-cc00-b093-f114a15692a3@github.com>
Date:   Fri, 2 Dec 2022 10:28:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 3/9] bundle-uri client: add helper for testing server
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        =?UTF-8?Q?=c3=86var_Arnfj=c3=b6r=c3=b0_Bjarmason_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <c3269a24b5780023cbb4d173cb9cfb10c5a4b0d8.1668628303.git.gitgitgadget@gmail.com>
 <84c07e84-0805-6163-d77b-cb9f42db402e@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <84c07e84-0805-6163-d77b-cb9f42db402e@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/28/2022 7:59 PM, Victoria Dye wrote:
> Ævar Arnfjörð Bjarmason via GitGitGadget wrote:
>> From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
>>  <avarab@gmail.com>
>>
>> Add a 'test-tool bundle-uri ls-remote' command. This is a thin wrapper
>> for issuing protocol v2 "bundle-uri" commands to a server, and to the
>> parsing routines in bundle-uri.c.
>>
>> Since in the "git clone" case we'll have already done the handshake(),
>> but not here, introduce a "got_advertisement" state along with
>> "got_remote_heads". It seems to me that the "got_remote_heads" is
>> badly named in the first place, and the whole logic of eagerly getting
>> ls-refs on handshake() or not could be refactored somewhat, but let's
>> not do that now, and instead just add another self-documenting state
>> variable.
>
> Maybe I'm missing something, but why not just rename 'got_remote_heads' to
> something like 'finished_handshake' rather than adding 'got_advertisement'
> (since, AFAICT, it's always identical in value to 'got_remote_heads').

I think that is a reasonable recommendation.

>> --- a/t/helper/test-bundle-uri.c
>> +++ b/t/helper/test-bundle-uri.c
>> @@ -88,6 +132,8 @@ int cmd__bundle_uri(int argc, const char **argv)
>>  		return cmd__bundle_uri_parse(argc - 1, argv + 1, KEY_VALUE_PAIRS);
>>  	if (!strcmp(argv[1], "parse-config"))
>>  		return cmd__bundle_uri_parse(argc - 1, argv + 1, CONFIG_FILE);
>> +	if (!strcmp(argv[1], "ls-remote"))
>> +		return cmd_ls_remote(argc - 1, argv + 1);
>
> With this helper being added, I'm not sure if/why 'clone' was needed to test
> the bundle URIs in patch 2 (I assumed integrating with a command was the
> only way to test it, which is why I didn't mention this in my review [1]).
> In the spirit of having commits avoid "doing more than one thing" could
> these patches be reorganized into something like:
>
> 1. Add the no-op client & some basic tests around fetching the bundle URI
>    list using this test helper.
> 2. Add the 'transport_get_remote_bundle_uri()' call to 'clone()' with
>    clone-specific tests.
>
> It probably wouldn't make the patches much shorter, but it would help avoid
> the churn of test changes & changing assumptions around 'quiet' &
> 'got_advertisement' in this patch.

I will think more on this as I get further into your review and figure out
a way to do the error case tests. At minimum, I've split out some things
so they might be easier to rearrange, but the 'git clone' integration is
(currently) still paired with the implementation in transport.c.

>>  test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
>>  	git init "$T5730_PARENT" &&
>>  	test_commit -C "$T5730_PARENT" one &&
>> -	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true
>> +	git -C "$T5730_PARENT" config uploadpack.advertiseBundleURIs true &&
>> +	git -C "$T5730_PARENT" config bundle.version 1 &&
>> +	git -C "$T5730_PARENT" config bundle.mode all
>
> Why are these config settings added here? I don't see them used anywhere?

This can be delayed until the next change that actually reads that config.

>> diff --git a/transport.c b/transport.c
>> index a020adc1f56..86460f5be28 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -371,6 +373,33 @@ static int get_bundle_uri(struct transport *transport)
>>  		init_bundle_list(transport->bundles);
>>  	}
>>
>> +	if (!data->got_advertisement) {
>> +		struct ref *refs;
>> +		struct git_transport_data *data = transport->data;
>> +		enum protocol_version version;
>> +
>> +		refs = handshake(transport, 0, NULL, 0);
>> +		version = data->version;
>> +
>> +		switch (version) {
>> +		case protocol_v2:
>> +			assert(!refs);
>> +			break;
>> +		case protocol_v0:
>> +		case protocol_v1:
>> +		case protocol_unknown_version:
>> +			assert(refs);
>> +			break;
>
> Why were these 'refs' assertions added? What are they intended to validate?

You're right. This is essentially inserting test code into the product
(although the assert()s would be compiled out, I assume). The only differnce
here is that after the handshake, protocol v2 has not executed the 'ls-refs'
command, while the other protocol versions start with a ref advertisement
in the initial response.

Thanks,
-Stolee
