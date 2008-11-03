From: Miquel van Smoorenburg <mikevs@xs4all.net>
Subject: git bisect v2.6.27 v2.6.26 problem/bug
Date: Mon, 3 Nov 2008 18:39:15 +0100
Message-ID: <20081103173911.GA12363@xs4all.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mikevs@xs4all.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 18:57:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx3fF-0001Vx-7s
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 18:56:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbYKCRzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 12:55:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752297AbYKCRzS
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 12:55:18 -0500
Received: from smtp-vbr16.xs4all.nl ([194.109.24.36]:4459 "EHLO
	smtp-vbr16.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbYKCRzR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 12:55:17 -0500
X-Greylist: delayed 959 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Nov 2008 12:55:17 EST
Received: from n2o.xs4all.nl (n2o.xs4all.nl [194.109.0.112])
	by smtp-vbr16.xs4all.nl (8.13.8/8.13.8) with ESMTP id mA3HdF1V084841;
	Mon, 3 Nov 2008 18:39:15 +0100 (CET)
	(envelope-from mikevs@xs4all.net)
Received: from mikevs by n2o.xs4all.nl with local (Exim 4.69)
	(envelope-from <mikevs@xs4all.net>)
	id 1Kx3OV-00041c-3D; Mon, 03 Nov 2008 18:39:15 +0100
Content-Disposition: inline
X-NCC-RegID: nl.xs4all
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99967>

I'm trying to nail down a disk statistics issue that was introduced
in 2.6.27, while 2.6.26 was working OK. So I decided to use git bisect.

However, sometimes I end up with a version before 2.6.26:

$ cat .git/BISECT_LOG
git-bisect start
# good: [bce7f793daec3e65ec5c5705d2457b81fe7b5725] Linux 2.6.26
git-bisect good bce7f793daec3e65ec5c5705d2457b81fe7b5725
# bad: [3fa8749e584b55f1180411ab1b51117190bac1e5] Linux 2.6.27
git-bisect bad 3fa8749e584b55f1180411ab1b51117190bac1e5
# bad: [dd9ca5d9be7eba99d685d733e23d5be7110e9556] USB: usb-serial: fix a sparse warning about different signedness
git-bisect bad dd9ca5d9be7eba99d685d733e23d5be7110e9556
# good: [84c3d4aaec3338201b449034beac41635866bddf] Merge commit 'origin/master'
git-bisect good 84c3d4aaec3338201b449034beac41635866bddf

$ head -4 Makefile 
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 26
EXTRAVERSION = -rc8

If at this point I do a 'git bisect good' I end up in a 2.6.26
branch, which is good, but after a few bisects I end up at
a version before v2.6.26 (2.6.26-rc5) again, which should be
impossible right ?

Anyway - at the end I end up with a 'good' version that is
2.6.26-rc<something> which is kind of useless. I know that
version up to 2.6.26 are good ...

What am I doing wrong ?

(git version 1.5.6.5 from debian/lenny)

Mike.
