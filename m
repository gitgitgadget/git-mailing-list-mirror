From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: [PATCH v2] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 10:43:32 -0600
Message-ID: <1232988212-8613-1-git-send-email-nathan.panike@gmail.com>
References: <d77df1110901260827j2200fe41oe1b84c387d88aba () mail ! gmail ! com>
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 17:45:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRUa7-0006lO-Oo
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 17:45:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbZAZQni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 11:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751601AbZAZQni
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 11:43:38 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:58034 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbZAZQnh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 11:43:37 -0500
Received: by yx-out-2324.google.com with SMTP id 8so2592475yxm.1
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 08:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=TJJVux2Bafx/LbpOqciS9xe3iscs3ixIYcw03frgWWU=;
        b=XInGzxZMcfCjqAJu2C3DB3OxuYH/t47NQYMdCqiiDtjqqzQWSRaw1xVpSRJMlaAotU
         fbmza0+n3Zqy2jWgoMvVebt+Pjiil8BSvfvxt1rfGExz9GEGWc1K+5HoAHcVD2L8PpXT
         ZPEUGoVKO2ntTwbUUJEndKvcwLUBcbOjXriFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=i0sMG+jiFy0ufPaB4SA88E1XXgPJPUpUDyv31BKrGs81mCiUVrGGLnW9K86UvgpAJb
         ilaHOTWU/abD4DJyBIcz/1FMzkBhkMix3NymmTnHCxgJ7HbMUYnJuyghOFsJq9WBGqcE
         lDIze/NygxknOjLcHlP13CLUAd1ysnXLUuqng=
Received: by 10.143.13.17 with SMTP id q17mr2136912wfi.222.1232988215430;
        Mon, 26 Jan 2009 08:43:35 -0800 (PST)
Received: from localhost (dyn-108-207.uwnet.wisc.edu [72.33.108.207])
        by mx.google.com with ESMTPS id 22sm30450503wfg.50.2009.01.26.08.43.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 08:43:34 -0800 (PST)
X-Mailer: git-send-email 1.6.1.1.GIT
In-Reply-To: <d77df1110901260827j2200fe41oe1b84c387d88aba () mail ! gmail ! com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107231>

The behavior for git format-patch is to ignore merge commits, producing an
empty patch.  The code does not allow the user to change this behavior. This
patch changes that behavior by allowing the user to specify -c or -m at the
command line to produce a patch for a merge commit.

Signed-off-by: Nathan W. Panike <nathan.panike@gmail.com>
---
Add Sign off.

This seems to solve my problem, but maybe my workflow is sufficiently different
that it is a problem no one else has. Maybe someone can point me in a direction
that solves problems more users have.

Thanks,

Nathan Panike
 builtin-log.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 2ae39af..ea4729d 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -994,10 +994,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		/* ignore merges */
-		if (commit->parents && commit->parents->next)
-			continue;
-
 		if (ignore_if_in_upstream &&
 				has_commit_patch_id(commit, &ids))
 			continue;
-- 
1.6.1.1.GIT
