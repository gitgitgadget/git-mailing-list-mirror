Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABDC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 13:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGUN2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 09:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGUN2B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 09:28:01 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7757874E3B
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:28:00 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w7so1815013plp.5
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 06:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LONWvmsaRSaPDjHSBi8NOTXxibMQ5Yw/e9PnEl/UgKU=;
        b=i0F3ZVIBh4SMKq9Uy2uhT7/AJyf6mUq8gqRS+uuSvF/ZWb2oQ24cxaJXNGftbguaVM
         +J9kZ43xiw6/OobA7hPLitZxL9nQoNZQnqGo1J7sfepngcCquwLP625/IChIeWOxEWfI
         e9kIai3HaLSBe3XgfEV5IBcPwJauGVVUbvg92G84+OsKiXzJ+GKXdkddpQXiCWZL1Fs3
         H3Gd7C6lYf9pDJumkpA1HkvO+t4QniR1Mer8Z/iGWF8CjJmgcWNa7VvjjcocU6sume93
         eBlHjrRQ6W/A/pALdG2jQH8Wt8N3T83oI7x8iTNo9EJVEauRpWWhF767QKMIB+BEb748
         fCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LONWvmsaRSaPDjHSBi8NOTXxibMQ5Yw/e9PnEl/UgKU=;
        b=mBnoDKSeZ3naHoz7BMOdJwUbT0t+hGnZmlLLh6giw8zL5A59VbbfBJil1NzaZHlos7
         I11jcD8ExwgeE4O7fSPoYRmp//r1nsBulO5Ikmvd6PTCHBq9m7LfgQwesVNG05WOpMSv
         C3pGJffqrzNdBMtFgSjatgL4XeRu041U3YDwK0UuEUdQqUuxG2QYP3sTq9qoUEt32Ty0
         Lia92oOXnWOyeTZppYzxccj48SZXMw7aGdGft1Tgd2AZ9XmbCyAKlUZRgvjJl2A7LFDX
         O8YKCtOInZ8anTeMhYZCb2Qf7KnW81ea3OPulI3WvAFsREbKMzdxUdW/s9rVVp51yOGh
         lwPw==
X-Gm-Message-State: AJIora+gtMyra0WgYmnFCTMbO93LjCgjAkVEZyT4OAJ+BG1WCkVvWhNz
        ap25SLPJayuQYWmx/h1Us2+13h+MTzc=
X-Google-Smtp-Source: AGRyM1s5JPelJuFfXgzWpWQI32EKgkxcpe18NU70HAAU3/6qgEQbvC4jqCoo1vGfIoLfD8u4V68aiQ==
X-Received: by 2002:a17:90a:8541:b0:1f2:1393:77f6 with SMTP id a1-20020a17090a854100b001f2139377f6mr11543658pjw.210.1658410079654;
        Thu, 21 Jul 2022 06:27:59 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm1467326pgt.64.2022.07.21.06.27.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 06:27:59 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, --cc=avarab@gmail.com, git@jeffhostetler.com,
        tenglong.tl@alibaba-inc.com, Teng Long <dyroneteng@gmail.com>
Subject: [PATCH 1/2] api-trace2.txt: print config key-value pair
Date:   Thu, 21 Jul 2022 21:27:47 +0800
Message-Id: <20220721132748.37848-2-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
References: <20220721132748.37848-1-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

It's supported to print "interesting" config key-value paire
to tr2 log by setting "GIT_TRACE2_CONFIG_PARAMS" environment
variable and the "trace2.configparam" config, let's add the
related docs in Documentaion/technical/api-trace2.txt.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 Documentation/technical/api-trace2.txt | 31 ++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index 77a150b30e..dcd0429037 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1207,6 +1207,37 @@ at offset 508.
 This example also shows that thread names are assigned in a racy manner
 as each thread starts and allocates TLS storage.
 
+Print Configs::
+
+	  Dump "interesting" config values to trace2 log.
++
+The environment variable `GIT_TRACE2_CONFIG_PARAMS` and configuration
+`trace2.configparams` can be used to output config values which you care
+about(see linkgit:git-config[1). For example:
++
+----------------
+$ git config color.ui auto
+----------------
++
+Then, mark the config `color.ui` as "interesting" config with
+`GIT_TRACE2_CONFIG_PARAMS`:
++
+----------------
+$ export GIT_TRACE2_PERF_BRIEF=1
+$ export GIT_TRACE2_PERF=~/log.perf
+$ export GIT_TRACE2_CONFIG_PARAMS=color.ui
+$ git version
+...
+$ cat ~/log.perf
+d0 | main                     | version      |     |           |           |              | ...
+d0 | main                     | start        |     |  0.001642 |           |              | /usr/local/bin/git version
+d0 | main                     | cmd_name     |     |           |           |              | version (version)
+d0 | main                     | def_param    |     |           |           |              | color.ui:auto
+d0 | main                     | data         | r0  |  0.002100 |  0.002100 | fsync        | fsync/writeout-only:0
+d0 | main                     | data         | r0  |  0.002126 |  0.002126 | fsync        | fsync/hardware-flush:0
+d0 | main                     | exit         |     |  0.002142 |           |              | code:0
+d0 | main                     | atexit       |     |  0.002161 |           |              | code:0
+----------------
 == Future Work
 
 === Relationship to the Existing Trace Api (api-trace.txt)
-- 
2.37.1.1.g8cbb44ffc4.dirty

