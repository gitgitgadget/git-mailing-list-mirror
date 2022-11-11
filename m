Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F93C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 22:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbiKKWIy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbiKKWIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 17:08:12 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120E5B85D
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:07:44 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id y6so4516328iof.9
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 14:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Lbfmf8aHFWMYGGIgu9HU3phgCJs5doyppkwelbnhEO8=;
        b=7OALeFdDx6s94teoYs6pXdEoJFJtFN3BxhH5OK1KsAn2YgEKy6ngGRKOCtwzXFIkue
         tr9T4weYM7TwTAbcPxx/UYRx3HNASwk8IFKbelcEXIaE8GccbD16LiXtZTjsf0jlGf4t
         5UzjsBrNskciTCF+BuhFtG0eSYzuKUuMe/naiEqhOpYW0kIQ94mDVflEMcKfutVgq+89
         RcjmAwaRQtJboI84BmKmO0Bv27mEKcXbKpNwHzXlm+VO4xs/d+1Z3WGa3MO4JgbezibF
         2K+EpBSTWQ40Gm6kNGio6ULHmY0x/ZwyB0GbPS8A0/+asqO9wxb7q1CRgMpVHsIrfEsq
         tMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lbfmf8aHFWMYGGIgu9HU3phgCJs5doyppkwelbnhEO8=;
        b=qj0LE021qgKlM4F9II7maGiGnlZnyrPY7PuvuHMDWZiDBIPD6vpWabQeF8/TImnru1
         bwi4aDPmmhZIRmRMPzCdNIcgHaMUsQ8/6gRszln+uUfSldCAw40472e3C1N2r/p66Aka
         Sr7e73G894u3ZQkyOWYBrZJDLZkymzSdXipZU5BTiMLU4MS4inIMSMnmSJC2XxqdnH/A
         qSD3MWcyZeLYYnORBm6LCXwgN5IoixE/Oo8/ChvJ6i5DKgddP0PtnLg3UpP8pOGtjaa2
         IuJEDqcHtI9o7nI7dPuRCPk1TTZvjemCtAIx2DM07NfDkXuWSrTWptAMFOPhb0uyFzMr
         j/aw==
X-Gm-Message-State: ANoB5pnuTVefbmcUnkhCkA+pZyQ7L909vD/hovwW1aBcYR6KLXy5C7rw
        3ie0vWBiOH34/y0nvpT8i9tDXQ==
X-Google-Smtp-Source: AA0mqf4+onQCMaAUX+jD2GkvE3ITMsemKT8cyOfABckr5gcDbRuGtLWUdaRSYcpFPGmp9h30NPJbbg==
X-Received: by 2002:a05:6638:3e8e:b0:371:874a:26b5 with SMTP id ch14-20020a0566383e8e00b00371874a26b5mr1633733jab.113.1668204463888;
        Fri, 11 Nov 2022 14:07:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q12-20020a0566022f0c00b006cab79c4214sm1204636iow.46.2022.11.11.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 14:07:43 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:07:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 00/11] Turn git-bisect to be builtin
Message-ID: <Y27Hrkruh6++7NkO@nand.local>
References: <cover.1668097286.git.congdanhqx@gmail.com>
 <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2022 at 11:36:35PM +0700, Đoàn Trần Công Danh wrote:
> This series finish the git-bisect porting from shell script into a C builtin.
>
> This series can't be applied cleaned on master, it needs to be applied on top
> of the series posted at:
> https://lore.kernel.org/git/cover.1668097286.git.congdanhqx@gmail.com/
> AND the series rs/no-more-run-command-v, which has been integrated to next.

Thanks, having both was helpful. Note that 'rs/no-more-run-command-v' was
merged into 'master' via be4ac3b197 (Merge branch
'rs/no-more-run-command-v', 2022-11-08), so picking up these new patches
only needed a merge of the other series.

> Johannes Schindelin (2):
>   bisect--helper: handle states directly
>   Turn `git bisect` into a full built-in
>
> Ævar Arnfjörð Bjarmason (4):
>   bisect tests: test for v2.30.0 "bisect run" regressions
>   bisect: refactor bisect_run() to match CodingGuidelines
>   bisect test: test exit codes on bad usage
>   bisect--helper: emit usage for "git bisect"
>
> Đoàn Trần Công Danh (5):
>   bisect: fix output regressions in v2.30.0
>   bisect run: keep some of the post-v2.30.0 output
>   bisect-run: verify_good: account for non-negative exit status
>   bisect--helper: identify as bisect when report error
>   bisect--helper: log: allow arbitrary number of arguments

Looking good to me. Is everybody happy to start merging these two down?

Thanks,
Taylor
