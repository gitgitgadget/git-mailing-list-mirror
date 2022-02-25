Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107A2C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 12:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240846AbiBYM7q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 07:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240839AbiBYM7o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 07:59:44 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C621EBAB9
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 04:59:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id h15so7296712edv.7
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 04:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=UyxeaOCgrrwOOcieiRsnHtUFmmI4/fvUbOdZpeoq1tM=;
        b=Dt09HCz8cKHGDSz47R0k/34aKJRj0WbHoFhOzGALYu72vSIEWDU7Ufjmeez45jXObN
         wbJMyaIL3uAos363DgAtad61Vapqrpm7oMo37xUBZXree0/Va47Ls41+3O0Dx2jp3+YD
         raAyv2A2S951KLCSa/2QAhV7dIoVBmPD7m8ZFDV9zydY6WlO7tHf5U0d4aL9BGbRAElY
         px+2LuHq/IX+O/X2smW9olB9V5043dM7bNmGvxz9WDR+8aq1tsgTrDLzw8cNq8+dc3Z7
         6grMyQtDgGxrUCzkitzvRzsv6wWGS1uu5hpcKURDV8c6uESGxW6yFHpjcoVN7qokRubl
         6KPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=UyxeaOCgrrwOOcieiRsnHtUFmmI4/fvUbOdZpeoq1tM=;
        b=oJAyfj9z1jmCYp7pmxNFiX6mKixDz2skmp2Cy1m0e01EA5U0S3/MBsoqMYVXWFbvVV
         M96h1w99F5OVpZT7TKJkEsKxUQmOh/knYQS5rA+dPC5OnSerz6tPQmFlzCJ0nSrM8FtN
         O9DYlSKiNcvYn0HH4Qsxey9B/WZ+W4yQPM0bTju8mZQTg8vtQ0gX8Grgk25JUdhswDDg
         wuOjR22+CzW9luvRiero1OIqC52ZyDxnqzeJ+wB855wHgfEArCmn8ku5dHuErcjKq8dn
         zjMWrXzTe/jj9S8cU7if7pnQBIF0jFfDfgla/6d58gNLhrKGMromThJ8ce3jqb/8d0bS
         a9Ng==
X-Gm-Message-State: AOAM531YpFdJusqBJ+UNp3Nok1NUlXEMRft4+adtTb64nu0brYxf8Jmr
        /TnjmgP/t85jWYtRLaafiiQ=
X-Google-Smtp-Source: ABdhPJzEkgSlXXeYYFD5pxoU4WXu8TeWvsT8K329B07E6QD8raPdM84FNFSZAkcRG17YHhsUJO4CBg==
X-Received: by 2002:a05:6402:254b:b0:412:d172:2607 with SMTP id l11-20020a056402254b00b00412d1722607mr7068319edb.80.1645793950478;
        Fri, 25 Feb 2022 04:59:10 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id ie19-20020a170906df1300b006bc52a7e928sm956828ejc.111.2022.02.25.04.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:59:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nNaBh-000WuT-5C;
        Fri, 25 Feb 2022 13:59:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Fri, 25 Feb 2022 13:39:54 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
 <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
 <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
Message-ID: <220225.868rtz85lu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 23 2022, Phillip Wood wrote:

> On 22/02/2022 13:31, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> [...]
>> So just to make the point about one of those mentioned in my [1] with
>> some further details (I won't go into the whole thing to avoid repeating
>> myself):
>> I opened both of:
>>      https://github.com/git-for-windows/git/runs/4822802185?check_suite_=
focus=3Dtrue
>>      https://github.com/dscho/git/runs/4840190622?check_suite_focus=3Dtr=
ue
>> Just now in Firefox 91.5.0esr-1. Both having been opened before, so
>> they're in cache, and I've got a current 40MB/s real downlink speed etc.
>> The former fully loads in around 5100ms, with your series here
>> that's
>> just short of 18000ms.
>> So your CI changes are making the common case of just looking at a
>> CI
>> failure more than **3x as slow as before**.
>
> I don't think that is the most useful comparison between the two.[...]

I'm not saying that it's the most useful comparison between the two, but
that there's a major performance regression introduced in this series
that so far isn't addressed or noted.

> [...]When
> I am investigating a test failure the time that matters to me is the
> time it takes to display the output of the failing test case. With the
> first link above the initial page load is faster but to get to the
> output of the failing test case I have click on "Run
> ci/print_test_failures.sh" then wait for that to load and then search
> for "not ok" to actually get to the information I'm after. With the
> second link the initial page load does feel slower but then I'm
> presented  with the test failures nicely highlighted in red, all I
> have to do is click on one and I've got the information I'm
> after. Overall that is much faster and easier to use.

Whether you think the regression is worth the end result is a subjective
judgement. I don't think it is, but I don't think you or anyone else is
wrong if they don't agree.

If you think it's OK to spend ~20s instead of ~5s on rendering the new
output that's something that clearly depends on how much you value the
new output, and much much you're willing to wait.

What I am saying, and what I hope you'll agree with, is that it's
something that should be addressed in some way by this series.

One way to do that would be to note the performence regression in a
commit message, and argue that despite the slowdown it's worth it.
