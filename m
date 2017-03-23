Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4763520958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932751AbdCWNG5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:57 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33469 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdCWNGz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so16476442wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YrfowDJp4CsoZyT48BjoCCw5KcA04zdVKISqfDoXGTE=;
        b=f4JgFNeMrvjLnb4UHFD3iQddBUOgZPjG0XwjtqP7c+Ix6iwTQYWIJJRVxXh4ggBXb1
         DShDcpNUIUlVSYjN1q7fvi/t8WO6u542zoS5jlxxJ7qjLqNCVCQXYvqiaGtlJnusA+I4
         RYEN840s+lwobvvu3obCxJwi60Ss8M33GRBkkvwXp6PEdnoyOjmRq01ZJ2G1Fc6iKRsS
         uBlBPU+TfqJdA/kcFgWRWqEICeZ3I6s4XRtaA4nncfyGIe0QGkXE0o6hMDOeBsc9qH7f
         +deRpNQbgSgTTyq5aqamI65JoPTKi3XvitSG+mOsFaX2s/2P4uTJSbd+7QN0sd50eZA5
         5XoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YrfowDJp4CsoZyT48BjoCCw5KcA04zdVKISqfDoXGTE=;
        b=ua0K812V2Z/+tzzEYGTWdUhSug6sRMdeIIgXJ8GbBuD+yC0VS8sBSaMxyNBaZM7tYc
         PS+J/2FDCPFFdE9LWLF+QgDTHwES68KGVQ4/v6EZrI1RIgFNK7r7OPG+sALzyE6n1y7F
         Nh5ZMhi933F/ZQEtrSq30H/cBCZEcmowP6oGL7kaARvCd3VWVravmeeUaOoh7nTNxmYu
         qS7u0O9lGj05VyMQY3+WqYigRAHMrEviAxFbV7ipPas64g7JgVK8qlP2E3+cxD1Ct38e
         Zt4YoDUESmrqbtAilFk2yomX5rFRjj1zKe35tX+3TTh4nIKy65/YjpiLw8ZhSnwcSfGf
         yUrw==
X-Gm-Message-State: AFeK/H3KPOMTLLcY9vL2IwcRLdc1VZ1FyflqKgsucjAVkHRWgu7OCUCzdZ8K3s9VxEtHow==
X-Received: by 10.28.126.17 with SMTP id z17mr12768765wmc.33.1490274408776;
        Thu, 23 Mar 2017 06:06:48 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:47 -0700 (PDT)
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
Subject: [PATCH v3 11/16] tag: change misleading --list <pattern> documentation
Date:   Thu, 23 Mar 2017 13:05:24 +0000
Message-Id: <20170323130529.11361-12-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the documentation for --list so that it's described as a
toggle, not as an option that takes a <pattern> as an argument.

Junio initially documented this in b867c7c23a ("git-tag: -l to list
tags (usability).", 2006-02-17), but later Jeff King changed "tag" to
accept multiple patterns in 588d0e834b ("tag: accept multiple patterns
for --list", 2011-06-20).

However, documenting this as "-l <pattern>" was never correct, as
these both worked before Jeff's change:

    git tag -l 'v*'
    git tag 'v*' -l

One would expect an option that was documented like that to only
accept:

    git tag --list
    git tag --list 'v*rc*'

And after Jeff's change, one that took multiple patterns:

    git tag --list 'v*rc*' --list '*2.8*'

But since it's actually a toggle all of these work as well, and
produce identical output to the last example above:

    git tag --list 'v*rc*' '*2.8*'
    git tag --list 'v*rc*' '*2.8*' --list --list --list
    git tag --list 'v*rc*' '*2.8*' --list -l --list -l --list

Now the documentation is more in tune with how the "branch" command
describes its --list option since commit cddd127b9a ("branch:
introduce --list option", 2011-08-28).

Change the test suite to assert that these invocations work for the
cases that weren't already being tested for.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 16 +++++++++-------
 t/t7004-tag.sh            | 25 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 448fdf3743..2640c6955c 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -87,13 +87,15 @@ OPTIONS
 	If no number is given to `-n`, only the first line is printed.
 	If the tag is not annotated, the commit message is displayed instead.
 
--l <pattern>::
---list <pattern>::
-	List tags with names that match the given pattern (or all if no
-	pattern is given).  Running "git tag" without arguments also
-	lists all tags. The pattern is a shell wildcard (i.e., matched
-	using fnmatch(3)).  Multiple patterns may be given; if any of
-	them matches, the tag is shown.
+-l::
+--list::
+	Activate the list mode. `git tag <tagname>` would try to
+	create a tag, use `git tag --list <pattern>...` to list
+	matching branches, (or all if no pattern is given).
++
+Running "git tag" without arguments also lists all tags. The pattern
+is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
+patterns may be given; if any of them matches, the tag is shown.
 
 --sort=<key>::
 	Sort based on the key given.  Prefix `-` to sort in
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 92af8bb7e6..75681b2cad 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -118,6 +118,18 @@ test_expect_success 'listing all tags if one exists should succeed' '
 	git tag
 '
 
+cat >expect <<EOF
+mytag
+EOF
+test_expect_success 'Multiple -l or --list options are equivalent to one -l option' '
+	git tag -l -l >actual &&
+	test_cmp expect actual &&
+	git tag --list --list >actual &&
+	test_cmp expect actual &&
+	git tag --list -l --list >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'listing all tags if one exists should output that tag' '
 	test $(git tag -l) = mytag &&
 	test $(git tag) = mytag
@@ -336,6 +348,19 @@ test_expect_success 'tag -l can accept multiple patterns' '
 	test_cmp expect actual
 '
 
+# Between v1.7.7 & v2.13.0 a fair reading of the git-tag documentation
+# could leave you with the impression that "-l <pattern> -l <pattern>"
+# was how we wanted to accept multiple patterns.
+#
+# This test should not imply that this is a sane thing to support. but
+# since the documentation was worded like it was let's at least find
+# out if we're going to break this long-documented form of taking
+# multiple patterns.
+test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documentation previously suggested' '
+	git tag -l "v1*" -l "v0*" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'listing tags in column' '
 	COLUMNS=40 git tag -l --column=row >actual &&
 	cat >expected <<\EOF &&
-- 
2.11.0

