Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB098C433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD66660F02
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 23:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbhKDXw2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 19:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhKDXw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 19:52:27 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D0DC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 16:49:48 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w12-20020ac80ecc000000b002a7a4cd22faso4462097qti.4
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ehy1gfPuZPpt5vTCt7qL8FWJE7G8MNrarg2OHwyOr9U=;
        b=FzGCjUuGAtmULxgifXDkvy/X0eGC0mbXiT2Ze6MCtLk3n0IxHaIz9CzYI3dqKh15A2
         tHwfRnb3JsJB/rlymMLl0nLSAqnqLZw86AnWJ12gLeJr9q4deO2onj5KSJmZa0rAokNx
         nyBh8ONM/WCesWSG1r0sCk9lFnIvrbHaNCIIdHb4Jr4giR/RX+4U0FeaOieB9+npUbwG
         W7uEOhauYVolOo+G4kUfkLJj+HmPJ50IPJW4PF8zckJfMOdAXW3/3EUCqNZCdaVDY7Da
         6b5B25gWe9KgXwltOQgwUrzg7ZtUExy8snBzBmTqC9CxJrIoNpwm6GoVdjyOYc78Qvrr
         BfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ehy1gfPuZPpt5vTCt7qL8FWJE7G8MNrarg2OHwyOr9U=;
        b=kIE9XOmi8XgiM7OfZQ0t5AFBvKXTvA7b2+dg1bhx0CzAjhYdU0qdKFF/sTv5ZKq3vQ
         rHQlO3g2mRuyeif9PbMyWFTg8MZHsNYJzhFEbpUSl+sIsjZoqOK2YaNhsn4Hi6EtiCKT
         Ms5eaHDg6yogr9YzgJGaCandNYl5f8Uz7pAADPLUd22Wju30dcPPy74b2EwQXz8Io/+M
         xriQCpmBDozxWjACRtnpL/R3HcM47GzMMhICIvLnMGMpZFKQmjAbsl6ONl0HT0i7rPTl
         Kq+0T3bEG9IIytXeSZPciUKmj6+11Ezn9qtXW4u2L11RCNOEm/B1oO1iIXsBER7bw0b1
         R4JA==
X-Gm-Message-State: AOAM530DskLU7L2h3DPWBus3MBthYjcoMjLkMB238THdBpDLz/5jPJ4R
        e+TNfWX3HjyKQ1v8a89id3TKoAb4pqcv9JDB344LU5V3u+JSqJaRL2nEQM1ueF2oSN3Hoc+i4MM
        Q6ZExRVD3ijCNylUyZsH1B2B/OvP+ZRfJqM0uslHs/AqlWpfOdRmZGIJjjpg5w973eIRiYVyp9Q
        ==
X-Google-Smtp-Source: ABdhPJzfDnhxhkZAc1mMMfwbfU9+MAMQe3ElGYLkWfjzZQALI4kDIC6BcBZls0F7cOQWGfiXmfCLeOaL2h7VUmc78Rs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:200:35a1:c171:b6f3:d46c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:622a:1788:: with SMTP id
 s8mr28948597qtk.388.1636069787946; Thu, 04 Nov 2021 16:49:47 -0700 (PDT)
Date:   Thu,  4 Nov 2021 16:49:39 -0700
In-Reply-To: <20211104234942.3473650-1-emilyshaffer@google.com>
Message-Id: <20211104234942.3473650-2-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20211104234942.3473650-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v5 1/4] t7400-submodule-basic: modernize inspect() helper
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
2.34.0.rc0.344.g81b53c2807-goog

