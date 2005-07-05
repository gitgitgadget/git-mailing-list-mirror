From: Junio C Hamano <junkio@cox.net>
Subject: Re: Last mile for 1.0 again
Date: Mon, 04 Jul 2005 23:24:23 -0700
Message-ID: <7v3bqthiso.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507042137300.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 08:24:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpgrG-0003OI-3S
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 08:24:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVGEGY3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 02:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVGEGY3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 02:24:29 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:38086 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261381AbVGEGYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 02:24:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050705062425.LALO7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 5 Jul 2005 02:24:25 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0507042137300.30848-100000@iabervon.org> (Daniel Barkalow's message of "Mon, 4 Jul 2005 21:54:07 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "DB" == Daniel Barkalow <barkalow@iabervon.org> writes:

DB> [perl script]

>> How does this work, and what do we do about merges?

DB> I've got that part, but I'm not clear on how the rename/copy and complete
DB> rewrite stuff works.

Rename/copy is simply about what files to use when comparing
between two trees.  If you are tracking file F and find that a
commit created that file by renaming what was originally G, then
you compare old G and this F and assign blame for common lines
to the ancestor of that commit (that had those lines in G), and
take responsibility of the rest yourself (or assign blame for
them to other parents).

Rewrite is easier.  If diff-tree -B says it is a complete
rewrite, instead of assigning blame for lines that you are the
current suspect to any of your parents, you take blame for all
of them yourself, without comparing the file with the parent to
assign blame line-by-line.
