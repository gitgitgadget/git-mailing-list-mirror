Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D71C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 02:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiCCCDA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiCCCCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 21:02:51 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F58C38AB
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 18:02:07 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id bm39so2940523qkb.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 18:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DU6sWuKgYJ/d9pO1aczMVDvB1QLo9JVIti4iYApzqh4=;
        b=baMQ13qAJzODsB+1ZOh5Ic8eLVNSlJWwq8c6HdvQrU0/4kLusGdFcC06AOz9TbCZ6b
         Ovh/D5UQTJQMgbCZDFqOVNBroG9fpxWw3uLNIEG0sCTxekQwHmXcY7l9G8z24dBS5BlP
         u5tHF2sLSrUGQ/VWuu6BLbzsaIv1Rwa1Wzlyo2F3rCd76f8FEzP2G0HAegYApcFj/thx
         vcEaESiTHI61zlYBmURxxpmpsPNttvuPps4RwjmTiaatxHYyrllB+y7BKjs42BzgiFPM
         DjLd3NrlZCnFV1mj6WAqS5fRf2qvxPJGZJSzt5GuJcp53c5c+Vo9Bvrk0RievZ5OM59h
         h7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DU6sWuKgYJ/d9pO1aczMVDvB1QLo9JVIti4iYApzqh4=;
        b=QEz53ENoL63hXnhOKnA3HYNhC2HW68vg9PyiNupL95/e7UzjKeArI4p70OfJE9IT2E
         BkzhMLLX+GmJoxYkZTkLryAA1BYcxBLE6DiiHe9cHaBXovvFPfOQRAMZiIbcHDPgV2Uq
         YAwuXWc0g56EiysFW2g4yhnC+xTlA1lEZPvoaPQudWKGbnmGGrzR9ESD+3aTuNoezVWE
         dIXdokNevR7MQ/ePbw7W9tfCJX3lnCn2jTKR/ZTDlS7YPvHmy8JwqSTQn5800lMkKCPL
         ZkdMTqOmZyFfA1QC5uZn9SMw1YdiXXgIIZHDymJyzqNsNBunXzE2ZdCWsiwiYwgZQHfl
         jzZg==
X-Gm-Message-State: AOAM531dv6qgnZcZi1Ux6lXdlWBUIQaE2fUDyZ7fcFN1DH00YfoGwcQb
        cwAdT17lVNP/sCkPB0eIwsy+
X-Google-Smtp-Source: ABdhPJw+NDWJoK3Y70fsDyWi1MiA99ZcI4egLm4WNSUuUiqyl0kMYC8B7afCVr+PJI9wHQp9KF1FKg==
X-Received: by 2002:a37:4550:0:b0:47f:55f2:7e86 with SMTP id s77-20020a374550000000b0047f55f27e86mr18327417qka.384.1646272926746;
        Wed, 02 Mar 2022 18:02:06 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id f13-20020ac87f0d000000b002dce143f369sm550589qtk.53.2022.03.02.18.02.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 18:02:06 -0800 (PST)
Message-ID: <76a1ff22-3eb0-08fb-5aa9-e612ee5b522f@github.com>
Date:   Wed, 2 Mar 2022 21:02:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/2/2022 12:27 PM, Ævar Arnfjörð Bjarmason wrote:
> This series fixes issues where we ignored the exit code of "git" due
> to it being on the LHS of a pipe, or because we interpolated its
> output with $() in a "test" construct, or had missing &&- chains in
> helper functions etc.
> 
> This series is not made by string-replacing things in our test suite,
> if it was it would be much larger. These are all tests I've seen real
> hide real failures under SANITIZE=leak, either on current "master", or
> in combination with various local leak fixes I've got unsubmitted.

My first reaction was to check that Subham was on the CC line (yes)
because they have been working in this space, too. Your focus on
examples that break SANITIZE=leak is appreciated so there is room
for that project.

> In cases where I was starting to fix a pattern in a file I'd fix the
> rest of the file if it was easy, but otherwise these are all cases
> where I ran SANITIZE=leak, had a test pass, but having ASAN_OPTIONS
> log to a file revealed that we had memory leaks within that test.

Neat trick.

The patches in this series clearly do the right transformations to
expose these errors at the appropriate time. The only time I got
hung up was patch 11 where test_expect_failure was swapped for
test_expect_success (while also dropping a test_must_fail inside
the test). The double-negative confused me at first, but in the end
the patch works as-is.

> As an aside we still have various potential issues with hidden
> segfaults etc. in the test suite after this that are tricked to solve,
> because:
> 
>  * Our tests will (mostly) catch segfaults and abort(), but if we
>    invoke a command that invokes another command it needs to ferry the
>    exit code up to us.
> 
>  * run-command.c notably does not do that, so for e.g. "git push"
>    tests where we expect a failure and an underlying "git" command
>    fails we won't ferry up the segfault or abort exit code.

Perhaps run-command.c could auto-exit for certain well-known error
codes that could only happen on certain kinds of failures (segfault,
for example). A simple die() might be something that is expected to
be handled by the top-level command in some cases.

>  * We have gitweb.perl and some other perl code ignoring return values
>    from close(), i.e. ignoring exit codes from "git rev-parse" et al.
> 
>  * We have in-tree shellscripts like "git-merge-one-file.sh" invoking
>    git commands, and if they fail returning "1", not ferrying up the
>    segfault or abort() exit code.

These are more involved and harder to evaluate. Add them to the pile
of projects for new contributors?

Thanks,
-Stolee
