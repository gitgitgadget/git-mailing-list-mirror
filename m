Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261FDC433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 21:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbiCWVKW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 17:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240884AbiCWVKV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 17:10:21 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064DA29CB2
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:08:50 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a26so4762981lfg.10
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 14:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P4c+fnP6ocmrX6iahKFdvRmUOxl2zNFwshkKjOZlyco=;
        b=OBUjEi1IqaPWDBvXthYgF2EQ8IgTh+OXevhiLqozCvJxMJC0luq4y4cYl0yM6SRUZs
         FcWbp52yIIA76mkXMd0R5B8Cz6d41K69djyAJo0aO5K0mA401uYiEeS/p/Z9jCtrir/r
         +Ir3gqpXd1E6DtfYtu/j+BqRp1wduUpQ8980eKHyXQpb9fzSfxvKzigTh8Jcx7V9yydN
         Z02vNQnAy6mPpBT5cWn9sVa4kxRzr0ginH22+dPkxM4BokkiXffrij56f1I4cFTfHRcP
         KP4Azl2v3Ab+2lO7bEhI9DSnD1ucj9QoIq4blWzNBgTQYqjxNbF5ukf8jZOcGValCq0h
         8/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P4c+fnP6ocmrX6iahKFdvRmUOxl2zNFwshkKjOZlyco=;
        b=7juG5TgJ5zV0tt9mLmaq21YSJFeiGZwJ31CJSlxIj/bCauha/F0pbQ+yvJIkleULE/
         Q2jeIJ6k/3Uizf0lyonL8vtRqZKBSaPuFb2y40m/STPKwcdP9qo7nFzdHgV4N45dhsNd
         DIcD0JdphsHAXhoMWL221SeY1gRqEw1TlpScv/1xVpTmlLs/1BV9TZZxYD3UI55OkcAH
         1484kmO1AAfRz3OC6gtFwA0LyNd+AwGJu1JhgjfPjXv/bHEMEKO7ZWOGSpqkvzGr/TfV
         Rfd5hRVV84gtf1YksGm4Wn0rOQOZMgEIA6Ploi/P2XusF5DBVhQsM5JMJLx67RfWZP8D
         dVqg==
X-Gm-Message-State: AOAM531njh157q3tQ8gdyMjxcnkPUXVYjetH+LQZ5HXmJ0wqsBaCvDic
        myA6bXY4TSJXKgq8XkY5J/SbVggEK55VpPmGuSk=
X-Google-Smtp-Source: ABdhPJwAG6OHnoUHRzOzeqI5OY7n22bdW1c/gwVAhsCJvGLbRDd+20FJvKYGZE/VmVSWYyWL4lAnLUi630OBVpDmTug=
X-Received: by 2002:a05:6512:1684:b0:448:a0e6:9fa6 with SMTP id
 bu4-20020a056512168400b00448a0e69fa6mr1346841lfb.592.1648069728249; Wed, 23
 Mar 2022 14:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <RFC-cover-0.7-00000000000-20220323T033928Z-avarab@gmail.com>
 <RFC-cover-v2-0.7-00000000000-20220323T140753Z-avarab@gmail.com> <RFC-patch-v2-7.7-a5951366c6e-20220323T140753Z-avarab@gmail.com>
