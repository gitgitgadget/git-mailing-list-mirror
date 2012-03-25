From: Ivan Todoroski <grnch_lists@gmx.net>
Subject: Re: Clone fails on a repo with too many heads/tags
Date: Sun, 25 Mar 2012 17:30:04 +0200
Message-ID: <4F6F39FC.2070801@gmx.net>
References: <m3fwd550j3.fsf@localhost.localdomain> <20120318190659.GA24829@sigill.intra.peff.net> <CACsJy8BNT-dY+wDONY_TgLnv0135RZ-47BEVMzX6c3ddH=83Zw@mail.gmail.com> <20120319024436.GB10426@sigill.intra.peff.net> <4F69B5F0.2060605@gmx.net> <CAJo=hJu0H5wfXB_y5XQ6=S0VJ9t4pxHWkuy_=rehJL_6psf00g@mail.gmail.com> <20120321171423.GA13140@sigill.intra.peff.net> <4F6A33C5.2080909@gmx.net> <20120321201722.GA15021@sigill.intra.peff.net> <4F6E3373.7090500@gmx.net> <20120325010609.GB27651@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 17:29:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBpO9-00073H-07
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 17:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756368Ab2CYP3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 11:29:44 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:34352 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756285Ab2CYP3n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 11:29:43 -0400
Received: (qmail invoked by alias); 25 Mar 2012 15:29:41 -0000
Received: from unknown (EHLO [127.0.0.1]) [77.28.166.17]
  by mail.gmx.net (mp010) with SMTP; 25 Mar 2012 17:29:41 +0200
X-Authenticated: #14478976
X-Provags-ID: V01U2FsdGVkX1/949ghyEL9QxR2kNnqUkM4ajkayzRuDOMgqRboyY
	pQPF2EULr3KMQl
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120325010609.GB27651@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193870>

On 25.03.2012 03:06, Jeff King wrote:
> On Sat, Mar 24, 2012 at 09:49:55PM +0100, Ivan Todoroski wrote:
> 
>> Is it failing for anyone else on the vanilla "maint" branch? I would
>> appreciate any help I could get here.
> 
> No, it passes fine here (Debian unstable).

OK, thanks for checking, it's good to know.


> Does your machine have mod_rewrite installed and enabled? I would think
> apache would complain at startup if it wasn't.  I wonder if there's
> something non-portable in the minimal apache config we ship.

Looks like it comes by default with the RPM. Maybe the Apache version is 
too old?

$ rpm -q httpd
httpd-2.2.3-63.el5.centos.1

$ rpm -ql httpd | grep rewrite
/usr/lib64/httpd/modules/mod_rewrite.so

$ ls -l /usr/lib64/httpd/modules/mod_rewrite.so
-rwxr-xr-x 1 root root 60384 Feb 23 19:23 
/usr/lib64/httpd/modules/mod_rewrite.so

$ ls -l trash\ directory.t5551-http-fetch/httpd/modules/mod_rewrite.so
-rwxr-xr-x 1 root root 60384 Feb 23 19:23 trash 
directory.t5551-http-fetch/httpd/modules/mod_rewrite.so


Also, mod_rewrite is enabled in both the master config file 
/etc/httpd/conf/httpd.conf, as well as the minimal 
git/t/lib-httpd/apache.conf.


> Does httpd/error.log in the trash directory say anything interesting?

Nothing, it just gives the startup and shutdown message:

$ cat trash\ directory.t5551-http-fetch/httpd/error.log
[Sun Mar 25 15:27:12 2012] [notice] Apache/2.2.3 (CentOS) configured -- 
resuming normal operations
[Sun Mar 25 15:27:12 2012] [notice] caught SIGTERM, shutting down


I will try your patch from the other message a bit later and let you know.
