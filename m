Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2F3C432C0
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F36CB2073C
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 15:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWxHRxIm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLCP75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:59:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40794 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfLCP74 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 10:59:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id a137so3895636qkc.7
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VtabGFU7balLi2262aPxZnqprs5zEaNJjhFQnaJyrZI=;
        b=KWxHRxIm9bScRCzVykq5nlQgthurpC2kjd54bkGByUGJtVZ+sn/LDgdNQGpWI9Mqic
         1z46Bqf++/2SN77K7miopC0p6vW2cqDlB3DnZMXjBkhUelcavUOPPmXX8R1UO2QYJzSd
         9Du+RL7hLSThNbI7wL1K7ipE5MQMNpmUkwGrPw6dizyHQ3f5WmZZ9yPqGeK7gNGAuUy6
         4ZztEBqMDX7FASeFTly8tWpQn2d/lYtXLWpQ+MoeLWzbur1Bjx+SEtYOBAQTfquxpEbH
         +oDqbJFhFOv0cc+2KOIqFxBqqSxTkdCSXG7HGoGqyhkQFhLGTA6K1U78zbgR3suqvkNL
         Up9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VtabGFU7balLi2262aPxZnqprs5zEaNJjhFQnaJyrZI=;
        b=eGswqRQ0Wmin2Y3t+8REHHiqKEBnNxak/rm7rHGNS+z3pvF+ps0l+K5LFfJ7bEiy89
         hf+fEX+dK7BP2Mw3Qhqq3KGDP29+euHuuoYDt3IescTXeXEgBuIW5VOsahquW9a5F18y
         crsgxigRN39dQpde88VK6Q4LbTKO2E6nSGjf9Ccqf8ra3UZkB8NutvPowuySS4mFq+3X
         Hlen9hhLhJ3Aaolzo4oXST93kAWExlgOYLpqnRNc57ED5rOiC0fJcjWbzFTb8NTU1gMI
         gCP5ZQk7IIrbNoJcoNg36lQLWyy4XUvoghcvVpQ9/FbObG4eiegNdGMgTdpqCcc+TBgS
         /ENw==
X-Gm-Message-State: APjAAAWBv/MNARbmYw3lNMdHDZmvYn17g4nq2e/xdYwfksoTjP4SLWgn
        yZoLP5iP//ZTeAduNW+pWKWqnIKT
X-Google-Smtp-Source: APXvYqwj2t4bpjk4wFPdA6sgI87Ooo7E5uULjQEw2xPidnFvcnAQkejjPlWgDKL3o+55NWGb1512Hg==
X-Received: by 2002:a37:bf83:: with SMTP id p125mr5872600qkf.165.1575388795686;
        Tue, 03 Dec 2019 07:59:55 -0800 (PST)
Received: from [10.10.31.126] ([24.229.121.34])
        by smtp.gmail.com with ESMTPSA id 206sm1913638qkf.132.2019.12.03.07.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2019 07:59:55 -0800 (PST)
Subject: Re: [PATCH v2 0/3] Feature: New Variable git-p4.p4program
To:     Junio C Hamano <gitster@pobox.com>,
        Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
 <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
 <xmqqd0ds5ysq.fsf@gitster-ct.c.googlers.com>
 <xmqqeey63ryq.fsf@gitster-ct.c.googlers.com>
From:   Ben Keene <seraphire@gmail.com>
Message-ID: <8b1329db-edd7-496f-1328-7cd249b19451@gmail.com>
Date:   Tue, 3 Dec 2019 10:59:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqeey63ryq.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 11/17/2019 8:15 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> As to individual patches, our local (read: project specific)
>> convention around here is to state the are the patch touches (in the
>> case of these patches, "git-p4" is the appropriate area name), colon,
>> and then a one-line summary of what the step is about (the last one
>> is done without initial capitalization).  The summary is written with
>> the focus more on why and what than how.
>
> Sorry for a late typofix.  "to state the AREA the patch touches" was
> what I meant.  So I would expect all patches to this file (which is
> the only component of 'git-p4' subsystem) to begin with "git-p4: "
> prefix.
>
> Thanks.
I was having email trouble trying to reply to your suggestions. 
(Downloaded yet another mail client, and this seems to work)  I'll make 
those changes.
