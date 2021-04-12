Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88CFC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930386128E
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 13:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237550AbhDLNQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237438AbhDLNQa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 09:16:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E7BC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:16:11 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u17so20224546ejk.2
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 06:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+WKClVrg6R1NPvgtsVRb1RuIAUR+VrDWCn9wmnZ8HhM=;
        b=GEV7h46BHU6Wx+oVV5XNoGE2J6j+xX8edDwbp7wYCfCO9VBLCas5FSuIf4jE5S0706
         izM7i1n4IG3oxyBh5lGoJQ5ei4zxYOyxgInK5jV2ADtVbg2A1GrpOM08AuIaUSy+p8Xo
         mJBq9KKvrj0nZVnjUTagpboN3jp5eQ/r8uH4iC0L29IS89r9Ti0iSqtS1TJV/7nXjM/t
         Uxz59jPpfB1GqmtOSmeayTf6kyzQIJH3Fl4D77aVj87qJAopBZsOnoBPNzKSr+Qv3bfx
         SlbAkVhFXKInwCK5Pkp3hYn6TsYdT6OuE8CNzICw7wnzZW28taCrKbFQYAg2TC4IUbSS
         Q3Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=+WKClVrg6R1NPvgtsVRb1RuIAUR+VrDWCn9wmnZ8HhM=;
        b=nUjJT3HbuAP6Ikuf26bbD/3VW4XLRiwgTt3BE2JJUxUBYdFyqD+b7S73JSVUPatJar
         RXf3bCpBXJLwPzDJFu8zU+u6f1kDKIRCGY2BpHt8v71LsYJFjIdCjQ0g/wDQB60UszPE
         2Te1WexBAiGjBo8X38ydZIT96Ah3gyQ1odpb/vUdWsvQjPdP3SKbKb12Y50DUJAcbYY5
         9GhFPPQt7ll1zkA17OBB5bToNsE9pn4DqyqQlBEy71Y/YwwytxG81CYwdXZa7A2fYlOP
         O8UgM5J90RUoFQUMmyuVAD0bwytRigFRqJcrdwPFppxp5mYBngf0Ko7Owr3gSxG3pB8i
         9dTQ==
X-Gm-Message-State: AOAM530sNf/tq0K9rkbhCkBODajtjB67C5XGBWBDX/S1XloGKMLJd8px
        mB1crrZ2gzXO+gPXfd9H6XWuGxrXQiQnMw==
X-Google-Smtp-Source: ABdhPJy9tbjO1UNrWAjUSL/nIxD8GZVMFxlNNi3RdyNLhm/+mnRxdN0M8XrygqPB4Krct1OM7LTnsg==
X-Received: by 2002:a17:906:b1d9:: with SMTP id bv25mr26444448ejb.230.1618233370647;
        Mon, 12 Apr 2021 06:16:10 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c2sm6800929edr.57.2021.04.12.06.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 06:16:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Drew DeVault <sir@cmpwn.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] git-send-email: die on invalid smtp_encryption
References: <20210411125431.28971-1-sir@cmpwn.com>
 <20210411125431.28971-3-sir@cmpwn.com>
 <87blakgaxr.fsf@evledraar.gmail.com> <CAKYMAEJQOA3.25YK6UYSYFHXQ@taiga>
 <878s5ogagz.fsf@evledraar.gmail.com> <875z0sg8t9.fsf@evledraar.gmail.com>
 <CAKZTYI6U0WY.36DC3N1E4R7D2@taiga> <87zgy4egtp.fsf@evledraar.gmail.com>
 <CALQY92B6OVL.2Z59Y6W51BU4Y@taiga>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <CALQY92B6OVL.2Z59Y6W51BU4Y@taiga>
Date:   Mon, 12 Apr 2021 15:16:09 +0200
Message-ID: <87o8ejej8m.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Apr 12 2021, Drew DeVault wrote:

> On Sun Apr 11, 2021 at 3:56 PM EDT, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n wrote:
>> I suggest we don't compromise and just go with whatever you're OK with :)
>
> Well, if you're giving me an opportunity to not drag this out into a
> multi-phase rollout, then I'll take it :)

Just to be clear even if I was insisting on that I'm still just one guy
on the ML reviewing your patch.

As a first approximation the opinion of regular contributors counts for
more when the topic is some tricky interaction of code they wrote/are
familiar with.

In this case we're just discussing the general interaction of security,
optional switches, software versioning and how SMTP servers in the wild
work.

I'd think someone who e.g. needs to regularly deal with SMTP servers in
the wild would have a much better idea of those trade-offs than someone
(like me) who happens to have some existing patches in git.git to
git-send-email.perl.

> Another option is to forbid an unknown value (which is almost certainly
> (1) wrong and (2) causing users to unexpectedly use plaintext when they
> expected encryption), file a CVE, and pitch it as a security fix - then
> we can expect a reasonably quick rollout of the change to the ecosystem
> at large.

I think anyone would agree that in retrospect "unknown is plaintext" for
the "what encryption do you want" option is at best a something
approaching a shotgun to your foot of a UI pattern.

But I think it falls far short of a CVE. We *do* prominently document
it, a potential CVE would be if we had silent degration to plaintext
(well, in a mode whose inherent workings aren't to be vulnerable to that
attack, as STARTTLS is...).

FWIW since my upthread <87zgy4egtp.fsf@evledraar.gmail.com> I tried
sending mail through GMail's plain-text smtp gateway as an authenticated
user.

Testing with:

    nc smtp.gmail.com 25
    openssl s_client -connect smtp.gmail.com:465

It will emit a 530 if you try to AUTH in plain-text (telling you to use
STARTTLS), it will also only say "AUTH" in the EHLO response to the
latter.

And indeed Net::SMTP picks up on this, and doesn't even send your
user/password:
https://metacpan.org/release/libnet/source/lib/Net/SMTP.pm#L169

So this hypothetical degradation of the connection and sending auth over
plain-text I suggested in upthread #3 seems to mostly/entirely be a
non-issue as far as e.g. accidentally sending your password on some open
WiFi network goes due to a local misconfiguration.

As long as the SMTP server is functional enough to say it doesn't
support AUTH on plain-text you'll be OK. I'm assuming that these days
with the push for "SSL everywhere" most/all big providers/MTAs have
moved away from supporing plain-text auth by default.
