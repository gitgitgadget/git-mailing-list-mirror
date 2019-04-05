Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AFBA20248
	for <e@80x24.org>; Fri,  5 Apr 2019 20:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfDEUoR (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 16:44:17 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:55816 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfDEUoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 16:44:16 -0400
Received: by mail-pf1-f201.google.com with SMTP id e128so3921020pfc.22
        for <git@vger.kernel.org>; Fri, 05 Apr 2019 13:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=n6oFv4nqAdzovMBTjG40b6ioM1OTTF5Bf+i0zFSNWtA=;
        b=a/Oj4olYUi8uyU5Y8iljxCPGKCS0YVRvzj8EZ8Wj+t6WBVz0by6m7cz8zGItTVSBwI
         RGDjZBuY9tLZ5GAe95rvCOxsxefRqalEziKTKwyfNaQhwD4HtohGYC5INYlhbaZtF0Cf
         /UFIR57OnQp1Y5IGDavl87T79RxFfszjKd0BrHHVjScxrsG+O58cYIz/EtK3gxEt+O45
         scYgP0y8FDq2fsoDF65Y6c+eXQmwCP5FnRIJAql7HU+frDj3ec5tU0VZOBTdRB0K8nYw
         qQwckFl9x4+/7/LCrCLYbXbXVlhwVCDAAtCePkLf2za7pZkLxFtsDVEChB3E3vcnPnPS
         DRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=n6oFv4nqAdzovMBTjG40b6ioM1OTTF5Bf+i0zFSNWtA=;
        b=FTVukYm25kIyvWbQKqkwi8EuDQotcLDtCTk+qSt+qhpcDaUd6wrhQ+X9vlcsnNiwDm
         pdb/UI8t6stpz4rrwQYHHZ0au9AAskx7LGiQuRkzxbMBOxMp+mxj/lcD7s5zsoKJ0R3P
         G53kz6ia7z9w2uZ7hFjZVxWpzS1e4A7yMPt196zKcTL1noaDqK9BxQTHGD9p5N82kuGi
         airbvuy22RE/3BadbpMwJozcjrFet9efM/YUMEkpK8zVRurFR7lBFeVhztS7Z5YhYMbX
         OLwgyu7kdK+QN1flVa+WaSqFKIdFBHWy7/uwKcLAHX5WNFfFVEFd3B5/XGnw2SSOn2Mc
         ea7w==
X-Gm-Message-State: APjAAAU+ac/Nl4wIqs3Z/9amVSnpD/93V/KdJn4t1m6ikcCyZw9wKpLl
        Ty3XGxMfEOdk40LvWkINYqEt9I73DNjNW8Yxb1J1JgI4SWOxjl947un0czolIHFGyhS1x+w6dzA
        y4FxUCWX2l8NcjVyS24ijA5JcvVZTbtXR2qD8tkfBMSE1VHzR8NnZndz++1zSPl4utxiDMA85sO
        r+
X-Google-Smtp-Source: APXvYqyMSenGSHq+MpmDZWOMUX8axFqdWLwM8mHZkuU0eIRhGu2iIC7ysG3Daz8I3yI1/X0kZr+FqOZjFjbiNEj6+V/t
X-Received: by 2002:a65:4544:: with SMTP id x4mr395198pgr.106.1554497055621;
 Fri, 05 Apr 2019 13:44:15 -0700 (PDT)
Date:   Fri,  5 Apr 2019 13:44:13 -0700
Message-Id: <20190405204413.93900-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH] clone: send server options when using protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5e3548ef16 ("fetch: send server options when using protocol v2",
2018-04-24) taught "fetch" the ability to send server options when using
protocol v2, but not "clone". This ability is triggered by "-o" or
"--server-option".

Teach "clone" the same ability, except that because "clone" already
has "-o" for another parameter, teach "clone" only to receive
"--server-option".

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-clone.txt |  7 +++++++
 builtin/clone.c             |  6 ++++++
 t/t5702-protocol-v2.sh      | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2fd12524f9..5b79da359c 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -131,6 +131,13 @@ objects from the source repository into a pack in the cloned repository.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
 --no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..625d47c1f4 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -66,6 +66,7 @@ static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
+static struct string_list server_options = STRING_LIST_INIT_DUP;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -137,6 +138,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST(0, "server-option", &server_options, N_("server-specific"),
+			N_("option to transmit")),
 	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 			TRANSPORT_FAMILY_IPV4),
 	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
@@ -1136,6 +1139,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
+	if (server_options.nr)
+		transport->server_options = &server_options;
+
 	if (filter_options.choice) {
 		struct strbuf expanded_filter_spec = STRBUF_INIT;
 		expand_list_objects_filter_spec(&filter_options,
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index e112b6086c..5b28d88401 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -251,6 +251,17 @@ test_expect_success 'server-options are sent when fetching' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'server-options are sent when cloning' '
+	test_when_finished "rm -rf log myclone" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone &&
+
+	grep "server-option=hello" log &&
+	grep "server-option=world" log
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
-- 
2.21.0.392.gf8f6787159e-goog

