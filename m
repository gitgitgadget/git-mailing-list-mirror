Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F1252047F
	for <e@80x24.org>; Sun, 17 Sep 2017 22:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751922AbdIQW2a (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 18:28:30 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35378 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751842AbdIQW2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 18:28:25 -0400
Received: by mail-io0-f193.google.com with SMTP id d16so7440320ioj.2
        for <git@vger.kernel.org>; Sun, 17 Sep 2017 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=02Ech3wNMmYmkY2naBXvq+BTwnFMUlmZIq0vDP1Jilk=;
        b=PA6bxwxQroMd4KgIJ/CwGEK8TEwF03j50ox7u604v9oPY1IPePKuZS7sY1tezvAUO+
         UQPg0u9K451nCtJvq6XQX4OJYfwsMTZ85g9gUGrUQijqTpluSK4s9+G/vHsLphNLvIry
         4yZjA6vfqUdQYVVAaIcUqWl8+MVWoYMbnpu+bVFCisAzzPk5SoC1r/T9JxvYv/j2Zujg
         yaa2ZqymXgnH0tCZwN+gEBkUNCrHq4VvK+veQ96yEubO24+gwons4ZxqsbyWcOvmFak/
         N7ejg8TWB45lLNDr34RLAk0XPb6KCm2IJckYjQuLk0AN3s7imRaUyx1jZy/FTYT/EnHr
         YW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=02Ech3wNMmYmkY2naBXvq+BTwnFMUlmZIq0vDP1Jilk=;
        b=JVymYDLCOuVLCZ6Vn3Y0nKHTPm4kE+NDXSOjPASYsvFmlq+kCod0erTZuq0wDr5PRS
         TyLp8kzCO9hK1/EBG7X6OTNvkFlIYJszcdq5lqv90qSnOP/ZNGylsc29hlkfdp1A7/5M
         Mt/HU33P8DoBRvDkcJJuKRTbVdZjB5a10KKTJR5JrnRXkYNho0A3AUJBlSuW93EMGOEZ
         M1HqzOVMq1y+2kvCfdOeWXvoVidA2zHCJqJkvKvGA5RXvK2QDC5dEsl8JOilLyDYm1Dn
         2UGRhwd0JXSJ9Jg41vDWhfOzjYEuy3MDX1e7CsQXDEJCF63DTsjPvjl1rlI7AOk1vLFl
         y96A==
X-Gm-Message-State: AHPjjUjV7VR36KjwBnv+fzS4HFx9yFdheo/zPRgp+mHf4I3AZj5d3a4u
        8YeOScWVqZBR2JxNTu4=
X-Google-Smtp-Source: AOwi7QD02BdgK2fgT5hZetxUgb738gGA+9VhYw4Budzf8AbADvP+U7rDlVMYqenBpSMRzy3fXZ0JGA==
X-Received: by 10.202.8.148 with SMTP id 142mr16743331oii.199.1505687304097;
        Sun, 17 Sep 2017 15:28:24 -0700 (PDT)
Received: from pixel.attlocal.net (75-59-239-78.lightspeed.sntcca.sbcglobal.net. [75.59.239.78])
        by smtp.gmail.com with ESMTPSA id d74sm6324438oib.30.2017.09.17.15.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2017 15:28:23 -0700 (PDT)
From:   Brandon Casey <drafnel@gmail.com>
To:     git@vger.kernel.org
Cc:     ilya.bobyr@gmail.com, Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 4/4] git-rebase: don't ignore unexpected command line arguments
Date:   Sun, 17 Sep 2017 15:28:17 -0700
Message-Id: <1505687297-31183-4-git-send-email-drafnel@gmail.com>
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
References: <1505687297-31183-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, git-rebase will silently ignore any unexpected command-line
switches and arguments (the command-line produced by git rev-parse).
This allowed the rev-parse bug, fixed in the preceding commits, to go
unnoticed.  Let's make sure that doesn't happen again.  We shouldn't be
ignoring unexpected arguments.  Let's not.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 git-rebase.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index ad8415e..6344e8d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -350,6 +350,9 @@ do
 		shift
 		break
 		;;
+	*)
+		usage
+		;;
 	esac
 	shift
 done
-- 
2.2.0.rc3

