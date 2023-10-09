Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD933CD6101
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 16:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377146AbjJIQWA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 12:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377100AbjJIQV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 12:21:58 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965C7A6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 09:21:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5ff5f858dso30855285ad.2
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1696868516; x=1697473316; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9D8jPF9E1+v7F2dWy/GLb2rQjEqzAmLDAq8Eefnd1qI=;
        b=GWPlVydh7c0LWyFybD+qI8TPbyhgL7asNPycf2ATMRfLt5+eH/0FB23iooNTKpmRFa
         f9hnNuyeHJCGYFCoQrYWniH7a1iQSpAJqijVstm3Ai+wBP8DbuzUYKaWSwaTYUmDDZ5e
         1KLG4EMkPS9V9TCRN6hS3Zxv84v2Z/jbAPFgcMoA40sbmOrMOfMpcNRtwFNKfMFR9+g6
         lcoBxjh+aHPfI6nehtfMZQKUCekT4QRK/4EL4RP6TA3z86BNBjQqP6g8OPmikZ1muqe2
         rYG5dVyaD0/IuxpwWO0H4IzrC64Q6TcmwctKmmgo2Mt6ylbbp3fNUVYN61aF8Rj65exN
         3ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696868516; x=1697473316;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9D8jPF9E1+v7F2dWy/GLb2rQjEqzAmLDAq8Eefnd1qI=;
        b=T9VkiAkPJad/vpzYh33SU6ssbpt9fxonVHIC1xQ9NpDfNUJMQCkXFUnwk063qW8RmN
         APqRqH1dhMrS/KptNoBqrm6mfyVjv8R66jjr5B65lEXrO4jrm+yX7ez5RBloFGuAKd6C
         V5oe3bon1kWfpYysg32FA4mMLHDSHq2YWZD484u1Ni0rS+/mlGt1jL2gPfmrf4iI6D59
         nwDboWCKKl+1IqDd99TXd6t3ZSx04OiYoPTxIfncEEwr1XyqEIqU6/rBGxVBmo+upmwn
         Pv62DFLFCWjdKaVQFrCB8hKwGMmzczcDccUB/QmCEHVQUB5q0SROcyWIyGz14/vWER7M
         wEnw==
X-Gm-Message-State: AOJu0YwcLoLF2s8ebAUcNWUnWOz6ox6bNBcWSSeOXUMUQlLBxpuGlzYe
        Da+An7jlstAIpF6aLNyEIsYx
X-Google-Smtp-Source: AGHT+IGdTIh2FweCyel44/dfnCBuBRNPxm0B/UN2lzupxoUQG4vrVTW1z/ppexHtY3jMuW0c36/CSg==
X-Received: by 2002:a17:902:eb45:b0:1bc:506a:58f2 with SMTP id i5-20020a170902eb4500b001bc506a58f2mr10750092pli.46.1696868516043;
        Mon, 09 Oct 2023 09:21:56 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id ji2-20020a170903324200b001b8b2b95068sm9791956plb.204.2023.10.09.09.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 09:21:55 -0700 (PDT)
Message-ID: <3585d72f-9f06-d190-ad5a-bec6db3f647f@github.com>
Date:   Mon, 9 Oct 2023 09:21:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] ref-cache.c: fix prefix matching in ref iteration
Content-Language: en-US
To:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
 <59276a5b3fd1fd3b25db73e096cf0e834af2d4f9.1696615769.git.gitgitgadget@gmail.com>
 <xmqqfs2n8lnn.fsf@gitster.g> <ZSPQLjJwq-7SjsDT@tanuki>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <ZSPQLjJwq-7SjsDT@tanuki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
>> Allowing prefix="refs/heads/v1.0" to yield entry="refs/heads/v1"
>> (case #2 above that this patch fixes the behaviour for) would cause
>> ref_iterator_advance() to return a ref outside the hierarhcy,
>> wouldn't it?  So it appears to me that either one of the two would
>> be true:
>>
>>  * the code is structured in such a way that such a condition does
>>    not actually happen (in which case this patch would be a no-op),
>>    or
>>
>>  * there is a bug in the current code that is fixed by this patch,
>>    whose externally observable behaviour can be verified with a
>>    test.
>>
>> It is not quite clear to me which is the case here.  The code with
>> the patch looks more logical than the original, but I am not sure
>> how to demonstrate the existing breakage (if any).
> 
> Agreed, I also had a bit of a hard time to figure out whether this is an
> actual bug fix, a performance improvement or merely a refactoring.
> 

I originally operated on the assumption that it was the first case, which is
why I didn't include a test in this patch. Commands like 'for-each-ref',
'show-ref', etc. either use an empty prefix or a directory prefix with a
trailing slash, which won't trigger this issue. I encountered the problem
while working on a builtin that filtered refs by a user-specified prefix -
the results included refs that should not have been matched, which led me to
this fix.

Scanning through the codebase again, though, I do see a way to replicate the
issue:

$ git update-ref refs/bisect/b HEAD
$ git rev-parse --abbrev-ref --bisect
refs/bisect/b

Because 'rev-parse --bisect' uses the "refs/bisect/bad" prefix (no trailing
slash) and does no additional filtering in its 'for_each_fullref_in'
callback, refs like "refs/bisect/b" and "refs/bisect/ba" are (incorrectly)
matched. I'll re-roll with the added test.

