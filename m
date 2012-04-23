From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 1/7] Documentation: explain push.default option a bit more
Date: Mon, 23 Apr 2012 20:00:25 +0100
Organization: OPDS
Message-ID: <CB914FF3899C496F9E85E83B9532E055@PhilipOakley>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr> <1335170284-30768-2-git-send-email-Matthieu.Moy@imag.fr>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Matthieu Moy" <Matthieu.Moy@imag.fr>
To: "Matthieu Moy" <Matthieu.Moy@imag.fr>, <git@vger.kernel.org>,
	<gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:59:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMOTp-00019E-Rz
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 20:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2DWS7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 14:59:17 -0400
Received: from out1.ip08ir2.opaltelecom.net ([62.24.128.244]:15378 "EHLO
	out1.ip08ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754965Ab2DWS7Q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Apr 2012 14:59:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ar8LAM+llU9cHIEm/2dsb2JhbABEizClGQICgQ+BCIIEAQQBAQUIAQEuEQUIAQEhCwIDBQIBAxQBAQslFAEEGAIGBxcGAQcLCAIBAgMBDASFJwcBgikaB7pcixYIgV6DcGMEiC+FSYkTjy2Cag
X-IronPort-AV: E=Sophos;i="4.75,469,1330905600"; 
   d="scan'208";a="525593226"
Received: from host-92-28-129-38.as13285.net (HELO PhilipOakley) ([92.28.129.38])
  by out1.ip08ir2.opaltelecom.net with SMTP; 23 Apr 2012 19:59:13 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196158>

From: "Matthieu Moy" <Matthieu.Moy@imag.fr> Sent: Monday, April 23, 2012 
9:37 AM
> The previous documentation was explaining _what_ the options were doing,
> but were of little help explaining _why_ a user should set his default to
> either of the options.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Documentation/config.txt |   22 ++++++++++++++++++----
> 1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index fb386ab..e38fab1 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1680,12 +1680,26 @@ push.default::
>  line. Possible values are:
> +
> * `nothing` - do not push anything.
> -* `matching` - push all matching branches.
> -  All branches having the same name in both ends are considered to be
> -  matching. This is the default.
> -* `upstream` - push the current branch to its upstream branch.
> +* `matching` - push all branches having the same name in both ends.
> +  This allows those who prepare all the branches into a publishable
> +  shape to push them out to a non-shared repository with a single
> +  command. This is well suited when pushing to a non-shared
> +  repository, but may give surprising results when used on a
> +  repository shared by multiple users, since locally stalled
> +  branches will attempt a non-fast forward push if other users
> +  updated the branch remotely. This is the default.

Given the expected future change to 'simple' as the default, surely "This is 
currently the default." give the hint toward that change.

> +* `upstream` - push the current branch to its upstream branch. See
> +  "branch.<name>.merge" for how to configure the upstream branch. This
> +  makes `git push` and `git pull` symmetrical in the sense that `push`
> +  will update the same remote ref as the one which is merged by
> +  `git pull`.
> * `tracking` - deprecated synonym for `upstream`.
> * `current` - push the current branch to a branch of the same name.
> +  +
> +  The `current` and `upstream` modes are for those who want to
> +  push out a single branch after finishing work, even when the other
> +  branches are not yet ready to be pushed out. They are safe when
> +  pushing to a shared repository.
>
> rebase.stat::
>  Whether to show a diffstat of what changed upstream since the last
> -- 
> 1.7.10.234.ge65dd.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.1913 / Virus Database: 2411/4953 - Release Date: 04/22/12
> 
