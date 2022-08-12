Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0EAC25B06
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 02:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiHLC5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 22:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236141AbiHLC5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 22:57:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C00A00E8
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 19:56:59 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id c19-20020a17090ae11300b001f2f94ed5c6so6432341pjz.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 19:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=nYfPfKFYTYp3bWUjmpsY2PJxAJIPSi2c9qMn7B6BShg=;
        b=f3DDFMSXx+RRon2s6SRhP9BD71swqUb0wA1CCCAyFOuuIE8uxkoWB/pC6S+NsTSECd
         8DqnLiW546YKiI3br+mPWtMsn9OGbgSGCXXFoDm1LVGfzDyvZ6x5btwpt72Id3Icv11Z
         XQPsa8xQ8pFe1meTgzVF0AlN+0zvR8DKtgQvUc4Ez1kd8Dn9wMeHNdvGdUZzSK6mjA4J
         J288vkmZm1L1x1leUYOxJFmz6jcmTtUaisn+W0gKUjjh9xuw8n+kItFnNfNhiTvPrSCg
         l0pCtXmH3Y/OI428ymYkyhc6e3qjWfxsgRejhKPumS+Eebo+hD3FtTwWlk7+Te1kw65P
         NaLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=nYfPfKFYTYp3bWUjmpsY2PJxAJIPSi2c9qMn7B6BShg=;
        b=vwJ1pGz1tRJJ72GRvoE9B8Shaq6K5ykVteoLEntd49PKPGc9IFpzRabHgdnGnUFFLH
         lmmGxE8IKDvqao6NR8la6ZT4dpKoGqkQO3ogez7jZRiSTH8VNsYQk456Q4BudOCK3xFi
         lhpTaSqRG7EymrkxlepLpNZmzSFrYkHPObYRAJKkovvlpqUxVsfGTcY2sHdwXha//+1S
         CWOdIcdBK7iZGGdOvacc+3S4YYiu1zbrwq8D3th7UVEFOeFzUxqW302sdMqHkGyoj1Qo
         dwQiDlq5VGUWx6Tj5R1HiOtuIZUg8TMsF9vXTCsjcPUsj0m7GVOxfSu5Bvt/24+EbLVA
         ssyQ==
X-Gm-Message-State: ACgBeo0eUFrLtFToneX5eN/5CH/hCY908FF47kN9zZ+0HZMV7xQg+Bsl
        POCaBYjVH94R6dOBSFIcOds=
X-Google-Smtp-Source: AA6agR40wGRi9GIz1np/48WEmurWBxFLvFrhC3/Q+swncrgqZzf3EQ0V9o8//TJf0aLc/Rk6FDdtAA==
X-Received: by 2002:a17:90b:1e0f:b0:1f5:37f5:159c with SMTP id pg15-20020a17090b1e0f00b001f537f5159cmr1965484pjb.189.1660273019174;
        Thu, 11 Aug 2022 19:56:59 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902a50100b0016f0c2ea14csm390631plq.275.2022.08.11.19.56.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Aug 2022 19:56:58 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v2 1/2] api-trace2.txt: print config key-value pair
Date:   Fri, 12 Aug 2022 10:56:45 +0800
Message-Id: <84bd8a71d7a1adcbcc7ef954ff10ea932e430f1b.1660272404.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <cover.1660272404.git.dyroneteng@gmail.com>
References: <cover.1660272404.git.dyroneteng@gmail.com>
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
index 77a150b30e..38d0878d85 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -1207,6 +1207,37 @@ at offset 508.
 This example also shows that thread names are assigned in a racy manner
 as each thread starts and allocates TLS storage.
 
+Config (def param) Events::
+
+	  Dump "interesting" config values to trace2 log.
++
+We can optionally emit configuration events, see
+`trace2.configparams` in linkgit:git-config[1] for how to enable
+it.
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

