Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41A281F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfDWKLk (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 06:11:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39897 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfDWKLj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 06:11:39 -0400
Received: by mail-io1-f68.google.com with SMTP id c3so4566823iok.6
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o5Be07gLDlKMtsEYl8fMGkVjP8TG9QvjpIr/dFG2gsU=;
        b=qUr4cT1XDCcZZR3emueT+NUH6XLOr8Qa+7cA2meEIZ02sb9e7hFq4DDainQSs+/G68
         Ajglv7c4IjLw7AtWESfxVYEnPdMvPaY6pNP7bw9v/f+vXucTsEwLLYW9sGjq0hdlPNrX
         KvIbd7X/w/KadEMZ6HOECj9rlFQSyWmYU9odJtcEINTMVsAGOqlb2Ayk7I3HtSXejutI
         +bNC29HIqwWOPH3hoM7xedGa0TsgY/28KSggtt35Z9D7dZn5o0xpaXuOptVlVVZ3UyWI
         GT7E2Pe4qj4NCIYsUSXJOf2bSIJWaRIlZTarkjVMdz582CO3nM2mB8MF13M0QV+pEYLw
         XXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o5Be07gLDlKMtsEYl8fMGkVjP8TG9QvjpIr/dFG2gsU=;
        b=Dz5lPo1ktXGXPl8Ow0Mx/FddVfEdN4B9qoqfsmlY5p6kgFAJSOICb0cdsXJNF8EmLd
         aZ1B1GyQrLidX8Ck8GIPY+2Ck+AALYB516ySkGb1fyfx8aYNTmtkoTWiWgttQyfu+Qia
         Zj3QzGqw1AjrPLLU7l6ZAeMV2zn29lcf0ChorXI7180XXMal3og+/R6qZ75Em8rBolrh
         VkAgYMhkA6CnThZaMVc+rpGE4UJqgVISU1ug6e5xPO2rr8b8I+FQKD56J/27g4lDegYZ
         la2ZnrWcJzLIWdsuQiR8RTboVOAW2KHaOdbzuaCtcECbu/plniAeCFv1RMZbn6PNVsC8
         6lvg==
X-Gm-Message-State: APjAAAWsjklWtUSx2L4bIo4EBBnE9QOABMW2D6Rt0tPXsV/NBNPOuK/g
        oxiDQT5j0jzfps4BydBzThhy0faVeZAcuAUetQ8=
X-Google-Smtp-Source: APXvYqwpOmuS1KuUBWMQ3sPWJuONHZDl0cZAoHTIR+VA+a83KbsjqQ8zzh3Tc34rOp0EyiaXzvctf91Zi4dLHnpTzq4=
X-Received: by 2002:a05:6602:58:: with SMTP id z24mr7244514ioz.118.1556014298936;
 Tue, 23 Apr 2019 03:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
In-Reply-To: <AM6PR02MB4950BB0152893633FF95DC99EA230@AM6PR02MB4950.eurprd02.prod.outlook.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Apr 2019 17:11:12 +0700
Message-ID: <CACsJy8D5z7PRw_bFqTTFm46_6PsA4c0mwjTxHOVBGaLxbgJ7qw@mail.gmail.com>
Subject: Re: [PATCH] git-compat-util: work around for access(X_OK) under root
To:     "CHIGOT, CLEMENT" <clement.chigot@atos.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 23, 2019 at 3:41 PM CHIGOT, CLEMENT <clement.chigot@atos.net> w=
rote:
>
> On some OSes like AIX, access with X_OK is always true if launched under
> root.
> Add NEED_ACCESS_ROOT_HANDLER in order to use an access helper function.
> It checks with stat if any executable flags is set when the current user
> is root.
>
> Signed-off-by: Cl=C3=A9ment Chigot <clement.chigot@atos.net>
> ---
>  Makefile          |  8 ++++++++
>  compat/access.c   | 29 +++++++++++++++++++++++++++++
>  config.mak.uname  |  1 +
>  git-compat-util.h |  8 ++++++++
>  4 files changed, 46 insertions(+)
>  create mode 100644 compat/access.c
>
> diff --git a/Makefile b/Makefile
> index 9f1b6e8926..513d835d01 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -439,6 +439,9 @@ all::
>  #
>  # Define FILENO_IS_A_MACRO if fileno() is a macro, not a real function.
>  #
> +# Define NEED_ACCESS_ROOT_HANDLER if access() with X_OK returns always t=
rue
> +# when launched as root.
> +#
>  # Define PAGER_ENV to a SP separated VAR=3DVAL pairs to define
>  # default environment variables to be passed when a pager is spawned, e.=
g.
>  #
> @@ -1833,6 +1836,11 @@ ifdef FILENO_IS_A_MACRO
>         COMPAT_OBJS +=3D compat/fileno.o
>  endif
>
> +ifdef NEED_ACCESS_ROOT_HANDLER
> +       COMPAT_CFLAGS +=3D -DNEED_ACCESS_ROOT_HANDLER
> +       COMPAT_OBJS +=3D compat/access.o
> +endif
> +
>  ifeq ($(TCLTK_PATH),)
>  NO_TCLTK =3D NoThanks
>  endif
> diff --git a/compat/access.c b/compat/access.c
> new file mode 100644
> index 0000000000..e4202d4585
> --- /dev/null
> +++ b/compat/access.c
> @@ -0,0 +1,29 @@
> +#include "../git-compat-util.h"
> +
> +/* Do the same thing access(2) does, but use the effective uid and gid,
> +   and don't make the mistake of telling root that any file is
> +   executable.  This version uses stat(2). */
> +int git_access (const char *path, int mode)
> +{
> +       struct stat st;
> +       uid_t euid =3D geteuid();
> +       uid_t uid =3D getuid();
> +
> +       if (stat(path, &st) < 0)
> +               return -1;
> +
> +       if (!(uid) || !(euid)) {
> +               /* Root can read or write any file. */
> +               if (!(mode & X_OK))
> +                       return 0;
> +
> +               /* Root can execute any file that has any one of the exec=
ute
> +                  bits set. */
> +               if (st.st_mode & (S_IXUSR | S_IXGRP | S_IXOTH))
> +                       return 0;
> +               errno =3D EACCES;
> +               return -1;
> +       }
> +
> +       return access(path, X_OK);

Do you need an #undef to cancel out the "#define access git_access"
line in git-compat-util.h (or "access" is still not redefined here,
how)?

#undef would screw things up though if the original access is also a
macro. But I guess that's much less likely since this compat code is
only enabled in selected platforms.

> +}
> diff --git a/config.mak.uname b/config.mak.uname
> index 86cbe47627..ce13ab8295 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -270,6 +270,7 @@ ifeq ($(uname_S),AIX)
>         NEEDS_LIBICONV =3D YesPlease
>         BASIC_CFLAGS +=3D -D_LARGE_FILES
>         FILENO_IS_A_MACRO =3D UnfortunatelyYes
> +       NEED_ACCESS_ROOT_HANDLER =3D UnfortunatelyYes
>         ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
>                 NO_PTHREADS =3D YesPlease
>         else
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 31b47932bd..bb8df9d2e5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -1242,6 +1242,14 @@ int git_fileno(FILE *stream);
>  # endif
>  #endif
>
> +#ifdef NEED_ACCESS_ROOT_HANDLER
> +#ifdef access
> +#undef access
> +#endif
> +#define access git_access
> +extern int git_access(const char *path, int mode);
> +#endif
> +
>  /*
>   * Our code often opens a path to an optional file, to work on its
>   * contents when we can successfully open it.  We can ignore a failure
> --
> 2.17.1
>
>
>
> Cl=C3=A9ment Chigot
> ATOS Bull SAS
> 1 rue de Provence - 38432 =C3=89chirolles - France



--=20
Duy
