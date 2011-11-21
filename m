From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation update for 'git branch --list'
Date: Mon, 21 Nov 2011 09:37:29 -0800
Message-ID: <7v7h2tgyw6.fsf@alter.siamese.dyndns.org>
References: <1321886000-4163-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 18:37:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSXoH-0002ka-Jv
	for gcvg-git-2@lo.gmane.org; Mon, 21 Nov 2011 18:37:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754360Ab1KURhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Nov 2011 12:37:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42957 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab1KURhb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2011 12:37:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E0874155;
	Mon, 21 Nov 2011 12:37:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2FWZVvbjuuQyoWVjHwk1uFYfZME=; b=cOOI9Y
	aGKBgRaM2qVTMP2my11EMcx1zXNPxOocKtnWsx4dPM7Rex+ey+lNQrI96nYCVD6w
	m5mcjZxoU89Pv8j8TsVmD0B63cp77T19I0MpqZ5Q0DPihR+0b03uFkQ6w6Ac1ryI
	2FXyL/oWW1cGbVzhNtF+jupwAoLPlyYMGSOy8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slV33NWFNTEG992YSFQK66y4xuvsc5i9
	0q+yVyibnaAHL7Fmeo8hvR8HBiBkMkqB/rAZ3CdeBaz0UsrM+2et5ge6RsXg4HQr
	/V8iXzoYgwje3LrdIZR6H5ZkPG4Yg6LbaxlcG7bsiNmZ4jwlCmIdLFVgNbw2V2Py
	WUPXmwKs8nQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 061224154;
	Mon, 21 Nov 2011 12:37:31 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 802E44153; Mon, 21 Nov 2011
 12:37:30 -0500 (EST)
In-Reply-To: <1321886000-4163-1-git-send-email-vfr@lyx.org> (Vincent van
 Ravesteijn's message of "Mon, 21 Nov 2011 15:33:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CC5DD36-1467-11E1-9B0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185754>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> Indicate that the <pattern>... argument is only valid when using --list.
> Otherwise a branch with the name <pattern> will be created.

I actually think there are some bugs in the implementation along that line
and the way forward is to fix the implementation, instead of documenting
the buggy behaviour.

It is natural to expect "git branch --merged pu vr/\*" to list branches
that are contained in 'pu' whose names match the given pattern, but it
seems to try creating a branch called "vr/*" and fails, for example.

> The current
> synopsis also suggests that 'git branch -d <pattern>...' would be a valid
> command.

That is not how I read the current synopsis for -d; doesn't it avoid using
<pattern> and explicitly say <branchname>?

> Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
> ---
>  Documentation/git-branch.txt |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index f46013c..9f49db4 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -9,8 +9,9 @@ SYNOPSIS
>  --------
>  [verse]
>  'git branch' [--color[=<when>] | --no-color] [-r | -a]
> -	[--list] [-v [--abbrev=<length> | --no-abbrev]]
> -	[(--merged | --no-merged | --contains) [<commit>]] [<pattern>...]
> +	[-v [--abbrev=<length> | --no-abbrev]]
> +	[(--merged | --no-merged | --contains) [<commit>]]
> +	[--list [<pattern>...]]
>  'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
>  'git branch' (-m | -M) [<oldbranch>] <newbranch>
>  'git branch' (-d | -D) [-r] <branchname>...
> @@ -23,8 +24,8 @@ be highlighted with an asterisk.  Option `-r` causes the remote-tracking
>  branches to be listed, and option `-a` shows both. This list mode is also
>  activated by the `--list` option (see below).
>  <pattern> restricts the output to matching branches, the pattern is a shell
> -wildcard (i.e., matched using fnmatch(3))
> -Multiple patterns may be given; if any of them matches, the tag is shown.
> +wildcard (i.e., matched using fnmatch(3)).
> +Multiple patterns may be given; if any of them matches, the branch is shown.
>  
>  With `--contains`, shows only the branches that contain the named commit
>  (in other words, the branches whose tip commits are descendants of the
> @@ -114,7 +115,7 @@ OPTIONS
>  --all::
>  	List both remote-tracking branches and local branches.
>  
> ---list::
> +--list [<pattern>...]::
>  	Activate the list mode. `git branch <pattern>` would try to create a branch,
>  	use `git branch --list <pattern>` to list matching branches.
