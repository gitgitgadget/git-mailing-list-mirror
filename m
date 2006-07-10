From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log to go forward instead of reverse?
Date: Mon, 10 Jul 2006 14:45:11 -0700
Message-ID: <7vpsgd9lso.fsf@assigned-by-dhcp.cox.net>
References: <86bqrxpai1.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101151470.5623@g5.osdl.org>
	<863bd9p9en.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101212410.5623@g5.osdl.org>
	<86mzbhntxu.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0607101304210.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Mon Jul 10 23:45:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G03Z8-0008QA-Rw
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 23:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWGJVpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 17:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965256AbWGJVpP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 17:45:15 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:47504 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965032AbWGJVpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 17:45:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710214512.KBIE18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 17:45:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23659>

Linus Torvalds <torvalds@osdl.org> writes:

> And if you didn't know about "git shortlog" already, I personally actually 
> find it easier to read
>
> 	git log --no-merges ORIG_HEAD.. | git shortlog
>
> which orders things by author instead.

Yes, and you can even have '-p' between git and shortlog in the
latter command if you do want the pager ;-).

BTW, when I prepare the "What's in" messages, I often find it
more useful to have a brother of short-log command that does not
group by author but group by topic branch the commits came from.

Currently I prepare the categorized list by hand, reviewing each
commit in "master..next" shortlog output.  While I do not mind
it too much since that is a good way to remind myself what are
still cooking, it would be nice to have to a command that takes:

	- which branch the output is relative to (defaults
          to "master");

	- list of branches that are "topics";

        - which branch the parts of topics have been merged to
          (optional -- I'd use "next" for my use).

and for each topic:

	- see if the topic branches off from another topic (for
          example, the merge-tree topic branches off from the
          xdiff-common topic like [*1*]); if so, state that and
          use that branch point instead of "master" in the next
          step;

	- list commits that have not made "master" yet;
          optionally, when "next" is given, limit the output
          only to the ones that have made "next" already.


[Footnote]

*1*

$ git show-branch --topics master lt/xdiff-common lt/merge-tree
* [master] git-rev-list: add documentation for --parents, --no-merges
 ! [lt/xdiff-common] xdiff: generate "anti-diffs" aka what is common...
  ! [lt/merge-tree] Improved three-way blob merging code
---
  + [lt/merge-tree] Improved three-way blob merging code
  + [lt/merge-tree^] Prepare "git-merge-tree" for future work
 ++ [lt/xdiff-common] xdiff: generate "anti-diffs" aka what is common...
*++ [master~67] checkout -m: fix read-tree invocation
