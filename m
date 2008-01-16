From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 23:04:21 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0801152256480.13593@iabervon.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
 <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:04:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEzWG-000089-Oj
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756533AbYAPEEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754830AbYAPEEY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:04:24 -0500
Received: from iabervon.org ([66.92.72.58]:41307 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbYAPEEY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:04:24 -0500
Received: (qmail 17689 invoked by uid 1000); 16 Jan 2008 04:04:21 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Jan 2008 04:04:21 -0000
In-Reply-To: <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70616>

On Tue, 15 Jan 2008, Linus Torvalds wrote:

> On Tue, 15 Jan 2008, Linus Torvalds wrote:
> > 
> > If we do any git-specific stuff, we need to have that "--git" thing there. 
> > That is *not* just limited to the prefix, but to all the other things git 
> > diffs can do: renames, mode changes, etc.
> 
> Side note: the fact that git-apply itself might have issues with a 
> "--no-prefix" patch is really a red herring, because while it's true that 
> you would normally not do it for git, it's even more true that we haven't 
> actually started teaching git about it and the cases where you *would* use 
> it (eg recursive subproject diffs etc).
>
> So I do not think it's true that "--no-prefix" (or --src/dst-prefix) 
> necessarily implies "no-git" at all. It *can* do so, but it's not a given 
> thing, and almost certainly isn't in the long run with submodule support. 

I don't think --no-prefix is sufficient for submodules; it means that 
git-apply will accidentally remove exactly one level, but if your 
submodule is two directory levels down, it won't work, and having the 
effective prefixes be "gitweb" and "gitweb" is a little hackish. You'd 
really want to generate a -p1 patch whose root is shifted from the actual 
project root, not a -p0 patch or -p2 patch or something.

	-Daniel
*This .sig left intentionally blank*
