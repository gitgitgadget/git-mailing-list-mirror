Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9769620899
	for <e@80x24.org>; Sun, 13 Aug 2017 09:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751097AbdHMJsd (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Aug 2017 05:48:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33473 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbdHMJsc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Aug 2017 05:48:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id y41so314119wrd.0
        for <git@vger.kernel.org>; Sun, 13 Aug 2017 02:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NennIra1P875DibbA6a9NnUszKP7K7Gz4PTACa/ydk4=;
        b=DYps+1mfouxwC5ldeLksqVOpGpxe4jjKLNOkZNJiXbPErbWzRc53zMFfDoP9whel2n
         KiXuYBCDJM9KSezmjA8rjVCwz+4V1OZYaQJLsRdzr2hvk+/zqMnRckhkeOYY0P8DJ5yD
         5GKJZJEu8UrltruOijjv6tq0IHlGWYHXOnKKA8YOc2L0D4ENrHkc0ucLZQQzgHjYx35S
         twZ4ob4aG4WkTjNSIrEVKdCXTgvYwdK55tTcC2IYT3Hm0qvI7FxlWRlOIobxyjqlKDrJ
         B35WrWCx+Hu4n9AsUbHK/HtrsTdOtvKA393NSiO6wK2F7H3U8Qm1fxYU/o0obAdCwO8U
         gZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NennIra1P875DibbA6a9NnUszKP7K7Gz4PTACa/ydk4=;
        b=aTG2jvy84LJwXqBOjjFj90ODjlGQxqLlqxh6A+BNgcqAA9rdmD9KgeqTHIxBNV08Ws
         qofx+/o8c6EccPdGmns7b0zMtK1Vtu68iprB5xuOSw/eL8sG4gmlvGngi5tGLUYbFzHM
         /CToSdwTnzVLMewiBNQZlbuWlEEs07sHfsrVZT8QK1KHHYTWjbeOc6RYQ6v+RKJYNcjH
         CRF6aDqXsCwHiHT749CHprhYK8Yv05A+yh42pCAz0kDxwdeDSgI5uPY7bXwD1OcgjG2y
         Hw6nFjoTWGXcvyVDEuwy2rNnRelHhE5w5OBZJt8byvAtzwhRhHi6JPyOYC2jnYk8Z1GB
         P+jA==
X-Gm-Message-State: AHYfb5iTaMkYrd2ceKyIJlFtZhovSnqyKQFdNot64m1a+BTHs/eRcp2I
        WzY2vpqOXtfQP9Pq
X-Received: by 10.223.148.36 with SMTP id 33mr15901817wrq.24.1502617711235;
        Sun, 13 Aug 2017 02:48:31 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:340a:f800:1926:4388:d603:b0d9])
        by smtp.gmail.com with ESMTPSA id v9sm2403673wmg.41.2017.08.13.02.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 13 Aug 2017 02:48:29 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH] doc: clarify "config --bool" behaviour with empty values
Date:   Sun, 13 Aug 2017 11:48:16 +0200
Message-Id: <20170813094816.7754-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.13.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config --bool xxx.yyy` returns `true` for `[xxx]yyy` but
`false` for `[xxx]yyy=` or `[xxx]yyy=""`.  This is tested in
t1300-repo-config.sh since 09bc098c2.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/config.txt | 3 ++-
 Documentation/git.txt    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..d3261006b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -221,7 +221,8 @@ boolean::
 		is taken as true.
 
        false;; Boolean false can be spelled as `no`, `off`,
-		`false`, or `0`.
+		`false`, `0`, no value (but still with `=`) or the
+		empty string.
 +
 When converting value to the canonical form using `--bool` type
 specifier; 'git config' will ensure that the output is "true" or
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7dd5e0328..6e3a6767e 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -75,7 +75,8 @@ example the following invocations are equivalent:
 Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
 `foo.bar` to the boolean true value (just like `[foo]bar` would in a
 config file). Including the equals but with an empty value (like `git -c
-foo.bar= ...`) sets `foo.bar` to the empty string.
+foo.bar= ...`) sets `foo.bar` to the empty string which ` git config
+--bool` will convert to `false`.
 
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
-- 
2.13.3

