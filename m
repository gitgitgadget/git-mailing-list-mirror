Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9F020248
	for <e@80x24.org>; Thu, 11 Apr 2019 20:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDKUa0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 16:30:26 -0400
Received: from mail-oi1-f202.google.com ([209.85.167.202]:43465 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfDKUaZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 16:30:25 -0400
Received: by mail-oi1-f202.google.com with SMTP id u10so3437560oie.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 13:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zN/yXJBnLA+2itMrWSSUERUXbXTQwHjdgXLrjjZpfSM=;
        b=uNJylTwTN1gofTWSOzraUwAq/d68YZjD0lEWJ06EBCfC9gdnnSORbb4luORoOINM2L
         8YFZ7JD2R2y9+YcQnK2Cj/iQ3dud/i3ttSYTTMZqqRYsPBsCTsiZcDfw0K+JDtaDILuc
         4SA53pndcFzKv+EZt6eYDYa+G6mchwxpKZn06PW5QAQQnG22x5eQvogBoa8NM0cUw/8C
         7sRZSJYWV14TssvpTo07S+bdqfmbvWEAq43+WVOSnfGIsH6wSw8cG20wnnyrYwTwK/JD
         nGFCOZTfGrYu3cuqnCOPu2UNiFwE9yzvH0e0/Zsux/ootVabE9+CEB6P3imCYQfvltZd
         1PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zN/yXJBnLA+2itMrWSSUERUXbXTQwHjdgXLrjjZpfSM=;
        b=FE8jItY1JHsKMTV0vUjwnzcmMo11/HYO3pKhVbsyPxMX75rCgYW4uBXtpRnPiyUpQa
         8xkLf6QiUBlCRqPa0aKRhJQKGE6euAn6dCIfVFy34ASliLnEO1ljG5EzgqBNYkQuxr4k
         y5bgU6CtG0EDB2ObRiaqo8LgMCaIYMkhTyKqDJqVGEVT/3hsOet8BNtntsHkKoz5aoqk
         VF02BurXw+ZgAZAX8Ys3c5nC/JrByTTeL4Gd5f4mYebGKUohOBmAs8/amAsEuBc806RE
         StY6dBRUUG6FFXZXgR8XYzdF0Sf1lo6H1gqIkjSnZMCHHumKlG+ryU6TDMOq1SYDXL/6
         zBNg==
X-Gm-Message-State: APjAAAV+XeniDJOxin2EaSB2bGobsIZcfWYm/Uft6PhdbWZTTmezypU/
        E/eZDzOX40p6HqoWD3/fjXAy1NWmPW8vzKrmWgjgM8OI45kYz4ZFBwgjYS12q++nzyktRKn1m6m
        Ah48LlWGn8TzSK6eBAAHf+GhiJghbVCKQrZCLaquBPsTLHl2NPdhEoHwESAfwV7nNaZxnuDpiI8
        r7
X-Google-Smtp-Source: APXvYqzrsgStzEcNpEqqfZBq/3ij3cXCrwODUmnmhFoFQ/w5nrV3P3WgkMFTAI4wBon28jJek+Eqcyj9+9ts3V4Zk4Zo
X-Received: by 2002:aca:b887:: with SMTP id i129mr4433158oif.47.1555014624182;
 Thu, 11 Apr 2019 13:30:24 -0700 (PDT)
Date:   Thu, 11 Apr 2019 13:30:16 -0700
In-Reply-To: <cover.1555014408.git.jonathantanmy@google.com>
Message-Id: <f59b8244eb3cf75ceeb21f52a6679a5fb3b96fd1.1555014408.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190405204413.93900-1-jonathantanmy@google.com> <cover.1555014408.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: [PATCH v3 2/2] clone: send server options when using protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
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

Explain in the documentation, both for clone and for fetch, that server
handling of server options are server-specific. This is similar to
receive-pack's handling of push options - currently, they are just sent
to hooks to interpret as they see fit.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/fetch-options.txt |  3 ++-
 Documentation/git-clone.txt     |  8 ++++++++
 builtin/clone.c                 |  6 ++++++
 t/t5702-protocol-v2.sh          | 22 ++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fa0a3151b3..91c47752ec 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -216,7 +216,8 @@ endif::git-pull[]
 --server-option=<option>::
 	Transmit the given string to the server when communicating using
 	protocol version 2.  The given string must not contain a NUL or LF
-	character.
+	character.  The server's handling of server options, including
+	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
 
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2fd12524f9..a0f14b51f2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -131,6 +131,14 @@ objects from the source repository into a pack in the cloned repository.
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
 
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.  The server's handling of server options, including
+	unknown ones, is server-specific.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
 --no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..31a47d190a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -66,6 +66,7 @@ static int option_dissociate;
 static int max_jobs = -1;
 static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
 static struct list_objects_filter_options filter_options;
+static struct string_list server_options = STRING_LIST_INIT_NODUP;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -137,6 +138,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_STRING_LIST(0, "server-option", &server_options,
+			N_("server-specific"), N_("option to transmit")),
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
index 7ddcf26e76..b8d5264a45 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -270,6 +270,28 @@ test_expect_success 'warn if using server-option with fetch with legacy protocol
 	grep "server options require protocol version 2 or later" err
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
+test_expect_success 'warn if using server-option with clone with legacy protocol' '
+	test_when_finished "rm -rf myclone" &&
+
+	GIT_TEST_PROTOCOL_VERSION=0 test_must_fail git -c protocol.version=0 \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone 2>err &&
+
+	grep "see protocol.version in" err &&
+	grep "server options require protocol version 2 or later" err
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
-- 
2.21.0.392.gf8f6787159e-goog

