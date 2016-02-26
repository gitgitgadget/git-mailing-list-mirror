From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 2/3] sumodule--helper: fix submodule--helper clone
 usage and check argc count
Date: Fri, 26 Feb 2016 11:31:06 -0800
Message-ID: <CAGZ79kbD7_CYo9KT185oTxrjqch-otwfG0mWqAV2QiwrC-ch9Q@mail.gmail.com>
References: <1456514328-10153-1-git-send-email-jacob.e.keller@intel.com>
	<1456514328-10153-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 20:31:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZO6r-0004Gr-VI
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbcBZTbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:31:10 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35149 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933880AbcBZTbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 14:31:08 -0500
Received: by mail-ig0-f172.google.com with SMTP id hb3so41100454igb.0
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=RC0Z0zSJsM21IiVWzA+cGOjvJtgbcG/db9UO37NtG/0=;
        b=YVeDtdRrdqhzBsGjvrmUYdWStXP/dfkxjo4nfq6Zxw3ppV2WmB1dQafn1Lwo9vLz4l
         8vmEs1ZgzLG+YXPFGTrUHepcJfoEELliEqoYoQnrfdwdZLRHp19S6fSj0t58KVkHhbXj
         L3/2QdrescB3ehZ7B3jqwecSSZEYJQgsAgdgt+tH3JfHEepRJG9VqpPnyHGDIYkjM+bR
         CLuLpvBTo2nOh/YUY73PFxTDOrEZ/TovAlQ2I65YUHX7XT3JaQUqzSuV980eNkW0gku/
         5LjEUBSXu/0g/1gNuPwfU5ba+KrqLkgoZC4d264n+wYBdq8xXxZwD4q+LE1yi41hOAp0
         98Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=RC0Z0zSJsM21IiVWzA+cGOjvJtgbcG/db9UO37NtG/0=;
        b=llMpyTG9wcsxnvXmF84ARKrEwy/5ZylBP/ZjiTnmBL0OOa4qdOCxzgw27s7BOAeYFQ
         ouiUHQKHQYd/mExURRIiuELzk3cloq57jbVZQMINGMwCnM4RDKDHDLY/fOdjiGtN27KY
         B7nbiU8WPW+VClUzWL+4dlc49KB1uf4XFKYbVnybyl/y7GN7ZPyg2vroAgfaow1yP6dy
         QmdhH73Sddqs4x2HV2edaz/gr3aVANjze03Y9Ssvgkv8TMB5t/GOqWZZ0eYmQ1hBTf+T
         jONlFrKHIyrERndxFpzIS/xcZeK/fszYctS0qBoj6EiLvCpudRS8erduC1U9BERGkIh1
         UuYw==
X-Gm-Message-State: AD7BkJJPOwFy2nYBO5+4Mmetw3qGsqfHK1qmSv7bxG5qC32iH8M/dWUYUbGqJu4qxmT2xBcouN1TCq5f53O8p6p6
X-Received: by 10.50.3.42 with SMTP id 10mr4464567igz.85.1456515067007; Fri,
 26 Feb 2016 11:31:07 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 26 Feb 2016 11:31:06 -0800 (PST)
In-Reply-To: <1456514328-10153-2-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287611>

On Fri, Feb 26, 2016 at 11:18 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> git submodule--helper clone usage specified that paths come after the --
> as a sequence. However, the actual implementation does not, and requires
> only a single path passed in via --path. In addition, argc was
> unchecked. (allowing arbitrary extra arguments that were silently
> ignored).
>
> Fix the usage description to match implementation. Add an argc check to
> enforce no extra arguments. Fix a bug in the argument passing in
> git-submodule.sh which would pass --reference and --depth as empty
> strings when they were unused, resulting in extra argc after parsing
> options.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  builtin/submodule--helper.c | 5 ++++-
>  git-submodule.sh            | 4 ++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index f4c3eff179b5..072d9bbd12a8 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -187,13 +187,16 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>         const char *const git_submodule_helper_usage[] = {
>                 N_("git submodule--helper clone [--prefix=<path>] [--quiet] "
>                    "[--reference <repository>] [--name <name>] [--url <url>]"
> -                  "[--depth <depth>] [--] [<path>...]"),
> +                  "[--depth <depth>] [--path <path>]"),

Right, no extra arguments.

>                 NULL
>         };
>
>         argc = parse_options(argc, argv, prefix, module_clone_options,
>                              git_submodule_helper_usage, 0);
>
> +       if (argc)
> +               usage(*git_submodule_helper_usage);
> +

This is the fix to check for more arguments.

>         strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
>         sm_gitdir = strbuf_detach(&sb, NULL);
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 9bc5c5f94d1d..2dd29b3df0e6 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -347,7 +347,7 @@ Use -f if you really want to add it." >&2
>                                 echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
>                         fi
>                 fi
> -               git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" "$reference" "$depth" || exit
> +               git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit

By having this additional fix (i.e. no '--depth', '<empty string>' is
passed to the
submodule helper, we can improve the submodule helper further
in clone_submodule we can drop the double check for `depth` and `reference`
(as well as `gitdir`, that double check is unneeded as of now already),
by just checking for the pointer to be non  NULL and not further checking
the dereferenced pointer.

That can go in either squashed into this commit or on top of it, either is fine.

That said:
Reviewed-by: Stefan Beller <sbeller@google.com>


>                 (
>                         clear_local_git_env
>                         cd "$sm_path" &&
> @@ -709,7 +709,7 @@ Maybe you want to use 'update --init'?")"
>
>                 if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
>                 then
> -                       git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" "$reference" "$depth" || exit
> +                       git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$prefix" --path "$sm_path" --name "$name" --url "$url" ${reference:+"$reference"} ${depth:+"$depth"} || exit
>                         cloned_modules="$cloned_modules;$name"
>                         subsha1=
>                 else
> --
> 2.7.1.429.g45cd78e
>
