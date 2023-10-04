Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA1E7B5F1
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 11:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbjJDLSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Oct 2023 07:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbjJDLSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 07:18:09 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1F8D8
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 04:18:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c12fc235fbso10279911fa.0
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696418282; x=1697023082; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W/PMtYA3TwVz2Yqt4E2skLcsRymoYCrZLGF8BH+Q488=;
        b=EvwuPM0GIr3CQtleoqBG/xDfy441+/Thuh1PEr5GCe4W8xLItnxG7jAM3c/GfgUvlj
         SUy7Du4ZALUz3pFI/A1eS/L+FHWLuQU4Q7WTjkJFLUDLWB14gRkbo1emG/k5anKbI2D5
         x7GeRLjoBDhBuiNSg0s53kOLQP7PxsWiOwMYcY/8b07BuEaKfYnOMV8y+Yw/C4ZpisuQ
         EPBo3lZQwrp8IoyF6F+MfgIxoXlc1t4YYMZLPVDNc0SjabmpAUUAYDFKGvPMCIhqhW3J
         WrGY809BtXLkhmagjHJ4rSKTWBMWBtKKLLvgzxO1QGj9Jpxs9oY0EHRuqwpgfqkSvBCY
         EztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696418282; x=1697023082;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/PMtYA3TwVz2Yqt4E2skLcsRymoYCrZLGF8BH+Q488=;
        b=TAI2uNvPjYAB1hpHb/c9gS2C3jPpxJfv8JFEs8nCho6masDzhK+qR9m6zmEpdgZK83
         IoXKwbuCeO07sj0rPT+PG/PEZVJ4FxKbmEwFkB2jByM5CjjoE/7qQSYQ48JN/s8srp0/
         xacVZntT+sgyCdpU9IQSLaL+er4br/H0GHhxLe8ShK3062J6bOCHzteM6t/G+F8aLMYC
         qhjTDVD55boWXM2XMkPkqe3WfK1W/iA2xGMXO1sakQmB2BZMI/nrIRocNWnl8DKJv7yz
         LATY9nshH10J7gCxS3Mecz2Knu+1tU3zHUWQruijjoVeF7nPAEfFtH4R9PSAWo7DPUtV
         s+XQ==
X-Gm-Message-State: AOJu0Yw8oZ01xubDgAgocbm8GJ+X9by4U8EcAdTCOrAB7grZ464XhB0n
        8It2lYfes3j+SUnx2jZhdGCXezHHtszTnQ==
X-Google-Smtp-Source: AGHT+IE8YXbOCqrWLpccK5Sqjau8H0ckFsu5uUIhn5JkLT7RjdFVTNf52tamnkLrlyMUOQzwe47Nuw==
X-Received: by 2002:a2e:9385:0:b0:2bd:1804:29ee with SMTP id g5-20020a2e9385000000b002bd180429eemr1639868ljh.18.1696418281904;
        Wed, 04 Oct 2023 04:18:01 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f19-20020a2e3813000000b002c182a942f1sm639734lja.139.2023.10.04.04.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 04:18:01 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2023, #01; Mon, 2)
References: <xmqqedic35u4.fsf@gitster.g> <871qecgpg1.fsf@osv.gnss.ru>
        <xmqq34yr3btn.fsf@gitster.g> <874jj7lh7x.fsf@osv.gnss.ru>
        <xmqqo7hessro.fsf@gitster.g>
Date:   Wed, 04 Oct 2023 14:18:00 +0300
In-Reply-To: <xmqqo7hessro.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        04 Oct 2023 01:20:43 -0700")
Message-ID: <871qeay6tz.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Sergey Organov <sorganov@gmail.com> writes:
>>>
>>>> I believe I've addressed this in details in my reply here:
>>>> <87o7hok8dx.fsf@osv.gnss.ru>, and got no further objections from you
>>>> since then, so I figure I'd ask to finally let the patch in.
>>>
>>> You need to know that no response does not mean no objection.  You
>>> repeated why the less useful combination is what you want, but that
>>> does not mean the combination deserves to squat on short-and-sweet
>>> 'd' and prevent others from coming up with a better use for it.
>>
>> Yep, but I've asked what's better use for -d than "get me diff"? Do you
>> really have an idea?
>
> The primary point is to leave it open for future developers.

Well, I'm not actually convinced it's justified in this particular case,
but I'll re-roll with another option name, even though I suspect this
will leave short-and-sweet '-d' unused for yet another 18 years.

Just for better understanding: does it mean that *any* addition of
one-letter option is prohibited from any existing Git command? Cause it
definitely sounds this way.

And while we are at it, is it allowed to have "long" one-letter options,
e.g., "--d"?

>
> If I have to pick a candidate for "get me diff" that is the most
> useful among those currently are available, it is "give patches to
> all single-parent commit, and show tricky conflict resolution part
> only for merge commits".

I'm afraid you need to pick a candidate that will be natural for '-d',
not just most useful output for your workflows, whatever it happens to
be.

> Before "--remerge-diff" was invented, my answer would have been "give
> patches to all single-parent commit, and show combined diff in the
> compact form for merge commits", aka "git log --cc".

And this is already there as well, or do you suggest

-d == --remerge-diff ?
-d == --cc ?

> Even though we did not know if a better output presentation for merge
> commits would be coming, we did not let it squat on any
> short-and-sweet single letter synonym.

Except -m and -c, and when "better" actually came where "better" means
basic functionality that should *better* have been there from the very
beginning, you argue against it.

And then, as in your view diff is not the best presentation for merge
commits, the best will have nothing to do with diff anyway, and so won't
be using '-d' with 99.99% probability.

Then, hopefully, somebody sometime will agree that we can finally use -d
for what it fits best: diff, plain old simple diff.

Overall, please expect a re-roll with another option name.

Thanks,
-- Sergey Organov
