From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Do not show "diff --git" metainfo with --no-prefix
Date: Tue, 15 Jan 2008 19:26:06 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801151919440.2806@woody.linux-foundation.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com> <alpine.DEB.1.00.0801151444180.5289@eeepc-johanness> <c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com> <alpine.LNX.1.00.0801151728120.13593@iabervon.org>
 <7vhched3kw.fsf@gitster.siamese.dyndns.org> <7v4pded1rk.fsf_-_@gitster.siamese.dyndns.org> <7v7iiabjyh.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 04:26:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEyvP-0001oz-OO
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 04:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbYAPD0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 22:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756049AbYAPD0U
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 22:26:20 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42975 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750912AbYAPD0T (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2008 22:26:19 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G3Q7Nn007357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 15 Jan 2008 19:26:08 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0G3Q6Sp017916;
	Tue, 15 Jan 2008 19:26:06 -0800
In-Reply-To: <alpine.LFD.1.00.0801151902080.2806@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.218 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70611>



On Tue, 15 Jan 2008, Linus Torvalds wrote:
> 
> If we do any git-specific stuff, we need to have that "--git" thing there. 
> That is *not* just limited to the prefix, but to all the other things git 
> diffs can do: renames, mode changes, etc.

Side note: the fact that git-apply itself might have issues with a 
"--no-prefix" patch is really a red herring, because while it's true that 
you would normally not do it for git, it's even more true that we haven't 
actually started teaching git about it and the cases where you *would* use 
it (eg recursive subproject diffs etc).

So I do not think it's true that "--no-prefix" (or --src/dst-prefix) 
necessarily implies "no-git" at all. It *can* do so, but it's not a given 
thing, and almost certainly isn't in the long run with submodule support. 

So it would be kind of sad if we mixed it up with the prefix decision, 
when it really is something totally separate. Many other SCM's may want a 
simple "-p1" patch (BK did, for example), and that doesn't make them 
particularly "git-like". And conversely, git itself will want more than a 
simple "-p1" patch for subproject handling.

		Linus
