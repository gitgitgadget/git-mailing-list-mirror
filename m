Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EB42E3AF0
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950636; cv=none; b=leKOSa5tm3HEi+RSUqhKc1bWj6uuFeO0P/1pbdzqqcSyJ5cXh/RliY6Zbg0Gx2QKHYi+Pwjk6+KTPA/ojZ4RQs5GCbsL9pdCp2p71nFV8SEgXjc1jwhXeKobmHE0fGdMJ18p5Gi+k8kfvbxScyccPwXMikFRu45SSmiv0yR33o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950636; c=relaxed/simple;
	bh=7gfDqVhiGuirWKk12A0K0YsqvS0gTirgXLJ9Jy8ZoVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0gSA9GE7W6O3jbCAlsUJJNrg2bziRsgS6CjVc8NU/eqmwNLH9l+Butettvlhy3f4PW9rF/Q57T1jM0nNZ05lO4Phivdv6L+WLqV6pP3h7FL6Bt9UtvbaZCgfcqOsGahsHsPxdQ2LpvRaks1OB2voGd7PtqnwYS1L0rBdFKOZ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nrArvMiE; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrArvMiE"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e905a52b0d5so2038100276.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754950633; x=1755555433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npjwIt96iIGZvyJCDB1rHNFkngJMWa/eFUZhR9pnRVM=;
        b=nrArvMiEW29oNlMtPOC8/j1S/uv+cEONFqzrQIEa0gChjWplxyjjekGr0t31twN/T3
         Ps+5GKug8+HmFV5VhuD+4S6ZZLx3IsSPiRNy1DfFjfSpG+wSytdzmJXPTu2cv6HiWvlh
         qdRyTfp+ZhTAP3PISy1Me1b4ubK9SN2MuHzBtvG4D+ZENvbGK7Uchdd8SvaSVXD3cEJs
         DWAkEZk2geZBu+hmYQ340CmKth9uPhtnu/FXXmTJBZO/TUHAnHFipbWGJhclCY8VOUG3
         KUwQInlC+Ijm8IEc9RUFDlLlIptNdI0zuKNkv8BwbUwNGIB/I62u1UHp7oCa7GObtN7D
         sASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950633; x=1755555433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npjwIt96iIGZvyJCDB1rHNFkngJMWa/eFUZhR9pnRVM=;
        b=rTyClU6VHEQP56ApBhaGq32vgPUY9xKufwv0+VpemYaSAYPgGl9+l0pvQQTsc/thdj
         UvzNs1REJFTVB1a6FZTwLwF0JMZ0bol+0PDBmQelQkbdtPbVjpAiTFVX6afAvNFyTOt8
         g4anLpnqnYQhYPCW+V6oSCZBrw+dz7npBS2aGpTONFPrm8QOGphAVNsZgtxeJSYA7Xc2
         qCw4smE888j0yxpV+iRpnHxJdlA1wjoJRK6J7Z/pQjJN96pfjTgIR9JRpqrvZA/u+zW9
         nzpdMJMNZrLJwNH8F5HvaGBdv2d1OfgEUUGPvr3mkfArES6wPUG58Zes9szobXBqG8Ns
         TrWg==
X-Gm-Message-State: AOJu0YycFRW4WxsKoG40Jy11hihGWsD0F0QuKj0h+RCNCRys+Jall01l
	Qh7OaK8aBJuVxdXA24lWFcWwH6MhO7AeHuShooH2hXC7reIiOWTmqYouX6d7HPUo
X-Gm-Gg: ASbGncvpQ6W2HG8IYneanEXD51DJdgf5MCoPP4vvecOfTkG/ztZKNcgAh5mZVAaVT8f
	41Uf1ZobhNH9jxe2e3h6KJnoS9+IWaDQIFb9Wmi9D9HJncsuw0P/r/YltzPD6Mj7d8GXID4/2G+
	utnboH0A5QJOTBF7b9PiPfwbK6FiI3qhkH9PhpSBEo6N9M4czhNEscA3jmQcIV6QdbSWUuJTwaQ
	XTCXVizeOg25tqWMCQ4oD55xkl27C1GxOEJz0dCB/pRiK5fzWGanjWcRXrT1papLgfFeSVAwqwE
	0Vw9B0a/WGV+lvJaoTidh2hxZ9UXHWX3rDABUxQEP3kpMb0QOaZpwYEc0Kf8EFbeWGJEYXej+wO
	mfJkUvAyhFasuj81CuvWTS3PIzRoidK45YyWBaYVIrH03OHmVUOFSbwvq7wxb+8NLP4cT53U=
