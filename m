Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03C851F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 14:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeJIV2r (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 17:28:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42716 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIV2q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 17:28:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id g20-v6so988754qke.9
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=kN7nYo+K0KsBlPUx9OaYYK0g7+yg2FiTcwWomq7bypw=;
        b=hHXkj2mJTKjnk3A21zrbMin/U009V8MBvo4BTV/hK9AtTX1nj9CiVWEVFAkZxtOe7O
         z4F7zuqlTBMUwQbblyjnyL7c0i1g2t9NWs/Lq18QnMY/LAJrDKuO6+0uK0YNLdzqhkvG
         Hjtg4F6JctgNk9xcDNSzGnLPp76PYjY8PL/nTNAJK2eww80FQhH9tgpD9FVIp2exNEo+
         OD9l/GMzhvVSqwHOggvc8EOwpDiOqouhP62ztnvirQwq+NA5QTjMbNGWgMhbbUWEKIiz
         TsotPFwFy9Z96qanpYhv6r5F1i8Uyua1LJEstFNAYDMRRB0GAumimYL1qFj1nm25ki3A
         IViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=kN7nYo+K0KsBlPUx9OaYYK0g7+yg2FiTcwWomq7bypw=;
        b=ST4iO7C7CmJR4komTpKI55Ac/UPIvUuhCC5Qk6Kvwue1HJPnJnSVnReL4G3SZdwh3j
         u8j05NwyJJNlxLAGj8azlo10hikdiLd+CEhFAeWvzwq1Ihyir8ChXmm7XsPHTionvVDI
         +xsh8c1/+Bze9tsKugAL/zqY9jSH9Qco5WU2Awd8BAuKIfumOzlW3dJz08EGW1Sq5EkK
         nlHZs58cWchgTx6RfrxRT6+pyquHNhPRcADi+tzPBHBaGUp1W3WQaWF5K8cRUQ666rWE
         yFBthXoVgDreIAPbTld4X6wekM0k0D7c2kxAPGkCHe58woXexVJe0rEJBHMjz6AksmgY
         UqCQ==
X-Gm-Message-State: ABuFfohiYOKNoWEzUFCvxPzzcElx4HQwcXEn+KkwBtB3tAARJYVn1kA+
        Tc5CMkPeOsRB4qkzgOv/yHc=
X-Google-Smtp-Source: ACcGV63GJ/I/TWnTdfifF1lPtrYeVDVRTTp7mp52e/kSeChK6kKMphvCNXLNchsCySLpy1tqRf/qVA==
X-Received: by 2002:ae9:f810:: with SMTP id x16-v6mr10808198qkh.334.1539094297211;
        Tue, 09 Oct 2018 07:11:37 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id 135-v6sm9849102qkm.65.2018.10.09.07.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 07:11:34 -0700 (PDT)
Subject: Re: [PATCH 2/3] midx: close multi-pack-index on repack
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
References: <pull.27.git.gitgitgadget@gmail.com>
 <725ebadc92a91469eed089eb501b705c2dd2c627.1539011820.git.gitgitgadget@gmail.com>
 <xmqq4ldvqyci.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8b5dbe3d-b382-bf48-b524-d9e8a074ac4d@gmail.com>
Date:   Tue, 9 Oct 2018 10:11:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ldvqyci.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2018 5:10 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> diff --git a/builtin/repack.c b/builtin/repack.c
>> index c6a7943d5c..7925bb976e 100644
>> --- a/builtin/repack.c
>> +++ b/builtin/repack.c
>> @@ -432,6 +432,10 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>   
>>   			if (!midx_cleared) {
>>   				/* if we move a packfile, it will invalidated the midx */
>> +				if (the_repository->objects) {
>> +					close_midx(the_repository->objects->multi_pack_index);
>> +					the_repository->objects->multi_pack_index = NULL;
>> +				}
>>   				clear_midx_file(get_object_directory());
>>   				midx_cleared = 1;
> It somehow looks like a bit of layering violation, doesn't it?  When
> we are clearing a midx file, don't we always want to do this as well?

You're right. It did feel a bit wrong. In v2, I'll replace this commit 
with a refactor of clear_midx_file() to do that. One tricky part is that 
we need to clear the file even if the in-memory struct hasn't been 
initialized, but I think passing a repository will suffice for that.

CC Stefan: Is there a plan to make get_object_directory() take a 
repository parameter?

Thanks,

-Stolee

