From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] Fix failed tag parsing when tag object has no body/message
 (and thus ends with a single '\n')
Date: Fri, 08 Jun 2007 10:18:34 +0200
Message-ID: <200706081018.34207.johan@herland.net>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706080208.14571.johan@herland.net>
 <7vd507m159.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 10:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwZgM-0001XM-7P
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 10:18:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936028AbXFHISo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 04:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934424AbXFHISo
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 04:18:44 -0400
Received: from smtp.getmail.no ([84.208.20.33]:50045 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763659AbXFHISl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 04:18:41 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJB0000D5R3KG00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 10:18:39 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJB00H8H5QYH180@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 10:18:34 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJB00JMV5QYK360@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 08 Jun 2007 10:18:34 +0200 (CEST)
In-reply-to: <7vd507m159.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49447>

On Friday 08 June 2007, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> 
> > Thanks to Johannes Schindelin <Johannes.Schindelin@gmx.de> for
> > discovering this.
> >
> > Also add a testcase for this condition.
> >
> > Signed-off-by: Johan Herland <johan@herland.net>
> 
> While this certainly is an improvement, I suspect that your
> parse_tag() does a little too much.  In a format such as "tag"
> object that does header + blank + body, it is customary to allow
> header fields that your version does not understand (assuming
> that such extention will go after the known fields is fine).
> 
> Which means that you should not be even saying "Ok, I've checked all
> headers I know about---there should be a double LF to terminate it",
> as you do not know if headers have ended.

Ok, I'm currently working on a patch series for Dscho and others where I 
split up the big patch ('[PATCH 1/6] Refactor git tag objects; make "tag" 
header optional; introduce new optional "keywords" header') into babysteps.

I can:

1. Provide a new patch series to totally replace the previous 6-part patch 
series (plus bugfixes). The new patch series will make smaller steps and 
end up (hopefully) in a better place, with less overzealous 
checking/parsing, and more "traditional" whitespacing.

OR

2. Provide the babystep-series ending up exactly where we are today (i.e. 
after the patch series, plus bug fixes). Then, provide patches on top of 
the existing series to get it into shape, both scope-wise (i.e. not trying 
to do too much) and whitespace-wise.

Which do you prefer?


...Johan
-- 
Johan Herland, <johan@herland.net>
www.herland.net
