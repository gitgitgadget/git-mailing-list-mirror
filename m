X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jeff Garzik <jeff@garzik.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Sun, 10 Dec 2006 17:14:31 -0500
Message-ID: <457C86C7.2070000@garzik.org>
References: <Pine.LNX.4.64.0612020835110.3476@woody.osdl.org>	 <200612102011.52589.jnareb@gmail.com>	 <Pine.LNX.4.64.0612101129190.12500@woody.osdl.org>	 <200612102127.05894.jnareb@gmail.com>	 <Pine.LNX.4.64.0612101228590.12500@woody.osdl.org> <46a038f90612101401m5f65aefbh78f7adf84725ade4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 22:14:52 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Rogan Dawes <discard@dawes.za.net>,
	Kernel Org Admin <ftpadmin@kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
In-Reply-To: <46a038f90612101401m5f65aefbh78f7adf84725ade4@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33940>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtWwV-0000O3-Oo for gcvg-git@gmane.org; Sun, 10 Dec
 2006 23:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758499AbWLJWOf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 17:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758792AbWLJWOf
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 17:14:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:41310 "EHLO mail.dvmed.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1758499AbWLJWOf
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2006 17:14:35 -0500
Received: from cpe-065-190-194-075.nc.res.rr.com ([65.190.194.75]
 helo=[10.10.10.10]) by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat
 Linux)) id 1GtWwK-0002vs-Mp; Sun, 10 Dec 2006 22:14:33 +0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Sender: git-owner@vger.kernel.org

Martin Langhoff wrote:
> On 12/11/06, Linus Torvalds <torvalds@osdl.org> wrote:
>> Sure, if the proxies actually do the rigth thing (which they may or may
>> not do)
> 
> For a high-traffic setup like kernel.org, you can setup a local
> reverse proxy -- it's a pretty standard practice. That allows you to
> control a well-behaved and locally tuned caching engine just by
> emitting good headers.
> 
> It beats writing and maintaining an internal caching mechanism for
> each CGI script out there by a long mile. It means there'll be no
> further tunables or complexity for administrators of other gitweb
> installs.

If gitweb produced cache-friendly headers, squid could definitely serve 
as an HTTP front-end ("HTTP accelerator" mode in squid talk).

In fact, given kernel.org's slave1/slave2<->master setup, that's a 
pretty natural fit for caching files and/or cache-aware CGI output.

You could even replace rsync to the slaves, if squid was serving as the 
front-end accelerator running on the slaves, communicating to the master.

squid is smart enough to hold off a thundering herd, and only pulls 
single cacheable copies of files as needed.

	Jeff

