Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF5DC5519F
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE1522245
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 13:31:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UuezRxTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgKPNai (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 08:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbgKPNai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 08:30:38 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F7FC0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:30:38 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id h16so11874416otq.9
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 05:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fmZEp67leZr8loXkGm8BGbaZ+gSjsdmjJgq46mgNMd4=;
        b=UuezRxTsBLMjKzudgV7+fY+IpbBzALh8R+ypmC+CzZnXWks+xjV9XuYNO8jjaUH7Nv
         zEYAG3bMpy2XOIDMRIHfjATtstKm59NVP34RH/SOqlcMgZHO4EthJZNXRCYYoAZoZy8O
         oqRXVIBL2kCX1uHUPfvZFAByWkWSnXF1siqiomhgEPYwKnDsCLBRYxSYXINzkhcCTSZQ
         2LFLtYGNx5Gp+rZ+sRTeGMtVZ4czBxRkUWCHH7VjNC4poPWp54oXKBUorHcymuwMkfyY
         Ga/dVHeDC+W4gVLb242I1ww4Yz2YHDF20dBkZLtRnaLH44NvZZ/33cqcfTC7WbXk/gEB
         xd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fmZEp67leZr8loXkGm8BGbaZ+gSjsdmjJgq46mgNMd4=;
        b=AdMgH5ynz0EjUVhwBEX4Cxrr9VNZukBUQkysIABzs3n3ksL2Zi4yko0uEQdzey8Sw8
         HYhq74kggh282qOWtIGnjb0QIqDBHfwDF/4T3ZpKzzkdude1BYwKfvKYFNIl7+DcFzuE
         d95mrRxs/s+HzkZ93vNg56WvdQuw5RFozxksTIFhgZLdT93Ve59SpZHxiVhsoarQDyWF
         w5gzWliPby5DyCnElhNGAA1R/6wM+dVPuc4/auTIdm0tF6W6ApKpfWb+iNNXJd1fTZr8
         MB+IxQm0gniW2I72O3CUX5NFLUtcZ77W+y7iJZur1XIYuELOgEHZbGnID/fI/llmxr7n
         aGnw==
X-Gm-Message-State: AOAM533aEufQhVPTaAw5RAoBYX11wOcaj/unzh7Y1EndZedWVSUr2AYd
        GbBtwtj5rC0ODh6i+2P4+h7lPKUoZjJChg==
X-Google-Smtp-Source: ABdhPJzy3OBxop3bD8oI7WmEHAtOrYM301VdYhlj4/RUQ3/8S1E+kjCuNejmByahhCnCwHuouisO3w==
X-Received: by 2002:a9d:66ca:: with SMTP id t10mr9954812otm.13.1605533437406;
        Mon, 16 Nov 2020 05:30:37 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:6dc1:e5c:951b:3570? ([2600:1700:e72:80a0:6dc1:e5c:951b:3570])
        by smtp.gmail.com with UTF8SMTPSA id n63sm1890399oih.39.2020.11.16.05.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 05:30:36 -0800 (PST)
Subject: Re: [PATCH 0/5] handling 4GB .idx files
To:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <42080870-1a92-e76f-d83a-f15642a96329@gmail.com>
Date:   Mon, 16 Nov 2020 08:30:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201116041051.GA883199@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15/2020 11:10 PM, Jeff King wrote:
> On Sun, Nov 15, 2020 at 03:43:39PM +0100, Thomas Braun wrote:
> 
>> On 13.11.2020 06:06, Jeff King wrote:
>>> I recently ran into a case where Git could not read the pack it had
>>> produced via running "git repack". The culprit turned out to be an .idx
>>> file which crossed the 4GB barrier (in bytes, not number of objects).
>>> This series fixes the problems I saw, along with similar ones I couldn't
>>> trigger in practice, and protects the .idx loading code against integer
>>> overflows that would fool the size checks.
>>
>> Would it be feasible to have a test case for this large index case? This
>> should very certainly have an EXPENSIVE tag, or might even not yet work
>> on windows. But hopefully someday I'll find some more time to push large
>> object support on windows forward, and these kind of tests would really
>> help then.
> 
> I think it would be a level beyond what we usually consider even for
> EXPENSIVE. The cheapest I could come up with to generate the case is:

I agree that the cost of this test is more than I would expect for
EXPENSIVE.

>   perl -e '
> 	for (0..154_000_000) {
> 		print "blob\n";
> 		print "data <<EOF\n";
> 		print "$_\n";
> 		print "EOF\n";
> 	}
>   ' |
>   git fast-import
> 
> which took almost 13 minutes of CPU to run, and peaked around 15GB of
> RAM (and takes about 6.7GB on disk).

I was thinking that maybe the RAM requirements would be lower
if we batched the fast-import calls and then repacked, but then
the repack would probably be just as expensive.

> In the resulting repo, the old code barfed on lookups:
> 
>   $ blob=$(echo 0 | git hash-object --stdin)
>   $ git cat-file blob $blob
>   error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
>   error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
>   error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
>   error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
>   error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
>   error: wrong index v2 file size in .git/objects/pack/pack-f8f43ae56c25c1c8ff49ad6320df6efb393f551e.idx
>   fatal: git cat-file 573541ac9702dd3969c9bc859d2b91ec1f7e6e56: bad file
> 
> whereas now it works:
> 
>   $ git cat-file blob $blob
>   0
> 
> That's the most basic test I think you could do. More interesting is
> looking at entries that are actually after the 4GB mark. That requires
> dumping the whole index:
> 
>   final=$(git show-index <.git/objects/pack/*.idx | tail -1 | awk '{print $2}')
>   git cat-file blob $final

Could you also (after running the test once) determine the largest
SHA-1, at least up to unique short-SHA? Then run something like

	git cat-file blob fffffe

Since your loop is hard-coded, you could even use the largest full
SHA-1.

Naturally, nothing short of a full .idx verification would be
completely sound, and we are already generating an enormous repo.

> So I dunno. I wouldn't be opposed to codifying some of that in a script,
> but I can't imagine anybody ever running it unless they were working on
> this specific problem.

It would be good to have this available somewhere in the codebase to
run whenever testing .idx changes. Perhaps create a new prerequisite
specifically for EXPENSIVE_IDX tests, triggered only by a GIT_TEST_*
environment variable?

It would be helpful to also write a multi-pack-index on top of this
.idx to ensure we can handle that case, too.

Thanks,
-Stolee
