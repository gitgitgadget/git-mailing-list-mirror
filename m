From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user
 manual
Date: Wed, 9 May 2007 11:38:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091137190.4167@racer.site>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site>
 <20070508210153.GA3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705082306100.4167@racer.site>
 <20070508213158.GB3969@diana.vm.bytemark.co.uk> <Pine.LNX.4.64.0705090105450.4167@racer.site>
 <Pine.LNX.4.64.0705090015360.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-155027006-1178703514=:4167"
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	bfields@citi.umich.edu, junio@cox.net, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed May 09 11:38:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlid2-0006eN-2F
	for gcvg-git@gmane.org; Wed, 09 May 2007 11:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbXEIJia (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 05:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754275AbXEIJia
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 05:38:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:38778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754069AbXEIJi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 05:38:29 -0400
Received: (qmail invoked by alias); 09 May 2007 09:38:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 09 May 2007 11:38:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++dwFozpG+g+kOhmYie9qEWCgIs7ByzYG799bReO
	+cDfN/y/X0eUgN
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705090015360.18541@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46691>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-155027006-1178703514=:4167
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 9 May 2007, Daniel Barkalow wrote:

> On Wed, 9 May 2007, Johannes Schindelin wrote:
> 
> > On Tue, 8 May 2007, Karl Hasselström wrote:
> > 
> > > On 2007-05-08 23:07:04 +0200, Johannes Schindelin wrote:
> > > 
> > > > On Tue, 8 May 2007, Karl Hasselström wrote:
> > > >
> > > > > On 2007-05-08 17:10:47 +0200, Johannes Schindelin wrote:
> > > > >
> > > > > > +  char *`, but is actually expected to be a pointer to `unsigned
> > > > > > +  char[20]`.  This variable will contain the big endian version of the
> > > > > > +  40-character hex string representation of the SHA-1.
> > > > >
> > > > > Either it should be "unsigned char[40]" (or possibly 41 with a
> > > > > terminating \0), or else you shouldn't be talking about
> > > > > hexadecimal since it's just a 20-byte big-endian unsigned integer.
> > > > > (A third possibility is that I'm totally confused.)
> > > >
> > > > It is 40 hex-character, but 20 _byte_. If you have any ideas how to
> > > > formulate that better than I did...
> > > 
> > > I think this is less confusing:
> > > 
> > >   This variable will contain the 160-bit SHA-1.
> > > 
> > > It avoids talking of hex, since it's not really stored in hex format
> > > any more than any other binary number with a number of bits divisible
> > > by four. And it avoids saying big-endian, which is not relevant anyway
> > > since we don't use hashes as integers.
> > 
> > Well, I do not buy into that. First, we _have_ to say that it is 
> > big-endian. It was utterly confusing to _me_ that the hash was not little 
> > endian, as I expected on an Intel processor.
> 
> SHA-1 is defined as producing a octet sequence, and to have a canonical 
> hex digit sequence conversion with the high nibbles first. Internally, it 
> is canonically specified using big-endian math, but the same algorithm 
> could equally be specified with little-endian math and different rules for 
> input and output.
> 
> > And I'd rather mention the hex representation (what you see in git-log and 
> > git-ls-tree). This helps debugging, believe me.
> 
> It's kind of important to distinguish between the hex representation and 
> the octet representation, because your code will not work at all if you 
> use the wrong one. And "unsigned char *" or "unsigned char[20]" is always 
> the octets; the hex is always "char *". Primarily mentioning the one that 
> is more intuitive but less frequently used doesn't help with understanding 
> the actual code.

That's a really good idea, to point out that "unsigned char *" refers to 
octets, while "char *" refers to the ASCII representation. I will add 
this, together with a simple example (the initial commit).

Ciao,
Dscho

--8323584-155027006-1178703514=:4167--
