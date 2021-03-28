Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D607CC433E1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 00:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA85E6199E
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 00:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhC1ATg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Mar 2021 20:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhC1ATF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Mar 2021 20:19:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCEFBC0613B1
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 17:19:00 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z136so9137760iof.10
        for <git@vger.kernel.org>; Sat, 27 Mar 2021 17:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xZRo/fPPu/BsHEC5+SefWBHx7Z7MncXV9rUx8+2OqZU=;
        b=E/ZQ1UuAp2s/6z/psEYHOK4ZdZ2Wn6bRhDkPgNHYWDljoO5Ag8ONr8wMKk+u+1kk0j
         zf5t7NlWgZRhWoT01jfdotAlgr/zmuDflHtFhEKwoduhZ9y3oky0ujL6aoW87y6zaQUx
         xv8KiFjDWGlaRq6edHKxVCcENG16BCyc3rvU+UUuC8RQNAYGzp3Mvh2FEapM3GtplppM
         GjaQw1MFHUgAZFspA17iFRpBd9Q1h4w0/2PjCmw6BzArZ2Q9wEJkcFi7W0QK6o/3zyrA
         WrrasYNC5CiPgOpwkhw7yKB8j98zckq/JeNypm3GnFKvJAVCIAbgnU6x4ZJLSu9FYe89
         d+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xZRo/fPPu/BsHEC5+SefWBHx7Z7MncXV9rUx8+2OqZU=;
        b=BZk7QkWNfujGrVjUUQSjOll84IVr/dNWZLNNLjLwxcm8sebAJcAgVFiK62AmtESsuj
         rJ7cicuQDhTWTw4xVDOG/4DubJnBwKt1E0Xhit/+GYVs50fmSf+93ikQ4QPhqabAFWmV
         vLXMh1emg4mfzBcEL/bWYOGDYdsf/4NkZNB9zuwIyTiRPKE7YH29tN3vG8MWprK79kpk
         UBIZAxSkDRvhRIqbL7ejsqziluTGnKFjwIxF0gvrXaeBKsCxJkU3Wm+JAuFDw2qnGG6E
         FhlDM6fSWpcWEcnPQjBbpbUoG+WpaVlzRwqOo2uIfHmXrrHNT7avTjGOfHnWoDJ2oFrx
         cMNw==
X-Gm-Message-State: AOAM533O8eDEZzmz/SXhlzFBBoBOhQ3g7QgG7i540jj/4HJf6aj89uig
        24Xmh+Ed51Ww2YrCFzqr65Ut4+/gZEFLR4WN5BLIlpKTIAGAeA==
X-Google-Smtp-Source: ABdhPJygdVCqrJU8V2I7KFQWQbXwj2HgceGE+oGMC7TzatAiVurc13saxTRhximRtP8d7tDPpVOcborgmoNgZdgPOow=
X-Received: by 2002:a02:6a5a:: with SMTP id m26mr17854714jaf.17.1616890739046;
 Sat, 27 Mar 2021 17:18:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Sat, 27 Mar 2021 20:18:37 -0400
Message-ID: <CAH8yC8nUpHP4iX-iQqMqX4wR6sMZO2MQv9fBVVTSys67_oGX0A@mail.gmail.com>
Subject: Git 2.31.1, Solaris and error: conflicting types for 'inet_ntop'
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I'm building the latest Git on Solaris 11.3. I use this patch for
Solaris: https://github.com/noloader/Build-Scripts/blob/master/patch/git.patch.
It ensures -lresolv -lsocket -lnsl (in that order).

The build is having some trouble:

/bin/gcc -o kwset.o -c -MF ./.depend/kwset.o.d -MQ kwset.o -MMD -MP
-I/usr/local/include -DNDEBUG -DNO_UNALIGNED_LOADS=1 -g2 -O2 -m64
-march=native -fPIC -pthread -I. -D__EXTENSIONS__ -D__sun__
-DGIT_HOST_CPU="\"i86pc\"" -DUSE_LIBPCRE2 -I/usr/local/include
-DHAVE_ALLOCA_H -I/usr/local/include -DUSE_CURL_FOR_IMAP_SEND
-I/usr/local/include -I/usr/local/include -I/usr/local/include
-I/usr/local/include -DNO_D_TYPE_IN_DIRENT -DNO_INET_NTOP
-DNO_INET_PTON -DSHA1_DC -DSHA1DC_NO_STANDARD_INCLUDES
-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0
-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\""
-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
-DSHA256_BLK  -DHAVE_PATHS_H -DHAVE_LIBCHARSET_H -DHAVE_STRINGS_H
-DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DHAVE_CLOCK_MONOTONIC
-DHAVE_GETDELIM  -DFREAD_READS_DIRECTORIES -Icompat/regex
-DSHELL_PATH='"/bin/bash"' -DPAGER_ENV='"LESS=FRX LV=-c"'  kwset.c
In file included from cache.h:4:0,
                 from json-writer.c:1:
git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
             ^
In file included from cache.h:4:0,
                 from ident.c:8:
git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
             ^
In file included from git-compat-util.h:226:0,
                 from cache.h:4,
                 from ident.c:8:
/usr/include/arpa/inet.h:43:20: note: previous declaration of
'inet_ntop' was here
 extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
                    ^
In file included from git-compat-util.h:226:0,
                 from cache.h:4,
                 from json-writer.c:1:
/usr/include/arpa/inet.h:43:20: note: previous declaration of
'inet_ntop' was here
 extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
                    ^
In file included from cache.h:4:0,
                 from hex.c:1:
git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
             ^
In file included from git-compat-util.h:226:0,
                 from cache.h:4,
                 from hex.c:1:
/usr/include/arpa/inet.h:43:20: note: previous declaration of
'inet_ntop' was here
 extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
                    ^
In file included from cache.h:4:0,
                 from kwset.c:35:
git-compat-util.h:823:13: error: conflicting types for 'inet_ntop'
 const char *inet_ntop(int af, const void *src, char *dst, size_t size);
             ^
In file included from git-compat-util.h:226:0,
                 from cache.h:4,
                 from kwset.c:35:
/usr/include/arpa/inet.h:43:20: note: previous declaration of
'inet_ntop' was here
 extern const char *inet_ntop(int, const void *_RESTRICT_KYWD,
                    ^
gmake: *** [hex.o] Error 1

Jeff
