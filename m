Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C21C001B0
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 09:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjGXJCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjGXJCY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 05:02:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B70310E6
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 02:02:02 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fdd515cebcso5983391e87.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189320; x=1690794120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14FeRDRF9mU0hYv8MGjhSIvJDLWNwHK7AId1aAXe6YE=;
        b=gen+4BgBnVDHVib1+upPCfJLQQmiQsD4aMGpMCXB7KQ1UyWRX+HlIMlrEHsGz+3tAJ
         46YT8XNuivY+2lweQzkxxoYsxCN1KclHB+svLuP1ZTK9O1LmsaCHnd/nwBm92pdnoMW5
         mxhJoF6Ws7X3SI7g58CpjezZAE3PfRSaiWxsyzuvV+aUJocbbep7oaOVbw9k4NB3jWBW
         jnFM8WmOXsdYgkZ/PiKDciOMK8EgGoFMqBryVCqgEHQwO9Mrm82srGEkPQUCItVn5fCW
         WnaTl6pVyK6lHZzJ5XF+gk5Z8ZT3w7dq9AKUy9OwwZUzd3P3v9LW+d2gcqG8/FDxkbWP
         MEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189320; x=1690794120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14FeRDRF9mU0hYv8MGjhSIvJDLWNwHK7AId1aAXe6YE=;
        b=U5u0jZ9rYsqNKIHovc9VcgvfRUPbaDAKecziUKk56Ca2C0d99P6FvLVvNIQxQrjjml
         vnV6CebgFVR6KKtkZpiThESq7Q10MBYw+GlOmgi+JgCd6vl0v6uNbKNvybbCXWztG6EH
         v3ytYYh9x9OJhcCE52wwzfZVWHbXTv2cOkm249CjMXtsVWNhUFG827kgIJwS4NMWqBb1
         W3VygBXClb3FNvE+0Fam1P+tJNC34rjTKKQ/uj/HdgdQIaybwsxn4/sEgF1nzE1I0T8i
         D5O7GO7PeGRhJEzAIuKVjoX3Sw16HopFl8Qa7c5EeyflakMTSM2sbr+dbcSChbrIDl6H
         VMzA==
X-Gm-Message-State: ABy/qLZQeLdVtmRZ3zcfcLkpiB3ZiqdgUz/LR862eWlClNlfxIZ+PS6b
        HS1AQMhD5rKgrdJa8w58TXZE2iFacWHltDK7SMo=
X-Google-Smtp-Source: APBJJlHOYGP1Lbs08IMHcztH0TSC4GLk8i9m7ovFittgUvSDWNXQYV+x37xEnxuGZrUoHll06o+/PvYVHmPF6CqtX+g=
X-Received: by 2002:a19:4f56:0:b0:4fd:f876:d86 with SMTP id
 a22-20020a194f56000000b004fdf8760d86mr1057204lfk.50.1690189320212; Mon, 24
 Jul 2023 02:02:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-6-christian.couder@gmail.com>
 <xmqqh6qi1byn.fsf@gitster.g>
In-Reply-To: <xmqqh6qi1byn.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Jul 2023 11:01:48 +0200
Message-ID: <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] repack: add `--filter=<filter-spec>` option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 5, 2023 at 7:53=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > This could be useful if, for example, some large blobs take a lot of
> > precious space on fast storage while they are rarely accessed. It could
> > make sense to move them into a separate cheaper, though slower, storage=
.
> >
> > In other use cases it might make sense to put all the blobs into
> > separate storage.
>
> Minor nit.  Aren't the above two the same use case?

In the first case only some large blobs are moved to slower storage
and in the other case all the blobs are moved to slower storage. So
yeah the use cases are very similar. Not sure if and how I can improve
the above wording though.

> > This is done by running two `git pack-objects` commands. The first one
> > is run with `--filter=3D<filter-spec>`, using the specified filter. It
> > packs objects while omitting the objects specified by the filter.
> > Then another `git pack-objects` command is launched using
> > `--stdin-packs`. We pass it all the previously existing packs into its
> > stdin, so that it will pack all the objects in the previously existing
> > packs. But we also pass into its stdin, the pack created by the previou=
s
> > `git pack-objects --filter=3D<filter-spec>` command as well as the kept
> > packs, all prefixed with '^', so that the objects in these packs will b=
e
> > omitted from the resulting pack.
>
> When I started reading the paragraph, the first question that came
> to my mind was if these two pack-objects processes can and should be
> run in parallel, which is answered in the part near the end of the
> paragraph.  It may be a good idea to start the paragraph with "by
> running `git pack-objects` command twice in a row" or something to
> make it clear that one should (and cannot be) run before the other
> completes.

Ok, in version 3 that I just sent, that paragraph starts with:

"
   This is done by running `git pack-objects` twice in a row. The first
   command is run with `--filter=3D<filter-spec>`, using the specified
   filter.
"

> In fact, isn't the call site of write_filtered_pack() in this patch
> a bit too early?  The subprocess that runs with "--stdin-packs" is
> started and told about the names of the pack we are going to create,
> and it does not start processing until it reads everything (i.e. we
> run fclose(in) in the write_filtered_pack() function), but the loop
> over "names" string list in the caller that moves the tempfiles to
> their final filenames comes after the call to close_object_store()
> we see in the post context of the call to write_filtered_pack() that
> is new in this patch.

I think it can work if the call to write_filtered_pack() is either
before the call to close_object_store() or after it. It would just use
the tempfiles with their temporary name in the first case and with
their final name in the second case.

write_filtered_pack() is very similar to write_cruft_pack() which is
called before the call to close_object_store(), so I prefer to keep it
before that call too, if possible, for consistency.

> The "--stdin-packs" one is told to exclude objects that appear in
> these packs, so if the main process is a bit slow to finalize the
> packfiles it created (and told the "--stdin-packs" process about),
> it will not lead to repository corruption---just some objects are
> included in the packfiles "--stdin-packs" one creates even though
> they do not have to.  So it does not sound like a huge problem to
> me, but still it somehow looks wrong.  Am I misreading the code?

I would have thought that as finish_pack_objects_cmd() calls
finish_command() the first pack-objects command (which is called
without --stdout) should be completely finished and the packfiles
fully created when write_filtered_pack() (or write_cruft_pack()) is
called, even if the object store is not closed, but you might be
right.

Perhaps this could be dealt with separately though, as I think we
might want to fix write_cruft_pack() first then.
