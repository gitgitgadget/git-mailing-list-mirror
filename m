Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4840C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E65522280
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 16:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPqh/y41"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389889AbgJIQtX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389431AbgJIQtX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 12:49:23 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB65C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 09:49:22 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id l18so2506123ooa.9
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pPaDg4K4etIljEJciHnXiEmJSlB5j778PlrtwK3LGWQ=;
        b=jPqh/y41lFM6CtP40ArKrZIqI1ca4KVmS87KVEMRYLepQZ22sr4VdvDSfm1ErvV8OG
         pFa2QLedCHaXJBUP0R+Zl31buZFjfMcmJckUCi902rl9h1BYVBny96ZuOz8pwXMONVru
         FW3CgKKLSf/y/K3q2+V0l9h2Q8Dv8z0sWotdyvDegap7xXOBgK1KRw49n9ifgLJkK7PG
         xriWz/v6hfy+ggygSY700052zFZsGZp4tq45JTXMKL3kQMBfuKEqFMPnPiVv5+g2I6Jn
         bITP9mekFsYcrJFiJb02F++XMpZdZZ9r4pQFfr3uFUeUv2uLIWZFM0vKkr4lSp5D0bwB
         c2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pPaDg4K4etIljEJciHnXiEmJSlB5j778PlrtwK3LGWQ=;
        b=Nb4oeAssY/EEgv7B54etD+svGwH1nh219pappshTSuQVWAvFA5xpefDkuC9h7mA3Tx
         UDVkNdyu0Fugjno8X1WpLnpri0NYx5Am5pz0r9uqw9BW0F3OAR0s3qpq7DexxTh72MvT
         /38ouGHocrGl3yELNse1zCq8V054zVJuzy0fG2Tf4FrQh9M/ghEqiv9NGvrqFSr1fRtf
         G7T6T2sYVdj88LqGYFsbMvSxTF+1iyJ0SiT/1cGXBt6BJY30T1vj6xLaGphgOovn/9DT
         5nwOfGGQJWBWYL4uU6KtrD3Rwy2k56XD9jvoJtybkJr0osPq+wrLSc1Q4Krq3VAJX8b+
         MpfA==
X-Gm-Message-State: AOAM531SFduDEFMLbLkzMhS+cjxVrxkaHJ5WMAP2MzP+yAxsujpGQf7H
        hUy3pea0YlANQmbXOwPxwmA=
X-Google-Smtp-Source: ABdhPJws3KVBWMfwJaTM+2/4ndBLO7qxFPHjbNnxV9Ow5fDgzZ83cHAW23uuUMiAWOr9+RG/clSVEA==
X-Received: by 2002:a4a:751a:: with SMTP id j26mr9788650ooc.14.1602262162168;
        Fri, 09 Oct 2020 09:49:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:859b:7143:ba12:a6eb? ([2600:1700:e72:80a0:859b:7143:ba12:a6eb])
        by smtp.gmail.com with UTF8SMTPSA id t22sm6308986otk.24.2020.10.09.09.49.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 09:49:21 -0700 (PDT)
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
 <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0d25e0ab-31ab-54c2-b518-bd9c0b0c4b7a@gmail.com>
Date:   Fri, 9 Oct 2020 12:49:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2020 11:29 AM, Thomas Braun wrote:
> I think I have a starting point for what goes wrong. I found a local
> repo with another broken commit graph. And after some fiddling the
> following script can reproduce it. I tried with git/git first but that
> seems not to trigger that.

I'm glad you're able to trigger bad commit-graph data somehow.
Let's see what's going on:

> # rm -rf dummy
> mkdir dummy
> cd dummy
> 
> git init
> 
> git remote add origin https://github.com/tango-controls/cppTango
> git remote add fork1 https://github.com/bourtemb/cppTango
> git remote add fork2 https://github.com/t-b/cppTango
> git fetch --all --jobs 12

My gut reaction is that this parallel fetching is causing
an issue, but we will see. Do you get a repro if you drop
the "--jobs 12"?

> git commit-graph verify
> rm -rf .git/objects/info/commit-graphs/
> git commit-graph verify
> git fetch --jobs 12
> git remote add fork3 git@github.com:t-b/cppTango.git
> git commit-graph verify
> git remote add fork4 git@github.com:t-b/cppTango.git
> git fetch --jobs 12
> git commit-graph verify
> 
> The last verify outputs
> 
> commit-graph generation for commit
> 029341567c24582030592585b395f4438273263f is 1054 != 1
> commit-graph generation for commit
> 1e8d10aec7ca6075f622c447d416071390698124 is 4294967295 != 1171
> commit-graph generation for commit
> 296e93516189c0134843fd56ac4f10d36ccf284f is 1054 != 1
> commit-graph generation for commit
> 4c0a7a3cd369d06b99d867be6b47a96c519efd7f is 1054 != 1
> commit-graph has non-zero generation number for commit
> 4d39849950d3dc02b7426c780ac7991ec7221176, but zero elsewhere
> commit-graph has non-zero generation number for commit 4
> [....]

This looks more troubling than just duplicate rows, but
perhaps those duplicate rows are causing sufficient
confusion when reading the commit-graph during the
'verify' command?

I tried incorporating this into the Git test suite so I
could test it on v2.29.0-rc0 and the current merge-check,
but I'm failing to reproduce the failure with this script:

diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index c334ee9155..2b3f3db593 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -440,4 +440,26 @@ test_expect_success '--split=replace with partial Bloom data' '
 	verify_chain_files_exist $graphdir
 '
 
+test_expect_success 'test' '
+	git init dummy &&
+	(
+		cd dummy &&
+		export GIT_TRACE2_EVENT="$TRASH_DIRECTORY/../trace.txt" &&
+		git config fetch.writeCommitGraph true &&
+		git remote add origin https://github.com/tango-controls/cppTango &&
+		git remote add fork1 https://github.com/bourtemb/cppTango &&
+		git remote add fork2 https://github.com/t-b/cppTango &&
+		git fetch --all --jobs 12 &&
+		git commit-graph verify &&
+		rm -rf .git/objects/info/commit-graphs/ &&
+		git commit-graph verify &&
+		git fetch --jobs 12 &&
+		git remote add fork3 git@github.com:t-b/cppTango.git &&
+		git commit-graph verify &&
+		git remote add fork4 git@github.com:t-b/cppTango.git &&
+		git fetch --jobs 12 &&
+		git commit-graph verify
+	)
+'
+
 test_done

I tried this on Linux and Windows, and under "--stress" but never
saw a failure.

Thomas: some things that could possibly help is if you repro this
situation but also do something like

	export GIT_TRACE2_EVENT="$(pwd)/trace.txt"

so we can read the details of everything Git is tracing during
these parallel jobs. We might be able to stitch together a
sequence of events that lead to these failures.

Thanks,
Stolee
