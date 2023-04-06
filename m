Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813AEC77B6E
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 22:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjDFWTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjDFWTM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 18:19:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F402B7
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 15:19:06 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-4fa3c1a7a41so1445571a12.2
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819545; x=1683411545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FZhMEJ3O8XGASk7tVlovLWnpvyfrq8HtzBWFOaTptAQ=;
        b=CrMacPQRomgXy70HTjOCCBtRA1X1W7u1S860XkIdZNWwdf1sAiv880eeRr8VTO8jJt
         HjhDlTXytcZlY/wWYHAzJZLTXb4dzWLZktg1MmISjVzT6ruu85C+yNebAQ/Uzbb9GCsJ
         MYlB46TAJuK7t8suk68RazHc5SImEDlnAKhbAj/yM3Wo6NZEXq7RsOOzr5UoGyeNSto9
         KcWY4Tr1eSxizVwtD7xRcxs6K/+7Un3AQAk6uxlbFO3LHYjyzAH8tkkL5Gm2c7sQ5nIu
         PXBNXIZ3/Sn5VOSXoQjG/xv7l9GaMASCg7+mKIWqUn0wrgjDLUr0RGfu0u26URUrozWl
         gSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819545; x=1683411545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZhMEJ3O8XGASk7tVlovLWnpvyfrq8HtzBWFOaTptAQ=;
        b=3u06cFTDlBlQon1lYPW8JZU/f1yQs1ouBhSf+liXo/V5hEEbyfkNIcUIvZ8R0OXMIJ
         mJWwM0457zH4XHXZNM2kuFvkoMaDfQZG5n43uGW2FSQVLEzMKn7aQxCkaSmBA6RpvY1w
         sH+priMfQAMdICfHAr+zEWZkstqS6/vtmUgPxm/z2mj6B4zbVo9Y4DkxPUDBqhVRN5z5
         B3Tcts1SPZEK+i4rfKOcacQZrFNdcd6hcdE7/tjWtY9s4YGWEGD1aNDQOsXcdBKLPY7i
         JhkC4HQZZBTkeOj+9OA1GWCe/i+ztEL1LNCQPx/AU9Qo44kHG1Qkxpeql2S8narNMB4z
         YGHg==
X-Gm-Message-State: AAQBX9fyQDSkAxaXPKm4Z1eBPBtIrAjOpVZKFmOnbtjLkrxFkIlXGAJd
        0f6nzR2gd25sya/mAN/6wTg=
X-Google-Smtp-Source: AKy350aHzPlMNqCWA/tLVw76wRgv5ACGRVetjDeEtIIVeGjJmHT+CmhpSwTm5C6Ot4KQBFj+wU+JPA==
X-Received: by 2002:a50:ee99:0:b0:502:3376:7872 with SMTP id f25-20020a50ee99000000b0050233767872mr1070425edr.35.1680819544433;
        Thu, 06 Apr 2023 15:19:04 -0700 (PDT)
Received: from [10.6.18.184] ([45.88.97.12])
        by smtp.gmail.com with ESMTPSA id y30-20020a50ce1e000000b0050470829dbesm828214edi.63.2023.04.06.15.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 15:19:04 -0700 (PDT)
Message-ID: <35bc2dc5-d5cb-3492-ff94-41b93b7563d4@gmail.com>
Date:   Fri, 7 Apr 2023 00:19:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 4/6] t1450: don't create unused files
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230403223338.468025-5-rybak.a.v@gmail.com>
 <230406.86lej5tn8c.gmgdl@evledraar.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <230406.86lej5tn8c.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2023 10:41, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Apr 04 2023, Andrei Rybak wrote:
>> ---
>>   t/	 | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
>> index bca46378b2..8c442adb1a 100755
>> --- a/t/t1450-fsck.sh
>> +++ b/t/t1450-fsck.sh
>> @@ -989,10 +989,7 @@ test_expect_success 'fsck error and recovery on invalid object type' '
>>   
>>   		garbage_blob=$(git hash-object --stdin -w -t garbage --literally </dev/null) &&
>>   
>> -		cat >err.expect <<-\EOF &&
>> -		fatal: invalid object type
>> -		EOF
>> -		test_must_fail git fsck >out 2>err &&
>> +		test_must_fail git fsck 2>err &&
>>   		grep -e "^error" -e "^fatal" err >errors &&
>>   		test_line_count = 1 errors &&
>>   		grep "$garbage_blob: object is of unknown type '"'"'garbage'"'"':" err
> 
> ...but ditto my review on other patches, this just seems like a mistake
> of mine, i.e. if I add the "test_must_be_empty out" the test passes.
> 
> So isn't the answer here that my 31deb28f5e had an unintentional
> regression, and we should bring the assertion back? Its commit message
> says nothing about wanting to stop asserting stdout.
> 
> Maybe there was a reason I'm missing for why I remved it, it's since
> been paged out of my wetware, but looking at it briefly now it just
> seems like an unintentional bug / loss of test coverage that we should
> fix.

Tests in t1450-fsck.sh that do enforce empty standard output do it mostly
via ">../actual 2>&1" and then a "test_must_be_empty actual".

For 'fsck error and recovery on invalid object type', the question is:
is having this assertion useful for a developer using this test? The test
is about invalid object types and what error messages "git fsck" prints
about them.  The test creates a fresh repository for it:

> 	git init --bare garbage-type &&

Is it useful to a developer working on this part of "git fsck" to have
a "reminder" that no dangling objects should be found in such a fresh
repository?  Speaking of which, should there be such a test:

	test_expect_success 'fresh repository has no dangling objects' '
		git init fresh &&
		git -C fresh fsck >out
		test_must_be_empty out
	'

? Maybe even in t0001-init.sh?
