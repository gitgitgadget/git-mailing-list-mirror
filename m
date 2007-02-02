From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 15:38:03 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com> <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org> <200702021055.49428.jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 02 16:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD0UO-0006uI-R0
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 16:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945925AbXBBPiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 10:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945938AbXBBPiJ
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 10:38:09 -0500
Received: from distorted.demon.co.uk ([80.177.3.76]:57988 "HELO
	metalzone.distorted.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1945925AbXBBPiH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Feb 2007 10:38:07 -0500
Received: (qmail 5776 invoked by uid 110); 2 Feb 2007 15:38:03 -0000
Received: (qmail 5760 invoked by uid 9); 2 Feb 2007 15:38:03 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1170430683 5758 172.29.199.2 (2 Feb 2007 15:38:03 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 2 Feb 2007 15:38:03 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38506>

Jakub Narebski <jnareb@gmail.com> wrote:

> BTW does Mercurial have tags?

Yes.  Mercurial stores tags in text files, one per line, mapping the tag
name to a SHA1 hash of the tagged revision.  There are two files of
tags: `local' tags go into .hg/tags (or somesuch) and don't get copied
by clone; global tags go into .hgtags and do get copied (of course,
since they're part of the source tree).

If I may be opinionated for a bit: this is barking for two reasons:

  * The tags files grow by having lines added to the bottom.  Files of
    this kind are almost ideal for causing merge conflicts, and there's
    no automatic means for resolving them.  (I actually wrote a custom
    tags merger recently -- if anyone wants it, just mail me.)

  * If I visit a tag, and then decide I want to visit some other, more
    recent tag, I'm screwed because it obviously didn't exist in that
    old revision.  Tying tags to the revision history in this way is
    truly daft.

-- [mdw]
