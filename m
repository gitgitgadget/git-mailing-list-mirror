Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3B41202F8
	for <e@80x24.org>; Thu,  9 Mar 2017 19:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933017AbdCITa5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 14:30:57 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36302 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932799AbdCITa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 14:30:56 -0500
Received: by mail-pf0-f176.google.com with SMTP id o126so32302831pfb.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 11:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DMOrP7m+x7gaq7PjmM3ZkPGqmTiDyPl6JDsZYCzpGZw=;
        b=tqjOhFMLl8beIQXXOizXVCj8joui7T2b2xQ/mLPoniBb0R1gL/y6z6KpItPlCIg8Yv
         56bc1NTMgFyL7wb3d4hCL41sHygDAZmEiqDqAXgYe7hke5otGZSJ8gzuMV9ZYmO6WiW7
         RAEKABPUG/sHdOreDxxvx8YVkjIcJ+erPnh/seqA+/pI9VOMKkygWt+d/SgjLhMGXoKG
         bQnVRD3rqsluTTe5MtQ/hArcIyvXUHClGKHU/pHgKZ5NMNsRdKjPMRr909GR6PFLHLSx
         OY/5Bqpvwu6jKlXKbFjuSQlYQGJT5F+Zw23lC5UMCP0LStEcEi+BsHhmoxuz5RvFc/7h
         AT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DMOrP7m+x7gaq7PjmM3ZkPGqmTiDyPl6JDsZYCzpGZw=;
        b=AC2hOglr5QFylEyhQWGZ9NuHo/LscTiDuEAeeuOsOg9nuM4uAnqfGezxYKTkhXNpGw
         5D6MlroHWIuuv8vdwnnVTFC/iosbh2WG7dij94iYjQz1aMFPf7iO3CFrITUihcyE85W1
         bDnYaNtNijEV3JzeK4cLyWdlViZ3mtsDQTShs/iqobS2BTc+Hl8kSK0KGixTs8Bkccks
         i2ozVOi0KNJL93pZOPsj4gBMj0Tosr2ByQtgL5PA/wJsKSpt/Kra1P1qgK57CVs6N5pm
         QkQ0bO5sH4cct57b/M0bZPIqI07UXvLvecTNv+lpWIiu8O/nfzEb/WvdC8HSAbY9C8yB
         fc7Q==
X-Gm-Message-State: AMke39nUhD2JqmWEXtnDnjLE9c28kM2x/LUA0GumRQxddRXiPM0z0EoCwt4LScqA6Y95ZiM7
X-Received: by 10.98.33.129 with SMTP id o1mr15955142pfj.5.1489087854620;
        Thu, 09 Mar 2017 11:30:54 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id t6sm14149796pgt.8.2017.03.09.11.30.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 11:30:53 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH] help: add optional instructions for reporting bugs
Date:   Thu,  9 Mar 2017 11:30:50 -0800
Message-Id: <20170309193050.19988-1-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.190.g6e60aba09d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git is distributed in various ways by various organizations. The Git
community prefers to have bugs reported on the mailing list, whereas
other organizations may rather want to have filed a bug in a bug tracker
or such.  The point of contact is different by organization as well.

When reporting bugs, users will usually look at the output of
'git --version' at one point to write a quality bug report.
So that is a good spot to provide additional information to the user
about e.g. additional the organizational quirks how to report a bug.

As the output of 'git --version' is parsed by scripts as well,
we only want to present this information to users, which is why
we only give the output to TTYs.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Not sure if this is a good idea at all, hence RFC.

Thanks,
Stefan

 help.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/help.c b/help.c
index bc6cd19cf3..d4c1fbe5cb 100644
--- a/help.c
+++ b/help.c
@@ -9,6 +9,12 @@
 #include "version.h"
 #include "refs.h"
 
+#ifdef GIT_BUG_REPORT_HELP
+const char git_bug_reporting_string[] = GIT_BUG_REPORT_HELP;
+#else
+const char git_bug_reporting_string[] = "To report bugs send a plain text email to git@vger.kernel.org";
+#endif
+
 void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 {
 	struct cmdname *ent;
@@ -435,6 +441,8 @@ int cmd_version(int argc, const char **argv, const char *prefix)
 			/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
 		}
 	}
+	if (isatty(1))
+		puts(git_bug_reporting_string);
 	return 0;
 }
 
-- 
2.12.0.190.g6e60aba09d.dirty

