From: Bernie Innocenti <bernie@codewiz.org>
Subject: How newbies create remote repositories
Date: Wed, 11 Mar 2009 07:59:47 +0100
Organization: Sugar Labs Foundation - http://sugarlabs.org/
Message-ID: <49B76163.2080205@codewiz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 08:01:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhIRL-0004Wb-M2
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 08:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbZCKG7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 02:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZCKG7v
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 02:59:51 -0400
Received: from trinity.develer.com ([89.97.188.34]:60672 "EHLO
	trinity.develer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730AbZCKG7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 02:59:51 -0400
Received: (qmail 13575 invoked from network); 11 Mar 2009 06:59:48 -0000
Received: from static-217-133-10-139.clienti.tiscali.it (HELO ?10.4.4.169?) (bernie@217.133.10.139)
  by trinity.develer.com with ESMTPA; 11 Mar 2009 06:59:48 -0000
User-Agent: Thunderbird 2.0.0.19 (X11/20090103)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112889>

Here's another usability problem report from my friends who
are learning their way to Git from previous experience with
Subversion and Mercurial.

Three of them confessed they couldn't find a simple recipe
to setup remote repositories, after looking in obvious
places such as the git-push manpage.

Each one could figure it out independently after some time, coming
up with a variety of creative strategies:

Strategy 1:
 client$ ssh server
 server$ mkdir foo.git
 server$ cd foo.git
 server$ git init --bare --shared
 server$ exit
 client$ git push --mirror server:foo.git 

Problem: Does not setup the remote for you.
Solution: Would be nice if "git push <URL>" could give this tip

Problem: Requires a full unrestricted shell on the server
Solution: If "git init <dir>" was supported, one could do
  ssh server git init --bare --shared foo.git


Strategy 2:
 client$ ssh server
 server$ mkdir foo.git
 server$ cd foo.git
 server$ git init --bare --shared
 server$ exit
 client$ git clone server:foo.git .
 client$ git add .
 client$ git commit
 client$ git push

Problem: only works if you had no local repository yet


Strategy 3:
 client$ scp -r .git server:foo.git
 client$ cd ..
 client$ rm -r foo
 client$ git clone server:foo.git

Problem: the user checks out the repository from scratch
  to properly add the remote
Solution: "git pull" might suggest to use "git remote".

A simple "git remote create" or "git remote new" along with a
reference to it in the manpage of "git push" might have helped
these users.

-- 
   // Bernie Innocenti - http://www.codewiz.org/
 \X/  Sugar Labs       - http://www.sugarlabs.org/
