Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9010BC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 07:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiGRHzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 03:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiGRHzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 03:55:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8C183B2
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 00:55:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l23so19749439ejr.5
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 00:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=1aAZeXNu7qQjnKNH+1TD/4BXQn+UcJ2VXFnaWbIMfFU=;
        b=Wvgf9CPcESLNhL5FiuSxhqOC9qbh8Xu16MOoc5f2OFl5QRm4WqDU+7UHJc8anf0otL
         5eLv9b/l1jYVfktwd8860yvq1plGsc9hoZ49lq7w3L6pFr8e4rrZQw1vihB7U9xnFY0V
         rivQcXDXt23JXntt4zxKEAVkBzohiHwizkS06kbBQLbXsmyBakHNrluTU9JajAE6kMw9
         vUIymT7O16XZOI1D9Nfp0wnBlIVa/afCqoHJtp1fgSD3QFQ0qumYA2Y4UTHSUuEwhzSP
         25NKUSlMKfVZQjIb3UvBXvfvWgCGw/tywNT64Vd32yALEghSsbsl1psCvnb9QKsrnL8R
         94pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=1aAZeXNu7qQjnKNH+1TD/4BXQn+UcJ2VXFnaWbIMfFU=;
        b=kz+BkLSAaQ2O0tJsCiHZ8Riu2YHDU4ggON8jte6dQJYs4DLX2uOTKyz1b9SVrkRXUA
         zMNIi82Tm8GBEhHdUj5eVTg0a+dzHAyQ8mhoJ3IGssdi4OH31XNCg8jNeEMlVxEq7EMH
         Yw7jQx3vrC7E9I8wjIL0SD5KKKsXKeTa9K3FNwXVVsKCwB15bKhZOUY/4UMgRkjkrxX+
         2SoCSDcU2JcW7zUNkZ2uraOmrRS/XgjQGZ4e5ycIK9S6ZAWejxOr6I5aeDQrsJCFnFv4
         23mrJmW6fsr12kSrqP2ch+lVvqqz0hDNU7eud7OWYtK6E3x7+CX8Sb4eLlEGPINR6wbl
         eF/Q==
X-Gm-Message-State: AJIora/4BZAVDgdGAv87Pw5ZY/d6M21fO5FK11RsCK5Dr9/YYe5x2ZsE
        G6LaRweM+tH4ubgukcvWfDBIxUi0mW4=
X-Google-Smtp-Source: AGRyM1vBDhzcqOcc46mjJgpbuX2WaMVGG3HKPIzoP6R6OBWAoDooGSxI5QHpN8XB/u6pCVJYi/+/Eg==
X-Received: by 2002:a17:907:2c44:b0:72b:6160:c64c with SMTP id hf4-20020a1709072c4400b0072b6160c64cmr24780924ejc.55.1658130930132;
        Mon, 18 Jul 2022 00:55:30 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b18-20020a1709063cb200b00722f069fd40sm5151410ejh.159.2022.07.18.00.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 00:55:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oDLbE-002y9v-KG;
        Mon, 18 Jul 2022 09:55:28 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-repack doc: remove discussion of ancient caveat
Date:   Mon, 18 Jul 2022 09:35:24 +0200
References: <patch-1.1-363f84a3fa7-20220715T075114Z-avarab@gmail.com>
        <xmqqsfn21fmt.fsf@gitster.g>
        <220716.8635f1zdg3.gmgdl@evledraar.gmail.com>
        <xmqq1qujt334.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq1qujt334.fsf@gitster.g>
