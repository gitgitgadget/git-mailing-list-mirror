From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/10] fast-export: improve argument parsing
Date: Sat, 12 Oct 2013 02:05:33 -0500
Message-ID: <1381561533-20381-11-git-send-email-felipe.contreras@gmail.com>
References: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtMy-0004bU-G1
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab3JLHMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:03 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:46506 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab3JLHMA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:00 -0400
Received: by mail-oa0-f51.google.com with SMTP id h16so3076036oag.24
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FN9X4OYynaw+q2+G8AkSdE+MascfOaO8AuE+EP+gonM=;
        b=yO/DgGXjC/2A32cLc2drG+pdhryI4Oy+U5yAFrF72sVmFbeaJTGTf+/NatPUcPfJOj
         Wu+WvqL5HB1rpE1jxRssR1e9O43fT/L9Y4uphnu03V5j+2SH3XTIsg3zf+V0lpjyNJAA
         V0pOMuOy/U+X2oKJL/fw6Ayw4/bgs9Cte7E5Q/PxqcoCF9AWbzC8cm8hC9spQsnLblnh
         XwG0n+GxJl+eXuN9g4xiQkRsjSCerv+My8KgQeZ3hOtaZEHrxaBYpOrJq5rUawdiU+oh
         g6D5VwAQXb/wZQPC+i3yZ/EaGzVjYKL4oJEAqC4CmEoiDDFyOLNZmtNJwZdROiLL3L3s
         zgDQ==
X-Received: by 10.60.40.67 with SMTP id v3mr18203751oek.16.1381561919540;
        Sat, 12 Oct 2013 00:11:59 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r6sm28666887obi.14.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:11:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561533-20381-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235984>

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
