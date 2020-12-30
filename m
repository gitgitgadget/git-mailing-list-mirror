Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9160C433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 04:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7508A207AE
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 04:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL3Egi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Dec 2020 23:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgL3Egi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Dec 2020 23:36:38 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC34C061799
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 20:35:58 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id d203so17660537oia.0
        for <git@vger.kernel.org>; Tue, 29 Dec 2020 20:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tlhxwcHfqT5ldTSWetdT228SlVZAx7NXtHOLBzYrBZQ=;
        b=lZ4EPcNsIaf7lohWC4Ie+VtA6VVv1EWOv2RE9XTgcf1UrJV3Bi04/6dLaNFNXBWnRc
         SnCzJyPi+xS1OTY8M1sQOZPrR1NmefDix1Db1MCadLrg86jtFy2t+sPApRBKnr99ZIur
         Sy12obZt+ycBToIctN5wYQA/9sDxBKIuTL4EYgUp/F/82zriMeU11z8dZ48tyunX4xT0
         bR2n6wmRN3P3akjTcss6PT+kTu0aJn8AvOt/u5/+y9J52ZTWUBkh3iJrg9CUKDaNtUWU
         gTIJ09g784HmdnNSAs6xUcRoMwq28z6nHj2I3PPZw0P6Wg8bRDrsfFjPKy/UUuktI9IS
         PqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tlhxwcHfqT5ldTSWetdT228SlVZAx7NXtHOLBzYrBZQ=;
        b=WtcOLAvbzFyYFoE/SMMq9BvS4iGuTZhigJuoOcTwjVS5n3+UoPgHqqbgTB6sUspSPx
         1Ds55D/8uq37EbJ0aYNo10ELRUhu1k782BX9EO0QugXUdR8PkeU2HDsYVXW/A3VBqu5G
         hATVgQKjQ4vRdLI/lz+mWrioFMj5U6GeJRycEzlnOqC+JcVjBqo9LqoDfkP1XsUQUdo6
         eY6v8IECOmpfR8HQtA1IXxkAvdoy/Co78Pf1EdlI3Y4847ezH2Mhi8ohGUU1w7BGlOVP
         502mO4Zg8f7O7HBfYSOVGZ2Yg1cis95SK1mP+jzAI1wy/i5jXp6c9gzm8qbe8bpOjE4A
         Y/sg==
X-Gm-Message-State: AOAM530V4k6J5VLdv58w5riMedvnLCnNow4mgvLVf/NMMImkb/76POZ+
        FUjFoVAzKwTAWLmjxxMxQ4k=
X-Google-Smtp-Source: ABdhPJwlihlBzeOMNO4hFmonve4YX47rEa5dssVQfzYK9+OuBtdZpeyJMn8U1Kbu8qoxC2cvzPsXpA==
X-Received: by 2002:aca:b789:: with SMTP id h131mr4253380oif.83.1609302957440;
        Tue, 29 Dec 2020 20:35:57 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id i194sm7931948oib.30.2020.12.29.20.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 20:35:56 -0800 (PST)
Subject: Re: [PATCH v5 00/11] [GSoC] Implement Corrected Commit Date
To:     Abhishek Kumar via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <me@ttaylor.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
References: <pull.676.v4.git.1602079785.gitgitgadget@gmail.com>
 <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1adabda6-b80b-d543-f6c0-570dadbe589b@gmail.com>
Date:   Tue, 29 Dec 2020 23:35:56 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <pull.676.v5.git.1609154168.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/28/2020 6:15 AM, Abhishek Kumar via GitGitGadget wrote:
> This patch series implements the corrected commit date offsets as generation
> number v2, along with other pre-requisites.

Abhishek,

Thank you for this version. I appreciate your hard work on this topic,
especially after GSoC ended and you returned to being a full-time student.

My hope was that I could completely approve this series and only provide
forward-fixes from here on out, as necessary. I think there are a few minor
typos that you might want to address, but I was also able to understand your
intention.

I did make a particular case about a SEGFAULT I hit that I have been unable
to replicate. I saw it both in my copy of torvalds/linux and of
chromium/chromium. I have the file for chromium/chromium that is in a bad
state where a GDAT value includes the bit saying it should be in the long
offsets chunk, but that chunk doesn't exist. Further, that chunk doesn't
exist in a from-scratch write.

I'm now taking backups of my existing commit-graph files before any later
test, but it doesn't repro for my Git repository or any other repo I try on
purpose.

However, I did some performance testing to double-check your numbers. I sent
a patch [1] that helps with some of the hard numbers.

