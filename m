From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] config doc: rewrite push.default section
Date: Sun, 16 Jun 2013 13:10:22 +0100
Organization: OPDS
Message-ID: <89027CD773CE4BFC8C293D2454CE4AE5@PhilipOakley>
References: <1371377188-18938-1-git-send-email-artagnon@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Git List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 16 14:10:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoBmt-0006Df-Jm
	for gcvg-git-2@plane.gmane.org; Sun, 16 Jun 2013 14:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab3FPMKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Jun 2013 08:10:22 -0400
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:57901 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755083Ab3FPMKV (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Jun 2013 08:10:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: At8NAMGpvVFZ8YhC/2dsb2JhbABagwmJOLYBBAEDAYEBF3SCHgUBAQQBCAEBHREeAQEhCwIDBQIBAw4HAQslFAEECBIGBxcGARIIAgECAwGHawMJCq8xDYhSjGSBeWqDBmEDiGiGBoZsjgaFJIMQOw
X-IronPort-AV: E=Sophos;i="4.87,874,1363132800"; 
   d="scan'208";a="422182839"
Received: from host-89-241-136-66.as13285.net (HELO PhilipOakley) ([89.241.136.66])
  by out1.ip05ir2.opaltelecom.net with SMTP; 16 Jun 2013 13:10:19 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228006>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Sunday, June 16, 2013 11:06 AM
> Design by Junio.
>
> By detaching descriptions from the implementation, we're only 
> confusing
> users.  I've chosen to use the term "central workflow" to make the
> descriptions terse and readable, although I've stayed way from
> "triangular workflow" (referred to as non-central workflow).

A sentence, in the Documentation/config.txt, is needed to clarify the 
Central workflow and any distinction with the  non-central workflow(s). 
We cannot assume the new reader has the same world view of that concept 
(they may be thinking it means we do a centralised VCS, not a DVCS with 
a chosen central primary repo - assuming I have understood it 
correctly).

It took a while to bottom out the issues, so it is worth summarising the 
key point(s) in the documentation to avoid having to repeat the 
disussions ;-)

>
> Yes, I hate writing documentation but I have no choice if I want to
> update the implementations to do something sane in triangular 
> workflows.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
> I'll send in the implementation once we can agree that this is what
> we want.
>
> Documentation/config.txt | 51 
> ++++++++++++++++++++++++------------------------
> 1 file changed, 25 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 7fd4035..30350a3 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1832,33 +1832,32 @@ push.default::
>  line. Possible values are:
> +
> --
> -* `nothing` - do not push anything.
> -* `matching` - push all branches having the same name in both ends.
> -  This is for those who prepare all the branches into a publishable
> -  shape and then push them out with a single command.  It is not
> -  appropriate for pushing into a repository shared by multiple users,
> -  since locally stalled branches will attempt a non-fast forward push
> -  if other users updated the branch.
> -  +
> -  This is currently the default, but Git 2.0 will change the default
> -  to `simple`.
> -* `upstream` - push the current branch to its upstream branch
> -  (`tracking` is a deprecated synonym for this).
> -  With this, `git push` will update the same remote ref as the one 
> which
> -  is merged by `git pull`, making `push` and `pull` symmetrical.
> -  See "branch.<name>.merge" for how to configure the upstream branch.
> -* `simple` - like `upstream`, but refuses to push if the upstream
> -  branch's name is different from the local one. This is the safest
> -  option and is well-suited for beginners. It will become the default
> -  in Git 2.0.
> -* `current` - push the current branch to a branch of the same name.
> +* `nothing` - error out unless a refspec is explicitly given.
> +
> +* `current` - push the refspec "$HEAD".  HEAD is resolved early to a
> +  branch name (referred to as $HEAD).  In other words, push the

s/In other words,/That is,/
'In other words' often indicates poor wording, while here the extra 
words explicitly explain the effect.

> +  current branch to update a branch with the same name on the pushing
> +  side.

s/pushing side/push destination/ for consistency with upstream wording 
used below.

> +
> +* `upstream` - push the refspec "$HEAD:branch.$HEAD.merge", and error
> +  out if the push destination is not the same as branch.$HEAD.remote.
> +  The name "upstream" refers to the revision "@{u[pstream]}" in
> +  linkgit:gitrevisions[7].  It is useful in central workflows, to 
> make
> +  the `push` symmetrical to `pull`.
> +
> +* `simple` - in central workflows, behaves like `upstream`, except
> +  that it errors out unless branch.$HEAD.merge is equal to $HEAD.  In
> +  non-central workflows, behaves like `current`.  It will become the
> +  default in Git 2.0.
> +
> +* `matching` - push the refspec ":".  In other words, push all
> +  branches having the same name in both ends, even if it means
> +  non-fast-forward updates.  This is for those who prepare all the
> +  branches into a publishable shape and then push them out with a
> +  single command.  Dangerous, and inappropriate unless you are the

"Dangerous and innappropriate" (which it maybe for some) is too 
judgemental.
Perhaps turn it around to a positive (unless -> only if).

"Useful if you are the.."

> +  only person updating your push destination.  This is currently the
> +  default, but Git 2.0 will change the default to `simple`.
> --
> -+
> -The `simple`, `current` and `upstream` modes are for those who want 
> to
> -push out a single branch after finishing work, even when the other
> -branches are not yet ready to be pushed out. If you are working with
> -other people to push into the same shared repository, you would want
> -to use one of these.
>
> rebase.stat::
>  Whether to show a diffstat of what changed upstream since the last
> -- 
> 1.8.3.1.443.g4fd77b9
>
> --
regards
Philip
