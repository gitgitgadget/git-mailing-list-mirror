Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E4CC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E627124677
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 21:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uhuckyLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLGV1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 16:27:31 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:41844 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfLGV1b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 16:27:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id g15so9679711qka.8
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ib9PdC4R8qhHw8XF3sA6nEWNi7PpzcKWqMcTi5QJ064=;
        b=uhuckyLm1e2+i7HX+PugQl59rkiuej7al6oGT+9aINmE4SKnCP0TVn8RHq6iSkphHA
         Z9r62t8sKSNpAwYXHrkBo6ABChHQkq4vXzF0vnwwRUwMiR+39AOxpRPVN7A2v86YHfHj
         LwORKpYwmIwdkQPPaAHHtUxp1vCH1AK43is1LxgU48orRW26mdU2A+NM46P+Im0vV2s0
         yLLpSHMNY8FLng+TZ/eTTTip4IBQU96el1EYRAHw/78YwTukLIKuMHuNomTJgfqzFP4y
         /0XoNQdyKNwHS7ZWhPjm50eofdTiwJX0x8VRNPcJTpjhF72Zp6416ho9q0gfrwpqP4hR
         l+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ib9PdC4R8qhHw8XF3sA6nEWNi7PpzcKWqMcTi5QJ064=;
        b=Ch9kEXEIBFLjA60JNGeeT5BfdG1xELDVVxofMiKTPVHhx1LUmORgTRrr2WNEwOyUtc
         xmE/w4xGQbAn/dyM1k2i3v6iLKeA1GVU0HbJoJXdZJTuM6pwlt60urmZTdLuObNzjgpq
         nlGxkBA7uMxdTMRnskvX86TKhnCEFCDnGtFBpgP9KrPfvnCWctzenjhECrkHbZdHc/0/
         AP1F+kBwwdejsupJk2EazbJ0/6kL/EJSvTaKlPh39r9U5RnQot5vRRPzl3htK+f07YnD
         ZiNccf+JpqRsI+yZYTro6sW+SBrrdjdFi5Hao8A1xNd7Xvukwd/tSbIuwMoaXkIYw025
         3EpA==
X-Gm-Message-State: APjAAAUqJpAdIqjfXBa8+yS09yZfM1lwcn5EIDTzZS41D63ALFN4KQ/r
        bgDmFWnmtO8gIwXhvrwzRRc=
X-Google-Smtp-Source: APXvYqyVKYeGBb94mYOKFEHX+X62fRMYypZV4qUYkPG3UmhiKF6leUO5pz5IQ4ezyNUGd466E1TY4A==
X-Received: by 2002:a37:4d45:: with SMTP id a66mr21139827qkb.65.1575754050559;
        Sat, 07 Dec 2019 13:27:30 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id p14sm7633203qtq.97.2019.12.07.13.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Dec 2019 13:27:29 -0800 (PST)
Subject: Re: [PATCH v5 00/15] git-p4.py: Cast byte strings to unicode strings
 in python3
To:     Jeff King <peff@peff.net>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
 <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
 <20191207194756.GA43949@coredump.intra.peff.net>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <95ead4b6-21bb-1aa2-f16f-888e61a4e4c0@gmail.com>
Date:   Sat, 7 Dec 2019 16:27:29 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191207194756.GA43949@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes indeed!

I hadn't pulled before I attempted the rebase, and got bit.  Yes those 
shouldn't be there!

On 12/7/2019 2:47 PM, Jeff King wrote:
> On Sat, Dec 07, 2019 at 05:47:28PM +0000, Ben Keene via GitGitGadget wrote:
>
>> Ben Keene (13):
>>    git-p4: select P4 binary by operating-system
>>    git-p4: change the expansion test from basestring to list
>>    git-p4: promote encodeWithUTF8() to a global function
>>    git-p4: remove p4_write_pipe() and write_pipe() return values
>>    git-p4: add new support function gitConfigSet()
>>    git-p4: add casting helper functions for python 3 conversion
>>    git-p4: python 3 syntax changes
>>    git-p4: fix assumed path separators to be more Windows friendly
>>    git-p4: add Py23File() - helper class for stream writing
>>    git-p4: p4CmdList - support Unicode encoding
>>    git-p4: support Python 3 for basic P4 clone, sync, and submit (t9800)
>>    git-p4: added --encoding parameter to p4 clone
>>    git-p4: Add depot manipulation functions
>>
>> Jeff King (2):
>>    t/gitweb-lib.sh: drop confusing quotes
>>    t/gitweb-lib.sh: set $REQUEST_URI
> Hmm, looks like rebasing leftovers. :) I think we can probably drop
> these first two?
>
> -Peff
