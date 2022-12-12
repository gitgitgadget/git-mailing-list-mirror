Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B442C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 14:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiLLOFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiLLOFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 09:05:14 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92408E007
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:05:13 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g7so8986583qts.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 06:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2KktVcsimnt9dd0kpHh2ibB30491gUozD4soSnQRPp8=;
        b=YobybEfQp4DncqoG58UF4CDVWLPFju+lPbKRJAOFoxQMKbCyppJgVJi5CnkRhDrnLP
         nmPzmklYEYRFcgfDbh9PqeWRuYVhBBdhYsXyKmCSwUE4S0gfpklUy3yuCPx58txhFdsE
         GDKCft4vSZ1Y3Ou0y5nSV3tEAMTXoCFt7D+D6R+2dnIZdEqFAEDEgOBaYLVrdQVqrgpQ
         mvW/FNe28T6SRnR6BDJuz0+TnnPVJyWCmmB0+wAZz/8uUAvmzLLe87TYCDit2rp/nQqZ
         hx2wagN5ypRYLlu0F0YSqmajLXARjDKTttc5hyS9AajeW2L/B2VJ+W6f2f+0BNHkVowu
         lREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2KktVcsimnt9dd0kpHh2ibB30491gUozD4soSnQRPp8=;
        b=x97gypx978fk2I6+IqrotjBzKBVm2RZbZKvS6F8xOnbnKzYY500UVaXc/sUnj2hyZC
         82RgrUq3UvI4Ts54NUg53rGcTvEPcs7VTM7+0XCbQOvDoWLn4FHcfxyZC3j+7EgIyjLA
         g5jb+FoRb85KK1SLh+yDqDaCkZaQ97gM8A7yk0bAdLz7fvebWJwqGoWDl+Vr4kAt2SnO
         xxw4AomPfL4v+0164qWXD2sOqVxmK8tHRRwRxuMsJ0OSDrYR29uKvO2QAU3HmQEaPU7x
         AUKNX2WZyXKQMKWrdxlCsdxcZMs/P2SSBPnv4yOzjgnCdzm4CUi8zhVGLFCTUr2eJ/bB
         bg7g==
X-Gm-Message-State: ANoB5pnw/OHLxc9t/jOghURd9iayAXZrMMmv/8oOoAQlfSQsXfufdG1F
        6DbmC3UcrVxSHtYdYUwH7Mua
X-Google-Smtp-Source: AA0mqf5Hh0Z05YgJ6/W1iV4UozC4dezDDGOjfnbyldQe4cXNSsrZHAnmviMZSR8sT7OknMVecqvpPw==
X-Received: by 2002:ac8:47da:0:b0:3a8:661:251 with SMTP id d26-20020ac847da000000b003a806610251mr17046732qtr.64.1670853912669;
        Mon, 12 Dec 2022 06:05:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:84c8:9ef9:1297:e16e? ([2600:1700:e72:80a0:84c8:9ef9:1297:e16e])
        by smtp.gmail.com with ESMTPSA id u7-20020a05620a0c4700b006fc8fc061f7sm5810593qki.129.2022.12.12.06.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 06:05:12 -0800 (PST)
Message-ID: <5301dfa1-71c9-1ff4-6ba0-e37f25e8ef62@github.com>
Date:   Mon, 12 Dec 2022 09:05:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/4] read-cache: add index.skipHash config option
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        newren@gmail.com
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
 <5fb4b5a36ac806f3ee07a614bcb93df2c430507c.1670433958.git.gitgitgadget@gmail.com>
 <221208.86mt7y946t.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221208.86mt7y946t.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/7/2022 6:06 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Dec 07 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> While older Git versions will not recognize the null hash as a special
>> case, the file format itself is still being met in terms of its
>> structure. Using this null hash will still allow Git operations to
>> function across older versions.
> 
> That's good news, but...
> 
>> The one exception is 'git fsck' which checks the hash of the index file.
>> This used to be a check on every index read, but was split out to just
>> the index in a33fc72fe91 (read-cache: force_verify_index_checksum,
>> 2017-04-14).
> 
> ...uh, what?
> 
> Is there an implied claim here that versions before v2.13.0 don't count
> as "older versions"?
> 
> I.e. doesn't v2.12.0 hard fail the verification for all index writing?
> It's only after v2.13.0 that we do it only for the fsck.
> 
> That seems like a rather significant caveat that we should be noting
> prominently in the docs added in 4/4.

I can add those details.
 
>> As a quick comparison, I tested 'git update-index --force-write' with
>> and without index.computeHash=false on a copy of the Linux kernel
>> repository.
> 
> It took me a bit to see why I was failing to reproduce this, before
> finding that it's because you mention index.computeHash here, but it's
> index.skipHash now.
>>
>> Benchmark 1: with hash
>>   Time (mean ± σ):      46.3 ms ±  13.8 ms    [User: 34.3 ms, System: 11.9 ms]
>>   Range (min … max):    34.3 ms …  79.1 ms    82 runs
>>
>> Benchmark 2: without hash
>>   Time (mean ± σ):      26.0 ms ±   7.9 ms    [User: 11.8 ms, System: 14.2 ms]
>>   Range (min … max):    16.3 ms …  42.0 ms    69 runs
>>
>> Summary
>>   'without hash' ran
>>     1.78 ± 0.76 times faster than 'with hash'
> 
> I suggested in
> https://lore.kernel.org/git/221207.868rjiam86.gmgdl@evledraar.gmail.com/
> earlier to benchmark this against not-sha1collisiondetection.

Generally, I'm avoiding that benchmark because sha1dc is here to stay.

If users want to go through the trouble of compiling to use the non-dc
version, then I would expect the difference to be less noticeable, but
still significant. However, I would strongly avoid considering compiling
both into the client by default, letting certain paths use sha1dc and
others using non-dc. Certain secure environments currently only use Git
under exceptions that allow SHA1 for "non-cryptographic" reasons, but
also with the understanding that sha1dc is used as a safety measure.
Adding the non-dc version back in would put that understanding at risk.

Thanks,
-Stolee
