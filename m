Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF43C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 10:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348627AbiFOKo0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 06:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348551AbiFOKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 06:44:23 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9406F50478
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:44:21 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s1so14777066wra.9
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 03:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdDLV3HAVN1L4S0pj1snMcm99u9y07JFBBCW8gc9HL0=;
        b=OX+5x+vyZh8wQ5Nb5JUPKEOsv1dbbek0ZjaFF9iRl6zn0aqThqUuHXgb3+6Jxr8+lA
         +V7NEBWmDjtfHYHfaSdSraF9/1Q1SvXUklFOxxUZtO0GoJDvL9TQxx9Js3oJYaEFaNGW
         4l8imf8X/SQa7n1LnzRo7cZ2VpSqUxk8u9It/q8F4/vFMSfrFlyfWLcodtzWPB4+GhO+
         TulDVeS8cjWLClz1Jqf1C9i6vL/cwrqtBnLXRarUrBhqLhvJDxy7Y17q7sBQDKvc6A7D
         jbsLFiq5Vm8uXkke0Yz67Nr+NzUuhhDbs0KiVk2/EKl6sLPnNTSeXW1xlqZrW6lKK17G
         913g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdDLV3HAVN1L4S0pj1snMcm99u9y07JFBBCW8gc9HL0=;
        b=w5jROWZPaVAPEgDmAW6jt8OjAl6lq8ZMBw4II5cn2EyFDo1FXedEn/CB5xL9/KiYXQ
         heXszDSpdwpRTdksOjVzGuDJPUoWKALu470DvizaHQ+T88COVqDyvVZgvcBtqvJvTOqN
         eZQh/3BejXafsNHp1Kfg7nmuGyUESOKKEDjn8JlQ8JObXixmHobb41CThimvbc9t6HHO
         pbXu3CdLzIcGKJoaPLDs7LnKf18YHXO4IWdRR9t2/2qAH116vtuf55sJUsdRg/dv0cRe
         VpGfDCXfh8kpwiYF4OLUsuvL6JEbuKDHgQdQT6su8fLHxzH88qSvT90n3ORj1mzSyvwa
         8Uhw==
X-Gm-Message-State: AJIora/Mh++K6Kpo2QbI/VuYFp7xYx7o/BkJdeJYGE+HZcIt2i2ZBYbS
        PnsSTNmw3wIOnOuivMTji4QV33b7cOvWlQ==
X-Google-Smtp-Source: AGRyM1v00c5y9/hMnOAVUxht6qPGfKJ88bMnMNPYzbje6kmWZhZcYNXJJ+dm6mbUWzAcYv3ZioT5PA==
X-Received: by 2002:a5d:59ae:0:b0:217:2519:8a0f with SMTP id p14-20020a5d59ae000000b0021725198a0fmr9338487wrr.383.1655289859679;
        Wed, 15 Jun 2022 03:44:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q1-20020adff501000000b002117ef160fbsm14487620wro.21.2022.06.15.03.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:44:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] transfer doc: move fetch.credentialsInUrl to "transfer" config namespace
Date:   Wed, 15 Jun 2022 12:44:12 +0200
Message-Id: <patch-2.2-9eb1ff28e80-20220615T103852Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "fetch.credentialsInUrl" configuration variable introduced
in 6dcbdc0d661 (remote: create fetch.credentialsInUrl config,
2022-06-06) to "transfer".

There are existing exceptions, but generally speaking the
"<namespace>.<var>" configuration should only apply to command
described in the "namespace" (and its sub-commands, so e.g. "clone.*"
or "fetch.*" might also configure "git-remote-https").

But in the case of "fetch.credentialsInUrl" we've got a configuration
variable that configures the behavior of all of "clone", "push" and
"fetch", someone adjusting "fetch.*" configuration won't expect to
have the behavior of "git push" altered, especially as we have the
pre-existing "{transfer,fetch,receive}.fsckObjects", which configures
different parts of the transfer dialog.

