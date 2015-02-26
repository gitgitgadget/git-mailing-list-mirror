From: Thomas Klausner <tk@giga.or.at>
Subject: weird behaviour in git
Date: Thu, 26 Feb 2015 15:12:34 +0100
Message-ID: <20150226141234.GP19896@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 26 15:22:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQzKs-0002to-1m
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 15:22:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753877AbbBZOWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 09:22:30 -0500
Received: from danbala.ifoer.tuwien.ac.at ([128.130.168.64]:62134 "EHLO
	danbala.ifoer.tuwien.ac.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753872AbbBZOW3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2015 09:22:29 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Feb 2015 09:22:29 EST
Received: by danbala.ifoer.tuwien.ac.at (Postfix, from userid 116)
	id B0AE3A5AF; Thu, 26 Feb 2015 15:12:34 +0100 (CET)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264443>

Hi!

I've played around with git and found that 'git mv' does not honor
what I tell it to do:

wiz@yt:~> mkdir a
wiz@yt:~> cd a
wiz@yt:~/a> git init .
Initialized empty Git repository in /home/wiz/a/.git/
wiz@yt:~/a> touch a
wiz@yt:~/a> git add a
wiz@yt:~/a> git commit -m 'add a'
[master (root-commit) 99d0ee7] add a
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a
wiz@yt:~/a> git mv a b
wiz@yt:~/a> touch Makefile
wiz@yt:~/a> git add Makefile
wiz@yt:~/a> git commit


# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
# Changes to be committed:
#       renamed:    a -> Makefile
#       new file:   b
#

This is reproducible for me with "git version 2.3.0" on
NetBSD-7.99.5/amd64.

I guess this happens because the checksums of the files are the same
and 'Makefile' is earlier when sorting, but since I explicitly told
"git mv" old and new name, I think that's a bug nevertheless.
 Thomas
