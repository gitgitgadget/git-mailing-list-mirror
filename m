Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 805491F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 21:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKSVor (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 16:44:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34674 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbfKSVor (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 16:44:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id h13so12644495plr.1
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 13:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=R+HtdIiwpiI/y5s2mFNNEG9Nr7iPcJoDFRsUa19EmjE=;
        b=Uzf36zTx9v6UYCs63d3hTOPP5TwA7SVwClInxBYqN4Jo9zGjAAhpFkwL1odGgOKROE
         h4jBrbs8gWpeNC35M54dYUjmm7aDzboldOHZbDy6x0awDcLGIeGfNo+GwCq822jd30E0
         9hTrO1SG3BMeEhNFL8UwoT4/Ielq45nTYWH20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+HtdIiwpiI/y5s2mFNNEG9Nr7iPcJoDFRsUa19EmjE=;
        b=VzWbC/+p5lAG5zipG2SGMl913bdzggVsbwkmQsjS4JrA9woTLBQvJBYJuvBfRzUfjW
         CWenLj84L6qNfSRyjP3uD2ulq3PpNW90PqxW721h/IpFAsFvrGVH7MkCoGKHQ70bWwmr
         XO5uoITa6mV9wT89Kzto+C/hSpDgEAN8n+xm07IPQMkuvHrey4u7n+jYn5qb2hvdTSkb
         /XD0WkRZMEkdbS+owAhWnPhyODXVHuXSrX7P0mblr7AQl9DpOy2mmYerKV9dm5R7RoKz
         Sg69b36/so4M2dgi1PaVOViR6Vq9NYhSXVx7YvpnzK4izlGvq5zRr75fwL64dq97R6g2
         /TZA==
X-Gm-Message-State: APjAAAXWoRBZrgqDB5KhEQikv1HOKLh6fNPZcMh6QhLhyUAMZwq6/1jN
        56le5jVAaUinAezmhEyQei+i0OuXKgk=
X-Google-Smtp-Source: APXvYqxCR3gAJRFL10yDiQHnw0kGlLzWX7478GAnuFn90nS05uE0IarnYdnsmDj/sLnAw2y7TWoWzA==
X-Received: by 2002:a17:902:26d:: with SMTP id 100mr20756986plc.7.1574199886217;
        Tue, 19 Nov 2019 13:44:46 -0800 (PST)
Received: from erikchen-macbookpro.roam.corp.google.com ([2620:0:1000:2104:407f:1cf7:d833:4184])
        by smtp.gmail.com with ESMTPSA id 129sm25906671pfd.174.2019.11.19.13.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 13:44:45 -0800 (PST)
Subject: Re: [PATCH v3 0/1] fetch: add trace2 instrumentation
To:     Junio C Hamano <gitster@pobox.com>,
        erik chen via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.451.v2.git.1573066300.gitgitgadget@gmail.com>
 <pull.451.v3.git.1573069152.gitgitgadget@gmail.com>
 <xmqqd0e4s1m2.fsf@gitster-ct.c.googlers.com>
From:   Erik Chen <erikchen@chromium.org>
Message-ID: <54eb184e-5400-093f-a9fc-c804dd6f9c65@chromium.org>
Date:   Tue, 19 Nov 2019 13:44:44 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <xmqqd0e4s1m2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Importing response from 
https://github.com/gitgitgadget/git/pull/451#issuecomment-555044068

On 11/6/19 9:21 PM, Junio C Hamano wrote:
> "erik chen via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> Add trace2 regions to fetch-pack.c to better track time spent in the various
>> phases of a fetch:
>>
>> * matching common remote and local refs
>> * marking local refs as complete (part of the matching process)
>>
>> Both of these stages can be slow for repositories with many refs.
>>
>> Signed-off-by: Erik Chen erikchen@chromium.org [erikchen@chromium.org]
> 
> If the above is verbatim copy of what you wrote in 1/1, that is very
> much unappreciated X-<.  A cover letter for a topic serves primarily
> just one purpose:
> 
>     It is a good place to present a birds-eye-view of a multi-patch
>     topic; a high level description of the problem (e.g. how the
>     issue manifests to the end users), an explanation of division of
>     the problem into subproblems you made (if applicable), and
>     interesting highlights of the solution would all be good things
>     to have in there.
> 
> And as a topic goes through iterations, it gives you a good place to
> summarize what changed since the previously reviewed iterations.  It
> could be just a single liner "addressed all the review comments for
> the previous iteration".  A well-written multi-patch topic also uses
> the same after-three-dash technique used for a single-patch topic
> (see below) to summarize what changed since the corresponding patch
> in the series in the previous iteration (or just says "no changes
> since the previous round"---that helps the reviewers a lot).
>     
> For a single-patch topic, there is no place for "here is an overall
> birds-eyes-view picture because the changes described in the
> proposed log message of individual patches are so big and complex".
> A single-patch topic has one patch, that solves one problem and only
> that problem well, so it should not need such a summary.
> 
> When you want to summarize the changes since the previous iteration,
> you would write it between the three-dash-line (which appears after
> your sign-off) and the diffstat.
> 
> Thanks.
> 
> 
Sorry about that, this is my first time contributing to git, and I'm 
using GitGitGadget. I believe it's too late to fix this now (?)
