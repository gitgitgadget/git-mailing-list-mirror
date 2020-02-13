Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3739BC3B18D
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8EA206DB
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 21:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owflY4+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387403AbgBMVt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:49:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44839 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgBMVt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 16:49:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so8545490wrx.11
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 13:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=O8yNnNJOmavcKvvVT2CYqzuS8mZCEYou49Z1C8L9iq8=;
        b=owflY4+qaQyGod2u4VcjYolw8Yo+DOsEOUGLNpTazsVKTcDttb1e7nRIdOLAzamIzW
         4o2PU/6gRB8Z5WuHuHx51KQkmn7a5h+V8PSdNyl+mWAiQzEPFDHDszhDA70GmS9UmEbW
         7q2kRkgyVuecG5rTf38ha99x9yLuigu2QXRn3ZdMYtj24YgkLU0sFq2/U/u2CSAUR13G
         LBXTS9MceEfV4bnurHFrPvt0oqBmm2EJOqSDCU8+rdOyCe7QJbRoAyGikABckVcq3VV6
         gv37M5Ht+K5IyrdkBWg4aVeQinjoEMYqfnH14tXKees89+6ZMwh58H/6L1Sxnk5tyM2c
         ITew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=O8yNnNJOmavcKvvVT2CYqzuS8mZCEYou49Z1C8L9iq8=;
        b=WbXolCpeNjnz1w/pYP6ghFiUYWa7UEVBrfQ8RrF04jAwQckNLrDTPJE5RqmbbrHjPx
         iTTWOmNBO6wKx2eEG3mUs0WhBeetnxUb8RFHZrXaWrr3jm2liCJGlT1Ks/clLgeCkhSZ
         G5TBynDZd1Dlu2ZcGbjBS1K9gyxl0r5vRXfCZlLLUhvaUeSUjA1fSLtbxr+kzlvLhVAm
         wqKtUC1EJ73D06cprtWbADgcNUOlS+gvwO0zAx0SHIDy3sWFMRZMpfTh08hb0DSIUcn/
         TCitU/MRhf2pUrs63med6hJRLVff3r9bcXHtVASfNkeUnCLABtppq1AYKbkBErHp7/iN
         U/yg==
X-Gm-Message-State: APjAAAUcUVlUGzT30Y0FTvEhgTJiQdq46LuRqA8IgcQMEcUmtmWm92+q
        hcntQ9+csD0YfQyUqAoS5g4jOTJ1
X-Google-Smtp-Source: APXvYqyb4DuJAHtQ5ASE5o6dMktyXnuo/xNAzBOihlM3ZpG2LeUga9hMWjy7lATQKgcs3IicOnKyoA==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr22414663wrn.327.1581630594451;
        Thu, 13 Feb 2020 13:49:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k13sm4408657wrx.59.2020.02.13.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 13:49:54 -0800 (PST)
Message-Id: <pull.150.git.1581630593304.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Feb 2020 21:49:53 +0000
Subject: [PATCH] mingw: add a helper function to attach GDB to the current
 process
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When debugging Git, the criss-cross spawning of processes can make
things quite a bit difficult, especially when a Unix shell script is
thrown in the mix that calls a `git.exe` that then segfaults.

To help debugging such things, we introduce the `open_in_gdb()` function
which can be called at a code location where the segfault happens (or as
close as one can get); This will open a new MinTTY window with a GDB
that already attached to the current process.

Inspired by Derrick Stolee.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    win32: make it easy to start the GNU debugger at a certain source line
    
    In particular when trying to debug issues in processes with redirected
    stdin and/or stdout, it can be quite a challenge to use an interactive
    debugger.
    
    Help this, by introducing a function that is purely meant for debugging
    purposes: open_in_gdb(). It will open a new terminal window, attach gdb
    to the current process in it, and sleep. That way, the above-mentioned
    debugging problem can be solved simply by inserting the statement 
    open_in_gdb(); at a specific source code line, then recompiling Git and
    then running e.g. the regression test that failed.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-150%2Fdscho%2Fopen-in-gdb-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-150/dscho/open-in-gdb-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/150

 compat/mingw.c | 13 +++++++++++++
 compat/mingw.h | 10 ++++++++++
 2 files changed, 23 insertions(+)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8141f77189..615e9b64aa 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -13,6 +13,19 @@
 
 static const int delay[] = { 0, 1, 10, 20, 40 };
 
+void open_in_gdb(void)
+{
+	static struct child_process cp = CHILD_PROCESS_INIT;
+	extern char *_pgmptr;
+
+	argv_array_pushl(&cp.args, "mintty", "gdb", NULL);
+	argv_array_pushf(&cp.args, "--pid=%d", getpid());
+	cp.clean_on_exit = 1;
+	if (start_command(&cp) < 0)
+		die_errno("Could not start gdb");
+	sleep(1);
+}
+
 int err_win_to_posix(DWORD winerr)
 {
 	int error = ENOSYS;
diff --git a/compat/mingw.h b/compat/mingw.h
index 30d9fb3e36..26d3296d56 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -584,6 +584,16 @@ int main(int argc, const char **argv) \
 } \
 static int mingw_main(c,v)
 
+/*
+ * For debugging: if a problem occurs, say, in a Git process that is spawned
+ * from another Git process which in turn is spawned from yet another Git
+ * process, it can be quite daunting to figure out what is going on.
+ *
+ * Call this function to open a new MinTTY (this assumes you are in Git for
+ * Windows' SDK) with a GDB that attaches to the current process right away.
+ */
+extern void open_in_gdb(void);
+
 /*
  * Used by Pthread API implementation for Windows
  */

base-commit: 8104ec994ea3849a968b4667d072fedd1e688642
-- 
gitgitgadget
