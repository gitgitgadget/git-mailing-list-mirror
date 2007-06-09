From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 07/21] Copy the remaining differences from verify_tag() to
 parse_tag_buffer_internal()
Date: Sat, 09 Jun 2007 23:39:12 +0200
Message-ID: <200706092339.12821.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090215.31731.johan@herland.net>
 <81b0412b0706091431h3a786aaew342693a667938d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 09 23:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hx8eV-0000XO-6q
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 23:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456AbXFIVjS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Jun 2007 17:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758236AbXFIVjS
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jun 2007 17:39:18 -0400
Received: from smtp.getmail.no ([84.208.20.33]:64336 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756996AbXFIVjR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jun 2007 17:39:17 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJE00D051HG0E00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:39:16 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE00JNS1HDID30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:39:13 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJE000HC1HDV690@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sat, 09 Jun 2007 23:39:13 +0200 (CEST)
In-reply-to: <81b0412b0706091431h3a786aaew342693a667938d9@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49625>

On Saturday 09 June 2007, Alex Riesen wrote:
> On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > +               /* Verify the tag-name: we don't allow control characters or spaces in it */
> > +               for (i = 4;;) {
> > +                       unsigned char c = tag_line[i++];
> > +                       if (c == '\n')
> > +                               break;
> > +                       if (c > ' ')
> > +                               continue;
> > +                       return error("char" PD_FMT ": could not verify tag name", tag_line + i - data);
> > +               }
> 
> This looks very familiar. Haven't you just made a very useless patch
> which had this very same code? How about putting it in its own
> function and just call it from these two places? And what problem
> do you have with pointers?!

I just answered your comment on the previous patch, and that answer should
apply here as well.

I'm probably splitting this up into too small pieces, since I keep getting
comments that fail to see the overall picture of what I'm trying to do,
namely taking two similar pieces of code and slowly unifying them to the
point where I can replace one of them by a call to the other (see the two
next patches).

Hope this helps,


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
