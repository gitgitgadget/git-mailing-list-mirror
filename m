From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH try2 09/14] apply: add --stage option
Date: Sun, 13 Oct 2013 05:53:37 -0400
Message-ID: <CAPig+cSmVKK_onR8NtLkdahkFci77SCsU6PagyJEBYLo4xZBUQ@mail.gmail.com>
References: <1381561488-20294-1-git-send-email-felipe.contreras@gmail.com>
	<1381561488-20294-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>,
	Miles Bader <miles@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	William Swanson <swansontec@gmail.com>,
	Ping Yin <pkufranky@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 13 11:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVIMu-0000ra-L3
	for gcvg-git-2@plane.gmane.org; Sun, 13 Oct 2013 11:53:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165Ab3JMJxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Oct 2013 05:53:40 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:34434 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab3JMJxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Oct 2013 05:53:39 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so4785755lbh.34
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=1SA4Xc1MiFL+s2tMtxoZWb0BzA2EzA6SNsagXd0WaeU=;
        b=yFiU/V3zd0ZnT7tjdatH+xvlEQkbYIHDqxihauiiv2g0n0hRXkwNVJd9U+AfRlN7UX
         oHjlcgtcWPLKSrHjbgoHARbdB/BPYjbkQPQGenXAxOpXtY9weCBh6qHISnhalBaKILrv
         ++ANTmleouyvzxsVtQn42A77iuyZl9lml0/uru8umGzfaHPhNBFIlp8OHPD5oNbY7XlT
         rgMM8fYTfU4eIlmr6TqWhbJmF/XE+Fybz9ibzwQGK9BMAzThNEn4q5zDQGaxLQGjitQz
         3FnlvG7XTcqw0PIVrO93T+CNyahOsElsBnQkmsew4WmuEaeKlfr1U0poLRm+0620Clzs
         RAmg==
X-Received: by 10.112.149.197 with SMTP id uc5mr24775786lbb.19.1381658017694;
 Sun, 13 Oct 2013 02:53:37 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 13 Oct 2013 02:53:37 -0700 (PDT)
In-Reply-To: <1381561488-20294-7-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: D9olTGipyR6iuQB7oNZTDi4loqc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236069>

On Sat, Oct 12, 2013 at 3:04 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Synonym for --index.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-apply.txt | 5 ++++-
>  builtin/apply.c             | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
> index f605327..ce44327 100644
> --- a/Documentation/git-apply.txt
> +++ b/Documentation/git-apply.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>  'git apply' [--stat] [--numstat] [--summary] [--check] [--index] [--3way]
>           [--apply] [--no-add] [--build-fake-ancestor=<file>] [-R | --reverse]
>           [--allow-binary-replacement | --binary] [--reject] [-z]
> -         [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached]
> +         [-p<n>] [-C<n>] [--inaccurate-eof] [--recount] [--cached|--staged]

Here "staged".

>           [--ignore-space-change | --ignore-whitespace ]
>           [--whitespace=(nowarn|warn|fix|error|error-all)]
>           [--exclude=<path>] [--include=<path>] [--directory=<root>]
> @@ -67,6 +67,9 @@ OPTIONS
>         up-to-date, it is flagged as an error.  This flag also
>         causes the index file to be updated.
>
> +--staged::
> +       Synonym for --index.
> +

Also "staged".

>  --cached::
>         Apply a patch without touching the working tree. Instead take the
>         cached data, apply the patch, and store the result in the index
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 50912c9..42b5a4b 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4377,6 +4377,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                         N_("instead of applying the patch, see if the patch is applicable")),
>                 OPT_BOOLEAN(0, "index", &check_index,
>                         N_("make sure the patch is applicable to the current index")),
> +               OPT_BOOLEAN(0, "stage", &check_index,

But here "stage".

> +                       N_("make sure the patch is applicable to the current index")),
>                 OPT_BOOLEAN(0, "cached", &cached,
>                         N_("apply a patch without touching the working tree")),
>                 OPT_BOOLEAN(0, "apply", &force_apply,
> --
> 1.8.4-fc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
