From: Nicolas Pitre <nico@cam.org>
Subject: Re: git push failing, unpacker error
Date: Fri, 09 Nov 2007 14:27:39 -0500 (EST)
Message-ID: <alpine.LFD.0.9999.0711091416070.21255@xanadu.home>
References: <9e4733910711082155t62df9d4by10bd3f546ffbd950@mail.gmail.com>
 <9e4733910711090637tcf7e837na863a4276578bf3f@mail.gmail.com>
 <9e4733910711090643t493b0e6fl2a18390a2f9ab842@mail.gmail.com>
 <7vtznvtii4.fsf@gitster.siamese.dyndns.org>
 <9e4733910711091009q2c6409fdj75cf8051d073c9c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 20:28:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqZWW-0004g2-ED
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 20:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751048AbXKIT15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 14:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbXKIT14
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 14:27:56 -0500
Received: from relais.videotron.ca ([24.201.245.36]:16516 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbXKIT14 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 14:27:56 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JR900AGB7E3QLL0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 09 Nov 2007 14:27:39 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910711091009q2c6409fdj75cf8051d073c9c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64252>

On Fri, 9 Nov 2007, Jon Smirl wrote:

> On 11/9/07, Junio C Hamano <gitster@pobox.com> wrote:
> > "Jon Smirl" <jonsmirl@gmail.com> writes:
> >
> > > On 11/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > >> I updated both sides to current git and it still fails. How do I debug this?
> > >> What's causing this, "error: pack-objects died with strange error"?
> > >
> > > My remote host is running 2.4.32, is git ok on that kernel?
> >
> > No problem that I am aware of.  We are not *that* intimate with
> > the kernel.
> >
> > Do "git-fsck --full" on both repositories pass?
> 
> I've just discovered that the hosting company has a mechanism for
> killing processes that it believes are consuming too much memory. When
> git does it's mmap's it looks like it is using over 512MB of memory
> which causes it to get zapped. At least I think this is what is
> happening.

You might be interested by the following config variables:

	core.packedGitWindowSize
	core.packedGitLimit
	core.deltaBaseCacheLimit
	pack.windowMemory
	pack.deltaCacheSize

Certainly one or more of them could be tweaked in the remote repo to 
solve your problem. But since your problem happens on push then you 
should look at the core variables first.


Nicolas
