From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 07 Dec 2011 22:35:00 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1112072227510.2907@xanadu.home>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
 <20111207225318.GA21852@sigill.intra.peff.net>
 <alpine.LFD.2.02.1112071912570.2907@xanadu.home>
 <20111208004515.GA23015@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?ISO-8859-15?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 04:35:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYUlg-0004aY-4L
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 04:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758621Ab1LHDf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 22:35:28 -0500
Received: from relais.videotron.ca ([24.201.245.36]:42235 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758007Ab1LHDf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 22:35:26 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR004.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0LVV00B278G89S30@VL-VM-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Dec 2011 22:31:20 -0500 (EST)
In-reply-to: <20111208004515.GA23015@sigill.intra.peff.net>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186528>

On Wed, 7 Dec 2011, Jeff King wrote:

> On Wed, Dec 07, 2011 at 07:18:13PM -0500, Nicolas Pitre wrote:
> 
> > I certainly never did a multi-ref fetch myself.
> 
> Not consciously, perhaps, but you do it all the time without realizing
> it:
> 
>   $ git clone git://git.kernel.org/pub/scm/git/git.git
>   $ cd git
>   $ git fetch -v origin
>    = [up to date]      maint      -> origin/maint
>    = [up to date]      master     -> origin/master
>    = [up to date]      next       -> origin/next
>    = [up to date]      pu         -> origin/pu
>    = [up to date]      todo       -> origin/todo
>   $ cat .git/FETCH_HEAD
>   b1af9630d758e1728fc0008b3f18d90d8f87f4c5        not-for-merge   branch 'maint' of git://git.kernel.org/pub/scm/git/git
>   4cb5d10b14dcbe0155bed9c45ccb94e83bd4c599                branch 'master' of git://git.kernel.org/pub/scm/git/git
>   03e5527c5df33d4550ccc1446d861c0aa5689d58        not-for-merge   branch 'next' of git://git.kernel.org/pub/scm/git/git
>   cc4e3f01fc6a5e09ae5bbdc464965981fae4cf39        not-for-merge   branch 'pu' of git://git.kernel.org/pub/scm/git/git
>   7a02dba15bd28826344f9c14a5e2b5c57eeb7e50        not-for-merge   branch 'todo' of git://git.kernel.org/pub/scm/git/git

OK, nevermind.  I admitedly never have been close enough to the related 
code.

And I don't think this particular case is interesting anyway as the 
reflogs for the various branches alre already involved.  I was thinking 
more about the "git fetch git://some.random.repo foobar" case where the 
summary also explicitly shows:

From: git://some.random.repo
  ......  foobar   -> FETCH_HEAD

In that case the only reference to the fetched branch is stored in 
FETCH_HEAD and that is what might be worthwile for a reflog.


Nicolas
