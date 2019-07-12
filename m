Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEBF41F461
	for <e@80x24.org>; Fri, 12 Jul 2019 23:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfGLXCM (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jul 2019 19:02:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45537 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfGLXCM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jul 2019 19:02:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id x21so11005506otq.12
        for <git@vger.kernel.org>; Fri, 12 Jul 2019 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dereferenced-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dw8p4LT4JC98rkKLoYavt7H4bO7TqoipKHLZtd2NhJw=;
        b=dGTnubjiNlC9R6KODCwLr3OQCvrvRa/XF7eGkr/qfyvPsNs6fPISciyb99bY4mOaH3
         iYdg1PQO0gDWsTX77j8oYAvq6sNjYTlqkZ6znmp54a2EX6sKVlNX46YaCsgVA+6R8Vdp
         3TZoEYDX/nn5Izuhpps0t0tzp2pyv0pOkwXdxkgOsD38XfqQIXwlr0lZsY+y/az9h16Z
         no+0suqWYJeM7LMrN7uVDpWPA6mqFfaT4VqPqNhQh4swbCoUXn3qt2wmHVvMP8OdEIs3
         ovcfj1BleSB87d08ExcNvN6OH49Dsj80k/e+GGgN6LbhvrX/i6FeuKarR7X9XsmJ47bu
         dadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Dw8p4LT4JC98rkKLoYavt7H4bO7TqoipKHLZtd2NhJw=;
        b=qF/QkwsiCkLGf2eYyhCyU2to82hHcIMYX+e0XfrVoLIuYU8jcTFtzu64dvZihXfdXb
         PlDuDJmyFzqkgoe1V56EFi7RlD9WdHaIk3vqYkilaPKxSGmEJQOKeAPMQP/+xifo79nh
         LbuXiKbrxSMBpfor8ScAVjEP2mQ7dkXr3KJQQw0P/CZ0eZlS+kDn61hn2VEA368bLceZ
         c+9JPoWCUVMxDppT3eMDr74bHhGlNpu/7wo/Jkv5W6aZW+sOzRdEzB/sZmJ6Q85J0r6V
         uRuCeM5qQImtryC71gWh7KjkDnNWd1QmxsZQEEHw7e+NFZKCsfAFLSo3IFaIo/KADjjf
         A+jw==
X-Gm-Message-State: APjAAAXh9UbsX+UaFksquFcSYwPrYKTqs9AwojatWSWrWv+aFDP/YHPP
        8BK7demnAw7OSGcGq5PXfy2G1/22
X-Google-Smtp-Source: APXvYqwkLuv3RojInUOJemHxFVDk5p/fyaNw+ccDz7fDLfHo9MS4WVijw+PPsWkAspCJJ7GkO3FWcw==
X-Received: by 2002:a9d:6a92:: with SMTP id l18mr9918702otq.294.1562972531093;
        Fri, 12 Jul 2019 16:02:11 -0700 (PDT)
Received: from nanabozho.attlocal.net ([2600:1700:8660:6160:c055:b92a:b249:c6a6])
        by smtp.gmail.com with ESMTPSA id i21sm3260066otl.24.2019.07.12.16.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 16:02:10 -0700 (PDT)
From:   Ariadne Conill <ariadne@dereferenced.org>
To:     git@vger.kernel.org
Cc:     Ariadne Conill <ariadne@dereferenced.org>
Subject: [PATCH v2 1/3] log: add warning for unspecified log.mailmap setting
Date:   Fri, 12 Jul 2019 18:02:02 -0500
Message-Id: <20190712230204.16749-2-ariadne@dereferenced.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190712230204.16749-1-ariadne@dereferenced.org>
References: <20190712230204.16749-1-ariadne@dereferenced.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Based on discussions around changing the log.mailmap default to being
enabled, it was decided that a transitional period is required.

Accordingly, we announce this transitional period with a warning
message.

Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
---
 builtin/log.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/log.c b/builtin/log.c
index 7c8767d3bc..559f42fe48 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -47,7 +47,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config;
+static int use_mailmap_config = -1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -151,6 +151,16 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
+static char warn_unspecified_mailmap_msg[] =
+N_("log.mailmap is not set; its implicit value will change in an\n"
+   "upcoming release. To squelch this message and preserve current\n"
+   "behaviour, set the log.mailmap configuration value to false.\n"
+   "\n"
+   "To squelch this message and adopt the new behaviour now, set the\n"
+   "log.mailmap configuration value to true.\n"
+   "\n"
+   "See 'git help config' and search for 'log.mailmap' for further information.");
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -199,6 +209,19 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
+	if (mailmap < 0) {
+		/*
+		 * Only display the warning if the session is interactive
+		 * and pretty_given is false. We determine that the session
+		 * is interactive by checking if auto_decoration_style()
+		 * returns non-zero.
+		 */
+		if (auto_decoration_style() && !rev->pretty_given)
+			warning("%s\n", _(warn_unspecified_mailmap_msg));
+
+		mailmap = 0;
+	}
+
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
-- 
2.17.1

