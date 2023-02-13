Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEB4C636D4
	for <git@archiver.kernel.org>; Mon, 13 Feb 2023 18:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjBMSWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 13:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbjBMSWW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 13:22:22 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B2A20689
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:09 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id cd27-20020a056a00421b00b005a87bcb8a5cso4199979pfb.12
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 10:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1676312529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcUa+ydeHBptl3Zvwcwox1kNmUkeDe015LzvshtpHLk=;
        b=tPpQ0a/Y/VhZGYQ5oSYPcICjRfX0MGHbX3n9HxWDIVemgTVc3dl0XQUDFK9eXNAz/T
         Lp8xfBCQYk7XQmU6c9uyXLndBEFmiYffMh//vR7+RqcIst6Ec7FGJgByHOM8tdhoQhhp
         NKkC90h3Mft6NLwXxiVJgFg0a0XX0YdNp8dlOtQLPRn+RSk5YPC1LY0cqCDLLatF/5SY
         rpCguQoc/N8n0jirOHbuV9/kESwP6LmjKgs0X0J7OLKUJTAwHHvOxTnJstUk3VbKINot
         6f/En1zProVjDAM+wVXyR7BdKsc13/jOETxbR7knGe81PZRgLKlW9kBlZ2ioclHUF4/r
         n+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676312529;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcUa+ydeHBptl3Zvwcwox1kNmUkeDe015LzvshtpHLk=;
        b=4/dtzx70PVDch9s4ubHlT312bXlnvMKZIqCZ7h0i9nHl7yuKjwz9m7MNIB0uigzn63
         NspfrkwLctPbiLArblFReFqGDRsmSlQrmEMaYU/LSP+WXdt2kaKi34M8PF9x5E41MJRD
         nUFvojpCrtmV4op5oaM8E2E5WX04tifzKgzlN2OOw8rBTxBXlBiHzKCAPtdaNsFeAe2B
         D6FVbfgWh2NftrprwsOJxOs9ecmy0lHnsMdgaWDmxjX3YXB5igHq3opr6ZWMC5smGYlq
         277QZ3O9lNskllymqD39o9SIU+/hwF8QoUn16CbGQfmTKRNp4Ld6x3I1HHfEjERyhhW7
         moYA==
X-Gm-Message-State: AO0yUKVuRInSOzufdGgJRHIpHXh9z6PUngjccvx+u4zqynfbB0t0ar6T
        FsBkXd0QHhm2MwnMc8xWcfmFt/HUzjdKWBnoFv8SWD1prHaJdGQlfWQMJlXGQQpDgGghKfPxeqY
        qa1lWQFJQPSJRXksUO5EsY5Od35WUTEeZSZLLvxcuegjfMmYhDe+SnzKi6y1mFn4yFQ==
X-Google-Smtp-Source: AK7set+Cm9n5NWrGR8aRvYzFmHCYlBY3gku+6Z1C55M5GymE6sRHX/P0e9mhLJS16gyBjz4i8B4K/ZNsTPZ28qU=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:7289:b0:199:1852:d21 with SMTP
 id d9-20020a170902728900b0019918520d21mr6290059pll.0.1676312528931; Mon, 13
 Feb 2023 10:22:08 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:21:32 +0000
In-Reply-To: <20230213182134.2173280-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213182134.2173280-5-calvinwan@google.com>
Subject: [RFC PATCH 4/6] tests: use `git submodule add` and fix expected diffs
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Josh Steadmon <steadmon@google.com>

This commit continues the previous work of updating the test suite to
use `git submodule add` to create submodules instead of using `git add`
to include embedded repositories. Specifically, in this commit we update
test cases where expected diffs must change due to the presence of a
.gitmodules file.

Signed-off-by: Josh Steadmon <steadmon@google.com>
Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 t/t3040-subprojects-basic.sh                 |   3 +-
 t/t4041-diff-submodule-option.sh             | 153 ++++++++++++++++++-
 t/t4060-diff-submodule-option-diff-format.sh | 125 +++++++++++++--
 t/t7506-status-submodule.sh                  |  15 +-
 4 files changed, 278 insertions(+), 18 deletions(-)

diff --git a/t/t3040-subprojects-basic.sh b/t/t3040-subprojects-basic.sh
index 61da7e3b94..a0f14db3d2 100755
--- a/t/t3040-subprojects-basic.sh
+++ b/t/t3040-subprojects-basic.sh
@@ -19,11 +19,12 @@ test_expect_success 'setup: create subprojects' '
 	( cd sub2 && git init && : >Makefile && git add * &&
 	git commit -q -m "subproject 2" ) &&
 	git update-index --add sub1 &&
