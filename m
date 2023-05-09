Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C8AC77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 01:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjEIB6Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 21:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjEIB6P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 21:58:15 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942749FC
        for <git@vger.kernel.org>; Mon,  8 May 2023 18:58:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f24cfb8539so2341746e87.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 18:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597491; x=1686189491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrB4dtcbpHoFVsecFQoKnY42g6NFPHCglKNAzQRZ7Eo=;
        b=Kc3IwHiroaRWqALaSGNRJNhXrzgS0FONE2zzDcyOQgEKGJODPJpyv/ROQZp5fMhkFn
         518C9pp1E6v53Q0Zlwr34jVg0BnQWGK37OXKD4CKG40FXr7eQ5+hZDmZm2PB8DbQ3hlA
         GEEd0v5Kj7HVoH3DCJl/ni3Usnp3ZxaDkWAmL/GDrk04Ax+It/+9LvMmQVrfKqdlu2LK
         BfUbwaPL0bzputD1HQuTXqY5ddJp/LbvvZUWSYO+rdKwT4cIrNyK9TspyuqndYpnMAxm
         NGMA3DALg03sCf+eqQjJJQtsnUCRg19CIUdS0aK69BpNCAQeuU+3lceO3rKWieC9Y0yV
         /dsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597491; x=1686189491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrB4dtcbpHoFVsecFQoKnY42g6NFPHCglKNAzQRZ7Eo=;
        b=C2ctgrEieYyj6+Sm7KaH8jfmR4gVao2rUEaI/Hn/EhqDzIC/RvDwvFYyir4JKCPgD+
         vIC6+/QRxz8eNUyka14zvhe7wh/wOhAylcvCqmoKDDQzofEfnaBjFHN01JxokeDlpb6u
         bxEN77EmgmftAQ4Lbll9KSCOtimH4hfJtIQiv6X173q0Y16B849kKQ+O/zW758h/R91c
         2ONy84spfsytK7qNCvh9AnTqFcOtwRgvRRpAqROwxkurLHE/wfaIDnfr6hyVjTAG24oc
         pWFX/0C2nLj6QWhwZmimdVvcfBGi93hLD6liBUPcdbZCZFqy4twBEBajH8t02ObR+PXK
         4OLg==
X-Gm-Message-State: AC+VfDwHEf6r5VpBfuZroIlCWSx4pkLH+A6RtP8u5TMJFZfWt/ef2G/K
        FrQhLs/Qh11gxWRT1gzoDtMEYXTiXo8MLlkB7o6a/x/pEQU=
X-Google-Smtp-Source: ACHHUZ7oDJAkEn5vIPYj9YfMJuycgLzWdBxYqeJbP85fJwj4yU0AQfaI+YSCnb5Iyel4ak8fMzRhCwhz9/tpNzAl/U8=
X-Received: by 2002:a05:6512:2189:b0:4ef:ef11:e29d with SMTP id
 b9-20020a056512218900b004efef11e29dmr225645lft.68.1683597491362; Mon, 08 May
 2023 18:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com> <20230508165728.525603-1-calvinwan@google.com>
In-Reply-To: <20230508165728.525603-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 8 May 2023 18:57:59 -0700
Message-ID: <CABPp-BGTByZg5rJCmBeZNwjNTFwsoQ5HTjEhmhYFFfi-KbfgTw@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] strbuf cleanups
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2023 at 9:57=E2=80=AFAM Calvin Wan <calvinwan@google.com> wr=
ote:
>
> This reroll include suggestions made by Elijah and Junio, clarifying
> commit messages in patches 2/4/5 and s/environment variable/global
> variable in patch 7.
>
> Calvin Wan (7):
>   strbuf: clarify API boundary
>   abspath: move related functions to abspath
>   credential-store: move related functions to credential-store file
>   object-name: move related functions to object-name
>   path: move related function to path
>   strbuf: clarify dependency
>   strbuf: remove global variable
>
>  abspath.c                  |  36 +++++++++++++
>  abspath.h                  |  21 ++++++++
>  add-patch.c                |  12 +++--
>  builtin/am.c               |   2 +-
>  builtin/branch.c           |   4 +-
>  builtin/commit.c           |   2 +-
>  builtin/credential-store.c |  19 +++++++
>  builtin/merge.c            |  10 ++--
>  builtin/notes.c            |  16 +++---
>  builtin/rebase.c           |   2 +-
>  builtin/stripspace.c       |   6 ++-
>  builtin/tag.c              |   9 ++--
>  fmt-merge-msg.c            |   9 ++--
>  gpg-interface.c            |   5 +-
>  hook.c                     |   1 +
>  object-name.c              |  15 ++++++
>  object-name.h              |   9 ++++
>  path.c                     |  20 +++++++
>  path.h                     |   5 ++
>  pretty.c                   |   1 +
>  rebase-interactive.c       |  15 +++---
>  sequencer.c                |  24 +++++----
>  strbuf.c                   | 106 +++----------------------------------
>  strbuf.h                   |  53 +++++--------------
>  tempfile.c                 |   1 +
>  wt-status.c                |   6 +--
>  26 files changed, 220 insertions(+), 189 deletions(-)
>
> Range-diff against v3:
> -:  ---------- > 1:  e0dd3f5295 strbuf: clarify API boundary

