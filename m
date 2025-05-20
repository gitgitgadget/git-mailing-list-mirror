Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600EF253F3B
	for <git@vger.kernel.org>; Tue, 20 May 2025 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759035; cv=none; b=HvizN/tZCqjwmQ/ob5pTkLp32ar4t7GHp++LKt/tB3av6CEkUZzwIQJsxmNt8MuxNEzmL7XMpy1Dq2Lap/vn7yzCumgIFyeydhj4hjA91BRAxW661b8PhMeabicuVMfGJiN4aHJfNObD2fDAm9AXYjIJPj8yFzifws7B0YlxUxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759035; c=relaxed/simple;
	bh=Cv1NU/6+2iv1y5CVGkKIMEEikUCTTo8t73R/5k0dQwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLsiD+Wk2hR8EzTK1AEzCu3CUyDanoxJ6m8tk08jtMZMW3k0nv5Zz7B9LIukWr+Vj/peMN0vZ60DHVRSOp4rM8X54JkfIodtMieJJx/Kp9N6RyPr6sghYk6nFAsTclFv+Be3AVEyTAYgxDgCdix7Q+gxteSrO5WoZ8ATrp4Qcas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+oPDrrT; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+oPDrrT"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-400fa6eafa9so4361663b6e.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747759032; x=1748363832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZvCBpzm5/FtJ2+VqpFHhZuJIKFQd8IIMcJ59iGsrOk=;
        b=I+oPDrrTHaHqmzrxsxyr9GhZGxGgu43ljmfOppQcBHrTpM7uRofm3p2K0spViae4gb
         HYvDw7XOXy9ubqq8a4Sn7oI7UFaf2jFFYEO499Py7Q5/ZqBQXq4WfptVgv7DM5xVG2PW
         +nNct64aBgNrvk38ae0kUaOzdJmIrEDWQtu+K9/hpcKyqloD1F4P9Bwa9hf5oC/17gTW
         t62HYwTywsDuI4kGXjFn07MIPV7XSblXasvyldNx87Q7L0Ut4Lqvv+cwAzjGr+0jWgaX
         JkZJppTw9EitJpUrwlh1tXdBX1C8ernYQ5Oa0eKzzv8dLekwsDQfA+SSQBkMTzTr4TjP
         tvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747759032; x=1748363832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZvCBpzm5/FtJ2+VqpFHhZuJIKFQd8IIMcJ59iGsrOk=;
        b=EIyc8NSBRcjCLIl9pLhUFFRUScZJKH6SKgDoL37QTRzaRp471Abhr9LVIQ6hXc15xr
         T0h+eayIFQWNAr+AqI75Iiytzt40wRMxq4ETJE+X949Vew5nZVMv9FqH1dC2rD8wwUtD
         L5slWDbQgOQpbdfdM96ubhnBYGcZGPIikm8dSA7NwsdAh5X5rBMCfMqVsuZKErtdTspd
         mqH+vU7RJcmcWF9YRiBc5GQi7Q2vDVI1Nxb43Xomnc93weNyRMVUIAFixytAUNUuRCFE
         LTpphw/gqdyjLTHr8YjmIaWJa/Ez0k5XgE+VfkCYqHi/X2CJW26nCguSs2OAus9rtD1d
         iYGA==
X-Gm-Message-State: AOJu0YzIvayB8nQtOCKVpDijhRNQn4Pz62k7wugMByS3guhg0Y2t+lWo
	y9fhoEGv7N6tL5SXQCZNxERbbxUixVlROBAfi3IYHoMhoNG4FwAkFtRLyWXvQUj9
X-Gm-Gg: ASbGnctlT/lEwI5GWWoPzwoIjqOJemQskJtKrbR+N6xwxqc0UQi/8GxP8qopC36O9OF
	UxLmLHIJp9NML8uwdWkfP1yGEBEnz8ExUE6s9W5/VHK9+y4D25d5wWMaB2behzuGQWXrlMHvhZL
	McS6IA6GfBwT1QJcWewVfVGEez4dX9EmQ6GM/fkmok7+QiH33ChvKKkxK+0BHcCyO4GrcJn5cHX
	gCSaj9MT9+LyegE1IoVOAGG5VxN0ZeJHH1+wqkjackSXMyXLB7nP6kizAm5YoAek3D3vtbWSZXo
	cBQoDZTrmDk9hwRbIkL/I3k2/KAshwHgT7q/i7zqIFQecDUt3P6Zm22ut+o=
