Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE38C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiCKXAf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 18:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiCKXAY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 18:00:24 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18A19457A
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:52:31 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g3so12675961edu.1
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mix3EjUTYijfgFVhy/WdeKOxp1XxhU64A5fCjvbrgag=;
        b=ZXU6ou5u6CVLhumYICwZLXxKoFsFGJK3K+XqOxut9ZA0sfod37UTOGTkhGBYQaRaH4
         6H/5AXV7UvFGTb1x6ZWw/vTyeLyEfwC6iVfjRnZKToFRwVCoXS/T6u9SbkqqrD73XEbE
         4PiR9pToqBLtlPaPRLkncHZ0IPWEQudzowgPQdnHa7v0dpcNTeoDsfaRoN5+kByXGotx
         9VnHK8kOigIV3rwiXDwr3ICF0HSYEnnHnEZqFrrJVBBG1qi6YDc+daLtZNwVFBi2aOYh
         YLjVIfjDMulThjAv4NaDFFUEJs4CHeIItUkFZSeqVfN44aDNI35wBRYzWpeNhmUN2RM6
         NG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mix3EjUTYijfgFVhy/WdeKOxp1XxhU64A5fCjvbrgag=;
        b=J2MAJ69PcsIiIOVMp1RZbgEkdvITbxjWKrFvt8A+lW1mIU4o/FD4O0nCA85FMPl6GP
         BsEz4x9naXoX9VZE27xQeM3vMq7rMb4Pq/aDdFlqPNCSpERXe0Exjr0LJW0oQEn5UA6Q
         E8djnNcJ3O2KBnzIA/rAHqGGOiJM35uijnqQsou+pYXavZb11a3JK7kftVxLOXaBBdMV
         PmfqDqEmE4M3HUlWtkjIBO90El4Hyf3NnfzgCZSnxm5qV4iueFd80LGxBPvt5FZ2qnaA
         sKUMR8lyqW2u9AD+18cGsS8XoBQWkBlstLovDm+YUNqFrSQSq7N3NQ9zaur8qX3wIJae
         7F2w==
X-Gm-Message-State: AOAM532DNqC98syqU799ZLzblrSoETOa5UQc3+gbiFEJVSEBe8FDAAxQ
        iUJhFAelI/6woLhCanDeivUOdgSEWj4=
X-Google-Smtp-Source: ABdhPJx4N4HBSX8lAUjAFkPEauNCAtOzyJ23pcNugvVXr2+DOXBtlWtJ7btNajMBa0OI/zI23emOoQ==
X-Received: by 2002:adf:b1da:0:b0:1f0:1205:89c1 with SMTP id r26-20020adfb1da000000b001f0120589c1mr8435042wra.27.1647033307576;
        Fri, 11 Mar 2022 13:15:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8-20020a1cf708000000b0034d7b5f2da0sm8057872wmh.33.2022.03.11.13.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:07 -0800 (PST)
Message-Id: <578c3682e2fb35af86087e6a0c277aa8766919d7.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:51 +0000
Subject: [PATCH 04/16] t/helper/fsmonitor-client: cleanup call to
 parse_options()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! t/helper/fsmonitor-client: create IPC client to talk to \
FSMonitor Daemon

Elminate unnecessary code in cmd__fsmonitor_client() WRT
parsing of options.

Fix name of test-tool in usage.

Don't localize die() message.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/helper/test-fsmonitor-client.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index f7a5b3a32fa..d59a640f1f9 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -49,7 +49,7 @@ static int do_send_query(const char *token)
 
 	ret = fsmonitor_ipc__send_query(token, &answer);
 	if (ret < 0)
-		die(_("could not query fsmonitor--daemon"));
+		die("could not query fsmonitor--daemon");
 
 	write_in_full(1, answer.buf, answer.len);
 	strbuf_release(&answer);
@@ -85,8 +85,8 @@ int cmd__fsmonitor_client(int argc, const char **argv)
 	const char *token = NULL;
 
 	const char * const fsmonitor_client_usage[] = {
-		N_("test-helper fsmonitor-client query [<token>]"),
-		N_("test-helper fsmonitor-client flush"),
+		N_("test-tool fsmonitor-client query [<token>]"),
+		N_("test-tool fsmonitor-client flush"),
 		NULL,
 	};
 
@@ -96,17 +96,12 @@ int cmd__fsmonitor_client(int argc, const char **argv)
 		OPT_END()
 	};
 
-	if (argc < 2)
-		usage_with_options(fsmonitor_client_usage, options);
+	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
 
-	if (argc == 2 && !strcmp(argv[1], "-h"))
+	if (argc != 1)
 		usage_with_options(fsmonitor_client_usage, options);
 
-	subcmd = argv[1];
-	argv--;
-	argc++;
-
-	argc = parse_options(argc, argv, NULL, options, fsmonitor_client_usage, 0);
+	subcmd = argv[0];
 
 	setup_git_directory();
 
-- 
gitgitgadget

