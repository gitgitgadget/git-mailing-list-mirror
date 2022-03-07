Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65515C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244040AbiCGQPj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244036AbiCGQPg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:15:36 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394BE3D1D8
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:14:42 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id d194so2680575qkg.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 08:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZoiIgqXEWzyqtlTaQ+Ba//J1RZ862dZb+NKa2/0g3sQ=;
        b=QsAMKoPlQow2i7/YHzifqjjc65o0lZb3IY3libeorT7JoQshK0+xHTw/0dxadJSlTq
         RF0yCOQro9u9BHRNZzWGPW9/ZAA+6WbdRZzAoUkp7Bd0q3WRlppFaWJ+41jOOEzXjgqZ
         bq9nmsSpuvuu6DPqrNyi1D4QurfskCYJ1bDseh2OXwZ0I0D/OBdkpMcszdaI1pl58Qmb
         dVdsIthwoSqz0PvOSjp68azocp8G73z94oAKn+lQsE5OmqT+VUiTeVFlbKJ11VzORwUy
         LL/jCLL7gqOQQd+TsnQrl0nlQIzvC4nZ0W03dGaBTuI1ts6Oyr6jmngrAz/N4kpGjHcE
         xYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZoiIgqXEWzyqtlTaQ+Ba//J1RZ862dZb+NKa2/0g3sQ=;
        b=bBaF1dTHigO62i51vzhxlwzL7kFwH4V7BCmpmJqCXWYkxHLF7NJ1z4w07EuNaP2ztQ
         lBSZL9Er+Xd0bkMNytPigtBOIYvPdQObb9uzmxojW0F+m35fzsiAbJNkHwksbuMmjKyA
         EMiHKA7r3JuOzCNGZGNYTFCgvBZVHrbd9C/rK9d7T7d63uUHeumQDDBqs5u6Rnc7ydow
         Q9mBEMi0hLC3rifNLSXWk1uiE9uhNBST/fy6GOC2OzhgSwNP3z/GXYfFEiyxiUxMoU8p
         pBKoe3hTWgYUwldcTUuahqL5lvVNE4iEQL+t97bh3CBEULkyS11zxREDaA5ct1jEFrIf
         ByZA==
X-Gm-Message-State: AOAM531xji7KhvyMBvrRkv+5WexnJ6juGIOp2fBZxAqLPPcCvalG8YEe
        0YfCplpS/cy2HtlXwTXKCtQe
X-Google-Smtp-Source: ABdhPJwY/DwGWrZ3N2jm3xcKwqSaMCGodal6L8qfJvB4BW2fdX97yvWoMuid3tXFc3CQl/fSieLycw==
X-Received: by 2002:a05:620a:17a0:b0:648:e2c1:b764 with SMTP id ay32-20020a05620a17a000b00648e2c1b764mr7326886qkb.427.1646669681292;
        Mon, 07 Mar 2022 08:14:41 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm6288007qka.80.2022.03.07.08.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 08:14:41 -0800 (PST)
Message-ID: <142219bd-5047-a27d-d53f-2ec2f6cb9c08@github.com>
Date:   Mon, 7 Mar 2022 11:14:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 08/11] bundle: parse filter capability
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <e7dbb46e6acb5c22a0b456135f3af42b974e0268.1645638911.git.gitgitgadget@gmail.com>
 <220307.86bkyhzs3r.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220307.86bkyhzs3r.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/7/2022 10:38 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
...
>> diff --git a/bundle.h b/bundle.h
>> index 06009fe6b1f..eb026153d56 100644
>> --- a/bundle.h
>> +++ b/bundle.h
>> @@ -5,11 +5,14 @@
>>  #include "cache.h"
>>  #include "string-list.h"
>>  
>> +struct list_objects_filter_options;
>> +
> 
> For the other ones we include the relevant header, do the same here (or
> if there's a need to not do it, do we need it for the rest too?)

The others are .c files that require looking into the struct. This
declaration is all that's required for this header file.

>>  struct bundle_header {
>>  	unsigned version;
>>  	struct string_list prerequisites;
>>  	struct string_list references;
>>  	const struct git_hash_algo *hash_algo;
>> +	struct list_objects_filter_options *filter;
>>  };
> 
> I haven't tried, but any reason this needs to be a *filter
> v.s. embedding it in the struct?
> 
> Then we'd just need list_objects_filter_release() and not the free() as
> well.
> 
> Is it because you're piggy-backing on "if (header->filter)" as "do we
> have it" state, better to check .nr?

Yes. I replied to Junio before that there is some assumption in
the filtering code that the .nr == 0 case is listed as a BUG()
so we would possibly be breaking expectations in a different
way doing the embedded version.

>> @@ -55,7 +55,7 @@ const char *list_object_filter_config_name(enum list_objects_filter_choice c)
>>   * expand_list_objects_filter_spec() first).  We also "intern" the arg for the
>>   * convenience of the current command.
>>   */
> 
> These API docs....
> 
>> -static int gently_parse_list_objects_filter(
>> +int gently_parse_list_objects_filter(
>>  	struct list_objects_filter_options *filter_options,
>>  	const char *arg,
>>  	struct strbuf *errbuf)
>> diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
>> index da5b6737e27..347a99c28cf 100644
>> --- a/list-objects-filter-options.h
>> +++ b/list-objects-filter-options.h
>> @@ -72,6 +72,11 @@ struct list_objects_filter_options {
>>  /* Normalized command line arguments */
>>  #define CL_ARG__FILTER "filter"
> 
> ...should be moved here, presumably.

Yes. Thanks!
-Stolee
