From: Rocco Rutte <pdmef@gmx.net>
Subject: Trouble with case-insensitive filesystems
Date: Fri, 26 Oct 2007 16:52:05 +0200
Organization: Berlin University of Technology
Message-ID: <20071026145204.GA294@localhost.daprodeges.fqdn.th-h.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 26 16:52:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlQXy-0006om-Fp
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 16:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXJZOwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 10:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751750AbXJZOwN
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 10:52:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:55166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751548AbXJZOwN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 10:52:13 -0400
Received: (qmail invoked by alias); 26 Oct 2007 14:52:09 -0000
Received: from dslb-088-073-075-228.pools.arcor-ip.net (EHLO localhost.daprodeges.fqdn.th-h.de) [88.73.75.228]
  by mail.gmx.net (mp050) with SMTP; 26 Oct 2007 16:52:09 +0200
X-Authenticated: #1642131
X-Provags-ID: V01U2FsdGVkX1+YUJA4jOCY+P1ltWBO+gDx1NmnEnHVaR1knTFhHZ
	iKhTQHCVdins+3
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-GnuPG-Key: http://user.cs.tu-berlin.de/~pdmef/rrutte.gpg
X-Blog: http://user.cs.tu-berlin.de/~pdmef/horst.cgi?o
X-System: localhost (Darwin 8.10.2 i386)
User-Agent: Mutt/1.5.16 (2007-10-18)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62412>

Hi,

after importing the opensolaris hg repo into git, I noticed that git 
gets confused if the repo contains files that clash on case-insensitive 
filesystems (here on OS X, I can't test Cygwin and Win32). git-checkout 
tells me that these files are modified, git-status gives me:

$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HB
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HB.name
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HI
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HI.name
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HX
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/HX.name
#       modified:   usr/src/cmd/lp/filter/postscript/font/devpost/charlib/LH
#       modified:   usr/src/lib/libldap4/common/Version.c
#
no changes added to commit (use "git add" and/or "git commit -a")

...without touching anything. Yes, there's a version.c file next to 
Version.c, HI.name next to Hi.name and so on.

I'm not really sure what I'm expecting git to do, but I guess I want it 
to abort a checkout and only continue with -f. But at the very least, it 
should issue a big fat warning (one may decide to work in some area 
without clashes).

I really have no idea how to efficiently detect that at runtime and 
which areas of git to look at for patching...

Rocco
