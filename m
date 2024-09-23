Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D742B19922F
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 12:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093890; cv=none; b=chfOSaPrNL39xK+sKJScroPT+6pmeyBJzoxvnNPNBAbBCaObqCYEgXEDeKHUiuZ6KVkvFX70tmKCLlM48MckgW8J2IIwCE+lAe6QDLGO9SHAI+wEUXMTzGdenAnQffskStz9F/EZ2qLMVhL6AqCHkc1MT/++YdfO93I5vNyvBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093890; c=relaxed/simple;
	bh=8fIRpxUpRyclDoF4Bz/TgegI9enFA66PPwz88UC4zHM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=osSOZm8tIRnWjl1XmROMPTMciX9uuWCrps+aawD0vgsnYHhPWV3Wl2TxLeD3fBZJS0+R+mucaUlf2iM7ibROeaFAB5hEtWjLTbi1KPY2NkgTB1srONcU664vI7kZEwvq6oxRJBVDib3lLvSNZGXvOF4CUP1oYkRtyB9aoiSWk34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGlBhjzt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGlBhjzt"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d3cde1103so296860566b.2
        for <git@vger.kernel.org>; Mon, 23 Sep 2024 05:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093887; x=1727698687; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ym6ewMAA+oVt0gY+7fjWAPeCV+RJ1gZYyUEKaYh2VY=;
        b=JGlBhjzt1I97FDEIoaf/hLus3K3eCMHiV5GxS4mn/bjDt4Ji/Yeq2i8EwtrMeuaC7l
         y6tEEe0X2vcEo/om0OiyfXrLf9Zl6boHrCty8WzEBuvSFv+X9bBEsP+G5x/jxCOllQZj
         wkb9/hPX4U1oSh1t+OEso/SGmKoN9Q45r9Wn1dFKjlGBR/g8W/HiJtSSt0/4PkmUhzTm
         tUNfI63SfiMtLs6yiRBPIxxX8xJpbfIcZ74d+iO/xHrvp4V7/E5OLLLvs22b0rUANi2B
         R1HjxQwUTWpVUJKhE3E70i2hTQLDJl7nQCU9gSCpXTHfvApgacLtbqFKXeOud5uS8sQb
         bCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093887; x=1727698687;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ym6ewMAA+oVt0gY+7fjWAPeCV+RJ1gZYyUEKaYh2VY=;
        b=NrlYjpsyqq0xUwkFRLRXAaWoVcocqAc07W9AEfL21gaJ1N6yk/gimiVvNPWJOjY88p
         xjBOCBzDayuF424ezXTEcltDKEHQKeJTuwvuG8LzxjJlBoWgM2srE+prS74UP3Oau694
         SUcF8ca9qeMfFKkaWzMHF74T2hZPsgK2+sJde1FYUrzBFlXSZXRUScoapSCN1YhUDvoh
         6knT2NAdTkjYRKn7j8zN2FAJ6y3GznacktXHHmC2wm9eUgy1w8qWdogiS7tkRPei5hQV
         k3tNt6xw6RFm4kVFTYch+GWZ2MA+ik/y0qf1QiLUcRk+fKTxdqy9UyMiYjM4vKG3klD9
         6puQ==
X-Gm-Message-State: AOJu0YzZ44K+PH3V2Zin1xFGmtkDD17NBpmtDoTE4JBbpffIu8nlED8I
	Cysn6kUsLjNTwHxJt2nm3YLmDYKPP1jSWC5ydpHwuagFjh/l5f1xA+54gg==
X-Google-Smtp-Source: AGHT+IELEyTXmbs9ihFYVOwoiR+pdUD4+IungcJqNWnHchmA7FLx9OltPwSrreXA+WJ+wIG01TpFew==
X-Received: by 2002:a17:906:d247:b0:a86:ab84:7fc1 with SMTP id a640c23a62f3a-a90d580486cmr1132773566b.50.1727093886570;
        Mon, 23 Sep 2024 05:18:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612b3bbdsm1207664466b.116.2024.09.23.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:18:06 -0700 (PDT)
Message-Id: <a7f3e458501ab22f51269d6e63ceeeb7ea488d91.1727093878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
References: <pull.1776.git.git.1725279236.gitgitgadget@gmail.com>
	<pull.1776.v2.git.git.1727093878.gitgitgadget@gmail.com>
From: "Xing Xin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Sep 2024 12:17:56 +0000
Subject: [PATCH v2 3/5] transport.c::handshake: make use of server options
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
index e22b217fba9..424cdeafcdd 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -304,6 +304,9 @@ endif::git-pull[]
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
index c8947415eec..bcfd4199c87 100644
--- a/transport.c
+++ b/transport.c
@@ -332,6 +332,9 @@ static struct ref *handshake(struct transport *transport, int for_push,
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

