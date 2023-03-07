Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA77C678D5
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 16:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCGQZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Mar 2023 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjCGQZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2023 11:25:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B7E746DF
        for <git@vger.kernel.org>; Tue,  7 Mar 2023 08:23:37 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t15so12707984wrz.7
        for <git@vger.kernel.org>; Tue, 07 Mar 2023 08:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678206216;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wsyaW6zaYrqrvlhC+omeRknEN+5GscSDensF9mfGpWA=;
        b=MwFdkxSpDQQ3XkWQjE0n8Whd86IBQAGk3WkLUOqVNgGyIdT3bPNkKu37iJuRDbZ0V7
         vuIw+uaEdIG5Y1OM0Cc1DYlSEqALylfYBPmlD1hvaRK57O6d53EiTfkNC8QSvylKbAz5
         1eogMU0+zoTXTmzWtHoDk85s7qmqW6mZgxgbZyL9E1ybRxZfssFIPPSIHVReOYB2i5an
         6yfxCESWR3npJfSn/Rp9leE+2K3PoV2k460/eRgN1Yn7hhTswfif2u950KUZ5ugBBKxY
         qkyyNXQffETG8Axpc/eW8lHhd5ei+24N8SwmmW4uL5Vk159Gnha/yhgMsno00dw8KsMd
         VEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206216;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wsyaW6zaYrqrvlhC+omeRknEN+5GscSDensF9mfGpWA=;
        b=qfE+upjZGl+TBs+5OOyQaM6kNhwgyN9eOWGJ7Lwijl+MS16hC+iWiTA0uX9bg36cUK
         XSBI0JrzwOWNCMHukvCeAlJJaUriJhfNS+2cviRDNuHCP5oFvjGL96hvU1oJL/VjeLoM
         Ddl+nqJlkxVZODYiINcnK7MwvgzqB/rTMHJxUXHdr/PyQseQV+24xDpLppOoWUJzlWMC
         EerKZlnsxRygIpclFGiBwP+k+BEk0OKZVjYma4z9TxYzCE2z8a+WEy21To7n8zJMianQ
         o5ebR5RSiAbiBlF1uEDAPp4QB6ggST+aK6ezgJbL8fkyo8hkD0cqTckDzafqZUNetd5B
         lWJQ==
X-Gm-Message-State: AO0yUKVUqGhfcEo0DyyQcL0HWmDMa2byHKeAsJVTb+sSVd0RA7zc85eg
        /puxHGdqcvfyKAjrX6wYFts=
X-Google-Smtp-Source: AK7set9LY+gfC3PsNFbYCn00ppSV1klzJKgvzwmSd5kKyMxGrWjGuaKpynhXE4a7xebzp0urUgfZYA==
X-Received: by 2002:a05:6000:507:b0:2c5:4f2d:d9b4 with SMTP id a7-20020a056000050700b002c54f2dd9b4mr8717213wrf.58.1678206215852;
        Tue, 07 Mar 2023 08:23:35 -0800 (PST)
Received: from [192.168.1.212] ([90.248.23.119])
        by smtp.gmail.com with ESMTPSA id h8-20020a5d5048000000b002c592535839sm12877111wrt.17.2023.03.07.08.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 08:23:35 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5551d67b-3021-8cfc-53b5-318f223ded6d@dunelm.org.uk>
Date:   Tue, 7 Mar 2023 16:23:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] rebase: add a config option for --rebase-merges
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        Glen Choo <chooglen@google.com>,
        Calvin Wan <calvinwan@google.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230225180325.796624-4-alexhenrie24@gmail.com>
 <1021e6d0-0cd0-d92c-4cb3-45dbf2f6626e@dunelm.org.uk>
 <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
