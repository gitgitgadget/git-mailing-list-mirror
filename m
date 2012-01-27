From: Mark Jason Dominus <mjd@plover.com>
Subject: BUG 1.7.9: git branch fails to create new branch when
 --edit-description is used
Date: Fri, 27 Jan 2012 16:52:45 -0500
Organization: P.D.Q. Bernoulli Institute of Lower Mathematics
Message-ID: <2443.1327701165@plover.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 23:53:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqufN-0001TJ-M1
	for gcvg-git-2@lo.gmane.org; Fri, 27 Jan 2012 23:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab2A0WxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 17:53:04 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:50900 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab2A0WxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 17:53:03 -0500
X-Greylist: delayed 3603 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Jan 2012 17:53:03 EST
Received: from plover.com ([unknown] [72.92.122.171])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LYH009OQ8RYCJOV@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 27 Jan 2012 15:52:47 -0600 (CST)
Received: (qmail 2445 invoked by uid 1000); Fri, 27 Jan 2012 21:52:45 +0000
Received: from localhost (HELO plover.com) (sendmail-bs@127.0.0.1)
 by localhost with SMTP; Fri, 27 Jan 2012 21:52:45 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189241>


This should work, but doesn't:

        % git branch
        * master
        % git branch  --edit-description  blarf
        [Edit description and exit editor normally]
        % cat .git/BRANCH_DESCRIPTION 
        I like blarf
        # Please edit the description for the branch
        #   blarf
        # Lines starting with '#' will be stripped.
        % git branch -a
        * master

Where is branch blarf?

Creating the branch and editing the description afterwards works correctly:

        % git branch blarf
        % git branch  --edit-description  blarf
        % git branch -a
          blarf
        * master
        % cat .git/config 
        [core]
                repositoryformatversion = 0
                filemode = true
                bare = false
                logallrefupdates = true
        [branch "master"]
                description = I like pie\n
        [branch "blarf"]
                description = I like blarf\n


Mark Jason Dominus 	  			                 mjd@plover.com
