From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --no-reuse-delta option to git-gc
Date: Mon, 11 Jun 2007 11:20:57 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706111109430.4059@racer.site>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu> <11786309072612-git-send-email-tytso@mit.edu>
 <11786309071033-git-send-email-tytso@mit.edu> <Pine.LNX.4.64.0705090056231.18541@iabervon.org>
 <7v3b26xvjo.fsf@assigned-by-dhcp.cox.net> <46418E24.9020309@midwinter.com>
 <20070509191052.GD3141@spearce.org> <466BAAD0.9060408@vilain.net>
 <alpine.LFD.0.99.0706102144080.12885@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Steven Grimm <koreth@midwinter.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Jun 11 12:24:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hxh4h-0000Gt-Aw
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 12:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478AbXFKKYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 06:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757614AbXFKKYU
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 06:24:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:48191 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757100AbXFKKYT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 06:24:19 -0400
Received: (qmail invoked by alias); 11 Jun 2007 10:24:18 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp016) with SMTP; 11 Jun 2007 12:24:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19J1PlXWf5JmL39n0Rkf50CofVQ1zdF9RKjI6QZZn
	ejtfhioMeUpf6a
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.0.99.0706102144080.12885@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49841>

Hi,

On Sun, 10 Jun 2007, Nicolas Pitre wrote:

> On Sun, 10 Jun 2007, Sam Vilain wrote:
> 
> > Anyway it's a free world so be my guest to implement it, I guess if 
> > this was selectable it would only be a minor annoyance waiting a bit 
> > longer pulling from from some repositories, and it would be 
> > interesting to see if it did make a big difference with pack file 
> > sizes.
> 
> It won't happen for a simple reason: to be backward compatible with 
> older GIT clients.  If you have your repo compressed with bzip2 and an 
> old client pulls it then the server would have to decompress and 
> recompress everything with gzip.  If instead your repo remains with gzip 
> and a new client asks for bzip2 then you have to recompress as well 
> (slow).  So in practice it is best to remain with a single compression 
> method.

With the extension mechanism we have in place, the client can send what 
kind of compression it supports, and the server can actually refuse to 
send anything if it does not want to recompress.

What I am trying to say: you do not necessarily have to allow every client 
to access that particular repository. I agree that mixed-compression repos 
are evil, but nothing stands in the way of a flag allowing (or 
disallowing) recompression in a different format when fetching.

So if you should decide someday to track data with Git (remember: Generic 
Information Tracker, not just source code), that is particularly unfit for 
compression with gzip, but that you _need_ to store in a different 
compressed manner, you can set up a repository which will _only_ _ever_ 
use that compression.

Of course, you'd need to prepare Git for that, but I could imagine 
something like a music library, which stores everything as ogg encoded 
snippets. It might even use some perception-based hash on small chunks of 
the music, and store the music as tree objects, which concatenate the 
small chunks. I might even try to do this for fun, some day in the distant 
future.

It's a wild world,
Dscho
