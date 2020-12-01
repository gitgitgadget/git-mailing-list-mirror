Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35162C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 14:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06342076C
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 14:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Riznr0CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgLAOc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 09:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgLAOc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 09:32:59 -0500
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F1DC0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 06:32:18 -0800 (PST)
Received: by mail-vs1-xe42.google.com with SMTP id u7so994894vsq.11
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rpGu1d1CYVdQTwZ80ZfhfYi2liVY5jawMhHVcoRPp5w=;
        b=Riznr0CLOdZox7eqbtOJdh93BZ95g3vt0gHlsmfOsNdCKBrW2RGPbaf73xHrumVSVI
         hDUUTh8JCvXXItvCo20QT15zgGun9Fof/t/EgDcilNukBok8aEBSOkhkTu9XgnmdPt/9
         D+u+meFLSNiHiHANXDBu/k4fxmf3Txw6DmaA6HvLoGZ0iHlckm1CaHt1k/FO6Vnip1Zr
         Weln7wicKgQsN15fJ9jomkUrh1sahB5N9DppGLzeHKX8xAGnNhNzmRKSOaonAd7wLNSJ
         KG8bzt4I6anPnzP4Q2LKCpI1KEJNWYMhznIynQu4B2adww+Yw6X68Le7qEP4m8WgxE9h
         70TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rpGu1d1CYVdQTwZ80ZfhfYi2liVY5jawMhHVcoRPp5w=;
        b=oOZRs9WeQ5I2wlN9uaGRENYhRq9JDmZ3btWLSel543bzkNCkI/SXtm2WM0qEt1Jg4w
         4NP77rcG/RyoIYHbBjylaGRc5G3WHYxwbW8FvOrYT+8wdfDIsX80fQ98RoMSfB1uT2LO
         ssxLS1mRsATjfOn3m5WKRDxJ8rmYRL16Pj8IDMou2H1/Hsls2TJfsl9sTKDZiHuZ8Vq+
         wHFMwf8PidgMQ/jTLEVVSAa3PAZCtmXtYdUwGnR/yF72O+2nZ6HUWcqId7NznuuWPYd5
         kINt4W6iw70gnx3avbDoefGzr/J/KkYX1p9m/X37F8oLqWlDu5naUnXaMPX1eXpSw/MJ
         XwDA==
X-Gm-Message-State: AOAM532nokQ7IUMLLQXWG8AtgDPsjKVlqGsPnieaaVKGB/GFxVazGskQ
        XYlj3PGAT2Wk+GdICmvrJtgLpZh0N0RSC6ubxZccKA==
X-Google-Smtp-Source: ABdhPJyCgEdAOyjwAf49pe6YEhPlrN8FSQ9cEuRbnjCZtHhm60upLHG4sTY01u5bZZ6e921hM9x/iqHM0k3Z+lWCoXA=
X-Received: by 2002:a67:a84:: with SMTP id 126mr1821342vsk.5.1606833137901;
 Tue, 01 Dec 2020 06:32:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.801.git.1606545878.gitgitgadget@gmail.com> <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com>
In-Reply-To: <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Dec 2020 15:32:06 +0100
Message-ID: <CAFQ2z_N=sZuYorZxNLn-OoWjb6y=1zrc7sCPuKzZHQODi08s+Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] fixup! reftable: rest of library
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 28, 2020 at 7:44 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Close the file descriptors to obsolete files before trying to delete or
> rename them. This is actually required on Windows.
>
> Note: this patch is just a band-aid to get the tests pass on Windows.
> The fact that it is needed raises concerns about the overall resource
> handling: are file descriptors closed properly whenever appropriate, or
> are they closed much later (which can lead to rename() problems on
> Windows, and risks running into ulimits)?
>
> Also, a `reftable_stack_destroy()` call had to be moved in
> `test_reftable_stack_uptodate()` to avoid the prompt complaining that a
> `.ref` file could not be deleted on Windows. This raises the question
> whether the code does the right thing when two concurrent processes want
> to access the reftable, and one wants to compact it. At the moment, it
> does not appear to fail gracefully.

Thanks for the report; I have to look more closely at these fixes; I
fear they might be incorrect.

The reftable spec doesn't treat this case in depth, and I think it was
rather written for Unix-like semantics. In the Unix flavor, a process
that wants to read can keep file descriptors open to keep reading from
the ref DB at a consistent snapshot.

What is the approach that the rest of Git on Windows takes in these
circumstances?

Consider processes P1 and P2, and the following sequence of actions

P1 opens ref DB (ie. opens a set of *.ref files for read)
P2 opens ref DB, executes a transaction. Post-transaction, it compacts
the reftable stack.
P2 exits
P1 exits

