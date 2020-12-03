Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1C4C433C1
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 13:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1983F20769
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 13:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbgLCN5g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 08:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727821AbgLCN5g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 08:57:36 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E1FC061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 05:56:56 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id j140so1277090vsd.4
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 05:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d+p6uI9qY01BW+kKH6YRaULrmNv8nH9ZIctBvv0X/wA=;
        b=fj5gpvZO67seB9ZFHO58D67jUqGSYoBvec1pFuhOG326NkBvKCyh9X/jtjh94RfT2d
         SJfk8GEq41OeHhmprbr2Mv3hovgR3/h6TJ69hlKmqrLlYVc1zYGATIgaLgSmwhR8EYcL
         qasb45D+7ksPKOhRSyMfANs3dAiI+NEloc9IyACLLDIh7FhvZ5Lw14g3dtspB/OGq0G/
         xRBmRi8ntdlyQF+uqGalELKwdV0yPaXBKS3gl9rag4XCNDXsWvxO6twX2z9+EmJxiGu1
         /efWzugPhmIIxE/MllbMHTE9apxiXx0grrBMDNL5XwDWCjbDVIOa28fXSsXHKb53MY7E
         sU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d+p6uI9qY01BW+kKH6YRaULrmNv8nH9ZIctBvv0X/wA=;
        b=k3sq033qNuFFl/xwsz/LqmrjOK8s8jjFNogd027mdF8b5QoaEaxb2MGrM5rPN9/U1S
         0OsSAj8PUqHFbbb+SGB6jt1QwFQuxJt/7wO2ElNSdwrCWJIIbyyX1VVXOIBOLbqqgkDl
         p2fTC1lfH6FCw9LksvnPyuKK0D39hfwyHAPU/Ne93IDXCcL4/Zf9RbF/tm3d3CTOTmTq
         djpigaVHry4ljqakD6qTLxkN9KG0QbROu6IUwrO9zDrO7FOK0ay0p/NhZwqKcd87j5XU
         N8A61w3AZr7g07BHapx0UNn79xZ1X1FzfEmQ+avn54SGrIlCAyKH+8yfkQZnEQuSaciv
         6ArQ==
X-Gm-Message-State: AOAM531EFEBBwpDfAOHC0eazFm0ZlLeQ44BhJyGKx3eVAWTCU2k00J1Y
        wWIgMPY4YT9LDXpIykZxHX/sxAA8xGhj4UfCSe1SXQ3Ac/c=
X-Google-Smtp-Source: ABdhPJxdWroJRsHiH2BYx2/HCCm/k1DNQ9eD45AsdSzcxz8CM3xLNHGvy+Npu0C4qKAVQdWgvdk5D5wgXpE40Skjb5E=
X-Received: by 2002:a67:ed83:: with SMTP id d3mr2217296vsp.28.1607003814705;
 Thu, 03 Dec 2020 05:56:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.801.git.1606545878.gitgitgadget@gmail.com>
 <878bffcdfe5ca7657f839de8f7993d9098726636.1606545878.git.gitgitgadget@gmail.com>
 <CAFQ2z_N=sZuYorZxNLn-OoWjb6y=1zrc7sCPuKzZHQODi08s+Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.2012021149030.25979@tvgsbejvaqbjf.bet> <CAFQ2z_PNbMjrhVBaDsDWZbrgCFSQn=VBxxiyh=wpy+JZADmHcQ@mail.gmail.com>
 <87k0tzulf1.fsf@evledraar.gmail.com>
In-Reply-To: <87k0tzulf1.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 3 Dec 2020 14:56:43 +0100
Message-ID: <CAFQ2z_PBk+fHLQ_hP5Lo1qJEX+eHnfWV_pbzkijajdMJDauW-A@mail.gmail.com>
Subject: Re: Reftable locking on Windows (Re: [PATCH 1/6] fixup! reftable:
 rest of library)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 1:24 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> >> Indeed. So the design needs to be fixed, if it fails.
