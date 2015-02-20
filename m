From: Alfred Perlstein <bright@mu.org>
Subject: Question on shallow clones.
Date: Fri, 20 Feb 2015 06:13:10 -0800
Message-ID: <40B70861-177F-4239-A86F-49C92121ACE7@mu.org>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 20 15:18:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOoP5-0008CL-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 15:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbbBTOR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 09:17:58 -0500
Received: from elvis.mu.org ([192.203.228.196]:30840 "EHLO elvis.mu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612AbbBTOR6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 09:17:58 -0500
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Feb 2015 09:17:58 EST
Received: from [10.0.1.100] (c-76-21-10-192.hsd1.ca.comcast.net [76.21.10.192])
	by elvis.mu.org (Postfix) with ESMTPSA id 77FB3341F90C
	for <git@vger.kernel.org>; Fri, 20 Feb 2015 06:09:10 -0800 (PST)
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264165>

Hello,

Very sorry if this has been explained before, I have been doing research past few weeks in spare time and have not found a good answer yet on the safety of doing something with git.

Basically we have some repos with huge history, namely FreeBSD source and FreeBSD ports.  In order to reduce the space in $repo/.git as well as speed up clone time we were thinking of doing a shallow clone of the repo with something like --depth 5000.

I am wondering, if we such a thing, basically:

# get a shallow mirror of let's say 5000 entries
git clone --depth 5000 --mirror our-freebsd.git  smaller-freebsd.git
# move our current repo to a backup
mv our-freebsd.git our-freebsd.git.backup
# make shallow repo our primary
mv smaller-freebsd.git our-freebsd.git

Will we be able to push/pull from our "new" repo as if nothing happened?  Will hashes remain the same?

Can we in theory later do this:

# merge branches from the "github" remote and push back to "our-freebsd.git"
git clone /url/our-freebsd.git  our-freebsd.git
cd our-freebsd.git
git remote add github https://github.com/freebsd/freebsd.git
git fetch github
# get from our-freebsd
git checkout -b master origin/master
# now merge in freebsd changes
git merge --no-ff github/master
git push origin HEAD

Or will this break terribly?

Thank you very much.

-Alfred
