From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 26 Jun 2007 19:14:06 -0700
Message-ID: <7vtzsurvo1.fsf@assigned-by-dhcp.pobox.com>
References: <7v646wqrvm.fsf@assigned-by-dhcp.cox.net>
	<7vfy5wcnbg.fsf@assigned-by-dhcp.cox.net>
	<7vd50xz7lq.fsf@assigned-by-dhcp.cox.net>
	<7vodkb1adr.fsf@assigned-by-dhcp.cox.net>
	<7virac547s.fsf@assigned-by-dhcp.cox.net>
	<7v6466oygl.fsf@assigned-by-dhcp.cox.net>
	<7vfy54tt3l.fsf@assigned-by-dhcp.cox.net>
	<7vtztbbnsq.fsf@assigned-by-dhcp.pobox.com>
	<7v4pl1zsd7.fsf@assigned-by-dhcp.pobox.com>
	<7v645cz7vm.fsf@assigned-by-dhcp.pobox.com>
	<20070626133548.GB11504@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jun 27 04:14:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3N2v-000108-UO
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 04:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbXF0COM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 22:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754465AbXF0COL
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 22:14:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64666 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754552AbXF0COH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 22:14:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070627021406.JRPP22777.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 26 Jun 2007 22:14:06 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GSE61X00K1kojtg0000000; Tue, 26 Jun 2007 22:14:07 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51009>

Matthias Lederhofer <matled@gmx.net> writes:

> Thanks.  I'll have a look at receive-pack this week.  Is there
> anything in receive-pack yet which helps to use a working tree in the
> hooks?  Or is this something for which the behaviour of git still has
> to be defined?

I think the behaviour for receive-pack and the environment the
hooks run in have been pretty well defined.  You start in the
repository (the directory $GIT_DIR), GIT_DIR is set and points
at it.

The issue is that the introduction of WORK_TREE enviornment and
core.worktree mechanism might want to update the semantics.  For
example, some people seem to run checkout (or perhaps "merge")
to update the associated working tree.  Can they find out where
the root of the working tree is (because they would want to
chdir to it before saying "git checkout"), given the current
environment receive-pack sets up for them?

Earlier we said that people who use only GIT_DIR without
GIT_WORK_TREE nor core.worktree should get exactly the same
semantics with or without the WORK_TREE topic, so the above may
not be an issue.
