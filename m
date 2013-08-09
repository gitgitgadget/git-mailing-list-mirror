From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/config.c: compilation fix
Date: Thu, 8 Aug 2013 23:31:59 -0700
Message-ID: <CAPc5daVoNef=EVxt+HAnVP9vSuQdTVHC=CRyc7_tqygxoiZeng@mail.gmail.com>
References: <7vli4b79x3.fsf@alter.siamese.dyndns.org> <866829AC-DD63-462B-B12F-BF868D0ED5C0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 08:32:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7gFN-0004NW-Pr
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 08:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272Ab3HIGcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 02:32:22 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:61594 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967395Ab3HIGcV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 02:32:21 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so2979660lbd.24
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EhuxBU0pMnQlqfinlO9BbXZuSxfQTzCoH4IdMScAEiQ=;
        b=BMqvwG1s9iZYCDt45pO/fh1go83D9z/weiU2LGkLtNn1z8PBlD2fWZ/UtW+LyI+L99
         pBcTMLsRlltK5eJ+3Y+3e14VZTEgS03r9bZdOAM+ZlJCjAkHbBDsrHPD6/inNmPJ5JE5
         hs8GDXmLUdzFRovw3UqgQTJCP8En2B910fn3UeiXt8lgh1nJcFPu4TiRdP1YO4Kd4+t/
         L90U+CragnEUiiv9WWSjlELKFehHhOqSao7+kZz6PAFzYhTngJVrH/7/2ntgXBFCfMc9
         YOz6A8p8IeST7crnY1H5tYPBddGDnHD3CEZY3kXp2VbU262OLk1e+emkQPqLNM0lN5h2
         nrfg==
X-Received: by 10.112.11.84 with SMTP id o20mr3796303lbb.86.1376029939753;
 Thu, 08 Aug 2013 23:32:19 -0700 (PDT)
Received: by 10.112.219.200 with HTTP; Thu, 8 Aug 2013 23:31:59 -0700 (PDT)
In-Reply-To: <866829AC-DD63-462B-B12F-BF868D0ED5C0@gmail.com>
X-Google-Sender-Auth: uXigcoeXfeOHW78l2nwNzflPjMM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231958>

On Thu, Aug 8, 2013 at 10:38 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
>> +       const char usage[] = "test-urlmatch-normalization [-p | -l] <url1>

> Looks good to me except that there seems to be a missing part of the patch.
> Did you also mean to include:
>
> diff --git a/test-urlmatch-normalization.c b/test-urlmatch-normalization.c
> index 2603899b..39017c20 100644
> --- a/test-urlmatch-normalization.c
> +++ b/test-urlmatch-normalization.c
> @@ -42,7 +42,7 @@ int main(int argc, char **argv)
>         }
>
>         if (opt_p || opt_l)
> -               die(usage);
> +               die("%s", usage);
>
> That's not terribly important here since we know the string will never
> contain any '%' characters, but the comment on the patch led me to believe
> that test-urlmatch-normalization would also get the die() change.

It appears that "const char usage[] = ..." is enough to convince Gcc
that usage _is_
a constant and can never contain anything funky. But I agree that the
usage string
could be updated, and I agree that it is prudent to do the same
die("%s", ...) there.
