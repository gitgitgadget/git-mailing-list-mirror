From: Pascal Obry <pascal@obry.net>
Subject: Problem with git-svn
Date: Sun, 16 Dec 2007 11:30:04 +0100
Organization: Home - http://www.obry.net
Message-ID: <4764FE2C.1010103@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 11:31:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3qlr-0007li-Ik
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 11:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761199AbXLPKaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 05:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759594AbXLPKaL
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 05:30:11 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:52251 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761199AbXLPKaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 05:30:09 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2817.orange.fr (SMTP Server) with ESMTP id 037697000086
	for <git@vger.kernel.org>; Sun, 16 Dec 2007 11:30:07 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2817.orange.fr (SMTP Server) with ESMTP id C25D37000081
	for <git@vger.kernel.org>; Sun, 16 Dec 2007 11:30:06 +0100 (CET)
X-ME-UUID: 20071216103006796.C25D37000081@mwinf2817.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68454>


I'm trying to use a Subversion repository with Git. I had
great success with many repositories except one. This one
live since long time and as been migrated from CVS to
Subversion.

The current Subversion repository contains multiple projects.
Each project is under /trunk. While trying to import the project
PROJ:

  $ git svn clone svn+ssh://myserver/trunk/PROJ

I get:

Initialized empty Git repository in .git/
W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: File not found: revision 100, path '/trunk/PROJ'
Found possible branch point: svn+ssh://myserver/importfromcvs/trunk =>
svn+ssh://myserver/trunk/PROJ, 48467
Initializing parent: git-svn@48467
W: Ignoring error from SVN, path probably does not exist: (160013):
Filesystem has no item: File not found: revision 101, path
'/importfromcvs/trunk'
r9458 = b90789186c85a19a9f32ea6dc8a4259e2eadef67 (git-svn@48467)
        A       file.el

But file.el is not part of this project, it is part of another one
on the same Subversion repository. It looks like git-svn get confused
at some point. I've been trying to track this down, but since I've
never written a single Perl script that's not easy :(

Note that AFAIK each CVS modules have been imported into
/importfromcvs/trunk then move into /trunk/<MODULE_NAME>.

r48467 seem ok as a branch point:

<<
------------------------------------------------------------------------
r48468 | svn | 2007-05-09 15:10:54 +0200 (Wed, 09 May 2007) | 1 line
Changed paths:
   D /importfromcvs/trunk
   A /trunk/PROJ (from /importfromcvs/trunk:48467)

Importing module PROJ into SVN.
>>

So I'm looking for hints about the possible problem.

Note that I have tried to reproduce this with a small
script (using the same repository structure) but I was
not able.

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
