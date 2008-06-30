From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 11:49:18 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200806301149.18115.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 11:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDG7Z-0005Yr-7n
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 11:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbYF3Jzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 05:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753800AbYF3Jzc
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 05:55:32 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:12925 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbYF3Jzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 05:55:31 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2008 05:55:31 EDT
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 11:49:18 +0200
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-OriginalArrivalTime: 30 Jun 2008 09:49:18.0324 (UTC) FILETIME=[906F9340:01C8DA96]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86896>

Hi,

I'm a bit puzzled. I have a bare repository, somehow without any files
in refs/heads.

It started using conversion from CVS via SVN using git-1.5.3.4. It is
configured for group access and there are a number of SSH accounts on
the machine in the proper group using git-shell for fellow developers. 

I never have any problems, but after upgrading to git-git (1.5.6.rc3)
fellow users get error:

error: no such remote ref refs/heads/JPL31
error: no such remote ref refs/heads/V57X
error: no such remote ref refs/heads/V5_4_patches
error: no such remote ref refs/heads/XML_UNICODE
error: no such remote ref refs/heads/attvar
error: no such remote ref refs/heads/gmp

Creating a new account and doing a fresh clone I even got the fatal
error there are no remote branches!? Still, using my own user id, I
could do anything I wanted. I checked permissions to see whether there
are differences between group and owner permissions, but couldn't find
anything suspicious.  git fsck --full on the repo gives no errors.

It turns out the directory refs/heads is empty!?

I made a fresh clone of the repo as myself, creating all references
nicely in refs/remotes/origin. Then I copied these files to refs/heads
into the main bare repository and now all appears to work nicely again.
Still, this is a bit worrying ...  My questions:

    * Is my work-around safe and sound?
    * How can this have happened?
    * Why can I clone as myself and not as anyone else!?  Stranger:
    after a "sudo -u <someone> /bin/bash" I could not clone.  I can
    copy the entire tree using cp -a, but I still cannot clone the
    copy with this user, while as myself I can clone the copy. 
    Somehow `as myself' appears to get the branchheads from somewhere.
    There is only one copy of git installed, so both users use the
    same.  What can cause this difference?

	Thanks --- Jan
