Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C4BCA0EEB
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 14:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjILOna (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 10:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjILOn2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 10:43:28 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546AB10D
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 07:43:24 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1cc87405650so3782531fac.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694529801; x=1695134601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbrccGU/mzoUTStj9dwOPmYe9diEuKLoCoxRzKzLm0U=;
        b=S6jFsOIDQ7A6XtnJ2vL9sjN//KFPTj/AG9fOPBXRhOdjs0Yq0XagJkFls2+DioMhex
         4nDX8NLIx0XHVItSM3GI8Jp8TsXHXV6PpzdeuBBwQ1upZVpfCnhZF0aAVDN4Jk5I0daa
         lxc8rCxOqA05ZclHBcbNiw0UBWsJRXtFGs554lH3RqEUCbB9URqwscRID4C3/q/YXW1t
         1Lh/dnZgwTdAe6iHJGawQuqNIPdCalTw+3NZ1hBSyJ/cddOlMQ0C+jk0AyrsGqMQsN4D
         5cV4l7JZphcPA4Yc3iBlDseAUZ3Xg9UjLmdiHUm7M7EqBxQsmUF/Ax7yH2ock4y8w5cT
         hEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529801; x=1695134601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tbrccGU/mzoUTStj9dwOPmYe9diEuKLoCoxRzKzLm0U=;
        b=ln/OI7KTdsq/W3kvfW6jFVjQX8pHw2/P0uvuYGxO9DdbqsWp0X6rPC8GagGtnEryAh
         kR5c+Nn73rXuUMFwOpg8uVT4Vz2x6DEZfQu4XbMQYAe0ZdsVH8sRj0EtQpREEwoD9n3d
         SWc/TAxIPQyXAD1HodS5TLOCzJ36d76s0AzyQ2Tf8MV9Dg/AOjJjwXzLlFHbqCI4Jf0K
         FRNmSmBdmF08E28dBHPEWrd3RaQtgO35tg7muRMz8e/He5QSgy12xbk6G31R0wjBV5Xk
         4S/FVVQnl5fKG28wvBk9+w2M6HfbkG0dYE2r7xoj7Q5zL2UrvbEc2yVPUHiIFNREcqHG
         JGmg==
X-Gm-Message-State: AOJu0YwuQU17oShvcp2PSyFBxmDhtF3Q+0O37Pfz4PMHIN6CcCFrbjfi
        lZ+2yQ8aSbeLAzBVq7CjwVgB6uL4yGaHQuukOeDMKvHvnB8sIQ==
X-Google-Smtp-Source: AGHT+IHzHRrzC+AIwTsKQ7sES5u9X/J+MIkMBkVWyharrwnKyIaurlEjMsJS/xFNIW/svvWrRA3M1DM1VV1VSdew7KE=
X-Received: by 2002:a05:6870:fb8a:b0:1bb:6cca:3468 with SMTP id
 kv10-20020a056870fb8a00b001bb6cca3468mr13910637oab.47.1694529801275; Tue, 12
 Sep 2023 07:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230908174208.249184-1-karthik.188@gmail.com> <xmqqwmx0sca3.fsf@gitster.g>
In-Reply-To: <xmqqwmx0sca3.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Tue, 12 Sep 2023 16:42:55 +0200
Message-ID: <CAOLa=ZT25MB4c4ag3wRruipsxxBdX-+ovr+Eq3uMDuQJvJyVeg@mail.gmail.com>
Subject: Re: [PATCH] revision: add `--ignore-missing-links` user option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 8, 2023 at 9:19=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> The above description needs tightened up a bit, I think.
>
> What is left unsaid is that you arranged a repository to borrow from
> an alternate object directory (or two), and plan to walk objects
> with this bit on in the repository, while leaving the alternates
> disabled.  Without stating that you plan to disable the alternates
> while this mode of operation happens, nothing would happen when the
> traversal goes from the main to the alternate because no links are
> broken, no?
>

Fair enough, I agree with your points. I'll amend the message to highlight =
this
scenario.

> > By exposing this new flag `--ignore-missing-links`, users can set the
> > required env variables (GIT_OBJECT_DIRECTORY and
> > GIT_ALTERNATE_OBJECT_DIRECTORIES) along with the `--boundary` flag to
> > find the boundary objects between object directories.
>
> This command being a plumbing, there is not much reason to object to
> surfacing features that already internally exist to the command line
> option.    Having said that,
>
>  * Suppose your traversal with --ignore-missing-links from the tip
>    of a branch reaches a tree object A, and the tree object A has a
>    link to a blob B and a blob C.  But B is in a separate object
>    store that you usually access via the alternate mechanism.
>    Instead of barfing "The repository is corrupt---object A points
>    at object B that does not exist", we pretend that A does not have
>    the link to B and keep traversing, discovering C and other
>    objects.
>
>    That much we can read from the above and also the documentation
>    part of the patch.  The interaction with --boundary needs to be
>    clarified in this description and the documentation, though.  It
>    is unclear if you show 'A' or 'B' in this scenario.

Do note that the `--boundary` option only works with commits. Keeping this =
in
mind `--ignore-missing-links` when used with `--boundary` doesn't even trav=
erse
non-commit objects. Which means trees/blobs being corrupted shouldn't matte=
r.

But I did realize that `--ignore-missing-links` as this patch stands
is broken when
used alongside the `--objects` flag (`--boundary` doesn't work with
`--objects` at the
moment, this is something I plan to tackle soon after with a
`--boundary-objects` flag).
The second version of this patch will have a fix to ensure that even
non-commit objects
are ignored during traversal if `--objects` option is used.

>
>  * Some traversals use the ignore-missing-links bit implicitly and
>    currently there is no way to turn it off.  Is it plausible that
>    user may want to explicitly toggle it off, with the option
>    negated, i.e. --no-ignore-missing-links?  I do not immediately
>    see the utility of such an option, but that is only due to my
>    lack of imagination.  For now, I think it makes sense not to
>    allow negating this option, until somebody comes up with a useful
>    use case.
>

Agreed!

> > +--ignore-missing-links::
> > +     When an object points to another object that is missing, pretend =
as if the
> > +     link did not exist. These missing links are not written to stdout=
 unless
> > +     the --boundary flag is passed.
>
> Does "git rev-list" ever writes "links"?  I thought not.
>
> "These missing objects are not written" would be more sensible, but
> we never write missing objects with or without the option, so it
> is not even worth saying.
>
> When "--boundary" is passed, do they appear as if they are
> available?  If not, then the above description is very misleading.
>
>     During traversal, if an object that is referenced does not
>     exist, pretend as if the reference itself does not exist,
>     instead of dying of a repository corruption.  Running the
>     command with the "--boundary" option makes these missing
>     objects, together with the objects on the edge of revision
>     ranges (i.e. true boundary objects), appear on the output,
>     prefixed with '-'.
>
> or something like that, perhaps?
>

This indeed is better, I've copied and modified it as needed.

> > +# With `--ignore-missing-links`, we stop the traversal when we encount=
er a
> > +# missing link.
> > +test_expect_success 'rev-list only prints main odb commits with --igno=
re-missing-links' '
> > +     test_stdout_line_count =3D 5 git -C main rev-list --ignore-missin=
g-links HEAD
> > +'
> > +
> > +# With `--ignore-missing-links` and `--boundary`, we can even print th=
ose boundary
> > +# commits.
> > +test_expect_success 'rev-list prints boundary commit with --ignore-mis=
sing-links' '
> > +     git -C main rev-list --ignore-missing-links --boundary HEAD >list=
-output &&
> > +     test_stdout_line_count =3D 6 cat list-output &&
> > +     test_stdout_line_count =3D 1 cat list-output | grep "^-"
> > +'
>
> These tests are way too loose.  Not only you want to see certain
> number of boundary objects, you _know_ exactly which object should
> be on the boundary, and you should check that instead.  That will
> allow you to find a mistake to write commit 'A' that refers to a
> missing commit 'B', when they wanted to write the missing comit 'B',
> as a boundary object, for example.
>

Fair enough, I will make them more specific and add some tests for
missing trees/blobs.

> Thanks.

Thank you for the review. Will send the next version of the patch soon :)
