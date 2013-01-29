From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] status: show branch name if possible in in-progress info
Date: Tue, 29 Jan 2013 13:31:53 +0100
Message-ID: <vpqy5fcrwzq.fsf@grenoble-inp.fr>
References: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 13:32:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0AMN-0005xN-BN
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 13:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165Ab3A2Mb6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2013 07:31:58 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42264 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab3A2Mb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 07:31:57 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0TCVqUK018501
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 29 Jan 2013 13:31:52 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U0ALx-0002T8-UN; Tue, 29 Jan 2013 13:31:53 +0100
In-Reply-To: <1359461450-24456-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 29
 Jan 2013 19:10:50 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 29 Jan 2013 13:31:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0TCVqUK018501
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360067513.06765@eVAuMx6TG2tx0D+ctWiJWQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214935>

I like the idea.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
> index b3f6eb9..096ba6f 100755
> --- a/t/t7512-status-help.sh
> +++ b/t/t7512-status-help.sh
> @@ -76,7 +76,7 @@ test_expect_success 'status when rebase in progress=
 before resolving conflicts'
>  	test_must_fail git rebase HEAD^ --onto HEAD^^ &&
>  	cat >expected <<-\EOF &&
>  	# Not currently on any branch.
> -	# You are currently rebasing.
> +	# You are currently rebasing '\''rebase_conflicts'\''.

Perhaps "rebasing *branch* 'rebase_conflicts'"

Or even "rebasing branch 'rebase_conflicts' on <sha1sum>"

?

> @@ -923,7 +947,7 @@ static void show_bisect_in_progress(struct wt_sta=
tus *s,
>  				struct wt_status_state *state,
>  				const char *color)
>  {
> -	status_printf_ln(s, color, _("You are currently bisecting."));
> +	status_printf_ln(s, color, _("You are currently bisecting '%s'."), =
state->branch);
>  	if (advice_status_hints)
>  		status_printf_ln(s, color,
>  			_("  (use \"git bisect reset\" to get back to the original branch=
)"));

In the "rebase" case, you test state->branch for null-ness. Don't you
need the same test here? (What happens if you start a bisect from a
detached HEAD state?)

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
