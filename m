Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E566C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiCYThI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiCYTg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:36:59 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9783E205964
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:09:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso4940178wmz.4
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=XmMONFA/Qg/+RsMZf8jGLI7IZY+EIvoYTBzkq6ObRE/Bf7CcId3pRX25Estf7YgSTE
         iiFq9puvjsnX2F2QmEcRpiD8Viqe0sSoYEH8XnrNeVddoHBlKrr8ezuMRNQeKvgICnTj
         uXmP13Qfw1BHRDQrQKhQDwCdeOiP9eUD1E6+VpgzxHuSzsBLNHiC+9Dl9THJTcxYemWw
         e8ooG93jFhxGKnpmy0369PDvsEg6KqJYc5hoqtZBRn3+oVQD43wkfz/0u3DhCFv8RK7V
         uZn/jr4lDOnjXYBDpKQHvZ3AhOTRAVnN3mOZhxT4SK/plHpV+JAjNAO3velrCrsa0/T8
         tqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3PLwCteJ9y2IKK4YgyfW1TpJLAFrB0rwJ1mFNfWqUuM=;
        b=pdPBL1iKAnPVnZpHiJa6lbxMsCKykrmjMoT5GTNoct2C7pKxs1cvTIM9j7qXnjZHzd
         5epGOiIzqVfSMyivVYSEaC1VUyIGkvdFIDO7Ded7s6IhKYBKwhAGo1Or2sPKVRQT45cS
         rtn+Wdrsyc8L7tlZpCO/lRoBEHWeaKwhyxbGgBoJH5cuZ6w2PLEeqR43nz/ni80DW4uu
         d5om9uRfWoQCYb4lCnzhoAazHveOd18DtfRaGXYKGdnPYDXAliIOVLnEBKaaMgMd31yI
         6nVR6XQLgdBtvNCUVxBXffkcHMpSgP6SuWUzlixXcx0apuwitoJPdybZcdWdr4TqTkO4
         uz6g==
X-Gm-Message-State: AOAM531uPYZAnEcqqOsVniKN1zkuPVMTQPsUFIK9pHYdv5kas7mLKcN3
        Dp4D1vAmw933P+pvl8Ud7Mm3zipLC1Y=
X-Google-Smtp-Source: ABdhPJw6AOZ3SkVIUR+TnZVRj90Dt12qetkSALYHFZNI7q9iZX7M2SS4V7I2eJHccdltUB3uzodDmA==
X-Received: by 2002:a7b:c841:0:b0:389:864c:e715 with SMTP id c1-20020a7bc841000000b00389864ce715mr11047079wml.72.1648231403187;
        Fri, 25 Mar 2022 11:03:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b0038cda9f92fasm3833846wms.0.2022.03.25.11.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:22 -0700 (PDT)
Message-Id: <4624ce2fa471b3ebb3a08baf0de2609447eb9fe3.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:50 +0000
Subject: [PATCH v9 07/30] fsmonitor--daemon: implement 'stop' and 'status'
 commands
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Implement `stop` and `status` client commands to control and query the
status of a `fsmonitor--daemon` server process (and implicitly start a
server process if necessary).

Later commits will implement the actual server and monitor the file
system.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/fsmonitor--daemon.c | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index f0498793379..5e3178b8bdd 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -7,10 +7,55 @@
 #include "khash.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
+	N_("git fsmonitor--daemon stop"),
+	N_("git fsmonitor--daemon status"),
 	NULL
 };
 
 #ifdef HAVE_FSMONITOR_DAEMON_BACKEND
+/*
+ * Acting as a CLIENT.
+ *
+ * Send a "quit" command to the `git-fsmonitor--daemon` (if running)
+ * and wait for it to shutdown.
+ */
+static int do_as_client__send_stop(void)
+{
+	struct strbuf answer = STRBUF_INIT;
+	int ret;
+
+	ret = fsmonitor_ipc__send_command("quit", &answer);
+
+	/* The quit command does not return any response data. */
+	strbuf_release(&answer);
+
+	if (ret)
+		return ret;
+
+	trace2_region_enter("fsm_client", "polling-for-daemon-exit", NULL);
+	while (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		sleep_millisec(50);
+	trace2_region_leave("fsm_client", "polling-for-daemon-exit", NULL);
+
+	return 0;
+}
+
+static int do_as_client__status(void)
+{
+	enum ipc_active_state state = fsmonitor_ipc__get_state();
+
+	switch (state) {
+	case IPC_STATE__LISTENING:
+		printf(_("fsmonitor-daemon is watching '%s'\n"),
+		       the_repository->worktree);
+		return 0;
+
+	default:
+		printf(_("fsmonitor-daemon is not watching '%s'\n"),
+		       the_repository->worktree);
+		return 1;
+	}
+}
 
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 {
@@ -28,6 +73,12 @@ int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_fsmonitor__daemon_usage, options);
 	subcmd = argv[0];
 
+	if (!strcmp(subcmd, "stop"))
+		return !!do_as_client__send_stop();
+
+	if (!strcmp(subcmd, "status"))
+		return !!do_as_client__status();
+
 	die(_("Unhandled subcommand '%s'"), subcmd);
 }
 
-- 
gitgitgadget

