Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17276192B85
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474596; cv=none; b=Sye/azUdtht483jpkxEq8gXi/VqGdiuas/GUYpL/c+DDyMaVDD3NVsw3sQTcfwEPW08yDOti67xHbyrWvQPagVEOlCLFSPMcgkYwszH1+MeinoGnCHPcMHv4oyatp3EeihnCC+b/cjFd1cv/Buz/VhogO/EitkVWe1n7NlRILZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474596; c=relaxed/simple;
	bh=TtPKBoiirzRwPKW3Fbc8h9CTuiRAJud8wq2JwnUEpcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JYYH6TGcVvV3SRUcBwZiXIl5F/CQZPQgZ5T0ayaHc63k9KlAL/zbW8BNiDFcgeE1L9JyFGRLEOCkCFJzVXTFOfp6RxOD2fVg03IeLjxd/b58irsDCQ/0IfpaS69HY1CyrXInxEjeoL2wMoTtF9s9EjSDM0+6an0tO7lhOh0pzsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvttDDjm; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvttDDjm"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398b589032so10425685e87.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474593; x=1729079393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kllgDYvBs6AL03xeRynB/4omnEpgePtHWu3/MAI+j5Y=;
        b=PvttDDjmfS7xJiofm9lXPVN5f8NgTrH1hn0j5CWS8UOgWViUPPTiJy0p4efR0GEp0+
         qlhj9ImV2IFfgRPGEPDYBrab19P55famQxMug0dSFnZ0vUp42PYLDDQ9+bRtZJ69b1V9
         v96EtWKpFztgkP0ItjtYggNDX5Fw/bRIt5dMWyX6Y8iK0teSDAJMnpNWvZDrhAx7JaQ2
         I76sDNhZJssx31MTpNkIn+yzJI0ukBObBw7Bk4xw4uLS6fUfbC0G+j21gC/XFOp1mxpE
         XBV93ItTaOiXm0rkSApfUu3Z4PC0OvXzG6l/9z1kDqFpJ3FMolngCbzDn0XQk8TbVwwg
         IHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474593; x=1729079393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kllgDYvBs6AL03xeRynB/4omnEpgePtHWu3/MAI+j5Y=;
        b=wu5zmsAOQHklV+vCZUT+3aaSqTjVS7Ow/t6DSQ1nEWmF+Tok7eug3ngHAsQDaH7rl7
         ePKTfD2hrzCDKXxWwyA+Y0hDkh8CUU9vfJkkvs4sd16u4kkL4EDIWf0pWr2B/13pWn8C
         MdMlGPyNK0o95dmWN8GnyTymB4Q+Itmsn009u4qaXLwnu+J6CHG/A46ltVrjj9AL19c8
         Fdu7464OURfnyFyK3/H0qi+IFwoabYL3s4aNgUWaPEC3RGvTLBLFYXWmCrsHQGrw50bL
         UlcwJdwmQyfs3yAXSZ0t5NnmO7MuHuhfHMQRtxJFt3O3bhcdpU9W+/qJRwtZD2mFrFSj
         llsw==
X-Gm-Message-State: AOJu0YxwmqsPx4tBhsqAKtLEKKJF+ocaEIGL4vRA4Z1A1O69P/Hn/3s1
	gz2YxgxTQzAv3PIgXM1SA7ixLoH1MaVIlWAB1TcgYtbjfe+s5BPpB61PQkWq
X-Google-Smtp-Source: AGHT+IHRGQ9qJh841XrbR7Q1Na2y7uNhpEk0n7GTV2L1njb3aIplSZ7B/0uPko3qTH/Imj5fupvzQw==
X-Received: by 2002:a05:6512:3087:b0:52c:e10b:cb33 with SMTP id 2adb3069b0e04-539c496804bmr1879100e87.50.1728474592469;
        Wed, 09 Oct 2024 04:49:52 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:51 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 4/7] t: fix typos
Date: Wed,  9 Oct 2024 14:49:37 +0300
Message-Id: <20241009114940.520486-5-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/lib-bundle.sh          | 2 +-
 t/lib-rebase.sh          | 2 +-
 t/lib-sudo.sh            | 2 +-
 t/lib-unicode-nfc-nfd.sh | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/lib-bundle.sh b/t/lib-bundle.sh
index cf7ed818b2..62b7bb13c8 100644
--- a/t/lib-bundle.sh
+++ b/t/lib-bundle.sh
@@ -11,7 +11,7 @@ convert_bundle_to_pack () {
 }
 
 # Check count of objects in a bundle file.
-# We can use "--thin" opiton to check thin pack, which must be fixed by
+# We can use "--thin" option to check thin pack, which must be fixed by
 # command `git-index-pack --fix-thin --stdin`.
 test_bundle_object_count () {
 	thin=
diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 11d2dc9fe3..0dd764310d 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -187,7 +187,7 @@ set_reword_editor () {
 			exit 1
 		fi
 	fi &&
-	# There should be no uncommited changes
+	# There should be no uncommitted changes
 	git diff --exit-code HEAD &&
 	# The todo-list should be re-read after a reword
 	GIT_SEQUENCE_EDITOR="\"$PWD/reword-sequence-editor.sh\"" \
diff --git a/t/lib-sudo.sh b/t/lib-sudo.sh
index b4d7788f4e..477e0fdc04 100644
--- a/t/lib-sudo.sh
+++ b/t/lib-sudo.sh
@@ -6,7 +6,7 @@ run_with_sudo () {
 	local RUN="$TEST_DIRECTORY/$$.sh"
 	write_script "$RUN" "$TEST_SHELL_PATH"
 	# avoid calling "$RUN" directly so sudo doesn't get a chance to
-	# override the shell, add aditional restrictions or even reject
+	# override the shell, add additional restrictions or even reject
 	# running the script because its security policy deem it unsafe
 	sudo "$TEST_SHELL_PATH" -c "\"$RUN\""
 	ret=$?
diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
index 22232247ef..aed0a4dd44 100755
--- a/t/lib-unicode-nfc-nfd.sh
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -74,7 +74,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
 # Yielding:   \xcf \x89  +  \xcc \x94  +  \xcd \x82
 #
 # Note that I've used the canonical ordering of the
-# combinining characters.  It is also possible to
+# combining characters.  It is also possible to
 # swap them.  My testing shows that that non-standard
 # ordering also causes a collision in mkdir.  However,
 # the resulting names don't draw correctly on the
-- 
2.39.5

