Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4423C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 06:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjDFGSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjDFGSt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 02:18:49 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7328A68
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 23:18:48 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id k17so45082545ybm.11
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 23:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680761927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAsYdxEW50I5iO8fTrpUqdNbe8brZY4ftyANnx2rJOc=;
        b=hSryqaqlxz5K8UQl669L/79CMXicZwEdE+tzu3V2sz+8ESTTPP9DIoRWIItjMnQd4x
         XP2R8QxcrVEqSQC2iG2TLguXu0zGj4N5hpBlvCP3sVFKi1GwO2c1WM72+J70w7WYuIJ3
         qwymnB8rnEqD19DXCnRc1rR6231xhvBwFHYiznyEV5LBBTStHgbtZFgGkH5uL/gWHJw6
         VHEsKG6pLfnYutEugM5mftacVdgpvjlDo/cO+BSaE1E4/P9PtQFfPpKbmka7h3eJUXhF
         Fu38BQ9+K/31gZDXHp76vaMQWz05HcAcoooT0rc+Cii59fXoDE1cYhfbrmHAXljkkQVc
         lw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680761927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAsYdxEW50I5iO8fTrpUqdNbe8brZY4ftyANnx2rJOc=;
        b=sKitD9OjP2DjP81l21n/Li3jnvBHXMHHDG++45sEPyTw7JZm8sfyq/lRZKiY6TaCJZ
         W9NJRokCAhMwWe0C1ER4wrS5IcuSnKkWnVQXV5eescKziIJJb4Byoins9QRGdLzzCu0I
         IcbSH7zKag6QryFrXsapgP/HRA5qyGBhh8xFSu1eSBnjbSde97qtzhIsR8eXiJ8S05FP
         co1XUyjMURShYcTbUVCHzjTn7ZjlbyEy01dB18p4dMCsa333PC+Oc/xoLn5AlINPYRV6
         lUptoKFmrHjZq4XYdITfThlvycFP/2idYPrneLYV/Sp7zXAW/gUjSu3f65/Ue4eX2OyG
         pz9w==
X-Gm-Message-State: AAQBX9dbZtFvK/19DRdEAn7pqhWPQZz3aXzUASOXcaVo4nr9M8dt0XR4
        0c3R8E0ztcfdqg4PwcMT7dbpn0/AbwfH1aYpQuw=
X-Google-Smtp-Source: AKy350bZs6Xax90xpgy2uWB3/cy0mpV0VpjeytkwlZGuc01igNmUxDe1Lwrni5p4Y3EUlO3ZyHDxD+iqWg8w6JUjJn0=
X-Received: by 2002:a25:d28b:0:b0:b45:5cbe:48b3 with SMTP id
 j133-20020a25d28b000000b00b455cbe48b3mr1417445ybg.0.1680761927487; Wed, 05
 Apr 2023 23:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230323221523.52472-1-felipe.contreras@gmail.com> <20230406035729.GA2092667@coredump.intra.peff.net>
In-Reply-To: <20230406035729.GA2092667@coredump.intra.peff.net>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 6 Apr 2023 01:18:36 -0500
Message-ID: <CAMP44s2u4tj7hUZHZ9H4qsJGp1a=Y=YUTBAxmSzftdfHX_HqwQ@mail.gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2023 at 10:57=E2=80=AFPM Jeff King <peff@peff.net> wrote:
>
> On Thu, Mar 23, 2023 at 04:15:23PM -0600, Felipe Contreras wrote:
>
> > In 2007 we added a custom header macro to provide version information
> > 7ef195ba3e (Documentation: Add version information to man pages,
> > 2007-03-25),
> >
> > However, in 2008 asciidoc added the attributes to do this properly [1].
> >
> > This was not implemented in Git until 2019: 226daba280 (Doc/Makefile:
> > give mansource/-version/-manual attributes, 2019-09-16).
> >
> > But in 2023 we are doing it properly, so there's no need for the custom
> > macro.
> >
> > [1] https://github.com/asciidoc-py/asciidoc-py/commit/ad78a3c
>
> This should be OK to do, as it is just touching the python asciidoc
> side. When we discussed those attributes in 2019:
>
>   https://lore.kernel.org/git/20190320183229.GK31362@pobox.com/
>
> asciidoctor support was new and incomplete. It needed v1.5.7 (from
> 2018),

Except that isn't true.

The `manmanual` and `mansource` attributes were supported since day 1
[1], back in 2015 and included in v1.5.3. But for the manpage backend,
which we refuse to use.

It's true they were added in 2018 and in v1.5.7 for the docbook5
backend [2], which is what we use when we do USE_ASCIIDOCTOR=3Dy, but we
could have used the manpage backend instead, which already had support
for that 3 years prior.

> and even today still does not seem to handle manversion.

Why do we need `manversion`?

All that it's used for is in the DocBook Stylesheets to join the
source name and the version, even its own documentation explains what
it looks like in practice [3]:

  In practice, there are many pages that simply have a version number
in the "source" field. So, it looks like what we have is a two-part
field, Name Version

So if we have `source=3D"Git"`, and `version=3D"2.4.0"`, we can just have
`source=3D"Git 2.40.0"`.

Why do we have to split that information only for the DocBook
Stylesheets to join it in?

>   Aside: If we think asciidoctor 1.5.7 is recent enough to rely on, then
>   we might want to simplify our hack to just output manversion.

There is no need for any hack: we can just set the "mansource"
attribute to "Git $(GIT_VERSION)", and everything will work correctly
for both asciidoc and asciidoctor in all backends.

Why do we insist on hacks for asciidoc.py/2007 and asciidoc|docbook5/2017?

Especially when I sent the fix for *everything* in 2021 [4].

This is absolutely no reason to complicate the joining of two strings this =
much.

Cheers.

[1] https://github.com/asciidoctor/asciidoctor/commit/7bddc416
[2] https://github.com/asciidoctor/asciidoctor/commit/6b07b0ba
[3] https://docbook.sourceforge.net/release/xsl/current/doc/common/template=
.get.refentry.source.html
[4] https://lore.kernel.org/git/20210514121435.504423-7-felipe.contreras@gm=
ail.com/

--=20
Felipe Contreras
