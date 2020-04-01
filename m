Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D8BC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 13:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B9D2077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 13:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ST1D2a/6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732651AbgDAN1m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:27:42 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39008 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732587AbgDAN1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 09:27:42 -0400
Received: by mail-qt1-f169.google.com with SMTP id f20so21561170qtq.6
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Hu36oE0j6LKg07sohlr0Sj5bZjl/cw2nWqjFeWlR3c=;
        b=ST1D2a/6Tcxa7+Wuz/NC/J63Ta95B43dpE+So4tnP1LoYpxvhl5njmewcj3ETDiGKW
         ZGDSmnAgxt83mmg3b6pJtK7ocvdBgJM9wD8CIPII6+diuarW0ofr25loDP1KSf2NOAwT
         nyKw1vLcY5HEufvG9qSUjExBwyZtUZ3wtBKMrNrZONfJ3wLAoZ6KJ3IAvYkMtSJBIPEs
         VdjB7l6tYl64nfRjNbm14w/gm1zNxoAvQb4M0DqC5uj3Jz3DDkzqRvqvVKbSxg9sjux+
         Bf1PpCkUJMExcA8qze45Q0xs2IEOoh9KaRFWFlH//1PNZxK6PRB1oSFZsvZZayPJyfwH
         lr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Hu36oE0j6LKg07sohlr0Sj5bZjl/cw2nWqjFeWlR3c=;
        b=b0TOILSX6ufKiPSqOQUeyxNaYEQ202Y2Vz4wkrlDkyqu7aN5DK7eCKs5aoKLjHjo0P
         xCoqjPZWt/Vg0GmWsCrL62ojFmKQsem9re4+0FxFdq61eXpEihASs45GFPqJMP2w9Zix
         L1fCOeMckmrtDqFlfDcKy7vol16dHeOcMWw+gd2nIPSP86Mc9R8p+gY4Js3GhgRm/2YN
         YQvH5zNErpp9UNf+trOd7NAOKr0q27Dbaqbeei2jl+R1O5kMgJZ+LNeYJ5hsPxW2+oco
         BPwljKgcT/W1Sh4IPCsTHTnwF7Iqh68Y9irUOyBfnUz3b/vVTr3c1R9dZLlvH83EDYQu
         Gvdg==
X-Gm-Message-State: ANhLgQ2e/7W25vfQYtkJ8bmIt+4u7lSzn1Kfk7MUSycdHo6VL919CAee
        mbfAN179uxs4TGgROfLAAS21QAEJSzQ=
X-Google-Smtp-Source: ADFU+vttvfjzU1z7f71pNFhXZGe/uKElVuc599LewAQI2YKbFf+DyHD750b2+74zjs/0aXMXAk76UA==
X-Received: by 2002:aed:2499:: with SMTP id t25mr10600971qtc.127.1585747660768;
        Wed, 01 Apr 2020 06:27:40 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id o81sm1415495qke.24.2020.04.01.06.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 06:27:39 -0700 (PDT)
Subject: Re: Git Test Coverage Report (March 31, 2020)
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <e7e15fd8-01fa-61df-830d-04e4882adc38@gmail.com>
 <20200401095635.GB60227@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <064fe1c7-3c93-fd82-ad78-92f800713462@gmail.com>
Date:   Wed, 1 Apr 2020 09:27:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200401095635.GB60227@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/1/2020 5:56 AM, Jeff King wrote:
> On Tue, Mar 31, 2020 at 09:58:17PM -0400, Derrick Stolee wrote:
> 
>> Uncovered code in 'jch' not in 'next'
>> --------------------------------------------------------
>> [...]
>> Jeff King	16ddcd40 sha1_array: let callbacks interrupt iteration
>> oid-array.c
>> 16ddcd40 76) return ret;
> 
> Hmm, that commit is from 2016. I guess it was triggered now because I
> renamed sha1-array.c to oid-array.c recently. I'm not sure what the
> right thing is here. Following the movement via blames a long-ago commit
> (I just happen to be the author of both in this case). But not following
> the movement means that my rename would get blamed for code that isn't
> actually new.

Interesting. The test-coverage tool is checking blame after checking a
diff, so the two are not as linked as they could be. The diff tries to
find all modified lines in the files that were updated, and filters the
blame output based on those. I suspect this will happen whenever we
rename a file.

The "real" fix would be to filter out the blame lines for commits that
don't actually fit in the commit range we are considering.

Thanks for looking closely!

-Stolee
