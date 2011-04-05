From: Darren Cook <darren@dcook.org>
Subject: Bug Report: git add
Date: Wed, 06 Apr 2011 08:18:54 +0900
Message-ID: <4D9BA35E.6040204@dcook.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 06 01:19:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FWb-0002vx-Bm
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:19:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639Ab1DEXS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:18:59 -0400
Received: from oproxy1-pub.bluehost.com ([66.147.249.253]:39568 "HELO
	oproxy1-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752447Ab1DEXS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:18:59 -0400
Received: (qmail 22316 invoked by uid 0); 5 Apr 2011 23:18:57 -0000
Received: from unknown (HELO box320.bluehost.com) (69.89.31.120)
  by cpoproxy1.bluehost.com with SMTP; 5 Apr 2011 23:18:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=dcook.org;
	h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:X-Enigmail-Version:Content-Type:Content-Transfer-Encoding:X-Identified-User;
	b=FDMjRm2KYz3UPee/r7a4pAJzG8wjpDvI6envNvs1Frtu939I+LOJByPf3TkrrlXPtBYO6YoWndG9th5OuGHatUOImsdvkMBvVHZotTrNcLYqy0qPzWH0Pmjl7tfCuzpF;
Received: from fla9aaa076.tky.mesh.ad.jp ([61.193.69.76] helo=[172.16.1.52])
	by box320.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <darren@dcook.org>)
	id 1Q7FWT-0006wr-47
	for git@vger.kernel.org; Tue, 05 Apr 2011 17:18:57 -0600
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
X-Enigmail-Version: 1.1.2
X-Identified-User: {2110:box320.bluehost.com:dcookorg:dcook.org} {sentby:smtp auth 61.193.69.76 authed with darren+dcook.org}
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170937>

(Apologies if there is a proper place to report bugs; but I could not
find one.)

PROBLEM: "git add" adds sub-directories without checking to see if there
is already a git repository already there.

WHY BAD: This causes files to be in two repositories (leading to a mess
if you don't notice for a while...)

ONE SOLUTION: When adding files from a directory (except root of the
repository, of course) look for a .git subdirectory, and complain if
found. Allow --force to override this.

MORE SOPHISTICATED:
 1. Offer to merge in all that history, followed by removing that old
.git subdirectory.

 2. Look inside the .git subdirectory to see if the file being added is
actually under control there. If not, no need to complain.


EXAMPLE OF PROBLEM

The problem can arise when people are just dipping their toe into git,
and decide to try it on just one directory, then later expand its use to
the whole project.

  mkdir test
  cd test

  mkdir settings
  cd settings
  git init
  touch x
  git add x
  git commit -m "xx"

  (time passes)

  cd ..
  git init
  git add settings/
   (should complain)



Thanks for taking the time to read this,

Darren




-- 
Darren Cook, Software Researcher/Developer

http://dcook.org/work/ (About me and my work)
http://dcook.org/blogs.html (My blogs and articles)