X-Google-Smtp-Source: AGHT+IGhMuCCqXzvssjPK3hMS1HtpMnVL8fyhUP22kPmnZO/6/AzxfjMq86FTxDSbCItWNWn8qvQxw==
X-Received: by 2002:a05:6808:164e:b0:401:e8e:189a with SMTP id 5614622812f47-404d87fcf7dmr10764433b6e.31.1747759032022;
        Tue, 20 May 2025 09:37:12 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-609f4be9734sm1903975eaf.7.2025.05.20.09.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 09:37:11 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 2/2] builtin/receive-pack: add option to skip connectivity check
Date: Tue, 20 May 2025 11:32:18 -0500
Message-ID: <20250520163218.263921-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.111.g5b97a56fa0
In-Reply-To: <20250520163218.263921-1-jltobler@gmail.com>
References: <20250520014920.201736-1-jltobler@gmail.com>
 <20250520163218.263921-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During git-receive-pack(1), connectivity of the object graph is
validated to ensure that the received packfile does not leave the
repository in a broken state. This is done via git-rev-list(1) and
walking the objects, which can be expensive for large repositories.

Generally, this check is critical to avoid an incomplete received
packfile from corrupting a repository. Server operators may have
additional knowledge though around exactly how Git is being used on the
server-side which can be used to facilitate more efficient connectivity
computation of incoming objects.

For example, if it can be ensured that all objects in a repository are
connected and do not depend on any missing objects, the connectivity of
newly written objects can be checked by walking the object graph
containing only the new objects from the updated tips and identifying
the missing objects which represent the boundary between the new objects
and the repository. These boundary objects can be checked in the
canonical repository to ensure the new objects connect as expected and
thus avoid walking the rest of the object graph.

Git itself cannot make the guarantees required for such an optimization
as it is possible for a repository to contain an unreachable object that
references a missing object without the repository being considered
corrupt.

Introduce the --skip-connectivity-check option for git-receive-pack(1)
which bypasses this connectivity check to give more control to the
server-side. Note that without proper server-side validation of newly
received objects handled outside of Git, usage of this option risks
corrupting a repository.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-receive-pack.adoc | 12 +++++++++
 builtin/receive-pack.c              | 40 ++++++++++++++++-------------
 t/t5410-receive-pack.sh             | 22 ++++++++++++++++
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-receive-pack.adoc b/Documentation/git-receive-pack.adoc
index 20aca92073..0956086d61 100644
--- a/Documentation/git-receive-pack.adoc
+++ b/Documentation/git-receive-pack.adoc
@@ -46,6 +46,18 @@ OPTIONS
 	`$GIT_URL/info/refs?service=git-receive-pack` requests. See
 	`--http-backend-info-refs` in linkgit:git-upload-pack[1].
 
+--skip-connectivity-check::
+	Bypasses the connectivity checks that validate the existence of all
+	objects in the transitive closure of reachable objects. This option is
+	intended for server operators that want to implement their own object
+	connectivity validation outside of Git. This is useful in such cases
+	where the server-side knows additional information about how Git is
+	being used and thus can rely on certain guarantees to more efficiently
+	compute object connectivity that Git itself cannot make. Usage of this
+	option without a reliable external mechanism to ensure full reachable
+	object connectivity risks corrupting the repository and should not be
+	used in the general case.
+
 PRE-RECEIVE HOOK
 ----------------
 Before any ref is updated, if $GIT_DIR/hooks/pre-receive file exists
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
diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
index 9afea54a26..f76a22943e 100755
--- a/t/t5410-receive-pack.sh
+++ b/t/t5410-receive-pack.sh
@@ -62,4 +62,26 @@ test_expect_success 'receive-pack missing objects fails connectivity check' '
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
+	git receive-pack --skip-connectivity-check remote.git <out >actual 2>err &&
+
+	test_grep ! "missing necessary objects" actual &&
+	test_must_be_empty err &&
+	git -C remote.git cat-file -e $(git -C repo rev-parse HEAD) &&
+	test_must_fail git -C remote.git rev-list $(git -C repo rev-parse HEAD)
+'
+
 test_done
-- 
2.49.0.111.g5b97a56fa0

