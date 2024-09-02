Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A819E987
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279245; cv=none; b=MFBqeTwTCgREPjcvYpPpQ4clByvBT17pCulnhi6SAufhim5AUZVXb2regAxy6C6lAzgl74EhHhpY8Iaui8P19XC+sLtNIWUlVyZBaB1/uKTG+eJkhnd8BWMb0j7KKp1M0X/7WcbZKXUGqiumOlAMimp5n+29yAuAK2aYLMIDyr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279245; c=relaxed/simple;
	bh=JMk8bmWarC/Xir/9EYek8xGN/eMTJQ2KjsWR3nXIDmI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Sh42kKK6eh/+fIsxQZ03E/akLDv/EDy6G8e7usVAAwd9N05b1YzKHVxoeSjd7qEvBp4dRk/2PI+AF62fPE7fHpzcGfgQMxg5Pw8aaO5HyLEGvxoiWYGsa7qg0+sAg2u8C34WMNIplH0YYMw9m40LK/Src5/y/Uck6qcpncMf5xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNVVyv8w; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNVVyv8w"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso3778735a12.0
        for <git@vger.kernel.org>; Mon, 02 Sep 2024 05:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725279241; x=1725884041; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8r8Vk6HVA8pMbObhySRn+AvEUZoqPKFTmyqpuL4jx4=;
        b=YNVVyv8w0JuK7lw/e9pmrVvKw8RH0bM66X+SYET6kBwKshXaF4pHnE++IwU/3/tWYi
         /HPIKQkkk3A+mes3GaDTfSGbI9jfLSe2VYCmdZjsogx2TkeGnNMQ7RU6sobMBDbfispg
         y7y5esurEF9fC9GPAGCLCV9NTXjvhb3qEOHadqCvfSjtwu8A5PcrjCjWVTINTRGDu3dI
         kkknEV5tcDP8RPY/YjtuqLdzelLER3oVgBmiUd8o9ruEz+5amECnhDTQPKDmnUi3MB3p
         LYfK0YWolirIIEh2Wykhq2uB2Re2Vannj8dxWg4Fwxv0IB/nf3ZiPcjJdyAW47Q25BAI
         8fqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279241; x=1725884041;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8r8Vk6HVA8pMbObhySRn+AvEUZoqPKFTmyqpuL4jx4=;
        b=EZcEJSrFBXVY5PFwOJ9Kf1TvPCJzqRf+bnDsjKnb1Dl1HRgs3EaLusn2RtJjVbN6XC
         d3Bb4gq4WFL3Blgd7LmO4Xti2jdMyuxVpZqsjs/0jR7mfMvHU52/HQGBbW8CESHb48nJ
         IkCkM6T2siBsMxJSLHNO+8x0qNvop6iNMRAbymVLvLjhJ+Rsp3Doktvd71XaExZsNzxn
         xWDp3FLRpwz7icYypf+R3Ha02L/E2ZFoQFM8lnGkTmzhLHzeBpz/3zU8l7D+qI+/ooUg
         qQkfn1kQnqwQ02//enri2RnQq5tNqMOFxL4mGQZSRfL5axZt896H6rz1XaFWSJqkHEcr
         +eRg==
X-Gm-Message-State: AOJu0YwPbH7JB5/4HjeSQu3jM/yGaLdqugdoxvj06t8fFvRQu/13s7CF
	zN2Sl06Etk/s7kOTlKvc94jEJ0Ru7pd1g9KZIJuwTi4AkjTamhzp6LCVqg==
X-Google-Smtp-Source: AGHT+IFGE70ZI20eCi7M6g0G2ZDY2HxKAqeadLoBX8uTzypfx5lHgRhxtdL32yTedrT8CIL2Q9ZDLw==
X-Received: by 2002:a17:907:96a4:b0:a77:dbf9:118f with SMTP id a640c23a62f3a-a89823c9e58mr1222782166b.13.1725279240845;
        Mon, 02 Sep 2024 05:14:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d71b4sm552126866b.160.2024.09.02.05.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 05:14:00 -0700 (PDT)
Message-Id: <7c3ebda513d872a2ab2aa0cff5887757de4cde0a.1725279236.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Sep 2024 12:13:55 +0000
Subject: [PATCH 3/4] builtin/clone.c: recognize fetch.serverOption
 configuration
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
    Jonathan Tan <jonathantanmy@google.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Teach git-clone to recognize the `fetch.serverOption` configuration as a
default list of server options to send for Git protocol v2, if server
options are not explicitly set via the command line.

