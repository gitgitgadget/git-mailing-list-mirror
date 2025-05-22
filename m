Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0CA25FA26
	for <git@vger.kernel.org>; Thu, 22 May 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747951359; cv=none; b=JsYp5GTGHOui3znEd4PrSoI3tW1bfpBHcFp+dTzyJcRsrFvNIGUXqhaGLYIFMPqn8g1HlhkzkE4+aAgZN1YmXQcOcupJC9swYCI5fBABg2vs1CQN6QhVKxiq30tsPUiQJTqSCOUE+M5236cXZjPfm+smO8OSutQT7KgJCfbWJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747951359; c=relaxed/simple;
	bh=Vr3sIZLajGJzB/ZRTwQzaI/+u6F6Aqe+6ir/O2K5gBg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KwXzrK6oJm0mR+GqfLwqKPx2mNM7yN357UPtr0Zxria1eZh667BIGsEY9nXoFgcSGHZNTRC43ctXVxEABL4vil4+oloojKxEaI2KZIBbRH+3uwbXnqOGrrxwTO4PyMSavYJto7ksy8l4BzWB/YRZpr1w0R68OlTkmhtthb384eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KnNPTeSl; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KnNPTeSl"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f8ce89468cso55687256d6.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 15:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1747951356; x=1748556156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=07Uh+oxecFokcYod6iakj4SQyQWJrEcl/yn+JSG8P8U=;
        b=KnNPTeSlaKGi3vyeap+y2QqHzg7TElbSHLs8RqBgjOm+tb3Yw0oHd4yRgPZmkFdXB1
         Hm/nmfdhjuGw+vHIYL30e4lQNefHlnsJIAjNi7FrMVSapEOYcx46iRa6V8I4BF2rRidw
         PIKchT099NzRyBUaxpw2/1mkGHQg/+5bHfDZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747951356; x=1748556156;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07Uh+oxecFokcYod6iakj4SQyQWJrEcl/yn+JSG8P8U=;
        b=M7pWYySu2mrT9V1+galELGSWE5cMbhGH8LaW4wnr2NE4/ug0npPZmdkMxNo5oF56pp
         4iZuNXZ6TVmazeGabKtBQz+uB7siwZKrTv6URideq7xs4XwrbJHr3wT0WDgrOfittx4l
         FyGFZMdVKdvizMM8AFA564SzhvwwbZiHeJOgPjjGGduxbbMNrPrqXy2iNAkUcGZNMDDU
         c4kVU1UR9uqaXz0EbM0RXLD9rh2a2XlGexlC8zxT7UuSN7wZxCgVDxKPk0d+kH7ZQpoK
         csSJKHcKNST2jJJ3fY45syCKzWiI13maLD7vXZ+XYwhJE6ZTC4uEqkcHUdOZkOsO1Pnt
         3F4A==
X-Gm-Message-State: AOJu0YyKf/QJ88m9gG/yUuWYbmG8bxzNH7/nf2imvrvdNSd7v5flUqIG
	K3HiQQkMIiLG997V5msDj/yidssRO21WEY+/xCX4FzY7Scy+k6/2DU16fiRX+PF0Apqj0a6EsVi
	qTIIdQw==
X-Gm-Gg: ASbGncuWuJuGALFwdNlz3qKkRkqq+TMpnZNmL/ScWs9LFiMvWbDeaakodf6WSntixFz
	L5HZJxkPD+18grnUx1GfSAStRpJ5ZT3VdL3gzDkGfTtZP9ghgHfHiGTFX5fOcCfNDh0kiF0zQVT
	f0knwhmDtia4I90A32nzLVRXJ7gerWgMrthP4/VBe6iusPIvhlWOgrLE5jnzmOB/lpBE9PwmguP
	aOfo2azYhzvzdehomlviRCeaR+e8uPkQonGSA0+p/OaRzxBr1XpqTp2LTujYBnqRXjaPwsvct/R
	vYXyyVjhuykNRhFJwVpetlcf/tLsO2ZEBius48HdIXM2SUvuZ8/gF0/94waw1XWR1820ffc=
X-Google-Smtp-Source: AGHT+IFSriJ9zmz1RuKfut7gqaL2epUE6iz7kbrzP/AnYIv2BN3kQpzffYR2R1DnXAJOTFs3evcR8Q==
X-Received: by 2002:a05:6214:1c4f:b0:6f8:c23c:525c with SMTP id 6a1803df08f44-6f8c23c8530mr402565156d6.7.1747951356483;
        Thu, 22 May 2025 15:02:36 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:419d:cdd5:ee68:cf36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b8778237sm96450076d6.17.2025.05.22.15.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:02:36 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] apply: set file mode when --reverse creates a deleted file
Date: Thu, 22 May 2025 18:02:35 -0400
Message-ID: <20250522220235.8650-1-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
mode bits; 2023-12-26) revised reverse_patches() to maintain the desired
property that when only one of patch::old_mode and patch::new_mode is
set, the mode will be carried in old_mode. That property is generally
correct, with one notable notable exception: when creating a file, only
new_mode will be set. Since reversing a deletion results in a creation,
new_mode must be set in that case.

Omitting handling for this case meant that reversing a patch that
removed an executable file would not result in the executable permission
being set on the re-created file.

When git apply --reverse is used, reverse_patches() will now additionaly
swap old_mode and new_mode for what's represented in the patch as a file
deletion, as it is transformed into a file creation under reversal.

