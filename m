Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAC6C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 19:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237858AbiHETiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiHETiX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 15:38:23 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906E72DAB4
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 12:38:22 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-10d845dcf92so3949556fac.12
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=m2J7wTtVwYPR+LbO7pk/mGFbdIFDwqtYhU0XC34gWPg=;
        b=ZgDgk+IuHFw1VyAC9YVS1gHJWrj3NwDwRJL3Tfb1XTLASSVmN6Q7PzWmRamkMI23lh
         PYO2Laxz/O5g4vGeiX3hK5UwdMfllQvcLLT4gCLowa7b1xOlv87fR6JDzYrToCnUfuEp
         WnKrbhYGN8BXyoNthNpA1ZhuDCaNXQxRZsjK1nERQPMXuh3WyOgJAkfwXmmb53AiRLDT
         yOBPRp7qCgajFjKARkSymFLtHYtdMtWYTj0uqHv5XRKwGC9g+l2d1DZUge6Pdj4E+G6C
         eVR2Zf3al+qETK/8oRX8TTpTn3boxphNSYMxVnvsAjSH8g1ke06BXtlK/cn9m+T6M7TL
         Kbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m2J7wTtVwYPR+LbO7pk/mGFbdIFDwqtYhU0XC34gWPg=;
        b=QTVD+6U3rYisxUetPJxZUHCte4qQfx7wxw4L/dNb6q2auKyln2a4oqZ6kB4ournH6i
         YD6OljFWLW2GnCkQrFjUmqBvEzFA4SAxNEECdDi+HimMb2liCQ38hLzwuhfroGyys9gR
         0aP63o1WgtOk8zhMpgEds6t4ldLDHcgDS0EfswcggCteKWCsqN9eV0paTax2OjJd9i5W
         pGkO5NXlk2D8X962dhkszpN1aDSRaM1APpA0ODL80uJoTiwZrfYXboW77T53v6EaX6yR
         i/g2L3UDNDHBYFOcPcuKsh8NenDHToP8JHdJpGcrXpjNTSwMQzSrqM9RizTR9ayZrMdQ
         n6dg==
X-Gm-Message-State: ACgBeo1hhpPM1f6AsiSVSk+yVTo38v3lgKQkBzNK88oVUWSATa92KjCk
        +mvcAfUQ5VcJkAdSnydbUfESEC/q6vPI
X-Google-Smtp-Source: AA6agR6H6/Ga3XCimwuYV3VEaCZHJmCQjWdg/d3ambiyscqwQGY4jruume7Yv8SinskjxTWdrL/JyA==
X-Received: by 2002:a05:6870:5aa:b0:10d:7d87:25b5 with SMTP id m42-20020a05687005aa00b0010d7d8725b5mr3938274oap.268.1659728301813;
        Fri, 05 Aug 2022 12:38:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:3928:8f07:23c6:89bf? ([2600:1700:e72:80a0:3928:8f07:23c6:89bf])
        by smtp.gmail.com with ESMTPSA id 66-20020a4a1545000000b0042313f42b26sm847383oon.39.2022.08.05.12.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 12:38:21 -0700 (PDT)
Message-ID: <41f85d57-596a-5e42-756c-93fe0f45185f@github.com>
Date:   Fri, 5 Aug 2022 15:38:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 06/10] builtin/diagnose.c: create 'git diagnose'
 builtin
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
 <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
 <73e139ee377f9c50e671b0d94a28b93c1db28a69.1659577543.git.gitgitgadget@gmail.com>
 <220804.86zggkecmk.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220804.86zggkecmk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/4/2022 2:27 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Aug 04 2022, Victoria Dye via GitGitGadget wrote:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> Create a 'git diagnose' builtin to generate a standalone zip archive of
>> repository diagnostics.
> 
> It's good to have this as a built-in separate from "git bugreport",
> but...
> 
>> +git-diagnose - Generate a zip archive of diagnostic information
> 
> ...I'd really prefer for this not to squat on such a common name we
> might regret having reserved later for such very specific
> functionality. I'd think e.g. these would be better:
> 
> 	git mk-diagnostics-zip
> 
> Or maybe:
> 
> 	git archive-interesting-for-report

These are not realistic replacements.

> If I had to guess what a "git diagnose" did, I'd probably think:
> 
>  * It analyzes your config, and suggests redundancies/alternatives
>  * It does some perf tests / heuritics, and e.g. suggests you turn on
>    the commit-graph writing.

These sound like great options to add in the future, such as:

   --perf-test: Run performance tests on your repository using different
   Git config options and recommend certain settings.

(This --perf-test option would be a great way to get wider adoption
of parallel checkout, since its optimal settings are so machine
dependent.)

The thing is, even if we did these other things, it would result in
some kind of document that summarizes the repository shape and features.
That kind of data is exactly what this version of 'git diagnose' does.

For now, it leaves the human reader responsible for making decisions
based on those documents, but they have been incredibly helpful when we
are _diagnosing_ issues users are having with their repositories.

Thanks,
-Stolee
