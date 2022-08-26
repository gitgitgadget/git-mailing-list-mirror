Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFB5ECAAD4
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 13:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiHZNI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 09:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiHZNI5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 09:08:57 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8EE1F2DA
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 06:08:56 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-33dce2d4bc8so34561257b3.4
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 06:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=D475rKfFH8E3y3RAvtqCmQRxm5haDx5W2ehgKDfeZrs=;
        b=Yhxyb2t1IiuVWnS/hrqcO+BZ+gwZ1Jlj1MOwSopy+Wsko9g/w2rlkPVq2gar7gY5QD
         Bwnrnl1t3GikFFWs0nXHy+arjeOG+jjw/N5aBBjRXGTlARYWh/3TAuZf/UaAXGe408Iv
         Qlod24ZvmxouWVdv7lLmICkz+ygYOlHdWeoqdNLCQfP33cidcWPtOtZrj4GUYL3/kSlM
         wN16DhDbJjrOemWTzOJ+vy1P9kWFbvnC0C1nFXdyaX6u828dV1tRPXFpQsuXn1AMR4Dp
         tlURt/qREIvNTHfDgJn4LqvACm136DhUT+bXLRXMsmxrc7AMBpvOT6VStA0Z49qWQRnq
         aCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=D475rKfFH8E3y3RAvtqCmQRxm5haDx5W2ehgKDfeZrs=;
        b=2yD1qnwZrhl6iCD6A2xgO5GAmU9dH7HIxE4FkbWAv/PQX9xJZE3uTnk6i4oOb7gsBQ
         RbvAXwFY1OZ/iWwEwq7mWiQBSAnAWGVBJN0O5b7DIdznOdu8Ma7Sx2m1Vf74VJhpuwlg
         hhLsc8pyHsWdymb9PP4yNJ8yXn8XkfmDAn8HAKVtFVvaZD8O8AeHn12XCOC02KAy4ExG
         RL1WPq8AXonYZcx7aGNcTflbQgsSHwoxtmmEW0ts2p62nH+J9RNhn5b/j3wkEUaYcl+9
         JPW5Kx3x88lCcTJ+lwWAAxvOSitKLt7C2+m7yySn4yH/aBBJhb0jHFkyyXke4YlS0dCE
         IqCw==
X-Gm-Message-State: ACgBeo3Pvm+JmyxUSjo4Gj3R+hT2wxzbz+wX9xcOULbVM3ontB2ytuOB
        RrqxMmBXpIw+tzesNbdnok50yM7OZiOQu+xSXYM=
X-Google-Smtp-Source: AA6agR6snUhBS23xkojmQmsjomZkAg9BRYNpHk++BNIZkWCTyO1ImDF9TP0fA4FpKIpYeeV5H837h8diAhtW08FdYm8=
X-Received: by 2002:a81:1608:0:b0:334:7c07:e72d with SMTP id
 8-20020a811608000000b003347c07e72dmr8564714yww.265.1661519335209; Fri, 26 Aug
 2022 06:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net> <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
 <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com> <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
 <YwCtkwjWdJVHHZV0@coredump.intra.peff.net> <220825.86edx44lzh.gmgdl@evledraar.gmail.com>
 <Ywhx6LLe6YcS/2xf@coredump.intra.peff.net>
In-Reply-To: <Ywhx6LLe6YcS/2xf@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
Date:   Fri, 26 Aug 2022 14:08:44 +0100
Message-ID: <CAPoeCOb8=6_7RCw6g-B8m_PsQkvYq6QDsk6Vu1WGiiZFG47K1w@mail.gmail.com>
Subject: Re: [PATCH 0/11] annotating unused function parameters
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff

On Fri, 26 Aug 2022 at 08:33, Jeff King <peff@peff.net> wrote:
>
> On Thu, Aug 25, 2022 at 01:00:19PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
> > > One, it feels like we're abusing the deprecated attribute here. The
> >
> > Definitely, but structurally it seems like a better pick. I.e. isn't th=
e
> > only problem with it the "deprecated" and its interaction with
> > -Wno-deprecated.
> > This is mildly annoying, but I don't really think it's a practical
> > issue. We're talking about running this without
> > -Wno-deprecated-declarations in CI, and by default.
> >
> > For unused parameters it's enough that we're catching them somewhere, o=
r
> > in common compilation settings, we don't need to catch them
> > *everywhere*, do we?
>
> No, but the farther away you go from the edit-compile-run cycle, the
> more painful warnings become. Catching them immediately and fully has
> real value, as it means the cost of correcting them is lower. So all
> things being equal, I think we should prefer universal solutions when
> they're available (and for example compiler errors over say, coccinelle
> or other analysis tools).

That's a good point, one of the nice things about your macro was that
all compilers detected when UNUSED() parameters were in fact used. In
comparison abusing the deprecated attribute is uglier and less
practical.

> (And yes, I know all things sadly aren't equal; see below...)

It might be worth reporting this issue on the coccinelle mailing list
to see if anyone is interested in fixing it. If it gets fixed we're
left with the problem of having  to build it for our ci but that
shouldn't be insurmountable.

Best Wishes

Phillip

> > IOW is anyone writing patches where they're testing with
> > -Wno-deprecated-declarations *and* adding unused parameters *and* won't
> > test without -Wno-deprecated-declarations before submitting them, *and*
> > nobody else will catch it?
>
> Probably not. I don't actually build with -Wno-deprecated-declarations
> routinely. But my fear is that some platform may be stuck there for a
> while (because an overzealous libc marks something). But that's kind of
> hypothetical, so we may have to just accept it and cross that bridge if
> we come to it.
>
> > > And finally, I actually prefer the parentheses of:
> > >
> > >   static int register_ref(const char *refname, const struct object_id=
 *oid,
> > >                       int UNUSED(flags), void *UNUSED(cb_data))
> >
> > ...and now to the real reason for the follow-up. You/Junio were CC'd,
> > but this is breaking coccinelle, see:
> > https://lore.kernel.org/git/220825.86ilmg4mil.gmgdl@evledraar.gmail.com=
/
>
> Ugh. Yeah, that is really unfortunate. I much prefer the parenthesized
> syntax, but if we can't find a way to unconfuse third-party parsing,
> then switching is probably the least-bad solution.
>
> -Peff
