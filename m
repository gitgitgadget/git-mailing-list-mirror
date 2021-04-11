Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1A8C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:56:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31E3F61027
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 19:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbhDKT4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 15:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235486AbhDKT4V (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 15:56:21 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8912C061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 12:56:04 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id h10so12501893edt.13
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JrQXRyU3hZwxliS6stHvNggNioQj585l7bC+4iX3n1k=;
        b=tUMv7VH4W18bIBj5bQoZ+qMu1f7CxuldoZs22K1WL+btFetjJ+8toEzFK3UH2EvqNn
         J4M/IiZ78edu4OT0dL3SPoaxTfPk0GEu9T/mIqeb2pEqGUcEZn/z845aSmFvY8kqSRq0
         +zmYqnTFJu8Vd32sYDUeS0MyabTIAk5H6X0f753fhfduG9LSXRp2K6p+cnNeqQO6+Yo8
         8JuSGIdmabWG53b9U7H/oE01MtUc0gk1VaKqYcYffAorr58wH8LgnGkaBEutoj+uQXgy
         5MBsH0xq8KE9h0e6BsJ5IgtHw5AZEc5/GtFL7rp1WbnGwarQSNdDeawVdJnWeVTOZz4W
         bzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=JrQXRyU3hZwxliS6stHvNggNioQj585l7bC+4iX3n1k=;
        b=E+i0HFuLN7QJzJCrCTbwsdQOrsNzRrFm49U+Fq5lI5ZReIqSq0o6yQ8+ojqESnKQYM
         mvtjuU/u+i7rnU84mh9Od5uVdn89SCa01kLqzctb+Or5guTqTvJoDIWQC+U143ocZux3
         oTKKDqP+OvTdQDYMar1HTHhah65HAR89VheyuWqb79tVceT2LJTC0kvsSwSMm9IEq3al
         HdzQs6ZGo81clGpisSHi9bi+LAZy9eKZ5R9D5+lykDEsGi7/EUhr1cA00XC5601oRN+R
         i+YY+c3AJfV+pbzJbtukGD6kGbi9Mp3Owowr4pwWbAcrgc7Kugy0xILxB7OMSkYRzQDe
         uLSw==
X-Gm-Message-State: AOAM531MIHfiHd3eKDXjrnVv6w6FTb1i0p6UNBfKQnquCujREA/5ddGS
        yygNm3Xlsb7AsaRIFRQdX2g=
X-Google-Smtp-Source: ABdhPJymm/N5J+d2vO738eD0j2rXQ7WJ9UuMjS0nRhn8HG6UUYS4egnlMkBmBMj4Y7fx8UqHpHBIBg==
X-Received: by 2002:aa7:c451:: with SMTP id n17mr26462200edr.197.1618170963255;
        Sun, 11 Apr 2021 12:56:03 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id u19sm5265833edy.23.2021.04.11.12.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 12:56:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com>
 <87blakgaxr.fsf@evledraar.gmail.com> <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
 <878s5ogagz.fsf@evledraar.gmail.com> <875z0sg8t9.fsf@evledraar.gmail.com>
 <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga>
Date:   Sun, 11 Apr 2021 21:56:02 +0200
Message-ID: <87zgy4egtp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, Drew DeVault wrote:

> On Sun Apr 11, 2021 at 11:06 AM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
>> 3. While I'm very much leaning to #1 being a good idea, I'm very much
>> leaning towards introducing this "starttls" alias being a bad idea
>> for the same reason.
>>=20=20=20=20=20
>> i.e. let's not create a new 'starttls' if we can avoid it explicitly
>> because we used to have the long-standing "anything unrecognized is
>> empty =3D=3D no encryption" behavior.
>>
>> A lot of users read documentation for the latest version online, but
>> may have an older version installed.
>
> I feel quite strongly that the options here are a grave failure of
> usability, and that it needs to be corrected. I help people troubleshoot
> git send-email problems quite often, and this is a recurring error.
> However, you make a good point in that someone might see some online
> documentation which does not match their git version and end up with a
> surprisingly unencrypted connection.
>
> As a compromise, let's consider making this a gradual change. We can
> start by clarifying the docs and forbiding the use of any value other
> than 'ssl' or 'tls'. If an unknown value is set, the user is not getting
> the encryption they expected anyway, and this should cause an error.
>
> Then we can leave the issue aside for some agreed upon period of time to
> allow the change to proliferate in the ecosystem, and then revisit this
> at some point in the future to rename the options to make more sense.
>
> Does this seem like a reasonable compromise?

I suggest we don't compromise and just go with whatever you're OK with
:)

I really don't care enough about #1 and #3 in my E-Mail to in any way
push for it, sorry if it came off that way.

I just wanted to check your assumptions when reviewing the series. I do
think that it would make sense to more prominently note something to the
effect of "this was documented to do X all along, now we do Y, but
that's OK because ABC", and to note why the new starttls =3D plaintext on
older versions is OK, maybe it's just fine. I really don't know.

Isn't it pretty common in any case that SMTP servers in the wild just
refuse plaintext these days when dealing with auth'd connections? I
don't know.

I do think it makes sense to fixup for my suggested #2, i.e. not leaking
the internal detail of the "empty string".
