Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F18842ABE
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 03:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358708; cv=none; b=nuFhC/Rr6QG76TLC2EuwlgQEfAhlKnZ6mRi4TqlbjNdmjljN8lJIoD24QmhuSXDWyEwrSv/Bet9OhAWOwfIPxTjYozjw44Rp8gLMUeyeqCUpvyvJ1cE5/irAYb9Hz3tqdhVeGiGz/sFyHnp8MiXOM1mZjrallKOQLhSMkS1j9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358708; c=relaxed/simple;
	bh=Rz/vK5uPmBZP+UYNuATM4PM7IXEU61ODpbFt0yViP6w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I83dQlso6Lporq5CEUQuWQuWXRGHdO2sdfLaubHTcXJmfbxcbev9W4t/AEkrHqubEAxB/M+ZcQvtitGnAHIWqO5a0unlStzsJ6BFmTZYqGWmTfzSHSsSqye05ugRP/oz7a+jCn/pYZ+KXvgPjXfRP4aMO/UsEct4w1zyWFlGHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8aJJ6q8; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8aJJ6q8"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c88b5c375fso6322897a12.3
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 20:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728358704; x=1728963504; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGV5V522FCK2dLh6Pcq7jJpa3WeLc5JhyQxpM0hZSYI=;
        b=I8aJJ6q8P9s8URqr8uqMslJ1BHl7ZsPjalbFzTIvm89xT0kbawCo1exG4cbf2yBnXI
         vIKk0RbWBCrG/hKp18QUmAnH4DRz9Y6uvrtBdTIMtCL/Lo/ePk9DdlHuQhlOHzHtO8Ik
         2RstjzsTK48SqROKENTZjDBUkAccvqT3Bh4afZMnW4Jv51op4E75XRHtjX3k/CP7QVV5
         b//fbxqKFL2yM/Gv2YNTnmjJIDMpxehOnUYxhK05lfas73OA1qAp/WbcQBGitrmm1D0x
         FP1q5edI9c2IK0XFiAJQe4QL+sM3ednk2HH+IZY60J0TRXhzK/AX+WJIrusmh/Tj2uwf
         v14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358704; x=1728963504;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGV5V522FCK2dLh6Pcq7jJpa3WeLc5JhyQxpM0hZSYI=;
        b=fnrWVvIY4fWnOF/gBc3KppBLlMhF86LsoRA5j9E+4PXwBCNvCe5IKXwCosfEXvIlMV
         QIYjSsC5D5kpIb3O0a1dLZ7W//C7nFlmZXcDtJc2V4H55zAgjj+LQ+uiYeYextqOJoVc
         wRaVifZ0AR0OBK6Cuk7KU7j8L+yMjPjJw786Dz0UN8K2bljcm2TiJ1TkmA2HzC3D+EPB
         VAGdAroTsjUPXnGpQ1DJglyb5O7ysZIgA2bls3YpDfWrUfePp+DyG3rsk6nh4usHmiBW
         oQ1QfkEHrE3RYtsQZ1me3TwmS4ldNZNEsyeP2dQXHmtiSakjDOwL2Dnd14Z04JgtQsjh
         zIKg==
X-Gm-Message-State: AOJu0Yx1CXPyifmrSSHrq/a5nxknY0X27AQSYZhDG26EXEwLM7797LHM
	+ZdRkI5s+mQeeNMbe6ujDQ7FkWBQl8A5K1Y+32zkKNYa6U6fc9y3yKFHMg==
X-Google-Smtp-Source: AGHT+IEyg7BhPyb4qp4Ni6Hw102sLFTRkQbVW/l1gEEjFDBBAwW6sSfBkc+J+y+V07OzhAQruEGGZA==
X-Received: by 2002:a17:907:6093:b0:a99:4136:895f with SMTP id a640c23a62f3a-a99413696a0mr987427866b.41.1728358703625;
        Mon, 07 Oct 2024 20:38:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5d0a32sm460037466b.19.2024.10.07.20.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:38:23 -0700 (PDT)
Message-Id: <f0835259b06aed6130e6ee7c5dc37cfebdc77393.1728358699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
References: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
	<pull.1776.v3.git.git.1728358699.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 03:38:17 +0000
Subject: [PATCH v3 3/5] transport.c::handshake: make use of server options
 from remote
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
    Patrick Steinhardt <ps@pks.im>,
    Liu Zhongbo <liuzhongbo.6666@bytedance.com>,
    blanet <bupt_xingxin@163.com>,
    Xing Xin <xingxin.xx@bytedance.com>

From: Xing Xin <xingxin.xx@bytedance.com>

