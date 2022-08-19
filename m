Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834DDC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 15:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349587AbiHSPNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 11:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348395AbiHSPNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 11:13:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B33C4A
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 08:13:20 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso4252837wma.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=bOX8ajmQFXiaIrVYX5y5x4rRseHGVxfVaMG45Ler3qg=;
        b=l7rEWcljYXX1OXJAftOLgm5RFUZmWpfTydjBQRA5Cg1W/vNC2Vz0z8wlfd7ZURxW0p
         NehJaqTrkGGsA0fnw8KKMSu1/I6kKD/mq3/u3tcBbkPur2NI1RQpbU7NqTyzUtiPclmJ
         Sjt0m2VBZcK7LbLF2eK7p4RG68B1mVmDtBFeoaOYmbQdlPwTiy1/jaVA0hoWIVwm9UKj
         c1faGbq98SKcOlIiViIzOXNNNy8eSJVgs4jzgN45EdG+C5BXVwzOHmR5me2myGhWAohJ
         OWHWTwmj8b4UPz4lEXxa0wgTh//Mchm/GHc3N+tAXAVVgV1nFkzn9NETzlqL6OnLveQz
         Velw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=bOX8ajmQFXiaIrVYX5y5x4rRseHGVxfVaMG45Ler3qg=;
        b=38aBTdd8Idcy3pLKoI7vxTfo+t+5L6VfBpjA5I9VDT/T9zAj7jyjSA4Li/y62sPBjJ
         WOkaHnRPboxEFfO+YodNJQp9bBDYZ/kctwSFxXkFSgUdHdQhX+dXg1sHBpq8WGXF1PNv
         ftUxViCFE52Q0aXZaMJgqBHfHWasBVt2jcG1h3KKZQLlVyCEB6O9yx45MotQ7268CLAx
         GmrScCCHhTTwgVbURvduJthetp9nD06Mc7c0VKYhHMDY7lDd4bkJ8ttAC9WsgWitlOKY
         XCQg8hB78ZFPySGd+isnyINj/DNwx1ubO0lRtz3oy+IQMpCERbD8a3brGXWqra0AnAfw
         l41Q==
X-Gm-Message-State: ACgBeo04PgZrhYo7onmIg7mf2KuJx6OAYbLKb+2vOTK1AnN/qBuhUO5D
        R2madvk5WyaGH2kchtSPtEs=
X-Google-Smtp-Source: AA6agR5Hr4LQDOJNE5rhhEe1nUrTmX+qcPrMOUKfRjGMn/2oOVa8ea14hj95QPcfWKnQEUQKxXy07A==
X-Received: by 2002:a05:600c:20a:b0:3a5:e40a:1821 with SMTP id 10-20020a05600c020a00b003a5e40a1821mr8122531wmi.125.1660921999414;
        Fri, 19 Aug 2022 08:13:19 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id v2-20020a5d6b02000000b0021e30e9e44asm4150164wrw.53.2022.08.19.08.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 08:13:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP3gT-000lP3-0S;
        Fri, 19 Aug 2022 17:13:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/4] sequencer: do not translate reflog messages
Date:   Fri, 19 Aug 2022 17:12:43 +0200
References: <09rn6r61-38qo-4s1q-q7qq-p5onp6p87o44@tzk.qr>
 <cover.1660828108.git.git@grubix.eu>
 <ea6c65c254bb08b20ea6c4d81200b847755b555c.1660828108.git.git@grubix.eu>
 <220818.86zgg18umf.gmgdl@evledraar.gmail.com>
 <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <6oqr69o7-qsps-sr86-o4r9-16r7no9n5424@tzk.qr>
Message-ID: <220819.86o7wg6zci.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Thu, 18 Aug 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Thu, Aug 18 2022, Michael J Gruber wrote:
>>
>> > Traditionally, reflog messages were never translated, in particular not
>> > on storage.
>> >
>> > Due to the switch of more parts of git to the sequencer, old changes in
>> > the sequencer code may lead to recent changes in git's behaviour. E.g.:
>> > c28cbc5ea6 ("sequencer: mark action_name() for translation", 2016-10-2=
1)
>> > marked several uses of `action_name()` for translation. Recently, this
>> > lead to a partially translated reflog:
>> >
>> > `rebase: fast-forward` is translated (e.g. in de to `Rebase: Vorspulen=
`)
>> > whereas other reflog entries such as `rebase (pick):` remain
>> > untranslated as they should be.
>> >
>> > Change the relevant line in the sequencer so that this reflog entry
>> > remains untranslated, as well.
>> >
>> > Signed-off-by: Michael J Gruber <git@grubix.eu>
>> > ---
>> >  sequencer.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/sequencer.c b/sequencer.c
>> > index 5f22b7cd37..51d75dfbe1 100644
>> > --- a/sequencer.c
>> > +++ b/sequencer.c
>> > @@ -575,7 +575,7 @@ static int fast_forward_to(struct repository *r,
>> >  	if (checkout_fast_forward(r, from, to, 1))
>> >  		return -1; /* the callee should have complained already */
>> >
>> > -	strbuf_addf(&sb, _("%s: fast-forward"), _(action_name(opts)));
>> > +	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>> >
>> >  	transaction =3D ref_transaction_begin(&err);
>> >  	if (!transaction ||
>>
>> I 95% agree with this direction, but the other 5% of me is thinking
>> "isn't this fine then? Let's keep it?".
>
> No, it's not fine, we mustn't keep it, because we expect Git itself to
> parse the reflog.

Doesn't that also mean that the relevant functionality is now also (and
still?) broken on any repository where these translations ended up
on-disk?
