Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A736C2BA83
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE03220870
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKLlBlln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJAbH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:07 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:43663 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgBJAbG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:06 -0500
Received: by mail-wr1-f42.google.com with SMTP id r11so2170009wrq.10
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1mruV75BuyqHbf9Wo/qpeJ/Mb/qxxHMqo4hZ10iHC5M=;
        b=FKLlBlln1alXjCXxkOr1AtMGufheP/ri1fQKG0hV49vuLsghYlkpU05B3S/4wwE8oc
         CmLFniwMw+tYX1J72svMjpRd32VZWk0mglAiTGrTziktkwV4kMdmHxjn2OMLcdNiMBDl
         J9s6imUrChHqCvC1LtyxJ1o0slhfGe5qqo/3UUShFSVGSgKylzDftIX5GW3ByCTWqGnV
         yvQS1e3hm4o7AJqH59UXKLzljUhsKi03RZg0Wtov2aKAryktytAsjT3n6/RY0986t8Za
         Gj+sYZAm06H1+aicAAMGAbTNoRT1flVqQLwg1JFm7yP7NL/5x0lLNHzv9fbjoJKanyT3
         49FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1mruV75BuyqHbf9Wo/qpeJ/Mb/qxxHMqo4hZ10iHC5M=;
        b=b8p63RGIKn3Mys0FMsVEisZtYpVXQ8AyCAX4kYRJk7dAUrwxAFAJ3kI72Ykdbw6/Sq
         5a72hg1zYGYHlexJB8j2Dd9OgbfEzm/ZdgjRAUcL1Y8cF8xXS2o+rZQl/JUwaALdGfPv
         rnluhDnDLAhnDGctbqr1jhNcxqyFYzQrDKaEs1m+7Dkvg4UjQ6mJmKHFsXjJ8CUphG/+
         TGtfl3gwMlMdpHxs0nNYqDcTUdTdA6u5pQqZ3btXQaJHRWsKQls9RJunIiUeZFzkjumV
         PkNzKFeej1BI8Jqyb3cP9MIC/5vr5bCeSEi/LxK1kldra73U/VQZK73Gql6P0PCWfHFH
         vLMQ==
X-Gm-Message-State: APjAAAWeDDdEXnx4GNQqyu7wiZnsKTSVo/yVZSJy0rK9HV7FlBaJe01j
        zVx9fV455xVgmD9wLaAND0KBnXZz
X-Google-Smtp-Source: APXvYqxUD3bK17WCiDIgCGAOSFgNmrTXtUCu5aVLErDQnZ2+e6iAm9S23fyYnqsqmlaXuIOKkyJisw==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr10354443wrt.322.1581294663306;
        Sun, 09 Feb 2020 16:31:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c74sm13825668wmd.26.2020.02.09.16.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:02 -0800 (PST)
Message-Id: <2c38c72f898bff2b5d552ce25f4593622f4b6c8e.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:51 +0000
Subject: [PATCH v7 02/10] t1300: fix over-indented HERE-DOCs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Prepare for the following patches by removing extraneous indents from
HERE-DOCs used in config tests.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1300-config.sh | 168 +++++++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 983a0a1583..e8b4575758 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1191,47 +1191,47 @@ test_expect_success 'old-fashioned settings are case insensitive' '
 	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
 
 	cat >testConfig_actual <<-EOF &&
-		[V.A]
-		r = value1
+	[V.A]
+	r = value1
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
-		[V.A]
-		Qr = value2
+	[V.A]
+	Qr = value2
 	EOF
 	git config -f testConfig_actual "v.a.r" value2 &&
 	test_cmp testConfig_expect testConfig_actual &&
 
 	cat >testConfig_actual <<-EOF &&
-		[V.A]
-		r = value1
+	[V.A]
+	r = value1
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
-		[V.A]
-		QR = value2
+	[V.A]
+	QR = value2
 	EOF
 	git config -f testConfig_actual "V.a.R" value2 &&
 	test_cmp testConfig_expect testConfig_actual &&
 
 	cat >testConfig_actual <<-EOF &&
-		[V.A]
-		r = value1
+	[V.A]
+	r = value1
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
-		[V.A]
-		r = value1
-		Qr = value2
+	[V.A]
+	r = value1
+	Qr = value2
 	EOF
 	git config -f testConfig_actual "V.A.r" value2 &&
 	test_cmp testConfig_expect testConfig_actual &&
 
 	cat >testConfig_actual <<-EOF &&
