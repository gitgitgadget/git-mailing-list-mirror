Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC5C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 11:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61884610E8
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 11:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhI0LIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbhI0LIS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 07:08:18 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD19C061604
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 04:06:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g8so67635067edt.7
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=MRl4LF1rnDDyFMWEJexCxJYhOmt1Xmxww5HUQsaQGdU=;
        b=Lfq6vOMTDcNBFIN2uP3lRyMwOXyNju5nATnNgCme34TZWurgr8exnLDG9xADNI2dox
         4RPSO96go5k0b6HH/Esoz3rKyUjgGvY83OCRPmUQeAjUlanQlbeIsu5MOLqzqEbZlwu1
         ukVOC13I+yRCo/XqK7Qd0Zm1url/DsiuaZ3W9iIiHmirPsj5Fkpf0mgi5itx0U6ewR+J
         lVxI6Dx435lSR+j1Smdlc3S6GLnX00sHADATfK1l7l5xpc5dVzxPVJ3DDh5TnqEw7lfo
         S3tWOfnctlGb43ZfOfwZNkH7SrmTpYDT8icUT8FBGfBf9x5kecoePtr76O9gIYbnLFxw
         m6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=MRl4LF1rnDDyFMWEJexCxJYhOmt1Xmxww5HUQsaQGdU=;
        b=1FgN9vHUUeOBO++n6wjnFTkuAW2CsV9PkFmyIkK5a1SxThta0PPQvYJq1wXgiO7sLf
         6kkYzt50m3EvXgr6sH/LI3sDpAUhajB2TS0WJjx+iSOSMLWUDW0LPKH/IZ3FqSFg2/Hg
         p00NYLZ+w3gp3u9pXQ9JL0IwgTXa3AUacn4v8YvxIWo/B+0iHPb+/8Fq+A/ife3qhZnI
         0L+CT16WAlgedYL934srUrfFvi2D/bGU8ikbKWEt11xpyf1INyu0JswwQmJN5og6/5vm
         k1hO/RhABaar6HrNTQy/sSpJDL2dl+alOiyFEYDR09JxYySWOlndHcp8HKgjphped090
         4cng==
X-Gm-Message-State: AOAM53284mAwMLZ359STm55FInMzF3sH91b0M/v/ZCprYuaa7mlLnb3S
        0YAEDNCL6K0T5AS2hEYpFzL68M/xWspPRA==
X-Google-Smtp-Source: ABdhPJxN0rE+sjFSH+cjju1NRGT29BHwpNMN3g+KPnXf5ANzDIO7QdzYesJeHENFaXOz+eD82oQpFg==
X-Received: by 2002:a05:6402:3454:: with SMTP id l20mr22396067edc.83.1632740799153;
        Mon, 27 Sep 2021 04:06:39 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id x7sm10418206ede.86.2021.09.27.04.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 04:06:38 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Date:   Mon, 27 Sep 2021 13:02:35 +0200
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com>
 <patch-5.5-7e571667674-20210927T003330Z-avarab@gmail.com>
 <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <694f477d-b387-c8ea-4138-0e9334540c69@kdbg.org>
Message-ID: <87czou1dmp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 27 2021, Johannes Sixt wrote:

> Am 27.09.21 um 02:39 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>> --- a/cbtree.h
>> +++ b/cbtree.h
>> @@ -37,11 +37,12 @@ enum cb_next {
>>  	CB_BREAK =3D 1
>>  };
>>=20=20
>> -#define CBTREE_INIT { .root =3D NULL }
>> +#define CBTREE_INIT { 0 }
>>=20=20
>>  static inline void cb_init(struct cb_tree *t)
>>  {
>> -	t->root =3D NULL;
>> +	struct cb_tree blank =3D CBTREE_INIT;
>
> This could be
>
> 	static const struct cb_tree blank =3D CBTREE_INIT;

*nod*...

>> +	memcpy(t, &blank, sizeof(*t));
>
> Is
> 	*t =3D blank;
>
> not a thing in C?
>
> -- Hannes

...but to both this & the above my reply in the side-thread at
https://lore.kernel.org/git/87h7e61duk.fsf@evledraar.gmail.com/
applies. I.e. this is just following a pattern I got from Jeff King &
used in bd4232fac33 (Merge branch 'ab/struct-init', 2021-07-16).

FWIW with "const" in general I don't use it as much as I'd personally
prefer, see e.g. [1] for one recent discussion, but maybe there wouldn't
be any push-back in this case...

1. https://lore.kernel.org/git/patch-1.1-c317e6e125e-20210921T124416Z-avara=
b@gmail.com/
