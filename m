From: Jeff Garzik <jgarzik@pobox.com>
Subject: Pull from one branch to another?
Date: Thu, 29 Sep 2005 02:07:57 -0400
Message-ID: <433B84BD.8030003@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090407050300090404070503"
X-From: git-owner@vger.kernel.org Thu Sep 29 08:09:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKraQ-0002ki-FA
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 08:08:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVI2GID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 02:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVI2GID
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 02:08:03 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41192 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750831AbVI2GIB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2005 02:08:01 -0400
Received: from cpe-069-134-188-146.nc.res.rr.com ([69.134.188.146] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.52 #1 (Red Hat Linux))
	id 1EKraK-00023z-Cl
	for git@vger.kernel.org; Thu, 29 Sep 2005 06:08:00 +0000
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9466>

This is a multi-part message in MIME format.
--------------090407050300090404070503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I currently use the attached script to merge the contents of one branch 
into another branch, in my kernel trees:

	$ cd /repo/netdev-2.6
	$ git checkout -f sky2
	$ ... merge patches ...
	$ git checkout -f upstream
	$ ... merge more patches ...
	$ git checkout -f ALL
	$ git-pull-branch upstream
	$ git-pull-branch sky2

End result:  'ALL' branch contains everything in 'sky2' and 'upstream' 
branches.  I use the above for creating an all-inclusive branch that 
users can test, and that Andrew Morton can pull into his -mm kernel tree.

Right now, my git-pull-branch script (attached) simply calls 
git-resolve-script, which nicely skips the fetch step and any 
complications related to that.

My question:  is this the best/right way to pull one branch into 
another?  It's been working for me, for months, but...

	Jeff




--------------090407050300090404070503
Content-Type: text/plain;
 name="git-pull-branch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-pull-branch"

#!/bin/sh

git-resolve-script HEAD $1 "`pwd` branch '$1'"


--------------090407050300090404070503--