-	git add sub2 &&
+	git submodule add ./sub2 &&
 	git commit -q -m "subprojects added" &&
 	GIT_PRINT_SHA1_ELLIPSIS="yes" git diff-tree --abbrev=5 HEAD^ HEAD |cut -d" " -f-3,5- >current &&
 	git branch save HEAD &&
 	cat >expected <<-\EOF &&
+	:000000 100644 00000... A	.gitmodules
 	:000000 160000 00000... A	sub1
 	:000000 160000 00000... A	sub2
 	EOF
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 556682b18b..6c666d2b7a 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -50,9 +50,19 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'added submodule' '
-	git add sm1 &&
+	git submodule add ./sm1 &&
+	gitmodules_hash1=$(git rev-parse --short $(git hash-object .gitmodules)) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 0000000...$head1 (new submodule)
 	EOF
 	test_cmp expected actual
@@ -63,6 +73,15 @@ test_expect_success 'added submodule, set diff.submodule' '
 	git add sm1 &&
 	git diff --cached >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 0000000...$head1 (new submodule)
 	EOF
 	git config --unset diff.submodule &&
@@ -74,6 +93,15 @@ test_expect_success '--submodule=short overrides diff.submodule' '
 	git add sm1 &&
 	git diff --submodule=short --cached >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	diff --git a/sm1 b/sm1
 	new file mode 160000
 	index 0000000..$head1
@@ -89,6 +117,15 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 	test_config diff.submodule log &&
 	git diff-index -p HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	diff --git a/sm1 b/sm1
 	new file mode 160000
 	index 0000000..$head1
@@ -105,6 +142,15 @@ test_expect_success 'modified submodule(forward)' '
 	head2=$(add_file sm1 foo3) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head1..$head2:
 	  > Add foo3 ($added foo3)
 	EOF
@@ -154,6 +200,15 @@ test_expect_success 'modified submodule(backward)' '
 	) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head2..$head3 (rewind):
 	  < Add foo3 ($added foo3)
 	  < Add foo2 ($added foo2)
@@ -165,6 +220,15 @@ test_expect_success 'modified submodule(backward and forward)' '
 	head4=$(add_file sm1 foo4 foo5) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head2...$head4:
 	  > Add foo5 ($added foo5)
 	  > Add foo4 ($added foo4)
@@ -187,6 +251,15 @@ test_expect_success 'setup - change sm1 to a blob' '
 test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	git diff --submodule=log --cached >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head4...0000000 (submodule deleted)
 	diff --git a/sm1 b/sm1
 	new file mode 100644
@@ -219,6 +292,15 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	git checkout-index sm1 &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head4...0000000 (submodule deleted)
 	diff --git a/sm1 b/sm1
 	new file mode 100644
@@ -238,6 +320,15 @@ test_expect_success 'nonexistent commit' '
 	fullhead6=$(cd sm1 && git rev-parse --verify HEAD) &&
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..$gitmodules_hash1
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head4...$head6 (commits not present)
 	EOF
 	test_cmp expected actual
@@ -436,12 +527,24 @@ test_expect_success 'deleted submodule' '
 test_expect_success 'create second submodule' '
 	test_create_repo sm2 &&
 	head7=$(add_file sm2 foo8 foo9) &&
-	git add sm2
+	git submodule add ./sm2 &&
+	gitmodules_hash2=$(git rev-parse --short $(git hash-object .gitmodules))
 '
 
 test_expect_success 'multiple submodules' '
 	git diff-index -p --submodule=log HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	index $gitmodules_hash1..$gitmodules_hash2 100644
+	--- a/.gitmodules
+	+++ b/.gitmodules
+	@@ -1,3 +1,6 @@
+	 [submodule "sm1"]
+	 	path = sm1
+	 	url = ./sm1
+	+[submodule "sm2"]
+	+	path = sm2
+	+	url = ./sm2
 	Submodule sm1 $head6...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head7 (new submodule)
 	EOF
@@ -460,6 +563,17 @@ test_expect_success 'given commit' '
 	commit_file sm2 &&
 	git diff-index -p --submodule=log HEAD^ >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	index $gitmodules_hash1..$gitmodules_hash2 100644
+	--- a/.gitmodules
+	+++ b/.gitmodules
+	@@ -1,3 +1,6 @@
+	 [submodule "sm1"]
+	 	path = sm1
+	 	url = ./sm1
+	+[submodule "sm2"]
+	+	path = sm2
+	+	url = ./sm2
 	Submodule sm1 $head6...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head7 (new submodule)
 	EOF
