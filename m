From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 09/12] MINGW: config.mak.uname: drop -DNOGDI
Date: Mon, 28 Apr 2014 16:56:45 +0200
Message-ID: <CABPQNSYdsCBXbp5GY_3WT5xvQ0wuAxS8b0auduqipsNkWJW=fA@mail.gmail.com>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org> <1398693097-24651-10-git-send-email-marat@slonopotamus.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 16:57:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wemzs-0005SL-0T
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 16:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbaD1O51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 10:57:27 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:46607 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbaD1O5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 10:57:25 -0400
Received: by mail-ig0-f176.google.com with SMTP id uy17so4842641igb.3
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zmnd6gui25XnbmRnUuel1/q0QAm9It8KMEmcpnk9Xe8=;
        b=0m2gEKNEf7fC632hRJppywsRzz8iueHb8OuVte6zVAnMCI/i7OQUUuVey1nv49kLdG
         qgYpQ8rnZlmxDFMlLpw+y7mg/9CZiy6D+RzBvuDFR+uG4G8WY8L9LQEuRRh94k4jSPYf
         nEFP2QumJA0NzgLwuOMV7IbKUJGHJKgQ3jZCsVcfU/rZ+MJmPqPEzCfVBCtoH9qF7JIW
         uetv1BsywJ53bnHX76moTqtq2zPhwNBygEvE/nCa9GL0+5qOjN4ZtBtaJC05mZXMQmU9
         KC7YGZXAoVSzw1kxeC9IB+z8956fZwxt/vz7gQ8dXyo/0V5EjaqwsLwWEXiGlpZrJTI1
         H8RQ==
X-Received: by 10.50.36.66 with SMTP id o2mr24233232igj.24.1398697045212; Mon,
 28 Apr 2014 07:57:25 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Mon, 28 Apr 2014 07:56:45 -0700 (PDT)
In-Reply-To: <1398693097-24651-10-git-send-email-marat@slonopotamus.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247348>

On Mon, Apr 28, 2014 at 3:51 PM, Marat Radchenko <marat@slonopotamus.org> wrote:
> On MinGW-W64, MsgWaitForMultipleObjects is guarded with #ifndef NOGDI.
>
> Unfortunately, including wingdi.h brings in #define ERROR 0 which
> conflicts with several Git internal enums. So, #undef ERROR.
>
> Signed-off-by: Marat Radchenko <marat@slonopotamus.org>
> ---
>  config.mak.uname  | 4 ++--
>  git-compat-util.h | 2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index a376b32..4883fd5 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -363,7 +363,7 @@ ifeq ($(uname_S),Windows)
>         COMPAT_OBJS = compat/msvc.o compat/winansi.o \
>                 compat/win32/pthread.o compat/win32/syslog.o \
>                 compat/win32/dirent.o
> -       COMPAT_CFLAGS = -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
> +       COMPAT_CFLAGS = -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
>         BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
>         EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib invalidcontinue.obj
>         PTHREAD_LIBS =
> @@ -503,7 +503,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
>         NO_INET_NTOP = YesPlease
>         NO_POSIX_GOODIES = UnfortunatelyYes
>         DEFAULT_HELP_FORMAT = html
> -       COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -DNOGDI -Icompat -Icompat/win32
> +       COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -D__USE_MINGW_ACCESS -D_USE_32BIT_TIME_T -Icompat -Icompat/win32
>         COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
>         COMPAT_OBJS += compat/mingw.o compat/winansi.o \
>                 compat/win32/pthread.o compat/win32/syslog.o \
> diff --git a/git-compat-util.h b/git-compat-util.h
> index aa57a04..48bf0f7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -98,6 +98,8 @@
>  #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
>  #include <winsock2.h>
>  #include <windows.h>
> +/* wingdi.h defines ERROR=0, undef it to avoid conflicts */
> +#undef ERROR
>  #define GIT_WINDOWS_NATIVE
>  #endif

Perhaps it would be cleaner to just undef NOGDI in compat/poll/poll.c?
That way we don't end up pulling in all kinds of unrelated GUI-stuff
into places where they're not needed...?
