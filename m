Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCBCC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 15:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiKPPPS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 10:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKPPPR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 10:15:17 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490DBE48
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 07:15:16 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ud5so44893609ejc.4
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 07:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jiYxnuYE5ewRz1sFWVLqnsVrIAROt0yEqJlk8yqIytc=;
        b=jwUS3YhAc773+IwjYWWx0HYjhrhZwBC0IxCY8M53eljttYRRnvk03wc4M71q5GZWGE
         ykk9NPBNQyrNy6e1FM4aUEKhL653wTDlLqvcGzNXEqTC2KQjQY80mQvEGSlBOI7C0/5u
         AqwNYEgD1H5cVkgShXiSsMJ25HgLW1dNRg+D3DkTlthFq8YpUPgiWNHNsLZO3o5b6SN6
         1wdRJrcjT+PgXVTmwT2xQCdzn4J4bXixa1mjsgbKMflq7ZSRh3vYMC5pGyVyx3DGwyai
         VXS+34fA4IWSHfvmjAbvfwtwsC2J72axfBFsmsoEiZlurC7wA/VP1Go2Vtd8Guh6XIvR
         1HQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiYxnuYE5ewRz1sFWVLqnsVrIAROt0yEqJlk8yqIytc=;
        b=bx2aLTgN5cg0GJqByBtfFS8f84xh4lkJwypn/MnOsEzixGIMOVtlgLqQSnVf7f79Pc
         iCcRMqkrLjUZnGuO5fSNQI0BO66zATBMdzRHRCxTJLy2CNsjvf3+E0GU0zRugf9eWUSm
         jW+rvsBV5vlsHrCJ7sVkMW43hSGulNc5mXrcQGEIWDlRi4c4gnBaHDI8WjYfZHHrc/QD
         UERNG0sIf9z0/qaN7aMj+NwvaLYJUe0MX7CbzUUCbd0I3c5A9agohg1uuzDv11cqzNEr
         LiE7IoGlOxEFIrt20QZ83ZgIzS5mqYO7lSWK7PNcQMZKMztR1Cy1cXeOE57kSQ230fSa
         Z0WA==
X-Gm-Message-State: ANoB5pmcL8iktqfJaYccTlxDq106XsU5tAKZgVouYplWZ/tRhjkfp9E5
        m3w8k1raqJSFdoKhhxjInK8=
X-Google-Smtp-Source: AA0mqf7ej2mOYrBDBj+Av8fSvc0Lz/et6F4ktbNtLB7fF5M54em0ABJevSUKnt/wJmWFpcHdJ/om9Q==
X-Received: by 2002:a17:906:6057:b0:7a0:b505:cae5 with SMTP id p23-20020a170906605700b007a0b505cae5mr18222574ejj.648.1668611714704;
        Wed, 16 Nov 2022 07:15:14 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id ee4-20020a056402290400b004585eba4baesm7615047edb.80.2022.11.16.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 07:15:14 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ovK89-004EJ9-26;
        Wed, 16 Nov 2022 16:15:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ronan Pigott <ronan@rjp.ie>
Subject: Re: [PATCH] builtin/gc.c: fix use-after-free in
 maintenance_unregister()
Date:   Wed, 16 Nov 2022 16:14:30 +0100
References: <2cbead254b77cb02d219bca8f628dc4362c045b0.1668538355.git.me@ttaylorr.com>
 <221115.86r0y4j8tr.gmgdl@evledraar.gmail.com>
 <Y3Puhtj8Q8kf2wt0@nand.local>
 <2ce55cf7-5eef-8e6d-7b91-9a4bc16ed1c4@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2ce55cf7-5eef-8e6d-7b91-9a4bc16ed1c4@github.com>
Message-ID: <221116.865yffj5ha.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Nov 16 2022, Derrick Stolee wrote:

> On 11/15/22 2:54 PM, Taylor Blau wrote:
>> On Tue, Nov 15, 2022 at 08:41:44PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>>>> @@ -1543,6 +1543,7 @@ static int maintenance_unregister(int argc, cons=
t char **argv, const char *prefi
>>>>  	int found =3D 0;
>>>>  	struct string_list_item *item;
>>>>  	const struct string_list *list;
>>>> +	struct config_set cs =3D { { 0 } };
>>>
>>> Just "{ 0 }" here instead? I see it may have been copied from some older
>>> pre-image though, and they'll do the same in either case, so it's not
>>> important...
>>=20
>> Copying from other zero-initializations of `struct config_set`:
>>=20
>>     $ git grep -oh 'struct config_set.*=3D {.*' | sort | uniq -c
>>           3 struct config_set cs =3D { { 0 } };
>
> Yes, without the double braces the compiler will complain on
> macOS, I believe.

Ah, that was sorted in 54795d37d9e (config.mak.dev: disable suggest
braces error on old clang versions, 2022-10-10).

It's fine here, we can follow-up for the #leftoverbits of changing those
some other time.
