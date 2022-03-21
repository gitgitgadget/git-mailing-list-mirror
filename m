Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79857C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345640AbiCUUit (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239014AbiCUUiq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:38:46 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670C413195E
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:37:20 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id pv16so32342796ejb.0
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=0yf3mhXmwR+kEr9dZzdNik+OQWjFlMHKNpIxQKzxPho=;
        b=P0Nh7BFx8jL59X+kqk463vA16jaaqrNv3jk0UL20lF2A3kA1vjSruua7Yw7/35I6z8
         EzLnC8UrmUGKh8Y+CXVqbtTLS8fFYve4kMRnUsKC0Bq87fwi6BxGXOsDxynYP+yeOKHV
         EAeYL98ZDYeuYipsWZxE76dy/4TcuKvnVldw8UdTo5DqrYTjwAS3asZ7mKb396YOqxy6
         0r+yKOLcabSeUt2lRoz+IUgfJyUNcPUd+cThNQrp7XJ0XnGHFPqinuyjDTOLSQMS1QeS
         l69vusfpGOhU1G+YIuSuYClxtgfrz6mdxOGGZGX3iLHwpb3M4YwwNNcQCctmtyIFQCCt
         BYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=0yf3mhXmwR+kEr9dZzdNik+OQWjFlMHKNpIxQKzxPho=;
        b=2h0Tu0HtQiT0FyD16+fk1G/N17aLY+78n48+SCQV9RA19S1OGjW8JiObzPPzy1YX+s
         f8uCx/ENt5RwWB3qIwIrqSu/8EdhEBFth/0clDpbwfMjBJ9f0LduLLAuYn+N8B6r5PTR
         gtoSY+k0Rdz48w7qGMkhtMZWFqg3WByzsCDaWG3jUl3WxCAnRy3lGzCypRt/qovm1rML
         BRgq6W/oDyrYwLD+1WLONMMmexymW3e6fSTCbVsXyRQLZCG9UQ+k0n4eaVV8PQqKFJSy
         MaY2ei1ZnVza3KeGxSN9TiReWPyAvDuSJnJJ7PNuovwA2zIO966SH4JEpUUOPyAF0EpY
         Errw==
X-Gm-Message-State: AOAM532G+pJIqnowJkmHMcfyZEeaSLirAm20gGbR/8ph0IWcs9Y6RKwa
        +ohGT1R8vsm6PmjD39yehYQJcYxPkdFhcw==
X-Google-Smtp-Source: ABdhPJzHFkgbA5E8cmi4PX7zxUrJ9DIBxPjNigECmtdTFSeMx7xu3dT4fZwCI5XBvzRkIG57J/xiJQ==
X-Received: by 2002:a17:907:1b27:b0:6d9:ceb6:7967 with SMTP id mp39-20020a1709071b2700b006d9ceb67967mr23247834ejc.186.1647895038444;
        Mon, 21 Mar 2022 13:37:18 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y27-20020a170906519b00b006dfaf4466ebsm4914778ejk.116.2022.03.21.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:37:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nWOmD-00058K-A1;
        Mon, 21 Mar 2022 21:37:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: [PATCH v2 2/7] core.fsyncmethod: batched disk flushes for
 loose-objects
Date:   Mon, 21 Mar 2022 21:18:04 +0100
References: <pull.1134.git.1647379859.gitgitgadget@gmail.com>
 <pull.1134.v2.git.1647760560.gitgitgadget@gmail.com>
 <3ed1dcd9b9ba9b34f26b3012eaba8da0269ee842.1647760560.git.gitgitgadget@gmail.com>
 <220321.861qyv9rjr.gmgdl@evledraar.gmail.com>
 <CANQDOdez2u4oTNeETM0zLQr7Xb6XXbEuoxXPhSqGuurwQWbkHA@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.10
In-reply-to: <CANQDOdez2u4oTNeETM0zLQr7Xb6XXbEuoxXPhSqGuurwQWbkHA@mail.gmail.com>
Message-ID: <220321.86zgljnite.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 21 2022, Neeraj Singh wrote:

[Don't have time for a full reply, sorry, just something quick]

> On Mon, Mar 21, 2022 at 9:52 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> [...]
>> So, my question is still why the temporary object dir migration part of
>> this is needed.
>>
>> We are writing N loose object files, and we write those to temporary
>> names already.
>>
>> AFAIKT we could do all of this by doing the same
>> tmp/rename/sync_file_range dance on the main object store.
>>
>
> Why not the main object store? We want to maintain the invariant that any
> name in the main object store refers to a file that durably has the
> correct contents.
> If we do sync_file_range and then rename, and then crash, we now have a f=
ile
> in the main object store with some SHA name, whose contents may or may not
> match the SHA.  However, if we ensure an fsync happens before the rename,
> a crash at any point will leave us either with no file in the main
> object store or
> with a file that is durable on the disk.

Ah, I see.

Why does that matter? If the "bulk" mode works as advertised we might
have such a corrupt loose or pack file, but we won't have anything
referring to it as far as reachability goes.

I'm aware that the various code paths that handle OID writing don't deal
too well with it in practice to say the least, which one can try with
say:

    $ echo foo | git hash-object -w --stdin
    45b983be36b73c0788dc9cbcb76cbb80fc7bb057
    $ echo | sudo tee .git/objects/45/b983be36b73c0788dc9cbcb76cbb80fc7bb057

I.e. "fsck", "show" etc. will all scream bloddy murder, and re-running
that hash-object again even returns successful (we see it's there
already, and think it's OK).

But in any case, I think it would me much easier to both review and
reason about this code if these concerns were split up.

I.e. things that want no fsync at all (I'd think especially so) might
want to have such updates serialized in this manner, and as Junio
pointed out making these things inseparable as you've done creates API
concerns & fallout that's got nothing to do with what we need for the
performance gains of the bulk checkin fsyncing technique,
e.g. concurrent "update-index" consumers not being able to assume
reported objects exist as soon as they're reported.

>> Then instead of the "bulk_fsync" cookie file don't close() the last file
>> object file we write until we issue the fsync on it.
>>
>> But maybe this is all needed, I just can't understand from the commit
>> message why the "bulk checkin" part is being done.
>>
>> I think since we've been over this a few times without any success it
>> would really help to have some example of the smallest set of syscalls
>> to write a file like this safely. I.e. this is doing (pseudocode):
>>
>>     /* first the bulk path */
>>     open("bulk/x.tmp");
>>     write("bulk/x.tmp");
>>     sync_file_range("bulk/x.tmp");
>>     close("bulk/x.tmp");
>>     rename("bulk/x.tmp", "bulk/x");
>>     open("bulk/y.tmp");
>>     write("bulk/y.tmp");
>>     sync_file_range("bulk/y.tmp");
>>     close("bulk/y.tmp");
>>     rename("bulk/y.tmp", "bulk/y");
>>     /* Rename to "real" */
>>     rename("bulk/x", x");
>>     rename("bulk/y", y");
>>     /* sync a cookie */
>>     fsync("cookie");
>>
>
> The '/* Rename to "real" */' and '/* sync a cookie */' steps are
> reversed in your above sequence. It should be

Sorry.

> 1: (for each file)
>     a) open
>     b) write
>     c) sync_file_range
>     d) close
>     e) rename in tmp_objdir  -- The rename step is not required for
> bulk-fsync. An earlier version of this series didn't do it, but
> Jeff King pointed out that it was required for concurrency:
> https://lore.kernel.org/all/YVOrikAl%2Fu5%2FVi61@coredump.intra.peff.net/

Yes we definitely need the rename, I was wondering about why we needed
it 2x for each file, but that was answered above.

>> And I'm asking why it's not:
>>
>>     /* Rename to "real" as we go */
>>     open("x.tmp");
>>     write("x.tmp");
>>     sync_file_range("x.tmp");
>>     close("x.tmp");
>>     rename("x.tmp", "x");
>>     last_fd =3D open("y.tmp"); /* don't close() the last one yet */
>>     write("y.tmp");
>>     sync_file_range("y.tmp");
>>     rename("y.tmp", "y");
>>     /* sync a cookie */
>>     fsync(last_fd);
>>
>> Which I guess is two questions:
>>
>>  A. do we need the cookie, or can we re-use the fd of the last thing we
>>     write?
>
> We can re-use the FD of the last thing we write, but that results in a
> tricker API which
> is more intrusive on callers. I was originally using a lockfile, but
> found a usage where
> there was no lockfile in unpack-objects.

Ok, so it's something we could do, but passing down 2-3 functions to
object-file.c was a hassle.

I tried to hack that up earlier and found that it wasn't *too
bad*. I.e. we'd pass some "flags" about our intent, and amend various
functions to take "don't close this one" and pass up the fd (or even do
that as a global).

In any case, having the commit message clearly document what's needed
for what & what's essential & just shortcut taken for the convenience of
the current implementation would be really useful.

Then we can always e.g. change this later to just do the the fsync() on
the last of N we write.

[Ran out of time, sorry]
