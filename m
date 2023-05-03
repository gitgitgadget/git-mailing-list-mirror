Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A1C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 02:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjECChS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 22:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECChO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 22:37:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27A830E2
        for <git@vger.kernel.org>; Tue,  2 May 2023 19:37:09 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4efea4569f5so5282526e87.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 19:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683081428; x=1685673428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b0xlYrr/Ld9+upShOl79DrdPTQaMc5hNppVDtjXQU4=;
        b=b6OIamsvs2/bGh5T+yKYoC1Gh3uOhoS20I3MEefur8LUgnHNtEhkv646ZjqfLEXwdl
         HpoMe2fydhNzP9dLRX9RGzTguwduv9iS97a/44Uy61fcGRnybFlSnPDLgbTb1hAsORha
         Tx8u+lhj7qjpvZW/pyAZyNkZwUl8TJROomAmEkEMhBNHdbINEtXQAz+kairBfP7xISBU
         waMeFqHtoK6pazMQyH4eersAs9kA6t6jVmdSEy9anPjwApnXgDJYN3r9CTWfLn+PJNBT
         cZaLCzUBkWK4BK77Q57dmWz2RZD/zfozjjb8qBbyvUbCUS2cLSBRISuSwvap7Ly4eVtB
         emig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683081428; x=1685673428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b0xlYrr/Ld9+upShOl79DrdPTQaMc5hNppVDtjXQU4=;
        b=facoUipqarVuJ1AJt5vzy7k0hvH5MQgGf0ik6G42cN43oN3VWWofsI5qNdusk+I/ab
         fT3pqbuJhvpVyacgi2hsPFKK/f0cON+cNRSOUPw3FVhO6YV0Yu0wbLo2WU1yFXaAfkOT
         iQoameSIPsuqSta2foyS1u0oPx9lAU550cSIWuPHhmABL1vwHfPMyBi1dces4jcguNtj
         s7KfJT7OsEE7DwekFtI03zhbPCB7cij6xuCA2x5TY7f4j3OL7Hftc31usJll5FZBk4UI
         BeDNg2SLUj7NtOG3DegHEHIPqxJzsmT+cLuM/uyq8FB7/txfvkqI8vppcQRc7oiam308
         dDvA==
X-Gm-Message-State: AC+VfDxg3NELKp3yipLsWJzEjqgjUQajfKucGosAXdR7cHf3Y2ft3Z0D
        JXQX6I0aA4YX1+oM2c6dvQWWbK7igS9JfcOlV37h1Dba
X-Google-Smtp-Source: ACHHUZ5ymq3lmhbIpq/2KQKyHamA5yXhneIzDpArKRdQvFBuFhunOjtAZu/H30KRUyvk4Z5bVP+sXVn13Tqbdv7yWwE=
X-Received: by 2002:ac2:4468:0:b0:4dc:82b0:4c68 with SMTP id
 y8-20020ac24468000000b004dc82b04c68mr436647lfl.50.1683081427885; Tue, 02 May
 2023 19:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230502211454.1673000-1-calvinwan@google.com>
In-Reply-To: <20230502211454.1673000-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 19:37:00 -0700
Message-ID: <CABPp-BFagTvBTe0XbEOM_hO-vDFwVvSSmGOii1q2=7amqerwtQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] strbuf cleanups
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 2:15=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
>
> Strbuf is a basic structure that should function as a low-level library
> due to how generic it is. Over time certain functions inside of
> strbuf.[ch] have been added with dependencies to higher level objects
> and functions. This series cleans up some of those higher level
> dependencies by moving the offending functions to the files they
> interact with. With the goal of eventually being able to stand up strbuf
> as a libary, this series also removes the use of environment variables
> from strbuf.
>
> Calvin Wan (6):
>   abspath: move related functions to abspath
>   credential-store: move related functions to credential-store file
>   object-name: move related functions to object-name
>   path: move related function to path
>   strbuf: clarify dependency
>   strbuf: remove environment variables
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
>  strbuf.h                   |  44 ++-------------
>  tempfile.c                 |   1 +
>  wt-status.c                |   6 +--
>  26 files changed, 213 insertions(+), 187 deletions(-)
>
> --
> 2.40.1.495.gc816e09b53d-goog

The series looks pretty good to me.  I left a couple small comments on
5/6 and 6/6.  One other high-level note:

As =C3=86var noted over at
https://lore.kernel.org/git/230501.86a5yohsme.gmgdl@evledraar.gmail.com/,
strbuf_add_separated_string_list() is currently only used by
merge-ort.c and merge-recursive.c (both of which include
merge-recursive.h).  It may make sense to move that function, and that
would permit you to drop the forward declaration of 'struct
string_list;' from strbuf.c as well.
