Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878A91F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752723AbeFERwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:52:05 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:47421 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbeFERwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:02 -0400
Received: by mail-vk0-f73.google.com with SMTP id v191-v6so1197354vke.14
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=vYYn1c1zWbz6YscHifqhZZa++piLxtxDz2jes92buO4=;
        b=BruxfDlMARTMtkXt4JE4in83N0LePV1e4YoVxHo2ZeyFk9TVigvwOr9Ov+0f7eJBu9
         dGWQrOUdQsh//yteSdxZ8w8D3UUFXBDdXBLla/NTuOh0V+CRodSdjBpVo6ArNyKKkp1k
         F3HB/nMGaA81PQPNAm30HGXoU5e0cq50ya1/CjcVLXwZYbzydQEvT6MXbw2n72RBuU90
         AdeZgiqfXn+OxbNZfmeDsDwQ/OQWlGg3fS5jIsyOP1ZZRlVg3a4SMIFj5On3NYpjxErC
         NT1R2Fab6ffW1LpxpHohjH5SBEGF9IUPwLl1JYUApz1WZWGo2WqDqIqg1bjLTZEJCXcJ
         4U+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=vYYn1c1zWbz6YscHifqhZZa++piLxtxDz2jes92buO4=;
        b=oF0Pu7XvEwLxj7guwxHq1n8KV9mwzU1CUyafIV7RsKhQtnFEqXts6cYmeysnnfR4yl
         8rHz559Hpvs+CoBa4tADf7dqB+qvh6D1YghM5pWXsHGwxu5ysotfxP8hQfX97Eav8s+f
         eMMP7a6JvURWiw7ZIi4DvCl/rdkwZbNjHaI9tbsWp4RvnVnra0VrS72VynLiisVXQDGN
         yUKL8hR6UYRUqecmg74CfMKpvMnD/AwHgkzBGt9iePY3IVK1zuEltUGJR0ZWrayfuazr
         sABeO49b1UM0yxLHKMMR8GSuuKBb50/3XLJzYP6Uu1f6+juFWN97ZNyYMRQ134pyYQ87
         73/Q==
X-Gm-Message-State: APt69E0RjeSl/Lmk6juP4f7ZeXV1Th5xjb/3VXD7uRuVxff9tx+UGNf3
        89JvhgOKcDwy37WjvCyaj7tXNh8lwjvlt+0jag/oWk0Ogmi0F8s+8f1Iz8Hyz38vPx/E5nrzk01
        5AvU/NweoI27ncWh7GE/+BJdRqkdavjqQCXATRQCeNuQFVeW2b68VX6UPnA==
X-Google-Smtp-Source: ADUXVKLoX8GsSBqHJ33H/p0ptwYghRxAGp7Nt+YvmBJ/bWL+XGbW4LiBelfZy7iFXfWMVw5WrBbMSWK3GKQ=
MIME-Version: 1.0
X-Received: by 2002:ab0:643:: with SMTP id f61-v6mr8872463uaf.113.1528221122062;
 Tue, 05 Jun 2018 10:52:02 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:39 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180605175144.4225-4-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 3/8] upload-pack: test negotiation with changing repository
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to check the behavior of fetching from a repository which
changes between rounds of negotiation (for example, when different
servers in a load-balancing agreement participate in the same stateless
RPC negotiation). This forms a baseline of comparison to the ref-in-want
functionality (which will be introduced to the client in subsequent
commits), and ensures that subsequent commits do not change existing
behavior.

