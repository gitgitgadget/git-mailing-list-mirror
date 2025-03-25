Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8978F4C
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 00:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742864136; cv=none; b=IhNJKV+prkKjcpCnQQmK6D16NuEeg7rwPCDTP1N1vzBL+BZNMZXXkb8+U0zp+IB3fBMtZg/I0m75r2IaIJZqdgN5qFpID4zOmQR0pWAQ5acnuWSOA3TBXKUzHKGV5/34LxURTxfTrwDomzU7HW0J94D5GMTyMXnLgyrkhM2N7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742864136; c=relaxed/simple;
	bh=/tfQeOtBXIyGyXb1XrI2zC6hkryc020zrhKm9KnxEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ar5gQw+v3HnzU9I7YPT5D9tOFcXfC0XPG9UOvXmAJ4wL6HRJOjKo1/i6zOhfQQCTOyzc/KGes6fJ9af3vOLeIYl/1XTwAxJ/UxBD3JIGZtGp+GplKdWBcC8+1ZEsg7jQCHs8RjnyxCL0ssQyeCNiU74Mr0jnQhlksaZPHaFOkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAYBqrvr; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAYBqrvr"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-72c1818c394so1397668a34.2
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 17:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742864134; x=1743468934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+yJb7o+0zYIr9IgJwgGYZgZIYw/ZrypCB+KVBv9PU4=;
        b=TAYBqrvrLuFiJQQuZJowCqjLDY1K02s7cBRMe5OWbIqDUGS+qAnY3XO0qIt99sr+nf
         4HV7JgXaGprqLNURda5zpbTrp6N0eprxjocAdh2rzdIaLyiPVXa6Sf1BgUEjafqmIyAH
         qAlia+ZU3wdtj/g+2qmLty2ZXt6uwp3GuT/VPKz+gWrD4qmS10KyVT/Nt1jkeyQbm6go
         4nt6jgE8B3wmyk+xOnhJ/pc06GGaEXOkzzJ77U0/BChYaXtA32/FxPqnu2TtpnGIduDk
         SP5YIkRlZzQS9HEdx9NFUvV200LVxcXDBtJhPJR7R/ZVlyry4Zdwm3hvBUxevTtoPvr8
         soYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742864134; x=1743468934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b+yJb7o+0zYIr9IgJwgGYZgZIYw/ZrypCB+KVBv9PU4=;
        b=h0mVxtRquuQ+zXbjTKvoEwytMRF7aXrssE2jXIHxGa+juGgXdFT+OPU8NXcyiXOUrs
         aT+IVL57sLIYbOyMkTpP0uClGyRb0B40d+aGoTtlICpiYWOpiM4JkbM1s3n8mp6E1qb+
         iL2ChTB+9YbG3/4HLz5TADZasEmV/C8EVAYEwyxpf1XqTqmW47Tf7UYvTS7W+wlbIrnG
         kr7ntOfbXC0t1R3GXyxCrCqvY/X6aCdmFS+a8zk+yChLMI2kHaLaunJUAc6soNdNKAhR
         R8kRc69mpr9VTp30KiGjFCtFn7dti9yZFv32rj+TvaTsbxLE6r6S5yoOoCDOCPBrqw+P
         A/Jw==
X-Gm-Message-State: AOJu0YzXxiQDHj4upX/MK6UvEVp9uvMjJy5HGao5jltW+C29LakKa6db
	fQCUuW3FE/awPfxFCC+Ph7FK17PEQfItJGR7Ftr7rUiFvMjyggM2/5LfsQ==
X-Gm-Gg: ASbGncvMMMEPSK+85MeGAEPmdCcs8UwQx01ZYJk7eYEUTxMdVPvE8ohr9qVtC/uzf2h
	J1LXYsPuCrv/i33OLWoXAetq5z2LyMP5LgWdmNuZHNy0Vc18PYJO5rz+UnZhiVYk+a2Fqva5ngE
	+wuR8b4QD6J4rnzLZ3o4zcZD8Gd8vS1o8m5qOSHyUNhDnWJobmijcisUQmlgmzpTsKjxxqv8ql5
	jWmrRzhcEv66patLDr4yL32j6xU0o0e1+uG5ivUQHh1cqbGIv7tz1FLlbZLKtQdNR43gjTXPNdW
	LzFSOLNN7Uj9KTxMmHpDy0aTVqEBUnBplT0dipLdMMJbd3curr9Q
