From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: Git sideband hook output
Date: Wed, 09 Jun 2010 09:44:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006090934320.30664@xanadu.home>
References: <AANLkTinLWDFTn7bhcF3Vk-q9aw4lJC2vFj95M9bxLbBT@mail.gmail.com>
 <20100608214632.GN14847@spearce.org>
 <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 15:44:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMLZs-0000QH-8w
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 15:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757767Ab0FINoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 09:44:14 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17428 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813Ab0FINoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 09:44:14 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L3R00KEZ25P1PG0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 09 Jun 2010 09:44:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <A612847CFE53224C91B23E3A5B48BAC744839BF3DD@xmail3.se.axis.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148778>

On Wed, 9 Jun 2010, Peter Kjellerstedt wrote:

> > -----Original Message-----
> > From: git-owner@vger.kernel.org [mailto:git-owner@vger.kernel.org] On
> > Behalf Of Shawn O. Pearce
> > Sent: den 8 juni 2010 23:47
> > To: Scott Chacon
> > Cc: git list
> > Subject: Re: Git sideband hook output
> > 
> > Scott Chacon <schacon@gmail.com> wrote:
> > > Prior to 6d525d where Shawn made the receive-pack process send hook
> > > output over side band #2, how did the hook output get sent to the
> > > client?
> > 
> > It was sent over stderr, which was proxied down to the client by
> > the SSH daemon.
> > 
> > > On older clients (before this commit) and on older servers,
> > > the hook output just shows up without the 'remote:' prefix.
> > 
> > Because its echoed to the tty by the SSH client, without Git ever
> > seeing it.
> > 
> > > After
> > > this commit I get the 'remote:' prefix,
> 
> This explains the messy output from hooks I have seen since 
> updating to 1.7.1...
> 
> > Now its being parsed out of the stream by the git client, using
> > the same code that displays the progress messages during clone/fetch.
> > 
> > > which is kind of annoying.
> > 
> > Depends on your perspective.  Its nice to know that the messages
> > came from the server, rather than from your client.  :-)
> 
> And it is very annoying that the output format has suddenly changed
> so that the output from hooks that rely on the previous no-prefix
> format no longer fit on an 80 char wide terminal where they used to
> fit just fine.

Fix your hook output then.

> > > Is
> > > there a way to suppress this to get the old output format?
> > 
> > No.  Other than to have the hook not output anything at all.
> > 
> > --
> > Shawn.
> 
> Here is +1 for giving us back the no-prefix output. I would like
> to suggest adding a configuration option to allow users to enable 
> the "remote: " prefix if they want it.

Would be much more logical to fix the hook output, and keep hook 
developers honnest by not confusing the user with output that isn't 
local stuff.

-1


Nicolas
