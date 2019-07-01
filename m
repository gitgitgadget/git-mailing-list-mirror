Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DEFF1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 20:20:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfGAUUZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 16:20:25 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:36233 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGAUUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 16:20:25 -0400
Received: by mail-pg1-f202.google.com with SMTP id s4so8207693pgr.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h5tPu6j20EkRGmVU+jgtTRm2YSQXSICHUxEy38FikbE=;
        b=dZVFrhGwRaQQ1LuJ2V7jGJ+ykxsvb4dPC56EA7nINtcAbXLPMVcs9uQRJsjhhyM4C3
         lF1IffU3WVDEzVeC40uZDURMcuAnA3MDxqjdIJdYyUSypTSb875FnB5ayZ8Y2gUBzTFN
         NlTQhFnZvbdK2RDOeW/hR2nZpiuDnHzdH6gBWKrLFRtw2PU7nGLR78aaKsChw4E+lNQb
         yvA+JdmyD5Q+V171uujuxuSh0lvhgpxogrdvbAvWaWrFUVymP8xptU6vPkkkky6fW+FY
         ri7OHg9hgNcXLIdWvh3njzrvtIdrr5V0NdB8Sl0AOzx2KD/pBuV2kfAfEJJ7qJ8fVzYI
         AkSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h5tPu6j20EkRGmVU+jgtTRm2YSQXSICHUxEy38FikbE=;
        b=WYjohMLwR+6/D0lbbGWoWfk8RXgDgFAsJ/69gRillYIlELySX9muVyTfeaJjZWkVVe
         e8KoizYdD0j1a/Wvf61KcQFiygmUOaQ6wXPjXapS6QM00F3WmgIjdoAqLeN5hLQ/rW5t
         S5coPycaH4xI+fpUYY4pTCyUQW5OQ54CktboZO/21i2F6qI+gM1n3HLv6MKyYaHT1gRl
         OBFUJ8k2rHJaoVx55hTUNJztYbh2YGKpAmtvFiZhBf/K97sQhnxGlBA23FUdK4/T6G5q
         mfOi7VNdaGfkAwP0LnaeXptds54R/QJaBL8zSZn8MdEluh4gbJFQf43vuxiq0SCUeyR7
         yvKw==
X-Gm-Message-State: APjAAAXvA4HEqP5JdkHAzua1r55bM7g7lRP716WVy7o0g56XZAORIPNP
        IsE25ziFSdj4qG2bIZA07mhiwrlRRM7qfdsrTsZBHNut5kfVW0AD3xO4Eexah/qRp+VWM0Fe9ym
        rPd7CFSIXmvXvXSoQ3dSxlADomL90OyK0rPfOJxLjThf0c8GBQEGeCGCHOukSYq7c752OcZKoLw
        ==
X-Google-Smtp-Source: APXvYqw1yMYoVw1WVFSq0RVzAyq6cLzkM2wdV/6YH7z2JHYNAtZ3VbdZ3YL1QyXoCmnKT2urqUVp3qbSJTPP3NNcKVk=
X-Received: by 2002:a63:5765:: with SMTP id h37mr8974312pgm.183.1562012424385;
 Mon, 01 Jul 2019 13:20:24 -0700 (PDT)
Date:   Mon,  1 Jul 2019 13:20:02 -0700
In-Reply-To: <20190701202014.34480-1-emilyshaffer@google.com>
Message-Id: <20190701202014.34480-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190701201934.30321-1-emilyshaffer@google.com> <20190701202014.34480-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH v3 01/13] walken: add infrastructure for revwalk demo
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Begin to add scaffolding for `git walken`, a toy command which we will
teach to perform a number of revision walks, in order to demonstrate the
mechanics of revision walking for developers new to the Git project.

This commit is the beginning of an educational series which correspond
to the tutorial in Documentation/MyFirstRevWalk.txt.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Change-Id: I64297621919412f54701e111366e99c4ef0feae3
---
 Makefile         |  1 +
 builtin.h        |  1 +
 builtin/walken.c | 18 ++++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 builtin/walken.c

diff --git a/Makefile b/Makefile
index f58bf14c7b..5bac1dbf8d 100644
--- a/Makefile
+++ b/Makefile
@@ -1137,6 +1137,7 @@ BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
 BUILTIN_OBJS += builtin/verify-tag.o
+BUILTIN_OBJS += builtin/walken.o
 BUILTIN_OBJS += builtin/worktree.o
 BUILTIN_OBJS += builtin/write-tree.o
 
diff --git a/builtin.h b/builtin.h
index ec7e0954c4..c919736c36 100644
--- a/builtin.h
+++ b/builtin.h
@@ -242,6 +242,7 @@ int cmd_var(int argc, const char **argv, const char *prefix);
 int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 int cmd_verify_tag(int argc, const char **argv, const char *prefix);
 int cmd_version(int argc, const char **argv, const char *prefix);
+int cmd_walken(int argc, const char **argv, const char *prefix);
 int cmd_whatchanged(int argc, const char **argv, const char *prefix);
 int cmd_worktree(int argc, const char **argv, const char *prefix);
 int cmd_write_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/walken.c b/builtin/walken.c
new file mode 100644
index 0000000000..db3ca50b04
--- /dev/null
+++ b/builtin/walken.c
@@ -0,0 +1,18 @@
+/*
+ * "git walken"
+ *
+ * Part of the "My First Revision Walk" tutorial.
+ */
+
+#include "builtin.h"
+
+int cmd_walken(int argc, const char **argv, const char *prefix)
+{
+	/*
+	 * This line is "human-readable" and we are writing a plumbing command,
+	 * so we localize it and use the trace library to print only when
+	 * the GIT_TRACE environment variable is set.
+	 */
+	trace_printf(_("cmd_walken incoming...\n"));
+	return 0;
+}
-- 
2.22.0.410.gd8fdbe21b5-goog

