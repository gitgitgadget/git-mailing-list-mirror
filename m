From: Randy Brandenburg <randy.brandenburg@woh.rr.com>
Subject: Re: Unable to fork off sideband demultiplexer
Date: Thu, 2 Jun 2011 15:29:04 +0000 (UTC)
Message-ID: <loom.20110602T172442-653@post.gmane.org>
References: <loom.20110601T161508-689@post.gmane.org> <7vk4d5h3qt.fsf@alter.siamese.dyndns.org> <20110601173524.GF7132@sigill.intra.peff.net> <loom.20110601T210757-955@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 17:29:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS9pu-0002Dh-Oc
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 17:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992Ab1FBP3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 11:29:21 -0400
Received: from lo.gmane.org ([80.91.229.12]:45260 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab1FBP3U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 11:29:20 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QS9pj-000288-Pl
	for git@vger.kernel.org; Thu, 02 Jun 2011 17:29:16 +0200
Received: from pm2-users.caci.com ([204.194.77.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 17:29:15 +0200
Received: from randy.brandenburg by pm2-users.caci.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Jun 2011 17:29:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 204.194.77.3 (Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; .NET CLR 1.1.4322; .NET CLR 2.0.50727; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648; InfoPath.2; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; MS-RTC LM 8))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174957>

Randy Brandenburg <randy.brandenburg <at> woh.rr.com> writes:

> 
> Jeff King <peff <at> peff.net> writes:
> > 
> > I suspect it is more subtle than that. We've had several people recently
> > reporting the same issue, and all are using pre-built binaries on
> > Solaris 9. Given the weird errno value ("unknown error"), my guess is
> > that the packages are built on Solaris 10, and there is some ABI
> > incompatibility between the two platforms.
> > 
> > I'd be curious if building on Solaris 9, even without NO_PTHREADS set,
> > fixes the issue.
> > 
> > -Peff
> > 
> 
> Thank you for the insight. I will attempt to rebuild on the target platform 
and 
> see what happens. 
> 
> I will post the results when I have an answer on whther that helped or not.
> 
> 

I rebuilt git-1.7.5 from source on the Solaris 9 platform with gcc-3.4.6, GNU 
make 3.82, and GNU install (from coreutils 8.11). Following these steps

----------------------------------------------------------------------------
# ./configure CC=gcc

Edit the Makefile - set the path to "ar", "gcc" and GNU "install".
CC = /usr/local/bin/gcc
AR = /usr/ccs/bin/ar
INSTALL = /usr/local/bin/install
Look for ifeq ($(uname_S),SunOS) and set INSTALL to /usr/lcoal/bin/install

# gmake NO_TCLTK=1 NO_CURL=1 NO_PTHREADS=YesPlease install prefix=/opt/sfw
# git --version
git version 1.7.5
----------------------------------------------------------------------------
Preliminary testing indicates a working system -- will investigate thourough 
today and tomorrow.

Thanks for the tips!

- Randy