-		[V.A]
-		r = value1
+	[V.A]
+	r = value1
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
-		[V.A]
-		r = value1
-		Qr = value2
+	[V.A]
+	r = value1
+	Qr = value2
 	EOF
 	git config -f testConfig_actual "v.A.r" value2 &&
 	test_cmp testConfig_expect testConfig_actual
@@ -1241,26 +1241,26 @@ test_expect_success 'setting different case sensitive subsections ' '
 	test_when_finished "rm -f testConfig testConfig_expect testConfig_actual" &&
 
 	cat >testConfig_actual <<-EOF &&
-		[V "A"]
-		R = v1
-		[K "E"]
-		Y = v1
-		[a "b"]
-		c = v1
-		[d "e"]
-		f = v1
+	[V "A"]
+	R = v1
+	[K "E"]
+	Y = v1
+	[a "b"]
+	c = v1
+	[d "e"]
+	f = v1
 	EOF
 	q_to_tab >testConfig_expect <<-EOF &&
-		[V "A"]
-		Qr = v2
-		[K "E"]
-		Qy = v2
-		[a "b"]
-		Qc = v2
-		[d "e"]
-		f = v1
-		[d "E"]
-		Qf = v2
+	[V "A"]
+	Qr = v2
+	[K "E"]
+	Qy = v2
+	[a "b"]
+	Qc = v2
+	[d "e"]
+	f = v1
+	[d "E"]
+	Qf = v2
 	EOF
 	# exact match
 	git config -f testConfig_actual a.b.c v2 &&
@@ -1622,40 +1622,40 @@ test_expect_success 'set up --show-origin tests' '
 	INCLUDE_DIR="$HOME/include" &&
 	mkdir -p "$INCLUDE_DIR" &&
 	cat >"$INCLUDE_DIR"/absolute.include <<-\EOF &&
-		[user]
-			absolute = include
+	[user]
+		absolute = include
 	EOF
 	cat >"$INCLUDE_DIR"/relative.include <<-\EOF &&
-		[user]
-			relative = include
+	[user]
+		relative = include
 	EOF
 	cat >"$HOME"/.gitconfig <<-EOF &&
-		[user]
-			global = true
-			override = global
-		[include]
-			path = "$INCLUDE_DIR/absolute.include"
+	[user]
+		global = true
+		override = global
+	[include]
+		path = "$INCLUDE_DIR/absolute.include"
 	EOF
 	cat >.git/config <<-\EOF
-		[user]
-			local = true
-			override = local
-		[include]
-			path = ../include/relative.include
+	[user]
+		local = true
+		override = local
+	[include]
+		path = ../include/relative.include
 	EOF
 '
 
 test_expect_success '--show-origin with --list' '
 	cat >expect <<-EOF &&
-		file:$HOME/.gitconfig	user.global=true
-		file:$HOME/.gitconfig	user.override=global
-		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
-		file:$INCLUDE_DIR/absolute.include	user.absolute=include
-		file:.git/config	user.local=true
-		file:.git/config	user.override=local
-		file:.git/config	include.path=../include/relative.include
-		file:.git/../include/relative.include	user.relative=include
-		command line:	user.cmdline=true
+	file:$HOME/.gitconfig	user.global=true
+	file:$HOME/.gitconfig	user.override=global
+	file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
+	file:$INCLUDE_DIR/absolute.include	user.absolute=include
+	file:.git/config	user.local=true
+	file:.git/config	user.override=local
+	file:.git/config	include.path=../include/relative.include
+	file:.git/../include/relative.include	user.relative=include
+	command line:	user.cmdline=true
 	EOF
 	git -c user.cmdline=true config --list --show-origin >output &&
 	test_cmp expect output
@@ -1663,16 +1663,16 @@ test_expect_success '--show-origin with --list' '
 
 test_expect_success '--show-origin with --list --null' '
 	cat >expect <<-EOF &&
-		file:$HOME/.gitconfigQuser.global
-		trueQfile:$HOME/.gitconfigQuser.override
-		globalQfile:$HOME/.gitconfigQinclude.path
-		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
-		includeQfile:.git/configQuser.local
-		trueQfile:.git/configQuser.override
-		localQfile:.git/configQinclude.path
-		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
-		includeQcommand line:Quser.cmdline
-		trueQ
+	file:$HOME/.gitconfigQuser.global
+	trueQfile:$HOME/.gitconfigQuser.override
+	globalQfile:$HOME/.gitconfigQinclude.path
+	$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
+	includeQfile:.git/configQuser.local
+	trueQfile:.git/configQuser.override
+	localQfile:.git/configQinclude.path
+	../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
+	includeQcommand line:Quser.cmdline
+	trueQ
 	EOF
 	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
 	nul_to_q <output.raw >output &&