So let's move this configuration variable to the "transfer" namespace
before it's exposed in a release. We could add all of
"{transfer,fetch,pull}.credentialsInUrl" at some other time, but once
we have "fetch" configure "pull" such an arrangement would would be a
confusing mess, as we'd at least need to have "fetch" configure
"push" (but not the other way around), or change existing behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/RelNotes/2.37.0.txt |  2 +-
 Documentation/config/fetch.txt    | 36 -----------------------------
 Documentation/config/transfer.txt | 38 +++++++++++++++++++++++++++++++
 remote.c                          |  4 ++--
 t/t5516-fetch-push.sh             | 14 ++++++------
 t/t5601-clone.sh                  | 10 ++++----
 6 files changed, 53 insertions(+), 51 deletions(-)

diff --git a/Documentation/RelNotes/2.37.0.txt b/Documentation/RelNotes/2.37.0.txt
index 39ca3606dec..9902a74f34a 100644
--- a/Documentation/RelNotes/2.37.0.txt
+++ b/Documentation/RelNotes/2.37.0.txt
@@ -54,7 +54,7 @@ UI, Workflows & Features
 
  * Update the doctype written in gitweb output to xhtml5.
 
- * The "fetch.credentialsInUrl" configuration variable controls what
+ * The "transfer.credentialsInUrl" configuration variable controls what
    happens when a URL with embedded login credential is used on either
    "fetch" or "push". Credentials are currently only detected in
    `remote.<name>.url` config, not `remote.<name>.pushurl`.
diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 827961059f8..cd65d236b43 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -96,39 +96,3 @@ fetch.writeCommitGraph::
 	merge and the write may take longer. Having an updated commit-graph
 	file helps performance of many Git commands, including `git merge-base`,
 	`git push -f`, and `git log --graph`. Defaults to false.
-
-fetch.credentialsInUrl::
-	A configured URL can contain plaintext credentials in the form
-	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
-	to warn or forbid the use of such configuration (in favor of
-	using linkgit:git-credential[1]).
-+
-Note that this is currently limited to detecting credentials in
-`remote.<name>.url` configuration, it won't detect credentials in
-`remote.<name>.pushurl` configuration.
-+
-You might want to enable this to prevent inadvertent credentials
-exposure, e.g. because:
-+
-* The OS or system where you're running git may not provide way way or
-  otherwise allow you to configure the permissions of the
-  configuration file where the username and/or password are stored.
-* Even if it does, having such data stored "at rest" might expose you
-  in other ways, e.g. a backup process might copy the data to another
-  system.
-* The git programs will pass the full URL to one another as arguments
-  on the command-line, meaning the credentials will be exposed to oher
-  users on OS's or systems that allow other users to see the full
-  process list of other users. On linux the "hidepid" setting
-  documented in procfs(5) allows for configuring this behavior.
-+
-If such concerns don't apply to you then you probably don't need to be
-concerned about credentials exposure due to storing that sensitive
-data in git's configuration files. If you do want to use this, set
-`fetch.credentialsInUrl` to one of these values:
-+
-* `allow` (default): Git will proceed with its activity without warning.
-* `warn`: Git will write a warning message to `stderr` when parsing a URL
-  with a plaintext credential.
-* `die`: Git will write a failure message to `stderr` when parsing a URL
-  with a plaintext credential.
diff --git a/Documentation/config/transfer.txt b/Documentation/config/transfer.txt
index b49429eb4db..b4475c06900 100644
--- a/Documentation/config/transfer.txt
+++ b/Documentation/config/transfer.txt
@@ -1,3 +1,41 @@
+transfer.credentialsInUrl::
+	A configured URL can contain plaintext credentials in the form
+	`<protocol>://<user>:<password>@<domain>/<path>`. You may want
+	to warn or forbid the use of such configuration (in favor of
+	using linkgit:git-credential[1]). This will be used on
+	linkgit:git-clone[1], linkgit:git-fetch[1], linkgit:git-push[1],
+	and any other direct use of the configured URL.
++
+Note that this is currently limited to detecting credentials in
+`remote.<name>.url` configuration, it won't detect credentials in
+`remote.<name>.pushurl` configuration.
++
+You might want to enable this to prevent inadvertent credentials
+exposure, e.g. because:
++
+* The OS or system where you're running git may not provide way way or
+  otherwise allow you to configure the permissions of the
+  configuration file where the username and/or password are stored.
+* Even if it does, having such data stored "at rest" might expose you
+  in other ways, e.g. a backup process might copy the data to another
+  system.
+* The git programs will pass the full URL to one another as arguments
+  on the command-line, meaning the credentials will be exposed to oher
+  users on OS's or systems that allow other users to see the full
+  process list of other users. On linux the "hidepid" setting
+  documented in procfs(5) allows for configuring this behavior.
++
+If such concerns don't apply to you then you probably don't need to be
+concerned about credentials exposure due to storing that sensitive
+data in git's configuration files. If you do want to use this, set
+`transfer.credentialsInUrl` to one of these values:
++
+* `allow` (default): Git will proceed with its activity without warning.
+* `warn`: Git will write a warning message to `stderr` when parsing a URL
+  with a plaintext credential.
+* `die`: Git will write a failure message to `stderr` when parsing a URL
+  with a plaintext credential.
+
 transfer.fsckObjects::
 	When `fetch.fsckObjects` or `receive.fsckObjects` are
 	not set, the value of this variable is used instead.
