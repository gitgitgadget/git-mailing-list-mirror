Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C0E19F130
	for <git@vger.kernel.org>; Sat, 24 May 2025 03:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748058053; cv=none; b=cLscCkCQ5w8wLrgLleoOqMXRMwyxJYW3DAPt4pPB1lFrA6QYp2HZkiNbTFdPLK3LPV6kwHevAoRvO9OmKHn8kbMlBC/hFn4a81XPbwKosIVYPppQJaFfbETwO3w5DoXOcBWPVsloEeoEC7uZQq+vL71NHXJomyCQlAoiC/9aOFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748058053; c=relaxed/simple;
	bh=BeX3AgcDs0hWGVGnGTbF6ybCvtWJ0udtYWIE/SNXjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbQrTtuLFNK5LGZWIbQmOUdXXeV02LFl/3yRUqMwRocTer18ABxNoWjwbhjUJop7BXJYQhGWqsMTKfaVH6+nkE6Mj5+Z5fNP+FcDDnJO5pdOA166mP9WrEoyoQGhIMktZraY6Ni9YmO4WgBcYfpRWmoEKv3Cgisi+uFmXgbDefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YxHiAh2C; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YxHiAh2C"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6f5373067b3so5425966d6.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 20:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748058050; x=1748662850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVvYbRsiKat00bbpjEPEW9PuQnfgOl9Vkx7SFdJEqA0=;
        b=YxHiAh2C0ViE7Q76VbTWRUkly94nsEBbpyPQdh3TVaHMUSYgMvPFc9M5nyxM93TTKj
         jjBMY9WKVehWiMSncfv+fHs05VNRQmKr9ariFJpzuYtxBHJ4qkqyCwj4QKwzzhurBazS
         jYgRBRzHFA15sYdXmrwYSclKtwt0S2ceb3IGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748058050; x=1748662850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVvYbRsiKat00bbpjEPEW9PuQnfgOl9Vkx7SFdJEqA0=;
        b=ALdv5Pq4f5XTuAiWfDqbT9Q38ufZNXYVEaSqwtgptjsJzlsRXkVEjeCly94JzLHTjU
         ZS7V+UbSB/2LR9BKUhqOU47Nzw1pXLJnegFHyoOFqquU/FSNceU28Kl9OLFvP/Wf5Mak
         f2czopO9r/7LGNxPVuW18oS3Hq1HfY1ss8MK5yCTynamc7CrcbGAAlDcMSzqyhFyUWUR
         r8aM48ehPwrOf8MWuHmA/D9qgY+tba3W4T1w2mr50xlmoVW39vrvvdWXDeTnlm4RRPpz
         8TgObQ3dq7j/diZc6lNeVx3MSvwgrZLD3upVirYMNEf7EdTYGhvIAMFjXJ2TgdHI33xw
         aCdQ==
X-Gm-Message-State: AOJu0YwQI/IRw7k2/YFFPnIiBL7n+2uuaiSxoE7fJfue4FYqZYHzmwqv
	CNgQUSnnyobIuTKNiM7MrERWYzF0tw10cUDLuaXF7f1yfMPcuTJGZxQ5zN7ZXUhqVYT15BuUHgX
	dVj6yFw==
X-Gm-Gg: ASbGncuQuuUxPQ28bk0FuQyqko1aOPiPUgBnrfujrEljEwWxnkhQEj8y+hXwxWDSR+4
	rT0BHzEqpn3VYrdHADE9TuJ3WodhI/uxnSKEhHztZy9u/Mt/wfjoz94Q1YCNZkpj0BRdOjf/JS5
	BQTN6E3nucsTM4E6NUzEiJTJJDC2L2q8pjYRSLoCNYklxG7PEYPQ/TkBYzU1edS3fDjjo6MxMbv
	O2+6ELtPIiCrOPjewz3CH5e6DiHXldGLIcIvKSZTqh0ufeYY8uIIxr7PI9xfldGxMYRfjkxcxv0
	Vt1CojxVKrtS9rV25iHN5byJxUms8+Dercq2S0iuMc8Q++rg50NKEEkiTjjy4ygUtE/73nACRoL
	5XE8ohw==
X-Google-Smtp-Source: AGHT+IELNb1R2GCXhjlfVbD9+ARRFzP1HmH+JAcFZHzWLKHXGEdvLl6TnHcETj2J+g9DrSM/ml3+2Q==
X-Received: by 2002:a05:6214:2a49:b0:6f8:c773:364 with SMTP id 6a1803df08f44-6fa9d016574mr29944146d6.13.1748058050076;
        Fri, 23 May 2025 20:40:50 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-497ae224a4bsm99001731cf.76.2025.05.23.20.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 20:40:49 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 2/2] apply: set file mode when --reverse creates a deleted file
Date: Fri, 23 May 2025 23:40:46 -0400
Message-ID: <20250524034046.2619-3-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250524034046.2619-1-mark@chromium.org>
References: <20250523172154.93810-1-mark@chromium.org>
 <20250524034046.2619-1-mark@chromium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