@@ -469,6 +583,17 @@ test_expect_success 'given commit' '
 test_expect_success 'given commit --submodule' '
 	git diff-index -p --submodule HEAD^ >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	index $gitmodules_hash1..$gitmodules_hash2 100644
+	--- a/.gitmodules
+	+++ b/.gitmodules
+	@@ -1,3 +1,6 @@
+	 [submodule "sm1"]
+	 	path = sm1
+	 	url = ./sm1
+	+[submodule "sm2"]
+	+	path = sm2
+	+	url = ./sm2
 	Submodule sm1 $head6...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head7 (new submodule)
 	EOF
@@ -479,6 +604,17 @@ test_expect_success 'given commit --submodule=short' '
 	fullhead7=$(cd sm2 && git rev-parse --verify HEAD) &&
 	git diff-index -p --submodule=short HEAD^ >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	index $gitmodules_hash1..$gitmodules_hash2 100644
+	--- a/.gitmodules
+	+++ b/.gitmodules
+	@@ -1,3 +1,6 @@
+	 [submodule "sm1"]
+	 	path = sm1
+	 	url = ./sm1
+	+[submodule "sm2"]
+	+	path = sm2
+	+	url = ./sm2
 	diff --git a/sm1 b/sm1
 	deleted file mode 160000
 	index $head6..0000000
@@ -507,6 +643,17 @@ test_expect_success 'setup .git file for sm2' '
 test_expect_success 'diff --submodule with .git file' '
 	git diff --submodule HEAD^ >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	index $gitmodules_hash1..$gitmodules_hash2 100644
+	--- a/.gitmodules
+	+++ b/.gitmodules
+	@@ -1,3 +1,6 @@
+	 [submodule "sm1"]
+	 	path = sm1
+	 	url = ./sm1
+	+[submodule "sm2"]
+	+	path = sm2
+	+	url = ./sm2
 	Submodule sm1 $head6...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head7 (new submodule)
 	EOF
@@ -525,7 +672,7 @@ test_expect_success 'diff --submodule with objects referenced by alternates' '
 	(cd super &&
 		git clone -s ../sub_alt sub &&
 		git init &&
-		git add sub &&
+		git submodule add ./sub &&
 		git commit -m "sub a"
 	) &&
 	(cd sub_alt &&
diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index 3cda8ffd14..6bee3ac628 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -61,9 +61,18 @@ test_expect_success 'setup repository' '
 '
 
 test_expect_success 'added submodule' '
-	git add sm1 &&
+	git submodule add ./sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 0000000...$head1 (new submodule)
 	diff --git a/sm1/foo1 b/sm1/foo1
 	new file mode 100644
@@ -88,6 +97,15 @@ test_expect_success 'added submodule, set diff.submodule' '
 	git add sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 0000000...$head1 (new submodule)
 	diff --git a/sm1/foo1 b/sm1/foo1
 	new file mode 100644
@@ -112,6 +130,15 @@ test_expect_success '--submodule=short overrides diff.submodule' '
 	git add sm1 &&
 	git diff --submodule=short --cached >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	diff --git a/sm1 b/sm1
 	new file mode 160000
 	index 0000000..$head1
@@ -127,6 +154,15 @@ test_expect_success 'diff.submodule does not affect plumbing' '
 	test_config diff.submodule log &&
 	git diff-index -p HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 1234567..89abcde
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	diff --git a/sm1 b/sm1
 	new file mode 160000
 	index 0000000..$head1
@@ -143,6 +179,15 @@ test_expect_success 'modified submodule(forward)' '
 	head2=$(add_file sm1 foo3) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..2334463
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head1..$head2:
 	diff --git a/sm1/foo3 b/sm1/foo3
 	new file mode 100644
@@ -203,6 +248,15 @@ test_expect_success 'modified submodule(backward)' '
 	) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..2334463
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head2..$head3 (rewind):
 	diff --git a/sm1/foo2 b/sm1/foo2
 	deleted file mode 100644
@@ -226,6 +280,15 @@ test_expect_success 'modified submodule(backward and forward)' '
 	head4=$(add_file sm1 foo4 foo5) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..2334463
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head2...$head4:
 	diff --git a/sm1/foo2 b/sm1/foo2
 	deleted file mode 100644
@@ -272,6 +335,15 @@ test_expect_success 'setup - change sm1 to a blob' '
 test_expect_success 'typechanged submodule(submodule->blob), --cached' '
 	git diff --submodule=diff --cached >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..2334463
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head4...0000000 (submodule deleted)
 	diff --git a/sm1/foo1 b/sm1/foo1
 	deleted file mode 100644
