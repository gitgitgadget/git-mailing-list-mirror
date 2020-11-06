Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31E9C388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60AF92075A
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ngjZeV9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732838AbgKFBad (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:30:33 -0500
Received: from avasout02.plus.net ([212.159.14.17]:57686 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgKFBad (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 20:30:33 -0500
Received: from [10.0.2.15] ([80.189.83.69])
        by smtp with ESMTPA
        id aqaEkOVgZ0K1OaqaFke8Jv; Fri, 06 Nov 2020 01:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604626231; bh=cCtKYCflblaQjwtBn247gNKRxP4oJ9Z7uBzrOLlp0Zw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ngjZeV9wdmI9W7l58ioZxhn9LK2dpENIuRHb0ePY+ZyjPaT9plkExz0013pFzVTiP
         PnsSibOGqXz8mQS4oyzL3C/BrbnGQR9utW1kEHglViTgvQuzK2Cva+UZiDxDtyyVcQ
         YI4pxBKdDldJzwpdLNJaz/ZufTcvGrR1M7+XQIoVu7HbjlMd79kLkBa3IQOik+M+45
         Bf3slMDsff5hKi3ZcRddbLOhQL+1cg8CQ+oAu4dsOvuyrsJuoOrxhFxsXCJv8CtNim
         oL1jLWOIvaj3QueU16pzkP4Cp1ath9eQGV6tOEMrbSnGLx81fI7K9QQ6JQh76Ybu65
         3+c1YUmct8YQA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=VKYMt3kHM3Z9lWmoeJedNA==:117 a=VKYMt3kHM3Z9lWmoeJedNA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=to6oJUn1mVSC9bFIeD0A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
 <xmqqy2jfh3nz.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <2f55ac8d-bcbc-5b4b-a790-4a749b369db0@ramsayjones.plus.com>
Date:   Fri, 6 Nov 2020 01:30:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2jfh3nz.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL2UZvHOMB0feA1pVhVrZ73I1sM2WcpFq6DU2sXACQw5RajEfvl5q+/y5A4oLHes3qz1ZnPHctAGh+XLMQSd6MtCk5Bioh43so/gLHf/IMMLkQp6nnH4
 ZjJPgdsbKT5lENIJRrIiLzic1qGP46jkzmMgXxY24KdSmgssIJxCsnMamhGRJ85qgV4jzik/dGOd3g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/11/2020 21:52, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> The 'clean' target is still noticeably slow on cygwin, despite the
>> substantial improvement made by the previous patch. For example, the
>> second invocation of 'make clean' below:
>>
>>   $ make clean >/dev/null 2>&1
>>   $ make clean
>>   ...
>>   make[1]: Entering directory '/home/ramsay/git/Documentation'
>>   make[2]: Entering directory '/home/ramsay/git'
>>   make[2]: 'GIT-VERSION-FILE' is up to date.
>>   make[2]: Leaving directory '/home/ramsay/git'
>>   ...
>>   $
>>
>> has been timed at 12.364s on my laptop (on old core i5-4200M @ 2.50GHz,
>> 8GB RAM, 1TB HDD).
>>
>> Notice that the 'clean' target is making a nested call to the parent
>> Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
>> the previous patch, there would have been _two_ such invocations).
>> This is to ensure that the $(GIT_VERSION) make variable is set, once
>> that file had been included.  However, the 'clean' target does not use
>> the $(GIT_VERSION) variable, so this is wasted effort.
>>
>> In order to eliminate such wasted effort, use the value of the internal
>> $(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
>> target is not 'clean'. (This drops the time down to 10.361s, on my laptop,
>> giving an improvement of 16.20%).
> 
> This obviously relies on the fact that none of our build products to
> be cleaned are named using $(GIT_VERSION)---in other words, if our
> cleaning rule contained
> 
> 	rm -f git-$(GIT_VERSION)-manual.html
> 
> this optimization would not work well.

Yes, indeed.

> Luckily, I think we use GIT_VERSION only to engrave version number
> in the resulting document, and it does not affect the name of the
> build product, so this change is safe, I think.

Yes, as I said in the commit message above:

    "However, the 'clean' target does not use
    the $(GIT_VERSION) variable, so this is wasted effort."

Thanks.

ATB,
Ramsay Jones
