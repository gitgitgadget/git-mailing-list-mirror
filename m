From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [BUG] git --work-tree=... status
Date: Sun, 12 Aug 2007 20:58:56 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070812185855.GA16704@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 12 20:59:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKIeU-0004Pe-0u
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 20:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932867AbXHLS67 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 14:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761586AbXHLS67
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 14:58:59 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:48011 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284AbXHLS66 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 14:58:58 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IKIeP-0004uL-3C
	for git@vger.kernel.org; Sun, 12 Aug 2007 20:58:57 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l7CIwuY1017135
	for <git@vger.kernel.org>; Sun, 12 Aug 2007 20:58:56 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l7CIwuYa017134
	for git@vger.kernel.org; Sun, 12 Aug 2007 20:58:56 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55702>

Hello,

I don't have time now to look into it, so for now as usual just a
report.  If nobody takes it, I will do it later.

	zeisberg@cassiopeia:~/gsrc/git$ git version
	git version 1.5.3.rc4.887.gd56871c

[That's Junio's next + my doc change "checkout-index doc: use --work-di=
r in
the export example"]

	zeisberg@cassiopeia:~/gsrc/git$ mkdir export

	zeisberg@cassiopeia:~/gsrc/git$ git --work-tree=3Dexport checkout-inde=
x -a

	zeisberg@cassiopeia:~/gsrc/git$ git --work-tree=3Dexport status
	fatal: /home/zeisberg/usr/bin/git-status cannot be used without a work=
ing tree.

runstatus works as expected (at least after some thought):

	zeisberg@cassiopeia:~/gsrc/git$ git --work-tree=3Dexport runstatus | h=
ead
	# On branch next
	# Changed but not updated:
	#   (use "git add <file>..." to update what will be committed)
	#
	#       modified:   .gitignore
	#       modified:   .mailmap
	#       modified:   COPYING
	#       modified:   Documentation/.gitignore
	#       modified:   Documentation/Makefile
	#       modified:   Documentation/RelNotes-1.5.0.1.txt

The problem seems to be that require_work_tree demands more that I thin=
k
it should.  It calls `git rev-parse --is-inside-work-tree`.

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D1+newton+in+kg*m+%2F+s%5E2
