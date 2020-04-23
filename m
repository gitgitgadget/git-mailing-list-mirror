Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE0EC55185
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9AAC2075A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=blastwave.org header.i=@blastwave.org header.b="dVOZV6+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgDWAKF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:10:05 -0400
Received: from mail.oetec.com ([108.160.241.186]:37608 "EHLO mail.oetec.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWAKF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 20:10:05 -0400
X-oetec-MailScanner-From: dclarke@blastwave.org
X-oetec-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
        score=-1.199, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
        DKIM_SIGNED 0.10, DKIM_VALID -0.10, DKIM_VALID_AU -0.10,
        DKIM_VALID_EF -0.10, URIBL_BLOCKED 0.00)
X-oetec-MailScanner: Found to be clean
X-oetec-MailScanner-ID: 03N09kgn006385
X-oetec-MailScanner-Information: Please contact oetec for more information
Received: from [172.16.35.3] (CPEf81d0f84cb23-CMf81d0f84cb20.cpe.net.cable.rogers.com [99.253.169.68])
        (authenticated bits=0)
        by mail.oetec.com (8.15.2/8.15.2/Debian-8) with ESMTPSA id 03N09kgn006385
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 22 Apr 2020 20:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=blastwave.org;
        s=default; t=1587600588;
        bh=zoHJNbR9W3TQIlQLjOPIyiOSpPnC3X34MPVkPRhjoH4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dVOZV6+7X8liw6ZJ0VO4l70U4AiSGEz64S1gh1U/4WkzYTWFP5Z554w2r/svUE7CK
         6LShvh1Ujt+RcQwag+hfbTR/ZOn6vJrgrPpZz4dPFC+OsJUuiV9MyfP+cypZBs4gpY
         WscdWgcSOlkRAk9CXFJMPoX9MgizvV3X2qgjBvbwQrMB8BZxd7pZ+Vl4o4IeEqbVj5
         jFEyQkhixJ0JSgr36q/BGORHUMDf0cuqVWsOB7JOZAdQ6RcWF3/vbLHrOV0n227naE
         u2yjOYYmgAhtgd2Uwv34M98dliAke12Zz727RmV/DBF0iK0qX4PImsHK+hIZ6Cq55x
         a5wzkrAHiLk9Q==
Subject: Re: minor patch required to compile git 2.26.1 on Oracle Solaris 10
 with Oracle Studio
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeffrey Walton <noloader@gmail.com>, git@vger.kernel.org
References: <6bf94982-71c4-78e9-0f4d-7fa4e485c417@blastwave.org>
 <xmqqzhb8rqa6.fsf@gitster.c.googlers.com>
 <20200422080950.GA464427@coredump.intra.peff.net>
 <20200422081156.GB464427@coredump.intra.peff.net>
From:   Dennis Clarke <dclarke@blastwave.org>
Message-ID: <f0beedfb-b50b-51b9-d996-155e0178a90d@blastwave.org>
Date:   Wed, 22 Apr 2020 20:09:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:74.0) Gecko/20100101
 Thunderbird/74.0
MIME-Version: 1.0
In-Reply-To: <20200422081156.GB464427@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-22 04:11, Jeff King wrote:
> On Wed, Apr 22, 2020 at 04:09:50AM -0400, Jeff King wrote:
> 
>> Which implies that NO_INET_NTOP should not be set in the first place.
>> I think this is the same issue discussed in:
>>
>>    https://lore.kernel.org/git/CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com/
>>
>> with a patch (which needs at least a signoff added) in:
>>
>>    https://lore.kernel.org/git/CAH8yC8kaWXbN+RYMJnM9em7KKW54+N07JtyS1MZk0qppD=m2BA@mail.gmail.com/
>>
>> Dennis, does building with:
>>
>>    make NO_INET_NTOP= NO_INET_PTON=
>>

I will give that a try today and see what happens. There seems to be a 
2.26.2 release from yesterday and may as well get that going. What was 
the changelog reason for the bump from 2.26.1 to 2.26.2 ?

Dennis


