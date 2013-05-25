From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/9] fast-export: improve argument parsing
Date: Fri, 24 May 2013 21:47:35 -0500
Message-ID: <1369450060-19011-5-git-send-email-felipe.contreras@gmail.com>
References: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 25 04:50:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ug4Yz-0005RF-9D
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 04:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab3EYCuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 22:50:21 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:57376 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab3EYCuT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 22:50:19 -0400
Received: by mail-ob0-f173.google.com with SMTP id eh20so6294085obb.18
        for <git@vger.kernel.org>; Fri, 24 May 2013 19:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=oD8qwIrNLaWVqSkOSoi2aex/1gQqo9sy3dDH61B/ov4=;
        b=Xs5O0sBn6KRN9gL1o1RS93Mi8A+wtVy75rZjNJyBMTxqobsJ9RTrWZaKbggcH/eRyR
         6WbjaicUUgHXw6P7Gf03mDhBy481/4gyaQGawMwQrE/+AOFLxFIDDhLRB2MX/+ZkFNFr
         YcoENUI/5pr4ecmssitKGnZO+sqZPUBB//LLxPWdie4Jb9Do7Xf4J73wlmRR4CQUDbb8
         46c9FUsqNLrGTIrP3fZpJAtfYQtd7RcBmiV69vee4P0PX27D8qV1fcSL+MmCkB8pJfZp
         U5eoe2JVjkBOCtmzdKPF8V1vk4lkC0GWu0ItUbjMMVtF3ZSQdTJB30J6JJWfM31RraNs
         nLWQ==
X-Received: by 10.182.214.103 with SMTP id nz7mr13676885obc.66.1369450218870;
        Fri, 24 May 2013 19:50:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kd10sm20611762oeb.7.2013.05.24.19.50.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 24 May 2013 19:50:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369450060-19011-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225479>

We don't want to pass arguments specific to fast-export to
setup_revisions.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d1d68e9..3e1c4d4 100644
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
1.8.3.rc3.312.g47657de
