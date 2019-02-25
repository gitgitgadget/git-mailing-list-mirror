Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8BDE20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbfBYXRf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:17:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46875 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbfBYXRf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:17:35 -0500
Received: by mail-wr1-f66.google.com with SMTP id i16so11795252wrs.13
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2c3LuKuBGcPBBJek4aSzi5CJTTLA/jeGIO5oacLHd4=;
        b=oFXzeFS+ow+n+neqDH7Dj5DdUG29R+wYntbtkzXtgUgvdb1CLpFE816e7Su3T14C6g
         YaqmVkKpdykuiGzhvh+eyBsqwssNCUd0whwrrUqGujgb7V+ZcXZjAjVI/2hXbg4L4437
         b+ANVYIRbmP5yTPbJryaNk5mUfbtgQ3E/gKZ+nYXHp9MRPjAFVDV9tOB97G+lhu/HPpH
         7ztkw5QDLvUerFvDN4wsttjf6uqNxMa4hp0EPTeOY1jX9BfVcAxIExV7flEoNoWI5box
         dwIg9uaoSQmIMs/Bv42MGBIz1WEZA5SygjRJb04U0ZfBIZ072K3p9/Q8hEWaDtYADA+4
         peeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2c3LuKuBGcPBBJek4aSzi5CJTTLA/jeGIO5oacLHd4=;
        b=O+kGHZM5dn7swSlfO9Vb7d5Mrr3EvamQieWyyDLKRicOyGWhBGcrtVO796k1ZlZdAk
         nYGfs+CCA8BTjaSVS06l9uLZKtk6uP/I9J4G0OMkRbDYfQEnunyy6L90T2J5AGt14LLm
         T7zKsRb5VLAYH3/tBb6PY29Juo9DC6gfo60hfu/GPG0vOA+mj10cJ19k7aQJSXKvuyyt
         tR+0Ij1VdzVA1TCKLn7C8163zs2Io5g/dtF5vwHgwGXs+nZm+g2l6X/JGHAzY4vWOWvH
         d6yIFKyPNbLYD801SDp0bVDxmVDdUwd+FzrP+UACLvDtpnprxspHZpdbW7tNeFOfwHrZ
         MHFw==
X-Gm-Message-State: AHQUAuarq7nRhpUYfic6Jy7UESEyMzZRf2HoObV8yfBLinuD9hOvG9FY
        FVSRS+GUfTtl849LcRat62xXeQu4
X-Google-Smtp-Source: AHgI3IbEh6GlQaOhoFExGu1d2ihgRnZRSHvSVQx2Dl0/b7cnx7kzYxSdL6k5l9kCj4tQhgf4kwWsZw==
X-Received: by 2002:adf:e50e:: with SMTP id j14mr14048502wrm.262.1551136652893;
        Mon, 25 Feb 2019 15:17:32 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id 12sm20979530wme.25.2019.02.25.15.17.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:17:31 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 27/27] tests: add a special setup where stash.useBuiltin is off
Date:   Mon, 25 Feb 2019 23:16:31 +0000
Message-Id: <20190225231631.30507-28-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Add a GIT_TEST_STASH_USE_BUILTIN=false test mode which is equivalent
to running with stash.useBuiltin=false. This is needed to spot that
we're not introducing any regressions in the legacy stash version
while we're carrying both it and the new built-in version.

This imitates the equivalent treatment for the built-in rebase in
62c23938fae5 (tests: add a special setup where rebase.useBuiltin is off,
2018-11-14).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/stash.c | 5 ++++-
 t/README        | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 49c6d7948a..1bfa24030c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1515,7 +1515,10 @@ static int use_builtin_stash(void)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf out = STRBUF_INIT;
-	int ret;
+	int ret, env = git_env_bool("GIT_TEST_STASH_USE_BUILTIN", -1);
+
+	if (env != -1)
+		return env;
 
 	argv_array_pushl(&cp.args,
 			 "config", "--bool", "stash.usebuiltin", NULL);
diff --git a/t/README b/t/README
index 28711cc508..9187eeea8e 100644
--- a/t/README
+++ b/t/README
@@ -349,6 +349,10 @@ GIT_TEST_REBASE_USE_BUILTIN=<boolean>, when false, disables the
 builtin version of git-rebase. See 'rebase.useBuiltin' in
 git-config(1).
 
+GIT_TEST_STASH_USE_BUILTIN=<boolean>, when false, disables the
+built-in version of git-stash. See 'stash.useBuiltin' in
+git-config(1).
+
 GIT_TEST_INDEX_THREADS=<n> enables exercising the multi-threaded loading
 of the index for the whole test suite by bypassing the default number of
 cache entries and thread minimums. Setting this to 1 will make the
-- 
2.21.0.rc2.291.g17236886c5

