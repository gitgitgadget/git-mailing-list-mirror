From: Adrian Bunk <bunk@kernel.org>
Subject: git-revert is a memory hog
Date: Sun, 27 Jan 2008 19:27:48 +0200
Message-ID: <20080127172748.GD2558@does.not.exist>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 18:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJBIU-0007sU-9d
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 18:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbYA0R11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 12:27:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753324AbYA0R11
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 12:27:27 -0500
Received: from smtp5.pp.htv.fi ([213.243.153.39]:54501 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752995AbYA0R10 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 12:27:26 -0500
Received: from does.not.exist (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 2357B5BC019
	for <git@vger.kernel.org>; Sun, 27 Jan 2008 19:27:25 +0200 (EET)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71821>

I'm not sure whether this is already known, but when recently working 
for some time from a computer with "only" 512 MB RAM I ran into the huge 
memory usage of git-revert when it tries to revert old commits.

Example (in Linus' kernel tree with git 1.5.3.8):

<--  snip  -->

$ git-revert d19fbe8a7
Auto-merged drivers/input/input.c
CONFLICT (content): Merge conflict in drivers/input/input.c
Auto-merged include/linux/input.h
CONFLICT (content): Merge conflict in include/linux/input.h
Automatic revert failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' and commit the result.
$ 

<--  snip  -->

In top you can see that this took > 800 MB of RAM !

I don't know how easy it would be to implement, but shouldn't git-revert 
be able to be as fast and less memory consuming as
  git-show d19fbe8a7 | patch -p1 -R
?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