In-Reply-To: <RFC-patch-v2-7.7-a5951366c6e-20220323T140753Z-avarab@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Wed, 23 Mar 2022 14:08:37 -0700
Message-ID: <CANQDOdcFN5GgOPZ3hqCsjHDTiRfRpqoAKxjF1n9D6S8oD9--_A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/7] fsync docs: add new fsyncMethod.batch.quarantine,
 elaborate on old
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Patrick Steinhardt <ps@pks.im>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 23, 2022 at 7:18 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Add a new fsyncMethod.batch.quarantine setting which defaults to
> "false". Preceding (RFC, and not meant to flip-flop like that
> eventually) commits ripped out the "tmp-objdir" part of the
> core.fsyncMethod=3Dbatch.
>
> This documentation proposes to keep that as the default for the
> reasons discussed in it, while allowing users to set
> "fsyncMethod.batch.quarantine=3Dtrue".
>
> Furthermore update the discussion of "core.fsyncObjectFiles" with
> information about what it *really* does, why you probably shouldn't
> use it, and how to safely emulate most of what it gave users in the
> past in terms of performance benefit.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config/core.txt | 80 +++++++++++++++++++++++++++++++----
>  1 file changed, 72 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
> index f598925b597..365a12dc7ae 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -607,21 +607,85 @@ stored on NTFS or ReFS filesystems.
>  +
>  The `batch` is currently only applies to loose-object files and will
>  kick in when using the linkgit:git-unpack-objects[1] and
> -linkgit:update-index[1] commands. Note that the "last" file to be
> +linkgit:git-update-index[1] commands. Note that the "last" file to be
>  synced may be the last object, as in the case of
>  linkgit:git-unpack-objects[1], or relevant "index" (or in the future,
>  "ref") update, as in the case of linkgit:git-update-index[1]. I.e. the
>  batch syncing of the loose objects may be deferred until a subsequent
>  fsync() to a file that makes them "active".
>
> +fsyncMethod.batch.quarantine::
> +       A boolean which if set to `true` will cause "batched" writes
> +       to objects to be "quarantined" if
> +       `core.fsyncMethod=3Dbatch`. This is `false` by default.
> ++
> +The primary object of these fsync() settings is to protect against
> +repository corruption of things which are reachable, i.e. "reachable",
> +via references, the index etc. Not merely objects that were present in
> +the object store.
> ++
> +Historically setting `core.fsyncObjectFiles=3Dfalse` assumed that on a
> +filesystem with where an fsync() would flush all preceding outstanding
> +I/O that we might end up with a corrupt loose object, but that was OK
> +as long as no reference referred to it. We'd eventually the corrupt
> +object with linkgit:git-gc[1], and linkgit:git-fsck[1] would only
> +report it as a minor annoyance
> ++
> +Setting `fsyncMethod.batch.quarantine=3Dtrue` takes the view that
> +something like a corrupt *unreferenced* loose object in the object
> +store is something we'd like to avoid, at the cost of reduced
> +performance when using `core.fsyncMethod=3Dbatch`.
> ++
> +Currently this uses the same mechanism described in the "QUARANTINE
> +ENVIRONMENT" in the linkgit:git-receive-pack[1] documentation, but
> +that's subject to change. The performance loss is because we need to
> +"stage" the objects in that quarantine environment, fsync() it, and
> +once that's done rename() or link() it in-place into the main object
> +store, possibly with an fsync() of the index or ref at the end
> ++
> +With `fsyncMethod.batch.quarantine=3Dfalse` we'll "stage" things in the
> +main object store, and then do one fsync() at the very end, either on
> +the last object we write, or file (index or ref) that'll make it
> +"reachable".
> ++
> +The bad thing about setting this to `true` is lost performance, as
> +well as not being able to access the objects as they're written (which
> +e.g. consumers of linkgit:git-update-index[1]'s `--verbose` mode might
> +want to do).

I wasn't able to understand clearly from your performance numbers.
What did you measure as the additional cost from quarantine=3Dtrue
versus quarantine=3Dfalse? Just if you have the numbers handy...

> ++
> +The good thing is that you should be guaranteed not to get e.g. short
> +or otherwise corrupt loose objects if you pull your power cord, in
> +practice various git commands deal quite badly with discovering such a
> +stray corrupt object (including perhaps assuming it's valid based on
> +its existence, or hard dying on an error rather than replacing
> +it). Repairing such "unreachable corruption" can require manual
> +intervention.
> +
>  core.fsyncObjectFiles::
> -       This boolean will enable 'fsync()' when writing object files.
> -       This setting is deprecated. Use core.fsync instead.
> -+
> -This setting affects data added to the Git repository in loose-object
> -form. When set to true, Git will issue an fsync or similar system call
> -to flush caches so that loose-objects remain consistent in the face
> -of a unclean system shutdown.
> +       This boolean will enable 'fsync()' when writing loose object
> +       files.
> ++
> +This setting is the historical fsync configuration setting. It's now
> +*deprecated*, you should use `core.fsync` instead, perhaps in
> +combination with `core.fsyncMethod=3Dbatch`.
> ++
> +The `core.fsyncObjectFiles` was initially added based on integrity
> +assumptions that early (pre-ext-4) versions of Linux's "ext"
> +filesystems provided.
> ++
> +I.e. that a write of file A without an `fsync()` followed by a write
> +of file `B` with `fsync()` would implicitly guarantee that `A' would
> +be `fsync()`'d by calling `fsync()` on `B`. This asssumption is *not*
> +backed up by any standard (e.g. POSIX), but worked in practice on some
> +Linux setups.
> ++
> +Nowadays you should almost certainly want to use
> +`core.fsync=3Dloose-object` instead in combination with
> +`core.fsyncMethod=3Dbulk`, and possibly with
> +`fsyncMethod.batch.quarantine=3Dtrue`, see above. On modern OS's (Linux,
> +OSX, Windows) that gives you most of the performance benefit of
> +`core.fsyncObjectFiles=3Dfalse` with all of the safety of the old
> +`core.fsyncObjectFiles=3Dtrue`.
>
>  core.preloadIndex::
>         Enable parallel index preload for operations like 'git diff'
> --
> 2.35.1.1428.g1c1a0152d61
>

I think the notion of minimizing fsyncs across the whole repository is
a great one.  However, your implementation isn't clean from an API
perspective, since people modifying the top-level commands need to
reason about the full set of operations to avoid silently breaking the
fsync requirements.  I think we should phrase this as a "transaction"
that the top level command can begin and end. Subcomponents of the
repo can "enlist" in the transaction and do the right thing optimally
when the overall transaction commits or aborts.

In the end, I think the optimal solution should be layered on top of
the final form of my current patch series as an incremental
improvement.  I'm going to start the rebranding of
plug/unplug_bulk_checkin in V3 of the patch series.

Thanks,
Neeraj
LAST MAIL
