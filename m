From: Wincent Colaiuta <win@wincent.com>
Subject: "git add" and absolute paths
Date: Mon, 28 Jan 2008 13:32:24 +0100
Message-ID: <916BAC14-A5E4-4666-A29E-2CDF114DCD87@wincent.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 28 13:33:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJTAY-00048r-JP
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 13:32:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbYA1Mc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 07:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYA1Mc1
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 07:32:27 -0500
Received: from wincent.com ([72.3.236.74]:37451 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbYA1Mc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 07:32:26 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0SCWPTp024619
	for <git@vger.kernel.org>; Mon, 28 Jan 2008 06:32:26 -0600
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71882>

I was somewhat surprised the other day to see that you can't pass  
absolute paths to "git add":

$ cd /tmp
$ mkdir foo
$ cd foo
$ git init
Initialized empty Git repository in .git/cuzco:foo
$ echo "content" > file
$ git add /tmp/foo/file
fatal: unable to add /tmp/foo/file to index
$ git add file

I understand that you can't add arbitrary paths outside of your  
worktree, but if the absolute path specifies something _inside_ your  
worktree then it seems that this is either a bug or a "usability  
shortcoming" if you prefer to avoid the term "bug".

I also understand that providing a relative path is by far the most  
common operation, but there are real use cases where it's easier to  
pass an absolute path. For example: you're working at the console  
inside the work tree but you also have a GUI file browser open  
alongside. Sometimes it is simpler to drag-and-drop the file from the  
GUI to the console window (thus inserting the absolute path to the  
file) rather than typing out the relative path, even with  
autocompletion.

Out of curiosity I went back and looked at the last version of Git  
before "add" became a built-in (1.3.3). It also barfs for absolute  
paths:

$ git add file
Ignoring path /tmp/foo/file

So I suspect it's always been this way. Do people agree that this  
issue is worth addressing?

Cheers,
Wincent
