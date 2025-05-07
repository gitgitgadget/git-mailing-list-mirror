Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21B61917FB
	for <git@vger.kernel.org>; Wed,  7 May 2025 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746587254; cv=none; b=IK3pnVDgA6HKBfexUjKWslGVNs9YCnw3MAcr7TVcit9OVTSLuJD9ULErBeQtm88Nw28j3T02wXGbRr703fcRjy6kE90mIlcn4/moGdSEfsCpI0Z1GprXyoMA3j8vS072vHIHVUadj8ajGp4uQ+QzJ3z/5xEU5ce4v3MuCcvRl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746587254; c=relaxed/simple;
	bh=pxQqWoP653BDpmuG0HFtU0UuIRfr7muICUJ9+Ax6YkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOHG0ZDvdRlGrmsslugVAohF2ibDphwAbfhYbjRCqsXhapchxtpHYJSaommtLCMMps0gTuix8H6cDexGppxIEgZKfMkvUK1Zbzq/Lb336icLnbC2Ed0ssM90WrB483a6Rmdqa+9KmQePlyEyXnc4U2ipSpJn6I4WP5RDNDznIqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eg1wSpId; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eg1wSpId"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7304efb4b3bso3629906a34.0
        for <git@vger.kernel.org>; Tue, 06 May 2025 20:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746587251; x=1747192051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSLIDVKggBh99n38bD5lMd2dAy0l1rRCrqx1Ju5+Bok=;
        b=Eg1wSpIdiTcxOutxwSHQYyA7rvoADaXk6ZGWqrMiaemmTOnj33jT4IvvvwZ5HyL+hi
         i/UIWbNT87q6z3ihTiGrj5Zqa5BHUc/XNHZfZMG7cYd3WAnk78Fq1QNR+OzQKMY2hlwq
         TEeb+sZ/1S5yw/3owltbVyYPsIlzUOsDn4E/PBDKw2wggAyiHbCGc/UV+ex4yIfLLN7O
         6qq8gpZXfllNDrRxhC/gr1dmDzTGJUcKYD4V7XEY7ZXC6M60zwokhLMW6uxVWwj6FDvg
         j6srLTfpP5shnjfqC8Fx1795D79BLNW4HzmM4cFBwnAkTIPvZIlL5oCDVux+Fz1McPMk
         xODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746587251; x=1747192051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bSLIDVKggBh99n38bD5lMd2dAy0l1rRCrqx1Ju5+Bok=;
        b=oCcrCT7wiSbGhMn/f0QiJBzsjuIrNctT5Ix+RKJHoiwIvzSQv7Vi9wMakT7ikXZaKg
         yHmDb+GS2CfvU5vtCsgUeexm6uAkE+8nze7oaYO6J2zjmOOTZGddcGMCMbsI0BsK4OQu
         JMBS3JSmGmKeynTjCEgLiYXjLTcUS6TXcqmxh81B2P1P9fAZK3sUCFLBTDyaVHrLimDM
         srDL2xZbwklx9s5oPnoWn1WCp2gddjuxApCzR18+6FS1EOqq0zJelaEdHDTnP35N/krQ
         jhBYD0VJS/XUFD+t80/AFdvle0UTaznZST+AuGeSH+z3V/bWOae4vwwAj4BimQlGGOVf
         h2DA==
X-Gm-Message-State: AOJu0YxIeuIQE1avL+A6sWfEI4f1Qma/MVMy9zzDLRRi1O+1NknH8+dS
	gr7aqaDwuD38RcUbJmEfzOCKt6kLUw6iCC1ltxLzgK5cRMFMeNs/Ot//Fn+O
X-Gm-Gg: ASbGncvtYb8GT2bNfr3rrzEP8RiEq5g6sKCN58wq7WIVWpibOMz1+hrZmYwAknqcob6
	qM9Z3EdbM4T9j6Gd7mvSxeiPyIcRg0s+Y3XZkv6kksf3PnxK31/MhrjwPpzJf/O8gqo65eJrO9E
	AIL+w2iq/isaAaqp95Yy5E4qfJRrp09Ymvtun2grgIS+U1Kl7p9+sF2PA/ckEVXUFYdbrACjVGC
	6l0rKRO1D8SONb1qoOTD2WpyvO0Pe9THXpvStmIGBTOPWkonDPPVdjLqMu/U31S5YKtCRnbnuqp
	im4GswkQCMxmWJMhqER4+0CKTbH0YAsp3XosR7eYqJ0/WcV3
