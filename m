Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077351F462
	for <e@80x24.org>; Fri,  7 Jun 2019 01:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfFGBI4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 21:08:56 -0400
Received: from mail-ua1-f73.google.com ([209.85.222.73]:41541 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfFGBI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 21:08:56 -0400
Received: by mail-ua1-f73.google.com with SMTP id a29so105797uah.8
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ezAByRz+Df2EkEWo74xlf1/fJ1g1mXu8fHuaGI964Z0=;
        b=h9fEj/iAnTCUy1/sCN5ZAWPlHcp8IF+Gvak638FRoFe6nxF8ca4BGhcOCoGCVGNw7V
         J9M9F2vdqpVvrBjNndXYCCoNgV9N02KZCSALt7coHHx9+HFMrmyZv63xDQhWP4E2KFQB
         xIgk1RsJ6m/OVQS94XhVa+RERBWM2sEglCFAY2nHtY8BA6MppJII5GRGTyC6YfesOLgo
         QN4KkZM+hWrIH43/ecTL16Vus+wnuyFgnzrTmJQhRotr+5XhBP75J8XSaEBXoeO6iMAQ
         XObuhyOj2uqQiUNFQmkh81QpOvNfLxNUTq8sLmiyN+RjFKZTJ8KIXfV3xI+i2yCJ5AdU
         eHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ezAByRz+Df2EkEWo74xlf1/fJ1g1mXu8fHuaGI964Z0=;
        b=mDGOd2ya7SHgMpJDUmdS31EOxy8zGEGTRCnoONAN6FF7VEa6FmQspqOsRT1dWT8OEU
         pKphgnPiNMz9urqcshFeI/qbJD6/QkoSiPvQzIq2z1Lyf5cakjz+xLsUHRrMdmNqri4y
         aUM2cMSNWu16wE2rAOjabxGjDeLDhe7BGu5EcPYCiM1sLDszGCkCfISQa31WL+kpYe9I
         n0suJ2jf3PE5O28u0m4X4R1FTObauEoZJ4kkM/dYNEEKyBS5G51s0a3WDc4chRreW4Fa
         Nn7W/g6cMlca3ErYnlQ6pvk1FnDVfclTD5sv6dj/ncR22lDrWq2/Aitvj1XsE2tMlOIk
         xkjg==
X-Gm-Message-State: APjAAAX39N/7+RwdvQL3Cp8N5e/fG/FgOIAkyo6K2AAhGyNegjgmf0pc
        V18ktq7NL0cyW1LqgsD8zJXz6oa8nzAb0ZG5m/eqDWBUzOtKbCIC1qD1D24buoCfZcvKSTdSlhF
        FzgKpETwdLLzPR0vNxIaezCva0L+oaDdQQekgIFMB2sNOxBQ0HUhTzoW+nX1RYM1Wm6zoT7FU9g
        ==
X-Google-Smtp-Source: APXvYqysB+/BS8BlKxWmqPxtz09olHql38g2j7xfp0wrcsVtqYhiz6hORXq2yM07SWFl7h7pnH7j9Po47+pqbfaB6bA=
X-Received: by 2002:ab0:60d0:: with SMTP id g16mr24734886uam.85.1559869735754;
 Thu, 06 Jun 2019 18:08:55 -0700 (PDT)
Date:   Thu,  6 Jun 2019 18:07:59 -0700
In-Reply-To: <20190607010811.52944-1-emilyshaffer@google.com>
Message-Id: <20190607010811.52944-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com> <20190607010811.52944-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [RFC PATCH 01/13] walken: add infrastructure for revwalk demo
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
---
 Makefile         |  1 +
 builtin.h        |  1 +
 builtin/walken.c | 14 ++++++++++++++
 3 files changed, 16 insertions(+)
 create mode 100644 builtin/walken.c

diff --git a/Makefile b/Makefile
index 8a7e235352..a25d46c7a3 100644
--- a/Makefile
+++ b/Makefile
@@ -1143,6 +1143,7 @@ BUILTIN_OBJS += builtin/var.o
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
index 0000000000..bfeaa5188d
--- /dev/null
+++ b/builtin/walken.c
@@ -0,0 +1,14 @@
+/*
+ * "git walken"
+ *
+ * Part of the "My First Revision Walk" tutorial.
+ */
+
+#include <stdio.h>
+#include "builtin.h"
+
+int cmd_walken(int argc, const char **argv, const char *prefix)
+{
+	printf(_("cmd_walken incoming...\n"));
+	return 0;
+}
-- 
2.22.0.rc1.311.g5d7573a151-goog