@@ -1684,9 +1684,9 @@ test_expect_success '--show-origin with --list --null' '
 
 test_expect_success '--show-origin with single file' '
 	cat >expect <<-\EOF &&
-		file:.git/config	user.local=true
-		file:.git/config	user.override=local
-		file:.git/config	include.path=../include/relative.include
+	file:.git/config	user.local=true
+	file:.git/config	user.override=local
+	file:.git/config	include.path=../include/relative.include
 	EOF
 	git config --local --list --show-origin >output &&
 	test_cmp expect output
@@ -1694,8 +1694,8 @@ test_expect_success '--show-origin with single file' '
 
 test_expect_success '--show-origin with --get-regexp' '
 	cat >expect <<-EOF &&
-		file:$HOME/.gitconfig	user.global true
-		file:.git/config	user.local true
+	file:$HOME/.gitconfig	user.global true
+	file:.git/config	user.local true
 	EOF
 	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
 	test_cmp expect output
@@ -1703,7 +1703,7 @@ test_expect_success '--show-origin with --get-regexp' '
 
 test_expect_success '--show-origin getting a single key' '
 	cat >expect <<-\EOF &&
-		file:.git/config	local
+	file:.git/config	local
 	EOF
 	git config --show-origin user.override >output &&
 	test_cmp expect output
@@ -1712,14 +1712,14 @@ test_expect_success '--show-origin getting a single key' '
 test_expect_success 'set up custom config file' '
 	CUSTOM_CONFIG_FILE="file\" (dq) and spaces.conf" &&
 	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
-		[user]
-			custom = true
+	[user]
+		custom = true
 	EOF
 '
 
 test_expect_success !MINGW '--show-origin escape special file name characters' '
 	cat >expect <<-\EOF &&
-		file:"file\" (dq) and spaces.conf"	user.custom=true
+	file:"file\" (dq) and spaces.conf"	user.custom=true
 	EOF
 	git config --file "$CUSTOM_CONFIG_FILE" --show-origin --list >output &&
 	test_cmp expect output
@@ -1727,7 +1727,7 @@ test_expect_success !MINGW '--show-origin escape special file name characters' '
 
 test_expect_success '--show-origin stdin' '
 	cat >expect <<-\EOF &&
-		standard input:	user.custom=true
+	standard input:	user.custom=true
 	EOF
 	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" >output &&
 	test_cmp expect output
@@ -1735,11 +1735,11 @@ test_expect_success '--show-origin stdin' '
 
 test_expect_success '--show-origin stdin with file include' '
 	cat >"$INCLUDE_DIR"/stdin.include <<-EOF &&
-		[user]
-			stdin = include
+	[user]
+		stdin = include
 	EOF
 	cat >expect <<-EOF &&
-		file:$INCLUDE_DIR/stdin.include	include
+	file:$INCLUDE_DIR/stdin.include	include
 	EOF
 	echo "[include]path=\"$INCLUDE_DIR\"/stdin.include" |
 	git config --show-origin --includes --file - user.stdin >output &&
@@ -1750,7 +1750,7 @@ test_expect_success '--show-origin stdin with file include' '
 test_expect_success !MINGW '--show-origin blob' '
 	blob=$(git hash-object -w "$CUSTOM_CONFIG_FILE") &&
 	cat >expect <<-EOF &&
-		blob:$blob	user.custom=true
+	blob:$blob	user.custom=true
 	EOF
 	git config --blob=$blob --show-origin --list >output &&
 	test_cmp expect output
@@ -1758,7 +1758,7 @@ test_expect_success !MINGW '--show-origin blob' '
 
 test_expect_success !MINGW '--show-origin blob ref' '
 	cat >expect <<-\EOF &&
-		blob:"master:file\" (dq) and spaces.conf"	user.custom=true
+	blob:"master:file\" (dq) and spaces.conf"	user.custom=true
 	EOF
 	git add "$CUSTOM_CONFIG_FILE" &&
 	git commit -m "new config file" &&
-- 
gitgitgadget

