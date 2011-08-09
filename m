From: Marat Radchenko <marat@slonopotamus.org>
Subject: git diff is slow (--patience is fast)
Date: Tue, 9 Aug 2011 07:51:44 +0000 (UTC)
Message-ID: <loom.20110809T093124-847@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 09:52:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqh6i-0004aT-Vs
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 09:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735Ab1HIHwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 03:52:03 -0400
Received: from lo.gmane.org ([80.91.229.12]:52393 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab1HIHwA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 03:52:00 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Qqh6R-0004Uz-Kv
	for git@vger.kernel.org; Tue, 09 Aug 2011 09:51:56 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 09:51:55 +0200
Received: from marat by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 09 Aug 2011 09:51:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 195.218.191.171 (Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179025>

Warning, downloaded files are 7.5Mb each.

~ $ git --version
git version 1.7.6
~ $ mkdir tmp
~ $ cd tmp
~/tmp $ git init
Initialized empty Git repository in /home/marat/tmp/.git/
~/tmp $ wget http://slonopotamus.org/git-diff/foo 2> /dev/null 
~/tmp $ git add -A
~/tmp $ git commit -am "initial"
[master (root-commit) 6b68e83] initial
 1 files changed, 410461 insertions(+), 0 deletions(-)
 create mode 100644 foo
~/tmp $ wget http://slonopotamus.org/git-diff/foo2 -O foo 2> /dev/null 
~/tmp $ time git diff > /dev/null 

real    0m6.513s
user    0m6.490s
sys     0m0.020s
~/tmp $ time git diff --patience > /dev/null 

real    0m0.237s
user    0m0.180s
sys     0m0.050s

Could something be done to `git diff` speed? I would be happy with patience 
diff, but other git commands call standard diff algorithm internally without 
giving an option to choose patience.

gprof output against git master:
http://slonopotamus.org/git-diff/gmon.txt
