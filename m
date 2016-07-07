Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A37F2070F
	for <e@80x24.org>; Thu,  7 Jul 2016 01:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbcGGBMy (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 21:12:54 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35063 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbcGGBMx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 21:12:53 -0400
Received: by mail-pa0-f41.google.com with SMTP id dx3so1266803pab.2
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 18:12:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IHQUco70hqipJs3HV/oWXduD4Nqm+/jouN4LPQgMk5U=;
        b=DVOIJGKNjtlpOfKyJkRvRK3uLBnUAz3XB+jMsnfT3UsSYRz83GNsmcqOYqn7Vd0cp0
         D7HQaxjrSTfJyroHqZ/h5Cm8ro/MXlSZ0+BPkhg63/FICFgFF/zfkWbddNtvqkE7sxvD
         oT6JDGRF2VnuOUbid/o9KToO1r6lZxZXqfH1d7X6v62QPKYW7GFx5DrS3+011trgD7uR
         swvoYhBBAG1SYFzmH/Cjeud8ksY/YkZ/T9JItCsNMdbd8rXFzuzM3U146GSly1sevaUy
         5VMlmAukL1VsK2SuFSzqlqDUVL4EUw4/Jod13tC8yRRVY3I7yW39tjLg5Wa9ZZoYoX78
         tIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IHQUco70hqipJs3HV/oWXduD4Nqm+/jouN4LPQgMk5U=;
        b=d5HuJ5LPCsH2XdtQp7q2t/vblskxy6hwttX5WPo7xUqmfVKStkJp0nz/VjBs4mAWzq
         2vVBrv3p8l2B6InZDB3DLzxZ9tt0G3Om60DUrYzq/FRle+agghnnr5vQn00trBcV34hD
         /KtddLZQcgu1iuL+aBhZQTHk13PAWvc4zP7/TUMElY+5t1bO1unnA0Y3Jvj+b9Se2PZu
         +aa3+crjmzqXtdOrmCsjPki6jkhEfTd2lnh64EL/0SDo04ciYUcSjavBc4oIK4DAXaoG
         RynNBKTwiBqI1rhqB0uLBcJt8Bei2e3wu6DWX5chxqJt3mqrnqzppJrgbi4Ph4sGq8E7
         QV4Q==
X-Gm-Message-State: ALyK8tIDUucKB2M/ZFR0/QPvOi1H13LxW8CVe5Yxzr9GyYms3Bes3yepskPWDcfwDJh89PB5
X-Received: by 10.66.83.35 with SMTP id n3mr47040784pay.124.1467853969341;
        Wed, 06 Jul 2016 18:12:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:7518:e836:5c9c:93dd])
        by smtp.gmail.com with ESMTPSA id 134sm760954pfu.83.2016.07.06.18.12.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 18:12:45 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, e@80x24.org, peff@peff.net, dwwang@google.com,
	dennis@kaarsemaker.net, Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] add a test for push options
Date:	Wed,  6 Jul 2016 18:12:18 -0700
Message-Id: <20160707011218.3690-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.141.gd59d3e9.dirty
In-Reply-To: <20160707011218.3690-1-sbeller@google.com>
References: <20160707011218.3690-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The functions `mk_repo_pair` as well as `test_refs` are borrowed from
t5543-atomic-push, with additional hooks installed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5544-push-options.sh | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100755 t/t5544-push-options.sh

diff --git a/t/t5544-push-options.sh b/t/t5544-push-options.sh
new file mode 100755
index 0000000..8dd3c8e
--- /dev/null
+++ b/t/t5544-push-options.sh
@@ -0,0 +1,101 @@
+#!/bin/sh
+
+test_description='pushing to a repository using push options'
+
+. ./test-lib.sh
+
+mk_repo_pair () {
+	rm -rf workbench upstream &&
+	test_create_repo upstream &&
+	test_create_repo workbench &&
+	(
+		cd upstream &&
+		git config receive.denyCurrentBranch warn &&
+		mkdir -p .git/hooks &&
+		cat >.git/hooks/pre-receive <<-'EOF' &&
+		#!/bin/sh
+		if test -n "$GIT_PUSH_OPTION_COUNT"; then
+			i=0
+			>hooks/pre-receive.push_options
+			while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do
+				eval "value=\$GIT_PUSH_OPTION_$i"
+				echo $value >>hooks/pre-receive.push_options
+				i=$((i + 1))
+			done
+		fi
+		EOF
+		chmod u+x .git/hooks/pre-receive
+
+		cat >.git/hooks/post-receive <<-'EOF' &&
+		#!/bin/sh
+		if test -n "$GIT_PUSH_OPTION_COUNT"; then
+			i=0
+			>hooks/post-receive.push_options
+			while test "$i" -lt "$GIT_PUSH_OPTION_COUNT"; do
+				eval "value=\$GIT_PUSH_OPTION_$i"
+				echo $value >>hooks/post-receive.push_options
+				i=$((i + 1))
+			done
+		fi
+		EOF
+		chmod u+x .git/hooks/post-receive
+	) &&
+	(
+		cd workbench &&
+		git remote add up ../upstream
+	)
+}
+
+# Compare the ref ($1) in upstream with a ref value from workbench ($2)
+# i.e. test_refs second HEAD@{2}
+test_refs () {
+	test $# = 2 &&
+	git -C upstream rev-parse --verify "$1" >expect &&
+	git -C workbench rev-parse --verify "$2" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'one push option works for a single branch' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git push --push-option=asdf up master
+	) &&
+	test_refs master master &&
+	echo "asdf" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_expect_success 'push option denied by remote' '
+	mk_repo_pair &&
+	git -C upstream config receive.advertisePushOptions false &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		test_must_fail git push --push-option=asdf up master
+	) &&
+	test_refs master HEAD@{1}
+'
+
+test_expect_success 'two push options work' '
+	mk_repo_pair &&
+	(
+		cd workbench &&
+		test_commit one &&
+		git push --mirror up &&
+		test_commit two &&
+		git push --push-option=asdf --push-option="more structured text" up master
+	) &&
+	test_refs master master &&
+	printf "asdf\nmore structured text\n" >expect &&
+	test_cmp expect upstream/.git/hooks/pre-receive.push_options &&
+	test_cmp expect upstream/.git/hooks/post-receive.push_options
+'
+
+test_done
-- 
2.9.0.141.gd59d3e9.dirty

