Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B84C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 17:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbiKGRX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 12:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiKGRX6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 12:23:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C3F20F75
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 09:23:57 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id 13so32091291ejn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 09:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pJ58VrRcelKgSgbo9J96ACUc+hwyuwAiNrrzdk7ROac=;
        b=RvTv0msdoKyVGlnRHOEF3lNsVBhfQgiFapQkChJCaPmjZJbPWqIJlUjHfwXt2ZO0M0
         dBxIGrOQx7nRMKMKndOXjKf4NMDyllggkGcW52Hy/M4p1Bdhkndl36Yo7egUa2dcN4Q/
         SuT19NLgpGBIfqtdbJ2v9RDCacR8mFcnuudHf538iMdUfEkn5EmGfQSGMlhHe5sB9cBe
         x6D0BqsIhC+p2dvgOuUAn0fGe1S6BG7Puo8gCAQUJfLEMlPNKOY0rhgwnNtbF1B2mxQA
         tlRF02LmMq34WaR8Yn6vhQDwwMjfqPfyd8Nmc6tqdbA02pW9OBc3c5HQJ6ai4+kel9+G
         Azlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ58VrRcelKgSgbo9J96ACUc+hwyuwAiNrrzdk7ROac=;
        b=0M+qP2BBGYVAyO9/iz4ABOsuI7pH03P73td3JCXySwZFHtkK0OkO71NdGJ6Fu2SGA7
         i6Jd7mEnPGmhEbvSs3+t3WUZG5cGCXAYqyRymHBbR5jwwbtct3lclEq24FFCPLCeLLry
         F1TGyP/zg7VV42mQfpjUvWmaw/MqOrbPHRvEMrFz4QIZa5IzrxvX7dCxIs6WUSwTDZjw
         63ra8vu+5Vgc8roI+ET7Axt9KnQMnJHPmDZcyaiGPlQk4Ylbx52hUJ3eaj40+tr+kr9T
         aF43pzKnQ5J+vE9U5eIVMRYZRtA677xy0NHrYQ8ZvvI46cbOOcc3EaKiG9Sb2lPqnIFl
         +l3w==
X-Gm-Message-State: ACrzQf2il2C0xmg9SlT5vod7D8mPOCIma+/iHK9lb82yaxFeJbhzgKbB
        Bha8i3Nzlzyz9f71E3D2D08=
X-Google-Smtp-Source: AMsMyM4PgVWahvspmQ3WoUGUugXfqBSa/iGXePWSr+kBtazh5tHAp66joXYcqtYap2PnQfjBMHbAjw==
X-Received: by 2002:a17:907:60c8:b0:78d:bc56:8f04 with SMTP id hv8-20020a17090760c800b0078dbc568f04mr48132994ejc.560.1667841835475;
        Mon, 07 Nov 2022 09:23:55 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ee2-20020a056402290200b004614fd33789sm4506400edb.18.2022.11.07.09.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:23:55 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os5qk-000DK5-1h;
        Mon, 07 Nov 2022 18:23:54 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Mon, 07 Nov 2022 18:22:34 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
 <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
 <CAPig+cS+8ER=K9byUZs9+MxZ1x9zVxnGKrKm8CGs1zJvvCoSEQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <CAPig+cS+8ER=K9byUZs9+MxZ1x9zVxnGKrKm8CGs1zJvvCoSEQ@mail.gmail.com>
Message-ID: <221107.86a652vfth.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Eric Sunshine wrote:

> On Mon, Nov 7, 2022 at 9:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>> On Mon, Nov 07 2022, Teng Long wrote:
>> > When appending to a given object which has note and if the appended
>> > note is not empty too, we will insert a blank line at first. The
>> > blank line serves as a split line, but sometimes we just want to
>> > omit it then append on the heels of the target note. So, we add
>> > a new "OPT_BOOL()" option to determain whether a new blank line
>> > is insert at first.
>> >
>> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
>> > ---
>> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
>> > @@ -159,6 +161,11 @@ OPTIONS
>> > +--blank-line::
>> > +--no-blank-line::
>> > +     Controls if a blank line to split paragraphs is inserted
>> > +     when appending (the default is true).
>>
>> Just make this:
>>
>>         --no-blank-line:
>>                 Suppress the insertion of a blank line before the
>>                 inserted notes.
>>
>> Or something, i.e. when adding a "true by default" let's add a "no-..." =
variant directly.
>
> This is the exact opposite of Junio's advice[1], isn't it?
>
> [1]: https://lore.kernel.org/git/xmqqsfjsi7eq.fsf@gitster.g/

I read that as him mainly talking about what we name the variable (which
I agree with, but didn't comment on here). I'm talking about what
interface is exposed to the user.

I.e. both concerns can be satisfied, but whether my suggestion is
sensible UX is another matter...
