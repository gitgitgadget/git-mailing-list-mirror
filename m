Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6AAC636D3
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjBGWJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjBGWJa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:09:30 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75040E3
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:09:29 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p9so538908ejj.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 14:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CIgo+Cvoq9VVaO6UsMQ+xyEoDKj7fgOC8ZLMyCAbL7U=;
        b=GWNfENNTTY8XMEpbx5cgEYKPo+jIyfWMj+X3AIMgAGJ8705rzskqt8JgQCLtQpRwri
         v7Qyrb1emMIV8P1uvPoqd08DmNw7B2/NALWvMGoHVLNxroP6Fs5Cdxwh+98wPAZCw91U
         FK8OVazY9I6vXCa4X9ABOeQTCzIWVek9SbYegQn0WyAyxUqt10CzRK6s9Q+EQQl7YMD0
         qa4FzifROZnXIwbO8aY85hRlUlYGVkA3EwaBdGHy5WPjZEv0yQBzA02SPUlMvz4Xi5I6
         S04wppCzZnayi3Lo/rYMD9oVJepLBmceLFpGI5CMLVdQzjxnGgiE7kGiA35kdS+Ey+t+
         +LBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CIgo+Cvoq9VVaO6UsMQ+xyEoDKj7fgOC8ZLMyCAbL7U=;
        b=kXRXdbDGwnO6jN7a6oeWbaaWh5N/8HPy4EDpLrYV3ISvytx/x628ulCtcLTBUVbgHm
         LL0m7DtkAnAImyJhZLSBoXhLLhB1B6D9QitnAdpDxytc9tPD/XIZYBr/tX2KluOPU6gm
         nFMJwyeQXsXTwOmRt7UXgmqG8c0Z75oAs+vb4NRoqTRIOWqIH3Q8/MxNZBlSkCCnJmvF
         atff0CgKrTo/9//DMSY5wYxI2ffJ9MgBwtx2hWF4iC8742gyGSHQOymxvTdbw+YWiypo
         DjRYKo805F8oSs2100hXy5FiN5dW/I/2eoFeXTL2Er0IntALePTUG7fnSdVD+O4ENHEu
         DgAw==
X-Gm-Message-State: AO0yUKWAXaY7NeIta6xdbWDkAXdFzxGfaR4YNpXFcV1J0mj9xhfX/L44
        3Ngc0lSBoIBp6FNod0bWFfg=
X-Google-Smtp-Source: AK7set/9/DxmZ6FNc12+8XNYhZcj7mC7kzYqbjJfAsNpukWfCKaYr3SgeJd3+a79XGYzCce+b7tsOQ==
X-Received: by 2002:a17:906:f49:b0:887:915d:7502 with SMTP id h9-20020a1709060f4900b00887915d7502mr4501899ejj.31.1675807767529;
        Tue, 07 Feb 2023 14:09:27 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id dm1-20020a05640222c100b004a21d03155bsm6991927edb.88.2023.02.07.14.09.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:09:26 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPW9W-0012TA-0R;
        Tue, 07 Feb 2023 23:09:26 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jiang Xin <worldhello.net@gmail.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Date:   Tue, 07 Feb 2023 23:04:22 +0100
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
        <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
        <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
        <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
        <xmqq8rh9yxot.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqq8rh9yxot.fsf@gitster.g>
Message-ID: <230207.86357h2kmh.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> I think you might be right that people might rely on this after having
>> discovered this undocumented interaction by accident.
>>
>> But I also think that the lack of questions about how to get imap-send's
>> tunnel mode to work with auth helpers (at least I couldn't find any
>> on-list), which is what you'd run into if you went by the documentation
>> & were trying to get htat ot work, is a pretty good sign that this may
>> be either entirely unused by anyone, or at best very obscure.
>
> I actually think the misconfiguration (from documentation's point of
> view) Peff is taking advantage of is a behaviour you would naturally
> expect, if you do not read the documentation but are merely aware of
> the presence of .host and .tunnel and guess what these do.  And
> those who felt it was a natural design would probably not have asked
> any question about it.  Documenting the current behaviour better
> would not hurt.  Updating the behaviour and documenting the new
> behaviour would not help anybody.

Sure, we don't have to belabor the point. It's moot for a re-roll of
this topic in any case (I won't be changing this behavior).

But do I take it from the non-reply to what came afterwards that you're
not interested in a (not a part of this topic) proposal for us to say
"if you want that, arrange for ssh to do it for you", which would allow
for finally dropping libssl as a non-trivial direct dependency? Or just
that you didn't get to considering that?
