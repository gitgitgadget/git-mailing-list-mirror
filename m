Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45401C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 12:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1275620661
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 12:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvIjJnfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgBAMeQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 07:34:16 -0500
Received: from mail-il1-f180.google.com ([209.85.166.180]:40318 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBAMeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 07:34:16 -0500
Received: by mail-il1-f180.google.com with SMTP id i7so8651477ilr.7
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=9LPRCqjW1MJooA31ZCgehUio7C3DUHwCcb+ii7hJgyg=;
        b=dvIjJnfoxF3uN0d337/ElG8qpgD82ZfujpNF8OuDGor+HscCE9ZmwDj3jI4ln3Kl50
         wdA+xrAgtINXtyxbqg5zZNFtmr/nz9keMe49hP/O5s70V0qzTwkdQ8itmd3gtsY1syZz
         E2Tc4DFeNuGVCNDjfEs4TlF8kLqkh87qJxTyDRyteUcviT8QC/WwYEpD9KfVQ5XqUdCR
         w4ComYw3UU2vzplBMt/1JhVLnXxZOGUP8mX0gfEYYiTvVxo7BlKBEuO+1indGq0W/Bse
         DeUbEyGpZpkXsv86YRQb7F+SUTmFBmfJkzzccn8oXW440TfGh4pCT7nJopNgYPevpqlr
         4Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=9LPRCqjW1MJooA31ZCgehUio7C3DUHwCcb+ii7hJgyg=;
        b=m1h9/Jg5REYJAM6oJ4km+IOdt80G3jp99+lEtmdVpdnEjNYmizOMVDCs3Xjq5HKfiQ
         XhnA1C3+Fk1im0FBUIXQ3ZCgLnj5+RZBt6koE3aS2sRwB271EcTPUHOYdcCmGEdbn3Gx
         zxO2UonFTySr2ib6LcGuPcmg6r//6UVlMlEnM+bd8uvyY6fhthyZ51iI3SeEh533Y+Ky
         dvTpy8p+QSc+5Pe9x9l5IfUlylRiiPQyQvNWgRcqfm2a/MYxN8lHnP/Rp4r4zyMRITFP
         JN2gONgJ/oKFrVpezXoZ5x15AUOJDqL2ngmaPXxHEMwyUa6cbgCZMjVYo2eVDLAJvGwq
         i8eA==
X-Gm-Message-State: APjAAAUxoyjUTix0J7OwaNWZRU0DTYzwFe0QJtQAKwTHBFdefi2RHwuF
        ZJ+UkdFYlJaxPTY3tjgnCSObs3qgp5renoFpriBmECwh
X-Google-Smtp-Source: APXvYqwnW9edSncWXwD0T3v5hIicLP0QwgIBvn9Kaoa42W8krgORkZ3WO3f7HSgcBDo2KYaHWBIxoo9UyvDdPqRh2e0=
X-Received: by 2002:a92:9857:: with SMTP id l84mr7121219ili.41.1580560453883;
 Sat, 01 Feb 2020 04:34:13 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
 <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
In-Reply-To: <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 1 Feb 2020 07:34:03 -0500
Message-ID: <CAH8yC8noefVsnK1cGipub3vmpq0iK3bwJDaWbiaFhJGGtNzHWw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGdpdC1jb21wYXQtdXRpbC5oOjc5ODoxMzogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cA==?=
        =?UTF-8?B?ZXMgZm9yIOKAmGluZXRfbnRvcOKAmQ==?=
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 1, 2020 at 7:12 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> On Sat, Feb 1, 2020 at 6:39 AM Jeffrey Walton <noloader@gmail.com> wrote:
> >
> > I'm building the 2.25 release tarball on Solaris 11.3 i86pc. I'm
> > catching an error:
> >
> > $ gmake
> >     CC fuzz-commit-graph.o
> > In file included from commit-graph.h:4:0,
> >                  from fuzz-commit-graph.c:1:
> > git-compat-util.h:798:13: error: conflicting types for =E2=80=98inet_nt=
op=E2=80=99
> >  const char *inet_ntop(int af, const void *src, char *dst, size_t size)=
;
> >              ^
> > In file included from git-compat-util.h:226:0,
> >                  from commit-graph.h:4,
> >                  from fuzz-commit-graph.c:1:
> > /usr/include/arpa/inet.h:43:20: note: previous declaration of
> > =E2=80=98inet_ntop=E2=80=99 was here
> >  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
> >                     ^
> > gmake: *** [fuzz-commit-graph.o] Error 1
> >
> > And:
> >
> > $ cat -n /usr/include/arpa/inet.h
> > ...
> >     41  #if !defined(_XPG4_2) || defined(_XPG6) || defined(__EXTENSIONS=
__)
> >     42  extern int inet_pton(int, const char *_RESTRICT_KYWD, void
> > *_RESTRICT_KYWD);
> >     43  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
> >     44                          char *_RESTRICT_KYWD, socklen_t);
> >     45  #endif /* !defined(_XPG4_2) || defined(_XPG6) ||
> > defined(__EXTENSIONS__) */
>
> According to Sun's man pages:
>
> inet(3SOCKET)              Sockets Library Functions             inet(3SO=
CKET)
>
> NAME
>        inet,  inet6, inet_ntop, inet_pton, inet_aton, inet_addr, inet_net=
work,
>        inet_makeaddr, inet_lnaof, inet_netof,  inet_ntoa  -  Internet  ad=
dress
>        manipulation
>
> SYNOPSIS
>        cc [ flag... ] file... -lsocket  -lnsl  [ library... ]
>        #include <sys/socket.h>
>        #include <netinet/in.h>
>        #include <arpa/inet.h>
>
> Maybe the include should be <arpa/inet.h> on Sun systems?

This may be part of the issue, too.

    checking for socket in -lc... no
    checking for inet_ntop... no
    checking for inet_ntop in -lresolv... no
    checking for inet_pton... no
    checking for inet_pton in -lresolv... no

-lsocket  -lnsl should probably be tested.

Jeff
