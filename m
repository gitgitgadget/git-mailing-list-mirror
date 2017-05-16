Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71524201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751057AbdEPEBH (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:01:07 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34335 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbdEPEBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:01:05 -0400
Received: by mail-qk0-f195.google.com with SMTP id u75so20664537qka.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lKy/9miH2mNBBZ4+SdTQKO+wqZDvjrW+bR62l45jVjA=;
        b=aBS8ZsrKuURFrL4EVzhs8WIu9d9K/pEiHdhPFIe1c3U1giRA+cWnUnpAiLmckbg9Hh
         ENYNqwRUQ/xZN6DGB5fXT4F02XAOrvUxu1DiePOy+ZKBdnD1AkLD1ttdQLMVbQnWByJQ
         u/yfQykGVjJekxBIDyj+7Itx9Tuvy9sHhThmp8+Y8rQaElexyPVZxezRS8ULMdxRMoXm
         2NAAaNUT7ZGlpkF/FQWaWPW5tKUXqCFRXJUxZkTAR+2GLvB7ym2qI/cqHcX5//CMbMta
         iZSkiCRXKd9F2W3+O9xjEb+xIJrC7klGj0T/GP/QMjijLFn5IyGV3xZJ5ni1KRB7udQ4
         jYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lKy/9miH2mNBBZ4+SdTQKO+wqZDvjrW+bR62l45jVjA=;
        b=EN/GxfIiOoHjdlJrY/uEXCMYtYnVYfXU/L47PAwMtyUG4PMcjQ5KNS3DA2JFJoUFd6
         ERKaITpa/7qn1uune6AE2tJmU/CfPf5F3x2+ST3QznF+vl4CPUpSpLS5eVzUdqCVPbEy
         aKCLl6bJaIQ66ueP4S5H39EtrccYKG6hk/a55MYD7wCe5rccLcdjeHxqLjB1XQW8hX3s
         RcqCEB3v4lHmxTJ7IeC0czrYmF9bWi+RKK9DlYUbhQyEuiSch39V4t8kiT7d/u331bmY
         W4gw2/A3wxXVym70T23rdUfC4JC/HLSBXEQTbFxMJDdU9AEKHhyMn5nhn8QN+TyXxuy3
         NLQQ==
X-Gm-Message-State: AODbwcCUWjO6uuLLv2W6cWIGYyjv+ie+cyWVi7EM4YeNlYzIwTvOymBH
        e3DLz8RWrgPgzg==
X-Received: by 10.55.118.199 with SMTP id r190mr8026960qkc.43.1494907264545;
        Mon, 15 May 2017 21:01:04 -0700 (PDT)
Received: from localhost.localdomain ([189.62.40.36])
        by smtp.gmail.com with ESMTPSA id h14sm10068049qta.18.2017.05.15.21.01.01
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:01:03 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v2 4/4] add--interactive: use add-interactive--helper for status_cmd
Date:   Tue, 16 May 2017 01:00:34 -0300
Message-Id: <1494907234-28903-5-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
References: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Call the newly introduced git-add-interactive--helper builtin on
status_cmd() instead of relying on git-add--interactive's Perl
functions to build print the numstat.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 git-add--interactive.perl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 709a5f6..8c192bf 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -632,9 +632,7 @@ EOF
 }
 
 sub status_cmd {
-	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
-			list_modified());
-	print "\n";
+	system(qw(git add--helper --status));
 }
 
 sub say_n_paths {
-- 
2.7.4 (Apple Git-66)

