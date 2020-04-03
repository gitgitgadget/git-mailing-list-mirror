Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5021EC2BA16
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2522D2076E
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9MyDDYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgDCUsf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51308 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgDCUsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:23 -0400
Received: by mail-wm1-f68.google.com with SMTP id z7so8476844wmk.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fWlB08WZ5q719C4+IIs/X0PHbhJx7zcQnVPwB920Id0=;
        b=H9MyDDYmX92TbLiIY2Y4wWo0J+yHzeJLky4jBYXHxXFqMWMSsVZO3KFpC0mCXTeNHW
         0jSUpsSIghn1Uvj+/KJCKHdTfk93PdOO+ourGm+4vyOG22bWzBTu9BDancBVdbPUcb8c
         77gKmUxbAgEwVIwvV+jFX+sjos8RjrNSVAtArOYeqsBb94bwYW1zQ6ga8U/ARVA14q3T
         +V+mtUdMw6MOL+X1SwXbHkQUDHw0fB6FiGTo+0OI7nIlEUjNZAA9WtpKGhevM8c6KJ2F
         pLj/iIq2mojlTqq5J8bqaC3i0ypAaiTy5NC9Kb5782Q7Kx/rvD3/m0g/970+9FPvvJYG
         G71Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fWlB08WZ5q719C4+IIs/X0PHbhJx7zcQnVPwB920Id0=;
        b=LA28epDoymbmJ7NAzCmkKEODE0a+3JN/I3hoWKN/x62Qik5sFbLJ4ebX5hka2DjoQE
         dNkIdBNvbbnO9w3UuEz5tnh8ff8u/SAe+DfY35QiWHnfV5PPYqEDV5w28E4ATLCKyfoi
         IYWjSRZT4AlmDp/lRBUm1Idx/TbXVS8BH/IfTxljtQixHzAb96pTmQy2q3D9fUYV8Vyq
         SSwmcBV3KyOd/UVweSUwr1OUFtz/jw+x40MR8NarMsD4s5nf6C2idBdNomAXdWBv2m+b
         /KJML77cSE6LhdSKorUGd2xrTd59jURu2jnhomPGNFUy9MQsVku2/a+XoqeiBwUkcamv
         XjBw==
X-Gm-Message-State: AGi0Pub0lH+ZItH5TzHZXSTSgOGycCXWtsRsESrvpWlSLUz/vTROhTQz
        qwIHpOWg61JVE+giOfFK7SOHqBAF
X-Google-Smtp-Source: APiQypKR4bKlZQSY4ng7AXRvVubbvr/2Wzf+MdFwByUNaKS74MCejLuzSUN8uaTv/atxFZAaYK1kBg==
X-Received: by 2002:a1c:2404:: with SMTP id k4mr10096627wmk.87.1585946900720;
        Fri, 03 Apr 2020 13:48:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f25sm12611454wml.11.2020.04.03.13.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:20 -0700 (PDT)
Message-Id: <cd7b320216deaa2dd0a19e3da2bc9625e32a3fb4.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:06 +0000
Subject: [PATCH 07/15] config: add job.pack-files.batchSize option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The previous change allowed a user to specify a --batch-size=<size>
option to 'git run-job pack-files'. However, when we eventually
launch these jobs on a schedule, we want users to be able to change
this value through config options.

The new "job.pack-files.batchSize" option will override the default
dynamic batch-size calculation, but will be overridden by the
--batch-size=<size> argument.

This is the first config option of the type
"job.<job-name>.<option>" but is not the last.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config.txt     | 2 ++
 Documentation/config/job.txt | 6 ++++++
 builtin/run-job.c            | 7 ++++++-
 3 files changed, 14 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/config/job.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2450589a0ed..c4c5fa99e6b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,6 +389,8 @@ include::config/instaweb.txt[]
 
 include::config/interactive.txt[]
 
+include::config/job.txt[]
+
 include::config/log.txt[]
 
 include::config/mailinfo.txt[]
diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
new file mode 100644
index 00000000000..efdb76afad3
--- /dev/null
+++ b/Documentation/config/job.txt
@@ -0,0 +1,6 @@
+job.pack-files.batchSize::
+	This string value `<size>` will be passed to the
+	`git multi-pack-index repack --batch-size=<size>` command as
+	part of `git run-job pack-files`. If not specified, then a
+	dynamic size calculation is run. See linkgit:git-run-job[1]
+	for more details.
diff --git a/builtin/run-job.c b/builtin/run-job.c
index 2ccc3bbae2d..76765535e09 100644
--- a/builtin/run-job.c
+++ b/builtin/run-job.c
@@ -327,6 +327,7 @@ static int multi_pack_index_repack(unsigned long batch_size)
 	int result;
 	struct argv_array cmd = ARGV_ARRAY_INIT;
 	struct strbuf batch_arg = STRBUF_INIT;
+	const char *config_value;
 	int count;
 	off_t default_size = get_auto_pack_size(&count);
 
@@ -336,7 +337,11 @@ static int multi_pack_index_repack(unsigned long batch_size)
 	strbuf_addstr(&batch_arg, "--batch-size=");
 
 	if (batch_size != UNSET_BATCH_SIZE)
-		strbuf_addf(&batch_arg, "\"%"PRIuMAX"\"", (uintmax_t)batch_size);
+		strbuf_addf(&batch_arg, "\"%"PRIuMAX"\"", (uintmax_t) batch_size);
+	else if (!repo_config_get_string_const(the_repository,
+					       "job.pack-file.batchsize",
+					       &config_value))
+		strbuf_addf(&batch_arg, "\"%s\"", config_value);
 	else
 		strbuf_addf(&batch_arg, "%"PRIuMAX,
 			    (uintmax_t)default_size);
-- 
gitgitgadget

