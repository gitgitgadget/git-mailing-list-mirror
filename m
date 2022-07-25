Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140FC43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 13:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbiGYNQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 09:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233312AbiGYNP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 09:15:58 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A8EA452
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 06:15:48 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w29so8126498qtv.9
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 06:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=NiiDqNYun+SFW2iZEHBXfLK0XfHUTgCmG2MoAy0spG4=;
        b=KMHHWf5jMkt6lx6I/RHyffjrnT8D7vGIAYdffyIBX2rzuuLQaixhBsqxa8oDRVvkTU
         j4Kpb1/Q2+TTTNCv6mVpIeXK+H1vVf+gRy8j1LMWMkrPiv8gCXtR5GPwDWdxUlEGp6Yn
         rB1l5T8v6NXngj19d5t9MSQouQcewh2tue///kD/ATAC7idhN3DpmIENhbK7c0dj+G1V
         166SSwabVh12jYg4dSi6AF2jqXjRXS79GhhPLrypt2kRqUKY1kZdYRseW63tupkkhBVU
         E1/8eTr3VwYhPAM/2LPaWtmdOa8Q+RRoU2DA2bWb3cPiv+klR3XaLyOxRfPpLrfiDt2w
         +UDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NiiDqNYun+SFW2iZEHBXfLK0XfHUTgCmG2MoAy0spG4=;
        b=CjAQUH/1aN1ge6EOEGBzI9XJfdth/aexEzuOag/kkLpzk2sfl0YJWrNSHXuQ6LZ1Lc
         7D5BIh4NTLTjm6dT6D/oBJQZ0KcvaW5YqcFIgKuoB6W4cGFfUmyRzqGov1dtnUVD1mSV
         hIJOwIa1+LfmsHFe2O4LcDS+Hxd1VK28ZHM1qC3MDh0FyvOY4qAVaOdZc7Ia3keBehSJ
         MyVEp7SL2J6Cx7hF7/jC5gf593N878EO6TTHrSBn8G7dRLUWKuBItYkNTnaEi21f44+T
         f0B7iz0ZtiW4Y+PA3RcIVH2lX4PVRiwhznvy3MTu3xRSCwAz5RylGhRdi50J4zNJMryv
         ADXA==
X-Gm-Message-State: AJIora9gJaTyh07gELWX4vrzXtOk/HUQNnrlcU5sH1K4LhUSi1JsnxJm
        vtrsh+Yo46qK6u4wZiWoyVJ1
X-Google-Smtp-Source: AGRyM1t+gk2o4h8Si5jvmIr5mOIfIY1bpRaoadn7h2P6Pay5xvmSm+Nh4X9qndMgGFZizoTmGh1KsQ==
X-Received: by 2002:ac8:59d5:0:b0:31f:dde:fca8 with SMTP id f21-20020ac859d5000000b0031f0ddefca8mr10279003qtf.86.1658754947221;
        Mon, 25 Jul 2022 06:15:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f959:7f34:301e:c14? ([2600:1700:e72:80a0:f959:7f34:301e:c14])
        by smtp.gmail.com with ESMTPSA id t2-20020ac85882000000b0031eb02307a9sm7362658qta.80.2022.07.25.06.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 06:15:46 -0700 (PDT)
Message-ID: <16acb1ce-92eb-d7ec-d5a2-3ef08cda9b69@github.com>
Date:   Mon, 25 Jul 2022 09:15:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 00/20] parse-options: handle subcommands
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/25/2022 8:38 AM, SZEDER Gábor wrote:
> Several Git commands have subcommands to implement mutually exclusive
> "operation modes", and they usually parse their subcommand argument
> with a bunch of if-else if statements.
> 
> Teach parse-options to handle subcommands as well, which will result
> in shorter and simpler code with consistent error handling and error
> messages on unknown or missing subcommand, and it will also make
> possible for our Bash completion script to handle subcommands
> programmatically in a follow-up series [1].

Since this has become an increasingly common pattern, I appreciate
that you have standardized it here.

> Patches 1-8 are a mix of preparatory cleanups, documentation updates, and
> test coverage improvements.
> 
> Patch 9 is the most important one, which teaches parse-options to handle
> subcommands.
> 
> The remaining 10-20 convert most builtin commands with subcommands one by
> one to use parse-options to handle their subcommand parameters.

I focused on reading the changes to the builtins I have experience with
(commit-graph, maintenance, multi-pack-index, sparse-checkout, worktree)
and found the adaptation to the new model very clean.

The one common thing I saw was that you are updating a function pointer
that you name "fn" but it could be more informative on first reading if
it was named something like "subcommand_fn".

> This patch series has two conflicts with 'seen' (but none with 'next'):

An upcoming conflict is going to be my bundle URI topic which is going
to replace 'git fetch --bundle-uri' with 'git bundle fetch' in its next
version. I'll wait to see how Junio applies this series and I'll think
about splitting the current series into "design doc" and "implementation"
just so I can build on your work here instead of colliding.

Thanks,
-Stolee