diff --git a/remote.c b/remote.c
index 9b9bbfe80ec..42c891d44fd 100644
--- a/remote.c
+++ b/remote.c
@@ -623,7 +623,7 @@ static void validate_remote_url(struct remote *remote)
 	struct strbuf redacted = STRBUF_INIT;
 	int warn_not_die;
 
-	if (git_config_get_string_tmp("fetch.credentialsinurl", &value))
+	if (git_config_get_string_tmp("transfer.credentialsinurl", &value))
 		return;
 
 	if (!strcmp("warn", value))
@@ -633,7 +633,7 @@ static void validate_remote_url(struct remote *remote)
 	else if (!strcmp("allow", value))
 		return;
 	else
-		die(_("unrecognized value fetch.credentialsInURL: '%s'"), value);
+		die(_("unrecognized value transfer.credentialsInURL: '%s'"), value);
 
 	for (i = 0; i < remote->url_nr; i++) {
 		struct url_info url_info = { 0 };
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index dedca106a7a..79d8a7b3675 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1836,18 +1836,18 @@ test_expect_success 'refuse to push a hidden ref, and make sure do not pollute t
 
 test_expect_success 'fetch warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c fetch.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=allow fetch https://username:password@localhost 2>err &&
 	! grep "$message" err &&
 
-	test_must_fail git -c fetch.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn fetch https://username:password@localhost 2>err &&
 	grep "warning: $message" err >warnings &&
 	test_line_count = 3 warnings &&
 
-	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:password@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings &&
 
-	test_must_fail git -c fetch.credentialsInUrl=die fetch https://username:@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die fetch https://username:@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
@@ -1855,12 +1855,12 @@ test_expect_success 'fetch warns or fails when using username:password' '
 
 test_expect_success 'push warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c fetch.credentialsInUrl=allow push https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=allow push https://username:password@localhost 2>err &&
 	! grep "$message" err &&
 
-	test_must_fail git -c fetch.credentialsInUrl=warn push https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn push https://username:password@localhost 2>err &&
 	grep "warning: $message" err >warnings &&
-	test_must_fail git -c fetch.credentialsInUrl=die push https://username:password@localhost 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die push https://username:password@localhost 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d2f046b4b92..e6a248bbdcc 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -73,24 +73,24 @@ test_expect_success 'clone respects GIT_WORK_TREE' '
 
 test_expect_success 'clone warns or fails when using username:password' '
 	message="URL '\''https://username:<redacted>@localhost/'\'' uses plaintext credentials" &&
-	test_must_fail git -c fetch.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=allow clone https://username:password@localhost attempt1 2>err &&
 	! grep "$message" err &&
 
-	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username:password@localhost attempt2 2>err &&
 	grep "warning: $message" err >warnings &&
 	test_line_count = 2 warnings &&
 
-	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:password@localhost attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings &&
 
-	test_must_fail git -c fetch.credentialsInUrl=die clone https://username:@localhost attempt3 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=die clone https://username:@localhost attempt3 2>err &&
 	grep "fatal: $message" err >warnings &&
 	test_line_count = 1 warnings
 '
 
 test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
-	test_must_fail git -c fetch.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
+	test_must_fail git -c transfer.credentialsInUrl=warn clone https://username@localhost:8080 attempt3 2>err &&
 	! grep "uses plaintext credentials" err
 '
 
-- 
2.36.1.1239.gfba91521d90

