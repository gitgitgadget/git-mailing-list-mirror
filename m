Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E88E1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 11:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeJPTDC (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 15:03:02 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36603 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeJPTDB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 15:03:01 -0400
Received: by mail-qk1-f195.google.com with SMTP id a85-v6so13802159qkg.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 04:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=064Pi96G0QYtBpcOPnJlrdwcqbdUNtPu38TSQjZp2Vg=;
        b=uj1e1U9eoHJFNrdh2s0hx5kruwjJh4iINNBqlggM/X+p2VPvn/ilD+U+dn6sMe1Pdw
         4l15bLqmqbXQlCn93/ccSLtYqTG1hTppo0b4VyPYQ+UsbjMH1PqlJtikKyHXv/K+XGKj
         AKDUzXFMPGgCOksw06JRwm7LvnhwXLIsd5uC55VNq9v6Z2NPqkpLee/irx4kxffLRd/3
         yJ/bp/3Z5Ksg/Py5XZ2AivismfHMe4Q0W6e2AJfiEjsccu9/ZM+Q6viVb5XaTTVn1fNG
         J3FwnXO/2jPSznyMgpNoRZ7SNAhz4RsyDfr06oquLugGGrevt+/n/AcCGIwX8ARhNN6l
         DEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=064Pi96G0QYtBpcOPnJlrdwcqbdUNtPu38TSQjZp2Vg=;
        b=lUzAjqZEw2JafpiBAJsPqSkap4h0Yqa/DrraWhGhHUC2SG2VJGiqm/fmOfSkUmYkaB
         V9b+W8dzxKQQg7A34bF8YIu5jhb/IK1Oa9VKtl08OJn/ypm74An2hKVW2GL9K/D4m2dK
         7h/oR6gbluclrPA+/gEcPvbU06XtK4lEY/3KiLPdBtDSxmXmB/bVnT/aI1g3eiKqy52U
         JFI9pqVjGyte+O3oXbRqM4+Toi8dO5o8G3Xig2hhNdUtPab3FO9Cim4Wx0nKFYteqctt
         7Axn38dA+2O8amaAh4aC1ipXSRKFKs6y4TkvhE0f4Fla+0cL1Ih4WhiPRGa4ulq3g4Aa
         SbLw==
X-Gm-Message-State: ABuFfohSw7DDudUEONSgsQr8x1i9f9V73FnGJbh1AdAzIeTK0Cjl73Rm
        7iNCqtzU28pYhTiUKZOMF9U=
X-Google-Smtp-Source: ACcGV60dqdDtJMkoV9g/iZ2l2nYJlL+imEDfUKsPQXbDZ15NMDYy/s7HjW9af9Ir2+es77ZmMmhTdA==
X-Received: by 2002:a37:6204:: with SMTP id w4-v6mr20203256qkb.258.1539688384960;
        Tue, 16 Oct 2018 04:13:04 -0700 (PDT)
Received: from [10.0.1.17] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id i2-v6sm7465674qkf.42.2018.10.16.04.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 04:13:04 -0700 (PDT)
Subject: Re: [PATCH 0/4] Bloom filter experiment
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
 <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
 <xmqqlg6y1ovh.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8c66cbe3-6830-05cb-f3bb-be2e4902e8f5@gmail.com>
Date:   Tue, 16 Oct 2018 07:13:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqlg6y1ovh.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/16/2018 12:45 AM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> 2. The filters are sized according to the number of changes in each
>> commit, with a minimum of one 64-bit word.
>> ...
>> 6. When we compute the Bloom filters, we don't store a filter for
>> commits whose first-parent diff has more than 512 paths.
> Just being curious but was 512 taken out of thin air or is there
> some math behind it, e.g. to limit false positive rate down to
> certain threshold?  With a wide-enough bitset, you could store
> arbitrary large number of paths with low enough false positive, I
> guess, but is there a point where there is too many paths in the
> change that gives us diminishing returns and not worth having a
> filter in the first place?
512 is somewhat arbitrary, but having a maximum size is not.
> In a normal source-code-control context, the set of paths modified
> by any single commit ought to be a small subset of the entire paths,
> and whole-tree changes ought to be fairly rare.  In a project for
> which that assumption does not hold, it might help to have a
> negative bloom filter (i.e. "git log -- A" asks "does the commit
> modify A?" and the filter would say "we know it does not, because we
> threw all the paths that are not touched to the bloom filter"), but
> I think that would optimize for a wrong case.

A commit with many changed paths is very rare. The 512 I picked above is 
enough to cover 99% of commits in each of the repos I sampled when first 
investigating Bloom filters.

When a Bloom filter response says "maybe yes" (in our case, "maybe not 
TREESAME"), then we need to verify that it is correct. In the extreme 
case that every path is changed, then the Bloom filter does nothing but 
add extra work.

These extreme cases are also not unprecedented: in our Azure Repos 
codebase, we were using core.autocrlf  to smudge CRLFs to LFs, but when 
it was time to dogfood VFS for Git, we needed to turn off the smudge 
filter. So, there is one commit that converts every LF to a CRLF in 
every text file. Storing a Bloom filter for those ~250,000 entries would 
take ~256KB for essentially no value. By not storing a filter for this 
commit, we go immediately to the regular TREESAME check, which would 
happen for most pathspecs.

This is all to say: having a maximum size is good. 512 is big enough to 
cover _most_ commits, but not so big that we may store _really_ big filters.

Thanks,
-Stolee

