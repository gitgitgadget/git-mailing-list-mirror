From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: HEAD branch duplicated in remotes/origin
Date: Thu, 8 Jun 2006 09:38:57 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060608073857.GA5072@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jun 08 09:39:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FoF6g-0001J6-G8
	for gcvg-git@gmane.org; Thu, 08 Jun 2006 09:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWFHHi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Jun 2006 03:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWFHHi7
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jun 2006 03:38:59 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:3257 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S932556AbWFHHi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jun 2006 03:38:58 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FoF6X-0001UL-Cg
	for git@vger.kernel.org; Thu, 08 Jun 2006 09:38:57 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k587cvu05530
	for git@vger.kernel.org; Thu, 8 Jun 2006 09:38:57 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21474>

Hello,

when cloning with --use-separate-remote, $GITDIR/remotes/origin contains
two references to refs/heads/master.  This breaks `git fetch origin'.

uzeisberger@io:~/gsrc$ git --version
git version 1.4.0.rc2.ga95e

uzeisberger@io:~/gsrc$ git clone --use-separate-remote git://git.kernel.org/pub/scm/git/git.git git-copy
Checking files out...)
 100% (523/523) done

uzeisberger@io:~/gsrc$ cd git-copy

uzeisberger@io:~/gsrc/git-copy$ git fetch origin
error: no such remote ref refs/heads/master
Fetch failure: git://git.kernel.org/pub/scm/git/git.git

uzeisberger@io:~/gsrc/git-copy$ grep -n master .git/remotes/origin
2:Pull: refs/heads/master:refs/remotes/origin/master
12:Pull: refs/heads/master:refs/remotes/origin/master

uzeisberger@io:~/gsrc/git-copy$ sed -i 2d .git/remotes/origin

uzeisberger@io:~/gsrc/git-copy$ git fetch origin

uzeisberger@io:~/gsrc/git-copy$ 

I didn't look into it deeply, but I think this happens because the
remote HEAD is translated to refs/heads/master and added while master is
added once more while processing refs/heads/master explicitly.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=12+divided+by+3
