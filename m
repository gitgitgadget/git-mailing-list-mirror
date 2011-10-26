From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: [PATCH] Fix 'Cloning into' message
Date: Wed, 26 Oct 2011 19:05:48 +0200
Message-ID: <1319648748-9150-1-git-send-email-richih.mailinglist@gmail.com>
Cc: Richard Hartmann <richih.mailinglist@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 19:06:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ6vq-0001ev-3C
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933309Ab1JZRGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Oct 2011 13:06:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57819 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932953Ab1JZRGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2011 13:06:21 -0400
Received: by faan17 with SMTP id n17so1748108faa.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=XS+Ee9K1eYrZHORa5JkehObclO1g8JsmD/puP/Gj1lM=;
        b=HTFykoNE7nCYiN3MC+rkDWHkKNLhwnSe6b0NOwoqRmtYEdfcYQAQwqaUGiaij9bDRT
         eZKcRIZXmS/TtSqOq1xelN2VRB8KZ97yy+snGWP7Ln4dhPPbfkx0eYEq0lZ4r4K2IdP/
         QNBlBK7VfwoW7XllJAHT4ZLfd06cJMfeSWcBc=
Received: by 10.223.75.25 with SMTP id w25mr62170782faj.15.1319648779761;
        Wed, 26 Oct 2011 10:06:19 -0700 (PDT)
Received: from localhost.localdomain (fw3.globalways.net. [94.186.137.245])
        by mx.google.com with ESMTPS id y17sm5168267faf.1.2011.10.26.10.06.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 26 Oct 2011 10:06:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184266>

Without this patch,

    git clone foo .

results in this:

    Cloning into ....
    done.

With it:

    Cloning into '.'...
    done.
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
