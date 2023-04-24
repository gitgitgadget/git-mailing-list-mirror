Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32862C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 13:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjDXNSB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjDXNR6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 09:17:58 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0555595
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:17:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2f625d52275so4262738f8f.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682342243; x=1684934243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vNwgt7iwCwbjIR949+0oXt7e0Osh5igz9RAzTT6xekU=;
        b=sm6Fab+SAPktx88uAJ6Q89dJsyCHkXnXAZMQDsORg4XXhaIagAmCqK2ovdJzWr/mnC
         GA33sz4MO69+OmqLJVZnzPjy8uvU9gPEYRJ9GY0RbiyLOpsvoN81JbUcAIyxvl7L/tWl
         gH3rbd56Yfackf2ESYvl7cjdfFodRwTkoP1TZsye5DMKr3dv6jk0BAFtz5n3A3cxMOjf
         +9WNSpzd6DrIsu0KLIYP6VBXut51orGC7OA6/WjVLElryqI/+ku6+THyah9DST4lvxpy
         J0RdjcbdzzO9LDBFlr8Awvb4IaqWEovwbn1U5V8GEJU57DsJLHPNX1fcJVAdJzvANrJl
         JJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682342243; x=1684934243;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNwgt7iwCwbjIR949+0oXt7e0Osh5igz9RAzTT6xekU=;
        b=LSciMaYkhfBrCrDlWwqBRdZ39qJYdYnLAi8F1QxXM7uKKmmP+1V8QTCrE2I/Uzhk5u
         G+17cRRy2YnKQskj8amZwcqbxmZ0RUzqhvpSYju2GzeX3xE/yvb4CAe6RhuU90HkQhYL
         GIxUKMsICeKThauawfVKIt9O6JifO2f7B8ZHOh7WtvjrVW2zxJPCSgbLcqZOqKu8vaPJ
         mM/Vk4W7W5LtptwXPVmWRT2x5snZuKAqSg/7Jikn4RUEJ7eE1RyT8LOIJlRIYB0Keos3
         UpUU7CAP9FZ6TMGCqIhsZmTy6eEEzz4aKBeuLL6qFRfTZtPFfdwrXp1Df5iJucTwCpht
         m6Rw==
X-Gm-Message-State: AAQBX9dRbBCLUz5dUnpE5FZGBo2eyjRuQgYzurIrel3UAhyfqC0Hek0S
        V7ORo7QgbUPj6nHzBxhr2xet2sKoQTU=
X-Google-Smtp-Source: AKy350aVcmvxXgMSW5qCJO0iIvlWEWJu8jys5hnmdoXWRBHePe0DS3ohv4ihgSbkH3uNjrI6RlpT2Q==
X-Received: by 2002:adf:fd92:0:b0:303:ba27:4366 with SMTP id d18-20020adffd92000000b00303ba274366mr7838341wrr.49.1682342242898;
        Mon, 24 Apr 2023 06:17:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020a5d674b000000b0030276f42f08sm9487963wrw.88.2023.04.24.06.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:17:22 -0700 (PDT)
Message-Id: <pull.1523.git.1682342241825.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Apr 2023 13:17:21 +0000
Subject: [PATCH] [RFC] transport: add --show-service option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Zeger-Jan van de Weg <zegerjan@gitlab.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Without using protocol v2, the git server needs to send a pktline
"# service=$servicename" to the git client first. This often
requires the git server to implement it independently, but it can
be delegated to the `git receive-pack` and `git upload-pack` to complete
the work proactively. Therefore, the `--show-service` option is added
to `git receive-pack` and `git upload-pack`, which can be used to send
the "# service=$servicename" pktline, making the logic of the git
server more concise.

