Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4AC433F5
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 07:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiACHx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 02:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiACHx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 02:53:56 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4EC061761
        for <git@vger.kernel.org>; Sun,  2 Jan 2022 23:53:55 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id b13so132764270edd.8
        for <git@vger.kernel.org>; Sun, 02 Jan 2022 23:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=hBSjBI7kNRnIQ5BfaKBoipcx673+A9EDdznqEbPd4FU=;
        b=OslApON8NL1sscDdGnJK9bob6sqgvD9TRq+Jh8JQB8GrH+jDpvzy8iqGBVQTRwUUAo
         OKZkA3T2mK0cdNW1wFXRK3mFvIVSqitln3gaHAUIBW9LjvQytD4fid0qkue/rdC0qNZz
         kyZJqcbz826vrvkhIh8CZ0INaxGreEIfvn2+exb9Lb/P8jIU4nkHvtZAmVW800cHqYc3
         sJirfMnwqzOz6romYy4DiqBR1uiiswzLJbU6B/sagM2nlOjlQLaJ/E7UUjpAt2kLGsSB
         ANLSWMJ5OGiEDh5ONTSzdeCqcnPBYXPTdo8Aq9tk1N4PDPL/H20miEKlB0dZWTC+FCiu
         1snQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=hBSjBI7kNRnIQ5BfaKBoipcx673+A9EDdznqEbPd4FU=;
        b=VyxYOvrUoEqXNthxPMX6B+ORXAJsiO4X2kGcRoWpFO2B2+Yprk7WNBNrLR0CwqISe+
         7HadVlJN+RFl1S3AJOQDS+iQm7jxQdfKSJ8Awb1fK6HfvgBodXKq23IhYlNaiSDN4uCk
         LDwS2PXcfJHBDKtld0ANqpJALukBm0/tgtTRkiQP8L3RqpSxXvjJvi44SBl8svA4cq77
         hL7cvp3/mpP5z6CC7SGUQoWKecQWwX4pPpvHj7FQ2a7wSeeUApqELudb1pbYLwH4iw/u
         yJf3DRksgPCwHrVv6Hek8jU63SpY8zQshAKCzVy1Mfk1MpgL2zet6gtlWRMILAXK86Ih
         i8Jw==
X-Gm-Message-State: AOAM530RuUsb0gKQNhftxlkYNTYvWMPgjbqT16ha5smFMPZ0s9lvExFa
        KuZqJG59Z3/jfl3rkp11l6fbSjdM+h8=
X-Google-Smtp-Source: ABdhPJxSCokTleoh77AX2WQu/pS/okW96+Cav794d/SE/wpE3I4fxg7S9ECFaduFWgRXL9CIQU4kjg==
X-Received: by 2002:a17:906:c109:: with SMTP id do9mr35108408ejc.111.1641196434328;
        Sun, 02 Jan 2022 23:53:54 -0800 (PST)
Received: from [192.168.1.6] (ip-193-121-17-144.dsl.scarlet.be. [193.121.17.144])
        by smtp.gmail.com with ESMTPSA id lb10sm4273687ejc.148.2022.01.02.23.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jan 2022 23:53:54 -0800 (PST)
Message-ID: <e3e2cf38-31e0-7b3e-af79-88226dcdabe5@gmail.com>
Date:   Mon, 3 Jan 2022 08:53:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
From:   Nick Gearls <nickgearls@gmail.com>
Subject: Re: Git Diff feature request
Reply-To: nickgearls@gmail.com
To:     Erik Cervin Edin <erik@cervined.in>, rsbecker@nexbridge.com
Cc:     git@vger.kernel.org
References: <52591f5d-d4b5-90ea-e84e-32b99803a3e6@gmail.com>
 <00dd01d7fd78$7e69e150$7b3da3f0$@nexbridge.com>
 <CA+JQ7M_tQG4yzSeHjZxPWuWEOM=iSLrWxojQGcpL9E7FcoXLRg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+JQ7M_tQG4yzSeHjZxPWuWEOM=iSLrWxojQGcpL9E7FcoXLRg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When you want to compare 2 versions of a repo you don't own, you don't 
have the option to apply a formatting standard ...

On 31-12-2021 12:15, Erik Cervin Edin wrote:
> On Fri, Dec 31, 2021 at 11:23 AM<rsbecker@nexbridge.com>  wrote:
>> One interesting technique I have seen used is to set up a pre-commit hook and/or clean filter to format code according to corporate/team standards. Reprocessing code prior to the commit would allow a normalization of coding standards and removing of EOL or space/tab concerns.
>> ...
>> We use a similar technique (enforced only by policy right now, not a hook), which is to require code to run through standard IDE source formatting. Improperly formatted code hitting pull requests gets a decline until the code is properly formatted.
> I agree with Randall, the easiest solution is to adhere to a formatting standard

