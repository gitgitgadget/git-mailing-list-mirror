Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884FDC433EF
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 12:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609266109E
	for <git@archiver.kernel.org>; Sat, 23 Oct 2021 12:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhJWMNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Oct 2021 08:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhJWMNC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Oct 2021 08:13:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A985BC061764
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 05:10:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q2-20020a17090a2e0200b001a0fd4efd49so9003240pjd.1
        for <git@vger.kernel.org>; Sat, 23 Oct 2021 05:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ynP3MXVx1pctJkNhPpLiroPFM58h3Lug48iAP4nMnUg=;
        b=NyvjlcyrD6Tb7MkKAQqTNrrwvd7O5gejjOxk6tIqZuXOSYEUVAx5YhEQ3nNzDkUJdl
         Y2TL2a2iMqN/soM2gBxCvdKOIFlsvpR+Bnc3bsV/+s7S4vsL+R37hIkakUnVWbnlEXBb
         bs8vRFMu8OijJVenB85z19gJHEi6NLQsRAnZ1zXbvfGm+lzEy0CiHrmH8cnq1nNP4i2B
         92tUaLC0fBOHv1dl3TttvPjkD2+kNDJLbsuuATAwkwr/jVMQma0CQix9v8+a4sxg2Blh
         qo5AufR++oaqidT6p9sOIgCNWAKRVOrTnF6DEE/loxNXA9bQNxAp++p1+VblYYi/4nNp
         Nr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ynP3MXVx1pctJkNhPpLiroPFM58h3Lug48iAP4nMnUg=;
        b=SzXAIQmGgbmD5QQfMoaQOfzwc5XgD+XnZnMyIc8lJpMIl5tNJJuMImn9RQealOXFzN
         MCQ+x+Ar7S5MeS5tL7w664IKYN9yD6vtErMRWIlT6Cb66J0+nOsjfrdVLO/wuUs8Dn09
         xGwyPAqKsb68KSEy7vjtHW7ksd0UNRzAmtgvKyVJxFuD3/sstiy+XtAtPtmsKV3rteWg
         k5ps40VIz6JtgOWJxkL00Wps/uzYFre37gKnx0l5hder79nR3l5o3do7E1hx38IBb50O
         Ab2k3+Lg7ZzKCuQdP+sKDyIIAEHvGu3sMyTythKgdBMojiELxVPfHaYa3MXzdT1XucIb
         v0nA==
X-Gm-Message-State: AOAM533293XjwuxjG4Q8FSCuEZf/+rFBH4RzTMQDYAR0kChpaxURM00J
        BsOEl7HI6/tQoW8EAgATpjv32yHEOfM5PFAs
X-Google-Smtp-Source: ABdhPJy0kuQbwVsn0+csz6fuktIdmLKPov7J8CTaqFBl7OLBRJwxwqkZnyukCjF6sVnltC7D5eafnA==
X-Received: by 2002:a17:90a:8912:: with SMTP id u18mr6473159pjn.69.1634991042534;
        Sat, 23 Oct 2021 05:10:42 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-77.three.co.id. [180.214.233.77])
        by smtp.gmail.com with ESMTPSA id m22sm13057169pfo.176.2021.10.23.05.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 05:10:42 -0700 (PDT)
Message-ID: <376fa19b-0e3f-1ccb-6c25-c9aa86fc0707@gmail.com>
Date:   Sat, 23 Oct 2021 19:10:39 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Bug report: branch display in git stash output
Content-Language: en-US
To:     Kraymer <kraymer@gmail.com>, git@vger.kernel.org
References: <CAAjS6zO2E043KEcqEJr_5QbtdZEjxVWObCc518Ti3sW-p6LX5A@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAAjS6zO2E043KEcqEJr_5QbtdZEjxVWObCc518Ti3sW-p6LX5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/10/21 14.21, Kraymer wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
> ❯ git checkout -b branch/with/slash
> Switched to a new branch 'branch/with/slash'
> ❯ echo "foobar" > foobar.txt
> ❯ git stash
> Saved working directory and index state WIP on slash: 41dc5da git:
> update .gitconfig
> 
> What did you expect to happen? (Expected behavior)
> 
> ❯ git stash list
> stash@{0}: WIP on branch/with/slash: 41dc5da git: update .gitconfig
> 
> What happened instead? (Actual behavior)
> 
> ❯ git stash list
> stash@{0}: WIP on slash: 41dc5da git: update .gitconfig
> 
> What's different between what you expected and what actually happened?
> 
> the displayed branch name in `git stash` output is truncated

I can reproduce the issue using this reproducer:

```

mkdir test && cd test &&
git init &&

# make initial commit first, since git stash requires it
echo "./" > slashdot &&
git commit -m "slashdot" &&

# stash WIP
git checkout -b slash/dot &&
echo "slashdot" >> slashdot &&
git stash push -m "slashdot"
```

Note that when stashing, the message says "Saved working directory and 
index state On dot: slashdot" although we are currently on `slash/dot` 
branch.

-- 
An old man doll... just what I always wanted! - Clara
