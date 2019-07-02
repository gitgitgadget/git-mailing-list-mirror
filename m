Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303111F461
	for <e@80x24.org>; Tue,  2 Jul 2019 09:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfGBJO0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 05:14:26 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46639 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfGBJO0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 05:14:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id i8so4171442pgm.13
        for <git@vger.kernel.org>; Tue, 02 Jul 2019 02:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sjxQC9ExWqlfRwxfY1lcZGsCIZu7g+wklshVn6nyRpc=;
        b=mY5qAcPWuwppZRMzVsvcX2awehdZrVRj9nwre4Tb/vqyt3RpyYYhc1Uz0lF/Y/3qhs
         FeNhPw27OpmRwHhHJCbOzI1Wo29lDVjqro8b6qRsKnbRl2DMUpZHd66lTSbHWhhrutZ/
         yzgIOwUjNbHcc4x6CSR5B5VG4UC8Msjr0ZRYz5HhBgRA+toQynU2kJUCrpJpd+5TPOQh
         pW9Sz0coN8cyxYuCRTvB+T2mkZ9wAwiM+aWeWfesu4wMd5XwJiu6Nxh8rDYMHPUWPVPX
         11FcCkA6xbZaeXYRlRgMub7y0Lr6GNMybidHsRdl2sUNT601odxlg33CaES3dds+mTnE
         eg+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sjxQC9ExWqlfRwxfY1lcZGsCIZu7g+wklshVn6nyRpc=;
        b=YRfEC/6HPnRPrL103GYjRtJLXYl96UehTFwTbPEUsorEM1t/xb5icnjDfLpKkvilYI
         I9N6CIgDe8WXF8Yw8FlIKjR+WliJfnQ2swZ3Dh4ND7/h/zQ705a7whh82RjrVIGwRqbB
         uPzT8GRm2s9RoUrVb7IYBKk64JtMDIb44rgitG3E0clTwXn7LsSW+qBEiE7L9ndsSQW5
         ujJV/g9iwdSnTFsCagVcg/y2g6Zx2ZSKVdWn39YD3TSufYKD1rM+9UliuOhOIAotdNKY
         4ZPHg+hfZ5m0BCY8VtI8RJ4z2y+N4Zz8g1Q564Voqo37VmY2e0F+JX7aj+dBVPi6Mtrk
         PBYA==
X-Gm-Message-State: APjAAAV7L84fcUZFuai+R3CV9KlvqPEBsQ18pgtZeFV8mZBc3rhPltwJ
        kmBJg8fdN89aj99oSO3iXiU=
X-Google-Smtp-Source: APXvYqznbI3DpP23R7C/64lHk/NMwkKK3+c6hPlBMpTuhop33FXFKjKjgZOtaRUk9Undo0cYBi08Ww==
X-Received: by 2002:a17:90a:cb15:: with SMTP id z21mr4422365pjt.87.1562058865359;
        Tue, 02 Jul 2019 02:14:25 -0700 (PDT)
Received: from ar135.iitr.local ([103.37.200.218])
        by smtp.gmail.com with ESMTPSA id q198sm20499178pfq.155.2019.07.02.02.14.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 02:14:24 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, t.gummerer@gmail.com,
        phillip.wood123@gmail.com, martin.agren@gmail.com,
        jrnieder@gmail.com
Subject: [GSoC][PATCH v8 3/5] sequencer: use argv_array in reset_merge
Date:   Tue,  2 Jul 2019 14:41:27 +0530
Message-Id: <20190702091129.7531-4-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
References: <20190608191958.4593-1-rohit.ashiwal265@gmail.com>
 <20190702091129.7531-1-rohit.ashiwal265@gmail.com>
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
index cb856bcfc3..70efe36ee8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2734,13 +2734,18 @@ static int rollback_is_safe(void)
 
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

