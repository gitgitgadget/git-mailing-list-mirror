From: Andrew Keller <andrew@kellerfarm.com>
Subject: Installing git-svn on Linux without root
Date: Fri, 3 Feb 2012 21:10:32 -0500
Message-ID: <35EF289A-1408-4B70-A25F-8194A8884A4D@kellerfarm.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 04 03:56:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtVnr-0008GP-1H
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 03:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752636Ab2BDC40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 21:56:26 -0500
Received: from sanjose.tchmachines.com ([208.76.86.38]:59872 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab2BDC4Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 21:56:25 -0500
X-Greylist: delayed 2726 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Feb 2012 21:56:25 EST
Received: from c-208-53-113-112.customer.broadstripe.net ([208.53.113.112] helo=[192.168.0.197])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1RtV5W-0004e0-SJ
	for git@vger.kernel.org; Fri, 03 Feb 2012 21:10:51 -0500
X-Mailer: Apple Mail (2.1084)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189837>

I am attempting to install git, including the ability to access subversion repositories on a Linux machine.  I do not have root access on the machine, so I prepended my PATH with a folder in my home directory.

Installing Git worked just fine, but when I try to clone a subversion repository, I get:

$ git svn clone file:///svn --prefix=svn/ --no-metadata --trunk=dba/trunk --branches=dba/branches --tags=dba/tags dba
Initialized empty Git repository in /home/kelleran/Documents/togit/converted/dba/.git/
Can't locate SVN/Core.pm in @INC (@INC contains: /homedirs/kelleran/local/lib/perl5/site_perl/5.8.8 /usr/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi /usr/lib/perl5/site_perl/5.8.8 /usr/lib/perl5/site_perl /usr/lib64/perl5/vendor_perl/5.8.8/x86_64-linux-thread-multi /usr/lib/perl5/vendor_perl/5.8.8 /usr/lib/perl5/vendor_perl /usr/lib64/perl5/5.8.8/x86_64-linux-thread-multi /usr/lib/perl5/5.8.8 .) at /homedirs/kelleran/local/libexec/git-core/git-svn line 41.

Google suggested that the above error could be due to missing perl bindings.  So, I installed swig, and followed the instructions for installing the perl bindings: http://svn.apache.org/repos/asf/subversion/trunk/subversion/bindings/swig/INSTALL (I used the alternate build steps, since I had to set the prefix).

Unfortunately, I still get exactly the same error.  So, I looked to see whether or not the missing library was installed:

$ find ~/local -iname Core.pm
/homedirs/kelleran/local/lib64/perl5/site_perl/5.8.8/x86_64-linux-thread-multi/SVN/Core.pm

So, the module does exist, but not in a location included by @INC.  This sounds like a simple misconfiguration during the installation on my part, but after reading the manuals and searching the web, I was unable to find a parameter that gets git to be able to see the perl bindings.

I'm guessing I need either more sleep or a fresh point of view.  Any thoughts?

The machine is running Linux 2.6.32 64-bit, and has perl 5.8.8.  Of the software I installed, I am using:
  libpcre 8.21
  swig 2.8.4
  neon 0.29.6
  apr 1.3.x
  apr-util 1.3.x
  subversion 1.7.2
  git 1.7.9

Thanks,
Andrew Keller
