From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: git push sometimes reports failure, but push operations seems to
 be OK
Date: Tue, 18 Mar 2008 18:10:43 +0100
Message-ID: <47DFF793.1080905@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 20:32:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc415-0006jn-Kp
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728AbYCST1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752620AbYCST1R
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:27:17 -0400
Received: from dorado.et.put.poznan.pl ([150.254.11.146]:55023 "EHLO
	dorado.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbYCST1K (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:27:10 -0400
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by dorado.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m2IHBVjQ024698
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 18:11:37 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [192.168.1.4] (adfy188.neoplus.adsl.tpnet.pl [79.184.128.188])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m2IHAh606595
	for <git@vger.kernel.org>; Tue, 18 Mar 2008 18:10:43 +0100 (MET)
User-Agent: Thunderbird 2.0.0.12 (X11/20080229)
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.4.1.325704, Antispam-Engine: 2.6.0.325393, Antispam-Data: 2008.3.18.93259
X-PMX-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __STOCK_PHRASE_7 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77510>

Hi,

I am using git with git-svn for working with two branches from one SVN 
repository. For backup purposes, I have also one remote repository to 
which I push my local Git branches (topic) and these two tracked SVN 
branches. The remote Git repository is only for my private purposes so I 
sometimes rewind it.
When pushing my changes to this remote Git repository I usually (but not 
always) get this error message:

=====8<=====
Counting objects: 22, done.
Compressing objects: 100% (12/12), done.
Writing objects: 100% (12/12), 1.92 KiB, done.
Total 12 (delta 11), reused 0 (delta 0)
To boreas.<hidden-domain>:/home/ediap/git/itpp.git
    410c244..09d4d2e  itpp-4-0 -> itpp-4-0
    0ecd5bb..a9fce92  master -> master
error: failed to push some refs to 
'boreas.<hidden-domain>:/home/ediap/git/itpp.git'
=====8<=====

*) please ignore the <hidden-domain> in the above ;)

However, the push operation seems to be OK (all commits are properly 
transferred to the remote repository). By adding some fprintf() into git 
code I managed to check that the finish_connect() function returns -255.


Here is the relevant part of configuration of my local Git repository:
=====8<=====
[remote "boreas"]
	url = boreas.<hidden-domain>:/home/ediap/git/itpp.git
	fetch = +refs/heads/*:refs/remotes/boreas/*
	push = master
	push = itpp-4-0
=====8<=====

Remote repository is on quite old SUN OS Solaris system:
=====8<=====
ediap@boreas ~/git/itpp.git % uname -a
SunOS boreas 5.9 Generic_112233-10 sun4u sparc SUNW,Sun-Blade-100
=====8<=====

The remote host uses the stable git version:
=====8<=====
ediap@boreas ~/git/itpp.git % git --version
git version 1.5.4.4
=====8<=====

My local git installation is:
=====8<=====
ediap@lespaul ~/tmp/build/itpp-git $ git --version
git version 1.5.4.4.532.ga6828.dirty
=====8<=====
on a Gentoo Linux x86 system:
=====8<=====
ediap@lespaul ~/tmp/build/itpp-git $ uname -a
Linux lespaul 2.6.24-gentoo-r3 #2 SMP Fri Mar 14 10:24:13 CET 2008 i686 
Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz GenuineIntel GNU/Linux
=====8<=====

Have you encountered similar issues with git push? Do you have any idea 
what should I check in my setup?

Thanks for any hints.
BR,
/Adam

PS. This problem is nothing new, so it is definitely not a regression in 
one the latest Git releases.


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
