Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170F438FB9
	for <git@vger.kernel.org>; Sat, 18 May 2024 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716028380; cv=none; b=LPx+YNzN6iSAB/EjtA/16g4tPlEvuWbLy8QOyM/8xG7yxFUrs7M46MvSIhOBeZz8RmGYIcRG11BEPD08+XRDoDmhFJjcRbLKgdFHXclSucx5m+PBD0yygz2B4gD6nArQq+vvvmieLEH30lp/hIrSWrxN+CKtYy9gHwOLf9BYL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716028380; c=relaxed/simple;
	bh=m6kiufg4gp0OgW3ZydyK6oNOG9SdNtqfifm5s8dBLVc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WqCVHj7fqL/O/sEZy4Pi9ekSLhoadJBiGLyWM9rhazDOW56L1G8sjCNVaWPmYfdx7STqDK2JJS0wa0kvFku48sX/lvRoKrEBecgys7bP5KH6RJbsMqP5ye9o5KRua77PXlYfymZzGIYBVuwYjb8B5Lapg8pNuruAmkAyJwUQoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuU5qDRe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuU5qDRe"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-351d309bbecso779484f8f.2
        for <git@vger.kernel.org>; Sat, 18 May 2024 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716028377; x=1716633177; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOk3FTAovndPzq/IQ222GiH3kGFhNLcCQqINN45WbRo=;
        b=AuU5qDReUluMqLN0HVujY9OnyImu7irF4/khbrAaOaVG6duSRjdTRkgdqNGzEYwESt
         8/X1I/xKUU7HV+pjRHvc3kkdRoRwbn4ZI+Ey6vdtPChC0e8yXmRc9NwrFTngXAyUOfXD
         y9ojgPG3fH9OdRF4IN3iNZ1Zs1Bo1s9Q9XzSVnIg9OLltCeFAKj7hNI9slW5ZGA0/tgO
         D8vh22YEId1SoHrfbW7gRAxWVrO9r8Vdr3UgoU8ilC3DRDPXYfssuuD/IZUmohh2dfQz
         MzdlsOGJmhZy592S7qt2j+w+jT1Kv00THodv5dcAhmLs7hp3n5pcyyA6e8z27YV55L0u
         x4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716028377; x=1716633177;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOk3FTAovndPzq/IQ222GiH3kGFhNLcCQqINN45WbRo=;
        b=tCSNRKzGnDPICr8LJNfNq5h2ZAKt7MLDq1LR2d30h2Jk/U7VWjlUzYbv5ItLkeBXDy
         3okYnFu9z3J18AU7+bdzUxKW+rBqjgfn2byc6Czx1z5Tb5r6tUabYAEKSVySkByKq/Eo
         osrNQLcXczGh2B/c+g6f552biCwJI4zWJF4KakfSw8QfoYZ4uHffIxkOKeYdWOepK3Ha
         To5d7XIxwoTBxaI4X6HVDpjQ3lbWUN9QuLyhdiRX4q1wnQt2klDO2UP+VqlFNy3GpMjm
         nB63eHfg4FOhRZSz3AzWtdSi5UBZGnLe8Yyy+JKMGl4e2Q4NXbHFvoQTvgIxNzpdGoso
         XLbQ==
X-Gm-Message-State: AOJu0Yz8CzPdtW2SxkWUyDZAIL6hua8otS1EKFK6o4NFCiEQQt9iTWsj
	tLP9627gsEarGSi1JEdiyb3WmlS0NHJCgS+0WmnArCYDSpJck00fy9ov5w==
X-Google-Smtp-Source: AGHT+IFoDZr3Dr+CBC0h/TtaeiC/iyozurd/24MCowrYE946eV09QLz36fx4SBRJZwLXtzXUECrlGQ==
X-Received: by 2002:adf:e8c1:0:b0:351:daf5:e28b with SMTP id ffacd0b85a97d-351daf5e375mr6558647f8f.23.1716028376661;
        Sat, 18 May 2024 03:32:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fd10cf8besm177802195e9.1.2024.05.18.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 May 2024 03:32:56 -0700 (PDT)
