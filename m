From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 05/12] MINGW: git-compat-util.h: use inttypes.h for printf macros.
Date: Mon, 28 Apr 2014 16:53:52 +0200
Message-ID: <CABPQNSaP=q5Y4oKOM3zAMvhATZx2BDj_8s6ZO1EBFPGrtSj1Tw@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-6-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:54:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wemx4-0001zG-Jj
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:54:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbaD1Oye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:54:34 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:51349 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756407AbaD1Oyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:54:33 -0400
Received: by mail-ie0-f169.google.com with SMTP id rl12so529988iec.28
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 07:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4VjRdCeGiyvNbacc0jLzOelgN0DVHNWaf6HjGnjXP6Y=;
        b=mMQs1TTKyI2HnA9DFqXbWDCX9uv8rkEwNwJSZTJkrGgfOiJ4TanGQAEK2Ww5krvZqs
         NUgatTykZBEjzeDVc7Qlc9vm3zF9hmaGhFfNOvDsppMe/JE8jnU64eKkPgQwYdNeN+Z2
         sKe4k+u3RlPVzK8ASFkpqhnFyVrRddVWtgu1oAsk015hDkCBq+TQOFA5AK9FDc1I2Nzc
         E0cioTWQgvUGL1UE+GpOKwp4C3dtdpriyeakRg0eDx+CmMek7Dso/qr29x6Og7YraMpc
         H3E75I2IiWNl8encz7227Jwy+clrIHollbDCP7zQBkDZCgdeWNZ1eIcRTJ4OOxE69Td9
         Ja7w==
X-Received: by 10.42.204.197 with SMTP id fn5mr1183787icb.95.1398696873229;
 Mon, 28 Apr 2014 07:54:33 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 07:53:52 -0700 (PDT)
In-Reply-To: <1398693097-24651-6-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247346>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> Also, pass -D__USE_MINGW_ANSI_STDIO=0 to select MSVCRT-compatible
> macro definitions.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  compat/mingw.h    |  2 --
>  compat/msvc.h     |  3 +++
>  config.mak.uname  |  3 ++-
>  git-compat-util.h | 11 ++++++-----
>  4 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/compat/mingw.h b/compat/mingw.h
> index 262b300..c502a22 100644
> --- a/compat/mingw.h
> +++ b/compat/mingw.h
> @@ -342,8 +342,6 @@ static inline char *mingw_find_last_dir_sep(const char *path)
>  }
>  #define find_last_dir_sep mingw_find_last_dir_sep
>  #define PATH_SEP ';'
> -#define PRIuMAX "I64u"
> -#define PRId64 "I64d"
>
>  void mingw_open_html(const char *path);
>  #define open_html mingw_open_html
> diff --git a/compat/msvc.h b/compat/msvc.h
> index 580bb55..cb41ce3 100644
> --- a/compat/msvc.h
> +++ b/compat/msvc.h
> @@ -15,6 +15,9 @@
>  #define strtoull     _strtoui64
>  #define strtoll      _strtoi64
>
> +#define PRIuMAX "I64u"
> +#define PRId64 "I64d"
> +
>  static __inline int strcasecmp (const char *s1, const char *s2)
>  {
>         int size1 = strlen(s1);
> diff --git a/config.mak.uname b/config.mak.uname
> index 6c2e6df..e5edae6 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -321,6 +321,7 @@ ifeq ($(uname_S),Windows)
>         NO_PREAD = YesPlease
>         NEEDS_CRYPTO_WITH_SSL = YesPlease
>         NO_LIBGEN_H = YesPlease
> +       NO_INTTYPES_H = UnfortunatelyYes
>         NO_POLL = YesPlease
>         NO_SYMLINK_HEAD = YesPlease
>         NO_IPV6 = YesPlease
> @@ -502,7 +503,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>         NO_INET_NTOP = YesPlease
>         NO_POSIX_GOODIES = UnfortunatelyYes
>         DEFAULT_HELP_FORMAT = html
> -       COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
> +       COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
>         COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>         COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>                 compat/win32/pthread.o compat/win32/syslog.o \
> diff --git a/git-compat-util.h b/git-compat-util.h
> index f6d3a46..aa57a04 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -85,6 +85,12 @@
>  #define _NETBSD_SOURCE 1
>  #define _SGI_SOURCE 1
>
> +#ifndef NO_INTTYPES_H
> +#include <inttypes.h>
> +#else
> +#include <stdint.h>
> +#endif
> +

Just checking that I understand: Does this mean that we now require an
MSVC-version that has stdint.h? If so, I'm not against such a case.
IMO, the biggest benefit of using MSVC is not building on legacy
systems, but being able to use it's debugger. And for that purpose
it's probably OK to increase the required version.
