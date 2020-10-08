Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF022C4363A
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C25020754
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 13:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biFEtEAd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgJHNXA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgJHNXA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 09:23:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB0AC061755
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 06:22:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m9so4998581qth.7
        for <git@vger.kernel.org>; Thu, 08 Oct 2020 06:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O52SJiBe+QN2peAESiCW9DY/xFyk1xDih8CwfPdejQI=;
        b=biFEtEAdHnwBmzcczjlDhjYa8JpiPX6NfW1Ghw1qHZ4+tlZLc8xx0dRyvMygWLbcp7
         Eq+mNOgGM5ZmLnz1CeH1qqH0MzXMwdJ8WqyEe/7SVGvThr8sWUP73Ui+ssWn9LMFL2eO
         INDxpQUDq3xJEkvKpHPeIGe53fOIShJK7WqMR9ldaGhpScSJ5OE1qJ+3YZW+cmMw/Gc5
         TmA3f3NOG/F3arAR/iOF5aISkrVYuaujoMNjpYxwYvDErhsULZAhgG5tL8OcpUHV4jEK
         JZt8KxW1PMWhhtttE1yH/R0LfxYbO51LBOf6CbkoPZOMa8eiYNedOK/EnxBAOUq9BCA6
         nrSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O52SJiBe+QN2peAESiCW9DY/xFyk1xDih8CwfPdejQI=;
        b=Hpc4sCsDxNRguVsKED9x40guYjz0SPOzObb5fUq/GsmRj0qrAkAOKQnNqBvbwL1n2N
         WdKk/ST/OTfAQMS2DVBIow7PY1qy6/lFZvv/ki+z9cY30opqgqQ1xn+wbQPVVFWvSice
         654PN3X+peXCFL8tANUMj8SBhOGU5wF/mMXkQi30/WYFo4JYiReihD//Te4qv/Sytynv
         UE/NbA9MGTiPgY49G09pk9Bt9L1WX3xFOHTyk+IH/HxhIUhOzDP5IyiYWKlXFrsOBRy9
         D29K6kaPHYdQCnHFTJlpgEJuI+nI3lPZKiuzAl84Qa6E2m7SNyLTObwUbUSayhnLd78v
         2PHA==
X-Gm-Message-State: AOAM5330lzUlx8M107w2dXyNsqmfC/Am3m47Ppz5mSt+gN0t48W7CoaD
        7B/QEkMD34ak780jdyAh+NGN2LlJf/n4vQ==
X-Google-Smtp-Source: ABdhPJwCKitIZtCGolVdFO/MsCB9Z0+d3upunsrfeTk1zq69TfJNUpS+dxFppw2fddhsuq2H62W3pg==
X-Received: by 2002:aed:368a:: with SMTP id f10mr8192867qtb.59.1602163377142;
        Thu, 08 Oct 2020 06:22:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:56e:1bd4:bf96:36ec? ([2600:1700:e72:80a0:56e:1bd4:bf96:36ec])
        by smtp.gmail.com with UTF8SMTPSA id f8sm3729246qtx.81.2020.10.08.06.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 06:22:56 -0700 (PDT)
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
From:   Derrick Stolee <stolee@gmail.com>
To:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <55f8f00c-a61c-67d4-889e-a9501c596c39@virtuell-zuhause.de>
 <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
Message-ID: <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
Date:   Thu, 8 Oct 2020 09:22:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2020 8:50 AM, Derrick Stolee wrote:
> On 10/8/2020 8:06 AM, Jeff King wrote:
>> But regardless, it seems unfriendly that we can't
>> get out of it while merging the graphs. Doing this obviously makes the
>> problem go away:
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index cb042bdba8..ae1f94ccc4 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -2023,8 +2023,11 @@ static void sort_and_scan_merged_commits(struct write_commit_graph_context *ctx)
>>  
>>  		if (i && oideq(&ctx->commits.list[i - 1]->object.oid,
>>  			  &ctx->commits.list[i]->object.oid)) {
>> -			die(_("unexpected duplicate commit id %s"),
>> -			    oid_to_hex(&ctx->commits.list[i]->object.oid));
>> +			/*
>> +			 * quietly ignore duplicates; these could come from
>> +			 * incremental graph files mentioning the same commit.
>> +			 */
>> +			continue;
>>  		} else {
>>  			unsigned int num_parents;
>>  
>>
>> but it's not clear to me if that's papering over another bug, or
>> gracefully handling a situation that we ought to be.
> 
> I think this is a good thing to do, at minimum. As I discussed above,
> the "input data" of the incremental commit-graph chain with duplicate
> commits across layers isn't actually _invalid_. It's unexpected based
> on what Git "should" be doing.

As I was working on my own version of this, I realized that just
commenting here still creates duplicate commits in the new layer,
which is even MORE unexpected. It could cause some confusion with
the binary search, but likely that is still fine. The only "real"
issue is that it is wasted data.

I'll send [1] to the list soon (after build & test validation),
but it includes copying the pointers to a new "de-duplicated" list.

[1] https://github.com/gitgitgadget/git/pull/747

Thanks,
-Stolee
