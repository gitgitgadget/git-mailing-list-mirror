Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD73F1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 19:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbfAQT3V (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 14:29:21 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44179 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbfAQT3U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 14:29:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so12584909qte.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 11:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2bloWAIgb+U1D00ZsTLZ7WFrwWsUV476JcxVTdLy5A=;
        b=sWthN2I0ymeR5j+5gbaqTmkRmhvWNY1IdBAlh0xOEfO6MjndEIB2/tNshvKPNhnPCb
         M8b7w6vmS2IwqmjS6uanIsyRO9FcZfnlCCNTnacMp95Wr8Ql0X/p/APw1tSTeZZTH06a
         6PqpUzop+WbNJBhmRvMmkdocrw+bX+kRyRWtvwVOVjJPhHAFclEwT4r3TGqCCzRiuZX1
         TKRPiMil40ErupI7hsAKCPRSjs9EM6MubsFNaOs5b6rqvIoGh9RqnXLE6gNCVTbhV/lb
         6FiZwBbr/6wVK4lC4Ny38UW6liDc19lnyBccuBLnh37aGxXHsKdQiaANy2TaZpdOq5J+
         Lyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2bloWAIgb+U1D00ZsTLZ7WFrwWsUV476JcxVTdLy5A=;
        b=Gx3UKDb+7VZzfj8a8EdG5nWH8Vt/R6inXznR4J8G9Jwj9T0Iei4ZgDToOQatFxU1wL
         MuBgDlLsb+WudEcNXGobgTWOzmzKDy5pYrXBupfhVBKsLxRZ8OYVqG/BEmsjXosGrCEC
         drN5iBY7h9rudgPMjrWzCUqHuoMT45woVnNu3hXMI9O9hlESJhwTEyP1btfU5TuvzHvX
         N5uZRhVXKOnWsoTAPBuHfpoTOqrQV4Q9XGx2RleY+Z2/FgZX70Lxwil3xyElspWIfmym
         o5+YA4xYQyfWGTtZKvKGuLfZBTquNFH7gNR7d27NbGakYm4NieF3n0C0HFzi9+zXP22r
         ocnQ==
X-Gm-Message-State: AJcUukdkZvMQGQW+SEAfsn0AMncmam0aRPUft3b1zHf2sRNZjYRuj82O
        /c65F5w3fgCQnrLkaJ8wwlDd/yjf
X-Google-Smtp-Source: ALg8bN4aQC4tQF8xH5x+73cw7M0QHY6wUKCx1DlNSNoy3SNFbFqATcNtduFK7ztMqQhBpsi52bkyIg==
X-Received: by 2002:a0c:981b:: with SMTP id c27mr13093544qvd.184.1547753359130;
        Thu, 17 Jan 2019 11:29:19 -0800 (PST)
Received: from localhost.localdomain ([131.202.255.236])
        by smtp.gmail.com with ESMTPSA id o48sm57663972qtb.87.2019.01.17.11.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 11:29:18 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org
Cc:     Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH] Allow usage of --gpg-sign flag in commit-tree builtin.
Date:   Thu, 17 Jan 2019 15:29:09 -0400
Message-Id: <20190117192909.26064-1-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <y>
References: <y>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---
Hi,

This is my first contribution, so please bear with me. All feedback
is appreciated.

Ran into this issue while writing a signed commit object manually.
Here are the steps I followed to replicate the issue:

mkdir test && cd test
git init
echo 'test' > test.txt
git hash-object -w test.txt
git update-index --add --cacheinfo 100644 <blob hash> test.txt
git write-tree
git commit-tree --gpg-sign -m 'test commit msg' <tree obj hash>

Thanks,
Brandon

 builtin/commit-tree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 9ec36a82b..9a06594f6 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -66,7 +66,9 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (skip_prefix(arg, "-S", &sign_commit))
+		if (skip_prefix(arg, "-S", &sign_commit) ||
+			skip_prefix(arg, "--gpg-sign=", &sign_commit) ||
+			skip_prefix(arg, "--gpg-sign", &sign_commit))
 			continue;
 
 		if (!strcmp(arg, "--no-gpg-sign")) {
-- 
2.20.1

