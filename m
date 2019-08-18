Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC451F461
	for <e@80x24.org>; Sun, 18 Aug 2019 18:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfHRS2R (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Aug 2019 14:28:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40075 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfHRS2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Aug 2019 14:28:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id v19so1098031wmj.5
        for <git@vger.kernel.org>; Sun, 18 Aug 2019 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SNaV1OAXYuPmrUC9mHsktPzFXluKOnASERv2LDjAxUw=;
        b=el8M6P8X/efTurz9J7kEPO71msh6iIeQCgbJyILfxic1NUejFw9qMSZmZW0g+W5aPs
         UoCUNPw3H0jenQGilFQncx90vxI6ASO6n3NVAGL4gDfZ/2CibkN6QZ4zlcvqXUcwlYZ0
         W+7fKZV7cT6tw25S4017wkhAufBmhLWLOQDvfqBEyACOy7FqZGXz/qDp1Ua5iillzLLZ
         u5eQ6+Fbfj6sZeQDkBZzxw84AW1B3skGrdSa/e88iMPYnyodhmR2ggYDKB8ChVcyba5u
         k4AoCLF941ZVdsuP4z4bQKRNgutdG1w+bbKsjXS4aAY6m5FtwnmdnS9ZrQfSvEhxIOjq
         KFNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SNaV1OAXYuPmrUC9mHsktPzFXluKOnASERv2LDjAxUw=;
        b=qt4fBaauq9duwtFi/+FPDX4+ggA/sE3juJBVn0C49fValYFMX4TktjY33wN4WwZHc3
         yVs7iAl5Ahu3qhOE+tOD8HT1PLYVgcUD2CqFxSzlKXotAk2BoLMttuA4B+aFmEalsQEo
         gXoIiMiCJ0BF4TAnHL+hJrXsfhMs01xI3Z3kp9SoUid2N2tmsrnUjANQUjC40W/odnbR
         lrxh8xysBNQh20D1Y7QUnp4A06XnUeGGdN1YNOcd1V+kFpXcMBv04RaHPTsdhYQTE85A
         vowscZdkTiVuLce3qGTMPWdz0W8vxjuRe/xo9HqbFUnoQQUlcQaMNeze8Y5wLsnBk+AV
         R+1g==
X-Gm-Message-State: APjAAAXhUtFBz7Y4YDwpm9H710pZduYoNG1erKarfqwrd+LnITO4lL1O
        ZpmACmDCNvE3XCuXqmHXPBtMs1XX
X-Google-Smtp-Source: APXvYqyeXHdwzvdoChMofsfMwviUBZ23wWC7854A07Hmm+Ow2cxzvtFJcg0UQ+45pLhfzFU3N3aEXg==
X-Received: by 2002:a05:600c:352:: with SMTP id u18mr16723249wmd.141.1566152894630;
        Sun, 18 Aug 2019 11:28:14 -0700 (PDT)
Received: from localhost.localdomain (x4db53457.dyn.telefonica.de. [77.181.52.87])
        by smtp.gmail.com with ESMTPSA id c201sm24112584wmd.33.2019.08.18.11.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Aug 2019 11:28:13 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Thomas Rast <tr@thomasrast.ch>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC PATCH 3/5] t4211-line-log: add tests for parent oids
Date:   Sun, 18 Aug 2019 20:27:59 +0200
Message-Id: <20190818182801.7580-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.349.g73f10e387d
In-Reply-To: <20190818182801.7580-1-szeder.dev@gmail.com>
References: <20190818182801.7580-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

None of the tests in 't4211-line-log.sh' really check which parent
object IDs are shown in the output, either implicitly as part of
"Merge: ..." lines [1] or explicitly via the '%p' or '%P' format
specifiers in a custom pretty format.

Add two tests to 't4211-line-log.sh' to check which parent object IDs
are shown, one without and one with explicitly requested parent
rewriting, IOW without and with the '--parents' option.

The test without '--parents' is marked as failing, because without
that option parent rewriting should not be performed, and thus the
parent object ID should be that of the immediate parent, just like in
case of a pathspec-limited history traversal without parent rewriting.
The current line-level log implementation, however, performs parent
rewriting unconditionally and without a possibility to turn it off,
and, consequently, it shows the object ID of the most recent ancestor
that modified the given line range.

In both of these new tests we only really care about the object IDs of
the listed commits and their parents, but not the diffs of the line
ranges; the diffs have already been thoroughly checked in the previous
tests.

[1] While one of the tests ('-M -L ':f:b.c' parallel-change') does
    list a merge commit, both of its parents happen to modify the
    given line range and are listed as well, so the implications of
    parent rewriting remained hidden and untested.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t4211-line-log.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index 1db7bd0f59..c378a453de 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -132,4 +132,72 @@ test_expect_success '--raw is forbidden' '
 	test_must_fail git log -L1,24:b.c --raw
 '
 
+# Create the following linear history, where each commit does what its
+# subject line promises:
+#
+#   * 66c6410 Modify func2() in file.c
+#   * 50834e5 Modify other-file
+#   * fe5851c Modify func1() in file.c
+#   * 8c7c7dd Add other-file
+#   * d5f4417 Add func1() and func2() in file.c
+test_expect_success 'setup for checking line-log and parent oids' '
+	git checkout --orphan parent-oids &&
+	git reset --hard &&
+
+	cat >file.c <<-\EOF &&
+	int func1()
+	{
+	    return F1;
+	}
+
+	int func2()
+	{
+	    return F2;
+	}
+	EOF
+	git add file.c &&
+	test_tick &&
+	git commit -m "Add func1() and func2() in file.c" &&
+
+	echo 1 >other-file &&
+	git add other-file &&
+	git commit -m "Add other-file" &&
+
+	sed -e "s/F1/F1 + 1/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify func1() in file.c" &&
+
+	echo 2 >other-file &&
+	git commit -a -m "Modify other-file" &&
+
+	sed -e "s/F2/F2 + 2/" file.c >tmp &&
+	mv tmp file.c &&
+	git commit -a -m "Modify func2() in file.c" &&
+
+	head_oid=$(git rev-parse --short HEAD) &&
+	prev_oid=$(git rev-parse --short HEAD^) &&
+	root_oid=$(git rev-parse --short HEAD~4)
+'
+
+# Parent oid should be from immediate parent.
+test_expect_failure 'parent oids without parent rewriting' '
+	cat >expect <<-EOF &&
+	$head_oid $prev_oid Modify func2() in file.c
+	$root_oid  Add func1() and func2() in file.c
+	EOF
+	git log --format="%h %p %s" --no-patch -L:func2:file.c >actual &&
+	test_cmp expect actual
+'
+
+# Parent oid should be from the most recent ancestor touching func2(),
+# i.e. in this case from the root commit.
+test_expect_success 'parent oids with parent rewriting' '
+	cat >expect <<-EOF &&
+	$head_oid $root_oid Modify func2() in file.c
+	$root_oid  Add func1() and func2() in file.c
+	EOF
+	git log --format="%h %p %s" --no-patch -L:func2:file.c --parents >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.23.0.349.g73f10e387d

