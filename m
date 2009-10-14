From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached HEAD
 was
Date: Wed, 14 Oct 2009 19:34:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910141926170.20122@xanadu.home>
References: <alpine.LNX.2.00.0910140037570.32515@iabervon.org>
 <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com>
 <alpine.LNX.2.00.0910141509200.32515@iabervon.org>
 <alpine.LFD.2.00.0910141616530.20122@xanadu.home>
 <7v7huxbtbk.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org>
 <20091014230934.GC29664@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 01:36:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyDOj-0001Bq-Hy
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 01:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761603AbZJNXf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757334AbZJNXf2
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 19:35:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31555 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbZJNXf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 19:35:28 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KRJ00IBQ2TYRYC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 14 Oct 2009 19:34:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20091014230934.GC29664@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130351>

On Wed, 14 Oct 2009, Jeff King wrote:

> On Wed, Oct 14, 2009 at 03:34:05PM -0700, Junio C Hamano wrote:
> 
> > > Agreed.  Presumably some expert mode config would imply -f 
> > > automatically.
> > 
> > No, I do not want an expert mode.  I can probably live with "per session"
> > setting, that makes me decide to set or not set it when I detach, though.
> 
> That makes the most sense to me. If "git checkout" could write metadata
> into HEAD (or into DETACH_HEAD, as in Daniel's patch), then checkout
> could record an "ok to commit" bit. And could also be used to change it
> after the fact. E.g.:
> 
>   $ git checkout --detach=commit origin/master
>   $ git commit ;# should be ok
> 
>   $ git checkout --detach=examine origin/master
>   $ git commit ;# complain
>   $ git checkout --detach=commit HEAD
>   $ git commit ;# ok
> 
> I guess something like "rebase" should detach with "ok to commit", since
> it is planning on attaching the commits later. I'm not sure about "git
> bisect". I guess probably it should be "not ok to commit" to be on the
> safe side, and then somebody can "git checkout --detach=commit" if they
> want to.

Whatever is done about this... I'm afraid Git will end up less useful as 
operations that were possible before won't be anymore for "security's 
sake" unless some obnoxious override mode is involved.

Isn't the reflog already dealing with the security issue by making sure 
that nothing is "lost"?

Can't the user confusion be dealt with through some means other than 
making the tool less flexible?  I don't mind extra help message to be 
displayed after a headless commit is made for example.  But trying to 
make the tool more friendly should perhaps come from better education 
rather than added restrictions.

My thoughts only.


Nicolas