Note that this `--show-service` option can only be used together with
`--http-backend-info-refs` and it is not applicable when using protocol v2.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [RFC] transport: add --show-service option
    
    When the protocol is not v2, the git client requires that the first
    pktline reply for info refs be "# service=servicename", which requires
    the git server to implement pktline capability, e.g. [1] , which may be
    a bit cumbersome.
    
    Delegating this feature to git upload-pack and git receive-pack via
    "--show-service" can simplify server implementation.
    
    v1. add --show-service to git upload-pack and git receive-pack.
    
    [1]:
    https://gitlab.com/gitlab-org/gitaly/-/blob/master/internal/gitaly/service/smarthttp/inforefs.go#L82

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1523%2Fadlternative%2Fzh%2Finfo-ref-service-output-opt-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1523/adlternative/zh/info-ref-service-output-opt-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1523

 Documentation/git-receive-pack.txt |  10 +++
 Documentation/git-upload-pack.txt  |  13 +++-
 builtin/receive-pack.c             |  14 +++-
 builtin/upload-pack.c              |  17 +++-
 http-backend.c                     |   7 +-
 t/t5555-http-smart-common.sh       | 120 +++++++++++++++++++++++++++++
 6 files changed, 171 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index 65ff518ccff..e16d364f394 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -46,6 +46,16 @@ OPTIONS
 	`$GIT_URL/info/refs?service=git-receive-pack` requests. See
 	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
 
+--show-service::
+	Output the "# service=git-receive-pack" pktline and the
+	"0000" flush pktline firstly. Since the git client needs
+	the git server to send the first pktline
+	"# service=$servicename", this option allows the git
+	server to delegate the functionality of sending this pktline
+	to `git-receive-pack`.
+	Note that this option can only be used together with
+	`--http-backend-info-refs`.
+
 PRE-RECEIVE HOOK
 ----------------
 Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index b656b475675..7052708d03e 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git-upload-pack' [--[no-]strict] [--timeout=<n>] [--stateless-rpc]
-		  [--advertise-refs] <directory>
+		  [--advertise-refs] [--show-service] <directory>
 
 DESCRIPTION
 -----------
@@ -44,6 +44,17 @@ OPTIONS
 	documentation. Also understood by
 	linkgit:git-receive-pack[1].
 
+--show-service::
+	Output the "# service=git-upload-pack" pktline and the
+	"0000" flush pktline firstly. Since the git client needs
+	the git server to send the first pktline
+	"# service=$servicename", this option allows the git
+	server to delegate the functionality of sending this pktline
+	to `git-upload-pack`.
+	Note that this option can only be used together with
+	`--http-backend-info-refs` and it is not applicable when
+	using protocol v2.
+
 <directory>::
 	The repository to sync from.
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9109552533d..eb45c1f72af 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2485,6 +2485,7 @@ static int delete_only(struct command *commands)
 int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 {
 	int advertise_refs = 0;
+	int show_service = 0;
 	struct command *commands;
 	struct oid_array shallow = OID_ARRAY_INIT;
 	struct oid_array ref = OID_ARRAY_INIT;
@@ -2497,8 +2498,10 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs, NULL),
 		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
 		OPT_HIDDEN_BOOL(0, "reject-thin-pack-for-testing", &reject_thin, NULL),
+		OPT_BOOL(0, "show-service", &show_service, N_("show service information")),
 		OPT_END()
 	};
+	enum protocol_version version = determine_protocol_version_server();
 
 	packet_trace_identity("receive-pack");
 
@@ -2525,7 +2528,16 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	else if (0 <= receive_unpack_limit)
 		unpack_limit = receive_unpack_limit;
 
