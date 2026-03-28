Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520433F59D
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728190; cv=none; b=qABhrvfZnQmtplw7lfztmz1QBZ24l7rQHmCNxjpUAtlHZbgOhGUo+bt/doUEyubH2rgByZyrjjpCoSZnZ2iaO/rjKPejjbUfz0jfwOaiyxgCSyy5IACGKlOSDv5CigrB+jRagAT6zhd/OgrKlGo4BIj9TGjLuhmYIb4zPFA8ImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728190; c=relaxed/simple;
	bh=BAQYdj7jDB1PGg/vVxp4j8gX5oH1vLs1Bzuo4TFwfkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px8J19D9lEGi2JMCTUJ1jthNudC8AaLQOes6bu5J7zBE8gkUiV7lvbMpMtlDlBKu7Y2xOWNt5sB81y9ioPk6/dyK1QyeJI06gmaKNwgo5nkRlldToBJIm7D3oSylZZyyS0W9keFverh5ET9OV7wALmYPS14sFbVSGIaBE8M6JT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o5icxw48; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o5icxw48"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c742723c863so2044697a12.0
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728188; x=1775332988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xapT/lxYHGswzPiMJ1RI596Hzy9qgwr1OvM8Ykslr3E=;
        b=o5icxw480+EMC6qN5yEm7FK/svJe9MB0mvdJXjN+isFyQb1cnGc/1vPBB9ugL3aJO7
         T58uzvQ4/1g9IKhCvz4lpILzoJy2gSaNNq52K8/krLy0aniVPQcSrgirXwO+5Iyz8eSb
         5JQFsrqbM41U9P4fDRLuUer7KYDE75XAAApewIzk5vzRqCc0XXLBVSHAzaabmj1BDWcI
         KirG3rqJ/dpg/52bJD4MrtUnpoIPQdxhP+4g5mZLdQr1d2WXOYJ7HvBt18S6oKfngjT4
         gzkMR5Qk2SQ0dFzhhGtuuEyvRo5Qqktgm1oXwZ18wNA8cij/NzJ8eUux0rQnpIm+Phi2
         DkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728188; x=1775332988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xapT/lxYHGswzPiMJ1RI596Hzy9qgwr1OvM8Ykslr3E=;
        b=fPlo9Pi0hFWuJZ1rPYT+XDydF82qZ7Ab5tKXQrvBmmCrwWCD5iZF/FHcu1GRHFYep2
         cw78LnVdcqJMkPI1OXQ9OambHLIwrZO8hOONIXwR8imr7OnRAkweUKC4RtnnP8HAym2F
         uYpd+XiEFBx6yi6mdCf4TY6MyoF++F36wV6FPgMJ1g5NZZ5oP7yl/s2ghh69UXTxOKdm
         3QOyOHKQDAm4QZ8R1qaSiXuIH5VWAdi/KJQSMzsmD302dhvY1fj2Cb9cXLOaB7qF5nqE
         kRy9f8BGN269eyfBF6XZ5pSmxOC35HpYSy5FyaW8Hthw30wWeAuvKWh8wmmdTp32SRy2
         4i0g==
X-Gm-Message-State: AOJu0Yxa9lcWq6AAfKOYsMKTQtNqzLAK7d7MDKhset0k2eKQM2d7wp5B
	aJGNsPkxrm2osCNMbsyBd19J4cItq+Gz4roUmV3pX4gZ0ncvg23j71aRmPZJQkwG
X-Gm-Gg: ATEYQzxnVObODJqvmDHt0m4MpjNW/kLsPjYaAoXTag+PqkfXLDnslxyMH/PKbBHobpQ
	cjgfdzKNGrhBWkuLgFYF8KqAIlx6hYxdenx8wkk4NSy+SHkvpLjXxXHZ/H/BVA/D5c5UuHRVSW/
	oaGlge2nixbLT01aayWXQM0BvibAXZGLsjvl+jqE5xxOxmwlqH1uhr8uAmdmPcj86AD5J6GR4XM
	NAic1KvyypoASy7PXYmxdi0NkfrqP0TfOzjljDR4r3J/ghL8vfWby0Q9d3qyl327G0MLdDTJ+Z9
	GdZyBF7RA75c44mOIG1I30WJzC7/XF/V2jaumgfwKGNkUFkBBCAfn7kqOy1uXibzhxWOOC34ibD
	2Zg65S+AwtpOPcn9zTvg7mC2Rd9aAqbDXaOaIti5MvNMUUb6b1NqpSas+VN6eI9/FNPXSJ3YQmj
	vjjx+jOvJ6HXYgc9DSIMUMkIbJEpXbQVbCOjtjg8gCVVtjGZMcM+eUy0BF0kyy+VurKVePrybeb
	qTWZcC9pA==
X-Received: by 2002:a05:6a21:9992:b0:398:bcee:451e with SMTP id adf61e73a8af0-39c87b6aefdmr7409483637.46.1774728188332;
        Sat, 28 Mar 2026 13:03:08 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:08 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 01/16] t7004: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:40 +0900
Message-ID: <20260328200255.247759-2-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t7004-tag.sh to redirect git-cmds output to a temporary
file instead of piping it directly to not hide the exit code
of git commands behind pipes, as a crash in git might go
unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index ce2ff2a28a..9bd5c98f93 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1560,7 +1560,8 @@ test_expect_success 'filename for the message is relative to cwd' '
 		cd subdir &&
 		git tag -a -F msgfile-5 tag-from-subdir
 	) &&
-	git cat-file tag tag-from-subdir | grep "in sub directory"
+	git cat-file tag tag-from-subdir >actual &&
+	test_grep "in sub directory" actual
 '
 
 test_expect_success 'filename for the message is relative to cwd' '
@@ -1569,7 +1570,8 @@ test_expect_success 'filename for the message is relative to cwd' '
 		cd subdir &&
 		git tag -a -F msgfile-6 tag-from-subdir-2
 	) &&
-	git cat-file tag tag-from-subdir-2 | grep "in sub directory"
+	git cat-file tag tag-from-subdir-2 >actual &&
+	test_grep "in sub directory" actual
 '
 
 # create a few more commits to test --contains
-- 
2.43.0

