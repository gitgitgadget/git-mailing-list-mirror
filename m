From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 10/21] Free mktag's buffer before dying
Date: Sun, 10 Jun 2007 00:05:11 +0200
Message-ID: <200706100005.11710.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706092346.12359.johan@herland.net>
 <81b0412b0706091500o2c0a8f88xd3808d6ee790d777@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 00:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx93h-0004Lz-8n
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 00:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760711AbXFIWFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758181AbXFIWFR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 18:05:17 -0400
Received: from smtp.getmail.no ([84.208.20.33]:46939 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755419AbXFIWFP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 18:05:15 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00E032OQW500@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:05:14 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00J302OOIH40@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:05:12 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE000JA2ONUA80@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 10 Jun 2007 00:05:12 +0200 (CEST)
In-reply-to: <81b0412b0706091500o2c0a8f88xd3808d6ee790d777@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49633>

On Sunday 10 June 2007, Alex Riesen wrote:
> On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > On Saturday 09 June 2007, Alex Riesen wrote:
> > > On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > > > +       if (parse_and_verify_tag_buffer(0, buffer, size, 1)) {
> > > > +               free(buffer);
> > > > +               die("invalid tag data file");
> > >
> > > This, and the similar one below are useless. You're destroying the
> > > process, what do you free that buffer for? Either handle the error
> > > case or do not needlessly complicate your change, which really
> > > also absolutely unneeded.
> >
> > Well, I was taught to treat my memory with care.
> 
> How do you treat your performance?

Hopefully with care, as well. However, I tend to look at performance _after_
correctness.

> Besides, was that systems with common address space
> where you were taught? Like DOS or MacOS, perhaps?

Nope. Never programmed on either. I thought care with memory was generally
considered a good principle. If I'm wrong, please point me at the relevant
documentation.

> > Right now it doesn't make any difference in practice (except that
> > Valgrind might be a bit happier with it), but in the future -- with
> > the libifaction effort and whatnot -- you never know what might happen
> > to this piece of code, and I'd like to stay on the safe side.
> 
> So that people have to check your free as well (they will have to,
> they come looking for die-calls). You just made more work for them.

Ok. Drop it. This isn't particularily important to me. I just try to
follow good principles when I can.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
