Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BFC433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 09:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJHJEo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 05:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJHJEn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 05:04:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE25F4B
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 02:04:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3742124wms.5
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 02:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zFL3TKBayQWatisn37u9UF4AkqCF9JcUO+kZlYULQWU=;
        b=i4aGqI1Kwe/7RPcKRl0SRyMnfke+hqjQK1cbOVVijg6EXz7zfcoHXA15MlOnvMtSz0
         VSVRltZz14Ej/nfqeVmM28WJlHRCSbRt5c/FQnTl6ITdi/srkXJ/1kYLMR2XFkq3tCb8
         sRuyRC7TJPxH2m6jxYGv5WldEnkvoNZmmUX5ejnEZXGLKoTEa6cck7bEKazu8h0yCZkx
         hnitXI8cG4uPTpg/BMWaBjH41EoVR5KdvRr4+bKZer27GGGwA2l+qohfQwe51CK08A8r
         WWokbdELo4wqnCnsba5To5GVzCsNrB7M16rgi4+wlmeGwVc/+AzD5dSh5kOf2vuxWjzU
         TeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFL3TKBayQWatisn37u9UF4AkqCF9JcUO+kZlYULQWU=;
        b=GZA4P0JMeA6GvVI5RgyK3mfmL3boDhn7OduPdSM8ze5qfpqvTRNWCYW4QGtqWVOKdA
         1grrIdj+GxpD+7ijTRdyfI6YfDwnUN/9737j8zcBT3c6IG0qrVhJ92JZGK7X3f24Li3l
         SbUu2jLXfEe/5bQCk/QKOlri7UNirpe1QlYVMVkn051s7mpD+0wAr+Rrg5K4cpobiYJ4
         QHCCg6bdBRt9naqnEiG3q/VDmBYmpiMtL0Ff871c+fL2rZa9oXIsPiPz0gXIp0EkayBO
         M9ivu6d2zYnAJlCMZtfOCx51qkEuh5D7kI7/i47+UuzxmyANfZLdfBYwThkyAZiHMdRy
         Vfkw==
X-Gm-Message-State: ACrzQf2Dug15pCxXKu3wUrNufNSBfTSdRhT2W88S4jTFZXH7A6UxATWq
        vVpVGUgUYx1+yTqP+Qoh3JRshPlQ8/g=
X-Google-Smtp-Source: AMsMyM4zOMt2X5F4xmDxAq3+MnitqIOY8knLSkrm4XY2Cb7VAaxjZMjwrLkYn5NvolSgyWbAWhKwQw==
X-Received: by 2002:a05:600c:a45:b0:3bc:c676:a573 with SMTP id c5-20020a05600c0a4500b003bcc676a573mr13181464wmq.118.1665219879755;
        Sat, 08 Oct 2022 02:04:39 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b003a540fef440sm11489868wms.1.2022.10.08.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 02:04:38 -0700 (PDT)
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com> <xmqq8rlrc5jp.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <32c2fe9a-51c4-493c-5600-ef77f8818b64@gmail.com>
Date:   Sat, 8 Oct 2022 11:04:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqq8rlrc5jp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/22 6:17, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
>>  	} else if (new_upstream) {
>> -		struct branch *branch = branch_get(argv[0]);
>> +		struct branch *branch;
>> +		struct strbuf buf = STRBUF_INIT;
>>  
>> -		if (argc > 1)
>> +		if (!argc)
>> +			branch = branch_get(NULL);
>> +		else if (argc == 1) {
>> +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
>> +			branch = branch_get(buf.buf);
>> +		} else
>>  			die(_("too many arguments to set new upstream"));
>>  
>>  		if (!branch) {
>> @@ -854,11 +867,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>>  		dwim_and_setup_tracking(the_repository, branch->name,
>>  					new_upstream, BRANCH_TRACK_OVERRIDE,
>>  					quiet);
>> +		strbuf_release(&buf);
>>  	} else if (unset_upstream) {
>> -		struct branch *branch = branch_get(argv[0]);
>> +		struct branch *branch;
>>  		struct strbuf buf = STRBUF_INIT;
>>  
>> -		if (argc > 1)
>> +		if (!argc)
>> +			branch = branch_get(NULL);
>> +		else if (argc == 1) {
>> +			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
>> +			branch = branch_get(buf.buf);
>> +		} else
>>  			die(_("too many arguments to unset upstream"));
> 
> The above two are a bit repetitious.  A helper like
> 
> 	static struct branch *interpret_local(int ac, const char **av)
> 	{
> 		struct branch *branch;
>                 if (!ac) {
>                 	branch = branch_get(NULL);
> 		} else if (ac == 1) {
> 			struct strbuf buf = STRBUF_INIT;
> 			strbuf_branchname(&buf, av[0], INTERPRET_BRANCH_LOCAL);
> 			branch = branch_get(buf.buf);
> 			strbuf_release(&buf);
> 		} else {
> 			die(_("too many arguments"));
> 		}
> 		return branch;
> 	}
> 
> might be useful, and it frees the callers from worrying about
> temporary allocations.

Yes, it leaves a repetitive taste.  I thought about joining the two cases, but
the taste with multiple if/else was worse.  Following what you suggest with the
"too many arguments" error, I'll try to reduce that repetitive taste.

Thanks

> 
> But the code written is OK as-is.
> 
