Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A3C04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239596AbiHXVhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238115AbiHXVhP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:37:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9918642FB
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:37:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id c2so16827091plo.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc;
        bh=g4L944ae2cIUAvuzp6X+TmnXKa7Wn5dOfjhGDf3cAeo=;
        b=ZwYC8HLcnvFFidCUM4EZpzpxH66ZuSKs+d1kRt2VhHYwgOL6BSL85DS6/98DgmIN2R
         wz4ME6+OhxLjIxRGRTom/2KnJNRXyrwyCud6PG8vH+OQT854Fm/Zd7bMLoqXG+G9BrI1
         5j2bpTgoXy4cWNYld1V371LY4sZwuoDckjJyue92wbQvBgE5SRGqWIuQ+UPBuSwXj6Pv
         woeZ9GyLdU6+abDUe8zvT5d/+ito7zPs63TK/BW/zjkDViJK9cYTM3iSe71quxhvl0eQ
         peEEZikLYpEbU0eb1fQifZ2boam6a3Bf+g+xOJZRNOGjrV6RPMAn/Ro69YP035gp2H28
         1wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=g4L944ae2cIUAvuzp6X+TmnXKa7Wn5dOfjhGDf3cAeo=;
        b=R1AhiILJxLzTxR+OrOr1qukDrYHXUKXy+XZcTG6iVRpar4VDfXzjsPTDcCCdgJS79U
         Xz6CKrHc/8Kyn7AsGP27XCjHEtBOSf1RdeD71SmRCDBws9nzn5pJwqK/hzO266SqQgKU
         XG6gEry6wXqg7ftjGvpzr0mcIbstr2hcDMrF6pH7pdtTfFeroAwBe4FoL6yM6SIvUMOc
         GtWgZgO/wwSyQMF7xyt5+bikyDxihuDW/+XbHRBWErDewFPLILh92gBV1MIdE9gI7rOW
         AFVB+/rDebqc1/hU8kWF7065zKwS2JcL323xin8OoV62FZ1ZZNyvJqYUKXKm7WQqCAvO
         NJeA==
X-Gm-Message-State: ACgBeo1qY6dQWru4hjI+Q/JXmVLY1x1kkqQ6VH5KbtfcVzxVBx6rIN0Q
        9TFW0H4BCj4zyRly2nUjyNs=
X-Google-Smtp-Source: AA6agR7vOoXoR1a0P4QTSZQrBhcUzAhN+vp9jiM/naFuSIi8eSeEax6e06ytzEpsCJhvnHH2U8oQqw==
X-Received: by 2002:a17:90b:388c:b0:1fb:6738:6e50 with SMTP id mu12-20020a17090b388c00b001fb67386e50mr1024655pjb.231.1661377033276;
        Wed, 24 Aug 2022 14:37:13 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id n66-20020a622745000000b0052d981e7842sm13464071pfn.208.2022.08.24.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:37:12 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] built-in add -p: support diff-so-fancy better
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <ab012782-1d02-b90b-9a4a-179ecc3f8e9e@gmail.com>
        <1r3pq48q-s728-8r2r-r4q3-72413r5483o1@tzk.qr>
        <41781ceb-bfad-2534-2970-c74618c93f2a@gmail.com>
        <145ddce5-8084-a024-39b5-9dea870d1afe@gmail.com>
        <xmqqmtbt7b5p.fsf@gitster.g>
        <34qs5607-001o-0n6o-rson-9587q8r909qn@tzk.qr>
Date:   Wed, 24 Aug 2022 14:37:12 -0700
In-Reply-To: <34qs5607-001o-0n6o-rson-9587q8r909qn@tzk.qr> (Johannes
        Schindelin's message of "Wed, 24 Aug 2022 23:05:38 +0200 (CEST)")
Message-ID: <xmqq7d2x5nnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> One unfortunate consequence of avoiding the `git diff` invocations of
> `git-add--interactive.perl` that are not actually necessary is that I
> missed that one of those invocations specifically ignores dirty
> submodules, and that the Perl script then only processes files whose
> numstat shows up in _that_ diff output.
>
> Fortunately, the fix is easy: simply ignore dirty submodules in _all_ `git
> diff` invocations of `add -p`.

OK, so it wasn't removing what is useless, but removing something
whose result was used.  And our next move is not to bring us closer
to how we used to correctly handle third-party diff filters by
mimicking the original better but doing the handling of this
particular piece differently.

> I will submit the next iteration as soon as the PR builds pass.

OK.

>> As with any big rewrite, a complete re-implementation always has risks
>> to introduce unintended regressions and that is why starting with
>> faithful rewrite with the staged transition plan is valuable.
>>
>> In this case, the staged transition plan, the step to flip the
>> default without before remove the old one, is working beautifully.
>> And it was only made possible with the actual users reporting issues
>> before they say "the new one is broken, so let's use the knob to
>> retain the old implementation".
>
> Indeed, and thank you, Philippe, for bringing this to the Git mailing list
> so that I could do something about the bug.

Yup.

To some people, "refatoring to match my subjective code aesthetics"
may be personally the most important, and to some other people,
"getting rid of scripted Porcelains" may be, but they are both wrong
and these are their second most important goals ;-)  Not regressing
end-user experience is, and we learned a valuable lesson here.  Be
conservative and make sure we can revert to buy time when making a
big rewrite like this one.

Thanks, all.
