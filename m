Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 180A020899
	for <e@80x24.org>; Mon, 14 Aug 2017 22:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbdHNWNE (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 18:13:04 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33070 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdHNWND (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 18:13:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id y41so2850118wrd.0
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r00xSJ4WNWJFYWDobaxef6sNexnhhcdyLgJG6qIrvZM=;
        b=IDPIVstk5A334WINa7HyavtXNfuNp3lMJDKosShZ6ZaalJ9Kg8A0yrsukasM1V488u
         2Ndbx8gsCrm2nRBvnk5uG1FVwhuA3wNH+LAy5cIWo0EzXwkcCxc4/ezmZEaZnfPN/1Z2
         eoICWeIbPH30SNotKmqAxnc1BZTh8PQq40TaPs8X7FvA/0y/0fF8nO6YyTt32d3xcQ9B
         fnPaVt/pOxM7eAV1/cdvya3ncipnjfZDY5lPyspJdejLkuNx0XM4JDYcI97mGMEkdbH0
         jOZuw0ZxxVqFk1utKVypVzSssjfLCX6GyunMkDaIcVKg2w8+N7IBp2G5FMjrVBuGE+zi
         WpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r00xSJ4WNWJFYWDobaxef6sNexnhhcdyLgJG6qIrvZM=;
        b=b+gf9+XFwlOwtYi4pnfI/HBUlM8RJR+B+dawUa6RpdBKxJDE3ullTh72LdMGvJCugP
         pietnciF+2NS8yHQO6i/U2gH2FNc8R6fdH7OaN07gKK6FAXd3kf/8P63V+hBYoGtenpt
         rkO+/8+WHpZDU/rIDwSiP+RVwJvITFnJwf1/WItrBp2Y2VkFIb+WJn88KAjV9StBgzHE
         4YFjmx+103ozCmCbTWj0W1BBbNyBgOq9VHaph7MKWK0HjkjAOL82LbUENeSNRr/227KD
         odpDm/8ENjVzgQhduHYC4x22kxDAG2oH7E96H8Erl+ZshNOEgWrqLdh0oIrgpUQJVbAb
         nvpA==
X-Gm-Message-State: AHYfb5ik1WVmA5vL8ntdSsMFo8q9Bofi5IBbfeKFb86Zsc3CDMAL/ZUd
        smhmvk+7XEmQ9pCNyQY=
X-Received: by 10.223.150.101 with SMTP id c34mr16074058wra.266.1502748781702;
        Mon, 14 Aug 2017 15:13:01 -0700 (PDT)
Received: from arrakeen.fritz.box ([2001:a61:10aa:9a01:58c4:fe9a:8665:891])
        by smtp.gmail.com with ESMTPSA id y39sm9331303wry.32.2017.08.14.15.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Aug 2017 15:13:01 -0700 (PDT)
From:   Andreas Heiduk <asheiduk@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Andreas Heiduk <asheiduk@gmail.com>
Subject: [PATCH v2] doc: clarify "config --bool" behaviour with empty values
Date:   Tue, 15 Aug 2017 00:12:18 +0200
Message-Id: <20170814221218.18874-1-asheiduk@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <914098af-00a9-fbc8-cdfe-a65918b2951b@gmail.com>
References: <914098af-00a9-fbc8-cdfe-a65918b2951b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config --bool xxx.yyy` returns `true` for `[xxx]yyy` but
`false` for `[xxx]yyy=` or `[xxx]yyy=""`.  This is tested in
t1300-repo-config.sh since 09bc098c2.

Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
---
 Documentation/config.txt | 10 +++++-----
 Documentation/git.txt    |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d5c9c4cab..478b9431e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -216,15 +216,15 @@ boolean::
        synonyms are accepted for 'true' and 'false'; these are all
        case-insensitive.
 
-       true;; Boolean true can be spelled as `yes`, `on`, `true`,
-		or `1`.  Also, a variable defined without `= <value>`
+	true;; Boolean true literals are `yes`, `on`, `true`,
+		and `1`.  Also, a variable defined without `= <value>`
 		is taken as true.
 
-       false;; Boolean false can be spelled as `no`, `off`,
-		`false`, or `0`.
+	false;; Boolean false literals are `no`, `off`, `false`,
+		`0` and the empty string.
 +
 When converting value to the canonical form using `--bool` type
-specifier; 'git config' will ensure that the output is "true" or
+specifier, 'git config' will ensure that the output is "true" or
 "false" (spelled in lowercase).
 
 integer::
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
2.14.1

