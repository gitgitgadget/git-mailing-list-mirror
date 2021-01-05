Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E30C4332B
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D1B22CB9
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 16:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbhAEQur (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 11:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbhAEQuq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 11:50:46 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B346C061574
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 08:50:06 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id d203so244662oia.0
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HDeGSOaLq9ZtICY+ZjCR9Y+lw0OaLXwdRMkwayz3IBM=;
        b=tvieSX09sFKbZnEu7W/BQntnVshXUQsSTOOlQsyXmHhkgzyk93IdTK72FVW6sKFITW
         DWzR1A918OHdxMJzTTedtE+WI4m4GEvnM4joqSSmY+1NaFGZGDnTl8oVZA2nc6ViIZRA
         qvyMPlTzqIPZ2NKKbM8FFzZhNuNDgk25JBCejvZ94pCuP1qGty8P5VCYQWUqMSUxiiVs
         43ELzl2Zrq3aiXF7zfxv0SA8BLdc1ACHNR8AnWbJK1Lcehy2nS4lX3ROjKnIaxhnzpqC
         7E2Fa2TgZiykrD7WSWMIgJaJj9pf4lhlmh0vd0PRcsQF2RUzVsP0yCsxlCFk+nyjwPqK
         5vrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HDeGSOaLq9ZtICY+ZjCR9Y+lw0OaLXwdRMkwayz3IBM=;
        b=DEdcWIYYR4LqWaJ/gbdiioq2hCbEUXyyPz+HyhtPQ7QhIOVdwnjg2c2il/4Z6MgetM
         esm45w7XTAWmIN6vKJ4W0sbGe456zNy8pdKFyE75C+goJV5W/qtC1fajwlqOI4eyc/1N
         WQPePp+JLt0llMPDFe2EkJ1LeMNuCn7+ybhZvRDRqE18CW36BpF4bGu1yYAqATxSgQu1
         j192wTEDNvB+Z+KxE28/AuPn3VbXl+sNSXHJHplnO3FB0xsyyjlQryt0Hw34xKOR7+fi
         uOW9AwHybvs0VwbAGim9Z4DP13vRbQDTkItVsuYadKwVdIXCIoqEKHOWOfUfE3Ud6NTg
         529w==
X-Gm-Message-State: AOAM5315IBu5RYvjgr8RBzOscGLk+jdbhDhCT5lknlTygm7R4AT6lbbY
        rQsNHYysAzQgt/6D+0cq7ro=
X-Google-Smtp-Source: ABdhPJxlQYH2O/o17BenssHgG1jlpzDi5dS9CjDMiYrumjA2+539Vg4gmeKKTY0MP9WSVPx+jFkbtw==
X-Received: by 2002:a54:400f:: with SMTP id x15mr334836oie.38.1609865405491;
        Tue, 05 Jan 2021 08:50:05 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id p28sm20366ota.14.2021.01.05.08.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 08:50:04 -0800 (PST)
Subject: Re: [PATCH v6 00/13] Rewrite the remaining merge strategies from
 shell to C
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20201116102158.8365-1-alban.gruin@gmail.com>
 <20201124115315.13311-1-alban.gruin@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <25a92f4c-1d7e-45bb-0a05-2f82586867ad@gmail.com>
Date:   Tue, 5 Jan 2021 11:50:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <20201124115315.13311-1-alban.gruin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/24/2020 6:53 AM, Alban Gruin wrote:
> In a effort to reduce the number of shell scripts in git's codebase, I
> propose this patch series converting the two remaining merge strategies,
> resolve and octopus, from shell to C.  This will enable slightly better
> performance, better integration with git itself (no more forking to
> perform these operations), better portability (Windows and shell scripts
> don't mix well).
> 
> Three scripts are actually converted: first git-merge-one-file.sh, then
> git-merge-resolve.sh, and finally git-merge-octopus.sh.  Not only they
> are converted, but they also are modified to operate without forking,
> and then libified so they can be used by git without spawning another
> process.

This is a worthwhile effort. Of course, I wasn't familiar with this
area and only took interest when I started working in a conflicting
area.

I did my best in reviewing the content here. I did not comment further
on the patches where Junio already gave extensive review.

> This series keeps the commands `git merge-one-file', `git
> merge-resolve', and `git merge-octopus', so any script depending on them
> should keep working without any changes.

I pointed out some questions about the "dashed versus non-dashed"
forms.

> This series is based on 306ee63a70 (Eighteenth batch, 2020-09-29).  The
> tip is tagged as "rewrite-merge-strategies-v6" at
> https://github.com/agrn/git.

Please also base onto 722fc37491 (help: do not expect built-in
commands to be hardlinked, 2020-10-07) as requested by Szeder.

Thanks,
-Stolee
