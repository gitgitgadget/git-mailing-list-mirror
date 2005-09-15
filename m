From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] Remove shell dependency in env.c
Date: Wed, 14 Sep 2005 22:50:48 -0700
Message-ID: <43290BB8.90501@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020704080308080902040209"
X-From: git-owner@vger.kernel.org Thu Sep 15 07:52:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFmeP-0005pX-Ub
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 07:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVIOFvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 01:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVIOFvA
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 01:51:00 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:25061 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1030394AbVIOFu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 01:50:59 -0400
X-Envelope-From: hpa@zytor.com
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by paleosilicon.orionmulti.com (8.12.10/8.12.10) with ESMTP id j8F5omJv024506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 14 Sep 2005 22:50:50 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-Spam-Status: No, hits=0.0 required=5.0 tests=AWL autolearn=ham version=2.63
X-Spam-Checker-Version: SpamAssassin 2.63 (2004-01-11) on 
	paleosilicon.orionmulti.com
X-Virus-Scanned: ClamAV version 0.86.2, clamav-milter version 0.86 on paleosilicon.orionmulti.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8586>

This is a multi-part message in MIME format.
--------------020704080308080902040209
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds an invocation of "env", so rsh.c works for C-shell users 
as well as Bourne shell users.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------020704080308080902040209
Content-Type: text/x-patch;
 name="rsh-use-env.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rsh-use-env.patch"

Explicitly invoke "env" so it doesn't depend on a specific shell.

---
commit 642840f61656059dc3929e7c3af9db7f6e251fa3
tree d8d77e8643efd7c70b834e02382bb694252b8b2d
parent 19397b4521bcc27eb224413fb71519223b94290f
author H. Peter Anvin <hpa@smyrno.hos.anvin.org> Wed, 14 Sep 2005 22:24:37 -0700
committer H. Peter Anvin <hpa@smyrno.hos.anvin.org> Wed, 14 Sep 2005 22:24:37 -0700

 rsh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/rsh.c b/rsh.c
--- a/rsh.c
+++ b/rsh.c
@@ -39,7 +39,7 @@ int setup_connection(int *fd_in, int *fd
 	}
 	/* ssh <host> 'cd <path>; stdio-pull <arg...> <commit-id>' */
 	snprintf(command, COMMAND_SIZE, 
-		 "%s='%s' %s",
+		 "env %s='%s' %s",
 		 GIT_DIR_ENVIRONMENT, path, remote_prog);
 	*path = '\0';
 	posn = command + strlen(command);

--------------020704080308080902040209--
