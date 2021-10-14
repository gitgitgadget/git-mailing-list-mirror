Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FE5C433EF
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C716109F
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 00:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhJNAdl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 20:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhJNAdk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 20:33:40 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B63C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:31:36 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e3so13781748wrc.11
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 17:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=8gBvNQKsQIXOjPtAEqCN7AdimgnL9us4xsxNyDOMoNI=;
        b=jqgl9O2cYD/qjcgno1jfRuMaozSjdfmC8hzqA9KKxSHGNMuq8KNHxTS3MAHcpwZ9re
         gFAApzwa1X1cXpQPufZ5XvrefNOWfYo0ZL3xUVG3gnoCWbYw3cTh2vnDmtQJhlBj+1M6
         7RJ8yM7yfh//zG1ggpEh6bKfJnh2jsNlVCuBc5MF4AwxEwfo0u4mS31yyqnrV24WpYuv
         fjSCKn3F6ukeH8HDFcYnaQfnn/jPS5ztCh2jrhQq4E5pEqCQ6DQzhkvFQ/bTDiW5tNtR
         9D/Swy3LERJeMEEFWDYYKf9jI7Psq1hyr3R4S2vg/lKTLx8LXDmHQy3Rp2xVP+72Y6N3
         kkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=8gBvNQKsQIXOjPtAEqCN7AdimgnL9us4xsxNyDOMoNI=;
        b=2lpruSzOq8mZJ+lKmd/NnaB3Owy6o0kFjlntr//Pib59h6lUnPagtIW9A9COYXWc2z
         Djg+rswTcsf08hJX8vKwUVkmpJwXe7KgxRLkc2WfJwweDCVGcUQVg9xLcGK3J9iPfVCi
         nB+uUthWgRTrV7nssQYgbjT9UkyrAnTXYpb1jQI1EPuG95tApn/c8ewcU3kXrr3PleRD
         WkRlEtxWoaMzSP2AC0DgyOH8qBjyGYeA5RAqtG69AhSx8MYr1YsFgy1HCar9txRscrLw
         DEAmoO61W/uM2/u31UiKMkn20EwM0XJaWuVrIuQ2prB3lGpzWsZZQxrkY+AMUeOjBiUz
         JBZQ==
X-Gm-Message-State: AOAM5334Bmha5HBWkYjdRgg3oJOtjvxtFsGwWlnY73GLQPsF5w+I0MQo
        3sofHn8OO+1HNiwaDIZiBVo=
X-Google-Smtp-Source: ABdhPJzuzsfR2eJQqbj2BKML6u3AxPu4aGyT2TwdmSBNjZ0AA8z4Djgk0Dv2oq0tUjc9WYpY++aDoQ==
X-Received: by 2002:a1c:2209:: with SMTP id i9mr16489019wmi.20.1634171494999;
        Wed, 13 Oct 2021 17:31:34 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e8sm1323066wrg.48.2021.10.13.17.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 17:31:34 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/7] ls-files: fix a trivial dir_clear() leak
Date:   Thu, 14 Oct 2021 02:15:32 +0200
References: <cover-0.7-00000000000-20211006T095426Z-avarab@gmail.com>
 <cover-v2-0.7-00000000000-20211007T100014Z-avarab@gmail.com>
 <patch-v2-5.7-73cf1018953-20211007T100014Z-avarab@gmail.com>
 <xmqqily8o3kw.fsf@gitster.g> <8735p5hwg6.fsf@evledraar.gmail.com>
 <xmqqczo8hhq2.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqczo8hhq2.fsf@gitster.g>
Message-ID: <87lf2wh2fu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 13 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> -       if (ps_matched) {
>> -               int bad;
>> -               bad =3D report_path_error(ps_matched, &pathspec);
>> -               if (bad)
>> -                       fprintf(stderr, "Did you forget to 'git add'?\n"=
);
>> -
>> -               return bad ? 1 : 0;
>> +       if (ps_matched && report_path_error(ps_matched, &pathspec)) {
>> +               fprintf(stderr, "Did you forget to 'git add'?\n");
>> +               ret =3D 1;
>>         }
>>=20=20
>>         dir_clear(&dir);
>>         free(max_prefix);
>> -       return 0;
>> +       return ret;
>>  }
>>
>> Doesn't make much sense, but I can re-roll with it if you feel strongly
>> about it. I think the current version is ready to be picked up.
>
> I do not see where that "doesn't make much sense" comes from.  If it
> does not make sense, I wouldn't have mentioned it.

I meant "I don't think that makes much sense".

>> Yeah we should avoid refactoring-while-at-it, but in cases where a patch
>> removes the only reason a nested if/if statement exists, unrolling it
>
> And I do not quite see what "the only reason" is in this case, or
> what it has to do with the restructuring, either.  Care to either
> clarify, or fix the patch, or perhaps both?

I mean that we generally don't write code like:

	if (x) {
		if (y) {
			fprintf(...);
			ret =3D 1;
		}
	}

And instead write:

	if (x && y) {
		fprintf(...);
		ret =3D 1;
	}

So aside from the specific change here I thought your objection would
also apply to e.g. removing braces from a standalone "if" as it's
reduced to a one statement body, which we we generally do.

But reading your upthread:

    [...]the "ah, report_path_error() always returns true" does not
    belong here.

I think the objection might be in folding that in particular into the
"if" statement?

The point of this change is that if report_path_error() was non-zero
we'd skip the freeing before, but shouldn't.

So any change here would have wanted to fall through the "if", but we
need to do the fprintf() if report_path_error returns true.

So I don't really get that "always returns true" comment means in this
context. It returns true on error, and dealing with that code branch in
relation to the freeing is what this change needs to concern itself
with.
