Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9C8C20305
	for <e@80x24.org>; Mon,  1 Apr 2019 16:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbfDAQlt (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 12:41:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:32861 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbfDAQlt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 12:41:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id q3so8885342edg.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oRYBwkKbTA/xoEuNWOOYTnSGmrM2PdQkDKbB9X/KvIo=;
        b=dmtkmZ3nL0zSWBLcrn50w7N7hMTX4UrcoXIMT91Y4kjs5d19/RFx1ixhvMskgb7Dxq
         Mh+FIomAlvmass8a3b3jH5UAX+K85DN4HPlc1/qvNiEbjYZb5PKn5e8DCa8H+c2+xS3U
         7ffFIn+8YO9i6PQYv+t7kd74P9Sm84QaG7B9U2rgCkZjcoNFBTZpYolGaAH1xCqeNe50
         5xKoTNTiCIXDtJd9ulOW3WV+T/kMozqUkQ1J6CeAHLd6cUmY7/s/IaUKvHZkYIdKcNOB
         Y351Z0C2es2IdU2B8xfSgfYC8GkYXcMEJ6NvJnC7j80M4k/a565vSNFx5vItN4YRd0rP
         ZVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oRYBwkKbTA/xoEuNWOOYTnSGmrM2PdQkDKbB9X/KvIo=;
        b=Zu4VV4Wuy/LCtwaIhTJDLJl8LIKbbkxgGvdyGOjzVC0OOj7QZi4H2DXoGVB3a2S0H5
         +zDMJ07Zo2wlYAlr097qHjAgr/+ZAsCG8qnt4P08/Dx6N8uiAr0viV/fD+Xk2zC/bf4+
         4dYLEHrnBGVYdy4V6RuKWnBdhVUSe/Az2EBuRO1fxbSBlGyvzwASKgcix0hyeL/QoS3c
         +Vbobp74zqQ0pb8eK9tuAlm/pAJiZL5GV0SGOVeyP9ufXrdnuuGYyyiHl9CMu9kkJLF+
         ygj3wsDFazIjQ8dYqk/vLo4xaj0UrcB+m3M6WoO5czr18GkYNPjZvES/HjCzXsZNqrDM
         wqIA==
X-Gm-Message-State: APjAAAWr0FJESOm+sTqLCOxlaU5BDhUQp5QCj7jBoxuyfvCygoexsnVs
        oVXt/DwvPlpMeM8VzJlequOvzIMrhWVk9LinQ0U=
X-Google-Smtp-Source: APXvYqySaJQZvtTHzztIeJyTobtG/EmwlQkmZDEEVIuY7Neh9AcnyHajC5ratmKy+HKEI1Lzzwtys0chwyQI1UPXaxg=
X-Received: by 2002:a50:9b50:: with SMTP id a16mr8838515edj.160.1554136907150;
 Mon, 01 Apr 2019 09:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190312132959.11764-1-chriscool@tuxfamily.org>
 <20190312132959.11764-3-chriscool@tuxfamily.org> <xmqqtvg7e7pn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvg7e7pn.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 1 Apr 2019 18:41:33 +0200
Message-ID: <CAP8UFD208vY=0tduwSipBHYTPJCrBtsME6GouZMiKrnXJ=0zAw@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] Add initial support for many promisor remotes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 5:09 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +struct promisor_remote *promisor_remote_new(const char *remote_name)
> > +{
>
> Shouldn't this be static?  The config callback that calls this
> function is inside this file.

Yeah, I made it static.

> > +     struct promisor_remote *o;
> > +
> > +     o = xcalloc(1, sizeof(*o));
> > +     o->remote_name = xstrdup(remote_name);
>
> A comment on this later...
>
> > +static struct promisor_remote *promisor_remote_look_up(const char *remote_name,
> > +                                                    struct promisor_remote **previous)
>
> In our codebase, this operation is far more often called "lookup",
> one word, according to "git grep -e look_up \*.h".

Ok, I changed it to "lookup".

> > +{
> > +     struct promisor_remote *o, *p;
> > +
> > +     for (p = NULL, o = promisors; o; p = o, o = o->next)
> > +             if (o->remote_name && !strcmp(o->remote_name, remote_name)) {
> > +                     if (previous)
> > +                             *previous = p;
>
> I think the "previous" thing is for the callers to learn what
> pointer points at the found entry, allowing e.g. an element to be
> inserted just before the found element.

Actually it's to make it easy to move the found element.

> If so, would it make more
> sense to use the more familiar pattern to use
>
>         *previous = &promisors;
>
> here?

If I do that I get an "error: assignment from incompatible pointer
type" as "*previous" is of type "struct promisor_remote *" while
"&promisors" is of type "struct promisor_remote **".

Maybe you mean:

         *previous = promisors;

but I fail to see how that would correctly pass the previous element
when the found one is not the first one.

> That would remove the need to switch on NULL-ness of previous
> in the caller.

In the only caller that passes a non NULL previous, we call
promisor_remote_move_to_tail() which does:

    if (previous)
        previous->next = o->next;
    else
        promisors = o->next ? o->next : o;

So yeah we check the NULL-ness of previous, but if previous has been
set to promisors, then previous->next = o->next will not set promisors
correctly.

I guess we are not here in the case were the familiar pattern you are
thinking about can be applied. Or is there an example, maybe in the
Git source code, that I could learn from?

Another possibility is to just use hashmap as you suggest below or
list.h. It might be a bit wasteful, but the code simplification might
be worth it.

> > diff --git a/promisor-remote.h b/promisor-remote.h
> > new file mode 100644
> > index 0000000000..bfbf7c0f21
> > --- /dev/null
> > +++ b/promisor-remote.h
> > @@ -0,0 +1,17 @@
> > +#ifndef PROMISOR_REMOTE_H
> > +#define PROMISOR_REMOTE_H
> > +
> > +/*
> > + * Promisor remote linked list
> > + * Its information come from remote.XXX config entries.
> > + */
> > +struct promisor_remote {
> > +     const char *remote_name;
> > +     struct promisor_remote *next;
> > +};
>
> Would it make the management of storage easier to make it
>
>         struct promisor_remote {
>                 struct promisor_remote *next;
>                 const char name[FLEX_ARRAY];
>         };
>
> that will allow allocation with
>
>         struct promisor_remote *r;
>         FLEX_ALLOC_STR(r, name, remote_name);

Ok to use a flex array. If we ever use arrays or hashmaps of promisor
remotes, we might have to go back to not using one.

> Or if the remote_name field must be a pointer, perhaps use
> FLEXPTR_ALLOC_STR().

[...]

> Can the name of promisor be any string?  If they end up getting used
> as part of a path on the filesystem, we'd need to worry about case
> sensitivity and UTF-8 normalization issues as well.

It looks like for regular remotes we only check if they start with /.
So I don't think we need to do more than that for promisor remotes. I
added the check.

> In a large enough project where multi-promisor makes sense, what is
> the expected number of promisors a repository would define?  10s?
> 1000s?  Would a linked list still make sense when deployed in the
> real world, or would we be forced to move to something like hashmap
> later?

I am ok to use hashmap to make it similar with regular remotes.

For now I don't expect large projects to use more than 10s promisors
though. They are defined in the config file and I don't think people
will be happy if they have to manage more than 10s promisors in their
config file. If people really start to use more than that, they are
likely to ask us for a new mechanism to manage them (and to
automatically have them configured from servers). So maybe we can
change that if/when we have to work on such mechanism.




> You do not have to have the answers to all these questions, and even
> the ones with concrete answers, you do not necessarily have to act
> on them right now (e.g. you may anticipate the eventual need to move
> to hashmap, but prototyping with linked list is perfectly fine;
> being aware of the possibility alone would force us to be careful to
> make sure that the implementation detail does not leak through too
> much and confined within _lookup(), _find(), etc. functions, and
> that awareness is good enough at this point).
>
> Thanks.
