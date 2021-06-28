Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21AEC2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4736198A
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 07:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbhF1HvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbhF1HvA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 03:51:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE7CC061574
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:48:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g4so9587584pjk.0
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3wl6F6Cr6s1F2eV0saEb2J+Y9sNdljU5QnFQrExFGKc=;
        b=So2ygdJ+U09/8IAUmVfMrq9vUpE0iiu6uqRgTlCTHKcgFz5QipBA1zcMG54qZ/mobo
         lKwzaKsJ7KG7ibl4rMrfse/Ma5vDnZIZ+zwZVE3ECvAJYEp9PMA/b8FefcpcyQbKwzYL
         3pgHpMCKhl2pisuAAuTCWr89cGtUIsFuahU/grroHiU9nycAFkV043hWP2dJ9a+q6Ay5
         orPJ7+68XbqLT5Q/7R60ymNf9OWpeNayWfTD8VeQ6GVCbRa1IAxrDCrkWDBbVGn2hA7G
         1R19mlV0AXvJ72T0V9tOqoUOSBXcMW5xiZR+M8mFyVcM1lx9b1g6zQfo5NfdlGw5yfZw
         MkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3wl6F6Cr6s1F2eV0saEb2J+Y9sNdljU5QnFQrExFGKc=;
        b=Ttteo6WlaQ8k49sACl6ApZqroaMLg3dVxa/zuUGTX7yphAkcamxLoJkDPdrc++Somd
         ylIBjvlQlraBGhetPeR99dQSv8G9lDo3KGXS/71mxzE8ceW2HpQRrd1ZMa+PulJnEgce
         QjFbCy5a02yW7HIZq41hpf0Q5V7X9nweWq+tmhPr/jifvVEsQY1L6i+bb/ccqDt5Q2BS
         w6451nAMr9zi5QO1MCr7iixtj3uTxJQbCRnqAsk1odsMnd4buby7KlwWyVGPBUNynQge
         Nzq3Qr2DH33AHT7CYJg4KFra9hCTlnERfDqF7ml7Yq3eVYL1ggi3wCZEBT006YLJxQ3T
         TIDg==
X-Gm-Message-State: AOAM532HnWNObjryQ4+B4WIefO7YYbz6JQSjDq5iM0z2WrtxGnkFWOQ5
        ftw+O+OJIu6hseUChZrizUY=
X-Google-Smtp-Source: ABdhPJwNVcg2IgRwiHDv0Q9yqFI7uDZZJSDOWa8PMiHeX6hVlzVrJRMcbLVsX7xzCFZTC0dte/ABsg==
X-Received: by 2002:a17:902:720a:b029:120:e07d:cc1c with SMTP id ba10-20020a170902720ab0290120e07dcc1cmr21247873plb.13.1624866513591;
        Mon, 28 Jun 2021 00:48:33 -0700 (PDT)
Received: from smtpclient.apple ([119.82.122.143])
        by smtp.gmail.com with ESMTPSA id pj4sm5548654pjb.18.2021.06.28.00.48.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jun 2021 00:48:33 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=94_Week_6?=
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAP8UFD2xCzJ7hxd_Of0FWnPKGzm9j9DizK55GyMhedzGgbs8gA@mail.gmail.com>
Date:   Mon, 28 Jun 2021 13:18:30 +0530
Cc:     Git List <git@vger.kernel.org>,
        Shourya Shukla <periperidip@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F28CA742-014E-4279-8A0C-825DF773FA33@gmail.com>
References: <4E38928E-A98D-4F57-8866-8A237B31DDE0@gmail.com>
 <CAP8UFD2xCzJ7hxd_Of0FWnPKGzm9j9DizK55GyMhedzGgbs8gA@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28-Jun-2021, at 03:37, Christian Couder <christian.couder@gmail.com> =
wrote:
>=20
> On Sun, Jun 27, 2021 at 1:24 PM Atharva Raykar <raykar.ath@gmail.com> =
wrote:
>>=20
>> Here's the latest instalment of my weekly Git blog:
>=20
> s/instalment/installment/

Instalment is the commonwealth spelling:
https://wikidiff.com/instalment/installment

>> https://atharvaraykar.me/gitnotes/week6
>=20
> Great, thanks!
>=20
> Small nit: s/has not not yet/has not yet/

Thanks, I'll update it.

> About "This kind of an invocation was done before in the context of
> submodules, but it does not look reusable to me because it seems to
> have side effects, that meddle with the repository=E2=80=99s object =
store."
> couldn't a commit walk do the job (see
> Documentation/MyFirstObjectWalk.txt)?

I did have a look at it (not very thorough, though), and I immediately
felt that it was too low-level to be a drop-in replacement for
'is_tip_reachable'. I'll have a more thorough look at it though, and
see if I can make that work out nicely.=
