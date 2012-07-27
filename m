From: Aleksandr Pryimak <tramsmm-mirror@yandex.ru>
Subject: git stash data loss
Date: Fri, 27 Jul 2012 07:06:08 +0400
Message-ID: <55831343358368@web1e.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 27 05:12:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuayW-0006cm-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jul 2012 05:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab2G0DMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 23:12:19 -0400
Received: from forward6.mail.yandex.net ([77.88.60.125]:59240 "EHLO
	forward6.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410Ab2G0DMS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 23:12:18 -0400
X-Greylist: delayed 367 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jul 2012 23:12:18 EDT
Received: from web1e.yandex.ru (web1e.yandex.ru [77.88.60.147])
	by forward6.mail.yandex.net (Yandex) with ESMTP id 270EF112203B
	for <git@vger.kernel.org>; Fri, 27 Jul 2012 07:06:09 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1343358369; bh=FV5dlcksvDPti4ptP/iD3EpXiPQmH2SSYToIfV3Mzgw=;
	h=From:To:Subject:MIME-Version:Message-Id:Date:
	 Content-Transfer-Encoding:Content-Type;
	b=nSouJVuyC7/4gvTRZaFCMhRFSmEJs0v38uipDd1Fklcj3P5dF0XxbWOY4QCYmH+cc
	 SVEoy1gHPgMBJL9NDOyM+xD5dskwihXugSrUi+/rapxSzvXIUHS39tvwZBronD8UYg
	 E6im7vcd3qp6ClznDS5u1Gb3s13JRz0b2rxzamAI=
Received: from 127.0.0.1 (localhost.localdomain [127.0.0.1])
	by web1e.yandex.ru (Yandex) with ESMTP id A659F1758038;
	Fri, 27 Jul 2012 07:06:08 +0400 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1343358368; bh=FV5dlcksvDPti4ptP/iD3EpXiPQmH2SSYToIfV3Mzgw=;
	h=From:To:Subject:Date;
	b=OVtxUlDsVstKcdaVvva/8M1KgC/yMdgvKX9BU+fSzvkIdnjNUK5h0dAKxpCPrTRqH
	 PGaKy+JI8t4BmT8SC2SjGpc3y5eHAR7i5/2XB8hX4AOu8nn/k3nJjWTLky+V0xfjI1
	 nsqAGR0xBHHaljTE7cnQeXVmG3SvcUZBlrf58kWg=
Received: from broadband-37-110-46-117.nationalcablenetworks.ru (broadband-37-110-46-117.nationalcablenetworks.ru [37.110.46.117]) by web1e.yandex.ru with HTTP;
	Fri, 27 Jul 2012 07:06:08 +0400
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202332>

Hello.

It is believed that
git stash
git stash pop
is safe to-do operation. But sometimes it is not. For example here is an example http://stackoverflow.com/questions/11680453/git-stash-where-did-the-files-in-my-directory-go/11680645

I also recreated it

aleksandr@beast:/tmp/test$ git init
Initialized empty Git repository in /tmp/test/.git/
aleksandr@beast:/tmp/test$ touch x
aleksandr@beast:/tmp/test$ git add x
aleksandr@beast:/tmp/test$ git commit -m "Initial"
[master (root-commit) d3569a0] Initial
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 x
aleksandr@beast:/tmp/test$ rm x
aleksandr@beast:/tmp/test$ mkdir x/
aleksandr@beast:/tmp/test$ ls
x
aleksandr@beast:/tmp/test$ git stash
Saved working directory and index state WIP on master: d3569a0 Initial
HEAD is now at d3569a0 Initial
aleksandr@beast:/tmp/test$ ls
x
aleksandr@beast:/tmp/test$ git stash pop
Removing x
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#	deleted:    x
#
no changes added to commit (use "git add" and/or "git commit -a")
Dropped refs/stash@{0} (c500443ae16cf0d846b195cb97eb388dec5f440e)
aleksandr@beast:/tmp/test$ ls
aleksandr@beast:/tmp/test$ git --version
git version 1.7.5.4

--
Aleksandr Pryimak