[1] https://lore.kernel.org/git/pull.828.git.1609302714183.gitgitgadget@gmail.com/

The big question is whether the overhead from using a slab to store the
generation values is worth it. I still think it is, for these reasons:

1. Generation number v2 is measurably better than v1 in most user cases.

2. Generation number v2 is slower than using committer date due to the
   overhead, but _guarantees correctness_.

I like to use "git log --graph -<N>" to compare against topological levels
(v1), for various levels of <N>. When <N> is small, we hope to minimize
the amount we need to walk using the extra commit-date information as an
assistance. Repos like git/git and torvalds/linux use the philosophy of
"base your changes on oldest applicable commit" enough that v1 struggles
sometimes.

git/git: N=1000

	Benchmark #1: baseline
	Time (mean ± σ):     100.3 ms ±   4.2 ms    [User: 89.0 ms, System: 11.3 ms]
	Range (min … max):    94.5 ms … 105.1 ms    28 runs
	
	Benchmark #2: test
	Time (mean ± σ):      35.8 ms ±   3.1 ms    [User: 29.6 ms, System: 6.2 ms]
	Range (min … max):    29.8 ms …  40.6 ms    81 runs
	
	Summary
	'test' ran
	2.80 ± 0.27 times faster than 'baseline'

This is a dramatic improvement! Using my topo-walk stats commit, I see that
v1 walks 58,805 commits as part of the in-degree walk while v2 only walks
4,335 commits!

torvalds/linux: N=1000 (starting at v5.10)

	Benchmark #1: baseline
	Time (mean ± σ):      90.8 ms ±   3.7 ms    [User: 75.2 ms, System: 15.6 ms]
	Range (min … max):    85.2 ms …  96.2 ms    31 runs
	
	Benchmark #2: test
	Time (mean ± σ):      49.2 ms ±   3.5 ms    [User: 36.9 ms, System: 12.3 ms]
	Range (min … max):    42.9 ms …  54.0 ms    61 runs
	
	Summary
	'test' ran
	1.85 ± 0.15 times faster than 'baseline'

Similarly, v1 walked 38,161 commits compared to 4,340 by v2.

If I increase N to something like 10,000, then usually these values get
washed out due to the width of the parallel topics.

The place we were still using commit-date as a heuristic was paint_down_to_common
which caused a regression the first time we used v1, at least for certain cases.

Specifically, computing the merge-base in torvalds/linux between v4.8 and v4.9
hit a strangeness about a pair of recent commits both based on a very old commit,
but the generation numbers forced walking farther than necessary. This doesn't
happen with v2, but we see the overhead cost of the slabs:

	Benchmark #1: baseline
	Time (mean ± σ):     112.9 ms ±   2.8 ms    [User: 96.5 ms, System: 16.3 ms]
	Range (min … max):   107.7 ms … 118.0 ms    26 runs
	
	Benchmark #2: test
	Time (mean ± σ):     147.1 ms ±   5.2 ms    [User: 132.7 ms, System: 14.3 ms]
	Range (min … max):   141.4 ms … 162.2 ms    18 runs
	
	Summary
	'baseline' ran
	1.30 ± 0.06 times faster than 'test'

The overhead still exists for a more recent pair of versions (v5.0 and v5.1):

	Benchmark #1: baseline
	Time (mean ± σ):      25.1 ms ±   3.2 ms    [User: 18.6 ms, System: 6.5 ms]
	Range (min … max):    19.0 ms …  32.8 ms    99 runs
	
	Benchmark #2: test
	Time (mean ± σ):      33.3 ms ±   3.3 ms    [User: 26.5 ms, System: 6.9 ms]
	Range (min … max):    27.0 ms …  38.4 ms    105 runs
	
	Summary
	'baseline' ran
	1.33 ± 0.22 times faster than 'test'

I still think this overhead is worth it. In case not everyone agrees, it _might_
be worth a command-line option to skip the GDAT chunk. That also prevents an
ability to eventually wean entirely of generation number v1 and allow the commit
date to take the full 64-bit column (instead of only 34 bits, saving 30 for
topo-levels).

Again, such a modification should not be considered required for this series.

> ----------------------------------------------------------------------------
> 
> Improvements left for a future series:
> 
>  * Save commits with generation data overflow and extra edge commits instead
>    of looping over all commits. cf. 858sbel67n.fsf@gmail.com
>  * Verify both topological levels and corrected commit dates when present.
>    cf. 85pn4tnk8u.fsf@gmail.com

These seem like reasonable things to delay for a later series
or for #leftoverbits

Thanks,
-Stolee