Message-Id: <5e5128bc232fbb822925efde20395484354492b6.1716028367.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
	<pull.1732.v2.git.1716028366.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 18 May 2024 10:32:44 +0000
Subject: [PATCH v2 6/8] hooks(clone protections): special-case current Git LFS
 hooks
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A notable regression in v2.45.1 and friends (all the way down to
v2.39.4) has been that Git LFS-enabled clones error out with a message
indicating that the `post-checkout` hook has been tampered with while
cloning, and as a safety measure it is not executed.

A generic fix for benign third-party applications wishing to write hooks
during clone operations has been implemented in the parent of this
commit: said applications are expected to add `safe.hook.sha256` values
to a protected config.

However, the current version of Git LFS, v3.5.1, cannot be adapted
retroactively; Therefore, let's just hard-code the SHA-256 values for
this version. That way, Git LFS usage will no longer be broken, and the
next Git LFS version can be taught to add those `safe.hook.sha256`
entries.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 hook.c          | 11 +++++++++++
 t/t1800-hook.sh | 20 ++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/hook.c b/hook.c
index a2479738451..f81b13df142 100644
--- a/hook.c
+++ b/hook.c
@@ -77,6 +77,17 @@ static int is_hook_safe_during_clone(const char *name, const char *path, char *s
 
 	if (!safe_hook_sha256s_initialized) {
 		safe_hook_sha256s_initialized = 1;
+
+		/* Hard-code known-safe values for Git LFS v3.4.0..v3.5.1 */
+		/* pre-push */
+		strset_add(&safe_hook_sha256s, "df5417b2daa3aa144c19681d1e997df7ebfe144fb7e3e05138bd80ae998008e4");
+		/* post-checkout */
+		strset_add(&safe_hook_sha256s, "791471b4ff472aab844a4fceaa48bbb0a12193616f971e8e940625498b4938a6");
+		/* post-commit */
+		strset_add(&safe_hook_sha256s, "21e961572bb3f43a5f2fbafc1cc764d86046cc2e5f0bbecebfe9684a0b73b664");
+		/* post-merge */
+		strset_add(&safe_hook_sha256s, "75da0da66a803b4b030ad50801ba57062c6196105eb1d2251590d100edb9390b");
+
 		git_protected_config(safe_hook_cb, &safe_hook_sha256s);
 	}
 
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 0f74c9154d0..af66999aff3 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -192,4 +192,24 @@ test_expect_success '`safe.hook.sha256` and clone protections' '
 	test "called hook" = "$(cat safe-hook/safe-hook.log)"
 '
 
+write_lfs_pre_push_hook () {
+	write_script "$1" <<-\EOF
+	command -v git-lfs >/dev/null 2>&1 || { echo >&2 "\nThis repository is configured for Git LFS but 'git-lfs' was not found on your path. If you no longer wish to use Git LFS, remove this hook by deleting the 'pre-push' file in the hooks directory (set by 'core.hookspath'; usually '.git/hooks').\n"; exit 2; }
+	git lfs pre-push "$@"
+	EOF
+}
+
+test_expect_success 'Git LFS special-handling in clone protections' '
+	git init lfs-hooks &&
+	write_lfs_pre_push_hook lfs-hooks/.git/hooks/pre-push &&
+	write_script git-lfs <<-\EOF &&
+	echo "called $*" >fake-git-lfs.log
+	EOF
+
+	PATH="$PWD:$PATH" GIT_CLONE_PROTECTION_ACTIVE=true \
+		git -C lfs-hooks hook run pre-push &&
+	test_write_lines "called pre-push" >expect &&
+	test_cmp lfs-hooks/fake-git-lfs.log expect
+'
+
 test_done
-- 
gitgitgadget

