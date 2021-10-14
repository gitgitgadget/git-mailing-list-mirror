Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38C5C4332F
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8513A61130
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 20:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbhJNUgk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 16:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhJNUgk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 16:36:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE422C061570
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:34 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y18-20020a25a092000000b005bddb39f160so7014350ybh.10
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 13:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EAMaV35359qSPUPd0E6tAUxjFw7qmvwY1vPLP8ryqhw=;
        b=hVNzlfENxT901vsmfFVqJozr2STgkW1qr6FQmICj/nsUHAPhMLR7dJNvse4YWO9UTs
         eGm6Kuy9BUekhUq5RGkb4CSSJ158MQMVGNKDYTm0ZocQugtzKSogPWYGaeRzFpSyFNa3
         bMqhjrKngns2YKGItOJf08yjH5UyqYJsyAKznXmP7g0g1cn84ToVjVhVg//gGKarznym
         lsOwWzSDZWKaxX/C2ymZg6d2VN5N05E4QzNLlCsUGna9njxqKW4ad9F+x76yzUVDlfWY
         oX5oOwYQPD4YDdomllds07lpZoxfkTw/dk8cZp38jmwEO+xb2WvqqqUY3oQG2w1xRNBe
         cTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EAMaV35359qSPUPd0E6tAUxjFw7qmvwY1vPLP8ryqhw=;
        b=ZYgBZkF/YLl8ozs/mDPU587UWImiT7B1UOXIVa0oZ1KC5YIiSvG4lWGIB7F6JxawCP
         fxmwKjfM2cmgVmb9ifhdGKAmJaNZncAHwX1ldDsWeca9fyByFAX3FmSPqeKcPadvZ5aB
         adJqMFS7g/gENa8KYdMVsGovNJfB8Q9UIx10eH1LxEIn1Krcp/UDlb5k9+U00lr1SryI
         dcKfbeuou+V+dJOuhTBM8pfm9xuwHSKJ/I110zyY+lzM8PEHupaUgPMQ/2rOxsyoTnV/
         mYs7q0jzCI2j6sL1UqoNu2rzHobJChSJU8MohS5UvFKKA4SALmdv/Rb8HcyNCz+V0/BO
         bhNw==
X-Gm-Message-State: AOAM532RD3k74+XOMsZeHv37O1jTUlsKuhVw0nybmG2XlZiiB6qFcHM+
        KF5CH5nX8krxq6soEYgKm1BBgYFTgt0Vc9hLAWLySMmB0gClWoL7pH0t6YJZ8xJLdRs9NtLS3tG
        tl589L0vwh47g5BRX94pcsM8WELxjqQmYkTF20La5yPpEZ7D4kzPNJh+RmMOJFu2fBmYXr2yvLA
        ==
X-Google-Smtp-Source: ABdhPJybvJql5v6eB3JkpC34FqklFPSCXY+IdusF7OUlFbEsWFfn+FoNToIkQEJV1dPXCl0oIwUcaWAl+Wkhu2U5uIU=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:e9ae:673a:ec5:a064])
 (user=emilyshaffer job=sendgmr) by 2002:a25:abf0:: with SMTP id
 v103mr8207523ybi.385.1634243674107; Thu, 14 Oct 2021 13:34:34 -0700 (PDT)
Date:   Thu, 14 Oct 2021 13:34:13 -0700
In-Reply-To: <20211014203416.2802639-1-emilyshaffer@google.com>
Message-Id: <20211014203416.2802639-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211014203416.2802639-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 1/4] t7400-submodule-basic: modernize inspect() helper
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the inspect() helper in the submodule-basic test suite was
written, 'git -C <dir>' was added. By using -C, we no longer need a
reference to the base directory for the test. This simplifies callsites,
and will make the addition of other arguments in later patches more
readable.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 t/t7400-submodule-basic.sh | 40 +++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index cb1b8e35db..d69a5c0032 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -107,23 +107,15 @@ test_expect_success 'setup - repository to add submodules to' '
 # generates, which will expand symbolic links.
 submodurl=$(pwd -P)
 
-listbranches() {
-	git for-each-ref --format='%(refname)' 'refs/heads/*'
-}
-
 inspect() {
-	dir=$1 &&
-	dotdot="${2:-..}" &&
-
-	(
-		cd "$dir" &&
-		listbranches >"$dotdot/heads" &&
-		{ git symbolic-ref HEAD || :; } >"$dotdot/head" &&
-		git rev-parse HEAD >"$dotdot/head-sha1" &&
-		git update-index --refresh &&
-		git diff-files --exit-code &&
-		git clean -n -d -x >"$dotdot/untracked"
-	)
+	sub_dir=$1 &&
+
+	git -C "$sub_dir" for-each-ref --format='%(refname)' 'refs/heads/*' >heads &&
+	{ git -C "$sub_dir" symbolic-ref HEAD || :; } >head &&
+	git -C "$sub_dir" rev-parse HEAD >head-sha1 &&
+	git -C "$sub_dir" update-index --refresh &&
+	git -C "$sub_dir" diff-files --exit-code &&
+	git -C "$sub_dir" clean -n -d -x >untracked
 }
 
 test_expect_success 'submodule add' '
@@ -146,7 +138,7 @@ test_expect_success 'submodule add' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod ../.. &&
+	inspect addtest/submod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -248,7 +240,7 @@ test_expect_success 'submodule add --branch' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/submod-branch ../.. &&
+	inspect addtest/submod-branch &&
 	test_cmp expect-heads heads &&
 	test_cmp expect-head head &&
 	test_must_be_empty untracked
@@ -264,7 +256,7 @@ test_expect_success 'submodule add with ./ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotsubmod/frotz ../../.. &&
+	inspect addtest/dotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -280,7 +272,7 @@ test_expect_success 'submodule add with /././ in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/dotslashdotsubmod/frotz ../../.. &&
+	inspect addtest/dotslashdotsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -296,7 +288,7 @@ test_expect_success 'submodule add with // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/slashslashsubmod/frotz ../../.. &&
+	inspect addtest/slashslashsubmod/frotz &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -312,7 +304,7 @@ test_expect_success 'submodule add with /.. in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod ../.. &&
+	inspect addtest/realsubmod &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -328,7 +320,7 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod2 ../.. &&
+	inspect addtest/realsubmod2 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
@@ -359,7 +351,7 @@ test_expect_success 'submodule add in subdirectory' '
 	) &&
 
 	rm -f heads head untracked &&
-	inspect addtest/realsubmod3 ../.. &&
+	inspect addtest/realsubmod3 &&
 	test_cmp expect heads &&
 	test_cmp expect head &&
 	test_must_be_empty untracked
-- 
2.33.0.1079.g6e70778dc9-goog

