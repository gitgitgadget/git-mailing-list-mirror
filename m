Return-Path: <SRS0=eTRQ=EM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515E5C388F7
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CDB206FB
	for <git@archiver.kernel.org>; Fri,  6 Nov 2020 01:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nG+qK6Ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732577AbgKFBgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 20:36:48 -0500
Received: from avasout02.plus.net ([212.159.14.17]:58019 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbgKFBgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 20:36:48 -0500
Received: from [10.0.2.15] ([80.189.83.69])
        by smtp with ESMTPA
        id aqgHkOW3h0K1OaqgIke8PN; Fri, 06 Nov 2020 01:36:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604626606; bh=90fpvmqszq82coz27A4mZGdtqiGYNOwugn0og9vP0Xc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nG+qK6FfAZDN+YSy2+YCjvdlUsJn0TJ3/nUr56kFKBPmDRBthdU7UE84oKDccmU/a
         Y0k37X0Q6T4LrpCepVdlyBc2vMyQDab8Nt626ay46jd02C6xMmJf0puexs1MOna9lr
         GqjPznIchfKxZP8PqbN14KE0hCyblNUOOpHmky66vx2p8KFT0CWtjdtgBCbOPjCptg
         GvGd/rSP9jywbLeMe4tHIol9Amp9lInGhBjlNap2QIBM5NKpfp2EWjSxeUOv0mR4nq
         K7t20Kg1NQ9XRpNN03NeLHZ+tD0E07CqtAdFLAd31SnuNbuexT0LAvNPLcAeN8E4RW
         FPPfDzRVDi6UQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=VKYMt3kHM3Z9lWmoeJedNA==:117 a=VKYMt3kHM3Z9lWmoeJedNA==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=2elCIetExCMgwJvxCxYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 7/8] Makefile: don't delete dist tarballs directly by name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
References: <48fdd198-93ad-7282-27e6-9a0c6de93067@ramsayjones.plus.com>
 <xmqqr1p7h38t.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4b59622a-f2f3-6d86-2742-46a0524fa6d5@ramsayjones.plus.com>
Date:   Fri, 6 Nov 2020 01:36:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqr1p7h38t.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPDUK8ZO3ez013rhy8v4kJJfpZlqp+SZ0t8QyO1OwQy5J5qcbiuBWXAtKSLDeNEQVRxGDdPv/9zxObtcCJzhdiPsViIWQYpp91udTGa9VeFtfQ5wBZWE
 bWwqRRpomyB1AKnIVqcMrSyOp2zprS0tGtCqBZGSMp8m1ZzwqOdFa340jeJ7h7B1f2dCloqN+VgU3g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/11/2020 22:01, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> diff --git a/.gitignore b/.gitignore
>> index 6232d33924..425b8cc2a4 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -191,6 +191,7 @@
>>  /gitweb/static/gitweb.min.*
>>  /config-list.h
>>  /command-list.h
>> +/dist-tars
>>  *.tar.gz
>>  *.dsc
>>  *.deb
>> diff --git a/Makefile b/Makefile
>> index 90e91a2185..bc9ce28bc3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -3083,6 +3083,7 @@ dist: git-archive$(X) configure
>>  		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
>>  	@$(RM) -r .dist-tmp-dir
>>  	gzip -f -9 $(GIT_TARNAME).tar
>> +	@echo $(GIT_TARNAME).tar.gz >>dist-tars
> 
> Sorry, but I'd rather not to see such a longer-term "list of files
> to be removed" on the filesystem.  This invites attackers to write a
> rogue test addition that writes into ../../dist-tars something like
> "~/.gitconfig" and wait for me to say "make clean".

Yes, that is a reasonable concern. I suppose we could drop the last
two patches then - most of the saving comes from the first four patches
(as you can see from the table in the cover letter).

Also, I had an alternative patch for the last patch, which did away with
the '-include GIT-VERSION-FILE' entirely! (That had treewide implications
that I hadn't sorted through yet).

ATB,
Ramsay Jones

