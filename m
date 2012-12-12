From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] RFC Optionally handle symbolic links as copies
Date: Wed, 12 Dec 2012 17:15:14 +0100 (CET)
Message-ID: <1141725649.20938344.1355328914240.JavaMail.root@dewire.com>
References: <50C89822.9050900@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:15:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tioy7-0001eN-M2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 17:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab2LLQPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 11:15:18 -0500
Received: from zimbra.dewire.com ([83.140.172.131]:42764 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754385Ab2LLQPR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 11:15:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id AD33082640;
	Wed, 12 Dec 2012 17:15:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vlJST9Hos8Rt; Wed, 12 Dec 2012 17:15:14 +0100 (CET)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 534598262E;
	Wed, 12 Dec 2012 17:15:14 +0100 (CET)
In-Reply-To: <50C89822.9050900@drmicha.warpmail.net>
X-Originating-IP: [194.68.56.38]
X-Mailer: Zimbra 7.2.0_GA_2681 (ZimbraWebClient - FF3.0 (Win)/7.2.0_GA_2681)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211363>



----- Ursprungligt meddelande -----
> Robin Rosenberg venit, vidit, dixit 06.12.2012 02:23:
> > 
> > 
> > ----- Ursprungligt meddelande -----
> >> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> >>
> >>> If core.symlinks is set to copy then symbolic links in a git
> >>> repository
> >>> will be checked out as copies of the file it points to.
> >>
> >> That all sounds nice on surface when the primary thing you care
> >> about is to fetch and check out other people's code and extract it
> >> to the working tree, but how well would that work on the checkin
> >> side?  What happens if I check out a symlink that points at a file
> >> (either in-tree or out-of-tree), make some changes that do not
> >> involve the symlink, and before I make the commit, an unrelated
> >> change is made to the file the symlink is pointing at?
> >>
> >>> - git status - when do we report a diff.
> >>> 	- After checkout we should probably not
> >>> 	- if the "linked" files change?
> >>
> >> Yeah, exactly.
> >>
> >>> 	- if a change in the copied directory chsnges
> >>
> >> That, too.
> >>
> >>> 	- if a file in the copied diretory is added/removed
> >>> 	- update, should we update the copied structure automatically
> >>> 	  when the link target changes
> > 
> > Some of the questions have proposals in the includes test script. A
> > little more dangerous than having real symlinks ofcourse, but
> > regardless
> > of what one does with or without copied symlinks one can make
> > mistakes
> > and I feel letting Git do the copying is way better than having
> > real
> > copies in the git repository. Another crappy scm which the users
> > are
> > converting from does this and it works. A difference to git is that
> > it (ok clearcase) makes all files read-only so there are fewer mays
> > of making mistakes with the copies.
> > 
> >> I personally do not think this is worth it.  It would be very
> >> useful
> >> on the export/checkout side, so it may make sense to add it to
> >> "git
> >> archive", though.
> > 
> > It makes sense, but it does not solve the problem at hand.
> > 
> > -- robin
> > 
> 
> Well, what is the problem at hand?

The problem is that I'm converting a repo from clearcase to git and
there are lots of symbolic links. Symbolic links in clearcase on 
Windows is treated as file copy in snapshot views which means that
you get a copy of the linked file when you update the view. If the
link target changes you can update your view to refersh your copies.

> Your commit message begins in present tense as if it described the
> current state of git, when in fact it describes what the patch is
> about
> to achieve. This is confusing enough already,

You're right.

> I don't see any mention of the purpose, other than "content may be
> used", which would be served perfectly by a copy-on-link feature on
> the
> export side, as mentioned by Junio. Is git-archive|tar an option?

I want the copy on checkout. The intent is to change things and
then commit.

Perhaps I can convince people to let a script copy stuff instead.

-- robin
