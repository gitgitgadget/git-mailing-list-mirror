From: Nicolas Pitre <nico@cam.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 21:45:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810312135190.13034@xanadu.home>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
 <20081031213114.GA21799@artemis.corp>
 <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
 <20081031232829.GC14786@spearce.org>
 <7v63n872bs.fsf@gitster.siamese.dyndns.org>
 <20081101001300.GE14786@spearce.org>
 <alpine.LFD.2.00.0810312106310.13034@xanadu.home>
 <20081101011910.GH14786@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 02:47:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw5aU-0000d1-UQ
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 02:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbYKABpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 21:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbYKABpq
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 21:45:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37668 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYKABpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 21:45:46 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M006NOSV0MR41@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 21:45:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081101011910.GH14786@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99705>

On Fri, 31 Oct 2008, Shawn O. Pearce wrote:

> > Both the negative code and errno style are lightweight in the common "no 
> > error" case.  The errno style is probably more handy for those functions 
> > returning a pointer which should be NULL in the error case.
> 
> I'm sticking with return a negative code for now, to the extent
> that some functions which return a pointer but also have many
> common failure modes (e.g. git_odb_open) use an output parameter
> as their first arg, so the error code can be returned as the result
> of the function.

Actually, the pointer-returning functions can encode error cases into a 
"negative" pointer. See include/linux/err.h for example.

	void *ptr = git_alloc_foo(...);
	if (IS_ERR(ptr))
		die("git_alloc_foo failed: %s", git_strerr(PTR_ERR(ptr)));


Nicolas
