Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AEBC4707F
	for <git@archiver.kernel.org>; Tue, 25 May 2021 21:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86E9E610CE
	for <git@archiver.kernel.org>; Tue, 25 May 2021 21:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhEYVvG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 17:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhEYVvG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 17:51:06 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6610C061574
        for <git@vger.kernel.org>; Tue, 25 May 2021 14:49:35 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id 1so24284505qtb.0
        for <git@vger.kernel.org>; Tue, 25 May 2021 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NqjWWzWfv73ZXwviwmtYnJrPvzDgNiY7NUMCxPIsl/0=;
        b=JnQbFJmkBUiZMtvHHwdA/aJKyYUNyC8SSq6N1/GwwReMLfyJt5TGraYDuUOUHe1QC4
         CH6iaOVZDmKNbNQJ3MvT227B9Mt+spnaXzD5E4i+gBEcy/ZaqDWy0jl4pS2AvZZ5YKCp
         B61cu/vuM/zNaE0GK5Zb5sKSooS+RFgkUY56e/FXXGtfBxim4A0IRohy7WETvEEDICZj
         sQnSXEVxcwpklfqIB8B1l4y9Qgr22/eh9mle3lJCRGyb4ME59Cj3SQgRp+ZxmC22RMYz
         Czp4M0xavsYJHq93xgVwjMU0uSCm3uArZ1+Ms/5p03pCPAeRa27bYWJILWXtKnExUDKF
         mNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqjWWzWfv73ZXwviwmtYnJrPvzDgNiY7NUMCxPIsl/0=;
        b=Im0QFnXqWiagDO+rY72dcM3j4mhlpgmBBD1ipU9r6xH5LcHZu7kkdMmeUAOAve/YYi
         Hp6+G5LrBrS7C7N1zTr3oSKa3Sv6umjB7Vdd6bDaCMxEhCQzdpvXjtIhncby9W/gnRuR
         6RvuL23U5LtGyT27z7tYA2ZalMq06AMFHcSHSwJIetbt74bT6/XzibVq3Pp/sZ51KNdS
         JI381NR2BsfWCKXFC5FvdOSb5V3pASdE8rHGIDXu3BKVDQx58QHbS2pI3buUIMCD4D+L
         4cIwOJgCDFVLEBmUDzXFEQYIb0qZah+JhQWE/zTXeePmsjI9LGnz7d7AZi/wors6swDK
         VegQ==
X-Gm-Message-State: AOAM533onbyjXMgPt84yTys6Qd++x7EXaEy8bSP85wzm4+pI6DhU5fEM
        g86qMm6R1IZ//Mu3Mzi8IPaCNw==
X-Google-Smtp-Source: ABdhPJyOdq6LYeWUJ/TDQESlL5h1mTm5ux8r6uW/aw1ma5g69um8zDQ15DZpvRlgnBNk8SoIZpFsQw==
X-Received: by 2002:a05:622a:587:: with SMTP id c7mr18437195qtb.76.1621979374952;
        Tue, 25 May 2021 14:49:34 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:fd7b:5b8e:7238:b804])
        by smtp.gmail.com with ESMTPSA id f8sm302169qka.86.2021.05.25.14.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 14:49:34 -0700 (PDT)
Date:   Tue, 25 May 2021 17:49:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] t1092: use GIT_PROGRESS_DELAY for consistent results
Message-ID: <YK1w7TPnH9CB0haj@nand.local>
References: <pull.960.git.1621886108515.gitgitgadget@gmail.com>
 <YKwMU13DOtTIgaeP@google.com>
 <e35b5217-362f-fc4f-7396-08218a9abf63@gmail.com>
 <YKwd2e5VxVmU6zqj@nand.local>
 <87fsybohy5.fsf@evledraar.gmail.com>
 <YKxBIP4lkoPeCYvb@nand.local>
 <68a2bf8f-07e8-b117-a3f4-862654c781b4@gmail.com>
 <xmqqy2c3fhmy.fsf@gitster.g>
 <9d6568ee-c9bf-b349-d1a6-0bb2fcf06dab@gmail.com>
 <xmqq1r9uee3r.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1r9uee3r.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 26, 2021 at 05:46:16AM +0900, Junio C Hamano wrote:
> Well, not so well X-<.  It seems that some builds are not happy with
> this change.  See https://github.com/git/git/actions/runs/876229761
> specifically these two:
>
>     https://github.com/git/git/runs/2669177395?check_suite_focus=true#step:7:3549
>     https://github.com/git/git/runs/2669080101?check_suite_focus=true#step:6:988
>
> I suspect that it has something to do with 32-bit platforms?

Thanks. Of course, redirecting stderr into a file and halting after we
get a non-zero exit code makes this pretty hard to debug from that
output alone, but this is pretty easily reproducible on a 32-bit Docker
image:

    root@99cfe0d56673:/git-master# getconf LONG_BIT
    32
    root@99cfe0d56673:/git-master# GIT_PROGRESS_DELAY=-1 ./bin-wrappers/git status
    fatal: failed to parse GIT_PROGRESS_DELAY

Looking more closely in a debugger shows that we're failing because of
this check in 'config.c:git_parse_unsigned()':

    if (unsigned_mult_overflows(factor, val) ||
        factor * val > max) {
          errno = ERANGE;
          return 0;
    }

unsigned_mult_overflows() doesn't trigger regardless of architecture,
since even though val is large, factor is 1, so factor * val == val. But
val is much larger than max, so we fail there. 'max' is just
'maximum_unsigned_value_of_type(long)', or 2^32-1, while val is 2^64-1.

Thanks,
Taylor
