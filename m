From: Yann Dirson <ydirson@altern.org>
Subject: [BUG] comments in grafts file broken in current master
Date: Sun, 16 Apr 2006 14:35:35 +0200
Message-ID: <20060416123535.GT12638@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Apr 16 14:26:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FV6KZ-0005Cy-RQ
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 14:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWDPM0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 08:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWDPM0F
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 08:26:05 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:47821 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750719AbWDPM0E (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 08:26:04 -0400
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 4E1616DB72
	for <git@vger.kernel.org>; Sun, 16 Apr 2006 14:25:58 +0200 (CEST)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.61)
	(envelope-from <ydirson@altern.org>)
	id 1FV6TY-0004EU-5m
	for git@vger.kernel.org; Sun, 16 Apr 2006 14:35:36 +0200
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18788>

While looking at allowing empty lines in grafts files, I discovered
that comments had already been implemented.  However, current
git-read-tree segfaults when there is a comment line in info/grafts:

dwitch@gandelf:/export/work/yann/git/git$ cat .git/info/grafts 
c118c026e44f02c3dbad00d924285eef2340f700
# foo
dwitch@gandelf:/export/work/yann/git/git$ git-read-tree master
Segmentation fault


The commit introducing the problem is
5040f17eba15504bad66b14a645bddd9b015ebb7 (blame -S <ancestry-file>),
which changes quite some things in the grafts area.
    

BTW, after segfaulting, .git/index.lock is still there, and the
"unable to create new cachefile" is not so helpful - I had to strace
to see what was happenning.

Hope this helps,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