> >>
> >> > There are several options:
> >> >
> >> > 1) P2 should fail the compaction. This is bad because it will lead t=
o
> >> > degraded performance over time, and it's not obvious if you can
> >> > anticipate that the deletion doesn't work.
> >> > 2) P2 should retry deleting until it succeeds. This is bad, because =
a
> >> > reader can starve writers.
> >> > 3) on exit, P1 should check if its *.ref files are still in use, and
> >> > delete them. This smells bad, because P1 is a read-only process, yet
> >> > it executes writes. Also, do we have good on-exit hooks in Git?
> >> > 4) On exit, P1 does nothing. Stale *.ref files are left behind. Some
> >> > sort of GC process cleans things up asynchronously.
> >> > 5) The ref DB should not keep files open, and should rather open and
> >> > close files as needed; this means P1 doesn't keep files open for lon=
g,
> >> > and P2 can retry safely.
> >> >
> >> > I think 3) seems the cleanest to me (even though deleting in read
> >> > process feels weird), but perhaps we could fallback to 5) on windows
> >> > as well.
> >>
> >> Traditionally, Git would fail gracefully (i.e. with a warning) to dele=
te
> >> the stale files, and try again at a later stage (during `git gc --auto=
`,
> >> for example, or after the next compaction step).
> >
> > So, how does this sound:
> >
> > * add a void
> >
> >   set_warn_handler(void(*handler)(char const*))
> >
> > The handler is called for non-fatal errors (eg. deleting an in-use
> > .ref file during compaction), and can provide the warning.
> >
> > * all .ref files will be prefixed with an 8-byte random string, to
> > avoid that new *.ref files collide with unreferenced, stale *.ref
> > files.
>
> Just trying to follow along here. Do you mean prefix the file name or
> the content of those *.ref files? In any case isn't this synonymous with
> proposing moving beyond reftable v1 (to the WIP v2, or a v1.1 with just
> this change?). The current spec seems to preclude prefixing either the
> file content or filename, but maybe I'm misreading it:

This is about prefixing the filename with an uniquifying prefix. This
is because the range of timestamps encompassed by the table doesn't
uniquely identify the table.

Consider the following case:
  State: 1 table "00001.ref"
  Transaction 1: add ref xyz at timestamp 2
     add ref abc at timestamp 2
     =3D> 00002.ref
  Transaction 2: add delete ref xyz at timestamp 3
     =3D> 00003.ref

On compacting 00002 and 00003 together, you'll end up with a table for
only  "ref abc at timestamp 2". If you call that result 00002.ref
again, there are two versions 00002.ref.

In the current spec with unix semantics, that's not a problem, because
out of date tables are removed, and disappear once the last reader closes
the file, but if we have to cater for a system
where removal that doesn't always work, we'd have to fix up things
afterwards. That means we have to be able to tell apart these two
versions of 00002.ref, and this is where a random prefix would help.

The exact naming of the tables is not central to the spec, as the
table names to read are listed in tables.list, and systems can write
filenames as they please. Maybe recommendations around filenames
should be phrased as a "SHOULD" clause, with a "MUST" that each table
has a globally unique name.

> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/techn=
ical/reftable.md#update-transactions
> https://googlers.googlesource.com/sop/jgit/+/reftable/Documentation/techn=
ical/reftable.md#header
>
> When the reftable format was initially being discussed I suggested
> somewhat flippantly (why not SQLite?). Partially because in trying to
> invent what's essentially a portable and concurrently updated database
> format we'd be likely to reinvent much of the same wheel.
>
> So not to drag that whole thing up again as a proposal for a format
> replacement, but I wonder what SQLite would do in this scenario & others
> where desired DB semantics / transactions and FS/portability semantics
> clash. AFAIK the reftable has only been battle-tested in production
> under JGit so far (presumably Linux-only). Whereas SQLite has been
> ported to and widely used on Windows, HP/UX and probably other systems
> where Linux-specific assumptions don't apply.

I think it would be an interesting exercise to build a ref database on
SQLite, and I wish it had been done before, because large part of the
work of getting reftable to work with git proper, is disentangling
the code with assumptions about the underlying ref storage system.

I agree that some of this is reinventing the wheel, and I wish that
reftable had been based on another format (say, LevelDB) to get away
from bit mangling, but I think SQlite is a tricky proposition, because
SQLite is a system with considerable complexity of its own. You'd
force all the other Git implementations (libgit2, Microsoft's C#,
go-git, JGit, Dulwhich etc.) to find a way to implement SQLite
support. That will be a difficult proposition for the implementations that
try to avoid FFI.

You could also look at this from the positive side, which is that the
transaction semantics of reftable are much easier to understand and
verify than those of the files backend.

--
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
