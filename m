From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [v3RFC] systemd socket activation support
Date: Fri, 3 Apr 2015 19:06:14 -0400
Message-ID: <CAPig+cTFRz=b=hdsuP_v_1jzu9-utGEWQM_rkhpEBvq-chrZig@mail.gmail.com>
References: <1428100224-29441-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Shawn Landden <shawnlandden@gmail.com>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 01:06:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeAfM-00020C-RI
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 01:06:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbbDCXGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 19:06:17 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:36198 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbDCXGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 19:06:16 -0400
Received: by lagv1 with SMTP id v1so11238438lag.3
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 16:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=WNVTQf9fIUqL/YHISOSt28cF/B/Tl64f6EmqvvPIbm4=;
        b=dHa1KEn+7JdBQ9TSw3T3fI6o8Kdo3Z1nU7cr3i92UYtHsSRiLnQIeDCW66gfbLHPlL
         jEbD8j4hEquzNX6LiOW1C3G7GsiIfIGgnI41Acdlk09LvoevnHfseO6jnlOYL98J9HcU
         N6qBT6U/D9mF7usU8KlIcA1+fltaMj1ODcXmU1myNtU+xsGTKqbAfoE4OX8MqL7Rj+uo
         gkkpt7MitSFB3V1PFQWIncTKxcnS8E7Ljk8Iqm7+Ot0lLk2PfQ5rwRyDCbHz1a4Qpvjy
         YPK8YBDtmuYxYvlLVzigdz77r0FUoKDQcIf8lNgcPguxeP858V1pLgcjkWr8a8+/BAEU
         UjHQ==
X-Received: by 10.112.146.129 with SMTP id tc1mr3865969lbb.27.1428102374994;
 Fri, 03 Apr 2015 16:06:14 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Fri, 3 Apr 2015 16:06:14 -0700 (PDT)
In-Reply-To: <1428100224-29441-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: 5rJZtTZXxE-quuzEYbqYAZg5rlE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266748>

On Fri, Apr 3, 2015 at 6:30 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> systemd supports git-daemon's existing --inetd mode as well.
>
> v2: actually test...
> v3: make optional, switch to libsystemd

Every issue raised by my review[1] of v2 still applies to v3, so I
won't bother repeating them here, however, there is one comment
(below) new to this version of the patch.

[1]: http://article.gmane.org/gmane.comp.version-control.git/266650

> shawn@zephyr:~/git/git$ ldd /lib/x86_64-linux-gnu/libsystemd.so.0
>         linux-vdso.so.1 (0x00007ffeba7ec000)
>         libcap.so.2 => /lib/x86_64-linux-gnu/libcap.so.2 (0x00007fea158fe000)
>         libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fea155f9000)
>         librt.so.1 => /lib/x86_64-linux-gnu/librt.so.1 (0x00007fea153f0000)
>         libselinux.so.1 => /lib/x86_64-linux-gnu/libselinux.so.1 (0x00007fea151cb000)
>         liblzma.so.5 => /lib/x86_64-linux-gnu/liblzma.so.5 (0x00007fea14fa8000)
>         libgcrypt.so.20 => /lib/x86_64-linux-gnu/libgcrypt.so.20 (0x00007fea14cc5000)
>         libresolv.so.2 => /lib/x86_64-linux-gnu/libresolv.so.2 (0x00007fea14aae000)
>         libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fea148aa000)
>         libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fea1468b000)
>         libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fea142e7000)
>         /lib64/ld-linux-x86-64.so.2 (0x00007fea15d5b000)
>         libattr.so.1 => /lib/x86_64-linux-gnu/libattr.so.1 (0x00007fea140e2000)
>         libpcre.so.3 => /lib/x86_64-linux-gnu/libpcre.so.3 (0x00007fea13e73000)
>         libgpg-error.so.0 => /lib/x86_64-linux-gnu/libgpg-error.so.0 (0x00007fea13c61000)
>
> ewwwww...and only for two tiny functions.
>
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---
> diff --git a/Makefile b/Makefile
> index 5f3987f..362af94 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1403,8 +1413,8 @@ ifdef NATIVE_CRLF
>  endif
>
>  ifdef USE_NED_ALLOCATOR
> -       COMPAT_CFLAGS += -Icompat/nedmalloc
> -       COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
> +       COMPAT_CFLAGS += -Icompat/nedmalloc
> +       COMPAT_OBJS += compat/nedmalloc/nedmalloc.o

You're sneaking in (whitespace) changes unrelated to the rest of the
patch. Typically, such unrelated cleanups should be relegated to
separate preparatory patches. (In this case, however, the change is
probably unwarranted and likely accidental, but serves as a reminder
to review patches before sending them out.)

>  endif
>
>  ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
> diff --git a/daemon.c b/daemon.c
> index 9ee2187..16b9eda 100644
> --- a/daemon.c
> +++ b/daemon.c
