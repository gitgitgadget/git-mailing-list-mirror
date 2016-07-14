Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BA6020196
	for <e@80x24.org>; Thu, 14 Jul 2016 17:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbcGNRjv (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 13:39:51 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35911 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbcGNRjr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 13:39:47 -0400
Received: by mail-pa0-f48.google.com with SMTP id pp5so23911107pac.3
        for <git@vger.kernel.org>; Thu, 14 Jul 2016 10:39:46 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+0ZkZUR3UBUWewb7WVEuuiwB5E4sX2evIyxBUmpygoA=;
        b=VLRL9cZHDpSZm54ZV+IZHui5c73nHF5shORj+cG9QcuOlVSpFklipFxFKFRgHPlMaR
         NbeSEWa2/rHV8PQ3spgtKTLqGVf/Z4fDvm4zsVQ/kM8sPqCGfE1o6QYmiRDyR68qThZn
         1vYFBIZonlio8x/GjGKnJEIuDyNXtNt4ghMdMeKbspA/TxLfgv+eTke4LIgwHbgHhv12
         TIyEyr5ZqtxscDeEJ3PdufdHqVDlvUvCcbg2X8afFTnGdx3J+0dJa0bS6HmMVE1sUlHk
         K+NVakodDkjJyZHw5kBWOGxREN5eS30C9BNd9VUowBqUaOQ+vviOM8vtySUtxxt0XycW
         kUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+0ZkZUR3UBUWewb7WVEuuiwB5E4sX2evIyxBUmpygoA=;
        b=ZQhdM24jPkGN+6kpoR2jLn/2lXa4cd7//ZMo5R4YXsJiGyEqGjpU8Jk5x22k8Rmi3w
         7RejoVKwPrnGZnt99wh6mmQxqby2R+yqT0IT1qtZIGBaiFv9rSf0XX0S+8Q8BgzFoEkV
         90i6y+w5Z6CL/clDwRaPHkAMR/pfGb4Jf78cJYnjOaCuhm1+R84Pajn9Uifs6FDGCgEk
         9RNxT4IOUWGscMVcVJYEPp2OGzhPjVhZzuhYkjeWa5UG9k9tv/Lkck4hUJehE0RW/KRw
         4rVnb8wLkI26cxDn9HTG1rAZkMcl+wzTfvRCJvSgVw40//QbmutkgNiigza6EGd+agJB
         WTpA==
X-Gm-Message-State: ALyK8tL2XWFtdfPxyB9HBTbZANhlYkG7rxIykEn8PsuZCXujewgsoMYcIPxt1oFooqKT6oAX
X-Received: by 10.66.185.14 with SMTP id ey14mr24835644pac.71.1468517985847;
        Thu, 14 Jul 2016 10:39:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c041:4809:7eab:7652])
        by smtp.gmail.com with ESMTPSA id v126sm5788764pfb.60.2016.07.14.10.39.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jul 2016 10:39:45 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	git@vger.kernel.org, gitster@pobox.com
Cc:	dwwang@google.com, e@80x24.org, peff@peff.net,
	dennis@kaarsemaker.net, jrnieder@gmail.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 4/4] add a test for push options
Date:	Thu, 14 Jul 2016 10:39:20 -0700
Message-Id: <20160714173920.22001-5-sbeller@google.com>
X-Mailer: git-send-email 2.9.0.247.gf748855.dirty
In-Reply-To: <20160714173920.22001-1-sbeller@google.com>
References: <20160714173920.22001-1-sbeller@google.com>
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

