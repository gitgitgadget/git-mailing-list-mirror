Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D768C3B1A4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CA22067D
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 17:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDFkZ/hw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbgBNRFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:05:19 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46966 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388935AbgBNRFS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 12:05:18 -0500
Received: by mail-qk1-f195.google.com with SMTP id u124so9346048qkh.13
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 09:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Rz/m0NRQLLxy4SpOaWtzWgBWxqvOED+8yRu2kPvMkpY=;
        b=HDFkZ/hwFfw8hQeNz/pZDhIEpvrMUG/O4/BwkDE+LPtsvknIj3FfmDbLUQ11gs79KS
         Fvz44D2/81AmvqUA8XAfTiln3kS5K6vKNiX8dlk0+hPoOuY1H/imTESkGdj5N1iq6pgn
         wkZMQr88AQePonfH5ry2LsUPJBYbc8y06spKFT5FOFePpQ9QpVTgDFnLLB4qAk36qnxv
         7rsjGD4tCYiL0bQbHrzLO3uLdffB/H8dhsgsdLC6ywK57bcqjWQpG1UBv1r6XS6pmeI1
         gheLJqtnMlKltPejsyQtNMratgyPO4pqw9hkYeLmAdGjJ8cK0ZPeLC6qwrv00OfSrCd+
         LJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Rz/m0NRQLLxy4SpOaWtzWgBWxqvOED+8yRu2kPvMkpY=;
        b=Rg53p0yU1GGJclUrN1PCLLXsgX3dpVyRHMsQT+LHBPyBRxyLWyywp2LFwZ5HX/xkWN
         PQjfUWyBhuiDyLjVHKOaIUNDL7QMuK0ZPHYmWlriDMMfIBR2hOSeRG3LrOdcyyTPScVy
         mwZqUgr6/gt+sj/dUpQncHHvEboBfgPGjjj60lS7bVRwfAddhfxOP9K7fF1vy/wh8fyh
         avWZf/8zuBS/6k/VrERpbbtAPh8K8c1SX51rkiu4Ov8rVnwKGkmbd1U9R43uvfAz2406
         CHfSikC6IuHxhmB7S9YdzFQXRZnBgkb4IECaYJhtG3ZrbUbUOgwN9CCnFc6e4IJfP6pr
         XxcQ==
X-Gm-Message-State: APjAAAWjpdRGUloEZ/WV78/3TQN5PeeYDgmbRXsEFw0DdCze0ji9iTI2
        3Xm3PeGk6maql0eqDuvk6Mj7rIcHAt8NQQ==
X-Google-Smtp-Source: APXvYqzpXpHLHDmU9FpTR/g4VgwWGrmnjVHO8K2Q5i3RHwnVig9zvpSv2CvWvwK6wT9Qcmu0xDhAfw==
X-Received: by 2002:ae9:c316:: with SMTP id n22mr3393012qkg.72.1581699917118;
        Fri, 14 Feb 2020 09:05:17 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id x4sm3540712qkx.33.2020.02.14.09.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 09:05:16 -0800 (PST)
Subject: Re: yz/p4-py3, was Re: What's cooking in git.git (Feb 2020, #03; Wed,
 12)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Yang Zhao <yang.zhao@skyboxlabs.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Han-Wen Nienhuys <hanwen@google.com>
References: <xmqqo8u3tqly.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2002131401130.46@tvgsbejvaqbjf.bet>
 <xmqq7e0qtqsm.fsf@gitster-ct.c.googlers.com>
 <xmqqk14qqj7n.fsf@gitster-ct.c.googlers.com>
 <xmqqtv3tpzto.fsf@gitster-ct.c.googlers.com>
 <20200214051505.GA16130@generichostname>
 <7fc48fbe-4cf4-7a0a-22f6-eac9692abc9b@gmail.com>
 <xmqq8sl5p0hf.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <9d1d3f2e-fef2-bcba-8065-c33ff6c5c0c3@gmail.com>
Date:   Fri, 14 Feb 2020 12:05:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqq8sl5p0hf.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 2/14/2020 12:01 PM, Junio C Hamano wrote:
> Ben Keene <seraphire@gmail.com> writes:
>
>> On 2/14/2020 12:15 AM, Denton Liu wrote:
>>> This change comes from 'git-p4: restructure code in submit' in
>>> 'bk/p4-pre-edit-changelist' which introduced the use of the `<>`
>>> operator. In Python 2, this is valid but in Python 3, it was removed.
>>>
>>> We can simply replace the `<>` with `!=` which is the new way of
>>> writing "not equals".
>> Absolutely. I'm committing the change now.
> Thanks.
>
> I didn't mean that the use of <> was the only bug in 'pu' wrt Python
> 3.  I see you sent a new round out, but has it been tested under
> Python 3 already?  Just checking to set my expectation right.
I have not been able to test my changes under Py3. Unfortunately I
don't have the bandwidth at present to incorporate Yang's code into
this code for testing. I've been having to work with Python 2 at
present and using my changes locally.  I have tried to not use Python2
only code, but cross compatible code but I'm not sure what other
errors might be present.

I'm fine if this needs to stay pending until Yang is complete and
I can then retest with the new code.
