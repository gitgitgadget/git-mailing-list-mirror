From: Adam Borowski <kilobyte@angband.pl>
Subject: [BUG] auto-repack exits prematurely, locking other processing out
Date: Fri, 23 May 2014 21:51:21 +0200
Message-ID: <20140523195121.GA923@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 22:18:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnvuk-0006Z4-FI
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 22:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbaEWUR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 16:17:59 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37330 "EHLO
	tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbaEWUR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 16:17:58 -0400
X-Greylist: delayed 1594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 May 2014 16:17:58 EDT
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.80)
	(envelope-from <kilobyte@tartarus.angband.pl>)
	id 1WnvUv-0000gV-B0
	for git@vger.kernel.org; Fri, 23 May 2014 21:51:21 +0200
Content-Disposition: inline
X-Junkbait: adolf@angband.pl, zareba@angband.pl
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@tartarus.angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250025>

Hi guys!

It looks like the periodic auto-repack backgrounds itself when it shouldn't
do so.  This causes the command it has triggered as a part of to fail:

==========================================================================
[~/linux](master)$ git pull --rebase
remote: Counting objects: 455, done.
remote: Compressing objects: 100% (64/64), done.
remote: Total 267 (delta 208), reused 262 (delta 203)
Receiving objects: 100% (267/267), 44.43 KiB | 0 bytes/s, done.
Resolving deltas: 100% (208/208), completed with 80 local objects.
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux
   4b660a7..f02f79d  master     -> linus/master
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
First, rewinding head to replay your work on top of it...
Applying: perf: tools: fix missing casts for printf arguments.
Applying: vt: emulate 8- and 24-bit colour codes.
fatal: Unable to create '/home/kilobyte/linux/.git/refs/heads/master.lock': File exists.

If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
Could not move back to refs/heads/master
[~/linux]((no branch, rebasing (null)))$
==========================================================================

-- 
Gnome 3, Windows 8, Slashdot Beta, now Firefox Ribbon^WAustralis.  WTF is going
on with replacing usable interfaces with tabletized ones?
