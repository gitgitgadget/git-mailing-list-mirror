From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 14/16] branch, tag: use porcelain output
Date: Wed, 30 Mar 2016 15:09:58 +0530
Message-ID: <1459330800-12525-15-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcM-0001nn-9r
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbcC3Jks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:48 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32953 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbcC3Jko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:44 -0400
Received: by mail-pa0-f53.google.com with SMTP id zm5so36442234pac.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ETJlqDNZTNlkavwoOtFRtcCineqnRp/aDV6gsZ/Y4u0=;
        b=nnl9YRpMwfUamEC8FUOqotXgeDUa5wQ6Yc/mEvTCShdXsNIt5e1IZnf4AWSXxyC6Wz
         KkIw+l/7P3p2HfJ3XSDth0F+nZhhMGb60DTND5Mfd9Sr1frzVGVIHPKCOzze1/rT/MLO
         2sFdDe2uCfksSrQRSvyh83MQnEM9+BDUs4McBJDhfqETGqlICGeoiQKcQbvCU1s0D067
         Ti2P03sT3cIGghNr4hsiBW20ilf/b+IsA+glmdf99/2Pu9Tukzu/6YddOzv0Td74Se1r
         cc68wtTVp4XrVf2INvnZx4d665FIgZPM98c8avo52HsXIAI/8vtgRDEfC8jeZzRZNl4f
         hsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ETJlqDNZTNlkavwoOtFRtcCineqnRp/aDV6gsZ/Y4u0=;
        b=YCA7qG/M/5rafIpBGi2eLiulEmDfErnc8n6/qr3oYCfMkiS97IVnoq74kMoaxUYjQh
         2LhNsirYQhdQ0wVEZUN7phuCQ2OCq5oRIHwN8ZejGnwp+keCYbJFr//UhuxZbnA2W6lK
         uh1Ng3nbO4BfLxk8iV9LyyqrGYuITTBbUixQRYzgYlzhoSdevNkf20LQMa2GsMGV/fL2
         gng/Z5yde1kTI7zbfFssXtpw3B6+nx8onjgOxgSwqImhL86yfzTuiNa4RZ1e+vTZFy0J
         8yp1wlpQsUgjdINGVpdJtViCxwEHCkRrg+uErV9LEnumr/fjTdQgONqmY05yUn5d7Cpk
         pHzA==
X-Gm-Message-State: AD7BkJLorYz9Cv7OyMgcKqqMC4Rp30dP+z5t/EkmFlde1KnJ4vXdrZ06ZMh4+lG1IiWinQ==
X-Received: by 10.66.152.231 with SMTP id vb7mr11445642pab.132.1459330843328;
        Wed, 30 Mar 2016 02:40:43 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:42 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290293>

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
2.7.4
