Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FF261F404
	for <e@80x24.org>; Thu, 13 Sep 2018 13:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbeIMS3j (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 14:29:39 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43986 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIMS3j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 14:29:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id f66-v6so2596125plb.10
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrYbopv7wt38R6AhDsC8THciSxEO7rQHOThRiR4VkbE=;
        b=uotfAH+oso/RbG3QruFbIcN3rd4hcbgD+q/79xJAR+VTE+f+gMCqAFo5V1xzeUrT0t
         mCtfE3nY8UBLm9d8fa9HYBzSUzpHOf5/EHE58meeyHPiWj54cXwNuLLRyWyuGCps/w2W
         5qT2xd5BAy6ltACIA9IkAGLWWFa8+taMfyjUr6D2QdBcXtvqo8Ck20r9L50WoIvK3l+j
         3pkzSS6f1HOXvDj7utIr/+tbzgB+YieCFvLrCE8x2NHiFc0ZI7+YDuX2aqHSbgJjorUA
         6Hc1czlY95PMmr0qZH86cF3HXr8K7qXubaBknEZc5NZm/C4m7/srhcIRXtq7/FkMByIx
         SiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrYbopv7wt38R6AhDsC8THciSxEO7rQHOThRiR4VkbE=;
        b=SWnSWUpJBXx23B5NszOK9kYuBqad1RG/cu1RR3R3813aWcyP8dnho4nt0I2yxcFcZg
         JQg0wVKTU38Xob7+VbPA5mPFGTyawCAMCOV/CDY8MEnIhpOo1OlursHlfyWvss2UnKVg
         R44K4LlzoUtcflosbJ6vCbDqQtBtIlAI9nd3aOK/PiBlBZSC0/wxHrKzAaoAbMcL2GhR
         f/fmi2sSjh27leSuXf/6Ax0YfqurQOasR7fbeEomz9W+GyMcKCIf/nHVLjqIExovHuNe
         12NQO+F3REhFgHg7xOO2aXmwML1IA1cnH9ncsa8V0CqJA361H3DBG+S4MoVDt0yVEf3A
         L2zg==
X-Gm-Message-State: APzg51BnHKYvXnwDPvSf2nkRAS25BiM/7I7qiBjaBLS8eW7ZQMgOAwmj
        pbTpJiNmeqKOHiipyzcZTyhN7cK8
X-Google-Smtp-Source: ANB0VdZzNqCUHuvp38x1qs2SQvqWstO36EAmqZ7cS+mX292tYL8j+JiLeDBkm/pvOXijFkmlDM7skQ==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr7122801plb.146.1536844812606;
        Thu, 13 Sep 2018 06:20:12 -0700 (PDT)
Received: from localhost.localdomain ([203.142.78.199])
        by smtp.gmail.com with ESMTPSA id u17-v6sm7705636pfa.176.2018.09.13.06.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 06:20:11 -0700 (PDT)
From:   Shulhan <m.shulhan@gmail.com>
To:     gitster@pobox.com
Cc:     Shulhan <m.shulhan@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2] builtin/remote: quote remote name on error to display empty name
Date:   Thu, 13 Sep 2018 20:18:33 +0700
Message-Id: <20180913131833.32722-1-m.shulhan@gmail.com>
X-Mailer: git-send-email 2.19.0.400.ge8095fc63
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
2.19.0.400.ge8095fc63

