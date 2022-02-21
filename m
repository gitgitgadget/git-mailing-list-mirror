Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED690C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbiBUTYr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:24:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBUTYl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:24:41 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737465BA
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:24:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id s14so14062295edw.0
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Y66IWN8ghwtlTypfYrLPHesTty7Lk15bybdGUeAKb0A=;
        b=BhW4lzFWxTkplww6qeMGhvoHf4wv3NBtL2d36Fn///EEaqm7cfWkEkht0yq0hC7C+C
         UwKedSCMitEURG6HGFGGFL11IKq7YAzXiLtCcgfY1//nd+GKGoTOuOpqQxhHISSx7v4u
         MR7Yi4eN7R15q+uTBe3p+cpl77RflBkUKqqOREiY3A1mHAhj3dEF/pzj8HOmGkSNIf/P
         MUxMGLb2v4TOnMBbRxnJXEkwEl+t8JeAV1NTG5agDgcR1IT2hTYZR0CmC+hyYMzibWyQ
         sE0GsLdECIPyW/w41pJHpVUUgLgKTDS5O+eGPV4AD93ItZZFbIifxSJLF0oXm9eyEpsK
         Ptsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Y66IWN8ghwtlTypfYrLPHesTty7Lk15bybdGUeAKb0A=;
        b=jY8rqgvQsLMwJhG8t3VLHvLKT5o97nEDZBXpFt9Kd13Vk2vFCFEAQc+yDCfZOtr+i4
         9pxq1YMOB1cYSdmMB+dPPSDNH5VuAxDiPSwMLrg2iTUGI+gV0jka91KNfLX4F0UJoKVK
         fpcNIEvBE53Wk6qCDOKhPFTPx6WFsYzqbIcZkhxZ5nD3B/mvN9OaIo1tJn8NAssAQ3OV
         uWniBMr2AYq9TpkD9KrgtPW1cW0vdTqXZSNEdGmfTH/aKvbOpboYi5+rHWo2WkdbJpqu
         xt3fP5Mof6tkMBRasgzLMXGYSlArw7jsi+m71B2Xis7x7N6ZWfimDQ5QNWhiyX75oYen
         USRg==
X-Gm-Message-State: AOAM531yZf04aw/uBNByJ+RrFzbgn4gHL+ON+9XbfvnZ2/NoGNZV1PwH
        zMu99IZlVVYSezJ2YZztfcNCXSa8TlAV1Q==
X-Google-Smtp-Source: ABdhPJyBcyK/Zr6+c+rt+Nf/Fviqgsf6fpXvfqgwoYwR7xbXU9ACnA5kJJFexqycia2YqpjbEEJr1A==
X-Received: by 2002:a05:6402:42c9:b0:407:f86c:44e7 with SMTP id i9-20020a05640242c900b00407f86c44e7mr23032139edc.230.1645471456290;
        Mon, 21 Feb 2022 11:24:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z22sm9475607edd.45.2022.02.21.11.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:24:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nMEIB-005mAY-7C;
        Mon, 21 Feb 2022 20:24:15 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Erlend Aasland <Erlend-A@innova.no>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] branch: delete now accepts '-' as branch name
Date:   Mon, 21 Feb 2022 20:20:22 +0100
References: <pull.1217.git.git.1645020495014.gitgitgadget@gmail.com>
 <xmqqbkz6vjkj.fsf@gitster.g>
 <00720bfb-c7b7-aaf2-e846-19b08d7b9cf4@sunshineco.com>
 <400A4D37-74EA-4F3B-BA3B-99FFDAE3CB3C@innova.no>
 <CAPig+cR0Ks2bnTRqs3uF4M+3q+n9X6pApBQ9HQTUq=zK5TpuXQ@mail.gmail.com>
 <xmqqiltd9vyg.fsf@gitster.g> <220221.86pmngb22e.gmgdl@evledraar.gmail.com>
 <xmqqwnhota5q.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <xmqqwnhota5q.fsf@gitster.g>
Message-ID: <220221.86zgmk9g68.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 21 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> Continuing the "thinking aloud" a bit, I _think_ this tells us these
>>> things:
>>>
>>>  * @{-1} has way too many letters to type to be liked by users, who
>>>    won't learn or remember what they do not appreciate (and do not
>>>    blame them---it is a bad notation).
>>>
>>>  * @{-<n>} may have been a generalized way that satisfied geeky mind
>>>    while being implemented, but the users only need the "last one"
>>>    and no such generalization.
>>>
>>> If it is too late for a more easy-to-type-and-pleasant-to-eyes
>>> notation, perhaps "@-", that does not have downsides of "-" or
>>> "@{-1}", I have to wonder.
>>
>> I too find the syntax really annoying to type.
>>
>> I wonder if we couldn't say that:
>> ...
>
> We could, but I do not think I like any of it, except for adding
> "@-".  We learned that we do not need @{-4} generalization and
> people only want "the last one" with nothing else.

FWIW I often use @{-2}, @{-3} or equivalent, but never @{-28} or
whatever.

Not often.

But I would very much appreciate @u if it existed. I use @{u} a lot, and
with the shift-key dancing it's a hassle to typ it.

> the same mistake without learning any from the lesson to take any
> random string that follows @ as if it is inside @{}, I am afraid.

I think we should be careful to squat on namespaces needlessly, but if
we can't think of a reason for why we wouldn't make typing some of these
shortcuts easier...

IOW can we think of a reason we'd ever use @1 @-1 or @u for anything
else? It would be *very* confusing to add a new @{u} that behaved
differently from @u, whatever such a @u would mean.

> P.S. It seems it is holiday around here and I hear it is at GitHub,
> too, so I expect the day to be slow and my presence may be sporadic.

*nod*
