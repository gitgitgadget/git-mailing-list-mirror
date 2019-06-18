Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B91A1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 17:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfFRRJV (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 13:09:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35319 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRRJV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 13:09:21 -0400
Received: by mail-pg1-f194.google.com with SMTP id s27so8044386pgl.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fbylS04N0kpHs/7vKPXmotnmDYuGwmyACsWWpHPf3xQ=;
        b=lhI0ZJ4OkzIk/SiPuJWqJUjjN9iEtdigwpqa9yA1+UwCKL13SghJxBXDm4UsehIjNt
         dRHBJerRT1XRFiLiqHza9w58i6ITBJblRhzBXuj1660kmlLT+eXX1+4V3kZpwSOnw2O1
         FZzGeAoAbpv+IZA9gK+dgOcy27Q0Nz51lw+B2Ajlacl77LBcTgN4d5gtHT9LzeM1uYgT
         xXL1uzbsGU4VpHs3Zm3Fp6je2JkE+Z96YP2M6+fpo5dvfnmdPrchM3R/min1yqpo32Ll
         fn8702glGtzvoxMPcUzxzX9H14NN4HYLczaziXAt5wRT+EABD0cEaDTVjO0DqYhVZqHp
         Nyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fbylS04N0kpHs/7vKPXmotnmDYuGwmyACsWWpHPf3xQ=;
        b=O4DqAF/stETjXegvL0xckOcCetC6YMrmwZ+SJeZnYZxPwR1aMNzDlgTek10c3jpP2V
         GwJkE8C3mBRhLkAZ2nroZ2ZnseU3bk3LKazTPok2TDigSezo7OqCj3IG+TkW/72rfj9Y
         R2JpRcX5d+WN/wybSeW8yu9q5p4xVVhV3YzQkeh5OWf0Ry9albss50RSntc941GMv4sn
         noCdkrc51xQWPF/qp6P5otLqr3dP0Ilu6zIe10jSJfwSsvxW8QjqFLngDMLqYpFzv/iN
         ycJgN5nMHK9COFxz13HIQLVWbKtNxQeGExeSoLJeibJmyGfvj9zXg/IfM3ZZESE8FEMX
         RSPg==
X-Gm-Message-State: APjAAAXwOwi0w/0NgPULEiTR5VGxBN0Uhu3p8cuOBnmrngzh7lrciVf0
        Rwq905luju0E9GZjQV86jWI=
X-Google-Smtp-Source: APXvYqwuMLKRwElH8aN5MizrAZ/PJUQszvvTBLNdZjFo+DPnXZViwBxnZkTL46etYFF0Sk8r1310lA==
X-Received: by 2002:a63:6c4a:: with SMTP id h71mr3577920pgc.331.1560877760926;
        Tue, 18 Jun 2019 10:09:20 -0700 (PDT)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id d6sm14251093pgf.55.2019.06.18.10.09.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 10:09:20 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: [GSoC][PATCH v5 3/5] sequencer: use argv_array in reset_merge
Date:   Tue, 18 Jun 2019 22:36:48 +0530
Message-Id: <20190618170650.22721-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190618170650.22721-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid using magic numbers for array size and index under `reset_merge`
function. Use `argv_array` instead. This will make code shorter and
easier to extend.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 sequencer.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 12f2605ded..6762a5f485 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2733,13 +2733,18 @@ static int rollback_is_safe(void)
 
 static int reset_merge(const struct object_id *oid)
 {
-	const char *argv[4];	/* reset --merge <arg> + NULL */
+	int ret;
+	struct argv_array argv = ARGV_ARRAY_INIT;
 
-	argv[0] = "reset";
-	argv[1] = "--merge";
-	argv[2] = oid_to_hex(oid);
-	argv[3] = NULL;
-	return run_command_v_opt(argv, RUN_GIT_CMD);
+	argv_array_pushl(&argv, "reset", "--merge", NULL);
+
+	if (!is_null_oid(oid))
+		argv_array_push(&argv, oid_to_hex(oid));
+
+	ret = run_command_v_opt(argv.argv, RUN_GIT_CMD);
+	argv_array_clear(&argv);
+
+	return ret;
 }
 
 static int rollback_single_pick(struct repository *r)
-- 
2.21.0

