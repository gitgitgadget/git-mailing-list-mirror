From: Paul Drews <paul.drews@intel.com>
Subject: rebase not honoring core.worktree pointing elsewhere
Date: Mon, 1 Nov 2010 17:22:05 +0000 (UTC)
Message-ID: <loom.20101101T182113-378@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 01 18:25:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCy8E-0002BL-B2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 18:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab0KARZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 13:25:09 -0400
Received: from lo.gmane.org ([80.91.229.12]:37341 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab0KARZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 13:25:07 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PCy81-00025D-AA
	for git@vger.kernel.org; Mon, 01 Nov 2010 18:25:05 +0100
Received: from jfdmzpr01-ext.jf.intel.com ([134.134.139.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 18:25:05 +0100
Received: from paul.drews by jfdmzpr01-ext.jf.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 18:25:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 134.134.139.70 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.3) Gecko/20100403 Fedora/3.6.3-4.fc13 Firefox/3.6.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160488>

Hello,

I'm observing an unexpected error from "git rebase" run from the directory
containing the ".git" directory:

$ git --version

git version 1.7.3.GIT
(includes up to commit ca2090 from git repository at
http://www.kernel.org/pub/scm/git/git.git)

$ mkdir wherefilesare
$ mkdir wheregitis
$ cd wherefilesare
$ echo "Here is a line from the original" > myfile.txt
$ cd ../wheregitis
$ git init
$ git config core.worktree /absolute/path/to/wherefilesare/
$ git add .
$ git commit
$ git branch mybranch
$ git checkout mybranch
$ vim ../wherefilesare/myfile.txt 
$ git add .
$ git commit
$ git checkout master
$ vim ../wherefilesare/myfile.txt 
$ git add .
$ git commit
$ git checkout mybranch
$ git rebase master

fatal: /usr/libexec/git-core/git-rebase cannot be used without a working tree.

Since I'm in the directory containing ".git" at this point, the ".git" directory
and the worktree can be unambiguously found.  Other commands besides "git
rebase" work.  I would expect "git rebase" to work as well.  Is this a bug or an
unreasonable expectation on my part?
