From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 15/17] branch, tag: use porcelain output
Date: Sun, 15 May 2016 16:15:31 +0530
Message-ID: <1463309133-14503-16-git-send-email-Karthik.188@gmail.com>
References: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, peff@peff.net,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 12:46:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tZ7-0003zV-KN
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:46:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754200AbcEOKqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:46:24 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:33662 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbcEOKqW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:46:22 -0400
Received: by mail-pa0-f66.google.com with SMTP id gh9so12081335pac.0
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PVQh5SDb3dcJ/fr3hOSyv1l2ddQJ8Sp7qytrAxXVa2U=;
        b=nqgdG9DPwJGW2+jkB2Bf+ck+xxHMRBUdZzj1HDSudWhaVXgsxm/nZup3vMfyy6NHct
         BTCLhy5t/Bh/jtodO4L55L98H2MKL1G+AkHGO7MyKb9yeK7CDk0f99B7kBVlTIR2tyYH
         Jam91FJf4XLipP6FXNbWfsadS1URECV+iH733CGKw8N1LALmDmy7V6oGJ2nBDp207qGV
         7ZCz05V4OtFTQRNh5EDST2OBllOICxVTEA5dy/WOQGfQ0OZprF09BgOIWAOfpyIFxeCy
         RLcnFCD/b2HGEcsUOQ87XhVQxwYjca3TUfAjWvkbt+grI9Sivc+nqDJi3TTsIHkjUQP3
         SGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PVQh5SDb3dcJ/fr3hOSyv1l2ddQJ8Sp7qytrAxXVa2U=;
        b=U4DpIMvLaQT0PwGQgtTK1K0LCn9aKc9aNwT6I8yYH5giT10hKfOiXR3g9A5qs9sBvN
         tP395jSwgWKqahPtvKh3TG2BT9DBUcRFBe9l/Wt1I7mNwGe10CvTWND005oqXzZQwNNp
         DhLt0ocUr9yfmhWevlbghdlSQzphya3XLaBR5SwFt7oXbkxqnsKuayHdYiE/dj2hjWns
         CdkxdFzFpk/Kd1bmqkGmgHpsT4F+KismrfJGseg9BrskGwhRFoFukoT02E1IC8I12fSx
         /x9U0g1dwovV1ZuOucQ3qCCZAJXw7+xLMQETrjnjWYBYCe9YP5mVbHCum/SS+xwBKTHI
         zr4A==
X-Gm-Message-State: AOPr4FV2GMq68pCJmKJ+LkwOmudMxpi5zsAH8rOujt4lKwGKzPxVp7I500WUA0iVuuFC/A==
X-Received: by 10.66.132.37 with SMTP id or5mr36786933pab.144.1463309181427;
        Sun, 15 May 2016 03:46:21 -0700 (PDT)
Received: from ashley.localdomain ([106.51.133.65])
        by smtp.gmail.com with ESMTPSA id 71sm39866747pfy.32.2016.05.15.03.46.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 May 2016 03:46:20 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463309133-14503-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294663>

Call ref-filter's setup_ref_filter_porcelain_msg() to enable
translated messages for the %(upstream:tack) atom. Although branch.c
doesn't currently use ref-filter's printing API's, this will ensure
that when it does in the future patches, we do not need to worry about
translation.

Written-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c | 2 ++
 builtin/tag.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index 141168d..fc5eae0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -656,6 +656,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 50e4ae5..a00e9a7 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -373,6 +373,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	git_config(git_tag_config, sorting_tail);
 
 	memset(&opt, 0, sizeof(opt));
-- 
2.8.2
