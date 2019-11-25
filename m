Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52D46C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F021D2073F
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 02:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hln2Y8/T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKYCpg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:45:36 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60019 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfKYCpg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 21:45:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CD06A7913;
        Sun, 24 Nov 2019 21:45:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=H4n+Y2jHqMsffGyNx+qcnbVuVzg=; b=hln2Y8
        /TRsKak7e1AH2RtxKE+IKdTS71scUiXUV1XFGYcOz5KzyEjRdIotXhYirLVUsVBa
        Bko+XRt+0nkRFzv/xGBKCYMKBIM4HuPXAKO2GAlJ97WJR/P/fGG+D5S+uhpBPQSG
        mqI6N69TwGvt0mse3TuUNyV/hhen4Ve7GorCg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dQ0kymxDSOdzvKPVB9nr+pQch2X8HoZR
        JaJabvrUHhjU1E3ipc0u2/uT+21aWHTxa/5JAsDsiFOBnp8c1XQ8PGLIPRQXC1ss
        V5hPplW/6jkXJVWk2vFc6ZGfE18AkXeQLNu1YCK0x6LF5g9mOyS6q4xQhh5F3wHq
        ALZEfm9IXYY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7510AA7912;
        Sun, 24 Nov 2019 21:45:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CE15FA7911;
        Sun, 24 Nov 2019 21:45:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
        <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
        <20191124170643.GA16907@sigill.intra.peff.net>
        <xmqq1rtwzoal.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 25 Nov 2019 11:45:29 +0900
In-Reply-To: <xmqq1rtwzoal.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 25 Nov 2019 11:24:02 +0900")
Message-ID: <xmqqv9r8y8qe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5D864CC-0F2D-11EA-B6AD-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Can we likewise ditch the fallback definition for SCNuMAX? And PRIu32,
>> etc? It seems likely any platform would either have all of them or none.
>
> I guess that's also a C99-ism that we can use?
>
> Thanks, both.

Here is what I have locally for now.

1:  98f866a929 ! 1:  ebc3278665 git-compat-util.h: drop the `PRIuMAX` definition
    @@ Metadata
     Author: Hariom Verma <hariom18599@gmail.com>
     
      ## Commit message ##
    -    git-compat-util.h: drop the `PRIuMAX` definition
    +    git-compat-util.h: drop the `PRIuMAX` and other fallback definitions
     
         Git's code base already seems to be using `PRIdMAX` without any such
         fallback definition for quite a while (75459410edd (json_writer: new
         routines to create JSON data, 2018-07-13), to be precise, and the
    -    first Git version to include that commit was v2.19.0).
    +    first Git version to include that commit was v2.19.0).  Having a
    +    fallback definition only for `PRIuMAX` is a bit inconsistent.
     
    -    Therefore it should be safe to drop the fallback definition for
    -    `PRIuMAX` in `git-compat-util.h`.
    +    We do sometimes get portability reports more than a year after the
    +    problem was introduced.  This one should be fairly safe.  PRIuMAX is
    +    in C99 (for that matter, SCNuMAX, PRIu32 and others also are), and
    +    we've been picking up other C99-isms without complaint.
     
    -    This addresses https://github.com/gitgitgadget/git/issues/399
    +    The PRIuMAX fallback definition was originally added in 3efb1f343a
    +    (Check for PRIuMAX rather than NO_C99_FORMAT in fast-import.c.,
    +    2007-02-20). But it was replacing a construct that was introduced in
    +    an even earlier commit, 579d1fbfaf (Add NO_C99_FORMAT to support
    +    older compilers., 2006-07-30), which talks about gcc 2.95.
    +
    +    That's pretty ancient at this point.
     
         Signed-off-by: Hariom Verma <hariom18599@gmail.com>
    +    Helped-by: Jeff King <peff@peff.net>
    +    [jc: tweaked both message and code, taking what peff wrote]
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## git-compat-util.h ##
    @@ git-compat-util.h: char *gitdirname(char *);
     -#define PRIuMAX "llu"
     -#endif
     -
    - #ifndef SCNuMAX
    - #define SCNuMAX PRIuMAX
    - #endif
    +-#ifndef SCNuMAX
    +-#define SCNuMAX PRIuMAX
    +-#endif
    +-
    +-#ifndef PRIu32
    +-#define PRIu32 "u"
    +-#endif
    +-
    +-#ifndef PRIx32
    +-#define PRIx32 "x"
    +-#endif
    +-
    +-#ifndef PRIo32
    +-#define PRIo32 "o"
    +-#endif
    +-
    + typedef uintmax_t timestamp_t;
    + #define PRItime PRIuMAX
    + #define parse_timestamp strtoumax
