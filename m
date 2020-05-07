Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBDFC38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01302495D
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ma2lKeQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEGSvR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 14:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbgEGSvQ (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 14:51:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DA5C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 11:51:16 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e26so7703091wmk.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 11:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=481X46v1yXWyPcuJmwCSLdfNq5DJkeSpH8A3ooN3slA=;
        b=Ma2lKeQJU8wrs9kwFg449F66x+2JhN28Ai63cHDF/sU6JcOqB1PGhU+FRYISik9Bm9
         xgVazYJlTu3UMPARoIeTiH7vxWWdx86aZYZMZz75ixuqNR5PTfhWNel0nIfPo2uSeB69
         BJy7olDCRQhEOhxK6A/veS8Q29t9yYqAGHl/HRZF7/toDI3KWnWMmRwn1Jr2KsKr1ZED
         FA5SUHMtNKCvK5L2gi0/Rs9afaktG2Midrna/xkt2aVFi4hWKDsxz+LiGjj9MTy+p/Y5
         nphY5p6n2yjIoUsgyAHHSFAt88KfjxqmPpo5ohenajfMAyP7oMcpgM9c9uN921Ivo1Cq
         87sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=481X46v1yXWyPcuJmwCSLdfNq5DJkeSpH8A3ooN3slA=;
        b=uCMbP+JBi3xBBokLtmm1Xe86sTDeSBN8s5AQcMvlacynnFl9H+tSjwTH6rDnFdTnQh
         FstP4Ac1JL4cEo3lWQXEjLlipdiL5zYkbPzM0yO8mhPSMVkj89e1vVJZ0KLRJ45WK0M/
         JbxKKkB67U1zZc6X20s7adiPZCsKePfP3tKbp1g8brbCN4yD+GBEg1qmwY9r1xIIvSsL
         RzwUGvzMt3Lru6NtfzSlVkiu5jnSVQb2jfPJqQqKqrIYLZs7OCGeKsoAfeonG7lJmVQ8
         ecV3vhxjijuJnhR+R0vHTMKzmEjFna9lneQlQtXSh6ABeuUUGd8TNl04rdIhX3xFffxI
         wOmw==
X-Gm-Message-State: AGi0PubktLWa+P2HwEsh1HCxa27suCNGNi67McM8Yir2kcpB1fHBEAPH
        u3d2R1u7R+fuFKoxWxbrgz6mjXkvgEgkDIc8ChjXLhZJEj0=
X-Google-Smtp-Source: APiQypKoxitLKJdmcxKSWuN3MGeZdclXtHzdT5R5vxlufodVJ7UX5v9ZWVdONiOopi/WXqN6Xq09OPyydbUQqJviy88=
X-Received: by 2002:a1c:4e16:: with SMTP id g22mr11210194wmh.157.1588877474009;
 Thu, 07 May 2020 11:51:14 -0700 (PDT)
MIME-Version: 1.0
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Thu, 7 May 2020 20:51:02 +0200
Message-ID: <CAFQ2z_Ne-1TWMRS88ADhzQmx4OfzNEkVUJ1anjf57mQD4Gdywg@mail.gmail.com>
Subject: How to move forward with Reftable
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have noticed that not everyone is happy with the reftable series as
it currently stands. I wanted to give some background on why it looks
the way it does today, I want to solicit feedback on where to go from
here, and share my worries about the negative feedback I=E2=80=99ve gotten =
so
far.

I manage the Gerrit team at Google. Gerrit uses refs extensively: we
have many repositories with millions of refs. To address the problems
this caused for Google, Shawn designed the reftable storage format,
and we have been running it in production since 2017. Unfortunately,
this doesn=E2=80=99t solve the problem for =E2=80=98normal=E2=80=99 deploym=
ents of Gerrit, and
this limits design choices that my team can make. To fix this, I have
implemented support for reftable on local file systems in JGit, and
want to make it a feature that is supported by core git too.

I found the implementation somewhat gnarly, which makes it an
interesting project. I thought it would be good for the ecosystem if
related projects such as libgit2 could use the same implementation, so
I wrote it as a library that is completely standalone (except for a
dependency on zlib). It was originally written in Go, translated to as
idiomatic C as I could manage. It is basically object-oriented with a
small amount of polymorphism, so it should translate relatively easily
to languages like Python.

As it currently stands, the library implements the specification
completely, including the parts that are currently probably not useful
for Git, like support for the object-ID/ref mapping. The API between
reftable and git is extremely narrow: it=E2=80=99s about 20 functions, and =
5
structure definitions. It=E2=80=99s also well tested (see coverage [2]. As =
of
today, the tests are leak-free according to valgrind). This is also
why I don=E2=80=99t believe Johannes=E2=80=99 argument that, because he fou=
nd one bug,
it must be full of bugs.

This approach has been successful, in the sense that the libgit2
project has experimented with integrating it, see
https://github.com/libgit2/libgit2/pull/5462. They seem happy at the
prospect of integrating existing code rather than reimplementing it.

Johannes had suggested that this should be developed and maintained in
git-core first, and the result could then be reused by libgit2
project. According to the libgit2 folks, this what that would look
like:

=E2=80=9C=E2=80=9D=E2=80=9D
    - It needs to be easy to split out from git-core. If it is
      self-contained in a single directory, then I'd be sufficiently
      happy already.

    - It should continue providing a clean interface to external
      callers. This also means that its interface should stay stable so
      we don't have to adapt on every update. git-core historically
      never had such promises, but it kind of worked out for the xdiff
      code.

    - My most important fear would be that the reftable interface
      becomes heavily dependent on git-core's own data types. We had
      this discussion at the Contributor's Summit already, but if it
      starts adopting things like git-core's own string buffer then it
      would become a lot harder for us to use it.

    - Probably obvious, but contained in the above is that it stays
      compilable on its own. So even if you split out its directory and
      wire up some build instructions, it should not have any
      dependencies on git-core.
=E2=80=9D=E2=80=9D=E2=80=9D

(for the discussion at the summit:
https://lore.kernel.org/git/1B71B54C-E000-4CEB-8AC6-3DB86E96E31A@jramsay.co=
m.au/)

I can make that work, but it would be good to know if this is
something the project is OK with in principle, or whether the code
needs to be completely Git-ified. If the latter happens, that would
effectively fork the code, which I think is a missed opportunity.

I have received a lot of negative comments, and I can=E2=80=99t gauge well
what to make of them, but they kindle several worries:

* The git community decides they don=E2=80=99t need the object reverse inde=
x,
and do not write =E2=80=98o=E2=80=99 section in reftables, because that cul=
ls 1000
lines of code. This generally works, but will cause hard to debug
performance regressions if command-line git is used on a gerrit
server.

* The git community looks at this, and decides the standard is too
complex, and goes off to create a reftable v3.

* The git community asks me to do a ton of superficial work (eg. slice
-> strbuf), and then decides the overall design needs to be different,
and should be completely rewritten.

Jonathan Nieder said I shouldn=E2=80=99t worry about standards compliance,
because the Git project has already ratified the reftable standard,
and wouldn=E2=80=99t want to break JGit compatibility, but it would be good=
 to
have the community leaders reaffirm this stance.

For my last worry, it would be good if someone would make an
assessment of the overall design to see if it is acceptable.

Once we have a path forward we can think of a way of integrating the
code. I think it may take a while to shake out bugs. Not bugs in the
reftable library itself, but Git is not very strict in enforcing
proper use of the ref backend abstraction (eg. pseudorefs [1]). Many
integration tests also don=E2=80=99t go through proper channels for accessi=
ng
refs.

cheers,


[1] https://lore.kernel.org/git/CAFQ2z_NZgkPE+3oazfb_m0_7TWxHjje1yYCc0bMZG0=
5_KUKEow@mail.gmail.com/

[2] https://hanwen.home.xs4all.nl/public/software/reftable-coverage/

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
