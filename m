From: Junio C Hamano <junio@siamese.dyndns.org>
Subject: Re: [PATCH] Docs update
Date: Thu, 21 Apr 2005 15:53:35 -0700
Message-ID: <7vy8bbd9n4.fsf@assigned-by-dhcp.cox.net>
References: <42680FCC.6030901@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 00:50:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOkUG-0001wg-IH
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261559AbVDUWxy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDUWxy
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:53:54 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:30909 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261559AbVDUWxl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:53:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050421225335.HZIB15592.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Apr 2005 18:53:35 -0400
To: David Greaves <david@dgreaves.com>
In-Reply-To: <42680FCC.6030901@dgreaves.com> (David Greaves's message of
 "Thu, 21 Apr 2005 21:40:44 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DG" == David Greaves <david@dgreaves.com> writes:

Looks nice.  I agree with Petr's comment that separating core part
and Cogito part would be good, and I would appreciate if you
pushed the core part documentation to Linus as well.

Some nitpicks and notes on your core part description.

DG>  commit-tree
DG> -	commit-tree <sha1> [-p <sha1>]* < changelog
DG> +	commit-tree <sha1> [-p <parent sha1>...] < changelog
 
The above does not describe what commit-tree expects.  It wants

    commit-tree <tree-sha1> [-p <parent1 sha1>]* <changelog

That is, you need -p before every parent.  I however think what
coommit-tree does here this aspect is wrong, unless Linus has
plans to give parameters other than parent IDs to commit-tree
later.  Even if that is the case, those non-parent things can
have their own -flag in front of them so not requiring -p would
be a good change.  I'll ask opinion from Linus on this (I just
sent out a patch).

DG> +A commit object usually has 1 parent (a commit after a change) or 2
DG> +parents (a merge) although there is no reason it cannot have more than
DG> +2 parents.

I'd rewrite the "or 2 parents..." part to "up to 16 parents.  More
than one parent represents merge of branches that led to them."

DG> +If not provided, commit-tree uses your name, hostname and domain to
DG> +provide author and committer info. This can be overridden using the
DG> +following environment variables.
DG> +	...
DG> +(nb <,> and CRs are stripped)

CRs are kept.  It removes '\n' (which is not necessarily LF).

DG> +diff-cache
DG> +	diff-cache [-r] [-z] <tree/commit sha1>
DG> +
DG> +Compares the content and mode of the blobs found via a tree object
DG> +with the content of the current cache and, optionally, the stat state
DG> +of the file on disk.

And the option to use working tree is not having the --cached
flag you describe later.  Please also update the usage at the
top as well:

	diff-cache [-r] [-z] [--cached] <tree/commit sha1>

DG> +In the special case of the file being changed on disk and out of sync with the cache, the sha1
DG> +
DG> +Operating Modes

Is the description truncated after "the sha1"???

DG>  ################################################################
DG>  diff-tree
DG> -	diff-tree [-r] [-z] <tree sha1> <tree sha1>
DG> +	diff-tree [-r] [-z] <tree sha1> <tree sha1> 

This command can take commit ID in place of tree ID.
 

