From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-rebase.txt: discuss --fork-point assumption of vanilla "git rebase" in DESCRIPTION.
Date: Mon, 22 Sep 2014 12:35:34 -0700
Message-ID: <xmqqzjdrjvnd.fsf@gitster.dls.corp.google.com>
References: <87r3z72wiu.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 22 21:35:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XW9Ol-0002CL-7V
	for gcvg-git-2@plane.gmane.org; Mon, 22 Sep 2014 21:35:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879AbaIVTfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2014 15:35:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52316 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbaIVTfm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2014 15:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED8D93CB69;
	Mon, 22 Sep 2014 15:35:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V3aetEPIeM1SuRGxZuYrm8kOHR4=; b=tRpIHP
	vPiTL1ZLu9hM48qa6DL4TYb12wFGNCSDKaWVvL/qmPqBZ8JBHwaxwuZ/RKGU2I6K
	H4O7QAEcvbcjRnsu6ic1LsrbF9KRAen87eKyO+kKHniVgftAz4rSRBP9Mx68xMhp
	/GYvqiIabaJ2lZpRVktzpceIKeu2ttSXxIeAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ccbYN9yK1I6UPVr53Mh/9zLYQaPWn65k
	bvu7v9f6kIPnl+AoILWUCIN4ueGVllBVpkPOih5MozLswuON1qrVDa2RbkB+tMl6
	xK0WumWJeb4vHth1Wn3QS8EUrJiRu0MnJ5lnekQUWiRgOONOmpyXM7Xgb4Hu+Toq
	6I3YOX3GYG0=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E461C3CB68;
	Mon, 22 Sep 2014 15:35:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 57B7B3CB59;
	Mon, 22 Sep 2014 15:35:36 -0400 (EDT)
In-Reply-To: <87r3z72wiu.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
	18 Sep 2014 23:03:25 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A03710C4-428F-11E4-8D8A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257378>

Sergey Organov <sorganov@gmail.com> writes:

> Vanilla "git rebase" defaults to --fork-point that in some cases
> makes behavior very different from "git rebase <upstream>",
> where --no-fork-point is assumed. This fact was not mentioned in
> the DESCRIPTION section of the manual page, even though the case of
> omitted <upstream> was otherwise discussed. That in turn made actual
> behavior of vanilla "git rebase" hardly discoverable.
>
> While we are at it, clarify the --fork-point description itself as well.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/git-rebase.txt | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 4138554..73e1e1c 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -21,15 +21,16 @@ If <branch> is specified, 'git rebase' will perform an automatic
>  it remains on the current branch.
>  
>  If <upstream> is not specified, the upstream configured in
> -branch.<name>.remote and branch.<name>.merge options will be used; see
> -linkgit:git-config[1] for details.  If you are currently not on any
> -branch or if the current branch does not have a configured upstream,
> -the rebase will abort.
> +branch.<name>.remote and branch.<name>.merge options will be used (see
> +linkgit:git-config[1] for details) and the `--fork-point` option is
> +assumed.  If you are currently not on any branch or if the current
> +branch does not have a configured upstream, the rebase will abort.

OK.  When you do not tell rebase with respect to what exact _commit_
the operation is to be done, then we will enable --fork-point, which
makes perfect sense because it is clear that the user is rebasing
with respect to a _branch_, for which we may find a place better
than its current tip to rebase onto if we look at its reflog.

It is debatable if we should do the same when the user tells us to
rebase with respect to a specific _branch_ by giving the 'upstream'
argument, but that is an entirely separate issue.  We might want to
do a similar command line heuristics to tell between the branch
switching "git checkout master" (which is an operation about a
branch) and head detaching "git checkout refs/heads/master^0" (which
is an operation about a commit) if we want to help the users by
auto-enabling fork-point mode.

>  All changes made by commits in the current branch but that are not
>  in <upstream> are saved to a temporary area.  This is the same set
> -of commits that would be shown by `git log <upstream>..HEAD` (or
> -`git log HEAD`, if --root is specified).
> +of commits that would be shown by `git log <upstream>..HEAD`; or by
> +`git log <fork_point>..HEAD`, if --fork-point is either specified or
> +assumed; or by `git log HEAD`, if --root is specified.

OK.  <fork_point> is a new term this patch introduces to this
document.  Do we define what it is anywhere in this document, or
would it help the readers to add something like "... where <fork_point>
is computed in such and such way (see ... for details)"?

> @@ -331,9 +332,8 @@ link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for details)
>  	between `upstream` and `branch` when calculating which commits have
>  	have been introduced by `branch` (see linkgit:git-merge-base[1]).
>  +
> -If no non-option arguments are given on the command line, then the default is
> -`--fork-point @{u}` otherwise the `upstream` argument is interpreted literally
> -unless the `--fork-point` option is specified.
> +If either <upstream> or --root is given on the command line, then the
> +default is `--no-fork-point`, otherwise the default is `--fork-point`.

Good.  The original, especially the mention of "@{u}", does not make
any sense and updated text reads more clearly.

Thanks.