As part of this effort, a mechanism to substitute strings in a single
HTTP response is added.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/lib-httpd.sh                     |  1 +
 t/lib-httpd/apache.conf            |  8 +++
 t/lib-httpd/one-time-sed.sh        | 16 ++++++
 t/t5703-upload-pack-ref-in-want.sh | 92 ++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+)
 create mode 100644 t/lib-httpd/one-time-sed.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 435a37465..84f8efdd4 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,6 +132,7 @@ prepare_httpd() {
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
 	install_script error.sh
+	install_script one-time-sed.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
index 724d9ae46..fe68d37bb 100644
--- a/t/lib-httpd/apache.conf
+++ b/t/lib-httpd/apache.conf
@@ -111,9 +111,14 @@ Alias /auth/dumb/ www/auth/dumb/
 	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
 	SetEnv GIT_HTTP_EXPORT_ALL
 </LocationMatch>
+<LocationMatch /one_time_sed/>
+	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
+	SetEnv GIT_HTTP_EXPORT_ALL
+</LocationMatch>
 ScriptAliasMatch /smart_*[^/]*/(.*) ${GIT_EXEC_PATH}/git-http-backend/$1
 ScriptAlias /broken_smart/ broken-smart-http.sh/
 ScriptAlias /error/ error.sh/
+ScriptAliasMatch /one_time_sed/(.*) one-time-sed.sh/$1
 <Directory ${GIT_EXEC_PATH}>
 	Options FollowSymlinks
 </Directory>
@@ -123,6 +128,9 @@ ScriptAlias /error/ error.sh/
 <Files error.sh>
   Options ExecCGI
 </Files>
+<Files one-time-sed.sh>
+	Options ExecCGI
+</Files>
 <Files ${GIT_EXEC_PATH}/git-http-backend>
 	Options ExecCGI
 </Files>
diff --git a/t/lib-httpd/one-time-sed.sh b/t/lib-httpd/one-time-sed.sh
new file mode 100644
index 000000000..a9c4aa5f4
--- /dev/null
+++ b/t/lib-httpd/one-time-sed.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+
+if [ -e one-time-sed ]; then
+	"$GIT_EXEC_PATH/git-http-backend" >out
+
+	sed "$(cat one-time-sed)" <out >out_modified
+
+	if diff out out_modified >/dev/null; then
+		cat out
+	else
+		cat out_modified
+		rm one-time-sed
+	fi
+else
+	"$GIT_EXEC_PATH/git-http-backend"
+fi
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 0ef182970..979ab6d03 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -150,4 +150,96 @@ test_expect_success 'want-ref with ref we already have commit for' '
 	check_output
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
+LOCAL_PRISTINE="$(pwd)/local_pristine"
+
+test_expect_success 'setup repos for change-while-negotiating test' '
+	(
+		git init "$REPO" &&
+		cd "$REPO" &&
+		>.git/git-daemon-export-ok &&
+		test_commit m1 &&
+		git tag -d m1 &&
+
+		# Local repo with many commits (so that negotiation will take
+		# more than 1 request/response pair)
+		git clone "http://127.0.0.1:$LIB_HTTPD_PORT/smart/repo" "$LOCAL_PRISTINE" &&
+		cd "$LOCAL_PRISTINE" &&
+		git checkout -b side &&
+		for i in $(seq 1 33); do test_commit s$i; done &&
+
+		# Add novel commits to upstream
+		git checkout master &&
+		cd "$REPO" &&
+		test_commit m2 &&
+		test_commit m3 &&
+		git tag -d m2 m3
+	) &&
+	git -C "$LOCAL_PRISTINE" remote set-url origin "http://127.0.0.1:$LIB_HTTPD_PORT/one_time_sed/repo" &&
+	git -C "$LOCAL_PRISTINE" config protocol.version 2
+'
+
+inconsistency() {
+	# Simulate that the server initially reports $2 as the ref
+	# corresponding to $1, and after that, $1 as the ref corresponding to
+	# $1. This corresponds to the real-life situation where the server's
+	# repository appears to change during negotiation, for example, when
+	# different servers in a load-balancing arrangement serve (stateless)
+	# RPCs during a single negotiation.
+	printf "s/%s/%s/" \
+	       $(git -C "$REPO" rev-parse $1 | tr -d "\n") \
+	       $(git -C "$REPO" rev-parse $2 | tr -d "\n") \
+	       >"$HTTPD_ROOT_PATH/one-time-sed"
+}
+
+test_expect_success 'server is initially ahead - no ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	test_must_fail git -C local fetch 2>err &&
+	grep "ERR upload-pack: not our ref" err
+'
+
+test_expect_failure 'server is initially ahead - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify master >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server is initially behind - no ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant false &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master^" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_failure 'server is initially behind - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+stop_httpd
+
 test_done
-- 
2.17.1.1185.g55be947832-goog

