Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8237C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7268620872
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 11:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ireXwaA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKULLA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 06:11:00 -0500
Received: from mail-qk1-f176.google.com ([209.85.222.176]:37971 "EHLO
        mail-qk1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbfKULLA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 06:11:00 -0500
Received: by mail-qk1-f176.google.com with SMTP id e2so2649328qkn.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 03:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yfun+WUVz2335ozRJvqPS5/2kijp1eXyZBtc9JLv9VQ=;
        b=ireXwaA/1zdlMfwKn3GFXDRcVx2nF2y4NGC0Mgz7vF9aG35gFHb/S/5nMQxUsMv+nZ
         gCa9N44ZZWKGGCFIDmq/aoysFE4K81dds/9tKT965EE/iHKNIx3zDxOPEh81SJtvd4c/
         PIFI04kiaNHyMBwDqU9ZUm9tvxK0AsUR5j1fd/1EL7KenRtKIEqB9cQEBHZCI/8IJYWZ
         KbTZhziGoLwFJ2OWOBoOzi4+vBBvBVEOd0HbE7oRa7pQWLYgEwHTJH8NVsbJ6QRa8DGU
         3TjORgSdPokwEgHw9QJUHuZIISWD6DHzmJCPwcIQk1zAawV0kid176z/sHy/cOBpzBlv
         Xbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yfun+WUVz2335ozRJvqPS5/2kijp1eXyZBtc9JLv9VQ=;
        b=BUSIoGyNbkSpoWtyL3JQgH+tbOS5Js7DwQI/HEe+WGgFoWtW+4qCHLWiK1fiuAvBQX
         0M/R3mO5oxlwWYT/tDCWV1f7N1+wV6RSwvxANhHElHz30nQuZwFfPq7HI8g7N0MGAZD0
         t17XRb7pyEHr5sT040OTZivuyAoriFuRPno4Vzni6ovTMhFYezHasS3FQUwCmA1jhvvn
         RVAVHmDwgjmvXzKPiJMqlgCq/0CoIXo2IWqvSB+h4ozshZOyeFT3/zLkSm1KgwC1Qy2J
         HxMrs3BHO8BIynjBIAyzJJaeLren21vX30OGYxGpPokVGXgCD24bp+G1AG3X6fRghFjh
         oAng==
X-Gm-Message-State: APjAAAXfrLDmoA4rISX9FMaK9HU5rPqedmzj7pNcKUgo7KgPFJ6aIUDL
        9cP3p56jSXK+t6gf99W86EgfhFfvqzA=
X-Google-Smtp-Source: APXvYqxcHNZ7hghukumWoW2YTOGzyncKXxP5S4sH4xXInNeX7ZyWfczUxalhBearBpm19cvNONP93Q==
X-Received: by 2002:a05:620a:1a:: with SMTP id j26mr7154328qki.150.1574334658750;
        Thu, 21 Nov 2019 03:10:58 -0800 (PST)
Received: from [10.0.1.19] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id a28sm1149505qkn.126.2019.11.21.03.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 03:10:58 -0800 (PST)
Subject: Re: What's cooking in git.git (Nov 2019, #03; Tue, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
References: <xmqqftikxs4z.fsf@gitster-ct.c.googlers.com>
 <20191119175850.GL23183@szeder.dev>
 <xmqqzhgrcksn.fsf@gitster-ct.c.googlers.com>
 <039f7668-53e3-9c6d-d813-ca412c4d1ed2@gmail.com>
 <xmqqy2wa9ibs.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <dc0bbc13-8204-c6b4-8d3b-db101027fe1c@gmail.com>
Date:   Thu, 21 Nov 2019 06:10:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:71.0) Gecko/20100101
 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2wa9ibs.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2019 7:36 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>>> OK.  I had an impression that it was something relatively easily
>>> patched to restore the plumbing behaviour without taking the
>>> remainder of the series with a follow-on work.  If it is not the
>>> case, perhaps I should revert the merge to 'next' and kick it back
>>> to 'pu'.
>>>
>>> Thanks for stopping me.
>>
>> That commit can be ejected from the series without affecting the
>> correctness of any of the other commits. That will require reverting
>> the merge at this point, though.
> 
> I've done the "reverting" part of everything, so that other patches
> that need further work, if any, can be given a fresh start.

I see that more feedback was given, so I'm working on a new version.

Thanks,
-Stolee