mode bits, 2023-12-26) revised reverse_patches() to maintain the desired
property that when only one of patch::old_mode and patch::new_mode is
set, the mode will be carried in old_mode. That property is generally
correct, with one notable exception: when creating a file, only new_mode
will be set. Since reversing a deletion results in a creation, new_mode
must be set in that case.

Omitting handling for this case means that reversing a patch that
removes an executable file will not result in the executable permission
being set on the re-created file. Existing test coverage for file modes
focuses only on mode changes of existing files.

Swap old_mode and new_mode in reverse_patches() for what's represented
in the patch as a file deletion, as it is transformed into a file
creation under reversal. This causes git apply --reverse to set the
executable permission properly when re-creating a deleted executable
file.

Add tests ensuring that git apply sets file modes correctly on file
creation, both in the forward and reverse directions.

Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 apply.c                   |   2 +-
 t/t4129-apply-samemode.sh | 165 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/apply.c b/apply.c
index f274a3794877..bd4571f89358 100644
--- a/apply.c
+++ b/apply.c
@@ -2219,7 +2219,7 @@ static void reverse_patches(struct patch *p)
 		struct fragment *frag = p->fragments;
 
 		SWAP(p->new_name, p->old_name);
-		if (p->new_mode)
+		if (p->new_mode || p->is_delete)
 			SWAP(p->new_mode, p->old_mode);
 		SWAP(p->is_new, p->is_delete);
 		SWAP(p->lines_added, p->lines_deleted);
diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index bf4e7609dc33..1d6317bd7141 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -102,14 +102,23 @@ test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
 	)
 '
 
+test_file_mode_common () {
+	if test "$1" = "000000"
+	then
+		test_must_be_empty "$2"
+	else
+		test_grep "^$1 " "$2"
+	fi
+}
+
 test_file_mode_staged () {
 	git ls-files --stage -- "$2" >ls-files-output &&
-	test_grep "^$1 " ls-files-output
+	test_file_mode_common "$1" ls-files-output
 }
 
 test_file_mode_HEAD () {
 	git ls-tree HEAD -- "$2" >ls-tree-output &&
-	test_grep "^$1 " ls-tree-output
+	test_file_mode_common "$1" ls-tree-output
 }
 
 test_expect_success 'git apply respects core.fileMode' '
@@ -189,6 +198,158 @@ test_expect_success 'git apply --reverse warns about incorrect file modes' '
 	test_file_mode_HEAD 100755 mode_test
 '
 
