From: Liu Yubao <yubao.liu@gmail.com>
Subject: problems of git-status
Date: Wed, 28 Mar 2007 15:59:16 +0800
Message-ID: <460A2054.20404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 28 10:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWT6O-0004LM-02
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 10:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbXC1IBt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Mar 2007 04:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbXC1IBt
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Mar 2007 04:01:49 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:21863 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965136AbXC1IBs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2007 04:01:48 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2745897wxd
        for <git@vger.kernel.org>; Wed, 28 Mar 2007 01:01:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=I6BJ3xDVipy9qY/lB8U9lZPZ0JaV4fGgYKW1ZD1Wt0OPASOqGBuH/8bUpeTqilYZxPrimjH7iHhIDsbOnkvRDIXXF05pep4FWFcIZidziV0k2JxMSmGik4481pFNp6Izcdjv1FngA8YafK0kL9MNjQ7VFd7n18vlX2/jReTNECE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=R0nbKMpF9kHRCnxY8BYg5QyNgWExC5NJf+4DIRB6HfLacsF7iAddqOnY/B3Jy6F1i9/0fLwGA2GpBSyzNPj/imbyE4lx3AEtTSS0BFgxpmU2PVuBjEHiLSUzcNXpGT+zJ8xclKrKZMzq+wZ44PAG9r644df4+gobOZPOXDg7D+k=
Received: by 10.70.77.2 with SMTP id z2mr14726698wxa.1175068907564;
        Wed, 28 Mar 2007 01:01:47 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id 5sm39783405nzk.2007.03.28.01.01.45;
        Wed, 28 Mar 2007 01:01:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43358>

Hi,
   I find "git status" and "git status ." have different output and the latter
will go wrong in the case below:

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
#!/bin/sh
rm -rf tt; mkdir tt; cd tt

git init
mkdir AA
echo hello>a
git add .
echo world>a

echo "different output..."
echo "--------------------git status-------------"
git status
echo "--------------------git status . ----------"
git status .

git add a
git commit -m "test"
echo hello world>a
git add a
sleep 4
echo world hello>a
echo "--------------------git status-------------"
git status
echo "--------------------git status . ----------"
git status .

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

I use git version 1.5.1.rc2.15.g465b3, "git repo-config -l" shows:
	core.filemode=false
	core.logallrefupdates=true
	core.compression=9
	diff.color=auto
	pack.window=64
	merge.summary=true
	core.repositoryformatversion=0
	core.filemode=false
	core.bare=false


Here is the output of that script:

Initialized empty Git repository in .git/
different output...
--------------------git status-------------
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file: a
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   a
#
--------------------git status . ----------
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#	new file: a
#
Created initial commit dc57cb444335e73ce3320c1e368765b1a92e3be5
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
--------------------git status-------------
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#	modified:   a
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#	modified:   a
#
--------------------git status . ----------
fatal: Entry 'a' not uptodate. Cannot merge.
