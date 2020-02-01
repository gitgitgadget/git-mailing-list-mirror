Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4944C33C9E
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 12:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE42A206D3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 12:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiRoSFBx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgBAMMd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 07:12:33 -0500
Received: from mail-il1-f178.google.com ([209.85.166.178]:38492 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgBAMMd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 07:12:33 -0500
Received: by mail-il1-f178.google.com with SMTP id f5so8623437ilq.5
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 04:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=yMFCkUDInQPRXvTJSEKcDcn6dVSfmQOa/y5missGLRs=;
        b=kiRoSFBxOIPlALsPVqmXXBJ8a2ovl/34pQptRPr3YrO0MdYXgtBSDJzpdacANIDdpU
         ztsLa1qzGIT+n03VFglUxuFWqwHXGWGRwtHaU9EefW/nsMIIOvPv12aNlKog3yDM+Zq6
         klV78CEGYACakH2eFaEUcUQBPGWX4QTzoKtl0z5kAUiSaiphyeBGit6wT6pxfvu6hRQh
         xwcepKDFvHsrLL3uqJERTFCSRST9Vp+g7ClApEl8Z7St4byjcUpWIPQkmt7ZySeAKl/I
         g60Ufs4YC4bh1T7MkYvOQOFYUDSRQK4MSJfeJY9vB52GdPhBEYpVw59+dPh5J7pau5B6
         JEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=yMFCkUDInQPRXvTJSEKcDcn6dVSfmQOa/y5missGLRs=;
        b=kQ/yd8l2+KdwQMZb6x4Y17QphTpUg2JCErGhtN1dI06/Lh7pGuKHPlMPVPaEe0QyhV
         dc/249yLPhrPs4HjyMYrZHdPvouN6ndTCJNXbA7mXwIMwAwHIQB9k4SebH0Ww7ANvLKX
         Mp42zxylmr9Wr287nZIA2LmttDgzhjVfnil4QErAybmufzh0UVdB1juLX8eTeRAd2k3H
         3BdwiOSHFJWIVJ0j+WKdKUbZAzALfGuHyTk+54/peMO15baP2TtJtwVR3nTyOCpDRTu1
         8DM+ND3WibF+RRxHt0lBegiuvzxxxoEiJtoS7lNfX4QK5+HL2OFD/o82+e6H4erF8zfg
         D5Yg==
X-Gm-Message-State: APjAAAWlgY4lyN+qOLwB7NW3hSRWzujHFWY3d6591fCUeWY1IxT6Z18D
        ls+KGS8BmdAelxYQ7gbFzfoukFW84Q/37mwq19fmdVF7
X-Google-Smtp-Source: APXvYqy4TJEML1KbfXEAg+36yYOwENXupbjPWg7Yf4datXQh8nz4wdgtlSCTI063rqE0mu6UP0olWoNWUDasn0vIBRc=
X-Received: by 2002:a92:8847:: with SMTP id h68mr13529865ild.212.1580559152166;
 Sat, 01 Feb 2020 04:12:32 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
In-Reply-To: <CAH8yC8m3JFvEcfFF3z1rrRnEPK-adHGObmkOhNZiph7QJKUWqA@mail.gmail.com>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 1 Feb 2020 07:12:21 -0500
Message-ID: <CAH8yC8mh0gysNz3Dbrph0f8KZ8DEWaH-6rWg6fSOD-_aGh3=3A@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGdpdC1jb21wYXQtdXRpbC5oOjc5ODoxMzogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cA==?=
        =?UTF-8?B?ZXMgZm9yIOKAmGluZXRfbnRvcOKAmQ==?=
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 1, 2020 at 6:39 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> I'm building the 2.25 release tarball on Solaris 11.3 i86pc. I'm
> catching an error:
>
> $ gmake
>     CC fuzz-commit-graph.o
> In file included from commit-graph.h:4:0,
>                  from fuzz-commit-graph.c:1:
> git-compat-util.h:798:13: error: conflicting types for =E2=80=98inet_ntop=
=E2=80=99
>  const char *inet_ntop(int af, const void *src, char *dst, size_t size);
>              ^
> In file included from git-compat-util.h:226:0,
>                  from commit-graph.h:4,
>                  from fuzz-commit-graph.c:1:
> /usr/include/arpa/inet.h:43:20: note: previous declaration of
> =E2=80=98inet_ntop=E2=80=99 was here
>  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
>                     ^
> gmake: *** [fuzz-commit-graph.o] Error 1
>
> And:
>
> $ cat -n /usr/include/arpa/inet.h
> ...
>     41  #if !defined(_XPG4_2) || defined(_XPG6) || defined(__EXTENSIONS__=
)
>     42  extern int inet_pton(int, const char *_RESTRICT_KYWD, void
> *_RESTRICT_KYWD);
>     43  extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
>     44                          char *_RESTRICT_KYWD, socklen_t);
>     45  #endif /* !defined(_XPG4_2) || defined(_XPG6) ||
> defined(__EXTENSIONS__) */

According to Sun's man pages:

inet(3SOCKET)              Sockets Library Functions             inet(3SOCK=
ET)

NAME
       inet,  inet6, inet_ntop, inet_pton, inet_aton, inet_addr, inet_netwo=
rk,
       inet_makeaddr, inet_lnaof, inet_netof,  inet_ntoa  -  Internet  addr=
ess
       manipulation

SYNOPSIS
       cc [ flag... ] file... -lsocket  -lnsl  [ library... ]
       #include <sys/socket.h>
       #include <netinet/in.h>
       #include <arpa/inet.h>

Maybe the include should be <arpa/inet.h> on Sun systems?

I was able to hack around it with the following after configure:

    # Solaris 11.3 work-around. The OS has inet_ntop and inet_pton
    for file in $(find "$PWD" -name 'Makefile')
    do
        sed '/ifdef NO_INET_NTOP/,+3 d' "$file" > "$file.fixed"
        mv "$file.fixed" "$file"
        sed '/ifdef NO_INET_PTON/,+3 d' "$file" > "$file.fixed"
        mv "$file.fixed" "$file"
    done

Jeff
