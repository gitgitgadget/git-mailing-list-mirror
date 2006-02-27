From: Michal Ostrowski <mostrows@watson.ibm.com>
Subject: Re: Teach the "git" command to handle some commands internally
Date: Mon, 27 Feb 2006 07:59:58 -0500
Message-ID: <1141045198.19983.9.camel@brick.watson.ibm.com>
References: <Pine.LNX.4.64.0602261225500.22647@g5.osdl.org>
	 <7vbqwt7m3t.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602261518110.22647@g5.osdl.org>
	 <7vy7zx65v0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 14:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDhz2-0000ag-To
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 14:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWB0NAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 08:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWB0NAJ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 08:00:09 -0500
Received: from igw2.watson.ibm.com ([129.34.20.6]:13459 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP
	id S1751149AbWB0NAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 08:00:07 -0500
Received: from sp1n293en1.watson.ibm.com (sp1n293en1.watson.ibm.com [129.34.20.41])
	by igw2.watson.ibm.com (8.12.11/8.13.1/8.13.1-2005-04-25 igw) with ESMTP id k1RCxvjJ008103;
	Mon, 27 Feb 2006 07:59:58 -0500
Received: from sp1n293en1.watson.ibm.com (localhost [127.0.0.1])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_2) with ESMTP id k1RCxkL211426;
	Mon, 27 Feb 2006 07:59:46 -0500
Received: from mgsmtp00.watson.ibm.com (mgsmtp00.watson.ibm.com [9.2.40.58])
	by sp1n293en1.watson.ibm.com (8.11.7-20030924/8.11.7/01-14-2004_1) with ESMTP id k1RCxjH220496;
	Mon, 27 Feb 2006 07:59:45 -0500
Received: from kitch0.watson.ibm.com (kitch0.watson.ibm.com [9.2.224.107])
	by mgsmtp00.watson.ibm.com (8.12.11/8.12.11/2005/09/01) with ESMTP id k1RDvcmZ001185;
	Mon, 27 Feb 2006 08:57:38 -0500
Received: from brick (brick.watson.ibm.com [9.2.216.48])
	by kitch0.watson.ibm.com (AIX5.1/8.11.6p2/8.11.0/03-06-2002) with ESMTP id k1RCxfm37878;
	Mon, 27 Feb 2006 07:59:41 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7zx65v0.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.4.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16842>

On Sun, 2006-02-26 at 15:46 -0800, Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Sun, 26 Feb 2006, Junio C Hamano wrote:
> >> 
> >> > There's one other change: the search order for external programs is 
> >> > modified slightly, so that the first entry remains GIT_EXEC_DIR, but the 
> >> > second entry is the same directory as the git wrapper itself was executed 
> >> > out of - if we can figure it out from argv[0], of course.
> >> 
> >> I am not sure about this part, though.
> >
> > Well, what it means is that _if_ you install all your "git" binaries in 
> > some directory that is not in your patch and is not GIT_EXEC_DIR, they 
> > will still magically work, assuming you don't do something strange.
> 
> I understood that part.  I was wondering if this change defeats
> what Michal (you sensibly CC'ed your message to) wanted to do
> earlier, going great length trying to avoid mucking with PATH
> and "where-ever git itself is found" in the last round.  After
> reviewing the change in 77cb17 commit, I realize my worry was
> unfounded.

The changes seem reasonable for now.  We can't avoid mucking with PATH
as long as we are going to be running shell scripts that depend on PATH
to invoke "git-xxx" or even "git xxx".  I don't seen any easy solution
to this that would not involve changing every script (albeit
mechanically) and would not be prone to lapses in discipline.

Any solution to this original problem (i.e. a special "PATH" for "git*")
would seem to be applicable to the behavior this patch introduces.


-- 
Michal Ostrowski <mostrows@watson.ibm.com>
