From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: Re: [PATCH 5/5] struct sockaddr_storage->ss_family is not portable
Date: Sun, 25 Apr 2010 03:36:44 -0500 (CDT)
Message-ID: <20100312151522.GA11943@thor.il.thewrittenword.com>
References: <20100311163715.GE7877@thor.il.thewrittenword.com>
 <alpine.DEB.2.00.1003111838260.29993@cone.home.martin.st>
 <20100312045654.GH7877@thor.il.thewrittenword.com>
 <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Storsj? <martin@martin.st>
X-From: git-owner@vger.kernel.org Sun Apr 25 10:37:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5xKy-0006Dx-4T
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 10:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab0DYIgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Apr 2010 04:36:46 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:64563 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0DYIgp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Apr 2010 04:36:45 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 47EF25CEE
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:57:47 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 47EF25CEE
Received: from localhost.localdomain (unknown [192.168.1.254])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 008BDA77
	for <git@vger.kernel.org>; Sun, 25 Apr 2010 08:36:45 +0000 (UTC)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id AF8C057C; Sun, 25 Apr 2010 03:36:44 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145723>

Hi Martin,

On Fri, Mar 12, 2010 at 09:24:01AM +0200, Martin Storsj? wrote:
> On Fri, 12 Mar 2010, Gary V. Vaughan wrote:
> > On Thu, Mar 11, 2010 at 06:40:37PM +0200, Martin Storsj? wrote:
> > > On Thu, 11 Mar 2010, Gary V. Vaughan wrote:
> > > 
> > > > Many of our supported platforms do not have this declaration, for
> > > > example solaris2.6 thru 2.7.  Lack of ss_family implies no IPV6
> > > > support, so we can wrap all the ss_family references in an ifndef
> > > > NO_IPV6, and assume sockaddr_in otherwise.
> > > 
> > > While this probably is ok as such, you can actually do the same without 
> > > accessing the sockaddr_storage->ss_family; just cast it to (const struct 
> > > sockaddr*) and use ->sa_family instead, that should work just as well, as 
> > > far as I know.
> > 
> > At least on aix-5.2 it won't be reliable unless you juggle compiler
> > switches just right [...]
> 
> Yes, but if the sockaddr struct can be arranged in different ways, the 
> other ones (sockaddr_in, sockaddr_storage, sockaddr_in6) must also be 
> defined coherently - you're always supposed to be able to cast an 
> sockaddr_in (or any other of them) to a sockaddr and read the sa_family 
> field. As far as I know, at least.

Ah, good point.  And now, having tested that on all our machines it
works perfectly, and is much more elegant!

I'll resubmit presently.

Cheers,
-- 
Gary V. Vaughan (gary@thewrittenword.com)