-	switch (determine_protocol_version_server()) {
+	if (show_service) {
+		if (!advertise_refs)
+			die(_("options '%s' and '%s' should be used together"), "--show-service", "--http-backend-info-refs");
+		if (version != protocol_v2) {
+			packet_write_fmt(1, "# service=git-receive-pack\n");
+			packet_flush(1);
+		}
+	}
+
+	switch (version) {
 	case protocol_v2:
 		/*
 		 * push support for protocol v2 has not been implemented yet,
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index beb9dd08610..e84eb3735b4 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -11,7 +11,7 @@
 
 static const char * const upload_pack_usage[] = {
 	N_("git-upload-pack [--[no-]strict] [--timeout=<n>] [--stateless-rpc]\n"
-	   "                [--advertise-refs] <directory>"),
+	   "                [--advertise-refs] [--show-service] <directory>"),
 	NULL
 };
 
@@ -22,6 +22,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	int advertise_refs = 0;
 	int stateless_rpc = 0;
 	int timeout = 0;
+	int show_service = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
 			 N_("quit after a single request/response exchange")),
@@ -32,8 +33,10 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
 		OPT_INTEGER(0, "timeout", &timeout,
 			    N_("interrupt transfer after <n> seconds of inactivity")),
+		OPT_BOOL(0, "show-service", &show_service, N_("show service information")),
 		OPT_END()
 	};
+	enum protocol_version version = determine_protocol_version_server();
 
 	packet_trace_identity("upload-pack");
 	read_replace_refs = 0;
@@ -50,7 +53,17 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
 
-	switch (determine_protocol_version_server()) {
+
+	if (show_service) {
+		if (!advertise_refs)
+			die(_("options '%s' and '%s' should be used together"), "--show-service", "--http-backend-info-refs");
+		if (version != protocol_v2) {
+			packet_write_fmt(1, "# service=git-upload-pack\n");
+			packet_flush(1);
+		}
+	}
+
+	switch (version) {
 	case protocol_v2:
 		if (advertise_refs)
 			protocol_v2_advertise_capabilities();
diff --git a/http-backend.c b/http-backend.c
index 89aad1b42c7..74c2c7bb606 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -539,6 +539,7 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 	if (service_name) {
 		const char *argv[] = {NULL /* service name */,
 			"--http-backend-info-refs",
+			"--show-service",
 			".", NULL};
 		struct rpc_service *svc = select_service(hdr, service_name);
 
@@ -547,12 +548,6 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 		hdr_str(hdr, content_type, buf.buf);
 		end_headers(hdr);
 
-
-		if (determine_protocol_version_server() != protocol_v2) {
-			packet_write_fmt(1, "# service=git-%s\n", svc->name);
-			packet_flush(1);
-		}
-
 		argv[0] = svc->name;
 		run_service(argv, 0);
 
diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
index b1cfe8b7dba..32431266eb9 100755
--- a/t/t5555-http-smart-common.sh
+++ b/t/t5555-http-smart-common.sh
@@ -159,4 +159,124 @@ test_expect_success 'git receive-pack --advertise-refs: v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'git upload-pack --advertise-refs --show-service: v0' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	# service=git-upload-pack
+	0000
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	git upload-pack --advertise-refs --show-service . >out 2>err &&
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect &&
+
+	# With explicit v0
+	GIT_PROTOCOL=version=0 \
+	git upload-pack --advertise-refs --show-service . >out 2>err &&
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+
+'
+
+test_expect_success 'git receive-pack --advertise-refs --show-service: v0' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	# service=git-receive-pack
+	0000
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	git receive-pack --advertise-refs --show-service . >out 2>err &&
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect &&
+
+	# With explicit v0
+	GIT_PROTOCOL=version=0 \
+	git receive-pack --advertise-refs --show-service . >out 2>err &&
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+
+'
+
+test_expect_success 'git upload-pack --advertise-refs --show-service: v1' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	# service=git-upload-pack
+	0000
+	version 1
+	$(git rev-parse HEAD) HEAD
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=1 \
+	git upload-pack --advertise-refs --show-service . >out &&
+
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git receive-pack --advertise-refs --show-service: v1' '
+	# With no specified protocol
+	cat >expect <<-EOF &&
+	# service=git-receive-pack
+	0000
+	version 1
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=1 \
+	git receive-pack --advertise-refs --show-service . >out &&
+
+	test-tool pkt-line unpack <out >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git upload-pack --advertise-refs --show-service: v2' '
+	cat >expect <<-EOF &&
+	version 2
+	agent=FAKE
+	ls-refs=unborn
+	fetch=shallow wait-for-done
+	server-option
+	object-format=$(test_oid algo)
+	object-info
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=2 \
+	GIT_USER_AGENT=FAKE \
+	git upload-pack --advertise-refs --show-service . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
+test_expect_success 'git receive-pack --advertise-refs --show-service: v2' '
+	# There is no v2 yet for receive-pack, implicit v0
+	cat >expect <<-EOF &&
+	$(git rev-parse HEAD) $(git symbolic-ref HEAD)
+	0000
+	EOF
+
+	GIT_PROTOCOL=version=2 \
+	git receive-pack --advertise-refs --show-service . >out 2>err &&
+
+	test-tool pkt-line unpack <out >actual &&
+	test_must_be_empty err &&
+	test_cmp actual expect
+'
+
 test_done

base-commit: 7580f92ffa970b9484ac214f7b53cec5e26ca4bc
-- 
gitgitgadget
