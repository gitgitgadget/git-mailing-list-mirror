From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 0/2] Random patches from my tree
Date: Mon, 27 Oct 2008 13:05:45 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810271256470.3386@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 21:07:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuYNM-0006u8-IJ
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 21:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbYJ0UGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 16:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742AbYJ0UGb
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 16:06:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57592 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752299AbYJ0UGa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Oct 2008 16:06:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9RK5jtN014577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 27 Oct 2008 13:05:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9RK5jnc008092;
	Mon, 27 Oct 2008 13:05:45 -0700
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.941 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99259>


Ok, here's two random patches that I have in my git tree that may or may 
not be interesting.

The first one is something I did a long time ago because I was irritated 
by the "skipping inexact rename detection" message not really telling me 
_why_ it did so - just "too many files". So it just adds the information 
about number of deleted and created files.

The second one was something I whipped up due to the discussion about 
"which branch is a commit from". It adds a "--source" flag to the log 
command family, which then makes the revision walker save off the name of 
the commit in the '->util' field, and makes 'show_decorations()' show it.

So the second one allows things like

	git log --pretty=oneline --source --all

and it gives a somewhat useful view of which branch some commit came in 
on, by just showing _which_ of the references was the one that reached 
a particular commit first.

Of course, with commits that are reached multiple ways the whole notion of 
"which one reached us" is ambiguous, and it just picks one rather than 
building up any list of them. The first name we reach somethign through 
is the one that a commit sticks with. That's generally what you want.

I guess we should have a "--pretty=format" thing for it too, and maybe you 
want to support it for 'git rev-list' as well, but that's for others to 
decide - it people think it's useful.

			Linus
