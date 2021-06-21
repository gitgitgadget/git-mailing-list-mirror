Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCDCC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 12:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936C260698
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFUMwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 08:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbhFUMwR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 08:52:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073CFC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 05:50:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id m14so2068035edp.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 05:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=7qOxMsur1Y9IR3+rVs5OD7ie6BcPv4lIkDGk+dh2Fyo=;
        b=l3+1Njgv+sXitlgVLWLaxv6qNNUihn5DisikrppmG3z2QZWaKTAEOgG5XsG8+WpCem
         iTT6r79vs+4EBolb/ydSVZINEwVch21fSpfx2fhI9T+3a8Fk96zMU/XGnJMdKlj/XOo1
         JBKNq53sP9F8kw0wOCZqsD0r4wIZMJI5qvgfHh106AftaISbaKMG8IsK0OzQsYADwrL6
         aZB8zp0xSNk5VlisvDKxVxLjp7qzqO2oeOoS2APeDefN+jc3g1LN5CMHzExR5ZRYvdbR
         u+Ognd2QkvfqXrpmfU6TL73Ws/EjQRUY/Zb8o/mOVhd3sUj1MJYeOgLh5Kjsu0gMA2Cg
         JLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=7qOxMsur1Y9IR3+rVs5OD7ie6BcPv4lIkDGk+dh2Fyo=;
        b=Dg23EjE+z8snCOsJyN6EB7igSSws1423xDUPKN1YcezyhmLgmyE7uP9Wd+gbm72JVk
         n39laZ7Qh1tQpTsUeCEzpM+87Qa12ga3A+ZguFkA+TMYrXIMEZy5StKGNbO1pfVAU4Qb
         24tx7pwuMGA402OlbJ7lmhq/Gn5PVvd7ZbgHsoIMOZTQX1J7qt5vwiaCsRBmgfVFPitu
         kkVv5nZ+x3Why4oqYfSqI8Qd6sQivm2jINhW2SjJgcyovdRosiBKb+CssymQqvyHyr95
         xHHkXF+NmvIZ8vW105WhMUS2YPs4ebPq+hvYjWPMYIHSg9Qq+6tko9px198UjPt4Jr4W
         8NfA==
X-Gm-Message-State: AOAM533YsNXuDYPbanjnMuc0gqHStzwgiOOiyM61mM22EXro897mWTC2
        xo0p2CJxg5wGJTGGTprQ/RM=
X-Google-Smtp-Source: ABdhPJzEBSPvQAD6xfQ4iZQtFqet2cGR8KgOBNH4JjEJfZNRhNv/cDRqvUOH6NYjnZsPqmj8nf5Trg==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr709391ede.39.1624279800312;
        Mon, 21 Jun 2021 05:50:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n11sm4867910ejg.43.2021.06.21.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 05:49:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git List <git@vger.kernel.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: allow to run from subdirectories
Date:   Mon, 21 Jun 2021 14:45:49 +0200
References: <20210620213836.10771-1-rhi@pengutronix.de>
 <877dio3vg5.fsf@evledraar.gmail.com>
 <YM/yqPsRutV2mUbb@camp.crustytoothpaste.net>
 <CAPig+cQa3JC-YkGeB-NDy-iP=Mv8BRL6jyXTGXzaqpTLcxj8+w@mail.gmail.com>
 <20210621093310.eqt3ajic64pgag44@pengutronix.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210621093310.eqt3ajic64pgag44@pengutronix.de>
Message-ID: <87sg1b2xhl.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Roland Hieber wrote:

> On Sun, Jun 20, 2021 at 10:10:10PM -0400, Eric Sunshine wrote:
>> On Sun, Jun 20, 2021 at 10:00 PM brian m. carlson
>> <sandals@crustytoothpaste.net> wrote:
>> > On 2021-06-21 at 00:35:49, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrot=
e:
>> > > On Sun, Jun 20 2021, Roland Hieber wrote:
>> > > > Currently, calling 'git bisect' from a directory other than the top
>> > > > level of a repository only comes up with an error message:
>> > > >
>> > > >     You need to run this command from the toplevel of the working =
tree.
>> > >
>> > > How does this affect out-of-tree scripts that will be run with "git
>> > > bisect run", is the cwd set to the root as they now might expect git=
 to
>> > > check, or whatever subdirectory you ran the "run" from?
>> >
>> > As for the idea itself, I think it's a good one assuming everything
>> > continues to work.  It will certainly be more convenient for a lot of
>> > people.
>>=20
>> There have been multiple patches sent to the project over the years
>> with the same purpose. One problem, I believe, which has never been
>> fully addressed is what happens when the subdirectory from which
>> git-bisect is run gets deleted as part of the bisection.
>>=20
>> Here are a couple recent threads triggered by previous such patches
>> (but there are probably several more):
>>=20
>> https://lore.kernel.org/git/pull.765.git.1603271344522.gitgitgadget@gmai=
l.com/
>> https://lore.kernel.org/git/pull.736.git.git.1584868547682.gitgitgadget@=
gmail.com/
>
> Ah, thanks for explaining the problem. Would a patch that adds a short
> explanatory comment in git-bisect.sh on the matter help to prevent
> people sending such patches?

Having skimmed the linked discussions I don't think the consensus is
that this shouldn't exist, but that someone who wants it should do some
research on the relevant edge cases, come up with test cases for them,
discuss the trade-offs in a commit message etc.

I for one would welcome such a feature, it's often annoyed me, it should
just work like "rebase exec" in that a "run" script should cd to the
root, but (as discussed in the linked threads) I don't see why we'd
prevent it any more than several other commands that already have this
edge case, but don't explicitly prevent this.