Utilize the `server_options` from the corresponding remote during the
handshake in `transport.c` when Git protocol v2 is detected. This helps
initialize the `server_options` in `transport.h:transport` if no server
options are set for the transport (typically via `--server-option` or
`-o`).

While another potential place to incorporate server options from the
remote is in `transport.c:transport_get`, setting server options for a
transport using a protocol other than v2 could lead to unexpected errors
(see `transport.c:die_if_server_options`).

Relevant tests and documentation have been updated accordingly.

Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
---
 Documentation/fetch-options.txt |   3 +
 Documentation/git-clone.txt     |   3 +
 Documentation/git-ls-remote.txt |   3 +
 t/t5702-protocol-v2.sh          | 123 ++++++++++++++++++++++++++++++++
 transport.c                     |   3 +
 5 files changed, 135 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 80838fe37ef..9dc7ac8dbdc 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -305,6 +305,9 @@ endif::git-pull[]
 	unknown ones, is server-specific.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
+	When no `--server-option=<option>` is given from the command line,
+	the values of configuration variable `remote.<name>.serverOption`
+	are used instead.
 
 --show-forced-updates::
 	By default, git checks if a branch is force-updated during
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8e925db7e9c..409fb3a3af6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -149,6 +149,9 @@ objects from the source repository into a pack in the cloned repository.
 	unknown ones, is server-specific.
 	When multiple ++--server-option=++__<option>__ are given, they are all
 	sent to the other side in the order listed on the command line.
+	When no ++--server-option=++__<option>__ is given from the command
+	line, the values of configuration variable `remote.<name>.serverOption`
+	are used instead.
 
 `-n`::
 `--no-checkout`::
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 76c86c3ce4f..d71c4ab3e29 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -81,6 +81,9 @@ OPTIONS
 	character.
 	When multiple `--server-option=<option>` are given, they are all
 	sent to the other side in the order listed on the command line.
+	When no `--server-option=<option>` is given from the command line,
+	the values of configuration variable `remote.<name>.serverOption`
+	are used instead.
 
 <repository>::
 	The "remote" repository to query.  This parameter can be
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 1ef540f73d3..5cec2061d28 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -185,6 +185,43 @@ test_expect_success 'server-options are sent when using ls-remote' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'server-options from configuration are used by ls-remote' '
+	test_when_finished "rm -rf log myclone" &&
+	git clone "file://$(pwd)/file_parent" myclone &&
+	cat >expect <<-EOF &&
+	$(git -C file_parent rev-parse refs/heads/main)$(printf "\t")refs/heads/main
+	EOF
+
+	# Default server options from configuration are used
+	git -C myclone config --add remote.origin.serverOption foo &&
+	git -C myclone config --add remote.origin.serverOption bar &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
+		ls-remote origin main >actual &&
+	test_cmp expect actual &&
+	test_grep "ls-remote> server-option=foo" log &&
+	test_grep "ls-remote> server-option=bar" log &&
+	rm -f log &&
+
+	# Empty value of remote.<name>.serverOption clears the list
+	git -C myclone config --add remote.origin.serverOption "" &&
+	git -C myclone config --add remote.origin.serverOption tar &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
+		ls-remote origin main >actual &&
+	test_cmp expect actual &&
+	test_grep "ls-remote> server-option=tar" log &&
+	test_grep ! "ls-remote> server-option=foo" log &&
+	test_grep ! "ls-remote> server-option=bar" log &&
+	rm -f log &&
+
+	# Server option from command line overrides those from configuration
+	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
+		ls-remote -o hello -o world origin main >actual &&
+	test_cmp expect actual &&
+	test_grep "ls-remote> server-option=hello" log &&
+	test_grep "ls-remote> server-option=world" log &&
+	test_grep ! "ls-remote> server-option=tar" log
+'
+
 test_expect_success 'warn if using server-option with ls-remote with legacy protocol' '
 	test_must_fail env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
 		ls-remote -o hello -o world "file://$(pwd)/file_parent" main 2>err &&
