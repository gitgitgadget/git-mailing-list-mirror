Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F305C7EE22
	for <git@archiver.kernel.org>; Wed, 17 May 2023 23:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjEQX4m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 19:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQX4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 19:56:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCA03AA2
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-b8f324b3ef8so1717710276.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 16:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684367796; x=1686959796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Iam80mBx4/hpSNCxo8gbjH6uIxlyYlkKW2FIvK05s=;
        b=KbkL3dJZAWwEYweogw9cxzPiEBMFYNHP70eADfR3QV1maRII3ymZdZB8UDxgrBeLJg
         WfgfgzSMvq5N6UwVhu9iQqIxsFxPBCDXFLD5QxB69s+mNiOqaIQrtwy5Pkh6yOMn/lrM
         P/NVorvLDl2jheMKbx2HKpqtumHW7Bc3DAmR/ZT+ckoiiMrebb6D9gv+Uk7+2yAX1sHw
         gFPWninio1dAhsMaHMb/1XNQ71Ynw9jtytRt+vcmcBAbNn2Lsz6i6YHFGZJ5h2v+tyrv
         LfqCt+jqfuABrKG3ENUeapmjc0RyLwk3lrvmOVTF/rTahah3SXLPrvGPWfQ+S3vYNx3y
         l1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684367796; x=1686959796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+Iam80mBx4/hpSNCxo8gbjH6uIxlyYlkKW2FIvK05s=;
        b=I+JQuQ9AEwNFWutYFyZ9PFUOxBt3/Ns/ayxOMUn4u4PgpIOgUdlP1wTan2VVLZd0ob
         YuT0O4EjM7Ui4oSgfC/Tk7IUUoN0yVdzYkHRvTGYc24ihc1kHe5VOPKa8WNX0Wr7oDJF
         KQHr9FjLfvWdJVqvAAi8tYT90ihFbotkGqgZaxGZIdeH03h102r97Is4MerNeMuuI0aG
         QEJ6+9qmMg9ZbcvysP2b2T7vGMkDQyORzeLKjGIPQlP57QKsl/g9R+m6d0YpzCNaWREL
         mEtGhGR58l4/cBB47rNaJEIFxED7T3fsVqa/MKHZOfpApiTyEQw4Kvy+K6ikt/UVRJ93
         kFRg==
X-Gm-Message-State: AC+VfDzLE19RfxnuIIVeMaOiMJN4BrBobnxSfDOFssKIv9IlELj3PzwB
        TKq7926xaeCeEBc6rPZ2Ey2QjZl6GViqHbap8C3Fz/frcX9SAhcF/fj9LqNvqBimIF23x9nu8mc
        i9FXJuGZFi3t4Db7mO1TBWj6c39IwzXH5zwq7Jt9qlABYyDQRNxpDxFB+05qgSTg=
X-Google-Smtp-Source: ACHHUZ5frjTRbPIAtEKWNG7nG9glopKgPVeDbemGc/yw3iI3pm7mXRAJm1qeuclH23mTQ8fQXOxAsd/NZZ6vZA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:202:f597:a1b7:3c54:2bc8])
 (user=steadmon job=sendgmr) by 2002:a81:af64:0:b0:561:985a:5b4c with SMTP id
 x36-20020a81af64000000b00561985a5b4cmr4196291ywj.5.1684367796710; Wed, 17 May
 2023 16:56:36 -0700 (PDT)
Date:   Wed, 17 May 2023 16:56:31 -0700
In-Reply-To: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
X-Mailer: b4 0.12.2
Message-ID: <20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com>
Subject: [PATCH RFC v2 1/4] common-main: split common_exit() into a new file
From:   steadmon@google.com
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>, calvinwan@gmail.com,
        szeder.dev@gmail.com, phillip.wood123@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is convenient to have common_exit() in its own object file so that
standalone programs may link to it (and any other object files that
depend on it) while still having their own independent main() function.
So let's move it to a new common-exit.c file and update the Makefile
accordingly.

Change-Id: I41b90059eb9031f40c9f65374b4b047e7ba3aac0
---
 Makefile      |  1 +
 common-exit.c | 26 ++++++++++++++++++++++++++
 common-main.c | 24 ------------------------
 3 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/Makefile b/Makefile
index e440728c24..8ee7c7e5a8 100644
--- a/Makefile
+++ b/Makefile
@@ -987,6 +987,7 @@ LIB_OBJS += combine-diff.o
 LIB_OBJS += commit-graph.o
 LIB_OBJS += commit-reach.o
 LIB_OBJS += commit.o
+LIB_OBJS += common-exit.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
diff --git a/common-exit.c b/common-exit.c
new file mode 100644
index 0000000000..1aaa538be3
--- /dev/null
+++ b/common-exit.c
@@ -0,0 +1,26 @@
+#include "git-compat-util.h"
+#include "trace2.h"
+
+static void check_bug_if_BUG(void)
+{
+	if (!bug_called_must_BUG)
+		return;
+	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
+}
+
+/* We wrap exit() to call common_exit() in git-compat-util.h */
+int common_exit(const char *file, int line, int code)
+{
+	/*
+	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
+	 * to e.g. turn -1 into 255. On a POSIX system this is
+	 * redundant, see exit(3) and wait(2), but as it doesn't harm
+	 * anything there we don't need to guard this with an "ifdef".
+	 */
+	code &= 0xff;
+
+	check_bug_if_BUG();
+	trace2_cmd_exit_fl(file, line, code);
+
+	return code;
+}
diff --git a/common-main.c b/common-main.c
index f319317353..a8627b4b25 100644
--- a/common-main.c
+++ b/common-main.c
@@ -62,27 +62,3 @@ int main(int argc, const char **argv)
 	/* Not exit(3), but a wrapper calling our common_exit() */
 	exit(result);
 }
-
-static void check_bug_if_BUG(void)
-{
-	if (!bug_called_must_BUG)
-		return;
-	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
-}
-
-/* We wrap exit() to call common_exit() in git-compat-util.h */
-int common_exit(const char *file, int line, int code)
-{
-	/*
-	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
-	 * to e.g. turn -1 into 255. On a POSIX system this is
-	 * redundant, see exit(3) and wait(2), but as it doesn't harm
-	 * anything there we don't need to guard this with an "ifdef".
-	 */
-	code &= 0xff;
-
-	check_bug_if_BUG();
-	trace2_cmd_exit_fl(file, line, code);
-
-	return code;
-}

-- 
2.40.1.606.ga4b1b128d6-goog

