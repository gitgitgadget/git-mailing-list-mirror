From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [QUESTION] Selective fetch possible?
Date: Tue, 11 Mar 2008 03:50:53 -0400
Message-ID: <20080311075053.GQ8410@spearce.org>
References: <47D5AFF3.90000@yahoo.it> <20080310225302.GE8410@spearce.org> <m3d4q2ywyx.fsf@localhost.localdomain> <47D6341C.7030505@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Filippo Zangheri <filippo.zangheri@yahoo.it>,
	git@vger.kernel.org
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 08:52:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYzHF-00010L-3R
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 08:52:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbYCKHvG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 03:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYCKHvE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 03:51:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44423 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755011AbYCKHu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 03:50:58 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JYzG9-0005AO-6p; Tue, 11 Mar 2008 03:50:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 05FD720FBAE; Tue, 11 Mar 2008 03:50:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <47D6341C.7030505@dawes.za.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76809>

Rogan Dawes <lists@dawes.za.net> wrote:
> Jakub Narebski wrote:
> >"Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> >>Filippo Zangheri <filippo.zangheri@yahoo.it> wrote:
> >>>Is it possible to git-fetch only a portion of the tree
> >>>of the specified repository, say, fetch only one directory or a
> >>>subset of files matching some regular expression?
> 
> >The problem is twofold, as far as I understand it.  First, what to do
> >if there is merge conflicts outside checked out (selected) directory?
> 
> This is something that has been repeated many times, and I fail to see 
> how it can be an issue. How can there be a conflict in a directory that 
> is not, and never has been, checked out, and therefore cannot have been 
> modified?

Given two branches:

	code
	docs

and the code people checkout the "src/" subdirectory and the docs
people checkout the "Documentation/" subdirectory, and they *only*
every work in that subdirectory, things are fine.

Until one day some developer also checks out "Documentation/" and
fixes something in the documentation as part of the same commit
that makes a code change.  The push this to the code branch.

Someday in the future a documentation writer merges the code branch
over to the docs branch, "just keeping it current".

Now there arises a possiblity of a merge conflict in a part of the
tree that you do not have checked out.


If you want to say "don't ever modify stuff outside of your branch's
purpose" then why aren't you just using submodules (one for docs and
one for code) and using a supermodule to tie everything together into
a "release package"?

> >Second, how to make repository contain only relevant objects: git in
> >many places assumes full connectivity, and that if it has an object it
> >hass all objects depending on it.
> >
> 
> Yes, this is the big problem as I see it.

This is easy enough that if the above problem could be resolved
sufficiently to the git gurus' satisfaction you would be able
to get some advice on how to solve it.  Its not difficult, just
damn annoying.  We already do it (to some extent) with grafts and
shallow clones.

-- 
Shawn.