@@ -346,6 +418,15 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 	git checkout-index sm1 &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..2334463
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head4...0000000 (submodule deleted)
 	diff --git a/sm1 b/sm1
 	new file mode 100644
@@ -364,6 +445,15 @@ test_expect_success 'nonexistent commit' '
 	head6=$(add_file sm1 foo6 foo7) &&
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	new file mode 100644
+	index 0000000..2334463
+	--- /dev/null
+	+++ b/.gitmodules
+	@@ -0,0 +1,3 @@
+	+[submodule "sm1"]
+	+	path = sm1
+	+	url = ./sm1
 	Submodule sm1 $head4...$head6 (commits not present)
 	EOF
 	diff_cmp expected actual
@@ -655,12 +745,23 @@ test_expect_success 'deleted submodule' '
 test_expect_success 'create second submodule' '
 	test_create_repo sm2 &&
 	head9=$(add_file sm2 foo8 foo9) &&
-	git add sm2
+	git submodule add ./sm2
 '
 
 test_expect_success 'multiple submodules' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
+	diff --git a/.gitmodules b/.gitmodules
+	index 2334463..8809a9f 100644
+	--- a/.gitmodules
+	+++ b/.gitmodules
+	@@ -1,3 +1,6 @@
+	 [submodule "sm1"]
+	 	path = sm1
+	 	url = ./sm1
+	+[submodule "sm2"]
+	+	path = sm2
+	+	url = ./sm2
 	Submodule sm1 $head7...0000000 (submodule deleted)
 	Submodule sm2 0000000...$head9 (new submodule)
 	diff --git a/sm2/foo8 b/sm2/foo8
@@ -717,11 +818,13 @@ test_expect_success 'given commit' '
 	git diff-index -p --submodule=diff HEAD^ >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/.gitmodules b/.gitmodules
-	new file mode 100644
-	index 1234567..89abcde
-	--- /dev/null
+	index 1234567..89abcde 100644
+	--- a/.gitmodules
 	+++ b/.gitmodules
-	@@ -0,0 +1,3 @@
+	@@ -1,3 +1,3 @@
+	-[submodule "sm1"]
+	-	path = sm1
+	-	url = ./sm1
 	+[submodule "sm2"]
 	+path = sm2
 	+url = bogus_url
@@ -753,11 +856,13 @@ test_expect_success 'diff --submodule=diff with .git file' '
 	git diff --submodule=diff HEAD^ >actual &&
 	cat >expected <<-EOF &&
 	diff --git a/.gitmodules b/.gitmodules
-	new file mode 100644
-	index 1234567..89abcde
-	--- /dev/null
+	index 1234567..89abcde 100644
+	--- a/.gitmodules
 	+++ b/.gitmodules
-	@@ -0,0 +1,3 @@
+	@@ -1,3 +1,3 @@
+	-[submodule "sm1"]
+	-	path = sm1
+	-	url = ./sm1
 	+[submodule "sm2"]
 	+path = sm2
 	+url = bogus_url
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index d050091345..9dbd9ff266 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -31,7 +31,8 @@ sanitize_diff () {
 test_expect_success 'setup' '
 	test_create_repo_with_commit sub &&
 	echo output > .gitignore &&
-	git add sub .gitignore &&
+	git submodule add ./sub &&
+	git add .gitignore &&
 	git commit -m "Add submodule sub"
 '
 
@@ -243,7 +244,7 @@ test_expect_success 'status -a clean (empty submodule dir)' '
 '
 
 cat >status_expect <<\EOF
-AA .gitmodules
+UU .gitmodules
 A  sub1
 EOF
 
@@ -277,7 +278,10 @@ cat >diff_expect <<\EOF
 diff --cc .gitmodules
 --- a/.gitmodules
 +++ b/.gitmodules
-@@@ -1,3 -1,3 +1,9 @@@
+@@@ -1,6 -1,6 +1,12 @@@
+  [submodule "sub"]
+  	path = sub
+  	url = ./sub
 ++<<<<<<< HEAD
  +[submodule "sub2"]
  +	path = sub2
@@ -293,7 +297,10 @@ cat >diff_submodule_expect <<\EOF
 diff --cc .gitmodules
 --- a/.gitmodules
 +++ b/.gitmodules
-@@@ -1,3 -1,3 +1,9 @@@
+@@@ -1,6 -1,6 +1,12 @@@
+  [submodule "sub"]
+  	path = sub
+  	url = ./sub
 ++<<<<<<< HEAD
  +[submodule "sub2"]
  +	path = sub2
-- 
2.39.1.581.gbfd45094c4-goog