In-Reply-To: <CAMMLpeRfD+81fsEtvKFvVepPpwYm0_-AD=QHMwhoc+LtiXpavw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 04/03/2023 23:24, Alex Henrie wrote:
> On Thu, Mar 2, 2023 at 2:37 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
>> On 25/02/2023 18:03, Alex Henrie wrote:
> 
>>> +rebase.merges::
>>> +     Whether and how to set the `--rebase-merges` option by default. Can
>>> +     be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
>>> +     true is equivalent to `--rebase-merges` without an argument, setting to
>>> +     `rebase-cousins` or `no-rebase-cousins` is equivalent to
>>> +     `--rebase-merges` with that value as its argument, and setting to false
>>> +     is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
>>> +     command line without an argument overrides a `rebase.merges=false`
>>> +     configuration but does not override other values of `rebase.merge`.
>>
>> I'm still not clear why the commandline doesn't override the config in
>> all cases as is our usual practice. After all if the user has set
>> rebase.merges then they don't need to pass --rebase-merges unless they
>> want to override the config.
> 
> Given the current push to turn rebase-merges on by default, it seems
> likely that rebase-cousins will also be turned on by default at some
> point after that.

It is good to try and future proof things but this seems rather 
hypothetical. I don't really see how the choice of whether 
--rebase-merges is turned on by default is related to the choice of 
whether or not to rebase cousins by default. It is worth noting that the 
default was changed to from rebase-cousins to no-rebase-cousins early in 
the development of --rebase-merges[1] as it was felt to be less surprising.

> There will be a warning about the default changing,
> and we'll want to let users suppress that warning by setting
> rebase.rebaseMerges=rebase-cousins. It would then be very confusing if
> a --rebase-merges from some old alias continued to mean
> --rebase-merges=no-rebase-cousins when the user expects it to start
> behaving as though the default has already changed.

But aren't you breaking those aliases now when 
rebase.rebaseMerges=rebase-cousins? That's what I'm objecting to. It 
seems like we're breaking things now to avoid a hypothetical future 
change breaking them which does not seem like the right trade off to me.

It also does not fit with the way other optional arguments interact with 
their associated config setting. For example "git branch/checkout/switch 
--track" and branch.autoSetupMerge. If the optional argument to --track 
is omitted it defaults to "direct" irrespective of the config.

[1] 
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1801292251240.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz/

> I will rephrase the documentation in v6 to make it more clear that the
> absence of a specific value on the command line does not clobber a
> specific value set in the configuration, as Glen suggested.

The documentation in v6 is certainly quite clear on this point.

>>> +test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
>>> +     test_config rebase.merges rebase-cousins &&
>>> +     git checkout -b override-config-rebase-cousins main &&
>>> +     git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
>>> +     test_cmp_graph HEAD^.. <<-\EOF
>>> +     *   Merge the topic branch '\''onebranch'\''
>>> +     |\
>>> +     | * D
>>> +     | * G
>>> +     o | H
>>> +     |/
>>> +     o A
>>> +     EOF
>>> +'
>>
>> I'm not sure this test adds much value, it is hard to see what kind of
>> regression would allow the others to pass but not this one.
> 
> I was worried that I or someone else would forget to explicitly set
> rebase_cousins to 0 when no-rebase-cousins is given on the command
> line, assuming that it is already 0 because that is the default. The
> test makes me feel better, but I am happy to remove it if you still
> think it's overkill.

Given we're using the same code to parse the command line argument and 
the config setting and we have a test for 
rebase.rebaseMerges=no-rebase-cousins I think we could drop it.

>>> +test_expect_success '--rebase-merges overrides rebase.merges=false' '
>>> +     test_config rebase.merges false &&
>>> +     git checkout -b override-config-merges-false E &&
>>> +     before="$(git rev-parse --verify HEAD)" &&
>>> +     test_tick &&
>>> +     git rebase --rebase-merges C &&
>>> +     test_cmp_rev HEAD $before
>>
>> This test passes if the rebase does nothing, maybe pass --force and
>> check the graph?
> 
> The rebase is supposed to do nothing here.

It's not doing nothing though - it is rebasing the branch, it just 
happens that everything fast-forwards so HEAD ends up unchanged. My 
point is that this test should verify the branch has been rebased. Maybe 
you could check the reflog message for HEAD@{0} is

	rebase (finish): returning to refs/heads/override-config-merges-false

> Checking that the commit
> hash is the same is just a quick way to check that the entire graph is
> the same. What more would be checked by checking the graph instead of
> the hash?

By using --force and checking the graph you check that the rebase 
actually happened.

Thanks for working on this

Phillip

> Thanks for the feedback,
> 
> -Alex