Tests are added that ensure that git apply sets file modes correctly on
file creation, both in the normal (forward) and reverse direction.
Existing test coverage for file modes focused only on mode changes of
existing files, and only in the forward direction.

Signed-off-by: Mark Mentovai <mark@chromium.org>
---
 apply.c                   |   2 +-
 t/t4129-apply-samemode.sh | 117 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 2 deletions(-)

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
index 2149ad5da44c..036613ad8fed 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -124,9 +124,124 @@ test_expect_success 'git apply respects core.fileMode' '
 
 	git apply patch 2>err &&
 	test_grep ! "has type 100644, expected 100755" err &&
+	git reset --hard &&
 
 	git apply --cached patch 2>err &&
-	test_grep ! "has type 100644, expected 100755" err
+	test_grep ! "has type 100644, expected 100755" err &&
+	git reset --hard
+'
+
+test_expect_success 'git apply restores file modes' '
+	test_config core.fileMode false &&
+	echo "This is data, do not execute!" >data.txt &&
+	git add --chmod=+x data.txt &&
+	git ls-files -s data.txt >ls-files-output &&
+	test_grep "^100755" ls-files-output &&
+	test_tick && git commit -m "Add data" &&
+	git ls-tree -r HEAD data.txt >ls-tree-output &&
+	test_grep "^100755" ls-tree-output &&
+	git checkout -- data.txt &&
+
+	git add --chmod=-x data.txt &&
+	git ls-files -s data.txt >ls-files-output &&
+	test_grep "^100644" ls-files-output &&
+	test_tick && git commit -m "Make data non-executable" &&
+	git ls-tree -r HEAD data.txt >ls-tree-output &&
+	test_grep "^100644" ls-tree-output &&
+	git checkout -- data.txt &&
+
+	git rm data.txt &&
+	git ls-files -s data.txt >ls-files-output &&
+	test_must_be_empty ls-files-output &&
+	test_tick && git commit -m "Remove data" &&
+	git ls-tree -r HEAD data.txt >ls-tree-output &&
+	test_must_be_empty ls-tree-output &&
+
+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
+	test_grep "^new file mode 100755$" patch &&
+	git apply --index patch &&
+	git ls-files -s data.txt >ls-files-output &&
+	test_grep "^100755" ls-files-output &&
+	test_tick && git commit -m "Re-add data" &&
+	git ls-tree -r HEAD data.txt >ls-tree-output &&
+	test_grep "^100755" ls-tree-output &&
+
+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
+	test_grep "^old mode 100755$" patch &&
+	test_grep "^new mode 100644$" patch &&
+	git apply --index patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err &&
+	git ls-files -s data.txt >ls-files-output &&
+	test_grep "^100644" ls-files-output &&
+	test_tick && git commit -m "Redo data mode change" &&
+	git ls-tree -r HEAD data.txt >ls-tree-output &&
+	test_grep "^100644" ls-tree-output &&
+
+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
+	test_grep "^deleted file mode 100644$" patch &&
+	git apply --index patch 2>err &&
+	test_grep ! "has type 100755, expected 100644" err &&
+	git ls-files -s data.txt >ls-files-output &&
+	test_must_be_empty ls-files-output &&
+	test_tick && git commit -m "Redo data removal" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_must_be_empty ls-tree-output
+'
+
+test_expect_success 'git apply --reverse restores file modes' '
+	test_config core.fileMode false &&
+	echo true >tool.sh &&
+	git add --chmod=-x tool.sh &&
+	git ls-files -s tool.sh >ls-files-output &&
+	test_grep "^100644" ls-files-output &&
+	test_tick && git commit -m "Add tool" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_grep "^100644" ls-tree-output &&
+
+	git add --chmod=+x tool.sh &&
+	git ls-files -s tool.sh >ls-files-output &&
+	test_grep "^100755" ls-files-output &&
+	test_tick && git commit -m "Make tool executable" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_grep "^100755" ls-tree-output &&
+	git checkout -- tool.sh &&
+
+	git rm tool.sh &&
+	git ls-files -s tool.sh >ls-files-output &&
+	test_must_be_empty ls-files-output &&
+	test_tick && git commit -m "Remove tool" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_must_be_empty ls-tree-output &&
+
+	git format-patch -1 --stdout >patch &&
+	test_grep "^deleted file mode 100755$" patch &&
+	git apply --index --reverse patch &&
+	git ls-files -s tool.sh >ls-files-output &&
+	test_grep "^100755" ls-files-output &&
+	test_tick && git commit -m "Undo tool removal" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_grep "^100755" ls-tree-output &&
+
+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
+	test_grep "^old mode 100644$" patch &&
+	test_grep "^new mode 100755$" patch &&
+	git apply --index --reverse patch 2>err &&
+	test_grep ! "has type 100644, expected 100755" err &&
+	git ls-files -s tool.sh >ls-files-output &&
+	test_grep "^100644" ls-files-output &&
+	test_tick && git commit -m "Undo tool mode change" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_grep "^100644" ls-tree-output &&
+
+	git format-patch HEAD~5..HEAD~4 --stdout >patch &&
+	test_grep "^new file mode 100644$" patch &&
+	git apply --index --reverse patch 2>err &&
+	test_grep ! "has type 100755, expected 100644" err &&
+	git ls-files -s tool.sh >ls-files-output &&
+	test_must_be_empty ls-files-output &&
+	test_tick && git commit -m "Undo tool addition" &&
+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
+	test_must_be_empty ls-tree-output
 '
 
 test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
-- 
2.49.0

