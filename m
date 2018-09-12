Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC92D1F404
	for <e@80x24.org>; Wed, 12 Sep 2018 14:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeILTvI (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 15:51:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36444 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeILTvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 15:51:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so1134719pfo.3
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/nrA4jKfXf9+rgC6lg/0GXaSOPZnuSWJsIFHlSo2K0=;
        b=V4NBVr35y6N8olOTXRnyIBC+IQZ01EqB+/aV5aadKnqNczBW5iPspQj9tlhA6/U226
         wHb/LrX8P+qDJolY+mdKEoqNp4zqz4e9F+yhC4UDkJFofxmTs0lZqfjK/wX3RkQHaRRB
         uIDjLfgNCPVjjmzWNdNk6jyty/f3mHUb6RpeuPuZZaL+jGT01TYI6Edt2xA8TRPnQjX4
         u7OGynR3fAR34MYyvXB3NovYmvZxKR6p+9zlaiUg7bOCWUpF9MbVsUjaQO1oVJYrp1lm
         W9kjcXfwm7tzEyB6a5uQIrMAs/MZwh0/R/a5OEhYbfWEJmdxIdI71Y2SQRQYh/OZDXG0
         0NyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/nrA4jKfXf9+rgC6lg/0GXaSOPZnuSWJsIFHlSo2K0=;
        b=lIvxOezjnfokoKVYSeZEv+4hVrhvurAb4bElhEMGiAIeOR1MaBn9l2Ar5y3gBrRO8Q
         CS60tV80ePuFJquClW1eN4VUgxTmHsiV9UP/+BIZMVJfKmceZdGcr9sExAiLMcC8Vzyd
         q63sHakPPZIIe6Wm0MKg3azIf383uXT53m1ivNDf0Y3bmm3MQiUsNNbTm28a/u8eqO3X
         UnH9FWom3Hlwnh5GFIY5tqb148Xp2FWzprNJq8K67tiQQ85L3nn9P9mEx/Hjy04Wt/Fk
         zIVnoE5XznP3n7op7wgYje4wO+j7OXp853RTHCJ/gwGdbrguK6ajk/YGyz/kG+27Qu7i
         egIQ==
X-Gm-Message-State: APzg51CWHfLmDv/wEoyIgXSf4XdnsBDMLXIOz//K2Z+a67bUbuf2n9VJ
        xVS/I6gP08fGgvlYmIJLpmoZixU7
X-Google-Smtp-Source: ANB0VdYwFIfJzZcZ1Xufx9ZsWStDniIEa0He+fdOVO06J/OtafNiWOyJf3eryABnpTDzmP5JxePrWQ==
X-Received: by 2002:a63:2506:: with SMTP id l6-v6mr2669798pgl.343.1536763577880;
        Wed, 12 Sep 2018 07:46:17 -0700 (PDT)
Received: from localhost.localdomain ([203.142.78.193])
        by smtp.gmail.com with ESMTPSA id l70-v6sm2319839pge.36.2018.09.12.07.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 07:46:17 -0700 (PDT)
From:   Shulhan <m.shulhan@gmail.com>
To:     git@vger.kernel.org
Cc:     Shulhan <m.shulhan@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 1/1] builtin/remote: quote remote name on error to display empty name
Date:   Wed, 12 Sep 2018 21:45:04 +0700
Message-Id: <20180912144504.7498-2-m.shulhan@gmail.com>
X-Mailer: git-send-email 2.19.0.398.gef7f67bed
In-Reply-To: <20180912144504.7498-1-m.shulhan@gmail.com>
References: <20180912144504.7498-1-m.shulhan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rationale: consistent error format

When adding new remote name with empty string, git will print the
following error message,

  fatal: '' is not a valid remote name\n

But when removing remote name with empty string as input, git did not
print the empty string with quote,

  fatal: No such remote: \n
---
 builtin/remote.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
-- 
2.19.0.398.gef7f67bed

