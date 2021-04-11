Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B628C433ED
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B6BC610CA
	for <git@archiver.kernel.org>; Sun, 11 Apr 2021 14:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhDKOak (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Apr 2021 10:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbhDKOaj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Apr 2021 10:30:39 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81FC061574
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:30:23 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m3so11943297edv.5
        for <git@vger.kernel.org>; Sun, 11 Apr 2021 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wMHkBp5qK1aFe9YG+xv/iq8YRyU+25JV2dd9lSyeJAg=;
        b=I1NkMtODDuCs70/n4imPhvHQQdJcM9JNGA6HIkB9rEl2EPQaTkU+7w8krqn2tsE94a
         fWJLNUmiSKUZoX0Xrw/992l8PX4MwbwpG/kHVU8bgpSw8+gfSK9o0TOtVnvM2yZ/guhj
         Zer4MvWyuzOxEl98oIvvpCBwtuZL/6sObKtlHCA+XUOLHzt9wUpWjZ1br4uqVg8xhRYC
         6Go0cUDAxX3wkjYGbnK0gsn14vJSlysoxLWrL6L5A9RXEulpSH6bzTI14Qlz6i010qJp
         KOEC4nFaCsM5W4t0IseHkT/25WYRPh9K5ayT94VqB01/UCLbJYiP0T/nbIk3CZcng5qR
         CcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=wMHkBp5qK1aFe9YG+xv/iq8YRyU+25JV2dd9lSyeJAg=;
        b=aJETA83ZUNVP00Zg8LoXgarmZzAjsmuWQak0riIrvn1N57tQqAQ7xk1xoGlPAzbs/T
         BMyeK5PxwTlqvDPwSh4hXgm3rccAQvmHYUZvhMcXvnuwa9hEn2hi5nRQRjxhoJNWGYxa
         2Mr8pGInwZqcaB9/BGDW1vYOC9jxufzC9kZ5EE0HtUj4B2r191FQNV2e7P9iTRq1msuP
         JmTtq6CggbbOt9rsK9dIhT18vHq+VhoPf4e1voCV13v3snawhz3ZZxH/j9AXfTptQOZ8
         S7d2woKq46yy+IAW1Se9bqXMRVA4EHRX1eGKuv1klQaiSU/aUs5OD/O6Wyenk8dwAi4f
         0YBg==
X-Gm-Message-State: AOAM533KfQuZsTrKNDk4CoX+ahkcRv9hOewkfpH4ysHjCdvgDTiq2a6s
        raUDagVlLSaiJiHgeXUctw9CZ2eeCwA=
X-Google-Smtp-Source: ABdhPJwz7ilIT9UuLhgeEgiTu91g+fadokjmD0br/cACRnjFp7VTJYROUxm8TBdVlsRltC4tefYvFQ==
X-Received: by 2002:a05:6402:1004:: with SMTP id c4mr25754195edu.364.1618151421706;
        Sun, 11 Apr 2021 07:30:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id yr16sm3203663ejb.63.2021.04.11.07.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 07:30:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com>
 <87blakgaxr.fsf@evledraar.gmail.com> <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
Date:   Sun, 11 Apr 2021 16:30:20 +0200
Message-ID: <878s5ogagz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 11 2021, Drew DeVault wrote:

> On Sun Apr 11, 2021 at 10:20 AM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on wrote:
>> >  # 'default' encryption is none -- this only prevents a warning
>> >  $smtp_encryption =3D '' unless (defined $smtp_encryption);
>> > +if ($smtp_encryption ne "" && $smtp_encryption ne "ssl" && $smtp_encr=
yption ne "tls") {
>> > +	die __("Invalid smtp_encryption configuration: expected 'ssl', 'tls'=
, or nothing.\n");
>> > +}
>>
>> Having not tested this but just eyeballed the code, I'm fairly sure
>> you're adding a logic error here, or is $smtp_encryption guaranteed to
>> be defined at this point?
>
> I will admit to being ignorant of much of Perl's semantics, but I had
> assumed that the line prior to my additions addresses this:
>
> $smtp_encryption =3D '' unless (defined $smtp_encryption);

You're right, I just misread the diff. Nevermind.
