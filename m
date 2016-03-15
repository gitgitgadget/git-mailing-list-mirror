From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 14/16] branch, tag: use porcelain output
Date: Tue, 15 Mar 2016 22:17:14 +0530
Message-ID: <1458060436-1215-15-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8b-000108-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965318AbcCOQsB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:48:01 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33736 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965300AbcCOQr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:57 -0400
Received: by mail-pf0-f171.google.com with SMTP id 124so35902663pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sZ+J/3Uh0J7k4eO8ZDV6qoQGMfnySZuo81OjCVkDujg=;
        b=Ralgcj+7zcOjOvCpe2W53a0i35474sPOG4uApKuVrKpodqfVd//5TJcDWxnFtiL+An
         V9PwTL+dDO1VsTpCn40014qsm/ZhcvgdJPL+ISIjmkOOlOPH21ka3nbbaZQ/gKwOo8gt
         UDv9OGIINu6lDd9iAFhumwFr8OYHmtFvvip8a904gPCk34R2es5h88RS9UdA+dKqyl+3
         D0s79AZ3bWNQsvYt4bY7LVJLKx4SBdetRgF5mH5AScLhQau4f0tuUdjIaFTkAvuQPbII
         37MyLmR6SONqRvmnCcyisuZLCNoNLBaH0LSi4j4Nr/56HAcSU2wDPy6+tdvQqyaeU1CJ
         MZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sZ+J/3Uh0J7k4eO8ZDV6qoQGMfnySZuo81OjCVkDujg=;
        b=NKI9x8N2Rh4ydViJICZOcqIXOYcweAfecSC4859fdrqgd5KpFV9qpHqzX6XAMB+uSN
         p0prJocYZHx7a2ihfkuvqUmyoq32i6LX18IcAx+gIQtv8/x2fWXC+a50eVM+ObfpVshw
         3u38gxa0pmr8K1s0tzrEXHCKv3hjkRG44xCORDK/e+va3fHuYKRDG16a7wd0715o5/gA
         FFalK/ncbWCkteIamcmwgDzeBs5lByAElxmtaOTM1cgSM+l6zJNmW2uGbW5A41koNrkV
         EDQF58A9yZLKzVT9hxoA0IDs0EReFpArgoOVikTdI+nIKs/HypyFT4LF6YTZInqzAoDQ
         C1Bg==
X-Gm-Message-State: AD7BkJLfaO4HqV6wSdig+ElhqoGs2lilYhkSMrJPIlmBrUNyz+yjth4d/buMY3fWcwt7OQ==
X-Received: by 10.98.68.71 with SMTP id r68mr40083068pfa.119.1458060476606;
        Tue, 15 Mar 2016 09:47:56 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:56 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288873>

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
index 460f32f..8747d82 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -622,6 +622,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_END(),
 	};
 
+	setup_ref_filter_porcelain_msg();
+
 	memset(&filter, 0, sizeof(filter));
 	filter.kind = FILTER_REFS_BRANCHES;
 	filter.abbrev = -1;
diff --git a/builtin/tag.c b/builtin/tag.c
index 1705c94..82a04ed 100644
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
2.7.3
