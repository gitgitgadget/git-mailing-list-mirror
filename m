From: Ben Bradshaw <ben@catalyst.net.nz>
Subject: could not detach HEAD error didn't identify the cause of the issue
Date: Mon, 14 Sep 2009 12:14:24 +1200
Message-ID: <4AAD8AE0.9070305@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 02:36:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmzYO-0004AW-JA
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 02:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493AbZINAdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 20:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754485AbZINAda
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 20:33:30 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:52972 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754341AbZINAda (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 20:33:30 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Sun, 13 Sep 2009 20:33:29 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 98DB531FC4
	for <git@vger.kernel.org>; Mon, 14 Sep 2009 12:26:44 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at mail.catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ma+LDOqoBCK4 for <git@vger.kernel.org>;
	Mon, 14 Sep 2009 12:26:43 +1200 (NZST)
Received: from [192.168.2.54] (leibniz.catalyst.net.nz [202.78.240.7])
	(Authenticated sender: ben)
	by mail.catalyst.net.nz (Postfix) with ESMTPA id 47D2E3222D
	for <git@vger.kernel.org>; Mon, 14 Sep 2009 12:14:25 +1200 (NZST)
User-Agent: BC/2.0.0.22
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128431>

Hi,

I was asked to post this issue to the list, I've just had git tell me it
can't detach HEAD which left me scratching mine as to the cause and fix.
Turns out if I have local untracked files that the remote branch also
has then this error will trigger. I have included my shell backlog
(client data removed). In this example the site_map folder was present
on master and I had a local, untracked copy.

git can obviosly detect this issue and stop my local copy getting in a
bad state, but an error message such as "sites/all/modules/site_map/ is
present in HEAD but is untracked locally, unable to apply changes" (or
something to point the finger) would be much appreciated.

ben@carbon:redacted/$ git pull --rebase
remote: Counting objects: 91, done.
remote: Compressing objects: 100% (72/72), done.
remote: Total 74 (delta 27), reused 0 (delta 0)
Unpacking objects: 100% (74/74), done.
From git+ssh://redacted
   fb1a4c9..bf06bbd  master     -> origin/master
First, rewinding head to replay your work on top of it...
Fast-forwarded master to bf06bbd9e50a2732164fba9e60e65606ab1267ab.
ben@carbon:redacted/$ pwd
/home/ben/redacted
ben@carbon:redacted/$ git pull --rebase
First, rewinding head to replay your work on top of it...
could not detach HEAD
ben@carbon:redacted/$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#    sites/all/modules/jquery.ui-1.6.zip
#    sites/all/modules/jquery_ui-6.x-1.3.tar.gz
#    sites/all/modules/jquery_ui/
#    sites/all/modules/modalframe-6.x-1.3.tar.gz
#    sites/all/modules/modalframe/
#    sites/all/modules/nodereference_explorer-6.x-1.1-beta6.tar.gz
#    sites/all/modules/nodereference_explorer/
#    sites/all/modules/noderelationships-6.x-1.1.tar.gz
#    sites/all/modules/noderelationships/
#    sites/all/modules/site_map-6.x-1.1.tar.gz
#    sites/all/modules/site_map/
nothing added to commit but untracked files present (use "git add" to track)
ben@carbon:redacted/$ rm -rf sites/all/modules/site_map/
ben@carbon:redacted/$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#    sites/all/modules/jquery.ui-1.6.zip
#    sites/all/modules/jquery_ui-6.x-1.3.tar.gz
#    sites/all/modules/jquery_ui/
#    sites/all/modules/modalframe-6.x-1.3.tar.gz
#    sites/all/modules/modalframe/
#    sites/all/modules/nodereference_explorer-6.x-1.1-beta6.tar.gz
#    sites/all/modules/nodereference_explorer/
#    sites/all/modules/noderelationships-6.x-1.1.tar.gz
#    sites/all/modules/noderelationships/
#    sites/all/modules/site_map-6.x-1.1.tar.gz
nothing added to commit but untracked files present (use "git add" to track)
ben@carbon:redacted/$ git pull --rebase
First, rewinding head to replay your work on top of it...
Fast-forwarded master to 527afccc7565929baf7890b42b1a34174014fee7.


Thanks for your time (and git)
Ben
