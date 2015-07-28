From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 11/11] branch: add '--points-at' option
Date: Tue, 28 Jul 2015 00:46:26 -0700
Message-ID: <CA+P7+xp6FKDw26Qudi+kHi+CQ-rB1BFwOQdk65VyyAwTRW=vGg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438067468-6835-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 09:46:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJzb9-0005rx-HY
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 09:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755263AbbG1Hqr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 03:46:47 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36737 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755253AbbG1Hqq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 03:46:46 -0400
Received: by igbij6 with SMTP id ij6so104969377igb.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 00:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5zdIi8pSi/veuDwZpgGGzmclEh+44r3ZCJPMMX83WLY=;
        b=KTV36Q2GYa/cgeRIOY9eV7BmxmajO/Um+TIxZjmCzrkhTJSU+lnnUAIQaMIUc1vOXx
         bS/dse+vAe/bht8Lf1FTOmfCtUdR6Bsaq++Izf9pdc1PHcc0MHr1E+URzDCO1IuSRYdD
         8lcCIPK753Gy0AcTtpGOvyYqJoSzWRruynDe5lMLvt3g1rTwzU4dFnn1SCKxGm3UDU9Y
         /dkNAEZMGKGy+gj+9fSiuZUImNYNiYDcvDXWJWbM50juAIlSyh35hPHbNbjqVBc8NN4c
         bi/ufCnD0AbRDqoyMjGw2MI/i4miLD3G4mi8sWM2ZVltrnY17sSvwDC99CWd6A9vQRvB
         pT8Q==
X-Received: by 10.50.23.98 with SMTP id l2mr3972697igf.25.1438069605775; Tue,
 28 Jul 2015 00:46:45 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Tue, 28 Jul 2015 00:46:26 -0700 (PDT)
In-Reply-To: <1438067468-6835-2-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274752>

On Tue, Jul 28, 2015 at 12:11 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add the '--points-at' option provided by 'ref-filter'. The option lets
> the user to list only branches which points at the given object.
>
> Add documentation and tests for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-branch.txt | 6 +++++-
>  builtin/branch.c             | 7 ++++++-
>  t/t3203-branch-output.sh     | 9 +++++++++
>  3 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 897cd81..efa23a5 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -11,7 +11,8 @@ SYNOPSIS
>  'git branch' [--color[=<when>] | --no-color] [-r | -a]
>         [--list] [-v [--abbrev=<length> | --no-abbrev]]
>         [--column[=<options>] | --no-column]
> -       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>] [<pattern>...]
> +       [(--merged | --no-merged | --contains) [<commit>]] [--sort=<key>]
> +       [--points-at <object>] [<pattern>...]
>  'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
>  'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
>  'git branch' --unset-upstream [<branchname>]
> @@ -237,6 +238,9 @@ start-point is either a local or remote-tracking branch.
>         for-each-ref`. Sort order defaults to sorting based on branch
>         type.
>
> +--points-at <object>::
> +       Only list tags of the given object.
> +

s/tags/branches/ ?? Since this is for the branch version, I think this
is just a copy-paste oversight.

>  Examples
>  --------
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 75d8bfd..d25f43b 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -26,6 +26,7 @@ static const char * const builtin_branch_usage[] = {
>         N_("git branch [<options>] [-l] [-f] <branch-name> [<start-point>]"),
>         N_("git branch [<options>] [-r] (-d | -D) <branch-name>..."),
>         N_("git branch [<options>] (-m | -M) [<old-branch>] <new-branch>"),
> +       N_("git branch [<options>] [-r | -a] [--points-at]"),
>         NULL
>  };
>
> @@ -647,6 +648,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>                 OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
>                 OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
>                              N_("field name to sort on"), &parse_opt_ref_sorting),
> +               {
> +                       OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
> +                       N_("print only tags of the object"), 0, parse_opt_object_name
> +               },

Same as above. s/tags/branches/

>                 OPT_END(),
>         };
>
> @@ -675,7 +680,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
>         if (!delete && !rename && !edit_description && !new_upstream && !unset_upstream && argc == 0)
>                 list = 1;
>
> -       if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE)
> +       if (filter.with_commit || filter.merge != REF_FILTER_MERGED_NONE || filter.points_at.nr)
>                 list = 1;
>
>         if (!!delete + !!rename + !!new_upstream +
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index 38c68bd..1deb7cb 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -154,4 +154,13 @@ EOF
>         test_i18ncmp expect actual
>  '
>
> +test_expect_success 'git branch --points-at option' '
> +       cat >expect <<EOF &&
> +  master
> +  branch-one
> +EOF
> +       git branch --points-at=branch-one >actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.4.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
