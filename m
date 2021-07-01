Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51BC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF576140A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 10:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbhGAK4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 06:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbhGAK4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 06:56:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1AAC061756
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 03:53:44 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id v20so9625868eji.10
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 03:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=F5pT0a/sLyaA5OOG/lA3V5LTlo606v9UBEoa8R1C6ts=;
        b=o6m2Q54l+MpzAUfcdXWC0s8I+KpzH90a4BlaOoBAmwZ61u4fJT5yAXchYkqiLYTGuz
         M1FwcBPBR5DqqnIjwp4tYV/sxQUKObG4+FsIXjmVXBeSjS3BVDXL4+N9LqyTLFm66ehX
         awNMQGbbBxMR/DuVYpmGwNz94tR7vocWwb4/kqxM9Z1JjwoWgtCzWMjg0qBcssUM++KG
         QAHoLUwftnQGZ118I6KaX+bt7PJ/1/ME18J9f/I1JN87AtURpsW6igkyKzrOWzwlFFFK
         GsAkDevJHefZfNttwltpoxMn7cBY0EuLG15L5y2rIAhZEmsubq+inKeNeNh0Rf80wky9
         A+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=F5pT0a/sLyaA5OOG/lA3V5LTlo606v9UBEoa8R1C6ts=;
        b=I5F5xLmcu5geETcElqBY3JV7UMdlQc5+gEVucM3srZtl56Ibp+pt7YTNzlLhpydHFe
         u8ygr0n5OXAoJHDRvSeKmL13gFuO6BhNg4MPjBAo37tRXAQ8aPt5nEJZm/el9A/4q+cz
         TVxlc5c1h7RsB0e500WHZy4VDpD+1ASzvnjvB6Prja70GfZSfMTYnTXl9lsgLQuZrPqd
         +mzsrU47uVHfiUcT1scMmRS2iRxxN+0i7grDMm4oMJIKDwJGThSfUKjlwCmtWgngLQ0a
         dron/Ql72K83PVdbyAJEMBpVhqYQ8RJMLrvS++3qqCqkeS5oiL9lJsXHyIE/FAm5Irs1
         v4eA==
X-Gm-Message-State: AOAM532LhTTRkAwwGK4C9AXBrVeyvV6/gwZKtw2+irhwpu/lJjUx6IUJ
        mlHlSS8x3LSgTvhtaAKxRJU=
X-Google-Smtp-Source: ABdhPJw7Q2ezxq0Xt2c7g5sJY8oG+PAH5qdoRg8nLXUFyH7u09wTd/L+1ogEoYhRWLeVd3tx355+2A==
X-Received: by 2002:a17:907:7662:: with SMTP id kk2mr39747463ejc.218.1625136822911;
        Thu, 01 Jul 2021 03:53:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h22sm550080edr.37.2021.07.01.03.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 03:53:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 0/3]
Date:   Thu, 01 Jul 2021 12:53:26 +0200
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <YNyrDxUO1PlGJvCn@coredump.intra.peff.net>
 <YNytp0JAIaQih0Y4@coredump.intra.peff.net>
 <87y2ardygj.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87y2ardygj.fsf@evledraar.gmail.com>
Message-ID: <87mtr6e24q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 30 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jun 30 2021, Jeff King wrote:
>
>> On Wed, Jun 30, 2021 at 01:34:07PM -0400, Jeff King wrote:
>>
>>> As an aside, having to have a separate bundle_header_init() and
>>> BUNDLE_HEADER_INIT is annoying (because they both must be kept up to
>>> date with each other), but quite common in our code base. I wonder if
>>> writing:
>>>=20
>>>   void bundle_header_init(struct bundle_header *header)
>>>   {
>>> 	struct bundle_header blank =3D BUNDLE_HEADER_INIT;
>>> 	memcpy(header, &blank, sizeof(*header));
>>>   }
>>>=20
>>> would let a smart enough compiler just init "header" in place without
>>> the extra copy (the performance of a single bundle_header almost
>>> certainly doesn't matter, but it might for other types).
>>>=20
>>> Just musing. ;)
>>
>> For my own curiosity, the answer is yes: https://godbolt.org/z/s54dc6ss9
>>
>> With "gcc -O2" the memcpy goes away and we init "header" directly.
>>
>> If we want to start using this technique widely, I don't think it should
>> be part of your series, though. This probably applies to quite a few
>> data structures, so it would make more sense to have a series which
>> converts several.
>
> That's cool, yeah that would make quite a lot of code better. Thanks!

Just for future reference: I submitted a small series to make use of
this suggested idiom:
https://lore.kernel.org/git/cover-0.5-00000000000-20210701T104855Z-avarab@g=
mail.com/
