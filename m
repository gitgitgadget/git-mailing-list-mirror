Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42B0820248
	for <e@80x24.org>; Thu, 18 Apr 2019 09:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbfDRJOg (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Apr 2019 05:14:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42640 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfDRJOf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Apr 2019 05:14:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so2017070wrx.9
        for <git@vger.kernel.org>; Thu, 18 Apr 2019 02:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M7u6MP/gUDWMF6P3O6C/gI1VujgwwOdzQzc3+HVRmFA=;
        b=Z5QlHuiFj3QaLEuWsgoIAK0C5XiX6b+G8znJf/qdomhiHmSlyycq4GjhRKVSJN3iAD
         CjFPokAgzNDYNzJFV0amk7n5zBMmbskxsoarFIHUxHPmzSjdVvZDFC0ARjdyYI7Zq78X
         yP2Dq0p78HBMK+aF6kLqq3TcTpdjcC+bMftGoTLPQvZXHMRVs/PYMC58AhLlbf57nAQT
         uiLmHK1Wil+Dk/G3ClaxX+XudSwI3t1WmSZYe6CkiKeP2PVCFrUojf8cTiycyp9iDRoT
         vBtcr37MwBqDUEWi7p9KiY1yZ+uTuAmqrD7VVGzFkmQM9uKb8sPx+4OX1JVW2zzdSG59
         aCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=M7u6MP/gUDWMF6P3O6C/gI1VujgwwOdzQzc3+HVRmFA=;
        b=K7uIyOWHVb1B1sYpxyFpD34e9bDgSBhEd1x7sbLRBN4uFYQ0LUkfiSV6PmJMd2blE1
         evE/Oz64kh4TboXt5bmAIyNvTuFKeB9pM1YxFeysz8077SD70cM2qsTcULn7R4geFx19
         VL+k+cwc+h6bAMfuPta6osI6hefiNn5e50BX3QAPvi4g5wvBoVpzBWzI9vxvqLpImJeS
         VjEJumRnXmZWisc0sRGJNdAxm+mHJR2hMcrwAnCVu+I3fWypPoGrUI05DyS44b+OC0pa
         BGlzhf7aPuOu3OO7em3c38RrkszoZ2A9dGrBPt0CIZPjVARgVlrSoo/9QZbj3phSt7eK
         IaMg==
X-Gm-Message-State: APjAAAVQXDNMh/5x1W9A8AEaiLDuxZ6WL0UTcMZmuyBPT9YeHCNqba68
        W5cfwjnLnj6ehNgnTHyEEOxaincfcJM=
X-Google-Smtp-Source: APXvYqwKw4o99EqnoRIH78wVSxVIX4j98rBirwEDkoVXvgU9KgDzvzmtX6chqQsVqTaotFpnjlTNMQ==
X-Received: by 2002:adf:dd8c:: with SMTP id x12mr30217259wrl.262.1555578874248;
        Thu, 18 Apr 2019 02:14:34 -0700 (PDT)
Received: from [192.168.2.240] (host-92-22-21-176.as13285.net. [92.22.21.176])
        by smtp.gmail.com with ESMTPSA id h84sm1337980wmf.15.2019.04.18.02.14.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 02:14:33 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v10 00/10] Fix scissors bug during conflict
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <cover.1553150827.git.liu.denton@gmail.com>
 <20190417102330.24434-1-phillip.wood123@gmail.com>
 <xmqqk1frhovr.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c37e44d1-d088-2088-148e-fb1ee022ac41@gmail.com>
Date:   Thu, 18 Apr 2019 10:14:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1frhovr.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/04/2019 06:19, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> With Denton's blessing I've rebased his patches on top of my patch to
>> fix the message cleanup with cherry-pick --signoff and -x [1]. I've

Note that the base is a merge of that patch (which is based on maint) 
with 041f5ea1cf ("The third batch", 2019-03-20)

>> [1] https://public-inbox.org/git/20190329110842.30604-1-phillip.wood123@gmail.com/
> 
> Hmph, I certainly saw that patch, but I do not recall seeing any
> in-depth review of it.  How ready is it?  Was it because it was
> trivially obvious that we didn't see much activity on the patch?

I think it is ready (it's a fairly simple change). Dscho said he was 
happy with it [1].

[1] 
https://public-inbox.org/git/nycvar.QRO.7.76.6.1903291651340.41@tvgsbejvaqbjf.bet/

Best Wishes

Phillip
