From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH] Fix 'Cloning into' message
Date: Thu, 27 Oct 2011 18:46:53 +0200
Message-ID: <1319734013-8956-1-git-send-email-richih.mailinglist@gmail.com>
References: <1319648748-9150-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 27 18:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJT7B-0003CV-B7
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 18:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684Ab1J0Qrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 12:47:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51161 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab1J0Qrb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 12:47:31 -0400
Received: by faan17 with SMTP id n17so2833558faa.19
        for <git@vger.kernel.org>; Thu, 27 Oct 2011 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=CYQaaciKG+lSwE7M0lkk1sZMcAhtlEB6HG0Q4tVlYoQ=;
        b=xrWIzB7Er57WofCtW82E43Xzz6IwuDz+Zp62+5MdT8XStC7Im479rMj5ycHVqJvIPB
         7gIWz9rkIKsEEiXaz4juaB1fiGGOmd1eMesWymQQNv23ycPuywF3haPupADwjQCvB3bk
         4JbqxQv4jdaQatFLDYHqC4aFUpxPTVvyH82TU=
Received: by 10.223.77.71 with SMTP id f7mr67959619fak.33.1319734050002;
        Thu, 27 Oct 2011 09:47:30 -0700 (PDT)
Received: from localhost.localdomain (fw3.globalways.net. [94.186.137.245])
        by mx.google.com with ESMTPS id v19sm12118109faa.13.2011.10.27.09.47.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 27 Oct 2011 09:47:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319648748-9150-1-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184299>

Without this patch,

    git clone foo .

results in this:

    Cloning into ....
    done.

With it:

    Cloning into '.'...
    done.

Signed-off-by: Richard Hartmann <richih.mailinglist@gmail.com>
---
 builtin/clone.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 488f48e..efe8b6c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -577,9 +577,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (0 <= option_verbosity) {
 		if (option_bare)
-			printf(_("Cloning into bare repository %s...\n"), dir);
+			printf(_("Cloning into bare repository '%s'...\n"), dir);
 		else
-			printf(_("Cloning into %s...\n"), dir);
+			printf(_("Cloning into '%s'...\n"), dir);
 	}
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
-- 
1.7.7
