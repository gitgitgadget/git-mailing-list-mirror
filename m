Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04A6C433B4
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:33:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823B46101D
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbhDZReQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhDZReK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 13:34:10 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4592AC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:33:27 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id s2so17805478uap.1
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 10:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fVGzZWzYh5XoQuZPOGr2p4QDs2Z1muZsX+M3lBpKyZs=;
        b=b4Ba+aEo4gSy5j7iZ0lk/Mhbinx3nF0bCKlQqtAfUmrHUudrdPLViw60dTji5H/Gox
         hG3S1/SdwQoRFri/l7QjlKwsVNZOL0sso5cBX5qm1Ud4s5h07tvsRoqT47WGhRKHO3rM
         J2aLa9xRZzIEg9f7fhFsT6KSI0nJ8eZ/lmpAq2SNxzllEF5Fk24UOjfXJsSIDcK1gfN3
         5ENb/ikczTgV3d0p4fQQEEFtMYBqFW9Jl4tmF4FRz0PRPJlet0boJDe5jZqrEIEhcF4A
         gKRqwveYV4AXAnxgTk9vo4L9Xdw/9Wpvd1h0s+odc4ZLQ8npnNiOFY+6G127KezJFVBm
         xUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fVGzZWzYh5XoQuZPOGr2p4QDs2Z1muZsX+M3lBpKyZs=;
        b=HfCZ16h7ULSGTcQ4oklxxcmkuE2jCLgtDkLazfayKGrvyQ9X10dxn1nKlFAVcx5wkG
         5SMXxjmArNLBw1wv/hdyWfraXUuo9fYXVfB0tXTET7SXZYIYjEcPywitYy+0eX2wUNV6
         6k/t6TS8XY23Z8aOsUN5jZm21f/9HCY8xrFodYnoXjUN/4SS35oVZ8pYA8GO/fHYYt7n
         jrVaKmqXsJfq4kMXMwGoOsIjYSkiC6K0g8wGefCDW3NqwwuVG8B1wu48qmRGi1y1jnmX
         u1tECv4tQK7F0f3gZicziF1jhh2kgm7onMhtCvAfbJmUhXSzg0Rll8MF3sL/Ac2RgHjw
         t8IQ==
X-Gm-Message-State: AOAM530x97CkVxLHm3TflydX4GzwzA10zQbwEm14LqKm9Pf+b9XdpeeO
        bxlxbyIRc2AtJammGR4f3I/EiNF28Lbul1u45p6XMw==
X-Google-Smtp-Source: ABdhPJy+Ed41mrflJCtDE825o+vEYh3m3ziCyLRygzJ3KqpRq/uqIhd2Vta+ozpwJ28DyPm+/a+GhzvLhgXsQOxTLLU=
X-Received: by 2002:ab0:2b01:: with SMTP id e1mr13410779uar.85.1619458406250;
 Mon, 26 Apr 2021 10:33:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAFQ2z_Ps3YxycA+NJ9VKt_PEXb+m83JdNB7ujzWw1fTPKyZ=fg@mail.gmail.com>
 <87im4f3l62.fsf@evledraar.gmail.com> <xmqqim4fzier.fsf@gitster.g>
 <CAFQ2z_OGv3qNp9jaeuMij5gqv1MoOeb73zH9mOvikLs8dWvmmg@mail.gmail.com> <YILUs3T4oM78ZcW2@coredump.intra.peff.net>
In-Reply-To: <YILUs3T4oM78ZcW2@coredump.intra.peff.net>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 26 Apr 2021 19:33:14 +0200
Message-ID: <CAFQ2z_OEB_jnL-G=GfypMiLLjE3gwp07ZMo3uF5aGkp3o6Yb9A@mail.gmail.com>
Subject: Re: reflog existence & reftable
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 4:07 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Apr 23, 2021 at 11:20:52AM +0200, Han-Wen Nienhuys wrote:
>
> > On Wed, Apr 21, 2021 at 6:55 PM Junio C Hamano <gitster@pobox.com> wrot=
e:

> > >  (2) we could declare that there is no way to create an empty reflog
> > >      supported across ref backends, and make the tests that rely on
> > >      the "feature" conditional on REF_FILES prerequisite.
> > >
> > > I have no strong preference.  In the early days I found the ability
> > > to limit which branches get logged convenient, so if reftable
> > > backend can learn the similar trick, we would want to go route (1)
> > > (the convenience largely came from the fact that there was no need
> > > to add one configuration item per branch, so I do not think we would
> > > want to bother with branch.<name>.reflog=3Dbool configuration---that
> > > won't be an easy-to-use substitute).  On the other hand, logs are
> > > useful, and dormant logs are not costing anything (other than holding
> > > onto stale objects we may no longer want), so it could be that it
> > > may not be as convenient as it used to be to be able to turn logs on
> > > only on selected refs, in which case approach (2) is fine.
> >
> > Exactly, these are the two options I outlined in my original message.
> > Both can be made to work. I slightly prefer 2 (empty reflogs don't
> > exist, and make logging a global switch), because it is simpler to
> > understand and document. The divergence with the files backend itself
> > is extra complexity, though. Maybe we could deprecate the behavior and
> > always write reflogs in the  files backend too.
>
> Yeah, I like (2) as well. This "write a reflog if it always exists"
> behavior has always seemed hacky, and like a leftover from early days
> when we didn't just turn reflogs on by default. Given that it was
> documented as "touch the file", I don't see any need to pretend that it
> makes any sense at all in a reftables world.

Thanks. Does that count as consensus? Junio?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
