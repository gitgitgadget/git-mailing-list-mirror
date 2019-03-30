Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 525E520248
	for <e@80x24.org>; Sat, 30 Mar 2019 14:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbfC3O2T (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Mar 2019 10:28:19 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43221 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbfC3O2S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Mar 2019 10:28:18 -0400
Received: by mail-pf1-f193.google.com with SMTP id c8so2381624pfd.10
        for <git@vger.kernel.org>; Sat, 30 Mar 2019 07:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WftxrZJlWWX6IGEh5qYZ7/wRX4GUg2vW7IpByNgMzHI=;
        b=WVRsmkeYqptkQ/xrKYQbMxZMTkc0PMT0PK6I/iXsTE+RhO64k/bf8edNuJlRluEoxw
         BAu93yN/Y0I8oGf/xUveYS3sqRekLIZjYXewyKr+5MHJSc6C0N6JyjiCBLbOSzlHLndv
         muk4q/rkcXabnLHITAvCrkBhuLAsotXM2uUgl3onfCBLhULC0aYWgg9gflH+SOcya+No
         mLATteV8ifmOT959YXex23ef3fF8gAemerLWpQMfGyuF+66eq0X8FtbsrD2KylJIwQzi
         flDFdVfhZF4FUoHtSkaPrsRyhAMn2P5c+S75Ub2917FV+QU9XxXaojuenQ1b+O7GO0e3
         1nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WftxrZJlWWX6IGEh5qYZ7/wRX4GUg2vW7IpByNgMzHI=;
        b=iOaKrrXD9yj3sjteA9RLcNHDJxvVmc/Nz2yNiJ7ud2f5vsYsZuObAs1zMMTHXXA01k
         8IXVVy1grhIoblV0Ilkojufo5fhefNdYrxmgSM5uP09uy3gxxBk3NL5Q/e6GDDptCz87
         FXNOX24GojVg0dklGu6xSbo7mG6VVQUXpR90grbuXRGgkmrgV33WNABg2iNFexN2FqPR
         tP5ABl5+Q/UOIaCuMvPp7oH7YQLY0I1L8Ar5WOgraASnmwGqkkz5cgBrlXQncLXIKDRf
         q0DtVTiQLsRmYi27QVBlyxuBmzZkpbACnKZZ1vUx2XxCcqs6uRHwpAZypdmSVIa/Wggz
         KcLQ==
X-Gm-Message-State: APjAAAU5qAva3jdpgkPuM7iSOdYio9qgCjSvPoQJl8rl9568t/v6yuBy
        Tf2rMj5ZHTLFhwDKTlLaP6T/5aOHttc=
X-Google-Smtp-Source: APXvYqzthWxN2PsdqPRLgfQfi6E8TECk0QjFjMtucf6kx6+9/9FATr5NYU0IWfQTDZTb0YwhrJe9BQ==
X-Received: by 2002:a62:448d:: with SMTP id m13mr54413626pfi.182.1553956097516;
        Sat, 30 Mar 2019 07:28:17 -0700 (PDT)
Received: from localhost.localdomain (cloudream.m3.ntu.edu.tw. [140.112.244.5])
        by smtp.gmail.com with ESMTPSA id v12sm6621737pfe.148.2019.03.30.07.28.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Mar 2019 07:28:17 -0700 (PDT)
From:   Jonathan Chang <ttjtftx@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jonathan Chang <ttjtftx@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [GSoC][PATCH v4 3/5] t0000: use test_line_count instead of wc -l
Date:   Sat, 30 Mar 2019 22:27:56 +0800
Message-Id: <28986ed00090df33791a6d53a5292b1bb296eaf5.1553954776.git.ttjtftx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1553954776.git.ttjtftx@gmail.com>
References: <cover.1553954776.git.ttjtftx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Chang <ttjtftx@gmail.com>
---
 t/t0000-basic.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 47666b013e..3de13daabe 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1136,8 +1136,8 @@ test_expect_success 'git commit-tree omits duplicated parent in a commit' '
 	parent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | sort -u) &&
 	test "z$commit0" = "z$parent" &&
 	git show --pretty=raw $commit2 >actual &&
-	numparent=$(sed -n -e "s/^parent //p" -e "/^author /q" actual | wc -l) &&
-	test $numparent = 1
+	sed -n -e "s/^parent //p" -e "/^author /q" actual >parents &&
+	test_line_count = 1 parents
 '
 
 test_expect_success 'update-index D/F conflict' '
@@ -1146,8 +1146,7 @@ test_expect_success 'update-index D/F conflict' '
 	mv tmp path2 &&
 	git update-index --add --replace path2 path0/file2 &&
 	git ls-files path0 >actual &&
-	numpath0=$(wc -l <actual) &&
-	test $numpath0 = 1
+	test_line_count = 1 actual
 '
 
 test_expect_success 'very long name in the index handled sanely' '
-- 
2.21.0

