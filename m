Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8303AC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A75E60FE6
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhFUUb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhFUUbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:31:24 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5DAC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:29:09 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id n99-20020a9d206c0000b029045d4f996e62so267755ota.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=owE5IcGhbPLTj8UQse0tj2OC/PgH6HwK1vg13xHXT/I=;
        b=sS4eWyTbbhfwnUUVjmskEhOQyPnOOekq+Wl5HuIXg8SKk17pQ0GSpY4dXcY07Sa4P4
         akKpr9FJTf4Fn9+zHLGn+Ki/jzwibHGUYz6SG7osi2OtvZsEDC9s90/6JaAlXsR53zXZ
         sVJuba1JoVNRTey1HtwLJb4vrJKe4rzH44VMxkLhzQcnl98RRRFLhhhPwGIE2y5sc/pd
         nRrCUf7mj7mustfIm90ITQLzBTCgF+2L2+6iS8afGdFFW2vFC6D8iQ1hqmtvkoBQqsJ7
         aI781GNMiUc6b2Yc8a+JIpcmnWCGZWb/ZwzlTF57Pg0Uk5ydZudDVHdhVpMtpV9OU5Jy
         B9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=owE5IcGhbPLTj8UQse0tj2OC/PgH6HwK1vg13xHXT/I=;
        b=qBhc8B9rq8NANORrGlaJMTAakivvIFA+CoUFCN7T6JT9oaMo/x7zUlIhBYn8Ucm+0W
         W3WtSG29++hQH2FS2NORpHe9kq3yGz+48OqDw/gvYEg5Lcjozc04xu+c1j4W2pEcD9Kc
         t/UXvQAPlp5fMxGSOSnFNQtQiX8TUCZKcb/Jv4ayGCyAv/EQSDLSksIsQI83uPG7yrbK
         23O/2J27UyRn05cee2KRhAhkxg1N5bKOb6yn6lAPUWh6NgGPx5JIQlQhlzdmblbGGxsK
         lVWjbc2c/+ymdbRmRIyIYWRXwlAE8hSzNG+b+uuvEazf1ZnyTcBQKoohiqtgcCKDVCUc
         it1A==
X-Gm-Message-State: AOAM533E0HVI8GrazzvH5W/jHbS3eG2mwKHBq2U6hbZ/x8gTvwWhtw9O
        nPN6UX9bbc/I51JOD7cr2/g19OqTHkUtS9e4BzM=
X-Google-Smtp-Source: ABdhPJzbMKM9KM6sLZiKOkTJkF6JkYPYgXDzo+o7CAEYKVZEUFE5xT/APXuPpkDdanEmDIsr/tEEZkC8o8GhCdVwdSs=
X-Received: by 2002:a9d:1a8:: with SMTP id e37mr245261ote.316.1624307347358;
 Mon, 21 Jun 2021 13:29:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200512214420.36329-1-emilyshaffer@google.com>
 <871r8w3sxu.fsf@evledraar.gmail.com> <CABPp-BFDfCqpDGZ1D=U6V5--KkcuCJON5-CcX-PVLcvH4pc5cg@mail.gmail.com>
 <87pmwf2rq5.fsf@evledraar.gmail.com>
In-Reply-To: <87pmwf2rq5.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 21 Jun 2021 13:28:56 -0700
Message-ID: <CABPp-BEe9r5vRYouhRRXmbWMJc7X+FqHC7CbzLpq-ALPRcc3fQ@mail.gmail.com>
Subject: Re: [PATCH] trace2: log progress time and throughput
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 21, 2021 at 7:54 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Jun 21 2021, Elijah Newren wrote:
>
> > On Sun, Jun 20, 2021 at 6:32 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Tue, May 12 2020, Emily Shaffer wrote:
> >>
> >> [Replying to a change long-since merged into git.git's "master"]
> >>
> >> > Rather than teaching only one operation, like 'git fetch', how to wr=
ite
> >> > down throughput to traces, we can learn about a wide range of user
> >> > operations that may seem slow by adding tooling to the progress libr=
ary
> >> > itself. Operations which display progress are likely to be slow-runn=
ing
> >> > and the kind of thing we want to monitor for performance anyways. By
> >> > showing object counts and data transfer size, we should be able to
> >> > make some derived measurements to ensure operations are scaling the =
way
> >> > we expect.
> >>
> >> Did you end up using this data for anything?
> >
> > I know you were asking Emily, but independently, I found it useful
> > while doing merge-ort and diffcore-rename optimizations.  I thought it
> > was a clever idea for quickly adding more measurement regions easily,
> > and wished I had thought of it myself earlier.
>
> Indeed, the data's useful. I'm just wondering about the key name.
>
> I saw after I sent this that this was brought up when the patch was
> discussed, and the name was just left in there:
>
> https://lore.kernel.org/git/8f159f13-ed61-61ea-8e9a-c1ffbc5fddb3@gmail.co=
m/

Yeah, I didn't comment on the key name because the name wasn't
important for my purposes: I didn't have scripts or anything looking
at the logs, just me reading them.

"total_objects" worked just fine (and was slightly more precise
wording) for my case, but since this code is used in lots of areas,
I'd be totally fine to see it switched to "total".
