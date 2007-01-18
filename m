From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Use fixed-size integers for .idx file I/O
Date: Thu, 18 Jan 2007 16:30:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701181630070.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vd55col04.fsf@assigned-by-dhcp.cox.net>
 <118833cc0701180651w3b5ac164m4e396399f1d58cb7@mail.gmail.com>
 <45AF8A86.7070101@fs.ei.tum.de> <20070118152107.GA15428@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Morten Welinder <mwelinder@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 18 16:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZE8-0003GG-EX
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbXARPaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbXARPaz
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:30:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:43289 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932462AbXARPay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:30:54 -0500
Received: (qmail invoked by alias); 18 Jan 2007 15:30:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp048) with SMTP; 18 Jan 2007 16:30:53 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070118152107.GA15428@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37109>

Hi,

On Thu, 18 Jan 2007, Shawn O. Pearce wrote:

> Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> > Morten Welinder wrote:
> > >>-                       return ntohl(*((unsigned int *) ((char *) 
> > >>index + (24 * mi))));
> > >>+                       return ntohl(*((uint32_t *)((char *)index + 
> > >>(24 * mi))));
> > >
> > >Is that pointer gymnastics guaranteed to work?  I.e., how do we know
> > >that we can access an uint32_t (or unsigned) at such an address?
> > 
> > if index is always aligned to a 4-byte boundary, this is safe.  apart from 
> > that, the problem already existed.
> 
> Its always 4-byte aligned here.  The index is mmap()'d as one huge
> chunk so the first byte of the index is page aligned.  The index
> starts out with 256 4-byte words, then is composed of 24 byte units
> (20 byte SHA1, 4 byte offset).  So no worries with the current file
> format, or code.
> 
> Yes, we're taking the leap of faith that any currently-used processor
> will work on 32 bit unsigned integers if they are 4 byte aligned in
> memory.

Actually, it's even valid in 8 byte aligned mode. (24 is divisible by 8.)

Ciao,
Dscho