Currently, the compaction in P2 tries to delete the files obviated by
the compaction. On Windows this currently fails, because you can't
delete open files.

There are several options:

1) P2 should fail the compaction. This is bad because it will lead to
degraded performance over time, and it's not obvious if you can
anticipate that the deletion doesn't work.
2) P2 should retry deleting until it succeeds. This is bad, because a
reader can starve writers.
3) on exit, P1 should check if its *.ref files are still in use, and
delete them. This smells bad, because P1 is a read-only process, yet
it executes writes. Also, do we have good on-exit hooks in Git?
4) On exit, P1 does nothing. Stale *.ref files are left behind. Some
sort of GC process cleans things up asynchronously.
5) The ref DB should not keep files open, and should rather open and
close files as needed; this means P1 doesn't keep files open for long,
and P2 can retry safely.

I think 3) seems the cleanest to me (even though deleting in read
process feels weird), but perhaps we could fallback to 5) on windows
as well.

Thoughts?

What errno code does deleting an in-use file on Windows produce?


> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  reftable/stack.c      | 37 ++++++++++++++++++++++++++++---------
>  reftable/stack_test.c |  2 +-
>  2 files changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 1d632937d7..02c6a370ba 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -212,7 +212,6 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
>                 goto done;
>
>         new_tables =3D NULL;
> -       st->readers_len =3D new_readers_len;
>         if (st->merged !=3D NULL) {
>                 merged_table_release(st->merged);
>                 reftable_merged_table_free(st->merged);
> @@ -220,6 +219,7 @@ static int reftable_stack_reload_once(struct reftable=
_stack *st, char **names,
>         if (st->readers !=3D NULL) {
>                 reftable_free(st->readers);
>         }
> +       st->readers_len =3D new_readers_len;
>         st->readers =3D new_readers;
>         new_readers =3D NULL;
>         new_readers_len =3D 0;
> @@ -939,14 +939,6 @@ static int stack_compact_range(struct reftable_stack=
 *st, int first, int last,
>         strbuf_addstr(&new_table_path, "/");
>         strbuf_addbuf(&new_table_path, &new_table_name);
>
> -       if (!is_empty_table) {
> -               err =3D rename(temp_tab_file_name.buf, new_table_path.buf=
);
> -               if (err < 0) {
> -                       err =3D REFTABLE_IO_ERROR;
> -                       goto done;
> -               }
> -       }
> -
>         for (i =3D 0; i < first; i++) {
>                 strbuf_addstr(&ref_list_contents, st->readers[i]->name);
>                 strbuf_addstr(&ref_list_contents, "\n");
> @@ -960,6 +952,32 @@ static int stack_compact_range(struct reftable_stack=
 *st, int first, int last,
>                 strbuf_addstr(&ref_list_contents, "\n");
>         }
>
> +       /*
> +        * Now release the merged tables and readers
> +        */
> +       if (st->merged !=3D NULL) {
> +               reftable_merged_table_free(st->merged);
> +               st->merged =3D NULL;
> +       }
> +
> +       if (st->readers !=3D NULL) {
> +               int i =3D 0;
> +               for (i =3D 0; i < st->readers_len; i++) {
> +                       reader_close(st->readers[i]);
> +                       reftable_reader_free(st->readers[i]);
> +               }
> +               st->readers_len =3D 0;
> +               FREE_AND_NULL(st->readers);
> +       }
> +
> +       if (!is_empty_table) {
> +               err =3D rename(temp_tab_file_name.buf, new_table_path.buf=
);
> +               if (err < 0) {
> +                       err =3D REFTABLE_IO_ERROR;
> +                       goto done;
> +               }
> +       }
> +
>         err =3D write(lock_file_fd, ref_list_contents.buf, ref_list_conte=
nts.len);
>         if (err < 0) {
>                 err =3D REFTABLE_IO_ERROR;
> @@ -1242,6 +1260,7 @@ static int stack_check_addition(struct reftable_sta=
ck *st,
>
>         free(refs);
>         reftable_iterator_destroy(&it);
> +       reader_close(rd);
>         reftable_reader_free(rd);
>         return err;
>  }
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 11d3d30799..c35abd7301 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -159,12 +159,12 @@ static void test_reftable_stack_uptodate(void)
>         err =3D reftable_stack_add(st2, &write_test_ref, &ref2);
>         EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
>
> +       reftable_stack_destroy(st1);
>         err =3D reftable_stack_reload(st2);
>         EXPECT_ERR(err);
>
>         err =3D reftable_stack_add(st2, &write_test_ref, &ref2);
>         EXPECT_ERR(err);
> -       reftable_stack_destroy(st1);
>         reftable_stack_destroy(st2);
>         clear_dir(dir);
>  }
> --
> gitgitgadget
>


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
