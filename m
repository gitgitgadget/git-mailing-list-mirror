From: Brad Roberts <braddr@puremagic.com>
Subject: [patch] fork optional branch point normazilation
Date: Sun, 17 Apr 2005 05:04:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0504170451030.2625-100000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Apr 17 14:01:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DN8SC-0005TK-DR
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 14:00:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbVDQMEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 08:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVDQMEW
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 08:04:22 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:52715 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261304AbVDQMES (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 08:04:18 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.3/8.13.3/Debian-6) with ESMTP id j3HC4GOK004377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 05:04:16 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.3/8.13.3/Submit) with ESMTP id j3HC4GXJ004373
	for <git@vger.kernel.org>; Sun, 17 Apr 2005 05:04:16 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(ok, author looks better, but committer doesn't obey the AUTHOR_ vars yet)

This might not be how you intended git fork to behave, but without doing
_something_ to protect the head parameter a bit, this is just asking for a
corrutped .git/HEAD file.

commit 76faec069dfeae59c3ce5faaad10bdcded0cc908
tree c291316b28eff4042c80850cd93445345a606835
parent 1cdbc0a19b8d9b68f1f42735e2f14f1289823a63
author Brad Roberts <braddr@puremagic.com> 1113738584 -0700
committer Brad Roberts,,, <braddr@gameboy2> 1113738584 -0700

gitfork needs to normalize the optional third parameter before using it.

Index: gitfork.sh
===================================================================
--- 51b1bddbbc05e50d5bbf1f9662e503c2e85d5e96/gitfork.sh  (mode:100755 sha1:e5692ea9bdbc39b028fe1e1205381da632541bab)
+++ c291316b28eff4042c80850cd93445345a606835/gitfork.sh  (mode:100755 sha1:386148ae9a99739d06a09742ff4157d0f7e4e223)
@@ -37,6 +37,7 @@
 [ -e "$destdir" ] && die "$destdir already exists"

 [ "$head" ] || head=$(commit-id)
+head=$(gitXnormid.sh -c $head)

 git lntree "$destdir"
 echo $head >.git/heads/$name



