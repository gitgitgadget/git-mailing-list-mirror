Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E5BC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 09:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356402AbiCYJPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242463AbiCYJPF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 05:15:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E4EABF79
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 02:13:29 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r23so8522737edb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ElNvT+nPcK7silNWQnB4pd4pTNux6Ny6bcQM3PpQb0M=;
        b=KLJpSHYXDw5XhMOyJtkAkG0PWPbYJieDi3KU60o0/15GbN+HgSBzWQOmKPeZXwWUyj
         Bywux8DaHUH7DFiqQBRtGb6fVVm+z6PaSjksKwR0QiJfz9l+eaV78sKVzDqbwCTO9XSi
         druHbYCNBKGBje48aJSvmEPVWJHhDrN1IBHx+lIGiBlc/o5BfzbdqvZry97UDbcm744f
         6ea8BtFs/6Q9wqcwny6mxiNBTL8IR8W58PxCVGtKGqT51gBmw0iUivXKDh54I7HhoeHT
         kC44gmuStayfQLYetKRRIyJdCUflvuGH+bPkJyjUjygDdc3V4AKqNhYio8+VTNoD/uhk
         vyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ElNvT+nPcK7silNWQnB4pd4pTNux6Ny6bcQM3PpQb0M=;
        b=5Yi94Q4PamsMLdlrrlCUVZZ97RmkzGRD1mqzcQ8eGkgYeiuj4G2zHh7z+wnWeBsxX9
         5zlOFiCJKH5kLQ0KroovLGeagT4arZtPJQNrEFV8vSuAsV0lC8BbS6wjCgkc6g4rWYS8
         jRCo6Yc+H3LcYCzFE0C/2nd7O1ek63YPOYUuA3C77Z0c9bkj+xDyGgrFdWzdPRXXstFl
         Bpc8z3i0FEjiYaAVnSiod7efCkulIMahs11KZzGE65CgKdSt22XINFvizR1v+PbDKzYF
         c4jOx0DRAOKmAe3x0XwFyc2QpQUqi1I3jdXuBDtjBO9Ebc9p2pYLjIoxUwZSTsjs+HhQ
         M8zw==
X-Gm-Message-State: AOAM531RGOZP8Lg+LHZDWTIN7kA3Q3RlQhf5C9XI7tU2Dr2S3DbVdMuP
        s40HyN5XiAl8tTzTxXlZSio=
X-Google-Smtp-Source: ABdhPJympmyQczsukYLP2gW5AvOHxkyGSUCiutCMzTGTdjcjWg4/dMIJxOUT56NlCHTB57cNA2UkfA==
X-Received: by 2002:a05:6402:3549:b0:419:343c:521 with SMTP id f9-20020a056402354900b00419343c0521mr11670522edd.85.1648199607672;
        Fri, 25 Mar 2022 02:13:27 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id r23-20020a056402235700b00419171bc571sm2645285eda.59.2022.03.25.02.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 02:13:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nXg0c-001rAv-GH;
        Fri, 25 Mar 2022 10:13:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
Date:   Fri, 25 Mar 2022 10:02:07 +0100
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
 <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>
 <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>
Message-ID: <220325.864k3mmm2x.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 24 2022, Victoria Dye wrote:

> Johannes Schindelin via GitGitGadget wrote:
> [...]
>> Is this the best UI we can have for test failures in CI runs? I hope we can
>> do better. Having said that, this patch series presents a pretty good start,
>> and offers a basis for future improvements.
>> 
>
> I think these are really valuable improvements over our current state, but I
> also understand the concerns about performance elsewhere in this thread
> (it's really slow to load for me as well, and scrolling/expanding the log
> groups can be a bit glitchy in my browser). That said, I think there are a
> couple ways you could improve the load time without sacrificing the (very
> helpful) improvements you've made to error log visibility. I experimented a
> bit (example result [1]) and came up with some things that may help:
>
> * group errors by test file, rather than by test case (to reduce
>   parsing/rendering time for lots of groups).
> * print the verbose logs only for the failed test cases (to massively cut
>   down on the size of the log, particularly when there's only a couple
>   failures in a test file with a lot of passing tests).
> * skip printing the full text of the test in 'finalize_test_case_output'
>   when creating the group, i.e., use '$1' instead of '$*' (in both passing
>   and failing tests, this information is already printed via some other
>   means).
>
> If you wanted to make sure a user could still access the full failure logs
> (i.e., including the "ok" test results), you could print a link to the
> artifacts page as well - that way, all of the information we currently
> provide to users can still be found somewhere.
>
> [1] https://github.com/vdye/git/runs/5666973267

Thanks a lot for trying to address those concerns.

I took a look at this and it definitely performs better, although in
this case the overall output is ~3k lines.

I'd be curious to see how it performs on some of the cases discussed in
earlier threads of >~50k lines, although it looks like in this case that
would require failures to be really widespread in the test suite.

I just looked at this briefly, but looking at the branch I see you
removed the "checking known breakage of[...]" etc. from the non-GitHub
markdown output, I didn't spot how that was related/needed.

>> Johannes Schindelin (9):
>>   ci: fix code style
>>   ci/run-build-and-tests: take a more high-level view
>>   ci: make it easier to find failed tests' logs in the GitHub workflow
>>   ci/run-build-and-tests: add some structure to the GitHub workflow
>>     output
>>   tests: refactor --write-junit-xml code
>>   test(junit): avoid line feeds in XML attributes
>>   ci: optionally mark up output in the GitHub workflow
>>   ci: use `--github-workflow-markup` in the GitHub workflow
>>   ci: call `finalize_test_case_output` a little later
>> 
>
> The organization of these commits makes the series a bit confusing to read,
> mainly due to the JUnit changes in the middle. Patches 5-6 don't appear to
> be dependent on patches 1-4, so they could be moved to the beginning (after
> patch 1). With that change, I think this series would flow more smoothly:
> "Cleanup/non-functional change" -> "JUnit XML improvements" -> "Log UX
> improvements".

Have you had a change to look at the approach my suggestion of an
alternate approach to the early part of this series takes?:
https://lore.kernel.org/git/cover-00.25-00000000000-20220221T143936Z-avarab@gmail.com/

I.e. to not build up ci/lib.sh to know to group the "build" etc. within
the "run-build-and-test" step, but instead just to pull those to the
top-level by running separate build & test steps.

