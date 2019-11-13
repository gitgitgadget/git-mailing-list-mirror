Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CF251F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfKMSz4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:56 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38462 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfKMSz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:56 -0500
Received: by mail-lj1-f196.google.com with SMTP id v8so3788777ljh.5
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSD2VDvr82/IoSXeKYKK22kLzHcNEqKtYhNihOJgIKA=;
        b=tSYHQHOPOxdBaONMz7QawOTT3QRJsNi0TsKf2dzlih+rxiZ4IKQ6hMlvWM2U0zmoQs
         gbuBEJ5JKIBKHA5DWiM8faGwdiEnuirMClYx1fZc7G81YEnZ21VvZjBIxqE+h7rV5ZvM
         tHDCNrXjMyXdJR4f5WKSl12Y2hpUUwu9wRawGL1+I6MnwDDoJo/96XPH1s7562jgBcTW
         AnU3ghT6dD1GUQc5LPZxmpgWL3/XtZm/Bc36kOfieT7RCe5Mwkmz722ZbiIv7MS4bD6G
         eNYnYOxbAgdypn/d7UZUflxgxGKMHRY8/NAcMEQtEO/HS/HWno0EiRcujWaJ+sto8qwX
         ImYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSD2VDvr82/IoSXeKYKK22kLzHcNEqKtYhNihOJgIKA=;
        b=ncDn0E574A7L1Z+26+lLr5w7xGmQJqQ+eKx0XjQSN+1rtoXyL0J48veBnbTlaFsuCv
         BQ5SeNU3paZ13fJfLgin6eGWqfsVUr675mO4Y7EubL4uQLAog0hVWY3mxL7XK5pzp5jD
         g0XwRaeeB8rM7t47QTWIAx7oU2mC+wd0S7VubDjAwiYm2Ur8JqTE0ITwGbNy9o17L3+w
         5L2PMKUvPKsmET7aQ9bhMcVrjUMQ78KpfNJLqLlewv6vgtNvCQMuzmxbGgL3B9W0Duc/
         2EkODeFi7qiaMTRzxknhsG5BQ2Lfwk549SUnIplMDSFH3DGzs/iUIKVZp4gO3QnAcsSw
         zz5g==
X-Gm-Message-State: APjAAAXp6BqhumbOZnN1iTPuWSw4NJmXEnd+9Ii4CUULr1Nx2IKXhN1O
        eq2lgJ9SFkhF/in9HSA2Ky4ynkWY
X-Google-Smtp-Source: APXvYqwGiyMy8eMn/sTii/KylpOf62hiAgXfncl5aJmxVdCNifVyYj0cQeQn46s/pEa6BRe4wDHoxA==
X-Received: by 2002:a2e:b4ba:: with SMTP id q26mr3646894ljm.60.1573671353671;
        Wed, 13 Nov 2019 10:55:53 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:52 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/8] builtin/config: warn if "value_regex" doesn't canonicalize as boolean
Date:   Wed, 13 Nov 2019 19:55:06 +0100
Message-Id: <0f48ab4fc344b3cc226d0a45d13530022208ff3e.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With `--type=bool`, we try to canonicalize the "value_regex". If it
doesn't canonicalize, we continue and handle the "value_regex" as an
ordinary regex. This is deliberate -- we do not want to cause existing
scripts to fail.

This does mean that users might be at risk of missing out on config
values depending on which representation they use in their config file:

	$ git config foo.bar on
	$ git config foo.baz true
	$ git config --type=bool --get-regex "foo\.*" tru
	foo.baz true
	$ # oops! missing foo.bar

Let's start warning when the "value_regex" doesn't look like a boolean.
Document our intention of eventually requiring the canonicalization to
pass.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt | 2 ++
 builtin/config.c             | 2 ++
 t/t1300-config.sh            | 3 ++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 864375b1ec..43310ca3c0 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -46,6 +46,8 @@ unset an existing `--type` specifier with `--no-type`.
 With `--type=bool` or `--type=bool-or-int`, if `value_regex` is given
 and canonicalizes to a boolean value, it matches all entries
 that canonicalize to the same boolean value.
+The support for non-canonicalizing values of `value_regex` with
+`--type=bool` is deprecated.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
diff --git a/builtin/config.c b/builtin/config.c
index 4e274d4867..2af62b95f8 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -303,6 +303,8 @@ static int handle_value_regex(const char *regex_)
 			cmd_line_value.boolean = boolval;
 			return 0;
 		}
+		warning(_("value_regex '%s' cannot be canonicalized "
+			  "to a boolean value"), regex_);
 	}
 
 	if (type == TYPE_BOOL_OR_INT) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f0e9a21dc4..3e067c211d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -466,8 +466,9 @@ test_expect_success '--get canonicalizes integer value_regex with --type=bool' '
 
 test_expect_success '--type=bool with "non-bool" value_regex' '
 	echo true >expect &&
-	git config --type=bool --get foo.y4 "t.*" >output &&
+	git config --type=bool --get foo.y4 "t.*" >output 2>err &&
 	test_cmp expect output &&
+	test_i18ngrep "cannot be canonicalized" err &&
 	test_must_fail git config --type=bool --get foo.y4 "T.*" >output &&
 	test_must_be_empty output
 '
-- 
2.24.0

