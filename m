Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5F6C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8518761042
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242548AbhJGQI5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 12:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbhJGQI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 12:08:56 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1639C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 09:07:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id z20so24671442edc.13
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gHJL5p/aWzyyhK+ZhAEskj48KFXh7//ZA06A9yyvw5I=;
        b=hywKXQ6R+pzJN174AeoHdN/d2RIQvXO1gJWamRHWz8iOOaD0yQxhUfWdP2mXESp9Cc
         HLu9FFMJOIHufFDCD7RQrJMnuGicLoD2WKoaOQza4B+lov3LVdlGcDlG8KkwgX8Fming
         h1PSGcD9pY+RsW+RxMgBQzjnfkiFboCbSrtvqur92WELjgzLgQ6RdX3NAs4M6NOXYKY7
         LuuSHg2JH/Z8dFADxSyH4MTp8ibpKkICkFBfYaEFH7fyHkhqY+1PvvCJUQp7ToKhlGy9
         v06wtVHzXIpIcQqnihv6Roe9W0fqK94EXxgagvi5WhglGfkBOMwZNyOMMoJoKzuMho40
         6how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gHJL5p/aWzyyhK+ZhAEskj48KFXh7//ZA06A9yyvw5I=;
        b=u9B1m1AVVc1JhD7nZfOfoATZ4o3BdCHeWYmZ8f6Qpl7hkQax00DUqAZ2H/YeQ++EKT
         PFf1bzGKDro3beXFyCWtSjHHGSiNbHenLKAXIJ5wKIvFbRwRob9rxv+YelQIGfPphuOw
         5VxkwbWFtChInWbochgoKk7pnooX3jjx7mjqfoL+vc+67QPHYhkD/b3S6LgOLFRhzSdI
         I5sf5tVFCaW0v/WNjfdDBNhCxCqsUqTfZbULOZ7eJmWbWtKlFtNFVc+co9VyPsD7OGJz
         tBRxMAYgMbiVUN/ePVjQo93AVHpYzmLORmT0mygk48nHkX70ZAl57iYqSwC6A9eL8lAH
         QloA==
X-Gm-Message-State: AOAM531gq5jUmIjtS26dwpXYdLtQYMXdfB1lR0yoQ5iIS1IGeqoE921P
        yT19fDy9lcXnZ4+hnJJpJMnk9L/+WCHUUpRybKM=
X-Google-Smtp-Source: ABdhPJwioe662yb3kHetar+ktbyEKw+TcYRITUCojWJ+bA1fBKZmAQRQkoCIqh7+khpbWJgEqKJ26f/FPR+4c5SMfSc=
X-Received: by 2002:a05:6402:438d:: with SMTP id o13mr5407507edc.0.1633622820125;
 Thu, 07 Oct 2021 09:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com>
 <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com> <patch-v2-2.3-1d5f5e9fff0-20211007T094019Z-avarab@gmail.com>
In-Reply-To: <patch-v2-2.3-1d5f5e9fff0-20211007T094019Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Oct 2021 09:06:48 -0700
Message-ID: <CABPp-BH=3DP-dXRCphY53-3eZd1TU8h5GY_M12nnbEGm-UYB9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sequencer: add a "goto cleanup" to do_reset()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 7, 2021 at 2:46 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> Restructure code that's mostly added in 9055e401dd6 (sequencer:
> introduce new commands to reset the revision, 2018-04-25) to avoid
> code duplication, and to make freeing other resources easier in a
> subsequent commit.

Since the first goto you add precedes the call to
setup_unpack_trees_porcelain(), the next commit will introduce a case
where some code calls clear_unpack_trees_porcelain() without having
first called setup_unpack_trees_porcelain().  With the current code
that is fine since you do initialize unpack_trees_opts to { 0 } first,
and clear_unpack_trees_porcelain() doesn't rely on any special setup,
but I wonder if the naming similarity of the two functions might lead
to future authors to presume they are always called in pairs.

I wonder if we should rename clear_unpack_trees_porcelain() to e.g.
unpack_trees_clear() just to avoid this problem, and then include the
other bits of your previous round to just make all callers of
unpack_trees() call unpack_trees_clear() when they are done.

