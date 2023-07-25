Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B393C001DF
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 15:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbjGYPXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 11:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjGYPXC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 11:23:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38D4187
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 08:23:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5221e2e69bdso4445462a12.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 08:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690298579; x=1690903379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F9Uzif5Z4HJdnMpWLKYr93+nHSJjpWo/TpafPbX3xHM=;
        b=nmxMdCbOly/EaEelxpVHMuxXOV+o7wwq8pw2pme2QbezM5n8loyNQNWnXkf6K/PzXN
         GdhOQT3Cy47E2rgDOzMGyzomkniR9aFgrNaYbp5UeY7dYCjmiuTIXgEbf/7sTP1fE3Xu
         VyifsoBJfWOR5h4/vthPTehOcQkuIsHFEKUP5TwA78AN4hfmqfnj1QkgRg6rZz/t99z1
         fhl+IUT/dQmZOP5P9wXmbUDF1uA6BdRj1AJmv3JrGOCf+/gZpvbfe78jdUVnJbcb46io
         Uu8ynFyx7T89EMRwPHT38YtdwR05zvoqOjVgz13L0IYBGhv8IVb+oa2QYjuN4t7qAyRb
         I3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690298579; x=1690903379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F9Uzif5Z4HJdnMpWLKYr93+nHSJjpWo/TpafPbX3xHM=;
        b=GEYc5OnKsyngH4s/1ZPUBduHUGnXSYoSL4aU0+gRTmvsGx4dpBoC6OP2REMd+ijq+Z
         k/8ZiLYW3m6EyqfaDFH5pGIJn3jn3lxAxq4Hw5DhjtfJzji/MinUBAYH1XI+FAUsf5BB
         jv6jua0jtJe/9tDSC0zYkE8IvigrQAE/Th1WvmjCA/IqvMzj0N78icD3/hRa3Q2mLP0A
         CVH/Ylo4zzNPwFHdb/WKgiq874c3+zDk+jiBO2A/xjpU6MmaKEnBnA9tT+2XDYqj7ubT
         6OJklXwg9c6MPf1znhkHwdQm/6SRLdvN4ZF/AyiqAkMjwQ8YoiKCyH7ouZ20Xb5SHWbT
         Sgjw==
X-Gm-Message-State: ABy/qLaDZw1LKNY7Yw8QUEFAPdWiaKTl+saTVmtPUkk2Lvvx8sEs+gCm
        3HdvK1crSeGK7GIEpTmlOmf79Sj0971uUuyoSm0=
X-Google-Smtp-Source: APBJJlH8cqHewO1KLdd3tLHmo+vjGCotK+PbgMet4ikv5vJucvXKcy1HZ7o9WplEWzfIMA4o4S1QBHBhg0LUBLtgdrI=
X-Received: by 2002:aa7:d813:0:b0:522:5834:d2de with SMTP id
 v19-20020aa7d813000000b005225834d2demr289304edq.8.1690298579110; Tue, 25 Jul
 2023 08:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-6-christian.couder@gmail.com>
 <xmqqh6qi1byn.fsf@gitster.g> <CAP8UFD0aa+EZQ2Q=C2WjWrNL9desg-KLLjOKS8BUBR4DS1ytsQ@mail.gmail.com>
 <xmqqila9p3j8.fsf@gitster.g>
In-Reply-To: <xmqqila9p3j8.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 25 Jul 2023 17:22:46 +0200
Message-ID: <CAP8UFD3b6gCog5P7WKzTuPQV2Lhf51=xO7ys+W7o0pGewJMcFg@mail.gmail.com>
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

On Mon, Jul 24, 2023 at 8:28=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> Minor nit.  Aren't the above two the same use case?
> >
> > In the first case only some large blobs are moved to slower storage
> > and in the other case all the blobs are moved to slower storage. So
> > yeah the use cases are very similar. Not sure if and how I can improve
> > the above wording though.
>
> Just by removing one or the other, it would be quite improved, no?
> Moving away some blobs could move away all or just a selected
> subset.

Ok, I have done that in my current version.

> > I think it can work if the call to write_filtered_pack() is either
> > before the call to close_object_store() or after it. It would just use
> > the tempfiles with their temporary name in the first case and with
> > their final name in the second case.
> >
> > write_filtered_pack() is very similar to write_cruft_pack() which is
> > called before the call to close_object_store(), so I prefer to keep it
> > before that call too, if possible, for consistency.
>
> As long as the set-up is not racy, either would be OK, as the names
> are not recorded in the end result.
>
> If the upstream tells the downstream the temporary's name and then
> finializes the temporary to the final name before the downstream
> reacts to the input,

It doesn't seem to me that it's what happens.

We have the following order:

  - finish_pack_objects_cmd() is called for the first pack-objects
process. It populates the 'names' string_list with the temporary name
of the packfile it generated (which doesn't contain the filtered out
objects) and calls finish_command() to finish the first pack-objects
process. So as far as I understand nothing can be written anymore to
the packfile when finish_pack_objects_cmd() returns.

  - write_filtered_pack() is called. It starts the second pack-objects
process and passes it the temporary name of the packfile that was just
written, taking it from the 'names' string_list. It then calls
finish_pack_objects_cmd() for the second process which populates the
'names' string_list with the temporary name of the packfile created by
the second process and finishes the second process. So nothing can
then be written in the second packfile anymore.

  - close_object_store() is called which renames the packfiles from
the 'names' string_list giving them their final name.

So the final names are given only once both processes are finished and
both packfiles have been fully written.

> however, then by the time downstream starts
> working on the file, the file may not exist under its original,
> temporary name, and that kind of race was what I was worried about.
>
> > Perhaps this could be dealt with separately though, as I think we
> > might want to fix write_cruft_pack() first then.
>
> Sorry, I am not understanding this quite well.  Do you mean we
> should add one more known-to-be-racy-and-incorrect codepath because
> there is already a codepath that needs to be fixed anyway?

No.

> If write_cruft_pack() has a similar issue, then yeah, let's fix that
> first (testing might be tricky for any racy bugs).  And let's use
> the same technique as used to fix it in this series, too, so that we
> do not reintroduce a similar bug due to racy setup.

Yeah, that's what I mean.

I am not sure the race actually exists though. I have tried to explain
why it seems to me that things look correct, but from previous
experience I know that you are very often right, and I might have
missed something.

Thanks.
