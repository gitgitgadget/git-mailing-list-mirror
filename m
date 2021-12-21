Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B3DC433FE
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238655AbhLUOve (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:51:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238646AbhLUOvd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:51:33 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F6C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:51:33 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c3so18017894iob.6
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2p7m7LQHrVomWJ1EElbYWjQhsmW6eD/IgsZ56a8I9fA=;
        b=CTynvtWsOMdyrwOmU/edLiaGs09pD20jWpssZKexNPEvNVfP5kVUsnz4yz9LD0wHX8
         pa/gR3d3EQZrGW1KOzqCD4XlnhEdwRwHxXQiYcQvFHMcyoYt25x9zQoN60zJhkoJaqsd
         ZeaSF+bVU5jNJU4PhR1A4ijiYdF4DQOtAI1TUjCoNxbRIbb8IETMoqE2RcidG7vBkkRp
         wV8whNjk4UW3Fpw47HiG/NQ7DodbXxBh9j6+J3M/4qjt3P0LUSuoa1KI4nJ4myUfxHA5
         ZkoJH8nLowZx/7R8161YS2EVG1urY+EuktkuJvZBipTeJmgQwRMi4mACDFSeEheMAeMS
         PI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2p7m7LQHrVomWJ1EElbYWjQhsmW6eD/IgsZ56a8I9fA=;
        b=htaeEDCJDSAi6zdQPnVAd+ACwruhkOwA4nzTZ/T9KEnI+R5m5HkPEyOEvlopcApo4k
         Oy6ZwA770cpSegLcDOfeAtokWkn1cQeVN6The5W3EAcil8k0xKxGSPG6VGq/v5IM156t
         Pmfk3+uBI18/iVExcf+HiEk8oPO5/hXEGoQqcyBL1ZZb5ofT2FDJX9w6aMvODS+f1+YJ
         pD08Pd62FfWsPcELeiX5yowp3ODIWWpo/0IVjD3Hfqpkf/IwOgKhVMii9HP4FHA1uBlu
         E4djmjuKD6Gu35/RCwnrqpeV9jvTZMDPv15JGdFTArg3oqjpysEC7sCynwYONotgmcmF
         lHpg==
X-Gm-Message-State: AOAM530mkjDVpgNiV/UyoOrHRRRNwu5UGWkNw/u/e7U2iI275vFBAW3n
        9rgbKYPq8pIkzRTlXPWMAIw=
X-Google-Smtp-Source: ABdhPJyq8n5K8SU63YJl9qOuqoGVDMH1efZwSKGwDXhajOrqJEY4cjBgwAQD1qL+5V+xza3hJkRSEA==
X-Received: by 2002:a05:6602:2d8c:: with SMTP id k12mr1793990iow.49.1640098292643;
        Tue, 21 Dec 2021 06:51:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:c11c:699d:989:f926? ([2600:1700:e72:80a0:c11c:699d:989:f926])
        by smtp.gmail.com with ESMTPSA id y8sm10305701iox.32.2021.12.21.06.51.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 06:51:32 -0800 (PST)
Message-ID: <92923ca0-fbf9-e763-5735-214f3ad0cc3a@gmail.com>
Date:   Tue, 21 Dec 2021 09:51:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 0/9] Trace2 stopwatch timers and global counters
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/20/2021 10:01 AM, Jeff Hostetler via GitGitGadget wrote:
> Extend Trace2 to provide multiple "stopwatch timers" and "global counters".

>  3. Rationale
> 
> Timers and counters are an alternative to the existing "region" and "data"
> events. The latter are intended to trace the major flow (or phases) of the
> program and possibly capture the amount of work performed within a loop, for
> example. The former are offered as a way to measure activity that is not
> localized, such as the time spent in zlib or lstat, which may be called from
> many different parts of the program.
> 
> There are currently several places in the Git code where we want to measure
> such activity -- changed-path Bloom filter stats, topo-walk commit counts,
> and tree-walk counts and max-depths. A conversation in [1] suggested that we
> should investigate a more general mechanism to collect stats so that each
> instance doesn't need to recreate their own atexit handling mechanism.
> 
> This is an attempt to address that and let us easily explore other areas in
> the future.
> 
> This patch series does not attempt to refactor those three instances to use
> the new timers and counters. That should be a separate effort -- in part
> because we may want to retool them rather than just translate them. For
> example, rather than just translating the existing four Bloom filter counts
> (in revision.c) into Trace2 counters, we may instead want to have a "happy
> path timer" and a "sad path timer" if that would provide more insight.

I'm excited for these API features. It might be nice to have an RFC-
quality series demonstrating how these examples could work with the
new API. Makes sense to delay in case there were recommended changes
to the API from review in this v1.

I also like your attention to thread contexts. I think these timers
would be very interesting to use in parallel checkout. CC'ing Matheus
for his thoughts on where he would want timer summaries for that
feature. I would probably want the per-thread summary to know if we
are blocked on one really long thread while the others finish quickly.
Within that: what are the things causing us to be slow? Is it zlib?
Is it lstat()?

Thanks,
-Stolee
