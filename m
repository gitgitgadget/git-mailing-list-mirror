From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] wrapper: move is_empty_file() from builtin/am.c
Date: Wed, 15 Jun 2016 14:22:50 -0400
Message-ID: <CAPig+cTu1msxkjBZgLfy9g3+_VF5OzKNDbR0E0zVvopTNe2Q=g@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <20160615140026.10519-4-pranit.bauva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:23:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFSu-0000Ay-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbcFOSWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:22:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35754 "EHLO
	mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932141AbcFOSWw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:22:52 -0400
Received: by mail-io0-f196.google.com with SMTP id n127so3874712iof.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 11:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cfd/8M+3gyZaErrHxKGhDKNtvrZetbbEzWZS8sSvKTw=;
        b=k6nLSEmvpZcsf8FLGfhGSpt8XON6zs1r8erIKtPHpcWqWhklfY7/RcxE3Wd2ja5YZm
         pNNm+Ja/aut1RXD0PWfrGhDZY+ZcKGr1L494s9OLeGjY1EcSuAq55UixFYZV33IBj5v+
         PoIhOMwnRuR0iExrvs7Cz2JtK+0tQ5PLr2H1eCslwzvG61krQYc6PwhWyA0pa/BVbS/X
         PWE2K5/dbbavqrmCMv2rlfJGG2GPUmt9mFwJ+myEDm+Zsr+6OVvrp4SjdRtFdyDDXvG5
         vN7Z5EjwyInI02jnboxVhKI2O53eIxLXbQam67atUJlJZf0w3dOkcBvSttBj78vPIaVo
         A9/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cfd/8M+3gyZaErrHxKGhDKNtvrZetbbEzWZS8sSvKTw=;
        b=QEZnVVASbH2WprVyJB9fq+CklHEsbN+b75LT9f6o4XYgRGf9N0jURZAEE87RPc57bA
         1yGxsIPA75rJ/5Xz4WaL7xz6xs7swAUXITlg/opYZ2NLMFW+WhvuL/NHCxJl6z2bR7CA
         FC91VHmKum5aMaNGFzmLZF1fa9JPnT80yWdSXcFOy6K8OhCYlk7ex3LGZOrtOYXnLRAr
         oOWdvq9hvsOBvAgcCoUayVm7Pb2d6Jovi5Eg8uZ0oWQ33kRJc3xNb3R9ZcVdK/7nBTHm
         SctkMfaD85cdHQCaHm7lL1veUFrRARBTntL+Zd/Zh6g2Eb8f/uJPEYhZP401MYjjgy4H
         Cdpw==
X-Gm-Message-State: ALyK8tKE8e3lmvLbqauiojdbCmiSjFvyGkGX0BZK/eTVagL4KYAjbQZXkgCilp5pxGRaGGxMm0GQ0X48/R2WDQ==
X-Received: by 10.107.47.41 with SMTP id j41mr1335563ioo.168.1466014970833;
 Wed, 15 Jun 2016 11:22:50 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 15 Jun 2016 11:22:50 -0700 (PDT)
In-Reply-To: <20160615140026.10519-4-pranit.bauva@gmail.com>
X-Google-Sender-Auth: gO1tB7P779_sZgwL_kh3hOktca8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297386>

On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> is_empty_file() can help to refactor a lot of code. Also it is quite
> helpful while converting shell scripts which use `test -s`. Since

As justification, "can help to refactor a lot of code" is very
nebulous. It would be better to give a concrete reason for moving the
function, such as explaining that the functionality will be needed by
the "git bisect" port to C.

> is_empty_file() is now a "library" function, its inappropriate to die() so
> instead error_errno() is used to convey the message to stderr while the
> appropriate boolean value is returned.
>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> @@ -30,22 +30,6 @@
>  /**
> - * Returns 1 if the file is empty or does not exist, 0 otherwise.
> - */
> -static int is_empty_file(const char *filename)
> -{
> -       struct stat st;
> -
> -       if (stat(filename, &st) < 0) {
> -               if (errno == ENOENT)
> -                       return 1;
> -               die_errno(_("could not stat %s"), filename);
> -       }
> -
> -       return !st.st_size;
> -}

So, the original function die()'d for unexpected errors, but the
rewrite does not. This is a big behavior change. To account for such a
change in behavior I'd expect to see git-am updated to die() on its
own for such failures, but no such changes are present in this patch.
More about this below...

> diff --git a/wrapper.c b/wrapper.c
> @@ -696,3 +696,16 @@ void sleep_millisec(int millisec)
> +int is_empty_file(const char *filename)
> +{
> +       struct stat st;
> +
> +       if (stat(filename, &st) < 0) {
> +               if (errno == ENOENT)
> +                       return 1;
> +               error_errno(_("could not stat %s"), filename);

Mental note: There is no 'return' in front of error_errno(), so the
function does not exit here...

> +       }
> +
> +       return !st.st_size;
> +}

If stat() returns some error other than ENOENT, then the value of 'st'
will be undefined, yet this return statement accesses its 'st_size'
field, which is clearly a bad thing to do.

You either need to return a designated value (such as -1) upon errors
other than ENOENT (and update the documentation to mention -1) so that
the caller can decided what to do, or die() as the original did. While
it's true that die()'ing is not necessarily friendly in library code,
it may be acceptable until such time that you find a caller which
needs different behavior.
