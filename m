Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C54C43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 13:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiGZNct (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238691AbiGZNcs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 09:32:48 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9C2871B
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:32:47 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10e4449327aso637151fac.4
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=muGrzxX5iKTOCUKlm6sYBjy2ZZ5cK032hts6n8ZjYJQ=;
        b=VInNQUUeTW3Zy5bUh/r9nNrPP5771fOTAvEjRRJMfpH0xFykbyAJc3KcePj/6PQ22g
         NQubduct+GFEJ+T2VMk1nb20bPnkzTBnoJUfFYNu7VSAnmpN7bxb2Ssb1d1nF1nggLUP
         LJ3bGTmfNbIQedkzfK+H3W9ltTOo181PtkKqZrbcLpLYzJIKaumSPAW2EbH6NgS2aleS
         /evtMh/DToT6G5bc2RDHvNUMU+4e/lnFQQzybLsP0MysMALc+Sk101QYHArbPGAS2jTK
         CQAQjQ/KIeEGhfy53sVYT2SqCthzBbntG6glkoVA/q3sQayN6iWSlGK+fhiCVkGOUnca
         7w/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=muGrzxX5iKTOCUKlm6sYBjy2ZZ5cK032hts6n8ZjYJQ=;
        b=0nSDIrGgVGKV8Rvn5zpVyGeXbYk7HBVCjWh9/9gPEEM3s2Hm1tJvlQEli/I77e55M9
         YN2s54KamsdfwWiz3ciahLBHZpQNbmY4W0C78XQXJJJjoC0nmU/YFpVp5RxE2FEh9hbh
         /STifSqqpQ4W+7Yy4onGGHYAsppk8JCeNYQaxLVg0IdULMU7Q2kpFt+niB34f+q2WLyD
         DA+AlREPP2+QR4lmosTemtyUnDhQ7gaNcMT+jriucUHChlj95pE9xhaMJzuY7xmEURJm
         bWwqJUuYFeGA9ICJIq8YAzqRo8TpE6XNxfn86J90Wzs9LmyLm/LCjkfBfuYeaEoRW5hC
         y7xA==
X-Gm-Message-State: AJIora9MErTqCJynGbkUFgg+DW5GT2KXc2Gx9W3zGuql+ZXC7BWAW5J7
        5Bn9Wh7AchmVsY50+aJoi4J0
X-Google-Smtp-Source: AGRyM1vny/uoMTI6xMAsWjGW5KxNdgzlYDoL7mN+JXawmREY1kIsC955Iy+TPco67lnSwvH4X4Itng==
X-Received: by 2002:a05:6870:e9a8:b0:10c:685a:15a4 with SMTP id r40-20020a056870e9a800b0010c685a15a4mr16552530oao.110.1658842367180;
        Tue, 26 Jul 2022 06:32:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:70fc:586a:b1e2:eef? ([2600:1700:e72:80a0:70fc:586a:b1e2:eef])
        by smtp.gmail.com with ESMTPSA id f24-20020a9d6c18000000b0061c731fc92bsm6071427otq.64.2022.07.26.06.32.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 06:32:46 -0700 (PDT)
Message-ID: <733f2432-00ab-f0c2-269f-90af02b2105c@github.com>
Date:   Tue, 26 Jul 2022 09:32:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 5/6] p5310-pack-bitmaps.sh: enable
 `pack.writeReverseIndex`
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
 <e7ef420f321b3936185b2729460b1c28f5384438.1658342304.git.gitgitgadget@gmail.com>
 <Yt9A4Lh5MzHigeVe@nand.local> <220726.86bktcny14.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220726.86bktcny14.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/2022 3:15 AM, Ævar Arnfjörð Bjarmason wrote:
> Rather than comparing HEAD to your current tree it's generally better
> to do something like:
> 
> 	GIT_PERF_MAKE_OPTS='-j3' ./run HEAD~ HEAD [...]

Using the 'run' script fixes the perf test in the worktree and tests
different versions of the 'git' executable.

That doesn't work when the change is in the performance test itself.

Thanks,
-Stolee
