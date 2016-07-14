Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCD80203C1
	for <e@80x24.org>; Thu, 14 Jul 2016 21:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbcGNVuG (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 17:50:06 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35529 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbcGNVuB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 17:50:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id dx3so32431011pab.2
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 14:50:00 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+0ZkZUR3UBUWewb7WVEuuiwB5E4sX2evIyxBUmpygoA=;
        b=ZY/LgwHLyoKPK/OkcMh3D6uMRH9tSso/6FiOTAU62MPK2uZI0LTIXkcOQy2RhE0Abf
         jXuy+xg30MBrACKlX8SKza3hFO8QJQJGr2TKMyqtgMNRoJimPPKe0ncAspWwBsCb/NoP
         7v9gdCdmSvyC7//76b2Fsl5bUB/qlBYD5pmyapNTN2JaluL0zYxnG1irWsxRoVvhSgAm
         NrR63Lx5Ny8fIWg7GQItCSHx7TySgpu7gswwwUZ0vx1IYTJvnbznFcN49sXIxKLKGXzW
         A2x/7QhmAxzFQc6WqBpcA3t3KbFWSfKDEhJHmseNSiUDpX8bFw0EmqrApcpsAN3fXhwt
         KfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+0ZkZUR3UBUWewb7WVEuuiwB5E4sX2evIyxBUmpygoA=;
        b=KPCazH3DRyhjNUDBJ0pAb8tocLuO5vhf82xaQaEjujOJkQAWu4RU0dj5Kot86whijx
         LzSBY0vEWFrYjzSjXfbV0xRr/d6Vwgo5KgnyUrUmXTjGuB07xG6gkBR4j5Jq/XdSxIqb
         +1nG3kL8zZ72b5QNVzxy43GMHNtB9TlKMRRNrlxj9mxm3bcXs7qVxH4pPpVB4bpyKZrO
         b9rWHQ4Z60iYTKvTW0DvGqHbYxL+gF51RBPfJiZxX+/PM+DqjAYqKWc0tbnA/LpTyprd
         FJvkVVczZoEazfde6KebMi/kilcmQq9XCuijCdqx1PP2r5pX0RkOZMeh1HmJ7A9we3p9
         i9sw==
X-Gm-Message-State: ALyK8tIR/9QuRGwTfCuAo87MgmGHZKaDk/E13eb3twI0YUzJ3LUQew3ir5gsZsbenzf6+Ptb
X-Received: by 10.66.65.109 with SMTP id w13mr26677614pas.142.1468533000179;
        Thu, 14 Jul 2016 14:50:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c041:4809:7eab:7652])
        by smtp.gmail.com with ESMTPSA id b134sm4501593pfb.55.2016.07.14.14.49.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 14:49:59 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	dwwang@google.com, e@80x24.org, peff@peff.net,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] add a test for push options
Date:	Thu, 14 Jul 2016 14:49:48 -0700
Message-Id: <20160714214948.27432-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.gf748855.dirty
In-Reply-To: <20160714214948.27432-1-sbeller@google.com>
References: <20160714214948.27432-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The functions `mk_repo_pair` as well as `test_refs` are borrowed from
t5543-atomic-push, with additional hooks installed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t5545-push-options.sh | 103 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100755 t/t5545-push-options.sh

diff --git a/t/t5545-push-options.sh b/t/t5545-push-options.sh
new file mode 100755
index 0000000..ea813b9
--- /dev/null
+++ b/t/t5545-push-options.sh
@@ -0,0 +1,103 @@
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
+	git -C upstream config receive.advertisePushOptions true &&
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
+	git -C upstream config receive.advertisePushOptions true &&
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
2.9.0.247.gf748855.dirty

