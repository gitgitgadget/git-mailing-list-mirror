Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 068BF201C8
	for <e@80x24.org>; Tue, 14 Nov 2017 11:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755145AbdKNLnc (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 06:43:32 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:50821 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752284AbdKNLnV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 06:43:21 -0500
Received: by mail-pg0-f66.google.com with SMTP id u3so13259pgn.7
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 03:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3JHV/COURcLPZT7qbggqdtlb27TXd9aqHgzF3t90tTQ=;
        b=cS+wdotTfg47eG2Har1GkrIVuiwt4AboQFponc52TV9bKgd0y9BWxzGPed9Z2N22YC
         SXmzw1B540i2+7Fuk1sT8AY8L3Gt/sXk4Hmtrq+FcoiwbBV3cKWjuUfih+258kufz3gr
         2uHIi1/Iq+7+05JtZIAM4dKer/IgoDmXSgFNvFFumDtUKTo0EsnCT+gvJNEFEmidTQyP
         tmrpXWAbLS861X3/Href32JSl9EdTzfMd3Dg1wdxPF7pefOMitzQwEe6ItaJRkAxSOj6
         4MlzTcOjqLkjaggXiq6/WB2r4DUp6Rc9guJPHZ2Xv1Mboffzo5tXXEv09rw0BOP+Qoaa
         7u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3JHV/COURcLPZT7qbggqdtlb27TXd9aqHgzF3t90tTQ=;
        b=oxf8WwN27qJtwNaMMhjdwBLzbcps500cxEgkJZm0Uog/N+j5KQG02lO93MdvoVwqqz
         ELCMNr97Uktgydlr1QsN09NmfLkv32uabDR7FMMT2Vt7K+QvQnz8or6MAgpWSFzNelD3
         60OJXTgJY0R4+AGDvmtUtASxGipLhADxA82LQ9vGVhu/21RPghWUt8GzYKcbOlFW+Q9k
         i67nOHLZQ+OgL6141oK7jRBP1Rq7py59Tv9AKicSCp0gA/xHkiFaSGTR4rtpJXkUQZhj
         QfigvvsAFtHYCPnocOkeuOkwLcevuJZ1WbYkp5HP1LWJtDDyqvYsR/4N5X9Mb3Bs0CMc
         fKLQ==
X-Gm-Message-State: AJaThX73x/kQmwDQIFVJMszk5iwXUhE4fVlFwZRWs4PdlOE6N2RF7PHY
        JGNNIV+TphdvEo1TS0L9HuLLV/HCsi7p2A==
X-Google-Smtp-Source: AGs4zMb7Oh3x8Va7ZTsX7qH9cXQjIT/I0GlFgZGyTPHm3H6E0KJ0TlUADEIMqJIYwM38Zf//YVaizw==
X-Received: by 10.84.131.161 with SMTP id d30mr8647764pld.270.1510659801222;
        Tue, 14 Nov 2017 03:43:21 -0800 (PST)
Received: from localhost.localdomain ([157.50.9.118])
        by smtp.gmail.com with ESMTPSA id m25sm38945584pfg.49.2017.11.14.03.43.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 03:43:20 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/2] branch: forbid refs/heads/HEAD
Date:   Tue, 14 Nov 2017 17:12:58 +0530
Message-Id: <20171114114259.8937-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20171013051132.3973-1-gitster@pobox.com>
References: <20171013051132.3973-1-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

strbuf_check_branch_ref() is the central place where many codepaths
see if a proposed name is suitable for the name of a branch.  It was
designed to allow us to get stricter than the check_refname_format()
check used for refnames in general, and we already use it to reject
a branch whose name begins with a '-'.

Use it to also reject "HEAD" as a branch name.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
  Changes in v2:

  * Fixed the issue of .git/HEAD being renamed when trying to do,

      $ git branch -m HEAD head

   This also allows to rename a branch named HEAD that was created by accident.

   cf. <1509209933.2256.4.camel@gmail.com>

  * Added a test to ensure that it is possible to rename a branch named HEAD.

 sha1_name.c             |  8 +++++++-
 t/t1430-bad-ref-name.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9a2d5caf3..657a060cb 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1438,9 +1438,15 @@ int strbuf_check_branch_ref(struct strbuf *sb, const char *name)
 		strbuf_branchname(sb, name, INTERPRET_BRANCH_LOCAL);
 	else
 		strbuf_addstr(sb, name);
-	if (name[0] == '-')
+	if (*name == '-')
 		return -1;
+
 	strbuf_splice(sb, 0, 0, "refs/heads/", 11);
+
+	/* HEAD is not to be used as a branch name */
+	if(!strcmp(sb->buf, "refs/heads/HEAD"))
+		return -1;
+
 	return check_refname_format(sb->buf, 0);
 }
 
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index e88349c8a..421e80a7a 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -331,4 +331,33 @@ test_expect_success 'update-ref --stdin -z fails delete with bad ref name' '
 	grep "fatal: invalid ref format: ~a" err
 '
 
+test_expect_success 'branch rejects HEAD as a branch name' '
+	test_must_fail git branch HEAD HEAD^ &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'checkout -b rejects HEAD as a branch name' '
+	test_must_fail git checkout -B HEAD HEAD^ &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'update-ref can operate on refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git show-ref refs/heads/HEAD &&
+	git update-ref -d refs/heads/HEAD &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'branch -d can remove refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git branch -d HEAD &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
+test_expect_success 'branch -m can rename refs/heads/HEAD' '
+	git update-ref refs/heads/HEAD HEAD^ &&
+	git branch -m HEAD head &&
+	test_must_fail git show-ref refs/heads/HEAD
+'
+
 test_done
-- 
2.15.0.rc2.397.geff0134c7.dirty

