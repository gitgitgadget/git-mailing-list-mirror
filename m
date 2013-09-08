From: Yann Dirson <ydirson@free.fr>
Subject: [BUG] rebase not recovering gracefully from repack error
Date: Sun, 8 Sep 2013 22:46:43 +0200
Message-ID: <20130908204643.GD8767@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 08 22:47:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIlsz-0008Ux-Pa
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:47:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab3IHUqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:46:52 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:41670 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751203Ab3IHUqw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:46:52 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2E4D794009B
	for <git@vger.kernel.org>; Sun,  8 Sep 2013 22:46:44 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.80)
	(envelope-from <ydirson@free.fr>)
	id 1VIlsZ-0002FR-Kd
	for git@vger.kernel.org; Sun, 08 Sep 2013 22:46:43 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234261>

(patches|REBASE 8/9)$ git rebase --continue
Applying: Check for __unix__ instead of __linux
Applying: Completely disable crash handler on archs other than i386 and amd64
Auto packing the repository for optimum performance. You may also
run "git gc" manually. See "git help gc" for more information.
error: Could not read a7d470051f53f4e4c9247df752583868a79ec70b
fatal: Failed to traverse parents of commit e6d2f264969207e337953717c260d37daa0a8554
error: failed to run repack
(patches|REBASE 10/9)$ cat .git/rebase-apply/next 
10
(patches|REBASE 10/9)$ 


The last patch has been dealt with and I consider the rebase done.
Rebase would be bombing out without cleaning behind it when the auto
repack fails ?


On another aspect, I find the repack error is suspect: "git fsck
--no-dangling" has nothing to complain about, and the missing commit
is the real ancestor of a grafted commit.  I suppose it has been gc'd
by a buggy git version, as I recall seeing such a fix on the list some
time ago.  (yes, I shouldn't be using grafts any more, but that
particular one dates back to 2006 ;)

-- 
Yann

[v1.8.4]
