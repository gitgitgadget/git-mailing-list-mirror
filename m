From: Marc Singer <elf@buici.com>
Subject: Effective difference between git-rebase and git-resolve
Date: Fri, 24 Mar 2006 19:54:23 -0800
Message-ID: <20060325035423.GB31504@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 25 04:54:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMzrC-0000r4-Uf
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 04:54:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWCYDyY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 22:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWCYDyY
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 22:54:24 -0500
Received: from 206-124-142-26.buici.com ([206.124.142.26]:58848 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1750747AbWCYDyY
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 22:54:24 -0500
Received: (qmail 11923 invoked by uid 1000); 25 Mar 2006 03:54:23 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17951>

The process I've been using to keep my patches current with the latest
development is this:

  git checkout linus && git pull linus
  git checkout work

When I'm ready to merge,

  git resolve work linus "Update with head"
  git tag basis

This lets me diff against basis even when the linus branch continues
to follow the latest developments.

Today, I wanted to move everything forward.  But the resolve failed to
merge some files.  In fact, one file was apparently so thorny that
resolve just gave up and left no working file.  Bothersome, but I
recovered by moving back to the previous work point.

Then, I found git-rebase which seems to be more what I'd like to use
since it moves my patches along on top of the main development line.

  git rebase linus

This time, almost everything merged without a hitch except for the
thorny file from before.  I edited the file, removing the conflict
markers, and started a build.  But what I found was that some of the
changes I'd made were no longer present.  Several files showed no sign
of the patches even though the kernel versions hadn't changed.

So, I have a couple of questions:

  1) Am I using rebase correctly?
  2) If not, did it leave some of my changes uncommitted and hidden
     somewhere? git-ls-files --unmerged shows no sign of them.
  3) Do I have to pull all of my patches off, apply them to the head
     of the tree, and only use git-rebase to make this work?
  4) Should I prefer rebase over resolve?
