From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: unexpected EOF?
Date: Thu, 1 Dec 2005 10:40:17 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0512011036120.3099@g5.osdl.org>
References: <E1EhohG-0001iZ-IB@jdl.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 19:44:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhtM6-0006TY-DE
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 19:40:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVLASk1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 13:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVLASk1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 13:40:27 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35733 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932400AbVLASk1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 13:40:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jB1IeJnO032641
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Dec 2005 10:40:20 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jB1IeHMl032425;
	Thu, 1 Dec 2005 10:40:18 -0800
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EhohG-0001iZ-IB@jdl.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.57__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13066>



On Thu, 1 Dec 2005, Jon Loeliger wrote:
> 
> I thought I had imagined this last time, but now 
> that it has happened twice, I'm not so sure what
> is going on.  First pull attempt garners an
> unexpected EOF message; immediately pull again
> seems to work.
> 
> jdl@ubuntu:/usr/src/git-core$ git pull origin
> fatal: unexpected EOF
> Fetch failure: git://git.kernel.org/pub/scm/git/git.git/
> jdl@ubuntu:/usr/src/git-core$ git pull origin
> Unpacking 17 objects

The public kernel.org machines are actually _two_ different machines, and 
have two different addresses:

	Non-authoritative answer:
	git.kernel.org  canonical name = zeus-pub.kernel.org.
	Name:   zeus-pub.kernel.org
	Address: 204.152.191.5
	Name:   zeus-pub.kernel.org
	Address: 204.152.191.37

so with a round-robin kind of DNS resolution, you'd get alternate 
machines. Maybe one of them isn't up-to-date due to mirroring problems?

You can test by using the IP addresses explicitly, of course.

In particular, if the directory doesn't exist at all, or if the directory 
doesn't have the "git-daemon-export-ok" flag, the git daemon on the other 
end will just close the connection and refuse to talk to you (I thought 
that was preferable to give any indication of why it fails: from a 
security standpoint, you do _not_ want to be able to test if a random 
directory exists by looking at the return value of git-daemon).

			Linus
