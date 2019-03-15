Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34B1B20248
	for <e@80x24.org>; Fri, 15 Mar 2019 15:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfCOPCO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 11:02:14 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:35384 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfCOPCO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 11:02:14 -0400
Received: by mail-pg1-f181.google.com with SMTP id e17so6667037pgd.2
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSjBl/W6ZQ4NHt6cdIPfyb1w2L7UUZwGvk+H+WYz14U=;
        b=QaTEpCck+vYGv77Q45O3nSq6vXrpz7W3ENO7waMzC/Hr7UrUNvxiVi3RRC0M/yR4Pb
         P8YmjzsU/u2k54xW26FY2x5209ihNhsAEbCaTEQlHlthbEeBYbfID8wGjtugQg8jnWb5
         etObQwewiIS74QLzWd3hccGF6YszeFP4BRYNv0dPIAT5d2ZHVhXH/2o/bZK7hcE+AHEi
         P1NCxO4o/x0+IWbn0uysUVFnyW2L01mgT6RvqqOjCO8JMcdxxwklf/r/R5nDAMIOTCfV
         Jun+IO6RPMvHTJcDsgEoY1Y+ULmkb3x+K7INrVjClUyod2NuMHPBg3Cw/XB+1ViX1zuT
         bpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSjBl/W6ZQ4NHt6cdIPfyb1w2L7UUZwGvk+H+WYz14U=;
        b=RSawuOVev65ykVIfx8zT51zR+gWNbrd+geTjBkcFGnyiEY7ReSXq00r5NSI3C/YAzQ
         T030X4/y8J/Hyg7pIuaHgyofb7ukNTZS6VP4KzcKUcbOgCU9p0WxgHbJ3i3lh8N8Ikqi
         Y905dcTXmUAr2jpCWprsFrx3KqJEnVw80CyhOCQhUY+2EecAgi+3IJuUu88hWnJ7zFvl
         gthJqh0SShTDbx/g3cUeTaGFnO41jd3R8rHPlWbmuhObDhs7bj4ln/I1dHJwGm+nxgVc
         f5l25os2HbguIhqHb+LDmgrmZLuQAL28iuMxwdHmCXFZrx97XNhIXTHH99SpMNPLe41c
         CwFg==
X-Gm-Message-State: APjAAAVsJLNMtfISECjhzQNNbG6IRLH5aI9cKrANgnfwb2qR1zAjwWcs
        e6mtg1Oc7eNegZsozag1ffhUbGHHSa4=
X-Google-Smtp-Source: APXvYqz2cBSSD3mCBvX3EcOYre3Iaro1WteUHUbbUnbkxMkwHeRpqGPzicL4aFby2EScMi93Toe5mw==
X-Received: by 2002:a65:6299:: with SMTP id f25mr3894247pgv.376.1552662132671;
        Fri, 15 Mar 2019 08:02:12 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:148c:681c:2e1:391b:7734:229a])
        by smtp.gmail.com with ESMTPSA id v186sm4062333pfv.184.2019.03.15.08.02.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 08:02:11 -0700 (PDT)
From:   jkapil.cs@gmail.com
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com, alban.gruin@gmail.com, avarab@gmail.com,
        Kapil <jkapil.cs@gmail.com>
Subject: [GSoC][RFC/PATCH 1/1] userdiff - support shell script
Date:   Fri, 15 Mar 2019 20:31:42 +0530
Message-Id: <20190315150142.20672-2-jkapil.cs@gmail.com>
X-Mailer: git-send-email 2.21.0.155.ge902e9bcae.dirty
In-Reply-To: <20190315150142.20672-1-jkapil.cs@gmail.com>
References: <20190315150142.20672-1-jkapil.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kapil <jkapil.cs@gmail.com>

Made a minor change of adding regex for identifying functions in shell scripts.
This regex has been tested separately from git.
For testing with git, please let me know.

This is just to get familiar with whole workflow, regex for word_regex parameter will be added in next patch.

---
 t/t4018-diff-funcname.sh | 1 +
 t/t4034-diff-words.sh    | 1 +
 userdiff.c               | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 22f9f88f0a..68092eaeaa 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -44,6 +44,7 @@ diffpatterns="
 	python
 	ruby
 	tex
+	shell
 	custom1
 	custom2
 	custom3
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 912df91226..de21f36d97 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -314,6 +314,7 @@ test_language_driver php
 test_language_driver python
 test_language_driver ruby
 test_language_driver tex
+test_language_driver shell
 
 test_expect_success 'word-diff with diff.sbe' '
 	cat >expect <<-\EOF &&
diff --git a/userdiff.c b/userdiff.c
index 3a78fbf504..1743608da2 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -170,6 +170,11 @@ IPATTERN("css",
 	 "-?[_a-zA-Z][-_a-zA-Z0-9]*" /* identifiers */
 	 "|-?[0-9]+|\\#[0-9a-fA-F]+" /* numbers */
 ),
+
+PATTERNS("shell",
+	"([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*\\([[:space:]]*\\)[[:space:]]*\\{[[:space:]\\(\\)|\\[<>?`/~!:\'\"%^&*+A-Za-z0-9_$=@;#,.-]*\\}",
+	".*"
+),
 { "default", NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
-- 
2.14.2

