Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA72C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE24613E1
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 12:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhD2Ma1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 08:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhD2Ma1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 08:30:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B11C06138B
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 05:29:40 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n25so6226069edr.5
        for <git@vger.kernel.org>; Thu, 29 Apr 2021 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=XSjctXF1rN7HvpATfVppChK2dsvq1TpO7CbgLtEHheQ=;
        b=kjr384zRJazZCWP6QBKMkT2Uw3JFstyc4qqIBmimJmrYxkk+kdhK1IgsJVA8ivRx9c
         Bm6GuV8HcK58A3nEKyxqPIsWXEt+cZDXIT9nxOEQ24wnxzyFhnobQZsqeN1Srxic7skh
         X4d+rMqGj5wpsMM0dGmp5CYBVDATzKqtZbL28iq+5ztt2uMOXXRz4Vayu+kd5VvdxGIO
         7+Qr86sng0e60Fkcz7ei8oTw/GTniNY9zvPPE5ETM6RsB9PlhtkBCaCKbJfJaj4dEYWp
         QzJOkZGH/eGgsnVONCSatJ/q/yvfa+Hpu9/rs9EznESW7fqTbIKDfUDZqt7+5EJ1XMj1
         3HAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=XSjctXF1rN7HvpATfVppChK2dsvq1TpO7CbgLtEHheQ=;
        b=Oyqlx9TpNiYVdh+Tp56vBGjTDXGrop5QBjxlkyZ55y2ld+hsQRR8QaGLChe+qrMAi2
         99G0bivAkasCufrvlqN2jp8XVQOgBvQVtpMvsE9fmTIpJQoT4zF2qyox1Md7jjDKNCnv
         AD+bxx2iXpM4iocXs8Y0vG60G+dTprNQuACby3PfoiSftsJV690m4EkfRNqEdwEFGLjC
         TmYbBp1JKaeOaCLbDr2smXSinKZjFStLNxJ1TADcUPLwxoxPpc63R1tzQwdMF2fa5f7C
         iMBetTNJyR0/cxnVf/HZPF/hUy/iSDVjxH4fG+q8/zRkSWKVsj8iTomvYJJoqkfYCeoc
         HY1A==
X-Gm-Message-State: AOAM530rCTxvx6EtgJqO5MCLjQG1iIeKuDaBjDoPKbQ7IJf6udUS6q6A
        +5dhKws8yKvbAUIc1+jUe5E=
X-Google-Smtp-Source: ABdhPJwCwpHdCr3tflMurxmEcB4ar1ONvXtCLzupTlLMF2LzMkaiSCWrWaoJj2cfohJMUx06B2JsdQ==
X-Received: by 2002:a50:bec7:: with SMTP id e7mr18104329edk.295.1619699379467;
        Thu, 29 Apr 2021 05:29:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id x9sm2276281edv.22.2021.04.29.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:29:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: Nesting topics within other threads
Date:   Thu, 29 Apr 2021 14:14:52 +0200
References: <87k0omzv3h.fsf@evledraar.gmail.com>
        <patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com>
        <1ecb3727-106f-3d04-976a-36aa03a61caf@gmail.com>
        <xmqqsg397jyj.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqsg397jyj.fsf@gitster.g>
Message-ID: <8735v9z32l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 29 2021, Junio C Hamano wrote:

> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 4/28/2021 12:26 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>> Simplify the setup code in repo-settings.c in various ways, making the
>>> code shorter, easier to read, and requiring fewer hacks to do the same
>>> thing as it did before:
>>
>> This patch is interesting, and I'll review it when I have some more
>> time. Probably tomorrow.
>>
>> But I thought that I would point out that this pattern of adding a
>> patch within the thread of a larger series makes it very difficult
>> to separate the two. I use an email client that groups messages by
>> thread in order to help parse meaningful discussion from the list
>> which otherwise looks like a fire hose of noise. Now, this patch is
>> linked to the FS Monitor thread and feedback to either will trigger
>> the thread as having unread messages.
>>
>> I find it very difficult to track multiple patch series that are
>> being juggled in the same thread. It is mentally taxing enough that
>> I have avoided reviewing code presented this way to save myself the
>> effort of tracking which patches go with what topic in what order.
>
> I do find it distracting to have a full "ah, I just thought of
> something while discussing this unrelated series" patch fairly
> irritating for the same reason.  It however is unavoidable human
> nature that we come up with ideas while thinking about something not
> necessarily related.  So it largely is a presentation issue.
>
> I really appreciate the way some people (Peff is a stellar example,
> but there are others who are as good at this) handle these tangents,
> where the message sent to an existing thread is limited to only give
> an outline of the idea (possibly with "something like this?" patch
> for illustration) and then they quickly get out of the way of the
> discussion by starting a separate thread, while back-referencing "So
> here is a proper patch based on the idea I interjected in the
> discussion of that other topic."  And the discussion on the tangent
> will be done on its own thread.

In RFC 822 terms. Are you talking about the In-Reply-To[1] or
References[2] headers, or both/neither?

I'm happy to go along with whatever the convention is, but as noted
think it's valuable to come to some explicit decision to document the
convention.

Threading isn't a concept that exists in E-Mail protocols per-se. Just
In-Reply-To and References. The References header can reference N
messages most would think about as a separate "thread", and "thread" is
ultimately some fuzzy MUA-specific concept on top of these (and others).

E.g. in my client right now I'm looking at just 4 messages in this
"thread", it doesn't descend down the whole In-Reply-To, others would
act differently.

Some (such as GMail) have their own ad-hoc concept of "thread" separate
from anything in RFCs (which includes some fuzzy group-by-subject). In
GMail's web UI everything as of my "upthread"
<patch-1.1-e1d8c842c70-20210428T161817Z-avarab@gmail.com> is presented
as its own thread.

The ML read as it happens, but it's also a collectively maintained
datastructure.

It seems to me to be better to veer on the side of using standard fields
for their intended purpose for archiving / future use. I.e. making "a
reference" universally machine-readable, as opposed to a lore.kernel.org
link, or a free-form "in a recent thread" blurb.

ML Archive Formats Matter[3] :)

But yes, maybe MUAs in the wild these days mostly render things one way
or another, so catering to them would be a good trade-off. I'm writing
this from within an Emacs MUA, so I don't have much of a feel for common
MUA conventions these days.

I'm prodding to see if we can define the problem exactly, because
e.g. maybe "References: <break@threading.hack> [actual <references>]" is
something that would achieve both aims, i.e. make the references
machine-readable, but break up threading in common in-the-wild
clients. We could then patch format-patch etc. to support such
"detached" threading.

1. https://tools.ietf.org/html/rfc822#section-4.6.2
2. https://tools.ietf.org/html/rfc822#section-4.6.3
3. https://keithp.com/blogs/Repository_Formats_Matter/
