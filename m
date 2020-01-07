Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0213C32771
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 00:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE5B2072E
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 00:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qrpff.net header.i=@qrpff.net header.b="a1l3LiCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgAGAKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 19:10:22 -0500
Received: from bonobo.elm.relay.mailchannels.net ([23.83.212.22]:21285 "EHLO
        bonobo.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbgAGAKW (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 6 Jan 2020 19:10:22 -0500
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EEBD2E1163
        for <git@vger.kernel.org>; Tue,  7 Jan 2020 00:10:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (100-96-85-12.trex.outbound.svc.cluster.local [100.96.85.12])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 59FA7E1378
        for <git@vger.kernel.org>; Tue,  7 Jan 2020 00:10:20 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|stevie@qrpff.net
Received: from pdx1-sub0-mail-a42.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.18.5);
        Tue, 07 Jan 2020 00:10:20 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|stevie@qrpff.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Army: 2710e43d52aa8a2b_1578355820811_2081901665
X-MC-Loop-Signature: 1578355820811:1867239328
X-MC-Ingress-Time: 1578355820810
Received: from pdx1-sub0-mail-a42.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a42.g.dreamhost.com (Postfix) with ESMTP id 4263181DE3
        for <git@vger.kernel.org>; Mon,  6 Jan 2020 16:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=qrpff.net; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=qrpff.net; bh=k2yJKaUVui49jE+8AaPv2v/ZdG4=; b=a
        1l3LiCohMaPeKR4cXYqfcTK4LZlCnPdqfNqk8PB/lhgYb4logRfCLg516au1EGi4
        S4M5hZ9txiWQ5BxHWHU9JTu8VfxEYrIm790lK+k+c5GbfYA9NWH7Nxihhu66/NKk
        ofro1QjnTd5EjYEtog2e4wsw9eUoFsoUQmq30ANJ0o=
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stevie@qrpff.net)
        by pdx1-sub0-mail-a42.g.dreamhost.com (Postfix) with ESMTPSA id D663D81D55
        for <git@vger.kernel.org>; Mon,  6 Jan 2020 16:10:14 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id l2so52785994lja.6
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 16:10:14 -0800 (PST)
X-Gm-Message-State: APjAAAVNU7dCq1pCo64ggX0Irl0cuj6mfgBY0EkatdTqZczGlvSi8dNT
        0PGczB1JdS7vfnKPXpZR9Y/kzmjcpKy3eXKXPRE=
X-Google-Smtp-Source: APXvYqyhV1VGOGexi/PPZfD9+np81EM8PvtARzu+Pf3d7PUNyMT9pZ6rjlAoe5kde3A/7Abr5FBGYsAppzTUqWUh7f0=
X-Received: by 2002:a2e:868c:: with SMTP id l12mr17291055lji.194.1578355813074;
 Mon, 06 Jan 2020 16:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20200103043027.4537-1-stevie@qrpff.net> <xmqqftgvdhpz.fsf@gitster-ct.c.googlers.com>
 <CAD_xR9fUxDTvwmAsfH-6=buRP+UmwBHhQJSV+T3paUOy-S1CGw@mail.gmail.com> <xmqqy2ul9yg0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy2ul9yg0.fsf@gitster-ct.c.googlers.com>
X-DH-BACKEND: pdx1-sub0-mail-a42
From:   Stephen Oberholtzer <stevie@qrpff.net>
Date:   Mon, 6 Jan 2020 19:10:00 -0500
X-Gmail-Original-Message-ID: <CAD_xR9dGNKdVNzFgFUaZCgJetpW5tXxb8wERovdjbc=1jS-KxA@mail.gmail.com>
Message-ID: <CAD_xR9dGNKdVNzFgFUaZCgJetpW5tXxb8wERovdjbc=1jS-KxA@mail.gmail.com>
Subject: Re: [RFC PATCH] bisect run: allow inverting meaning of exit code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehuddgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpeggfhgjhfffkffuvfgtsehttdertddttdejnecuhfhrohhmpefuthgvphhhvghnucfqsggvrhhhohhlthiivghruceoshhtvghvihgvsehqrhhpfhhfrdhnvghtqeenucfkphepvddtledrkeehrddvtdekrddujeeinecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehmrghilhdqlhhjuddqfhdujeeirdhgohhoghhlvgdrtghomhdpihhnvghtpedvtdelrdekhedrvddtkedrudejiedprhgvthhurhhnqdhprghthhepufhtvghphhgvnhcuqfgsvghrhhholhhtiigvrhcuoehsthgvvhhivgesqhhrphhffhdrnhgvtheqpdhmrghilhhfrhhomhepshhtvghvihgvsehqrhhpfhhfrdhnvghtpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio,

On Sun, Jan 5, 2020 at 8:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Yeah, I know.  I didn't mean to give you a perfect solution and that
> was why I said "along the line of...".  I know I ignored the 128 and
> above, as I usually trust that our contributors are competent enough
> to be able to fill in the missing details given an outline.
>
> The key takeaway I wanted you to notice was that a single case
> statement that maps the exit code external command would give us
> would look sufficient, without any of the {SUCCESS,FAIL}_TERM magic
> you had in your version, which indicates that there is more than the
> simple "using a run script to find where a bug was fixed can be done
> by swapping exit code" going on.  And it is quite unclear why that
> is needed either from the patch or the text that accompanied the
> patch.


In this particular instance at least, I'm not competent enough to come
up with a clean, portable way to create a single case statement that
handles the final condition.
The issue I'm having is that case-esac blocks do string matching, not
integer value matching, so I don't know how to replicate the current
behavior without a case pattern that looks like
[12]|1[3-9]|1[01][0-9]|12[0-467]|1[3-9]|2[0-9]|[3-9].



-- 
-- Stevie-O
Real programmers use COPY CON PROGRAM.EXE