Note that `builtin/clone.c:cmd_clone` originally read the git config
twice via `builtin/clone.c:git_clone_config`, which would duplicate
server options if parsing logic were added there. Upon investigation, it
was found that the first config read is unnecessary since all the global
variables it sets are actually used after the second config read.
Therefore, the first config read is replaced with a simple
`config.c:git_default_config`.

Tests and documentation have been updated accordingly.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 Documentation/git-clone.txt |  3 +++
 builtin/clone.c             | 22 ++++++++++++++++------
 t/t5702-protocol-v2.sh      | 22 ++++++++++++++++++++--
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8e925db7e9c..105645ed685 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -149,6 +149,9 @@ objects from the source repository into a pack in the cloned repository.
 	unknown ones, is server-specific.
 	When multiple ++--server-option=++__<option>__ are given, they are all
 	sent to the other side in the order listed on the command line.
+	When no ++--server-option=++__<option>__ is given from the command
+	line, the values of configuration variable `fetch.serverOption`
+	are used instead.
 
 `-n`::
 `--no-checkout`::
diff --git a/builtin/clone.c b/builtin/clone.c
index 269b6e18a4e..5a1e2e769af 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -85,7 +85,8 @@ static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options = LIST_OBJECTS_FILTER_INIT;
 static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
-static struct string_list server_options = STRING_LIST_INIT_NODUP;
+static struct string_list config_server_options = STRING_LIST_INIT_DUP;
+static struct string_list option_server_options = STRING_LIST_INIT_DUP;
 static int option_remote_submodules;
 static const char *bundle_uri;
 
@@ -160,7 +161,7 @@ static struct option builtin_clone_options[] = {
 		   N_("specify the reference format to use")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
-	OPT_STRING_LIST(0, "server-option", &server_options,
+	OPT_STRING_LIST(0, "server-option", &option_server_options,
 			N_("server-specific"), N_("option to transmit")),
 	OPT_IPVERSION(&family),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -847,6 +848,12 @@ static int git_clone_config(const char *k, const char *v,
 		config_reject_shallow = git_config_bool(k, v);
 	if (!strcmp(k, "clone.filtersubmodules"))
 		config_filter_submodules = git_config_bool(k, v);
+	if (!strcmp(k, "fetch.serveroption")) {
+		if (!v)
+			return config_error_nonbool(k);
+		parse_transport_option(v, &config_server_options);
+		return 0;
+	}
 
 	return git_default_config(k, v, ctx, cb);
 }
@@ -982,17 +989,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int hash_algo;
 	enum ref_storage_format ref_storage_format = REF_STORAGE_FORMAT_UNKNOWN;
 	const int do_not_override_repo_unix_permissions = -1;
-
+	struct string_list *server_options = NULL;
 	struct transport_ls_refs_options transport_ls_refs_options =
 		TRANSPORT_LS_REFS_OPTIONS_INIT;
 
 	packet_trace_identity("clone");
 
-	git_config(git_clone_config, NULL);
+	git_config(git_default_config, NULL);
 
 	argc = parse_options(argc, argv, prefix, builtin_clone_options,
 			     builtin_clone_usage, 0);
 
+	server_options = option_server_options.nr ?
+			 &option_server_options : &config_server_options;
+
 	if (argc > 2)
 		usage_msg_opt(_("Too many arguments."),
 			builtin_clone_usage, builtin_clone_options);
@@ -1359,8 +1369,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
-	if (server_options.nr)
-		transport->server_options = &server_options;
+	if (server_options && server_options->nr)
+		transport->server_options = server_options;
 
 	if (filter_options.choice) {
 		const char *spec =
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index ae25400010e..3bf31fb570d 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -424,12 +424,30 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 test_expect_success 'server-options are sent when cloning' '
 	test_when_finished "rm -rf log myclone" &&
 
+	# Specify server options from command line
 	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
 		clone --server-option=hello --server-option=world \
 		"file://$(pwd)/file_parent" myclone &&
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log &&
+	rm -rf log myclone &&
 
-	grep "server-option=hello" log &&
-	grep "server-option=world" log
+	# Specify server options from fetch.serverOption config
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		clone "file://$(pwd)/file_parent" myclone &&
+	test_grep "server-option=hello" log &&
+	test_grep "server-option=world" log &&
+	rm -rf log myclone &&
+
+	# Cmdline server options take a higher priority
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c fetch.serverOption=hello -c fetch.serverOption=world \
+		clone --server-option=foo=bar \
+		"file://$(pwd)/file_parent" myclone &&
+	test_grep ! "server-option=hello" log &&
+	test_grep ! "server-option=world" log &&
+	test_grep "server-option=foo=bar" log
 '
 
 test_expect_success 'warn if using server-option with clone with legacy protocol' '
-- 
gitgitgadget