Huh?  I thought v3 had this patch.  v2 certainly did, and with the
same contents.  Did you just give the wrong range for the range-diff?

Aside: Can I plug gitgitgadget for a minute?  It
  * handles the range-diff consistently
  * sets up reply-to nicely
  * ensures testing on a variety of platforms
  * makes it _trivial_ to download the series via a simple fetch, with
remote/branch/command documented in the cover letter

I think the last point is particularly cool.  Yes, I know of b4, and
it helps a lot, but a simple fetch, especially one where the cover
letter contains the command, makes things easier for someone who comes
along to review.  I know I'm happier as a reviewer when I see a patch
series sent by gitgitgadget, because of this last point.  (Granted,
folks could just copy that really nice usability touch by hand in
their cover letters if they like send-email, but I suspect it's enough
of a hassle to the sender that people just don't do it.).  Anyway,
just some food for thought.

> 1:  ec1ea6ae4f ! 2:  48fb5db28b abspath: move related functions to abspat=
h
>     @@ Metadata
>       ## Commit message ##
>          abspath: move related functions to abspath
>
>     -    Move abspath-related functions from strbuf.[ch] to abspath.[ch] =
since
>     -    paths are not primitive objects and therefore strbuf should not =
interact
>     -    with them.
>     +    Move abspath-related functions from strbuf.[ch] to abspath.[ch] =
so that
>     +    strbuf is focused on string manipulation routines with minimal
>     +    dependencies.
>
>       ## abspath.c ##
>      @@ abspath.c: char *prefix_filename_except_for_dash(const char *pfx,=
 const char *arg)
> 2:  2d74561b91 =3D 3:  a663f91819 credential-store: move related function=
s to credential-store file
> 3:  30b5e635cb ! 4:  ccef9dd5f2 object-name: move related functions to ob=
ject-name
>     @@ Commit message
>          object-name: move related functions to object-name
>
>          Move object-name-related functions from strbuf.[ch] to object-na=
me.[ch]
>     -    since paths are not a primitive object that strbuf should direct=
ly
>     -    interact with.
>     +    so that strbuf is focused on string manipulation routines with m=
inimal
>     +    dependencies.
>
>       ## object-name.c ##
>      @@ object-name.c: static void find_abbrev_len_packed(struct min_abbr=
ev_data *mad)
> 4:  6905618470 ! 5:  0d6b9cf0f7 path: move related function to path
>     @@ Metadata
>       ## Commit message ##
>          path: move related function to path
>
>     -    Move path-related function from strbuf.[ch] to path.[ch] since p=
ath is
>     -    not a primitive object and therefore strbuf should not directly =
interact
>     -    with it.
>     +    Move path-related function from strbuf.[ch] to path.[ch] so that=
 strbuf
>     +    is focused on string manipulation routines with minimal dependen=
cies.
>
>       ## path.c ##
>      @@ path.c: int normalize_path_copy(char *dst, const char *src)
> 5:  caf3482bf7 =3D 6:  5655c56a6d strbuf: clarify dependency
> 6:  3bbaebf292 ! 7:  874d0efac3 strbuf: remove environment variable
>     @@ Metadata
>      Author: Calvin Wan <calvinwan@google.com>
>
>       ## Commit message ##
>     -    strbuf: remove environment variable
>     +    strbuf: remove global variable
>
>          As a library that only interacts with other primitives, strbuf s=
hould
>     -    not utilize the comment_line_char environment variable within it=
s
>     +    not utilize the comment_line_char global variable within its
>          functions. Therefore, add an additional parameter for functions =
that use
>          comment_line_char and refactor callers to pass it in instead.
>
> --
> 2.40.1.521.gf1e218fcd8-goog

Other than the off-by-one in the range-diff of the cover letter, this
all looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
