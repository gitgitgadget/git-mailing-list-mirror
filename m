Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54BA20281
	for <e@80x24.org>; Tue, 23 May 2017 19:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764385AbdEWTcF (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 15:32:05 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34826 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761585AbdEWTcE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 15:32:04 -0400
Received: by mail-qk0-f194.google.com with SMTP id k74so24099003qke.2
        for <git@vger.kernel.org>; Tue, 23 May 2017 12:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=vjmYCtNc4p+mHkdnu696HJ/ecDTt9Oqr2403/e2ARno=;
        b=p+sG2fhConA/MkNlUbCvT3QwiBK2JZaYv0t8c0NfaGck+NyyoovufAlaMtwYeagTBL
         mFdfetWbxryNwIJdJCpFSdK/cQQcV4onlZqK/Ty05gFz7Amny3kk7B42mPytYWqTIqJg
         FSgi7BjTTwQhJr5vbdS5rQvY4olmu9tv3G680eLE7NfZ8d9q2nCHG3k6NaJsUBvuB0Ag
         hQaA5QWb963a/aGtM66q9/PhUvTHafHkK+YLURsvJd6SSfG1NZ7HJkcD/1Q33JpuxgKR
         G6SOLVA9fcQEwvznXoKs51Csz9ilzGvaQ303C8c/sVl6tGyR7A6HHfjNQyx9zHPuDHRc
         61kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=vjmYCtNc4p+mHkdnu696HJ/ecDTt9Oqr2403/e2ARno=;
        b=abVQ8czEg4m1eT5AONXQLwgD2Bd8PZpM0uUq9Vjr+H21oLI8MdBevyscvECTPZgc8m
         BQY8/WpFhsHVBUrCA3/g0kjjjJb5eWRFT0a/jG6RhcBeuSk2ZXbdWaLZ6wAmXbrLOz/b
         tUbjZp8t04fSEgDrtDv6CYeMPZYaPh/gIlLxIu98VyNz5P4q2yRKmp7pJiDilgtTHY9U
         nMO+8mNYSAfcNw2FTCa1cFbrUm8acpQMuFhvIksM5dTTgp13iPGPoIbYoeAPisUTohbg
         ft8qe4ti2GasJOzWALg+7hf2yOtXUgE7vxMcLhDgbN/fGUlFi9s4NxbL3/un1pP3wkXX
         VBqw==
X-Gm-Message-State: AODbwcC0QUaqsbWLWct49DJKA0Z0ENtpO5tJj2PBiBuL7uthTXkjFPLv
        w76hlLoQFMWuxA==
X-Received: by 10.55.204.23 with SMTP id r23mr29760164qki.72.1495567923289;
        Tue, 23 May 2017 12:32:03 -0700 (PDT)
Received: from localhost.localdomain (cpe-98-14-117-223.nyc.res.rr.com. [98.14.117.223])
        by smtp.gmail.com with ESMTPSA id f94sm1058506qtb.16.2017.05.23.12.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 12:32:02 -0700 (PDT)
From:   Samuel Lijin <sxlijin@gmail.com>
To:     git@vger.kernel.org
Cc:     Samuel Lijin <sxlijin@gmail.com>
Subject: [PATCH v6 1/6] t7300: clean -d should skip dirs with ignored files
Date:   Tue, 23 May 2017 06:09:32 -0400
Message-Id: <20170523100937.8752-2-sxlijin@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170523100937.8752-1-sxlijin@gmail.com>
References: <20170523100937.8752-1-sxlijin@gmail.com>
In-Reply-To: <20170523091829.1746-1-sxlijin@gmail.com>
References: <20170523091829.1746-1-sxlijin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If git sees a directory which contains only untracked and ignored
files, clean -d should not remove that directory. It was recently
discovered that this is *not* true of git clean -d, and it's possible
that this has never worked correctly; this test and its accompanying
patch series aims to fix that.

Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
---
 t/t7300-clean.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index b89fd2a6a..3a2d709c2 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -653,4 +653,20 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
 	test_path_is_dir foobar
 '
 
+test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
+	echo /foo/bar >.gitignore &&
+	echo ignoreme >>.gitignore &&
+	rm -rf foo &&
+	mkdir -p foo/a/aa/aaa foo/b/bb/bbb &&
+	touch foo/bar foo/baz foo/a/aa/ignoreme foo/b/ignoreme foo/b/bb/1 foo/b/bb/2 &&
+	git clean -df &&
+	test_path_is_dir foo &&
+	test_path_is_file foo/bar &&
+	test_path_is_missing foo/baz &&
+	test_path_is_file foo/a/aa/ignoreme &&
+	test_path_is_missing foo/a/aa/aaa &&
+	test_path_is_file foo/b/ignoreme &&
+	test_path_is_missing foo/b/bb
+'
+
 test_done
-- 
2.13.0

