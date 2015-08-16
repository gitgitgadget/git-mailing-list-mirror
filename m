From: David Dynerman <david@block-party.net>
Subject: Bug pushing branch to new remote via SSH
Date: Sun, 16 Aug 2015 10:56:13 +0900
Message-ID: <m2si7katdu.fsf@block-party.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 16 04:03:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQnHo-0001di-US
	for gcvg-git-2@plane.gmane.org; Sun, 16 Aug 2015 04:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbbHPCCk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 22:02:40 -0400
Received: from anti-capital.block-party.net ([94.254.0.205]:53283 "EHLO
	anti-capital.block-party.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751576AbbHPCCj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Aug 2015 22:02:39 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Aug 2015 22:02:39 EDT
Received: from CIVIC-TV.localdomain (unknown [103.5.142.12])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: david@block-party.net)
	by anti-capital.block-party.net (Postfix) with ESMTPSA id 370002342
	for <git@vger.kernel.org>; Sat, 15 Aug 2015 20:56:21 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=anti-capital.block-party.net; s=dkim; t=1439690181;
	bh=AmOKVcLtwGHL+OM7gruzfSWvsv7izE/RNJKviW2d5Rk=;
	h=From:To:Subject:Date:From;
	b=Bz2v5Bj43VpXpiu18zLalsPqtifhhJdSA2zsEZ/PbC/8L3SVjbt8zli/LZXFpevyL
	 vjwJaelVQ0NdjxdO3qFgXOJLKlDIinGngKyV2jcnpn6Bk0JQdMhHn89xHInH32KCXg
	 yqYfXLhePRqsQSUqFSW/n9qJ/cqcM5zZkSu6iZCM=
Received: by CIVIC-TV.localdomain (Postfix, from userid 501)
	id D5A351E511E4; Sun, 16 Aug 2015 10:56:13 +0900 (KST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276009>

Hello,

I am encountering a bizarre error message trying to push a branch to a
new remote over SSH. The error message is

fatal: packfile name 'remotehost.com' does not end with '.pack'

Here, remotehost.com is the internet domain name of the remote host I'm
trying to push to.

Obviously pushing to SSH remotes isn't broken generally, so I think this
is caused by some bad state in my repository. But the error message
seems odd enough that I think I might be encountering a bug.

If anyone has any hints on how to resolve this, I'd really appreciate
it.

On my laptop, which is running OS X:

$ git fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (398/398), done.

$ ssh remotehost.com "git init ~/git/my_repo --bare"
Initialized empty Git repository in /home/user/git/my_repo/

$ git remote add remotehost ssh://remotehost.com/home/user/git/my_repo

$ git push remotehost master
Counting objects: 405, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (298/298), done.
fatal: packfile name 'remotehost.com' does not end with '.pack'
error: pack-objects died of signal 13
error: failed to push some refs to
'ssh://remotehost.com/home/user/git/my_repo/'

$ git --version
git version 2.2.0

$ ssh remotehost.com "git --version"
git version 1.7.10.1

Thank you very much,
David
