Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4D11F404
	for <e@80x24.org>; Fri, 14 Sep 2018 15:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeINU0S (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 16:26:18 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34137 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbeINU0S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 16:26:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id f6-v6so4358456plo.1
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 08:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=510tjpL8AMDS+baa+NKNe1DX3+DJzFoM7evkdo1Dmfo=;
        b=g3O3AykjPFGMD08yf5z4y08bVfKhYUqmMz9VGAvdICe7iJdR7Bpadnzw90RUHBg6MG
         AYIC9m2S6/Og2t5jb3/DiP7rKvRXbrFjAozS9nBlXHXpitVEdfROfnU6pMCnUwke3+pa
         RuNAEp2bARyW5W6VoJRvZKNyd3esgjUJieGKtQIfqYomuMmgCmo9qwknalmAE9cUPnCf
         LTADg7wBgE4uGeEyxIf347V9kGZfKeuDwUbujxmoND8Hq+Y5o/3Bc/pFX8paycQhVP+p
         Y6VXimktaNVzTClMqfdMGUMfiS1BPD7tyKVcVpFQk50d1DB7gotN1J8O+m9Fos2Jcw5X
         8vAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=510tjpL8AMDS+baa+NKNe1DX3+DJzFoM7evkdo1Dmfo=;
        b=aoZdJJAgjiBwUfgfg7pRJIvZFOGN1Vo/Ozwa5NCMeyIZjeNtzdCFQqDAYN46TAM9f6
         3Z83lbprEE4E93Ie2OLU1D3LfSU1qersAQOjxLOb/32zAAIR1D4T7axRlQRFbb4jU27v
         JyGzDdR7YU4+Z67LFQ6JMolAJYOJlCXaONmv0xfiBM++Q9SlEe3/BDsKJKKQ1MfM95Hf
         f6ji2Y+BLs9TeLoFW6IxzTzjtZ6qt7/1AEdbLunvEiq4Zsxi9hEkV8qXcj1ge99ihN2A
         vLX+zLeP271O20wLoQsmb4LtmS6qJaSrFmddX/zOt1/xjcSGoGqpXm01oBBFiVg0t4VW
         E2wA==
X-Gm-Message-State: APzg51ChInw7PztBO/K6+9ufxe3+Dv2tzvE4gL5l9fI6vtFvSUCA7Rm5
        9VuqjQ3GbzpGS03YATaCE/ze40sm
X-Google-Smtp-Source: ANB0VdYPDjjC7zT6+OmI+JDE8vjYQ7DhxfMX/E8R28zUacuduuC1oY5HgirtA9rB7JEZYVMIz1YEHQ==
X-Received: by 2002:a17:902:8a92:: with SMTP id p18-v6mr12673424plo.148.1536937880951;
        Fri, 14 Sep 2018 08:11:20 -0700 (PDT)
Received: from localhost.localdomain ([203.142.78.202])
        by smtp.gmail.com with ESMTPSA id z63-v6sm8636727pgd.69.2018.09.14.08.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 08:11:20 -0700 (PDT)
From:   Shulhan <m.shulhan@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Shulhan <m.shulhan@gmail.com>
Subject: [PATCH v3] builtin/remote: quote remote name on error to display empty name
Date:   Fri, 14 Sep 2018 22:10:31 +0700
Message-Id: <20180914151031.9217-1-m.shulhan@gmail.com>
X-Mailer: git-send-email 2.19.0.401.g521b368dc
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding new remote name with empty string, git will print the
following error message,

  fatal: '' is not a valid remote name\n

But when removing remote name with empty string as input, git shows the
empty string without quote,

  fatal: No such remote: \n

To make these error messages consistent, quote the name of the remote
that we tried and failed to find.

Signed-off-by: Shulhan <m.shulhan@gmail.com>
Reviewed-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/remote.c  | 6 +++---
 t/t5505-remote.sh | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 40c6f8a1b..f7edf7f2c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -626,7 +626,7 @@ static int mv(int argc, const char **argv)
 
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1))
-		die(_("No such remote: %s"), rename.old_name);
+		die(_("No such remote: '%s'"), rename.old_name);
 
 	if (!strcmp(rename.old_name, rename.new_name) && oldremote->origin != REMOTE_CONFIG)
 		return migrate_file(oldremote);
@@ -762,7 +762,7 @@ static int rm(int argc, const char **argv)
 
 	remote = remote_get(argv[1]);
 	if (!remote_is_configured(remote, 1))
-		die(_("No such remote: %s"), argv[1]);
+		die(_("No such remote: '%s'"), argv[1]);
 
 	known_remotes.to_delete = remote;
 	for_each_remote(add_known_remote, &known_remotes);
@@ -861,7 +861,7 @@ static int get_remote_ref_states(const char *name,
 
 	states->remote = remote_get(name);
 	if (!states->remote)
-		return error(_("No such remote: %s"), name);
+		return error(_("No such remote: '%s'"), name);
 
 	read_branches();
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 241e6a319..d2a2cdd45 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -145,7 +145,7 @@ test_expect_success 'remove remote protects local branches' '
 test_expect_success 'remove errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-		echo "fatal: No such remote: foo" >expect &&
+		echo "fatal: No such remote: '\''foo'\''" >expect &&
 		test_must_fail git remote rm foo 2>actual &&
 		test_i18ncmp expect actual
 	)
@@ -173,7 +173,7 @@ test_expect_success 'remove remote with a branch without configured merge' '
 test_expect_success 'rename errors out early when deleting non-existent branch' '
 	(
 		cd test &&
-		echo "fatal: No such remote: foo" >expect &&
+		echo "fatal: No such remote: '\''foo'\''" >expect &&
 		test_must_fail git remote rename foo bar 2>actual &&
 		test_i18ncmp expect actual
 	)
-- 
2.19.0.401.g521b368dc

