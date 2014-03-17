From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][GSOC2014] install_branch_config: change logical chain to
 lookup table
Date: Mon, 17 Mar 2014 02:52:53 -0400
Message-ID: <CAPig+cSCD32e=XgK=rRHJm944Dc=_jk+81LV124nv6L_kheD5g@mail.gmail.com>
References: <CAPig+cRCKCcfYQVM=pyXUQtTsbaD8g=OKff+K5+Bd+kBgqAufg@mail.gmail.com>
	<BLU0-SMTP430B54F52C27DDA0C405A5D5700@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: TamerTas <tamertas@outlook.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 07:53:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPRPv-0000zv-7j
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 07:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756215AbaCQGwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 02:52:55 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:33037 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799AbaCQGwy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 02:52:54 -0400
Received: by mail-yk0-f172.google.com with SMTP id 200so13975567ykr.3
        for <git@vger.kernel.org>; Sun, 16 Mar 2014 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=41Dd5YD4z5T/M3pzg+Z1NbJgMWmGCsSP3T2+5yO4Cn4=;
        b=NpO76+egF8mrZYzeql7LT0+YxHOF4J+Qx3bGawfymFLHTyrcdvgn4N5+5xjJ7c9FT8
         V9aeukKcqaKfeUKr07l+Cl6fd3e6a7vGsa6KNTuAUKcioQxmjLOijX3L7pEvVT9WjPjP
         32Sb2eHNZHqpW2sOz6OAAHpzzLlLKROttWGoBT3wYooxzJ10uhkK1s3bRlWofdRdmb/W
         FMMikVUBpw5jCw1+q8g1QroBU9YFg3y3rt6b1ygUsCcXtv37FXGVxJCZcliJoFmtT/oF
         jD3ek6Hj5rUCcPoMso1Fer8PeC/8wXbRz6OCqe1nf7k1PNx6jF4kntP5V0stY09zBcTU
         y7qA==
X-Received: by 10.236.26.72 with SMTP id b48mr2220424yha.59.1395039173902;
 Sun, 16 Mar 2014 23:52:53 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Sun, 16 Mar 2014 23:52:53 -0700 (PDT)
In-Reply-To: <BLU0-SMTP430B54F52C27DDA0C405A5D5700@phx.gbl>
X-Google-Sender-Auth: JtTFycFy0I9Pb9dktu_FvmbWFZE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244224>

On Fri, Mar 14, 2014 at 5:30 PM, TamerTas <tamertas@outlook.com> wrote:
> Signed-off-by: TamerTas <tamertas@outlook.com>
> ---
> Thanks again for the feedback it's been a great learning experience. Comments Below :)
>
> I have refactored the commit [1] to * suggested changes [2].
> format-patch was placing 2 hyphens instead of 3 but it's fixed now.
> I've turned the table into a multidimensional one and I didn't put
> the inner braces since this was used method in other multidimensional arrays
> throughout the project.

Thanks, this is looking better. A few minor comments below, but it's
probably not worth a re-roll. What is important is that you have had a
taste of the review process on this project, and the GSoC mentors have
had a chance to observe your abilities and reviewer interaction.

> I've also changed shortname to short_name since that seems to be how variables are named
> in this project.

This is a conceptually distinct change which should be done as a
separate "cleanup" patch since it otherwise adds noise which obscures
the "real" change (rewriting the if-chain). One of the goals of a
patch submitter is to make the review process as streamlined as
possible, so noise should be avoided.

Apart from that, unless the variable is really improperly named and
misleading, this sort of change (renaming "shortname" to "short_name")
is likely to be considered unnecessary code churn which will probably
be rejected. At any given time, there are many patch series in-flight
which Junio has to juggle, and code churn increases possibility of
conflict between them, which makes his job more difficult.

> It appears that table-driven code might be more readable after all.
>
> [1]http://git.661346.n2.nabble.com/PATCH-GSOC2014-install-branch-config-change-logical-chain-to-lookup-table-tp7605550.html
> [2]http://git.661346.n2.nabble.com/PATCH-GSOC2014-install-branch-config-change-logical-chain-to-lookup-table-tp7605550p7605605.html
> ---
>  branch.c |   42 +++++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 723a36b..eab6fa4 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -49,13 +49,27 @@ static int should_setup_rebase(const char *origin)
>
>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>  {
> -       const char *shortname = remote + 11;
> +       const char *short_name = remote + 11;
> +       const char *setup_message[][2][2] = {
> +               N_("Branch %s set up to track local ref %s."),
> +               N_("Branch %s set up to track local branch %s."),
> +               N_("Branch %s set up to track remote ref %s."),
> +               N_("Branch %s set up to track remote branch %s from %s."),
> +               N_("Branch %s set up to track local ref %s by rebasing."),
> +               N_("Branch %s set up to track local branch %s by rebasing."),
> +               N_("Branch %s set up to track remote ref %s by rebasing."),
> +               N_("Branch %s set up to track remote branch %s from %s by rebasing.")
> +       };
> +
>         int remote_is_branch = starts_with(remote, "refs/heads/");
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> +       const char *remote_name = remote_is_branch? short_name : remote;
> +       const char *message = setup_message[!!rebasing][!!origin][!!remote_is_branch];

In the previous review, it was suggested to pull this value out into
its own variable to make the code less noisy since it was being
accessed frequently in just a few lines of code. However, since you've
collapsed the code to a single printf_ln() invocation in this patch,
the separate variable may be not helping clarity (especially as the
assignment is divorced by some distance from the code which references
it). The same is probably true of 'remote_name' which is used in just
the one printf_ln() call.

>         if (remote_is_branch
> -           && !strcmp(local, shortname)
> +           && !strcmp(local, short_name)
>             && !origin) {
>                 warning(_("Not setting branch %s as its own upstream."),
>                         local);
> @@ -77,29 +91,7 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         strbuf_release(&key);
>
>         if (flag & BRANCH_CONFIG_VERBOSE) {
> -               if (remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote branch %s from %s by rebasing.") :
> -                                 _("Branch %s set up to track remote branch %s from %s."),
> -                                 local, shortname, origin);
> -               else if (remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local branch %s by rebasing.") :
> -                                 _("Branch %s set up to track local branch %s."),
> -                                 local, shortname);
> -               else if (!remote_is_branch && origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track remote ref %s by rebasing.") :
> -                                 _("Branch %s set up to track remote ref %s."),
> -                                 local, remote);
> -               else if (!remote_is_branch && !origin)
> -                       printf_ln(rebasing ?
> -                                 _("Branch %s set up to track local ref %s by rebasing.") :
> -                                 _("Branch %s set up to track local ref %s."),
> -                                 local, remote);
> -               else
> -                       die("BUG: impossible combination of %d and %p",
> -                           remote_is_branch, origin);
> +               printf_ln(_(message), local, remote_name, origin);
>         }
>  }
>
> ---
> 1.7.9.5
