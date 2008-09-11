From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 17:39:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
References: <20080909132212.GA25476@cuci.nl> <m3zlmhnx1z.fsf@localhost.localdomain> <20080909194354.GA13634@cuci.nl> <alpine.LFD.1.10.0809091631250.3117@nehalem.linux-foundation.org> <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org>
 <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 02:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdaFH-0001YP-Ak
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 02:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752196AbYIKAkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 20:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752235AbYIKAkF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 20:40:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42235 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751636AbYIKAkD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Sep 2008 20:40:03 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8B0dRu3012529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 10 Sep 2008 17:39:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8B0dQne002518;
	Wed, 10 Sep 2008 17:39:27 -0700
In-Reply-To: <20080910230906.GD22739@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.937 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95570>



On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:
> 
> - However, if you explicitly pull D, the origin information from A to D can
>   be used.  People doing a generic clone get all four branches, and
>   therefore have all the important commits which normally could contain
>   origin links.  Note that even during a clone, commits pointed to by
>   origin links are not being transmitted (unless there already are other
>   reasons to send them along).

IOW, it's not actually transferring them and saving them, since a simple 
delete of the origin branch will basically make them unreachable.

Fine. At least it works the same way as fetch, then. But it's still a huge 
mistake, because it really does mean that it is technically no different 
at all to just mentioning the SHA1 in the commit message, the way we 
already do for backports.

The "origin" link has no _meaning_ for git, in other words.

> >No it's not. You can mention the backport explicitly in the commit 
> >message, and then you get hyperlinks in the graphical viewers. That works 
> >when people _want_ it to work, instead of in some hidden automatic manner 
> >that does entirely the wrong thing in all the common cases.
> 
> Could you spell out one of the common cases where it would do entirely
> the wrong thing?

It carries along information that is worthless and meaningless and hidden.

I refuse to touch such an obviously braindamaged design. It has no sane 
_semantics_. If it doesn't have semantics, it shouldn't exist, certainly 
not as some architected feature.

Nobody has shown any actual sane meaning for it. The only ones that have 
been mentioned have been for things like avoiding re-picking commits 
during a "git rebase", but (a) the patch SHA1 does that already for things 
that are truly identical an (b) since that information isn't reliable 
_anyway_, and since it's apparently a user choice, it's just "random".

I'm sorry, but "good design" is a hell of a lot more important than some 
made-up use case that isn't even reliable, and doesn't match any actual 
real problems that anybody can explain.

			Linus
