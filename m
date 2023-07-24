Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63480C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 09:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjGXJBi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 05:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjGXJBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 05:01:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C4A10CA
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 02:01:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so5957863e87.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 02:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189269; x=1690794069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUyxQFKOQXmGizkdORIOh+/JwRls3VT312n9Gg+cgdg=;
        b=XM5bCOv2CiX4lPbcsRyPUalZYrQ7WmdKmaU1rqPsSG0B5CfrOCiaWjT1rJ+ng7p/b3
         ZAvWjyCbHUDkU8G92zawcrKJIKSrzOQb7slmLr9mgkoR3YhbsCT0TntgtHNy87/ZFOFC
         Ny/u/ioFOlO3jKSZOtk1opec/J53J+qdxFjVf7FbocZztNQzMwp9E7+mva5UlklwSfkI
         zUQ/QXFJpU3jNfMe1fC6RHSjFwwIFSY4juaid9MmQ2NiztudQjiEo4s9r3DxpKcViUp4
         /X3waejgnaKDGxSorOaHxjYO6vzH6T/WYn0NzlN+KUzQ8vyw9DmGqPQtZooWq+JSTqde
         KH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189269; x=1690794069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUyxQFKOQXmGizkdORIOh+/JwRls3VT312n9Gg+cgdg=;
        b=IWpwJ+4TXaKlaybfJsdJnRUGWB0dxjUbPXljRPImN2eKS21KpYnogcfSWRnfMy9KV3
         mPLWpw2G3DO1Rmw7w/ZbsSl90KFPG87kRfJE7AaXzXCaWVY3zeIVER1sEL1TZhdrnbQU
         7EIH90z6YwYBZYmlooFGLOwsA5J+7SwNgoMl+6XfB/21IiIsS74gU4IENiEWlQFJoz6L
         xqsptiLh4CacadhN5pXosj8v6Ch43/8hL8qI2WhDXMQduuyy5mxtFZA5mEJiocDHZBEM
         k/t+/nqS3ZMnMw7P2Pb6PRwslydkh0HSDJfSf44M8GcALuwUHzTxPO1XvAzd6Tewe2LN
         YEDg==
X-Gm-Message-State: ABy/qLZUKYg7jqGEE80K1NSZSHIdZxtVlyYEGm2PmAgsQ0jJ9aWGs1Mw
        edmx6GZDdzW0Mr7DGtOD5cVYjgXZ6WaRTYnWN/ZL+WtR
X-Google-Smtp-Source: APBJJlF9Fs5O3oSeR7O8duoeZZ9ALixRHhkMCjnhwviqpFM0+Hlfk2LZ5BOvyM+x0VswNo7/0Vf3NO1dAeI2ASNyig0=
X-Received: by 2002:ac2:4846:0:b0:4f8:6d54:72fb with SMTP id
 6-20020ac24846000000b004f86d5472fbmr4115976lfy.62.1690189268700; Mon, 24 Jul
 2023 02:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230705060812.2865188-1-christian.couder@gmail.com> <20230705060812.2865188-8-christian.couder@gmail.com>
 <xmqq5y6y1agl.fsf@gitster.g>
In-Reply-To: <xmqq5y6y1agl.fsf@gitster.g>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 24 Jul 2023 11:00:56 +0200
Message-ID: <CAP8UFD1tqzp744j0KORw-zcgOn6Tufm4Kk3yct3vHGY29pbm-w@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] repack: implement `--filter-to` for storing
 filtered out objects
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

On Wed, Jul 5, 2023 at 8:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > A previous commit has implemented `git repack --filter=3D<filter-spec>`=
 to
> > allow users to filter out some objects from the main pack and move them
> > into a new different pack.
>
> OK, this sidesteps the question I had on an earlier step rather
> nicely.  Instead of having to find out which ones are to be moved
> away, just generating them in a separate location would be more
> straight forward.
>
> The implementation does not seem to restrict where --filter-to
> directory can be placed, but shouldn't it make sure that it is one
> of the already specified alternates directories?  Otherwise the user
> will end up corrupting the repository, no?

I don't think it should make sure that the implementation should
restrict where the --filter-to directory can be placed.

In version 3, that I just sent, I have written the following in the
commit message to explain this:

"
   Even in a different directory, this pack can be accessible if, for
   example, the Git alternates mechanism is used to point to it. In fact
   not using the Git alternates mechanism can corrupt a repo as the
   generated pack containing the filtered objects might not be accessible
   from the repo any more. So setting up the Git alternates mechanism
   should be done before using this feature if the user wants the repo to
   be fully usable while this feature is used.

   In some cases, like when a repo has just been cloned or when there is no
   other activity in the repo, it's Ok to setup the Git alternates
   mechanism afterwards though. It's also Ok to just inspect the generated
   packfile containing the filtered objects and then just move it into the
   '.git/objects/pack/' directory manually. That's why it's not necessary
   for this command to check that the Git alternates mechanism has been
   already setup.
"

I haven't mentioned cases related to promisor remotes, but I think in
some of those cases the feature can be very useful too while there is
no need to check that the Git alternates mechanism has been set up.

In version 3, the doc for the --filter-to option and the corresponding
gc.repackFilterTo config flag look like this:

+--filter-to=3D<dir>::
+       Write the pack containing filtered out objects to the
+       directory `<dir>`. Only useful with `--filter`. This can be
+       used for putting the pack on a separate object directory that
+       is accessed through the Git alternates mechanism. **WARNING:**
+       If the packfile containing the filtered out objects is not
+       accessible, the repo could be considered corrupt by Git as it
+       migh not be able to access the objects in that packfile. See
+       the `objects` and `objects/info/alternates` sections of
+       linkgit:gitrepository-layout[5].

+gc.repackFilterTo::
+       When repacking and using a filter, see `gc.repackFilter`, the
+       specified location will be used to create the packfile
+       containing the filtered out objects. **WARNING:** The
+       specified location should be accessible, using for example the
+       Git alternates mechanism, otherwise the repo could be
+       considered corrupt by Git as it might not be able to access the
+       objects in that packfile. See the `--filter-to=3D<dir>` option
+       of linkgit:git-repack[1] and the `objects/info/alternates`
+       section of linkgit:gitrepository-layout[5].

So they warn about possible issues with the feature and link to some
relevant doc.

Now if we think that it's not enough, I would implement a check in the
code that would warn users loudly if the directory specified by those
options is not accessible using the Git alternates mechanism. It would
be annoying I think that it would be too restrictive to error out in
that case though.