Message-ID: <220718.86tu7eyhvz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 17 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> That's all academic.  I wouldn't have written the above if the
>>> proposed log message stopped here.  But with the rest of proposed
>>> log message that hints that the above statement is backed by a solid
>>> study of history, it is wrong to write a wrong version number there.
>>>
>>> I agree that it is safe to say that anything before Git 2.0.0 is
>>> irrelevant at this point (I would actually say before Git 2.16.0,
>>> i.e. anything older than 3-4 years).
>>
>> 1.4.4 is the version that introduced the flag, but the paragraphs I'm
>> removing is relevant to 1.6.0, as it discusses concerns with that
>> new-in-1.4.4 --delta-base-offset flag being turned on by default.
>>
>> So this documentation matches e.g. the RelNotes update you made in
>> e903b4095a0 (Update draft release notes for 1.6.0, 2008-07-01).
>>
>> I.e. 1.4.4 was released in late 2006, 1.6.0 in mid-2008. Hence the
>> mention of "git clients older than 2008-era git" not being a concern.
>>
>> I.e. the target audience for this bit of documentatino is someone
>> running 1.6.0. or newer that's also concerned about pre-1.4.4.
>
> Step back and think why the 1.6.0 carried the mention in the release
> notes, and added the "use of delta-base-offset is incompatible with
> versions of Git that are older than 1.4.4" to the documentation.
>
> Back in 1.6.0 days, some of the users still had to refrain from
> using the delta-base-offset feature by explicitly disabling it,
> because the version of Git running on the other side of their
> connection were before eb32d236 (introduce delta objects with offset
> to base, 2006-09-21)---1.4.4 was the first version of Git that
> learned how to produce packs with delta-base-offset, and how to read
> objects out of such packs.
>
> If 1.4.4 were too distant in the past to matter and we were sure
> nobody is running such an ancient version back then, we wouldn't
> have written such a notice there in the document when we turned it
> on by default in 1.6.0.
>
> Or, step back and think what we would have taken into account, if
> the patch in question were suggested during the development cycle
> toward Git 1.7.0, and what the reason for rejection would have been.
> Even if there were tons of folks who were running pre-1.6.0 versions
> of Git, as long as these old versions were all newer than 1.4.4,
> then we would have said that the warning would not matter.  The
> reason to reject such a patch in 1.7.0 cycle would not be because of
> the age of 1.6.0 being too young, but because of the age of 1.4.4
> being not old enough.
>
> Both are based on how distant in the past 1.4.4 had happened.  As
> the removed paragraph says, generated packs with delta-base-offset
> are "incompatible with versions of Git older than 1.4.4".  If 1.4.4
> and older died out, nobody needs to worry about use of d-b-o.  If
> 1.4.4 and older are still used, we would need to.  How ancient 1.6.0
> does not matter.

The removed documentation covers two distinct topics:

 1. For >=3D 1.6.0 that the default changed to include --delta-base-offset.
 2. For < 1.4.4 that providing --delta-base-offset produces
    incompatibilties.

With "older than 2008-era git" and v1.6.0. I was referring to #1, not
#2. You're pointing out that we should cover #2 more prominently, I'll
re-roll to do that.

> Perhaps rein in the temptation to "attack back" in spinal reflex
> when somebody bothers to take time to point out where you are
> mistaken?  They are often not attacking you, but merely offering
> improvements.

That's really not the case here. The reason I replied with a
clarification was this part of your upthread
<xmqqsfn21fmt.fsf@gitster.g>:

	But with the rest of proposed log message that hints that the
	above statement is backed by a solid study of history, it is
	wrong to write a wrong version number there.

Which I may have misread, but I understood as going beyond suggesting
that we cover #2 over (or in addition to) #1, and into speculation that
the change being suggested here was suspect because I hadn't carried out
a "solid study of history".

Which I would agree with if I had mixed the two up. After all if someone
proposes to remove documentation where 1.4.4 v.s. 1.6.0 is critical what
else have they missed, and can the change be trusted? Perhaps there's
some major caveat that the referenced older commits would reveal that
the submitter didn't bother to study.

Which is why I replied rather than re-rolling. I.e. if that was the case
I don't think a mere re-roll would address all of your concerns, I'd
just be copy/pasting and rephrasing what you suggested, but I still
wouldn't have carried out that "study of history".

But that's not the case. I was just attempting to go for brevity
here. I.e. if I could establish that anything older than 1.6.0 wasn't
relevant (#1) I wouldn't have to cover (#2) at all, as it follows from
the chronology that if #1 isn't worth worrying about, neither is #2.

I'll re-roll with something I think addresses your comments here, and
perhaps I've just dug myself deeper into the hole you've pegged my in
with this reply, but hopefully this clarifies things & where I was
coming from.

Thanks.

