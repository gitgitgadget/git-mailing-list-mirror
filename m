Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E5C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiEWUPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbiEWUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:50 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C9AE255
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:21 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h205-20020a1c21d6000000b003972dda143eso222269wmh.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YNHaA4YYGDZmoBb7X7Sg3r2d0bTHSrICz7I5REqA2vE=;
        b=IZss0e1OSCri9gYZbKS8LxA9RZrcylx/wzybgTgjynnirt3zBWW4NHpD4+mf5xpPl3
         FUtvqjWn20qRWfNgy8Aw0DDI10d0Xtn0YEEvPcSy8/LNUmX3HtPjXLHGTOHmQG4rNjg8
         7u9k/VNxhP8i1d5kIemNscQ0ah3HfUJfOrdZIDXuttZDd34ADT18qpHyAlfVsD5VZkmP
         gbPPokACYwk0MjtPU4gfaDCnT8S1IyiKkRFq/ZpRu6MxqSqwXXnaWeqZrOBUyRo6ykkQ
         nC0xBh4ta8aq8BgU7oxyFzG2WfJnfXtrAKUWfUVFhMUb/tjY8KExBvtQWpGiB3toHSrM
         J7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YNHaA4YYGDZmoBb7X7Sg3r2d0bTHSrICz7I5REqA2vE=;
        b=7W5ttd6n/k/ffxGQPQ6GzI0rCbQ6EVASqvKfrD1GMfm1MBfUR9U11z83UdMrxWI9fT
         3894EW0CCjMHgYsNb4lGC7O0mZwKT5cMu3sUbrBYQ1xrvUf/ZdGdviRQMNqoSYcEisKj
         y5ZwIM0/RKoBKHFIUB9e73V0Cp/Ezz/1DtXq7x56ayrBHB/Cn3AVxFemMjcWCYhFpIax
         /bmZ0DnDhVs5ikwM5eKIo5hxZeopKkl6QpOlMc1ipv3n2bJwj5s4JNMIjjII/vrdoiA/
         YhhZS6MgWBhRLI6uv/Bzg+G8BoMtUxhc1lC5uHyx3ISs21LJTBvidAq14eeZ/IR29KF8
         Dnog==
X-Gm-Message-State: AOAM53027tF5Jg+JjwP7i3pXWWVFqh1wyK5/em5yKxyVeTlbI7Yy8xFc
        yh7fdC9hHmlDGawPM7SpMjvXgYiBTLM=
X-Google-Smtp-Source: ABdhPJz+kvYhOiU3BjEEE4i/yboZuUvPUT6TEVhrq71u9En+TTfqi5dr9Nf1Xwgd9YpaLQZPlxsrjg==
X-Received: by 2002:a05:600c:1986:b0:394:77a3:bfa9 with SMTP id t6-20020a05600c198600b0039477a3bfa9mr629968wmq.142.1653336800727;
        Mon, 23 May 2022 13:13:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17-20020adfbbd1000000b0020e6470b2a7sm10791806wrg.85.2022.05.23.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:20 -0700 (PDT)
Message-Id: <6f2e935f148e826609153378751c04807858e76c.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:41 +0000
Subject: [PATCH v7 26/30] t/helper/hexdump: add helper to print hexdump of
 stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhostetler@github.com>

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 Makefile                |  1 +
 t/helper/test-hexdump.c | 24 ++++++++++++++++++++++++
 t/helper/test-tool.c    |  1 +
 t/helper/test-tool.h    |  1 +
 4 files changed, 27 insertions(+)
 create mode 100644 t/helper/test-hexdump.c

diff --git a/Makefile b/Makefile
index 5f1623baadd..5afa194aac6 100644
--- a/Makefile
+++ b/Makefile
@@ -729,6 +729,7 @@ TEST_BUILTINS_OBJS += test-getcwd.o
 TEST_BUILTINS_OBJS += test-hash-speed.o
 TEST_BUILTINS_OBJS += test-hash.o
 TEST_BUILTINS_OBJS += test-hashmap.o
+TEST_BUILTINS_OBJS += test-hexdump.o
 TEST_BUILTINS_OBJS += test-index-version.o
 TEST_BUILTINS_OBJS += test-json-writer.o
 TEST_BUILTINS_OBJS += test-lazy-init-name-hash.o
diff --git a/t/helper/test-hexdump.c b/t/helper/test-hexdump.c
new file mode 100644
index 00000000000..f1e0a0fabf3
--- /dev/null
+++ b/t/helper/test-hexdump.c
@@ -0,0 +1,24 @@
+#include "test-tool.h"
+#include "git-compat-util.h"
+
+/*
+ * Read stdin and print a hexdump to stdout.
+ */
+int cmd__hexdump(int argc, const char **argv)
+{
+	char buf[1024];
+	ssize_t i, len;
+
+	for (;;) {
+		len = xread(0, buf, sizeof(buf));
+		if (len < 0)
+			die_errno("failure reading stdin");
+		if (!len)
+			break;
+
+		for (i = 0; i < len; i++)
+			printf("%02x ", (unsigned char)buf[i]);
+	}
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index 0424f7adf5d..88c4b28cdfa 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -38,6 +38,7 @@ static struct test_cmd cmds[] = {
 	{ "getcwd", cmd__getcwd },
 	{ "hashmap", cmd__hashmap },
 	{ "hash-speed", cmd__hash_speed },
+	{ "hexdump", cmd__hexdump },
 	{ "index-version", cmd__index_version },
 	{ "json-writer", cmd__json_writer },
 	{ "lazy-init-name-hash", cmd__lazy_init_name_hash },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index c876e8246fb..511f6251bf5 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -29,6 +29,7 @@ int cmd__genzeros(int argc, const char **argv);
 int cmd__getcwd(int argc, const char **argv);
 int cmd__hashmap(int argc, const char **argv);
 int cmd__hash_speed(int argc, const char **argv);
+int cmd__hexdump(int argc, const char **argv);
 int cmd__index_version(int argc, const char **argv);
 int cmd__json_writer(int argc, const char **argv);
 int cmd__lazy_init_name_hash(int argc, const char **argv);
-- 
gitgitgadget

