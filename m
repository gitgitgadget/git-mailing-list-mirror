From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 1/6] Refactor git tag objects; make "tag" header optional;
 introduce new optional "keywords" header
Date: Mon, 04 Jun 2007 09:30:14 +0200
Message-ID: <200706040930.14287.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040252.55152.johan@herland.net> <20070604060812.GC15148@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:30:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv71L-0004th-W4
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071AbXFDHaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbXFDHaV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:30:21 -0400
Received: from smtp.getmail.no ([84.208.20.33]:54689 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752071AbXFDHaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:30:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300M03OUHS100@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 09:30:18 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300EC9OUESF30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 09:30:14 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300GBZOUEJKE0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 09:30:14 +0200 (CEST)
In-reply-to: <20070604060812.GC15148@moooo.ath.cx>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49075>

On Monday 04 June 2007, Matthias Lederhofer wrote:
> Johan Herland <johan@herland.net> wrote:
> > 1. Make the "tag" header optional. The "tag" header contains the tag 
name,
> >    which is optional for 'notes'. The new semantics for the "tag" header
> >    are as follows: The tag header _must_ be given for signed tags (this
> >    is already enforced by git-tag.sh). When the tag header is not given,
> >    its value defaults to the empty string.
> 
> Why must signed tags have a tag header?  Will notes optionally have a
> tag header?

The purpose of signing a tag is to cryptographically verify the thing 
pointed at by the tag. But you also want to protect the tag itself. In 
order to make it harder for someone to rename a signed tag (thereby opening 
the door to replacing it with a different - possibly signed - malicious 
tag), you want to include the tag name in the signed data. This allows us 
to verify that the tag ref (as stored in '.git/refs') is identical to the
tag name stored inside the signed object.


Yes, 'notes' will optionally have a "tag" header. When I originally designed  
notes, I didn't think anybody would want to name their notes, but Linus 
requested it, and there's no technical argument against it. Note that if 
you name your note, and put a ref to it (under '.git/refs'), there's 
technically no distinction between a tag object and a note object, except 
what you choose to put in the "keywords" header, of course.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