+test_expect_success 'setup: git apply [--reverse] restores file modes (change_x_to_notx)' '
+	test_config core.fileMode false &&
+
+	touch change_x_to_notx &&
+	git add --chmod=+x change_x_to_notx &&
+	test_file_mode_staged 100755 change_x_to_notx &&
+	test_tick && git commit -m "add change_x_to_notx as executable" &&
+	test_file_mode_HEAD 100755 change_x_to_notx &&
+
+	git add --chmod=-x change_x_to_notx &&
+	test_file_mode_staged 100644 change_x_to_notx &&
+	test_tick && git commit -m "make change_x_to_notx not executable" &&
+	test_file_mode_HEAD 100644 change_x_to_notx &&
+
+	git rm change_x_to_notx &&
+	test_file_mode_staged 000000 change_x_to_notx &&
+	test_tick && git commit -m "remove change_x_to_notx" &&
+	test_file_mode_HEAD 000000 change_x_to_notx &&
+
+	git format-patch -o patches -3 &&
+	mv patches/0001-* change_x_to_notx-0001-create-0755.patch &&
+	mv patches/0002-* change_x_to_notx-0002-chmod-0644.patch &&
+	mv patches/0003-* change_x_to_notx-0003-delete.patch &&
+
+	test_grep "^new file mode 100755$" change_x_to_notx-0001-create-0755.patch &&
+	test_grep "^old mode 100755$" change_x_to_notx-0002-chmod-0644.patch &&
+	test_grep "^new mode 100644$" change_x_to_notx-0002-chmod-0644.patch &&
+	test_grep "^deleted file mode 100644$" change_x_to_notx-0003-delete.patch &&
+
+	git tag change_x_to_notx_initial
+'
+
+test_expect_success 'git apply restores file modes (change_x_to_notx)' '
+	test_config core.fileMode false &&
+	git reset --hard change_x_to_notx_initial &&
+
+	git apply --index change_x_to_notx-0001-create-0755.patch &&
+	test_file_mode_staged 100755 change_x_to_notx &&
+	test_tick && git commit -m "redo: add change_x_to_notx as executable" &&
+	test_file_mode_HEAD 100755 change_x_to_notx &&
+
+	git apply --index change_x_to_notx-0002-chmod-0644.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 100644 change_x_to_notx &&
+	test_tick && git commit -m "redo: make change_x_to_notx not executable" &&
+	test_file_mode_HEAD 100644 change_x_to_notx &&
+
+	git apply --index change_x_to_notx-0003-delete.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 000000 change_x_to_notx &&
+	test_tick && git commit -m "redo: remove change_notx_to_x" &&
+	test_file_mode_HEAD 000000 change_x_to_notx
+'
+
+test_expect_success 'git apply --reverse restores file modes (change_x_to_notx)' '
+	test_config core.fileMode false &&
+	git reset --hard change_x_to_notx_initial &&
+
+	git apply --index --reverse change_x_to_notx-0003-delete.patch &&
+	test_file_mode_staged 100644 change_x_to_notx &&
+	test_tick && git commit -m "undo: remove change_x_to_notx" &&
+	test_file_mode_HEAD 100644 change_x_to_notx &&
+
+	git apply --index --reverse change_x_to_notx-0002-chmod-0644.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 100755 change_x_to_notx &&
+	test_tick && git commit -m "undo: make change_x_to_notx not executable" &&
+	test_file_mode_HEAD 100755 change_x_to_notx &&
+
+	git apply --index --reverse change_x_to_notx-0001-create-0755.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 000000 change_x_to_notx &&
+	test_tick && git commit -m "undo: add change_x_to_notx as executable" &&
+	test_file_mode_HEAD 000000 change_x_to_notx
+'
+
+test_expect_success 'setup: git apply [--reverse] restores file modes (change_notx_to_x)' '
+	test_config core.fileMode false &&
+
+	touch change_notx_to_x &&
+	git add --chmod=-x change_notx_to_x &&
+	test_file_mode_staged 100644 change_notx_to_x &&
+	test_tick && git commit -m "add change_notx_to_x as not executable" &&
+	test_file_mode_HEAD 100644 change_notx_to_x &&
+
+	git add --chmod=+x change_notx_to_x &&
+	test_file_mode_staged 100755 change_notx_to_x &&
+	test_tick && git commit -m "make change_notx_to_x executable" &&
+	test_file_mode_HEAD 100755 change_notx_to_x &&
+
+	git rm change_notx_to_x &&
+	test_file_mode_staged 000000 change_notx_to_x &&
+	test_tick && git commit -m "remove change_notx_to_x" &&
+	test_file_mode_HEAD 000000 change_notx_to_x &&
+
+	git format-patch -o patches -3 &&
+	mv patches/0001-* change_notx_to_x-0001-create-0644.patch &&
+	mv patches/0002-* change_notx_to_x-0002-chmod-0755.patch &&
+	mv patches/0003-* change_notx_to_x-0003-delete.patch &&
+
+	test_grep "^new file mode 100644$" change_notx_to_x-0001-create-0644.patch &&
+	test_grep "^old mode 100644$" change_notx_to_x-0002-chmod-0755.patch &&
+	test_grep "^new mode 100755$" change_notx_to_x-0002-chmod-0755.patch &&
+	test_grep "^deleted file mode 100755$" change_notx_to_x-0003-delete.patch &&
+
+	git tag change_notx_to_x_initial
+'
+
+test_expect_success 'git apply restores file modes (change_notx_to_x)' '
+	test_config core.fileMode false &&
+	git reset --hard change_notx_to_x_initial &&
+
+	git apply --index change_notx_to_x-0001-create-0644.patch &&
+	test_file_mode_staged 100644 change_notx_to_x &&
+	test_tick && git commit -m "redo: add change_notx_to_x as not executable" &&
+	test_file_mode_HEAD 100644 change_notx_to_x &&
+
+	git apply --index change_notx_to_x-0002-chmod-0755.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 100755 change_notx_to_x &&
+	test_tick && git commit -m "redo: make change_notx_to_x executable" &&
+	test_file_mode_HEAD 100755 change_notx_to_x &&
+
+	git apply --index change_notx_to_x-0003-delete.patch &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 000000 change_notx_to_x &&
+	test_tick && git commit -m "undo: remove change_notx_to_x" &&
+	test_file_mode_HEAD 000000 change_notx_to_x
+'
+
+test_expect_success 'git apply --reverse restores file modes (change_notx_to_x)' '
+	test_config core.fileMode false &&
+	git reset --hard change_notx_to_x_initial &&
+
+	git apply --index --reverse change_notx_to_x-0003-delete.patch &&
+	test_file_mode_staged 100755 change_notx_to_x &&
+	test_tick && git commit -m "undo: remove change_notx_to_x" &&
+	test_file_mode_HEAD 100755 change_notx_to_x &&
+
+	git apply --index --reverse change_notx_to_x-0002-chmod-0755.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 100644 change_notx_to_x &&
+	test_tick && git commit -m "undo: make change_notx_to_x executable" &&
+	test_file_mode_HEAD 100644 change_notx_to_x &&
+
+	git apply --index --reverse change_notx_to_x-0001-create-0644.patch 2>err &&
+	test_grep ! "has type 100.*, expected 100.*" err &&
+	test_file_mode_staged 000000 change_notx_to_x &&
+	test_tick && git commit -m "undo: add change_notx_to_x as not executable" &&
+	test_file_mode_HEAD 000000 change_notx_to_x
+'
+
 test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
 	cat >patch <<-\EOF &&
 	diff --git a/non-canon b/non-canon
-- 
2.49.0

