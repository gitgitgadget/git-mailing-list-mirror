Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28B791FF76
	for <e@80x24.org>; Wed, 14 Dec 2016 08:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755066AbcLNIib (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Dec 2016 03:38:31 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34716 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755048AbcLNIi3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Dec 2016 03:38:29 -0500
Received: by mail-pg0-f67.google.com with SMTP id e9so1735405pgc.1
        for <git@vger.kernel.org>; Wed, 14 Dec 2016 00:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B8+MtnNgt81eyfT5mrb9SgeJBKzH0uRwaS5VaG2eLO0=;
        b=y6eSzNf8ZZ+0rWKfuBWWUuYR7P2noOB2xfudtYbUP6ahEkAzooEp2FBnCG8x7OUxt+
         r8xoqb2locbWkYttvTWIh5XS/aZCQGUKB8EZFcab7KFbeKXU5O0Grt2Bxg3SLYGPfsZN
         9dbfYz3v5+cC41tiwU4yCM5ebqVUdcb3kqfFmKDFZLiO+4DKS3VPrH4CzTN4AVAQj2ca
         BGuDI4FFslkTJxZNAkwm8+mMlrQKPIyqEMTZXvp7bp3hLwQO+TRR/sa6lW9QADuJRgAx
         QTpqCX5SYbbAhzWPzzeACAlgLg0755z/XpqDiWDL2T4MO9wXfDBQDjZQILW+5EOI9sFx
         oZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B8+MtnNgt81eyfT5mrb9SgeJBKzH0uRwaS5VaG2eLO0=;
        b=F3OXS1rM+fW5xiR2URh9CTAv7ssX3EbbuJafxaZFgMN7gVJcxfu1xooMxv7YubfGUQ
         qWef5tfp6SZF9uPEQkFAH6AnesvOxCBAUX6mP6YEQe7YMuB82MKaJylofEvLP+c1P/Jk
         FikxDwSTy1R8aPeODxch1uoHZkIu5vx7hdFur3npIkz3rUP5r9CtQY286hQ5/oav8GbW
         DuqgO12Vf9/cTg9GsXMxk9admN7bK/BSsZsMwMXTafLZz5uUrygnGt3alVM9ke5PwkpT
         iN7ML7VpqIsiPHcEA+B+x8c1Y1onU14IvmJGXu5y+MQWSzdi7RT1BUJXVQOWlwlkZ/Sy
         s0tA==
X-Gm-Message-State: AKaTC03B/GOTdAiRjo1WiBb7aMVl1QcBhgqa182QDTOxcM+k7NtfjZ1o4BRrLjLhHoumrg==
X-Received: by 10.84.216.21 with SMTP id m21mr204561236pli.119.1481704709224;
        Wed, 14 Dec 2016 00:38:29 -0800 (PST)
Received: from chrisp-dl.atlnz.lc ([2001:df5:b000:22:50cb:a0f2:6faa:ea3b])
        by smtp.gmail.com with ESMTPSA id g63sm85225192pfd.60.2016.12.14.00.38.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Dec 2016 00:38:28 -0800 (PST)
From:   Chris Packham <judge.packham@gmail.com>
To:     git@vger.kernel.org
Cc:     mah@jump-ing.de, peff@peff.net, jacob.keller@gmail.com,
        gitster@pobox.com, Chris Packham <judge.packham@gmail.com>
Subject: [PATCH 2/3] completion: add --continue option for merge
Date:   Wed, 14 Dec 2016 21:37:56 +1300
Message-Id: <20161214083757.26412-2-judge.packham@gmail.com>
X-Mailer: git-send-email 2.11.0.24.ge6920cf
In-Reply-To: <20161214083757.26412-1-judge.packham@gmail.com>
References: <20161213084859.13426-1-judge.packham@gmail.com>
 <20161214083757.26412-1-judge.packham@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add 'git merge --continue' option when completing.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Changes in v2:
- new
Changes in v3:
- none

 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 21016bf8d..1f97ffae1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1552,7 +1552,7 @@ _git_merge ()
 	case "$cur" in
 	--*)
 		__gitcomp "$__git_merge_options
-			--rerere-autoupdate --no-rerere-autoupdate --abort"
+			--rerere-autoupdate --no-rerere-autoupdate --abort --continue"
 		return
 	esac
 	__gitcomp_nl "$(__git_refs)"
-- 
2.11.0.24.ge6920cf

