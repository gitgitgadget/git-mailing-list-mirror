From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] submodule: add verbose mode for add/update
Date: Wed, 12 Mar 2014 04:35:47 -0400
Message-ID: <5FD334C9-9AD9-40AE-ADFB-B96B8E2D8F66@sunshineco.com>
References: <CAGHpTBJ29oyuNojiAtsd73wau4Xsz2zuxxg04mFG0TdekeSRxA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 09:35:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNedp-0006ps-Um
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 09:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756675AbaCLIfw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Mar 2014 04:35:52 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61129 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756336AbaCLIfu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Mar 2014 04:35:50 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so13591817igb.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 01:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WzlWjYDds28kcORYRFw9ngipodM5zQltx9OqWFqjolo=;
        b=bkp1W/KEpzaBj3Pgg8Vb8BszhUd7tYWUAIFd4TCdCaDy7IwWdmiv8RAu4LMRnlXvQV
         qAcShs4niRI4RDNkD98RUT8UqFEo9BuzD8dzq+ObuiT3XNFhWiUGqnSIkWM3WidE3vhB
         6ciz+WieDBTWo3rMD9lxYgALpcb9HRoC8af1ok7l09YEGosNF/6XmAyh41Yy++Y+4nHo
         dBhC11wYEOObWFgkPfXNjC6a3NmC+R+u03o2Qlm1OW3YuNq2XZEdFesoWb3RPbdhK8E3
         EmPwbQyL/OxLig0odsFdzF1LzvNP/bvoOI6ToU3HWH5qjHWILqg+meny+OSvtJnsZnKA
         N5NQ==
X-Received: by 10.50.122.9 with SMTP id lo9mr28884449igb.27.1394613349581;
        Wed, 12 Mar 2014 01:35:49 -0700 (PDT)
Received: from [192.168.0.104] (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id an1sm53323434igc.0.2014.03.12.01.35.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 12 Mar 2014 01:35:49 -0700 (PDT)
In-Reply-To: <CAGHpTBJ29oyuNojiAtsd73wau4Xsz2zuxxg04mFG0TdekeSRxA@mail.gmail.com>
X-Mailer: Apple Mail (2.1874)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243927>

On Mar 12, 2014, at 2:38 AM, Orgad Shaneh <orgads@gmail.com> wrote:
> Executes checkout without -q
> =97

Missing sign-off. See Documentation/SubmittingPatches.

Your patch is badly whitespace-damaged, as if it was pasted into your e=
mail client. =93git send-email=94 can avoid this problem.

As I=92m not a submodule user, I won=92t review the content of the patc=
h other than to say that such a change should be accompanied by documen=
tation update (Documentation/git-submodule.txt) and additional tests.

> git-submodule.sh | 24 +++++++++++++++++++-----
> 1 file changed, 19 insertions(+), 5 deletions(-)
>=20
> diff --git a/git-submodule.sh b/git-submodule.sh
> index a33f68d..5c4e057 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -5,11 +5,11 @@
> # Copyright (c) 2007 Lars Hjemli
>=20
> dashless=3D$(basename "$0" | sed -e 's/-/ /')
> -USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> [--reference <repository>] [--] <repository> [<path>]
> +USAGE=3D"[--quiet] add [-b <branch>] [-f|--force] [--name <name>]
> [--reference <repository>] [-v|--verbose] [--] <repository> [<path>]
> or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>.=
=2E.]
> or: $dashless [--quiet] init [--] [<path>...]
> or: $dashless [--quiet] deinit [-f|--force] [--] <path>...
> -   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch=
]
> [-f|--force] [--rebase] [--reference <repository>] [--merge]
> [--recursive] [--] [<path>...]
> +   or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch=
]
> [-f|--force] [--rebase] [--reference <repository>] [--merge]
> [--recursive] [-v|--verbose] [--] [<path>...]
> or: $dashless [--quiet] summary [--cached|--files]
> [--summary-limit <n>] [commit] [--] [<path>...]
> or: $dashless [--quiet] foreach [--recursive] <command>
> or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
> @@ -319,12 +319,16 @@ module_clone()
> rel=3D$(echo $a | sed -e 's|[^/][^/]*|..|g')
> (
> clear_local_git_env
> + if test -z "$verbose"
> + then
> + subquiet=3D-q
> + fi
> cd "$sm_path" &&
> GIT_WORK_TREE=3D. git config core.worktree "$rel/$b" &&
> # ash fails to wordsplit ${local_branch:+-B "$local_branch"...}
> case "$local_branch" in
> - '') git checkout -f -q ${start_point:+"$start_point"} ;;
> - ?*) git checkout -f -q -B "$local_branch" ${start_point:+"$start_po=
int"} ;;
> + '') git checkout -f $subquiet ${start_point:+"$start_point"} ;;
> + ?*) git checkout -f $subquiet -B "$local_branch"
> ${start_point:+"$start_point"} ;;
> esac
> ) || die "$(eval_gettext "Unable to setup cloned submodule '\$sm_path=
'")"
> }
> @@ -380,6 +384,9 @@ cmd_add()
> --depth=3D*)
> depth=3D$1
> ;;
> + -v|--verbose)
> + verbose=3D1
> + ;;
> --)
> shift
> break
> @@ -786,6 +793,9 @@ cmd_update()
> --depth=3D*)
> depth=3D$1
> ;;
> + -v|--verbose)
> + verbose=3D1
> + ;;
> --)
> shift
> break
> @@ -913,7 +923,11 @@ Maybe you want to use 'update --init'?")"
> must_die_on_failure=3D
> case "$update_module" in
> checkout)
> - command=3D"git checkout $subforce -q"
> + if test -z "$verbose"
> + then
> + subquiet=3D-q
> + fi
> + command=3D"git checkout $subforce $subquiet"
> die_msg=3D"$(eval_gettext "Unable to checkout '\$sha1' in submodule
> path '\$displaypath'")"
> say_msg=3D"$(eval_gettext "Submodule path '\$displaypath': checked ou=
t
> '\$sha1'")"
> ;;
> --=20
> 1.9.0.msysgit.0
