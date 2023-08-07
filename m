Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D673C04A6A
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 18:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjHGSvy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjHGSvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 14:51:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCE5E68
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 11:51:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-317716a4622so3835314f8f.1
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691434304; x=1692039104;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=re/fkMTHo/0BCJ7Q11r5cRvbEJ98ymR9C0zXJbJryKM=;
        b=BPHN/aj5pq7DhJ9oLGktesnP0ZQ5iXFvvhIjsQRN2X+XaF7sDrnyOdAv+peYqvO0bh
         yJnuhMFu2kpU9mg4mNbdyMytOhExOXy6GZm39dWWQqp4cOT2ir002z8TohGn5w0ulAcn
         dMQJwnQwVeymas77aa+679dWFe7YpYIZ8U+fdsVgnVMIzIl8KQ+Q/aBSfhMdkEPX4BLu
         b82Gn5Ezp28hQs5Pfc6I7D5aesuoYWoaTavow8xQOfkhKjLc5lbIr8PBlWVza8F58JNV
         D+49d4rInXBbxY2EvOmiHQqK9qFQYtTjIjMh13C/Vuh3zndlaEJkWZwdL7sdnC5Nv5fr
         fReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434304; x=1692039104;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=re/fkMTHo/0BCJ7Q11r5cRvbEJ98ymR9C0zXJbJryKM=;
        b=imqkC4UUGIj/VIsy1AIhAHhe9wv0ea0CsXdYoWXj+7gZ+dkMzGyLFlqJLtly3FtF37
         ExnIll6uBn/W5TFA0zQIZ/TiZd9u+iOyhNgL4uBAscjbxRVb6LkNo0sHs5hvcWBR3zvx
         xMJlEbPBdyBME+BfjzYiRkflpe2jTPU4uqJLRYb+3hX8fTMlmSp4JQYOsftd3Ctq3sgf
         gWA4GsfSjzRPLLBJ1rjR2qSM7DqApbXH0r0RAqflxG5uJwvodPhi0wFaGdNiFe4LoFvg
         s2sosUeWAjDeQ+ki6Q5HCEQ7CS3vmQMwx33+J34lR386+mFacmQprd0VmiQ/z+L3+B1G
         dBDg==
X-Gm-Message-State: AOJu0YwbwhriffUps/bNXpocgktVswXNCYdA1x3R/ZBbANqP3Y1B0wl0
        eSpq3Wn3zZ3XDw4pSqNHfk6kdprS7Yg=
X-Google-Smtp-Source: AGHT+IHo/J/ZXmra6ytPk6C/TBIS8l3s5w/3iBvGfxahqKkxN+H5uKHCOz7A4VQOcwnjHgNkTPXccQ==
X-Received: by 2002:a5d:4605:0:b0:317:60a8:f3a7 with SMTP id t5-20020a5d4605000000b0031760a8f3a7mr5973480wrq.10.1691434304377;
        Mon, 07 Aug 2023 11:51:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i1-20020adfe481000000b00317e77106dbsm4592401wrm.48.2023.08.07.11.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:51:43 -0700 (PDT)
Message-ID: <3ef3cf0861ffcb86dc8dbb075a17265d4c23d3fc.1691434300.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Aug 2023 18:51:38 +0000
Subject: [PATCH 4/6] maintenance: use random minute in cron scheduler
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The get_random_minute() method was created to allow maintenance
schedules to be fixed to a random minute of the hour. This randomness is
only intended to spread out the load from a number of clients, but each
client should have an hour between each maintenance cycle.

Add this random minute to the cron integration.

The cron schedule specification starts with a minute indicator, which
was previously inserted as the "0" string but now takes the given minute
as an integer parameter.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/gc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index f059c9f89d5..be47000ed36 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -2181,6 +2181,7 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 	FILE *cron_list, *cron_in;
 	struct strbuf line = STRBUF_INIT;
 	struct tempfile *tmpedit = NULL;
+	int minute = get_random_minute();
 
 	get_schedule_cmd(&cmd, NULL);
 	strvec_split(&crontab_list.args, cmd);
@@ -2235,11 +2236,11 @@ static int crontab_update_schedule(int run_maintenance, int fd)
 			"# replaced in the future by a Git command.\n\n");
 
 		strbuf_addf(&line_format,
-			    "%%s %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
+			    "%%d %%s * * %%s \"%s/git\" --exec-path=\"%s\" for-each-repo --config=maintenance.repo maintenance run --schedule=%%s\n",
 			    exec_path, exec_path);
-		fprintf(cron_in, line_format.buf, "0", "1-23", "*", "hourly");
-		fprintf(cron_in, line_format.buf, "0", "0", "1-6", "daily");
-		fprintf(cron_in, line_format.buf, "0", "0", "0", "weekly");
+		fprintf(cron_in, line_format.buf, minute, "1-23", "*", "hourly");
+		fprintf(cron_in, line_format.buf, minute, "0", "1-6", "daily");
+		fprintf(cron_in, line_format.buf, minute, "0", "0", "weekly");
 		strbuf_release(&line_format);
 
 		fprintf(cron_in, "\n%s\n", END_LINE);
-- 
gitgitgadget

