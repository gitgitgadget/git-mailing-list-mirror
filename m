Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12BD32095B
	for <e@80x24.org>; Tue, 21 Mar 2017 13:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757456AbdCUNBE (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 09:01:04 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35602 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757344AbdCUNBB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 09:01:01 -0400
Received: by mail-wm0-f67.google.com with SMTP id z133so2790852wmb.2
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P5tujkjF0YlP3arExNC0q/sjUQzvrfpENV4VGX+yDGc=;
        b=nixlAFV9zdXBY0wt5dFwsM0wxjC2vaTSut7tD1BbCRz1b3giPsG9iqs4wEb1Ut0MWq
         vCnwDUhQOVQqofz40K2Tegx0GuVUQzC8tMEFpOqySH8+MHHF0oNs00wVSon8Of6j8p4F
         fTddzlRdxXWbJQ9drUf+0QNZF4o9sLZvrl2OBToeXs44WN7DpKUZ7ghDv2QJ048G/u9C
         85KWuqd/HvjG69uKcjqTzTytwGc/D29nJbJpauDLEHLzwUW7EMyENhbdK97VVSDy86/v
         hEWZHc+BwVGGmBXo02d9WwThOcciliNw3lwuZqWpXlLwyEgdUTUy8BPo7x8TInXkHA3p
         oAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P5tujkjF0YlP3arExNC0q/sjUQzvrfpENV4VGX+yDGc=;
        b=Dtg0iN+b3kuuk72LFXt6+xuZnDXbNdFbH3fghHql90j/Tdn+dSoz1tYxYylU9BHJGs
         lsVSRHEqHLBLicc+WV226BplTtw3ZnmWm3xcxl7uINYsUAiM5XWNWDAtI6nL8OGwLGDY
         YmAbiLkv28Kb6S7reRrn8Ad9AWBQ1Rhd3PQZQ5DeoL7Kx/D8aA5DWN1YYx6lGVfaM6J/
         XipAllQcjdkuapSHBP/3OiLHnF4xIsnLfRMy+uNVmTSoEgAsDcvsdhZT3r1Xo76bRacj
         Y/+wbyJwCfQczjpSNNNenfIzVxfamRPpLJRDenyYED5mRuucKsMWR53DIxJzmxbuBVCl
         0FIQ==
X-Gm-Message-State: AFeK/H03yk6BNx7z2WQWtwRmp5LnYX9PibTF8n7e+++D+LRc9GUKt+YtLLguBM3S71WLkg==
X-Received: by 10.28.1.68 with SMTP id 65mr2739381wmb.63.1490101258515;
        Tue, 21 Mar 2017 06:00:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 63sm17555072wmg.22.2017.03.21.06.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 Mar 2017 06:00:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 15/16] tag: implicitly supply --list given the -n option
Date:   Tue, 21 Mar 2017 12:59:00 +0000
Message-Id: <20170321125901.10652-16-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170321125901.10652-1-avarab@gmail.com>
References: <20170321125901.10652-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "tag" command to treat the "-n" invocation as a list-like
option in addition to --contains, --points-at etc.

Most of the work for this was done in my earlier "tag: Implicitly
supply --list given another list-like option" commit, but I've split
off this patch since it's more contentious. Now these will be
synonymous:

    git tag -n 100
    git tag -n --list 100

Whereas before the former would die. This doesn't technically
introduce any more ambiguity than the aforementioned change applied to
th other list-like options, but it does introduce the possibility for
more confusion, since instead of the latter of these dying:

    git tag -n100
    git tag -n 100

It now works entirely differently, i.e. invokes list mode with a
filter for "100" as a pattern. I.e. it's synonymous with:

    git tag -n --list 100

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt |  9 +++++----
 builtin/tag.c             |  3 ++-
 t/t7004-tag.sh            | 17 ++++++++++++++++-
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c249072001..6694b7d33f 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -83,10 +83,11 @@ OPTIONS
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
-	are printed when using -l.
-	The default is not to print any annotation lines.
-	If no number is given to `-n`, only the first line is printed.
-	If the tag is not annotated, the commit message is displayed instead.
+	are printed when using -l. Implies `--list`.
++
+The default is not to print any annotation lines.
+If no number is given to `-n`, only the first line is printed.
+If the tag is not annotated, the commit message is displayed instead.
 
 -l::
 --list::
diff --git a/builtin/tag.c b/builtin/tag.c
index 67d63b2095..dbc6f5b74b 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -461,7 +461,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		if (argc == 0)
 			cmdmode = 'l';
 		else if (filter.with_commit || filter.no_commit ||
-			 filter.points_at.nr || filter.merge_commit)
+			 filter.points_at.nr || filter.merge_commit ||
+			 filter.lines != -1)
 			cmdmode = 'l';
 	}
 
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 7984d1b495..60b5cd8751 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -639,6 +639,11 @@ test_expect_success \
 	git tag -n0 -l tag-one-line >actual &&
 	test_cmp expect actual &&
 
+	git tag -n0 | grep "^tag-one-line" >actual &&
+	test_cmp expect actual &&
+	git tag -n0 tag-one-line >actual &&
+	test_cmp expect actual &&
+
 	echo "tag-one-line    A msg" >expect &&
 	git tag -n1 -l | grep "^tag-one-line" >actual &&
 	test_cmp expect actual &&
@@ -652,6 +657,17 @@ test_expect_success \
 	test_cmp expect actual
 '
 
+test_expect_success 'The -n 100 invocation means -n --list 100, not -n100' '
+	>expect &&
+	git tag -n 100 >actual &&
+	test_cmp expect actual &&
+
+	git tag -m "A msg" 100 &&
+	echo "100             A msg" >expect &&
+	git tag -n 100 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success \
 	'listing the zero-lines message of a non-signed tag should succeed' '
 	git tag -m "" tag-zero-lines &&
@@ -1569,7 +1585,6 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -a -s -m -F &&
 	test_must_fail git tag -a -s -m -F -l &&
 	test_must_fail git tag -l -v &&
-	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -n 100 -v &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
-- 
2.11.0

