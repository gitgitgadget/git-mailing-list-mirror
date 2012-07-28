From: Nikolai Vladimirov <nikolay@vladimiroff.com>
Subject: [PATCH] buitin_config: return postitive status in get_value
Date: Sat, 28 Jul 2012 14:42:10 +0300
Message-ID: <1343475730-18743-1-git-send-email-nikolay@vladimiroff.com>
Cc: Nikolai Vladimirov <nikolay@vladimiroff.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 28 13:44:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv5RU-0004Y5-Gp
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 13:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2G1Lng (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 07:43:36 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33762 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab2G1Lng (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 07:43:36 -0400
Received: by wibhm11 with SMTP id hm11so427589wib.1
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=480QUr0/MxEvzgSpZiKNZR9umVCCF3dXUVcEvh2z+OE=;
        b=JutM0WoAylO/mF1rLSR/XWo4k4/Q+cFHsgZY1KrpGhyeBHD3vo019yx7sCNvD6U50J
         WW337Ixvx++54m5BxjbUBJORqzxJKCYGYMtIBGpoOkwlhHUnJlFpunXyzfAcEjQy1FoZ
         n+b82zSbHaS85e8uSCioIJ9n8y5woh7DvhcnsGtRoZFGKtQYDuccUErnaonwClCACbt1
         snEBubow4MQaEEvVCIqOMPpDrSW9Enx0rBbwsxxV48xEbofwqviLCn2iJaHYLjYdTlug
         buwKBQdyAwiFFTrWhmPBvsJl8YyNAsIabi64fwWs6Dc7jqhF5HeudlKj/LMcaRzvK18g
         IvXg==
Received: by 10.180.107.2 with SMTP id gy2mr29190138wib.2.1343475814549;
        Sat, 28 Jul 2012 04:43:34 -0700 (PDT)
Received: from localhost.localdomain ([95.111.28.14])
        by mx.google.com with ESMTPS id cl8sm3777154wib.10.2012.07.28.04.43.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 04:43:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202430>

Returning -1 instead of 1 results in wrong exit status(255) since
the output of get_value is passed to exit().

'git config missing_section' should now return proper exit status = 1,
as specified by the git config documentation.

Signed-off-by: Nikolai Vladimirov <nikolay@vladimiroff.com>
---
 builtin/config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cd08da..c262cbb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -160,7 +160,7 @@ static int show_config(const char *key_, const char *value_, void *cb)
 
 static int get_value(const char *key_, const char *regex_)
 {
-	int ret = -1;
+	int ret = 1;
 	char *global = NULL, *xdg = NULL, *repo_config = NULL;
 	const char *system_wide = NULL, *local;
 	struct config_include_data inc = CONFIG_INCLUDE_INIT;
-- 
1.7.11.2
