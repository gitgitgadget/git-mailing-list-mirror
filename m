From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 2/6] connect: use static list of repo-local env vars
Date: Wed, 24 Feb 2010 08:23:12 +0100
Message-ID: <1266996196-25978-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 08:23:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBb6-0003WY-IT
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918Ab0BXHXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:23:40 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58154 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab0BXHXi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:23:38 -0500
Received: by wya21 with SMTP id 21so1021578wya.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 23:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=WCpLxmjEvIKHtoP50ltdYNtdYvqzsjBQU8gBuWHztHE=;
        b=s75zgX5w2cifrwjP7x+mQoaunNvz9M4xtpWgsyGfo2MzmJLz0R9TVfWw/mqMXOG4zS
         7JNQU6FFlWnjEiEsK+dhbBrTWkrq+5RjUBCBonigTp7dTRjyIMRGVLIAuKcKMj+oMh2l
         XGyYHME1wzFFmA2s7FrFcXDL79sVlLArwc5Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a4Sci6kO0vKpnHGj8N3kOZ4isCRMkugmIqyS96YWjF9CfxGh7fL+/o5JVe0hhUukwC
         ejO/sj1Cm5zZUnKvpcMzoYXuK/bHrYhJP80AstcnzVuq/X8N8Wff4nr89aQNTUSQE5KV
         l/h7fodv5C+sUlO4nONLmNMCfFASTXyHiwSxs=
Received: by 10.216.180.130 with SMTP id j2mr1984422wem.86.1266996217218;
        Tue, 23 Feb 2010 23:23:37 -0800 (PST)
Received: from localhost ([151.60.179.236])
        by mx.google.com with ESMTPS id j8sm21472602gvb.26.2010.02.23.23.23.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Feb 2010 23:23:36 -0800 (PST)
X-Mailer: git-send-email 1.7.0.212.g4e217.dirty
In-Reply-To: <1266996196-25978-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140909>

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
1.7.0.212.g4e217.dirty
