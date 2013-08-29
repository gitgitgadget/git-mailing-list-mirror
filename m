From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/9] fast-export: improve argument parsing
Date: Thu, 29 Aug 2013 10:23:22 -0500
Message-ID: <1377789808-2213-4-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:28:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF49X-0000M4-Gw
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040Ab3H2P2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:42 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:49343 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006Ab3H2P2l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:41 -0400
Received: by mail-ob0-f170.google.com with SMTP id eh20so638533obb.29
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FN9X4OYynaw+q2+G8AkSdE+MascfOaO8AuE+EP+gonM=;
        b=ZQeZXDwgN38eFjuiEY/CNqcnhF2U18yNkRcHkAaafMMcWF+e38Kc3jSyyvH6oq9b4C
         MqyKPh29rMPfZuw25VXjaEivwDiWWBb1qsfCOt9XaC+lc4MUhBPeYF2MXssPhbwl0dBB
         g7Y80LqJ0LhIVg2lKA46ykTANObT1H39iifz62PxryAsT5wJsFR3sLfPU6C7wSPeTArf
         GWYqXsGI8792UKqG3+Bz6C9zuLkbcAs4va3QYIh1VZCBOJafr9vhEnadsbBIUm6jW/Fv
         hHEgqZLdw3mcl0Jfnp+nsoEep8W1UH1Rh7+WRIEekTjlZ5uzJzAVXNVlvDsLjgjEmE4Q
         5Osw==
X-Received: by 10.60.95.229 with SMTP id dn5mr2942456oeb.26.1377790121024;
        Thu, 29 Aug 2013 08:28:41 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm32936204oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:39 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233270>

We don't want to pass arguments specific to fast-export to
setup_revisions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 8e19058..91114f4 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -694,8 +694,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	revs.topo_order = 1;
 	revs.show_source = 1;
 	revs.rewrite_parents = 1;
+	argc = parse_options(argc, argv, prefix, options, fast_export_usage,
+			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN);
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	argc = parse_options(argc, argv, prefix, options, fast_export_usage, 0);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
 
-- 
1.8.4-fc
