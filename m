Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FECBC4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 10:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839F160F70
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbhHBKal (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 06:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhHBKak (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 06:30:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F327C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 03:30:30 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id nd39so30111496ejc.5
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=xlb74iYCBLxzLTl+JF06FMY05VY+TmxgJzEWm4B2SVQ=;
        b=UCNZ5mknc+Co1UxnTaY/4i9CzsvtAshTkqOYcngfJMn/PifVTgokLJj236w8cB1VDh
         Kr787K6c1pBFt1548Q/MMWLv7WCgazjB40DMTvtWf/pN1sV5elAHZKi4ob+Nwjj0/TKY
         ATmNEwNdaKaQgK3xZVVsCmmrxqyuGj08DZ2CrB6YGd8hJdnR8N7+QABKIFlRVEz5ahuE
         mTbWxl7h1ozB36cYED1zPvD0Zerh6aMU/+WLn7EgFqplDrwD9zsd/QKr+UxD4USnUoHQ
         Sw/6Cg9O/I1rht9PtcCtdiwyfSE0WGdlFCi/PefQ/dZbieL6K0o6V2xz1G9IJ68T1Hg9
         ovwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=xlb74iYCBLxzLTl+JF06FMY05VY+TmxgJzEWm4B2SVQ=;
        b=BZAV6unFoB1YxQiZY7LqwuJJVlUiKozjuqJ8PfWH4tDA896c3WE0t9KJkQqOCmyTtT
         Ghq5zIC0vbK2zj6sHEN5rMtsyyCYF9hm2r6B7hyw1Y4KDUL1612JMgN3naaK/3/q0pe2
         Tt2cxizajI2QseFyWqUXzku78o72YyIWvJVwiXamZ2VJo0T98Yxkk/ztOgrXwPUJvHy/
         +Th5aph/2CsCqpuy4xB2j+bPy6QiRBdr5zqOguF7+3wrZwg+FxMR9Q0IPTCrA+HMd0gI
         i6SEkdsWs5YGb5XgFbVbwj5pEsepmFh/5jwwyskAwfDiVxHM0urYmiKLWbBqcatONtd/
         zxiQ==
X-Gm-Message-State: AOAM531H+R8tw8SzgnlbILrZ6MFquZPgPldA9M/JzRXVO4hMbng5gnnx
        5xYUqF3qXPwDSlffIEHeZaM=
X-Google-Smtp-Source: ABdhPJzZfcfnmHUCH8i3cnXeQp06weTl9IbG3CKIx9yIN+vRYgu0I9ddPoCxmiLu1TP4tyLWbMlJKg==
X-Received: by 2002:a17:906:bc87:: with SMTP id lv7mr14813062ejb.365.1627900228559;
        Mon, 02 Aug 2021 03:30:28 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id de49sm4338138ejc.34.2021.08.02.03.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 03:30:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 2/2] tr2: log parent process name
Date:   Mon, 02 Aug 2021 12:22:07 +0200
References: <20210722012707.205776-1-emilyshaffer@google.com>
 <20210722012707.205776-3-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210722012707.205776-3-emilyshaffer@google.com>
Message-ID: <87o8agp29o.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 21 2021, Emily Shaffer wrote:

> Git for Windows also gathers information about more than one generation
> of parent. In Linux further ancestry info can be gathered with procfs,
> but it's unwieldy to do so.

Having read the win32 get_processes() implementation and read proc(5) I
don't get how it's unweildy to do so on Linux? Perhaps I'm missing some
special-case but this rather simple patch-on-top seems to do the job for
me. This includes the unrelated enum/switch/case change I suggested.

I can submit it as a patch-on-top with SOB etc, but maybe there's some
subtle reason it won't work properly. It works for me, I get e.g.:
    
    {
      "event": "cmd_ancestry",
      "sid": "20210802T102731.879424Z-Hc2f5b994-P00001acc",
      "thread": "main",
      "time": "2021-08-02T10:27:31.879618Z",
      "file": "compat/linux/procinfo.c",
      "line": 66,
      "ancestry": [
        "bash",
        "screen",
        "systemd"
      ]
    }

If anything the existing Windows version seems a bit unweildy, having to
apparently deal with cycles etc., I don't think that happens under
procfs, but maybe I'm missing some special-case.

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index 578fed4cd31..671fe2395fd 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -4,51 +4,65 @@
 #include "strvec.h"
 #include "trace2.h"
 
-static void get_ancestry_names(struct strvec *names)
+static int stat_parent_pid(FILE *fp, char *statcomm, int *statppid)
+{
+	char statstate;
+	int statpid;
+
+	int ret = fscanf(fp, "%d %s %c %d", &statpid, statcomm, &statstate,
+			 statppid);
+	if (ret != 4)
+		return -1;
+	return 0;
+}
+
+static void push_ancestry_name(struct strvec *names, pid_t pid)
 {
-	/*
-	 * NEEDSWORK: We could gather the entire pstree into an array to match
-	 * functionality with compat/win32/trace2_win32_process_info.c.
-	 * To do so, we may want to examine /proc/<pid>/stat. For now, just
-	 * gather the immediate parent name which is readily accessible from
-	 * /proc/$(getppid())/comm.
-	 */
 	struct strbuf procfs_path = STRBUF_INIT;
-	struct strbuf name = STRBUF_INIT;
+	char statcomm[PATH_MAX];
+	FILE *fp;
+	int ppid;
 
 	/* try to use procfs if it's present. */
-	strbuf_addf(&procfs_path, "/proc/%d/comm", getppid());
-	if (strbuf_read_file(&name, procfs_path.buf, 0)) {
-		strbuf_release(&procfs_path);
-		strbuf_trim_trailing_newline(&name);
-		strvec_push(names, strbuf_detach(&name, NULL));
-	}
+	strbuf_addf(&procfs_path, "/proc/%d/stat", pid);
+	fp = fopen(procfs_path.buf, "r");
+	if (!fp)
+		return;
 
-	return;
-	/* NEEDSWORK: add non-procfs-linux implementations here */
+	if (stat_parent_pid(fp, statcomm, &ppid) < 0)
+		return;
+
+	/*
+	 * The comm field is in parenthesis, use printf + offset as a
+	 * poor man's trimming of both ends.
+	 */
+	strvec_pushf(names, "%.*s", (int)strlen(statcomm) - 2, statcomm + 1);
+
+	/*
+	 * Both errors and reaching the end of the process chain are
+	 * reported as fields of 0 by proc(5)
+	 */
+	if (ppid != 0)
+		push_ancestry_name(names, ppid);
 }
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
-	if (!trace2_is_enabled())
-		return;
+	struct strvec names = STRVEC_INIT;
 
-	/* someday we may want to write something extra here, but not today */
-	if (reason == TRACE2_PROCESS_INFO_EXIT)
+	if (!trace2_is_enabled())
 		return;
 
-	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
-		/*
-		 * NEEDSWORK: we could do the entire ptree in an array instead,
-		 * see compat/win32/trace2_win32_process_info.c.
-		 */
-		struct strvec names = STRVEC_INIT;
-
-		get_ancestry_names(&names);
+	switch (reason) {
+	case TRACE2_PROCESS_INFO_EXIT:
+		break;
+	case TRACE2_PROCESS_INFO_STARTUP:
+		push_ancestry_name(&names, getppid());
 
 		if (names.nr)
 			trace2_cmd_ancestry(names.v);
 		strvec_clear(&names);
+		break;
 	}
 
 	return;