X-Google-Smtp-Source: AGHT+IG84KqHQaTPioNM9ASGYILTRWExQAk/3pzHt/qcpYkienlfIXGV9MjBjksI29zlJy83nwVpWw==
X-Received: by 2002:a05:6830:6181:b0:72b:8a8b:e02c with SMTP id 46e09a7af769-73210a69ba6mr1102583a34.2.1746587251473;
        Tue, 06 May 2025 20:07:31 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73210aaab9asm268260a34.53.2025.05.06.20.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 20:07:30 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [RFC PATCH 2/2] builtin/receive-pack: add option to skip connectivity check
Date: Tue,  6 May 2025 22:02:49 -0500
Message-ID: <20250507030249.4802-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250507030249.4802-1-jltobler@gmail.com>
References: <20250507030249.4802-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During git-receive-pack(1), connectivity of the object graph is
validated to ensure that the received packfile does not leave the
repository in a broken state.

Generally, this check is critical to avoid an incomplete receieved
packfile from corrupting a repository. In situations where server
operators validate the connectivity of incoming objects outside of Git,
such a check may be redundant.

Introduce the --skip-connectivity-check option for git-receive-pack(1)
which bypasses this connectivity check to give more control to on the
server-side.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/receive-pack.c  | 40 ++++++++++++++++++++++------------------
 t/t5412-receive-pack.sh | 20 ++++++++++++++++++++
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e8..66674bc408 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -81,6 +81,7 @@ static int prefer_ofs_delta = 1;
 static int auto_update_server_info;
 static int auto_gc = 1;
 static int reject_thin;
+static int skip_connectivity_check;
 static int stateless_rpc;
 static const char *service_dir;
 static const char *head_name;
@@ -1936,27 +1937,29 @@ static void execute_commands(struct command *commands,
 		return;
 	}
 
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc = copy_to_sideband;
-		muxer.in = -1;
-		if (!start_async(&muxer))
-			err_fd = muxer.in;
-		/* ...else, continue without relaying sideband */
-	}
+	if (!skip_connectivity_check) {
+		if (use_sideband) {
+			memset(&muxer, 0, sizeof(muxer));
+			muxer.proc = copy_to_sideband;
+			muxer.in = -1;
+			if (!start_async(&muxer))
+				err_fd = muxer.in;
+			/* ...else, continue without relaying sideband */
+		}
 
-	data.cmds = commands;
-	data.si = si;
-	opt.err_fd = err_fd;
-	opt.progress = err_fd && !quiet;
-	opt.env = tmp_objdir_env(tmp_objdir);
-	opt.exclude_hidden_refs_section = "receive";
+		data.cmds = commands;
+		data.si = si;
+		opt.err_fd = err_fd;
+		opt.progress = err_fd && !quiet;
+		opt.env = tmp_objdir_env(tmp_objdir);
+		opt.exclude_hidden_refs_section = "receive";
 
-	if (check_connected(iterate_receive_command_list, &data, &opt))
-		set_connectivity_errors(commands, si);
+		if (check_connected(iterate_receive_command_list, &data, &opt))
+			set_connectivity_errors(commands, si);
 
-	if (use_sideband)
-		finish_async(&muxer);
+		if (use_sideband)
+			finish_async(&muxer);
+	}
 
 	reject_updates_to_hidden(commands);
 
@@ -2517,6 +2520,7 @@ int cmd_receive_pack(int argc,
 
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("quiet")),
+		OPT_HIDDEN_BOOL(0, "skip-connectivity-check", &skip_connectivity_check, NULL),
 		OPT_HIDDEN_BOOL(0, "stateless-rpc", &stateless_rpc, NULL),
 		OPT_HIDDEN_BOOL(0, "http-backend-info-refs", &advertise_refs, NULL),
 		OPT_ALIAS(0, "advertise-refs", "http-backend-info-refs"),
diff --git a/t/t5412-receive-pack.sh b/t/t5412-receive-pack.sh
index 190c7d3624..426a3a3df4 100755
--- a/t/t5412-receive-pack.sh
+++ b/t/t5412-receive-pack.sh
@@ -24,4 +24,24 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
 	test_must_fail git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
 '
 
+test_expect_success 'receive-pack missing objects bypasses connectivity check' '
+	test_when_finished rm -rf repo remote.git setup.git &&
+
+	git init repo &&
+	git -C repo commit --allow-empty -m 1 &&
+	git clone --bare repo setup.git &&
+	git -C repo commit --allow-empty -m 2 &&
+
+	# Capture git-send-pack(1) output sent to git-receive-pack(1).
+	git -C repo send-pack ../setup.git --all \
+		--receive-pack="tee ${SQ}$(pwd)/out${SQ} | git-receive-pack" &&
+
+	# Replay captured git-send-pack(1) output on new empty repository.
+	git init --bare remote.git &&
+	git receive-pack --skip-connectivity-check remote.git <out >actual &&
+
+	test_grep ! "fatal: Failed to traverse parents" actual &&
+	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD)
+'
+
 test_done
-- 
2.49.0.111.g5b97a56fa0

