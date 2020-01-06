Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DDAC33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1649A207FD
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 23:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="nN1HkdbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAFX36 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 18:29:58 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:55481 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726545AbgAFX36 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 18:29:58 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 169573407CD
        for <git@vger.kernel.org>; Mon,  6 Jan 2020 23:29:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a56.g.dreamhost.com (100-96-15-236.trex.outbound.svc.cluster.local [100.96.15.236])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 30C1F3402BE
        for <git@vger.kernel.org>; Mon,  6 Jan 2020 23:29:56 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a56.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Mon, 06 Jan 2020 23:29:57 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Eyes: 35c3a6017b350240_1578353396868_520506470
X-MC-Loop-Signature: 1578353396868:2802364709
X-MC-Ingress-Time: 1578353396867
Received: from pdx1-sub0-mail-a56.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a56.g.dreamhost.com (Postfix) with ESMTP id 8C4E284C2E
        for <git@vger.kernel.org>; Mon,  6 Jan 2020 15:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=qrpff.net; bh=CyvZkWCZq+uSu92MQQWj/fsK6bU=; b=n
        N1HkdbI6VdnJtmqFTodr4F03TbnbE2HcZyfkqIvMPgi2RMYzOUZsT3HznByZgYHS
        /mJ7NdlYC7SB3CAQb9FwQ5GIjCtB0dmbekLteqQwphu8dvrrs+FmLg/fjKIvgxTT
        oA22InTVYMhV4b/YwTf+VQdw6KcGXFyf4cKimhaHcE=
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a56.g.dreamhost.com (Postfix) with ESMTPSA id 001CF84C06
        for <git@vger.kernel.org>; Mon,  6 Jan 2020 15:29:49 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id i23so37542670lfo.7
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 15:29:49 -0800 (PST)
X-Gm-Message-State: APjAAAUdx1xPhSZfPZgNSRCFMqUy/CnhgQywY7fxWJFIhZVDJPCzgQbM
        sWJjbleTNqiZSpzk7Xoy16DaN3RaNa77Edv/C0o=
X-Google-Smtp-Source: APXvYqx7BcrHNEYK2vLaSwDUAd6xkwPBSfkI7PmnoLaKpuU6KNfCSnvS87QEZNmV/ajp+SFE5yI0fo1f0Uyg7KGTo84=
X-Received: by 2002:ac2:5605:: with SMTP id v5mr59645617lfd.136.1578353388035;
 Mon, 06 Jan 2020 15:29:48 -0800 (PST)
MIME-Version: 1.0
References: <20200104034551.23658-1-stevie@qrpff.net> <xmqq1rsfddkq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1rsfddkq.fsf@gitster-ct.c.googlers.com>
X-DH-BACKEND: pdx1-sub0-mail-a56
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Mon, 6 Jan 2020 18:29:35 -0500
X-Gmail-Original-Message-ID: <CAD_xR9faremhsGP4G65vHj=cvskUbK1rpPrQisa2_4AD2AGNYw@mail.gmail.com>
Message-ID: <CAD_xR9faremhsGP4G65vHj=cvskUbK1rpPrQisa2_4AD2AGNYw@mail.gmail.com>
Subject: Re: [PATCH] bisect run: allow '--' as an options terminator
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepgghfjgfhfffkuffvtgesthdtredttddtjeenucfhrhhomhepufhtvghphhgvnhcuqfgsvghrhhholhhtiigvrhcuoehsthgvvhhivgesqhhrphhffhdrnhgvtheqnecukfhppedvtdelrdekhedrudeijedrgeejnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqlhhfuddqfhegjedrghhoohhglhgvrdgtohhmpdhinhgvthepvddtledrkeehrdduieejrdegjedprhgvthhurhhnqdhprghthhepufhtvghphhgvnhcuqfgsvghrhhholhhtiigvrhcuoehsthgvvhhivgesqhhrphhffhdrnhgvtheqpdhmrghilhhfrhhomhepshhtvghvihgvsehqrhhpfhhfrdhnvghtpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

Sorry about that sloppy test script; that'll teach me to try cleaning
up a patch late at night.

On Fri, Jan 3, 2020 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:


> I do not think I have seen enough to justify addition of "--",

That's fine; I was just trying to be thorough (also, it was easy to
test.) I was taught: if you accept any -options, honor -- as well. If
you're not concerned about that, that's fine with me.

> but
> addition of tests by itself may have a value, and I'd prefer to see
> it as its own patch.  But I see hits for
>
>         git grep 'git bisect run' t/
>
> already in t6030, so "adds an actual test script", while it is not
> telling a lie, may be giving a false impression that it is adding
> something new that has been missing.

Mmh, I didn't see those 'bisect run' tests in there; clearly, I didn't
look hard enough.  I was distracted by several factors, including the
filename (t/t6030-bisect-porcelain.sh: I associated "porcelain" with
"output intended to be parsed".  Since run doesn't have any meaningful
parse-able output, I did not expect to find it there.) and the fact
that bisect apparently has all of the test cases in one single script,
when (for example) rev-list currently has 23 different test scripts.

> > +exec </dev/null
>
> All of our test scripts are designed to be used unattended with the
> use of test_expect_* harness helpers.  Can you tell us why this new
> file alone needs to dissociate the input to _all_ its subproesses by
> doing this, while others do not have to?

Ironically, that line was copied straight out of the top of t6030.

>
> > +. ./test-lib.sh
> > +
> > +{ test_expect_success 'Setting up repo for "git bisect run" tests.' "$(cat)" ; } <<'SETUP'
>
> Yuck.  I have to say this is trying to be too clever and cute than
> its worth.  Doesn't it defeat test-lint, for example?

Actually, it doesn't.  test-lint is too devious :-o

I was trying to adapt the script that I initially wrote to set up a
repo for manual testing.  A heredoc was the easiest way to achieve
that without having to worry too much about escaping.

<more advice on readability and portability snipped>

> Thanks.

No, thank you, for putting up with me :)

Anyway, it sounds like: (a) the feature my patch adds isn't wanted or
needed, and (b) the functionality I *thought* I was adding test
coverage for already has test coverage, so we can kill this particular
thread entirely.


--
-- Stevie-O
Real programmers use COPY CON PROGRAM.EXE
