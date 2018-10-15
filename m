Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04AA01F453
	for <e@80x24.org>; Mon, 15 Oct 2018 14:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeJOWZV (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:25:21 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44074 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbeJOWZV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:25:21 -0400
Received: by mail-qk1-f194.google.com with SMTP id y8-v6so11936538qka.11
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=7A2cnLiepTwB3zn9RzsREbijfsRaQ5MR2yr8Io6DMQY=;
        b=egnn7KXrlNOBaSRhUE5La9sMYnU8EvtgxAVQJT89DrsL6HolPbE9qfro+HYGHuzJLR
         tOUJSi01wx7RdQYgOkV9MjpWw6vIRKDjM9wbBdrfnkBHPGZ4H/9Iesc62n6PWXFh2F7U
         zx5fJfQ3fdqdXAKUWq9/WF78na59UANuhIzxW2+fdUcWCjvWdDlWUDHhoLWBzjJs2eiy
         tgnisw0Zqzw1bsoahNcwk37ybgxn9m6EabMG7iHx8v9U67V/rTI70hr7VHRNN5J4LhID
         +yLv1yGdwlkyPQulVIEohQL/GZy1edhPqYFUmLYBpV8d5DZ1SToRSCOpQIPcJHrrcPnf
         Ix+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=7A2cnLiepTwB3zn9RzsREbijfsRaQ5MR2yr8Io6DMQY=;
        b=hlMdPwcnnKKCRmdLAZUaaRtEpnGkyiB2U9Ng6nKQOAyy5oaFXC0buwLXEeRgcc5wet
         97FoJOiwd4fj/sDvu+c0CquERDWXbjkyJrSXOYB2WqRy7TrHswf/F9XgkfVQWLaZQjr4
         WnF/lewGO18xWm81vZOumuzFOLboO/EF1QwwCO44Y/T7o0nd5UG+ILgZuOo+VPkcjcAA
         3M8fD7N1Os5HowX9E8rq0HMkFowkGQKukvBET+yQgUQhI64u9wubgBaILfRT41K1r8xR
         D1VeqR1JAZiv34ewRaOz3EFxYVbZFKnGLDb1oRrAG+VgUXHg8e/eSJd4Vau5KcpKb742
         AOxg==
X-Gm-Message-State: ABuFfohAeOZvGxJDsBpjChfyCjXMpUGrcEMw7isIeTFd11ouQkO3cnzc
        ay7ebT0Bdzl9oqo2COctSbdblNla
X-Google-Smtp-Source: ACcGV62ezd8jjCSaYIqjbxlnO7YxKp+zu/XyDS/2i7if5KO7Xqsn4ECIVTah14Tlz3+icJ4txsvp7Q==
X-Received: by 2002:a37:2be1:: with SMTP id r94-v6mr16402777qkr.3.1539614387324;
        Mon, 15 Oct 2018 07:39:47 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:a017:1942:43e1:ced3? ([2001:4898:8010:0:894d:1942:43e1:ced3])
        by smtp.gmail.com with ESMTPSA id y138-v6sm6184688qka.36.2018.10.15.07.39.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 07:39:46 -0700 (PDT)
Subject: Re: [PATCH 0/4] Bloom filter experiment
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181009193445.21908-1-szeder.dev@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com>
Date:   Mon, 15 Oct 2018 10:39:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009193445.21908-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2018 3:34 PM, SZEDER Gábor wrote:
> To keep the ball rolling, here is my proof of concept in a somewhat
> cleaned-up form, with still plenty of rough edges.

Peff, Szeder, and Jonathan,

Thanks for giving me the kick in the pants to finally write a proof of 
concept for my personal take on how this should work. My implementation 
borrows things from both Szeder and Jonathan's series. You can find my 
commits for all of the versions on GitHub (it's a bit too messy to share 
as a patch series right now, I think):

Repo: https://github.com/derrickstolee/git
Branches: bloom/* (includes bloom/stolee, bloom/peff, bloom/szeder, and 
bloom/tan for the respective implementations, and bloom/base as the 
common ancestor)

My implementation uses the following scheme:

1. Bloom filters are computed and stored on a commit-by-commit basis.

2. The filters are sized according to the number of changes in each 
commit, with a minimum of one 64-bit word.

3. The filters are stored in the commit-graph using two new optional 
chunks: one stores a single 32-bit integer for each commit that provides 
the end of its Bloom filter in the second "data" chunk. The data chunk 
also stores the magic constants (hash version, num hash keys, and num 
bits per entry).

4. We fill the Bloom filters as (const char *data, int len) pairs as 
"struct bloom_filter"s in a commit slab.

5. In order to evaluate containment, we need the struct bloom_filter, 
but also struct bloom_settings (stores the magic constants in one 
place), and struct bloom_key (stores the _k_ hash values). This allows 
us to hash a path once and test the same path against many Bloom filters.

6. When we compute the Bloom filters, we don't store a filter for 
commits whose first-parent diff has more than 512 paths.

7. When we compute the commit-graph, we can re-use the pre-existing 
filters without needing to recompute diffs. (Caveat: the current 
implementation will re-compute diffs for the commits with diffs that 
were too large.)

You can build the Bloom filters in my implementation this way:

GIT_TEST_BLOOM_FILTERS=1 ./git commit-graph write --reachable

> You can play around with it like this:
>
>    $ GIT_USE_POC_BLOOM_FILTER=$((8*1024*1024*8)) git commit-graph write
>    Computing commit graph generation numbers: 100% (52801/52801), done.
>    Computing bloom filter: 100% (52801/52801), done.
>    # Yeah, I even added progress indicator! :)
>    $ GIT_TRACE_BLOOM_FILTER=2 GIT_USE_POC_BLOOM_FILTER=y git rev-list --count --full-history HEAD -- t/valgrind/valgrind.sh
>    886
>    20:40:24.783699 revision.c:486          bloom filter total queries: 66095 definitely not: 64953 maybe: 1142 false positives: 256 fp ratio: 0.003873

Jonathan used this same test, so will I. Here is a summary table:

| Implementation | Queries | Maybe | FP # | FP %  |
|----------------|---------|-------|------|-------|
| Szeder         | 66095   | 1142  | 256  | 0.38% |
| Jonathan       | 66459   | 107   | 89   | 0.16% |
| Stolee         | 53025   | 492   | 479  | 0.90% |

(Note that we must have used different starting points, which is why my 
"Queries" is so much smaller.)

The increase in false-positive percentage is expected in my 
implementation. I'm using the correct filter sizes to hit a <1% FP 
ratio. This could be lowered by changing the settings, and the size 
would dynamically grow. For my Git repo (which contains 
git-for-windows/git and microsoft/git) this implementation grows the 
commmit-graph file from 5.8 MB to 7.3 MB (1.5 MB total, compared to 
Szeder's 8MB filter). For 105,260 commits, that rounds out to less than 
20 bytes per commit (compared to Jonathan's 256 bytes per commit).

Related stats for my Linux repo: 781,756 commits, commit-graph grows 
from 43.8 to 55.6 MB (~12 MB additional, ~16 bytes per commit).

I haven't done a side-by-side performance test for these 
implementations, but it would be interesting to do so.

Despite writing a lot of code in a short amount of time, there is a lot 
of work to be done before this is submittable:

1. There are three different environment variables right now. It would 
be better to have one GIT_TEST_ variable and rely on existing tracing 
for logs (trace2 values would be good here).

2. We need config values for writing and consuming bloom filters, but 
also to override the default settings.

3. My bloom.c/bloom.h is too coupled to the commit-graph. I want to 
harden that interface to let Bloom filters live as their own thing, but 
that the commit-graph could load a bloom filter from the file instead of 
from the slab.

4. Tests, tests, and more tests.

We'll see how much time I have to do this polish, but I think the 
benefit is proven.

Thanks,
-Stolee
