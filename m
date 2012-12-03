From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] git-svn: Document branches with at-sign(@).
Date: Mon, 03 Dec 2012 11:28:00 -0800
Message-ID: <7vlidfq6kf.fsf@alter.siamese.dyndns.org>
References: <cover.1354324110.git.Sebastian.Leske@sleske.name>
 <67e9db6f948315f3c733dda0ad970e6257c075af.1354324110.git.Sebastian.Leske@sleske.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>,
	Eric Wong <normalperson@yhbt.net>
To: Sebastian Leske <Sebastian.Leske@sleske.name>
X-From: git-owner@vger.kernel.org Mon Dec 03 20:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tfbgk-0002Sj-4j
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 20:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262Ab2LCT2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2012 14:28:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751008Ab2LCT2D (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2012 14:28:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A824B9EC1;
	Mon,  3 Dec 2012 14:28:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=eNFEG/lU5lDpn28x1qEwH82yBr4=; b=ATYPuNzmP8h7NNMfqaGC
	fGzUpvKTDXxmKG1NOlt+vk66MQe/daj8uCMMH8YZ/PH3raIkVtnKfn3mE1uB/kMM
	HR+YMsaFjU96l77QzNrzUPy5iBGh5TnePBYMSfgeJxBeJzTw810/K+jRUq8Qv8wt
	joC7JYdcpgFtMcWHLURSqnI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bnfaoqF9z0+PRuZO81fqJ7K28YU+bWZDFQEQIjtstKZHsv
	MDe1B2d4CjycBKSBOS9euGznEjVyPctqmOcMxRHzSINSeO2mNb4nmcSjt4pnKyPy
	k4gD6LssZA1RjdM72RT0vRu/JS1EF2UYCrN4EhEe1OLT+cePVAFRbwAkoPUBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E73F9EBF;
	Mon,  3 Dec 2012 14:28:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B72249EBD; Mon,  3 Dec 2012
 14:28:01 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D6FCEAC-3D7F-11E2-B66E-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211053>

Sebastian Leske <Sebastian.Leske@sleske.name> writes:

> git svn will sometimes create branches with an at-sign in the name

It may be just me but "git svn sometimes creates" without "will"
reads much better to me (there is the same phrasing in the patch
text as well).

> (branchname@revision). These branches confuse many users and it is a FAQ
> why they are created. Document when git svn will create them.
>
> Signed-off-by: Sebastian Leske <sebastian.leske@sleske.name>
> ---
>  Documentation/git-svn.txt |   38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 8b0d3ad..824bf82 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -881,6 +881,44 @@ different name spaces.  For example:
>  	branches = stable/*:refs/remotes/svn/stable/*
>  	branches = debug/*:refs/remotes/svn/debug/*
>  
> +If 'git svn' is configured to fetch branches (and --follow-branches
> +is in effect), it will sometimes create multiple branches for one SVN
> +branch, where the addtional branches have names of the form
> +'branchname@nnn' (with nnn an SVN revision number).  These additional
> +branches are created if 'git svn' cannot find a parent commit for the
> +first commit in an SVN branch, to connect the branch to the history of
> +the other branches. Normally, the first commit in an SVN branch consists
> +of a copy operation. 'git svn' will read this commit to get the SVN
> +revision the branch was created (copied) from. It will then try to find the
> +git commit that corresponds to this SVN revision, and use that as the
> +parent of the branch. However, it is possible that there is no suitable
> +git commit to serve as parent.  This will happen, among other reasons,
> +if the SVN branch is a copy of a revision that was not fetched by 'git
> +svn' (e.g. because it is an old revision that was skipped with
> +'--revision'), or if in SVN a directory was copied that is not tracked
> +by 'git svn' (such as a branch that is not tracked at all, or a
> +subdirectory of a tracked branch). In these cases, 'git svn' will still
> +create a git branch, but instead of using an existing git commit as the
> +parent of the branch, it will read the SVN history of the directory the
> +branch was copied from and create appropriate git commits (this is
> +indicated by the message "Initializing parent: <branchname>").
> +Additionally, it will create a special branch named
> +'<branchname>@<SVN-Revision>', where <SVN-Revision> is the SVN revision
> +number the branch was copied from.  This branch will point to the newly 
> +created parent commit of the branch.  If in SVN the branch was deleted
> +and later recreated from a different version, there will be multiple
> +such branches with an '@'.
> +Note that this may mean that multiple git commits are created for a
> +single SVN revision. An example: In an SVN repository with a standard 
> +trunk/tags/branches layout, a directory trunk/sub is created in r.100.
> +In r.200, trunk/sub is branched by copying it to branches/. 'git svn
> +clone -s' will then create a branch 'sub'. It will also create new git
> +commits for r.100 through r.199 and use these as the history of branch
> +'sub'. Thus there will be two git commits for each revision from r.100
> +to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
> +it will create a branch 'sub@200' pointing to the new parent commit of
> +branch 'sub' (i.e. the commit for r.200 and trunk/sub/).
> +

Have you looked at the formatted result?  This is quite detailed and
long, and may deserve to be split into a few paragraphs.  I'd
probably suggest a paragraph break before "Normally, the first...",
"Additionally", "Note that", and "An example:"
