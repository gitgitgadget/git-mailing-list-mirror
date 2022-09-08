Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03093C38145
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 00:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIHAY2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIHAY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 20:24:26 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D50ABEB
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 17:24:23 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-127dca21a7dso12924750fac.12
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 17:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=i7CUD87qCX+hr4t6k1ZofGQ6fN/qDQl8JYqiKk32sQw=;
        b=INQiFjh3gI+F3fXzX81axARabH15Q14kp9QyvD0I2XZV8kGTLgWC9B/GXsPh3eBFJi
         tjTzo0YlNTifgaCftsZa/IRezfMk1BtdmwYEN/eDG1H8fcKIVwJRbwtyIcZLSfjBBTDH
         Vw9ZxAKiNpFymamp6UZGS0ItmX0/332l1+BpLBrOLfQ2wjJygi44wNBqo/sMbRn8/LyK
         fIMR/1ZhsscvXrdYgn+Fhvcs5/CAHTzXF9CG+DmiRBUfinF8IfjaMbrgw1D1TMKTYRma
         UeHAZdejw+HpNHTXbiUIsKd2m93D8zXsCuZ9dAZIxaxx9UETmkSbE+n+OHgspmow2nL6
         PPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=i7CUD87qCX+hr4t6k1ZofGQ6fN/qDQl8JYqiKk32sQw=;
        b=e0o5mTYcOauEDIq10JIWEJeEgBFZprL+PXOPChZxa7lCyZmNSe1dJz9dxNz2Udlymu
         a6D0bk4fK6Tg7GhTsUkEsfzGILjoz83NIrLOeoQWwVb46+/VP6bKk+yZIBug3lRRZInV
         tiFLvjLOY1FC6SWp49ZzKITtMkHVpfsFc3SYQf/d5Rcg74pmRmrEF7QuLsUtPCFCUwmE
         NE7ys1hMYI0t7PYe6XcJaqOJP7I3Vorp8uamcOW6L232anlxKn8g6d6hDCe1sAf12uqd
         /tKEyrSkk0H6rPqs1t50CrDxmeuk1wi2YUfo9f8C8eQZSPfZVhYW/BajJ+d8P9p+uOKJ
         /dkg==
X-Gm-Message-State: ACgBeo1seZeitNjG/pC1T54xoGzmZVwNJh7jigrS4Qwz57IzGOBmDcQW
        pFvJg7X2m8pwEfVr26DQf+E=
X-Google-Smtp-Source: AA6agR6Mmulg9UNolvn0q/UgMvrR+UsTtvviGKUP/7w6ePZep23z/q8h/qASHQaAGWHmpuvp0HCSlA==
X-Received: by 2002:aca:b554:0:b0:34c:fa8c:c541 with SMTP id e81-20020acab554000000b0034cfa8cc541mr66409oif.2.1662596662852;
        Wed, 07 Sep 2022 17:24:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:a9ed:6ae4:cfed:738f? ([2600:1700:5a60:7720:a9ed:6ae4:cfed:738f])
        by smtp.gmail.com with ESMTPSA id i27-20020a4a6f5b000000b00425678b9c4bsm5709096oof.0.2022.09.07.17.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 17:24:22 -0700 (PDT)
Message-ID: <679485f4-da18-ec7c-210e-c8463ef4920e@gmail.com>
Date:   Wed, 7 Sep 2022 17:24:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 3/3] builtin/grep.c: walking tree instead of expanding
 index with --sparse
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com, vdye@github.com
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220903003623.64750-1-shaoxuan.yuan02@gmail.com>
 <20220903003623.64750-4-shaoxuan.yuan02@gmail.com>
 <xmqqczcd1382.fsf@gitster.g>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <xmqqczcd1382.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/2/2022 9:39 PM, Junio C Hamano wrote:
> Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> writes:
> 
>> @@ -537,8 +534,20 @@ static int grep_cache(struct grep_opt *opt,
>>  
>>  		strbuf_setlen(&name, name_base_len);
>>  		strbuf_addstr(&name, ce->name);
>> +		if (S_ISSPARSEDIR(ce->ce_mode)) {
>> +			enum object_type type;
>> +			struct tree_desc tree;
>> +			void *data;
>> +			unsigned long size;
>> +
>> +			data = read_object_file(&ce->oid, &type, &size);
>> +			init_tree_desc(&tree, data, size);
>>  
>> -		if (S_ISREG(ce->ce_mode) &&
>> +			hit |= grep_tree(opt, pathspec, &tree, &name, 0, 0);
>> +			strbuf_reset(&name);
> 
> Is this correct?
> 
> I would have expected that this would chomp to name_base_len, just
> like what the code before this if/elseif cascade did.

OK.

> 
> There needs a test that is run with repo->submodule_prefix != NULL
> to uncover issues like this, perhaps?

I'm sorry that I forgot to directly reply to this. But I have sent a v5
[1] based on your suggestions here. Thanks for the review!

[1]
https://lore.kernel.org/git/20220908001854.206789-1-shaoxuan.yuan02@gmail.com/

Thanks,
Shaoxuan
