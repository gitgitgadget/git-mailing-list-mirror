From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 4/6] Makefile: update to new command-list.txt format
Date: Mon, 11 May 2015 02:44:26 -0400
Message-ID: <CAPig+cQBUiniQ_A2BZGx-R4kxabE5hPcrbcoPXbq0kJS6oP+uw@mail.gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431191856-10949-5-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 08:44:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrhS4-0008Az-Un
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 08:44:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbEKGo2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2015 02:44:28 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:37447 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752308AbbEKGo1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 02:44:27 -0400
Received: by igbsb11 with SMTP id sb11so62452827igb.0
        for <git@vger.kernel.org>; Sun, 10 May 2015 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=dbX/vZxhq4ajxGCuFHmQL9MJCOkjy9FKTChl4iYqNV4=;
        b=N6dQGN112L1iE+b8eGrQX5ws9RcvWXWT2Lvkt+0tYjFUXoIwid4Im5y/muQjlB9O5P
         R1zDCYbfmCOlYHHq4qaraI9jl3J20zsFrW6QrjBOB1cYMZCsLmzyYgSgJib58fJ7W4GV
         v7Yc9WNH9PrEONDhGXnOdnwOUh/nF1auJy8JFKOHBdC824f9/L0cvi1cJjkbhjZzNMP1
         k2DUpiGfO+4YYCqiKBpb02Eq0YOgf0Iifz7LpBm0q7aKqG2J2hWi36P6FMrVeYk9r0cq
         rNvuN5d4NVRwo/MhYf2/L7mPy4sGDf5Of3Vs0vXcBU0fl22Y0AHQ9yVF8a4dexi/Jpmj
         dIaA==
X-Received: by 10.50.61.200 with SMTP id s8mr12458508igr.7.1431326666972; Sun,
 10 May 2015 23:44:26 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 10 May 2015 23:44:26 -0700 (PDT)
In-Reply-To: <1431191856-10949-5-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: L-A4teRwQBpDYzGT0qshH5z89iM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268760>

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> * In target common-cmds.h:
>   The AWK script 'generate-cmdlist.awk' replaces 'generate-cmdlist.sh=
'
>
> * In target check-docs:
>   command-list.txt now contains common commands group in
>   the header [common]. sed ignore all lines in command-list.txt
>   until the [commands] list to correctly checks for missing
>   documentation on Git commands.
>
> For the target common-cmds.h part:
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

The Makefile modification from my generate-cmdlist patch[1] is part of
the overall logical change of that patch. Its relation to the Makefile
changes in this patch is weak at best, or entirely non-existent.
Consequently, it should not be mixed with them. See my reply[2] to the
v5 cover letter for more information.

More below.

[1]: http://article.gmane.org/gmane.comp.version-control.git/268598
[2]: http://article.gmane.org/gmane.comp.version-control.git/268756

> For the target check-docs part:
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/Makefile b/Makefile
> index 5f3987f..9f333e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1687,10 +1687,10 @@ $(BUILT_INS): git$X
>         ln -s $< $@ 2>/dev/null || \
>         cp $< $@
>
> -common-cmds.h: ./generate-cmdlist.sh command-list.txt
> +common-cmds.h: generate-cmdlist.awk command-list.txt
>
>  common-cmds.h: $(wildcard Documentation/git-*.txt)
> -       $(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
> +       $(QUIET_GEN)awk -f generate-cmdlist.awk command-list.txt > $@=
+ && mv $@+ $@
>
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>         $(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_=
PATH_SQ):\
> @@ -2447,7 +2447,7 @@ check-docs::
>                 esac ; \
>                 test -f "Documentation/$$v.txt" || \
>                 echo "no doc: $$v"; \
> -               sed -e '/^#/d' command-list.txt | \
> +               sed -e '1,/^\[commands\]/d' <command-list.txt | \

I'm not convinced that it's a good idea to drop comment-line
processing from this sed invocation. Even though the current
command-list.txt may not have any comments following the [commands]
header, there is no guarantee that someone won't some day add some
comments following the header.

sed accepts multiple -e arguments, so retaining comment-line
processing does not make the extraction any more expensive. For
instance:

    sed -e '1,/^\[commands\]/d' -e '/^#/d' <command-list.txt | \

>                 grep -q "^$$v[  ]" || \
>                 case "$$v" in \
>                 git) ;; \
> @@ -2455,7 +2455,7 @@ check-docs::
>                 esac ; \
>         done; \
>         ( \
> -               sed -e '/^#/d' \
> +               sed -e '1,/^\[commands\]/d' \

Ditto. It would be more robust to retain comment-line processing.

>                     -e 's/[     ].*//' \
>                     -e 's/^/listed /' command-list.txt; \
>                 $(MAKE) -C Documentation print-man1 | \
> --
> 2.4.0
