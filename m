From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 22:08:20 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080824202325.GA14930@eagain.net>  <7vfxoukv56.fsf@gitster.siamese.dyndns.org>  <20080824203825.GB14930@eagain.net>  <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>  <20080824222534.GC14930@eagain.net>  <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
  <48B29B2A.6000802@gnu.org>  <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, Tommi Virtanen <tv@eagain.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 22:05:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXiIb-00036Q-Or
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 22:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbYHYUDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 16:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753787AbYHYUDU
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 16:03:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:54363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753242AbYHYUDT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 16:03:19 -0400
Received: (qmail invoked by alias); 25 Aug 2008 20:03:17 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 25 Aug 2008 22:03:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Ta9g/aCfT3xg3o2covNvUWGdSV/lzSDgrx6VkHR
	xr66ZKLvPxxhTq
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93664>

Hi,

On Mon, 25 Aug 2008, Mikael Magnusson wrote:

> 2008/8/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > On Mon, 25 Aug 2008, Paolo Bonzini wrote:
> >
> >> > That would involve you actually finding out what's happening, 
> >> > though.
> >>
> >> He said so:
> >>
> >> > test:x:1001:1001:,,,:/home/test:/usr/bin/git shell
> >> >
> >> > just makes ssh loop asking for a password, logging
> >> >
> >> > "User test not allowed because shell /usr/bin/git shell does not 
> >> > exist"
> >
> > Okay, so this means that you cannot pass arguments to the login shell. 
> > Makes me wonder... I had the impression that bash was called with 
> > --login.
> 
> When you login, a '-' is prepended in argv[0], ie, bash checks if it's 
> called "-bash". This is documented in man bash, but I couldn't find it 
> in man login or man agetty, not sure where else it might be written 
> down.

Thanks!

So does this mean that we could check in git.c if there is a leading "-" 
in argv[0]?  If so, then the builtin git-shell should be called by 
default.

At least I do not expect many instances of git being called with argv[0] 
starting with a "-"... :-)

Ciao,
Dscho
