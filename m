Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D84DC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 19:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjHHTqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjHHTqR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 15:46:17 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A6117BB5
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:50:49 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so40179395e9.3
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691513448; x=1692118248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/sHuMwZKgwQ09Q3mt51P2wqlDQHj/2uOS7bgDxjaTFM=;
        b=ejpBDCMVUL46Ki+unhoaxF4u5DYLl+HOBPZCu0B82xGR5irl3+olhRS94o0ata+6+Y
         3UTOqNRyeLwcf6Zp7/cJ+C+Id+Has9zn0kqoBoRkP031UzUVVR6nj5OEdDx08EwE4+/3
         NZIg0C7tld0YpMIaFUo+ulLvy1UbjHMij1HPe+Ibw8CXtj7087q187zI3sWzk9ZIcwZ1
         6eAPM9e//w5Xh2laDfQIyceTTZG4oeUkrMibREv0A8LFO8l0syf1fsSNIwdtyfEvLVI2
         0noAeDHX+dBh3XmCcsbE6XJWQt0wUNuuoFBnaHyL9WjvpN7Rb4tnHZ9fYg1tTwHsldRk
         HAjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691513448; x=1692118248;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/sHuMwZKgwQ09Q3mt51P2wqlDQHj/2uOS7bgDxjaTFM=;
        b=K0v9diUIjdas5pLRGJ0YcfGqHzYgff4f/ozc6/zk/NeFtf6pjC9Iri9kWLH1FP+ece
         ZpZ7aeY3bHUiqjbB8pNXcOENSUvm++tmQXJVEqyp9Tcu/KZul1oVroOnt9Yaw3i+jyPC
         m2xg1l9LmvS5ZtIHv/sVzmlpXTJsN/LUgb0gFAzeMQzLLLyc1rs2aEzk9BB7eKDLSABY
         M7+7xdy5/EcBIzvwG1q/dwxcx5PaUBdC26MLI3s1lleKYkJR1QS9B4l7fW5UQyYzFA4/
         KSEXxoSHFGPU3DW6Zl3KL7BJJsyFQatYUHOi8NRbJhPleThHviQwMoGe1ouO02t1oxQs
         ieIg==
X-Gm-Message-State: AOJu0YwJ9ck4jamQZuFvyNqS7cI6tILqsuUKrSSja55Z9QxBtnQjwRPt
        8+3GFE1LQmLcGKCBeeSLXLjqfvbMbn4=
X-Google-Smtp-Source: AGHT+IFEMgyLGwZXYqgOMp2P1X9TYNDsQRvWjZX0+30obq2L5Ij1g3Kx3TPRiIJMMNpNYJLe+EJ0xg==
X-Received: by 2002:a05:600c:2286:b0:3fa:8c68:4aba with SMTP id 6-20020a05600c228600b003fa8c684abamr9002140wmf.25.1691497154896;
        Tue, 08 Aug 2023 05:19:14 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id z12-20020a05600c220c00b003fe1ca92151sm13616523wml.26.2023.08.08.05.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 05:19:14 -0700 (PDT)
Message-ID: <1fd1f22d-e0db-04f3-7235-899b10909c7a@gmail.com>
Date:   Tue, 8 Aug 2023 13:19:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/5] trailer: separate public from internal portion of
 trailer_iterator
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <0bce4d4b0d5650edf477cbbcc9f4e467b7981426.1691211879.git.gitgitgadget@gmail.com>
 <kl6l8rama6yj.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <kl6l8rama6yj.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/08/2023 22:16, Glen Choo wrote:
> As someone who isn't that familiar with trailer code, and will have less
> time for the ML soon, this is more of a quick drive-by..

This is a bit of a drive-by comment as well ...

> "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +#define private __private_to_trailer_c__do_not_use
>> +
>>   void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>>   {
>>   	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
>>   	strbuf_init(&iter->key, 0);
>>   	strbuf_init(&iter->val, 0);
>>   	opts.no_divider = 1;
>> -	trailer_info_get(&iter->info, msg, &opts);
>> -	iter->cur = 0;
>> +	trailer_info_get(&iter->private.info, msg, &opts);
>> +	iter->private.cur = 0;
>>   }
>> --- a/trailer.h
>> +++ b/trailer.h
>> @@ -119,8 +119,10 @@ struct trailer_iterator {
>>   	struct strbuf val;
>> ...
>>   	/* private */
>> -	struct trailer_info info;
>> -	size_t cur;
>> +	struct {
>> +		struct trailer_info info;
>> +		size_t cur;
>> +	} __private_to_trailer_c__do_not_use;
>>   };
> 
> Interesting approach to "private members". I like that it's fairly
> lightweight and clear. On the other hand, I think this will fail to
> autocomplete on most people's development setups, and I don't think this
> is worth the tradeoff.
> 
> This is the first instance of this I could find in the codebase. 

We have something similar in unpack_trees.h see 576de3d9560 
(unpack_trees: start splitting internal fields from public API, 
2023-02-27). That adds an "internal" member to "sturct unpack_trees" of 
type "struct unpack_trees_internal which seems to be a easier naming scheme.

> I'm not
> really opposed to having a new way of doing things, but it would be nice
> for us to be consistent with how we handle private members. Other
> approaches I've seen are:
> 
> - Using a "larger" struct to hold private members and "downcasting" for
>    public users (struct dir_iterator and struct dir_iterator_int). I
>    dislike this because I think this enables 'wrong' memory access too
>    easily.
> 
>    (As an aside, if we really wanted to 'strictly' enforce privateness in
>    this patch, shouldn't we move the "#define private" into the .c file,
>    the way dir_iterator_int is in the .c file?)

That #define is pretty ugly

Another common scheme is to have an opaque pointer to the private struct 
  in the public struct (aka pimpl idiom). The merge machinery uses this 
- see merge-recursive.h. (I'm working on something similar for the 
sequencer so we can change the internals without having to re-compile 
everything that includes "sequencer.h")

> - Prefixing private members with "__" (khash.h and other header-only
>    libraries use this at least, not sure if we have this in the 'main
>    tree'). I think this works pretty well most of the time.

It is common but I think the C standard reserves names beginning with "__"

> - Just marking private members with a comment. IMO this is good enough
>    the vast majority of the time - if something is private for a good
>    reason, it's unlikely to get used accidentally anyway. But properly
>    enforcing "privateness" is worthy goal anyway.
>
> Personally, I think a decent tradeoff between enforcement and ergonomics
> would be to use an inner struct like you do here, but name it something
> autocomplete-friendly and obviously private, like "private" or
> "_private".

I agree, something like that would match the unpack_trees example

> I suspect self-regulation and code review should be enough
> to catch nearly all accidental uses of private members.

Agreed

Best Wishes

Phillip

