From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv3 2/5] connect: use static list of repo-local env vars
Date: Wed, 24 Feb 2010 00:35:33 +0100
Message-ID: <1266968136-11129-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 00:36:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk4IY-0001Ms-Dj
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 00:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab0BWXfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 18:35:54 -0500
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51835 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab0BWXfw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 18:35:52 -0500
Received: by wwf26 with SMTP id 26so1011731wwf.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 15:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DC15ydex0o8vtOS7x2betCz/cSBgyCHlTnla60WreWM=;
        b=wRtRBJAlQ2G2WZw1l+Hg1C5Jty1ZHq9MRqQWWwxVHC6V5aj5YRDxzjXs6VDK8nYHZw
         8K3uiDCdmPip0bK/3dJOXhB7IJLrDIer4jx6oBwCauvK4g+rcbmpT1IpmeeOrGVWpH5t
         zE02fsNBIvOzautrpcuQtVhSGmhKKqIPPw6M4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qbgGYiF+RHch5plqEjoI6x4EehMGUSy1m7agZB4kAy4vTR0+Oc+kJL/oxNxE/J6M9e
         mX6jqy+Ik06vjCSUr9c0d8KyLqXFzBYCYMUFUVSNKuXmfJvTqzjh6sbQ6BMI8SdUmyCr
         epStSGU+AD4runqgHEYlFp0atbnrKj3JKTAwQ=
Received: by 10.216.172.76 with SMTP id s54mr2364377wel.100.1266968151024;
        Tue, 23 Feb 2010 15:35:51 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id p10sm20752549gvf.6.2010.02.23.15.35.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 15:35:50 -0800 (PST)
X-Mailer: git-send-email 1.7.0.200.g5ba36.dirty
In-Reply-To: <1266968136-11129-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140873>

This adds the missing GIT_CONFIG to the list of env vars that
should be cleared.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 connect.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/connect.c b/connect.c
index 9f39038..94b3707 100644
--- a/connect.c
+++ b/connect.c
@@ -582,18 +582,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		*arg++ = host;
 	}
 	else {
-		/* remove these from the environment */
-		const char *env[] = {
-			ALTERNATE_DB_ENVIRONMENT,
-			DB_ENVIRONMENT,
-			GIT_DIR_ENVIRONMENT,
-			GIT_WORK_TREE_ENVIRONMENT,
-			GRAFT_ENVIRONMENT,
-			INDEX_ENVIRONMENT,
-			NO_REPLACE_OBJECTS_ENVIRONMENT,
-			NULL
-		};
-		conn->env = env;
+		conn->env = local_repo_env;
 		conn->use_shell = 1;
 	}
 	*arg++ = cmd.buf;
-- 
1.7.0.200.g5ba36.dirty