X-Google-Smtp-Source: AGHT+IHTss/aJaGb1YYW86HUAiagmABFWQYydvMAkLXGSMidBIBmGHQw4m/jTdpu+b7uoYxLkRRCDQ==
X-Received: by 2002:a05:6902:2b88:b0:e90:6a07:6c4c with SMTP id 3f1490d57ef6-e917a1a952emr2340229276.10.1754950633460;
        Mon, 11 Aug 2025 15:17:13 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:7d40:489a:fc5:8804])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e917b3ec714sm176217276.11.2025.08.11.15.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:17:13 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 3/4] t7005: sanitize test environment for subsequent tests
Date: Mon, 11 Aug 2025 18:16:54 -0400
Message-ID: <20250811221706.67168-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810160323.49372-1-ben.knoble+github@gmail.com>
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the editor tests manipulate the environment or config in ways
that affect future tests, but those modifications are visible to future
tests and create a footgun for them.

Use test_config, subshells, single-command environment overrides, and
test helpers to automatically undo environment and config modifications
once finished.

Best-viewed-with: --ignore-all-space
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 t/t7005-editor.sh | 83 ++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 44 deletions(-)

diff --git a/t/t7005-editor.sh b/t/t7005-editor.sh
index 0a5861b7f0..3a5f4b897e 100755
--- a/t/t7005-editor.sh
+++ b/t/t7005-editor.sh
@@ -34,61 +34,57 @@
 	test_commit_message HEAD -m "$msg"
 '
 
-TERM=dumb
-export TERM
 test_expect_success 'dumb should error out when falling back on vi' '
-	test_must_fail git commit --amend
+	TERM=dumb test_must_fail git commit --amend
 '
 
 test_expect_success 'dumb should prefer EDITOR to VISUAL' '
-	EDITOR=./e-EDITOR.sh &&
-	VISUAL=./e-VISUAL.sh &&
-	export EDITOR VISUAL &&
-	git commit --amend &&
+	TERM=dumb EDITOR=./e-EDITOR.sh VISUAL=./e-VISUAL.sh \
+		git commit --amend &&
 	test_commit_message HEAD -m "Edited by EDITOR"
 '
 
-TERM=vt100
-export TERM
 for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
 do
-	echo "Edited by $i" >expect
-	unset EDITOR VISUAL GIT_EDITOR
-	git config --unset-all core.editor
-	case "$i" in
-	core_editor)
-		git config core.editor ./e-core_editor.sh
-		;;
-	[A-Z]*)
-		eval "$i=./e-$i.sh"
-		export $i
-		;;
-	esac
 	test_expect_success "Using $i" '
-		PATH="$PWD:$PATH" git commit --amend &&
-		test_commit_message HEAD expect
+		if test "$i" = core_editor
+		then
+			test_config core.editor ./e-core_editor.sh
+		fi &&
+		(
+			case "$i" in
+			[A-Z]*)
+				eval "$i=./e-$i.sh" &&
+				export $i
+				;;
+			esac &&
+			PATH="$PWD:$PATH" TERM=vt100 git commit --amend
+		) &&
+		test_commit_message HEAD -m "Edited by $i"
 	'
 done
 
-unset EDITOR VISUAL GIT_EDITOR
-git config --unset-all core.editor
-for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
-do
-	echo "Edited by $i" >expect
-	case "$i" in
-	core_editor)
-		git config core.editor ./e-core_editor.sh
-		;;
-	[A-Z]*)
-		eval "$i=./e-$i.sh"
-		export $i
-		;;
-	esac
-	test_expect_success "Using $i (override)" '
-		PATH="$PWD:$PATH" git commit --amend &&
-		test_commit_message HEAD expect
-	'
-done
+test_expect_success 'Using editors with overrides' '
+	(
+		TERM=vt100 &&
+		export TERM &&
+		for i in $vi EDITOR VISUAL core_editor GIT_EDITOR
+		do
+			echo "Edited by $i" >expect &&
+			case "$i" in
+			core_editor)
+				git config core.editor ./e-core_editor.sh
+				;;
+			[A-Z]*)
+				eval "$i=./e-$i.sh" &&
+				export $i
+				;;
+			esac &&
+			PATH="$PWD:$PATH" git commit --amend &&
+			test_commit_message HEAD expect || exit 1
+		done
+	)
+'
 
 test_expect_success 'editor with a space' '
 	echo "echo space >\"\$1\"" >"e space.sh" &&
@@ -97,9 +93,8 @@
 	test_commit_message HEAD -m space
 '
 
-unset GIT_EDITOR
 test_expect_success 'core.editor with a space' '
-	git config core.editor \"./e\ space.sh\" &&
+	test_config core.editor \"./e\ space.sh\" &&
 	git commit --amend &&
 	test_commit_message HEAD -m space
 '
-- 
2.48.1