@@ -381,6 +418,44 @@ test_expect_success 'server-options are sent when fetching' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'server-options from configuration are used by git-fetch' '
+	test_when_finished "rm -rf log myclone" &&
+	git clone "file://$(pwd)/file_parent" myclone &&
+	git -C file_parent log -1 --format=%s >expect &&
+
+	# Default server options from configuration are used
+	git -C myclone config --add remote.origin.serverOption foo &&
+	git -C myclone config --add remote.origin.serverOption bar &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
+		fetch origin main &&
+	git -C myclone log -1 --format=%s origin/main >actual &&
+	test_cmp expect actual &&
+	test_grep "fetch> server-option=foo" log &&
+	test_grep "fetch> server-option=bar" log &&
+	rm -f log &&
+
+	# Empty value of remote.<name>.serverOption clears the list
+	git -C myclone config --add remote.origin.serverOption "" &&
+	git -C myclone config --add remote.origin.serverOption tar &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
+		fetch origin main &&
+	git -C myclone log -1 --format=%s origin/main >actual &&
+	test_cmp expect actual &&
+	test_grep "fetch> server-option=tar" log &&
+	test_grep ! "fetch> server-option=foo" log &&
+	test_grep ! "fetch> server-option=bar" log &&
+	rm -f log &&
+
+	# Server option from command line overrides those from configuration
+	GIT_TRACE_PACKET="$(pwd)/log" git -C myclone -c protocol.version=2 \
+		fetch -o hello -o world origin main &&
+	git -C myclone log -1 --format=%s origin/main >actual &&
+	test_cmp expect actual &&
+	test_grep "fetch> server-option=hello" log &&
+	test_grep "fetch> server-option=world" log &&
+	test_grep ! "fetch> server-option=tar" log
+'
+
 test_expect_success 'warn if using server-option with fetch with legacy protocol' '
 	test_when_finished "rm -rf temp_child" &&
 
@@ -404,6 +479,37 @@ test_expect_success 'server-options are sent when cloning' '
 	grep "server-option=world" log
 '
 
+test_expect_success 'server-options from configuration are used by git-clone' '
+	test_when_finished "rm -rf log myclone" &&
+
+	# Default server options from configuration are used
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c remote.origin.serverOption=foo -c remote.origin.serverOption=bar \
+		clone "file://$(pwd)/file_parent" myclone &&
+	test_grep "clone> server-option=foo" log &&
+	test_grep "clone> server-option=bar" log &&
+	rm -rf log myclone &&
+
+	# Empty value of remote.<name>.serverOption clears the list
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c remote.origin.serverOption=foo -c remote.origin.serverOption=bar \
+		-c remote.origin.serverOption= -c remote.origin.serverOption=tar \
+		clone "file://$(pwd)/file_parent" myclone &&
+	test_grep "clone> server-option=tar" log &&
+	test_grep ! "clone> server-option=foo" log &&
+	test_grep ! "clone> server-option=bar" log &&
+	rm -rf log myclone &&
+
+	# Server option from command line overrides those from configuration
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		-c remote.origin.serverOption=tar \
+		clone --server-option=hello --server-option=world \
+		"file://$(pwd)/file_parent" myclone &&
+	test_grep "clone> server-option=hello" log &&
+	test_grep "clone> server-option=world" log &&
+	test_grep ! "clone> server-option=tar" log
+'
+
 test_expect_success 'warn if using server-option with clone with legacy protocol' '
 	test_when_finished "rm -rf myclone" &&
 
@@ -415,6 +521,23 @@ test_expect_success 'warn if using server-option with clone with legacy protocol
 	test_grep "server options require protocol version 2 or later" err
 '
 
+test_expect_success 'server-option configuration with legacy protocol is ok' '
+	test_when_finished "rm -rf myclone" &&
+
+	env GIT_TEST_PROTOCOL_VERSION=0 git -c protocol.version=0 \
+		-c remote.origin.serverOption=foo -c remote.origin.serverOption=bar \
+		clone "file://$(pwd)/file_parent" myclone
+'
+
+test_expect_success 'invalid server-option configuration' '
+	test_when_finished "rm -rf myclone" &&
+
+	test_must_fail git -c protocol.version=2 \
+		-c remote.origin.serverOption \
+		clone "file://$(pwd)/file_parent" myclone 2>err &&
+	test_grep "error: missing value for '\''remote.origin.serveroption'\''" err
+'
+
 test_expect_success 'upload-pack respects config using protocol v2' '
 	git init server &&
 	write_script server/.git/hook <<-\EOF &&
diff --git a/transport.c b/transport.c
index 4d9e605b273..b416fc84567 100644
--- a/transport.c
+++ b/transport.c
@@ -334,6 +334,9 @@ static struct ref *handshake(struct transport *transport, int for_push,
 	data->version = discover_version(&reader);
 	switch (data->version) {
 	case protocol_v2:
+		if ((!transport->server_options || !transport->server_options->nr) &&
+		    transport->remote->server_options.nr)
+			transport->server_options = &transport->remote->server_options;
 		if (server_feature_v2("session-id", &server_sid))
 			trace2_data_string("transfer", NULL, "server-sid", server_sid);
 		if (must_list_refs)
-- 
gitgitgadget

