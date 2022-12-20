Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C3AC4332F
	for <git@archiver.kernel.org>; Tue, 20 Dec 2022 00:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiLTAnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 19:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiLTAnG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 19:43:06 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5675B1D7
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:43:04 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id 62so7300151pgb.13
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 16:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PwyuB76tA69KehWH0tG6oL7sOox4qvBGzrWR82d4G20=;
        b=cdN0p2YFdH9mYxdzh3Ai7VQ3hrmZkzVPtcWG0oMYsxozwAaPG25Tbq6lDuWbVrGAVh
         WKE7W+RE4RGghAUd/VJtkEfIi7ItJxeDufivvMFbBaSJJQ5WPHCArXI70ShfOrm6NLqz
         6JvxGBNMoo2ALs/P76VM+75NnEGgofvFWyJNIlk5k4kosygIfbL/WR09l2uIdmy9UUGh
         CuE0AybZnzmh/T1g2cyxk/Ov5Bg6llXu54FqNcKm3H+0fG3OANILoJnXOVbVm4Dkl2Jy
         TWoo6g1D2NJX3otrqU6qdNiNHK9yxXrkqt4kplqpsF2ABuvY5zdL9lzq77XIa5zQiiQq
         KJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwyuB76tA69KehWH0tG6oL7sOox4qvBGzrWR82d4G20=;
        b=vUv8kvVVOnjtyqDFCgA2UwMupGDhnhaoFWMrOj9ErpkHE/MKnExiJ2fPGK23qbGbdt
         bLpEGiJwLeZQ+6fANXuOO/eMZuTYoOQTuk5XdoHYKfEx5icUz98+Q1TGHEx4ngoyHUNj
         rsZ0CLIm7rXFFGXWHm4tMcZzaJlmK3rOI0JGIj1q/6zmL7QKT3eTuPkEqVuU74P0cqsg
         LomRNcMeWo5p0AAygiWFGj7Ffp2cgAKLnWwiatecBcsXc8TGJPQkOBk015iiszcstUyd
         oj2Z89T64r3f60QyQZTEgg+NOdHmFw84tGQD5Jg70ZuN4CKumQVXxhSfic2TaVjf0r5S
         Z+Xg==
X-Gm-Message-State: AFqh2kqEDEGx0mrI42TpTLWhzjYFIH2IUsZptWd9LUsquhXvnQA7gbNS
        uANrzVEhRMtNHqDs704cHqI=
X-Google-Smtp-Source: AMrXdXur4mmGyS+caZ9CC23WM7Py3DZYLn4P97VLGJIiZHSfAPcUPEqMoF7+tadon8awyAitAUy92Q==
X-Received: by 2002:a62:1d07:0:b0:56b:a2f8:1d0f with SMTP id d7-20020a621d07000000b0056ba2f81d0fmr11253389pfd.0.1671496983608;
        Mon, 19 Dec 2022 16:43:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e14-20020aa7980e000000b00575fbe1cf2esm7287769pfl.109.2022.12.19.16.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 16:43:03 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH] cmake: don't invoke msgfmt with --statistics
References: <patch-1.1-0fa41115261-20221219T102205Z-avarab@gmail.com>
        <45d8d9fc-ca68-5902-0aa7-70034f8383ff@dunelm.org.uk>
Date:   Tue, 20 Dec 2022 09:43:02 +0900
In-Reply-To: <45d8d9fc-ca68-5902-0aa7-70034f8383ff@dunelm.org.uk> (Phillip
        Wood's message of "Mon, 19 Dec 2022 15:00:06 +0000")
Message-ID: <xmqqcz8e29d5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 19/12/2022 10:26, Ævar Arnfjörð Bjarmason wrote:
>> In [1] I made the same change to our Makefile, let's follow-up and do
>> the same here.
>> For "cmake" this is particularly nice with "-G Ninja", as before
>> we'd
>> emit ~40 lines of overflowed progress bar output, but now it's only
>> the one line of "ninja"'s progress bar.
>
> I don't really have a strong opinion either way on this but if it
> matches what we do in the Makefile than it sounds sensible.

As a one-shot change, it might be sensible to claim consistency by
saying "we do the same thing in two places", but I'd worry more
about the root cause of such inconsistency in the first place, i.e.
can we have some trick to ensure that two build systems will not
reimplement the same thing slightly differently?

It also is worth examining if having "the same change" is a good
idea in the first place.  The justification given "In [1]" was that
a build driven by our Makefile were concise and non-verbose overall,
but with --stat that concise output pattern was broken.

I do not know (and I do not have particular interest in knowing) how
a build driven by cmake looks like, but does it also aim the same
concise output where output --stat does not fit well, or do folks
who daily build with cmake find the output with --stat sit well in
the output from other things given there?  If the latter, making
"the same change" as the Makefile side may not make much sense.