Or, maybe we could just make unpack_trees() call unpack_trees_clear()
automatically and remove that responsibility from callers...except
that merge-recursive is weird and special and would need a new
function (unpack_trees_without_automatic_cleanup() or something like
that?) since it's the one caller that needs to use
unpack_trees_options data after calling unpack_trees().

So, multiple competing ideas here, and all for theoretical future code
safety.  As such, if any of it sounds like too much of a pain, I'm
fine with punting on it.

> It's safe to initialize "tree_desc" to be zero'd out in order to
> unconditionally free desc.buffer, it won't be initialized on the first
> couple of "goto"'s.
>
> There are three earlier "return"'s in this function that I'm not
> bothering to covert,

s/covert/convert/

> those don't need to rollback anything,

They aren't currently rolling back the lockfile right now, but I think
they should.  Those error cases are pretty unlikely to happen (hard
disk full?), but if they did, they'd leave the lock file in place.

Granted, that's a pre-existing problem rather than a problem
introduced by your patch, so it doesn't need to be part of this
series, but the commit message should at least be tweaked.

> or free any resources

True.

> , so let's leave, even though they could safely "goto
> cleanup" as well.



>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  sequencer.c | 32 +++++++++++++-------------------
>  1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 6872b7b00a4..457eba4ab10 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3650,7 +3650,7 @@ static int do_reset(struct repository *r,
>         struct strbuf ref_name =3D STRBUF_INIT;
>         struct object_id oid;
>         struct lock_file lock =3D LOCK_INIT;
> -       struct tree_desc desc;
> +       struct tree_desc desc =3D { 0 };
>         struct tree *tree;
>         struct unpack_trees_options unpack_tree_opts;
>         int ret =3D 0;
> @@ -3684,10 +3684,8 @@ static int do_reset(struct repository *r,
>                 strbuf_addf(&ref_name, "refs/rewritten/%.*s", len, name);
>                 if (get_oid(ref_name.buf, &oid) &&
>                     get_oid(ref_name.buf + strlen("refs/rewritten/"), &oi=
d)) {
> -                       error(_("could not read '%s'"), ref_name.buf);
> -                       rollback_lock_file(&lock);
> -                       strbuf_release(&ref_name);
> -                       return -1;
> +                       ret =3D error(_("could not read '%s'"), ref_name.=
buf);
> +                       goto cleanup;
>                 }
>         }
>
> @@ -3703,24 +3701,18 @@ static int do_reset(struct repository *r,
>         init_checkout_metadata(&unpack_tree_opts.meta, name, &oid, NULL);
>
>         if (repo_read_index_unmerged(r)) {
> -               rollback_lock_file(&lock);
> -               strbuf_release(&ref_name);
> -               return error_resolve_conflict(_(action_name(opts)));
> +               ret =3D error_resolve_conflict(_(action_name(opts)));
> +               goto cleanup;
>         }
>
>         if (!fill_tree_descriptor(r, &desc, &oid)) {
> -               error(_("failed to find tree of %s"), oid_to_hex(&oid));
> -               rollback_lock_file(&lock);
> -               free((void *)desc.buffer);
> -               strbuf_release(&ref_name);
> -               return -1;
> +               ret =3D error(_("failed to find tree of %s"), oid_to_hex(=
&oid));
> +               goto cleanup;
>         }
>
>         if (unpack_trees(1, &desc, &unpack_tree_opts)) {
> -               rollback_lock_file(&lock);
> -               free((void *)desc.buffer);
> -               strbuf_release(&ref_name);
> -               return -1;
> +               ret =3D -1;
> +               goto cleanup;
>         }
>
>         tree =3D parse_tree_indirect(&oid);
> @@ -3728,13 +3720,15 @@ static int do_reset(struct repository *r,
>
>         if (write_locked_index(r->index, &lock, COMMIT_LOCK) < 0)
>                 ret =3D error(_("could not write index"));
> -       free((void *)desc.buffer);
>
>         if (!ret)
>                 ret =3D update_ref(reflog_message(opts, "reset", "'%.*s'"=
,
>                                                 len, name), "HEAD", &oid,
>                                  NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> -
> +cleanup:
> +       free((void *)desc.buffer);
> +       if (ret < 0)
> +               rollback_lock_file(&lock);
>         strbuf_release(&ref_name);
>         return ret;
>  }
> --
> 2.33.0.1446.g6af949f83bd
>