X-Google-Smtp-Source: AGHT+IEAi3GUEUW9wpS9NpjTiHCaozR1WsIMioo1tccfTSkVZtgNIso7kCwtJoaZvD/NGcwWYD512Q==
X-Received: by 2002:a05:6830:6805:b0:72a:449e:2b6e with SMTP id 46e09a7af769-72c0ae43d98mr9701663a34.5.1742864133656;
        Mon, 24 Mar 2025 17:55:33 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0ac7bbafsm1735316a34.65.2025.03.24.17.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 17:55:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood123@gmail.com,
	alan@norbauer.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/3] builtin/clone: suppress unexpected default branch advice
Date: Mon, 24 Mar 2025 19:51:47 -0500
Message-ID: <20250325005148.1771502-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325005148.1771502-1-jltobler@gmail.com>
References: <20250321231639.180762-1-jltobler@gmail.com>
 <20250325005148.1771502-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 199f44cb2ead (builtin/clone: allow remote helpers to detect repo,
2024-02-27), clones started partially initializing the refdb before
executing the remote helpers by creating a HEAD file and "refs/"
directory. This has resulted in some scenarios where git-clone(1) now
prints the default branch name advice message where it previously did
not.

A side-effect of the HEAD file already existing, is that computation of
the default branch name is handled later in execution. This matters
because prior to 97abaab5f6 (refs: drop `git_default_branch_name()`,
2024-05-17), the default branch value would be computed during its first
execution and cached. Subsequent invocations would simply return the
cached value. Since the next `git_default_branch_name()` call site,
which is invoked through `guess_remote_head()`, is not configured to
suppress the advice message, computing the default branch name results
in the advice message being printed.

Configure `guess_remote_head()` to suppress the advice message,
restoring the previous behavior.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/clone.c         |  7 +++++--
 t/t5607-clone-bundle.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index f14229abf4..baa76f88c3 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -450,7 +450,9 @@ static struct ref *wanted_peer_refs(struct clone_opts *opts,
 		if (head)
 			tail_link_ref(head, &tail);
 		if (option_single_branch)
-			refs = to_free = guess_remote_head(head, refs, 0);
+			refs = to_free =
+				guess_remote_head(head, refs,
+						  REMOTE_GUESS_HEAD_QUIET);
 	} else if (option_single_branch) {
 		local_refs = NULL;
 		tail = &local_refs;
@@ -1523,7 +1525,8 @@ int cmd_clone(int argc,
 	}
 
 	remote_head = find_ref_by_name(refs, "HEAD");
-	remote_head_points_at = guess_remote_head(remote_head, mapped_refs, 0);
+	remote_head_points_at = guess_remote_head(remote_head, mapped_refs,
+						  REMOTE_GUESS_HEAD_QUIET);
 
 	if (option_branch) {
 		our_head_points_at = find_remote_branch(mapped_refs, option_branch);
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index 82e3621ec5..d709bea753 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -211,4 +211,16 @@ test_expect_success 'git bundle v3 rejects unknown capabilities' '
 	test_grep "unknown capability .unknown=silly." output
 '
 
+test_expect_success 'cloning bundle suppresses default branch name advice' '
+	test_when_finished "rm -rf bundle-repo clone-repo" &&
+
+	git init bundle-repo &&
+	git -C bundle-repo commit --allow-empty -m init &&
+	git -C bundle-repo bundle create repo.bundle --all &&
+	GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME= \
+		git clone --single-branch bundle-repo/repo.bundle clone-repo 2>err &&
+
+	test_grep ! "hint: " err
+'
+
 test_done
-- 
2.49.0

