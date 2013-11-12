From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 06/11] fast-export: improve argument parsing
Date: Tue, 12 Nov 2013 14:57:01 -0600
Message-ID: <1384289830-5471-9-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL8v-0008IN-51
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274Ab3KLVEg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:36 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:54543 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab3KLVE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:27 -0500
Received: by mail-oa0-f54.google.com with SMTP id o6so4091131oag.41
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GNMeKRkxMWz89BRrhJ/ban7/UTxmEXiUPRoKUKUKxZA=;
        b=ehnqrmKIkIPRL2tnWPijVPQIKT7Hqk23d6EhBGd+58uSgrR7aoo3bjThF3D664Nlta
         glTzjjA5mQYZkd47nHU5+qZkNQNtO82YJDkT0RkFVYj3ONMHGl1Qc9PjifyQZ6qto+7A
         MUJlHhYsdIDqxmwMXjV2IhOijBEaCd+NSnkH2yIrUW5xIXd43zUn9h0mWXi4G4odHxM8
         khrWDLM2AAY3yZSn74IC3DAKSqpjViFqsxfNr8D2i4GjWOqFmXiKyrCSD0lXRudmozhR
         J/Kf+11ZDdb9A9bJfGBcaJZBI9gh3+oDiqMfDnFR6gi699K8QgnCxf3fgr6thwfU1UcO
         B9pQ==
X-Received: by 10.182.166.40 with SMTP id zd8mr26780538obb.25.1384290266797;
        Tue, 12 Nov 2013 13:04:26 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id tz10sm35388243obc.10.2013.11.12.13.04.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:25 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237743>

We don't want to pass arguments specific to fast-export to
setup_revisions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 78250ea..eea5b8c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -701,8 +701,9 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
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
1.8.4.2+fc1
