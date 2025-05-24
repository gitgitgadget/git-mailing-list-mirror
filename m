Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C84EC2
	for <git@vger.kernel.org>; Sat, 24 May 2025 03:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748058051; cv=none; b=IaVgo8urTzR+PrQ5t5uwQahEBWYAid1GEqvc8SsRDZOpt0sBT/oZJrObaQueVsCk7x6qr3uOIKkD2edUGdYpmX2QPdCxnKuds7pWsurOWgAHNyPswecV6F5+YUHSjOWO/1twUPCRsKnGGkZyF92EEQ1HBpzf89khMP6aoDRzjo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748058051; c=relaxed/simple;
	bh=MzL/nrV28kTkzLFKqYMPomqQ6ywU7l/bhXkdaSs06AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOWi8ncpeaLjbyxQp67YM85qKReN1aGWCtrh1E//IpOZufx7cgyGYEpT0QyF4mjEUA/9RGlyM8uUhpO1VXQFAKtbkQZh/uZydoPcdnzvmFp+sNeFgbDDxkAtU/gb61fhZ3i9xpCpIthGxce0TF5ANJ+XFyAhlY0Km4GkZGQ/MO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NC/JVgwz; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NC/JVgwz"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4774ce422easo4055401cf.1
        for <git@vger.kernel.org>; Fri, 23 May 2025 20:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748058048; x=1748662848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1trNakZ+9+Mx/KvcNXbtinQm55DI5AnyiHirbZTCW8=;
        b=NC/JVgwzoephpINYUDtzbIv5YnnpqDATa17oLq3FTQWKxbsjclJ4jZw5j1Wq3RfMgm
         Hm8Gkg5qnZTvJTK3zvfK2PFJYzNrDjY5Rnkc5bfwGu+YzMqZWzMgfrAPpOKlrjwpE33o
         oskwLIOt93xjBZx7tIWTncKrFtqBLGQwmhb/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748058048; x=1748662848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1trNakZ+9+Mx/KvcNXbtinQm55DI5AnyiHirbZTCW8=;
        b=a845J/QbVsWpDJMeVBbH9ie6bU+I8Tm3w6YWz6w8lEqYcq5TIEz7u4shr2YYMu9L0k
         Ax6OeudaEGt2L3aDovLWexi2vyUrOZq4xjQEAO2reYu/JioELRupH9K7NAIHzLxwMLFI
         cAT42spv4hPnXtDow3pDnQ8e/nxJggzQ2PtxYS2cttTA87GxfliV/5DxwxQ4IAu3SjUN
         rLEXkZ72UaPj8Ku2J91Vi/kwl0BmTM8QC5IYnF9ZhiQkyw3YILfIEuUFtYgtMJtra+Po
         5ddFT6BGgrRpL2C6y4rkArG8bqlOspnwtpGmC3859mcySQO3GhKvr4t9oGFtVAYZRlLU
         90GQ==
X-Gm-Message-State: AOJu0Yw7Ja8VBgOOilwpWP4YO7vcKz6fSThNNz3BaKfdCTbLCT/MXV6K
	IsVMsgxQVZx6ES7y9OR3RjyglAMCfxPVpebdwXq34xCb5Gkf+jZlWLtgczfQ728hh3t1r5Gc1Su
	Mgj73+A==
X-Gm-Gg: ASbGncuN/sVagLYyx/bUXtVQNJCPCR8k1P7SaGYkh/BnOsqy2llz4h5hzJ+VbEFW/nB
	BU5TLgK2S8pykyBg+eO4DLu7zwb68NJ2d38RJ+1LDMfMoLpj0oPnC4sKELNYIm+yHLScnFHfnZm
	+b0lp6258mJWHu+jMGikaKuPudCmfYmZrya59JgwHHvAtY46YsjUgZNcXvB3yc4w/na8ribYZD9
	M+bs81vT0Q6BGAIOxO9i7ZDR19WZhHSqgF8knGMSOUFeFHLCTiRc1SPoCXeZE0UySZAl4nvD8cP
	WUlUK8daIBNWOI/XvUY2PgpigYPZSFVTEFTDu5MkkGX2vB3bibCRODlkAoAVNkUJVChUbdo=
X-Google-Smtp-Source: AGHT+IHY9NVAPu9tQJHomG+EdL05yGIBernoFuwW0TSAnOn4fEA6dMmpNtQ+1SoxPuLpDHuDiE4i/A==
X-Received: by 2002:a05:622a:1c19:b0:477:41fa:1120 with SMTP id d75a77b69052e-49f4655a58amr25532391cf.12.1748058047834;
        Fri, 23 May 2025 20:40:47 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-497ae224a4bsm99001731cf.76.2025.05.23.20.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 20:40:47 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v3 0/2] apply: set file mode when --reverse creates a deleted file
Date: Fri, 23 May 2025 23:40:44 -0400
Message-ID: <20250524034046.2619-1-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523172154.93810-1-mark@chromium.org>
References: <20250523172154.93810-1-mark@chromium.org>
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
being set on the re-created file.

Changes from v2:
* test_file_mode_common correctly fails when requested to verify the
  presence of a file (by nonzero mode argument) that is actually absent.
* Test setup establishes tags at appropriate checkpoints with git tag,
  and tests restore those checkpoints with git reset --hard, making
  tests less sensitive to execution order and to the success of previous
  tests.
* test_file_mode_common accepts full 6-digit file modes instead of
  4-digit ones, and uses 000000 for absent files (as git diff --raw
  does) instead of an empty string.
* File presence is assured with >f as opposed to touch f. Minor style
* fix at the point of test_file_mode_common's declaration.

Changes from v1:
* Reword the commit message as requested.
* Refactor the new test in accordance with review feedback, splitting it
  up and increasing coverage.
* Introduce another new test for the specific problem that commit
  01aff0a (apply: correctly reverse patch's pre- and post-image mode
  bits, 2023-12-26) fixed.

Mark Mentovai (2):
  t4129: test that git apply warns for unexpected mode changes
  apply: set file mode when --reverse creates a deleted file

 apply.c                   |   2 +-
 t/t4129-apply-samemode.sh | 231 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 227 insertions(+), 6 deletions(-)

Range-diff against v2:
1:  a0af8d15f664 ! 1:  5ee7d4efe53e t4129: test that git apply warns for unexpected mode changes
    @@ t/t4129-apply-samemode.sh: test_expect_success POSIXPERM 'do not use core.shared
      
     +test_file_mode_staged () {
     +	git ls-files --stage -- "$2" >ls-files-output &&
    -+	test_grep "^10$1 " ls-files-output
    ++	test_grep "^$1 " ls-files-output
     +}
     +
     +test_file_mode_HEAD () {
     +	git ls-tree HEAD -- "$2" >ls-tree-output &&
    -+	test_grep "^10$1 " ls-tree-output
    ++	test_grep "^$1 " ls-tree-output
     +}
     +
      test_expect_success 'git apply respects core.fileMode' '
    @@ t/t4129-apply-samemode.sh: test_expect_success POSIXPERM 'do not use core.shared
      	git add --chmod=+x script.sh &&
     -	git ls-files -s script.sh >ls-files-output &&
     -	test_grep "^100755" ls-files-output &&
    -+	test_file_mode_staged 0755 script.sh &&
    ++	test_file_mode_staged 100755 script.sh &&
      	test_tick && git commit -m "Add script" &&
     -	git ls-tree -r HEAD script.sh >ls-tree-output &&
     -	test_grep "^100755" ls-tree-output &&
    -+	test_file_mode_HEAD 0755 script.sh &&
    ++	test_file_mode_HEAD 100755 script.sh &&
      
      	echo true >>script.sh &&
      	test_tick && git commit -m "Modify script" script.sh &&
    @@ t/t4129-apply-samemode.sh: test_expect_success 'git apply respects core.fileMode
     +test_expect_success 'setup: git apply [--reverse] warns about incorrect file modes' '
     +	test_config core.fileMode false &&
     +
    -+	touch mode_test &&
    ++	>mode_test &&
     +	git add --chmod=-x mode_test &&
    -+	test_file_mode_staged 0644 mode_test &&
    ++	test_file_mode_staged 100644 mode_test &&
     +	test_tick && git commit -m "add mode_test" &&
    -+	test_file_mode_HEAD 0644 mode_test &&
    ++	test_file_mode_HEAD 100644 mode_test &&
    ++	git tag mode_test_forward_initial &&
     +
     +	echo content >>mode_test &&
     +	test_tick && git commit -m "append to mode_test" mode_test &&
    -+	test_file_mode_HEAD 0644 mode_test &&
    ++	test_file_mode_HEAD 100644 mode_test &&
    ++	git tag mode_test_reverse_initial &&
     +
     +	git format-patch -1 --stdout >patch &&
    -+	test_grep "^index .* 100644$" patch &&
    -+
    -+	git add --chmod=+x mode_test &&
    -+	test_file_mode_staged 0755 mode_test &&
    -+	test_tick && git commit -m "make mode_test executable" &&
    -+	test_file_mode_HEAD 0755 mode_test
    ++	test_grep "^index .* 100644$" patch
     +'
     +
    -+test_expect_success 'git apply --reverse warns about incorrect file modes' '
    ++test_expect_success 'git apply warns about incorrect file modes' '
     +	test_config core.fileMode false &&
    ++	git reset --hard mode_test_forward_initial &&
     +
    -+	git apply --index --reverse patch 2>err &&
    ++	git add --chmod=+x mode_test &&
    ++	test_file_mode_staged 100755 mode_test &&
    ++	test_tick && git commit -m "make mode_test executable" &&
    ++	test_file_mode_HEAD 100755 mode_test &&
    ++
    ++	git apply --index patch 2>err &&
     +	test_grep "has type 100755, expected 100644" err &&
    -+	test_file_mode_staged 0755 mode_test &&
    -+	test_tick && git commit -m "undo append" &&
    -+	test_file_mode_HEAD 0755 mode_test
    ++	test_file_mode_staged 100755 mode_test &&
    ++	test_tick && git commit -m "redo: append to mode_test" &&
    ++	test_file_mode_HEAD 100755 mode_test
     +'
     +
    -+test_expect_success 'git apply warns about incorrect file modes' '
    ++test_expect_success 'git apply --reverse warns about incorrect file modes' '
     +	test_config core.fileMode false &&
    ++	git reset --hard mode_test_reverse_initial &&
     +
    -+	git apply --index patch 2>err &&
    ++	git add --chmod=+x mode_test &&
    ++	test_file_mode_staged 100755 mode_test &&
    ++	test_tick && git commit -m "make mode_test executable" &&
    ++	test_file_mode_HEAD 100755 mode_test &&
    ++
    ++	git apply --index --reverse patch 2>err &&
     +	test_grep "has type 100755, expected 100644" err &&
    -+	test_file_mode_staged 0755 mode_test &&
    -+	test_tick && git commit -m "redo append" &&
    -+	test_file_mode_HEAD 0755 mode_test
    ++	test_file_mode_staged 100755 mode_test &&
    ++	test_tick && git commit -m "undo: append to mode_test" &&
    ++	test_file_mode_HEAD 100755 mode_test
      '
      
      test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
2:  00760c9ec492 ! 2:  cc6f4b4af3b7 apply: set file mode when --reverse creates a deleted file
    @@ t/t4129-apply-samemode.sh: test_expect_success POSIXPERM 'do not use core.shared
      	)
      '
      
    -+test_file_mode_common() {
    -+	test -n "$1" && test_grep "^10$1 " "$2" || test_must_be_empty "$2"
    ++test_file_mode_common () {
    ++	if test "$1" = "000000"
    ++	then
    ++		test_must_be_empty "$2"
    ++	else
    ++		test_grep "^$1 " "$2"
    ++	fi
     +}
     +
      test_file_mode_staged () {
      	git ls-files --stage -- "$2" >ls-files-output &&
    --	test_grep "^10$1 " ls-files-output
    +-	test_grep "^$1 " ls-files-output
     +	test_file_mode_common "$1" ls-files-output
      }
      
      test_file_mode_HEAD () {
      	git ls-tree HEAD -- "$2" >ls-tree-output &&
    --	test_grep "^10$1 " ls-tree-output
    +-	test_grep "^$1 " ls-tree-output
     +	test_file_mode_common "$1" ls-tree-output
      }
      
      test_expect_success 'git apply respects core.fileMode' '
    -@@ t/t4129-apply-samemode.sh: test_expect_success 'git apply warns about incorrect file modes' '
    - 	test_file_mode_HEAD 0755 mode_test
    +@@ t/t4129-apply-samemode.sh: test_expect_success 'git apply --reverse warns about incorrect file modes' '
    + 	test_file_mode_HEAD 100755 mode_test
      '
      
     +test_expect_success 'setup: git apply [--reverse] restores file modes (change_x_to_notx)' '
    @@ t/t4129-apply-samemode.sh: test_expect_success 'git apply warns about incorrect
     +
     +	touch change_x_to_notx &&
     +	git add --chmod=+x change_x_to_notx &&
    -+	test_file_mode_staged 0755 change_x_to_notx &&
    ++	test_file_mode_staged 100755 change_x_to_notx &&
     +	test_tick && git commit -m "add change_x_to_notx as executable" &&
    -+	test_file_mode_HEAD 0755 change_x_to_notx &&
    ++	test_file_mode_HEAD 100755 change_x_to_notx &&
     +
     +	git add --chmod=-x change_x_to_notx &&
    -+	test_file_mode_staged 0644 change_x_to_notx &&
    ++	test_file_mode_staged 100644 change_x_to_notx &&
     +	test_tick && git commit -m "make change_x_to_notx not executable" &&
    -+	test_file_mode_HEAD 0644 change_x_to_notx &&
    ++	test_file_mode_HEAD 100644 change_x_to_notx &&
     +
     +	git rm change_x_to_notx &&
    -+	test_file_mode_staged "" change_x_to_notx &&
    ++	test_file_mode_staged 000000 change_x_to_notx &&
     +	test_tick && git commit -m "remove change_x_to_notx" &&
    -+	test_file_mode_HEAD "" change_x_to_notx &&
    ++	test_file_mode_HEAD 000000 change_x_to_notx &&
     +
     +	git format-patch -o patches -3 &&
     +	mv patches/0001-* change_x_to_notx-0001-create-0755.patch &&
    @@ t/t4129-apply-samemode.sh: test_expect_success 'git apply warns about incorrect
     +	test_grep "^new file mode 100755$" change_x_to_notx-0001-create-0755.patch &&
     +	test_grep "^old mode 100755$" change_x_to_notx-0002-chmod-0644.patch &&
     +	test_grep "^new mode 100644$" change_x_to_notx-0002-chmod-0644.patch &&
    -+	test_grep "^deleted file mode 100644$" change_x_to_notx-0003-delete.patch
    ++	test_grep "^deleted file mode 100644$" change_x_to_notx-0003-delete.patch &&
    ++
    ++	git tag change_x_to_notx_initial
     +'
     +
     +test_expect_success 'git apply restores file modes (change_x_to_notx)' '
     +	test_config core.fileMode false &&
    ++	git reset --hard change_x_to_notx_initial &&
     +
     +	git apply --index change_x_to_notx-0001-create-0755.patch &&
    -+	test_file_mode_staged 0755 change_x_to_notx &&
    ++	test_file_mode_staged 100755 change_x_to_notx &&
     +	test_tick && git commit -m "redo: add change_x_to_notx as executable" &&
    -+	test_file_mode_HEAD 0755 change_x_to_notx &&
    ++	test_file_mode_HEAD 100755 change_x_to_notx &&
     +
     +	git apply --index change_x_to_notx-0002-chmod-0644.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged 0644 change_x_to_notx &&
    ++	test_file_mode_staged 100644 change_x_to_notx &&
     +	test_tick && git commit -m "redo: make change_x_to_notx not executable" &&
    -+	test_file_mode_HEAD 0644 change_x_to_notx &&
    ++	test_file_mode_HEAD 100644 change_x_to_notx &&
     +
     +	git apply --index change_x_to_notx-0003-delete.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged "" change_x_to_notx &&
    ++	test_file_mode_staged 000000 change_x_to_notx &&
     +	test_tick && git commit -m "redo: remove change_notx_to_x" &&
    -+	test_file_mode_HEAD "" change_x_to_notx
    ++	test_file_mode_HEAD 000000 change_x_to_notx
     +'
     +
     +test_expect_success 'git apply --reverse restores file modes (change_x_to_notx)' '
     +	test_config core.fileMode false &&
    ++	git reset --hard change_x_to_notx_initial &&
     +
     +	git apply --index --reverse change_x_to_notx-0003-delete.patch &&
    -+	test_file_mode_staged 0644 change_x_to_notx &&
    ++	test_file_mode_staged 100644 change_x_to_notx &&
     +	test_tick && git commit -m "undo: remove change_x_to_notx" &&
    -+	test_file_mode_HEAD 0644 change_x_to_notx &&
    ++	test_file_mode_HEAD 100644 change_x_to_notx &&
     +
     +	git apply --index --reverse change_x_to_notx-0002-chmod-0644.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged 0755 change_x_to_notx &&
    ++	test_file_mode_staged 100755 change_x_to_notx &&
     +	test_tick && git commit -m "undo: make change_x_to_notx not executable" &&
    -+	test_file_mode_HEAD 0755 change_x_to_notx &&
    ++	test_file_mode_HEAD 100755 change_x_to_notx &&
     +
     +	git apply --index --reverse change_x_to_notx-0001-create-0755.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged "" change_x_to_notx &&
    ++	test_file_mode_staged 000000 change_x_to_notx &&
     +	test_tick && git commit -m "undo: add change_x_to_notx as executable" &&
    -+	test_file_mode_HEAD "" change_x_to_notx
    ++	test_file_mode_HEAD 000000 change_x_to_notx
     +'
     +
     +test_expect_success 'setup: git apply [--reverse] restores file modes (change_notx_to_x)' '
    @@ t/t4129-apply-samemode.sh: test_expect_success 'git apply warns about incorrect
     +
     +	touch change_notx_to_x &&
     +	git add --chmod=-x change_notx_to_x &&
    -+	test_file_mode_staged 0644 change_notx_to_x &&
    ++	test_file_mode_staged 100644 change_notx_to_x &&
     +	test_tick && git commit -m "add change_notx_to_x as not executable" &&
    -+	test_file_mode_HEAD 0644 change_notx_to_x &&
    ++	test_file_mode_HEAD 100644 change_notx_to_x &&
     +
     +	git add --chmod=+x change_notx_to_x &&
    -+	test_file_mode_staged 0755 change_notx_to_x &&
    ++	test_file_mode_staged 100755 change_notx_to_x &&
     +	test_tick && git commit -m "make change_notx_to_x executable" &&
    -+	test_file_mode_HEAD 0755 change_notx_to_x &&
    ++	test_file_mode_HEAD 100755 change_notx_to_x &&
     +
     +	git rm change_notx_to_x &&
    -+	test_file_mode_staged "" change_notx_to_x &&
    ++	test_file_mode_staged 000000 change_notx_to_x &&
     +	test_tick && git commit -m "remove change_notx_to_x" &&
    -+	test_file_mode_HEAD "" change_notx_to_x &&
    ++	test_file_mode_HEAD 000000 change_notx_to_x &&
     +
     +	git format-patch -o patches -3 &&
     +	mv patches/0001-* change_notx_to_x-0001-create-0644.patch &&
    @@ t/t4129-apply-samemode.sh: test_expect_success 'git apply warns about incorrect
     +	test_grep "^new file mode 100644$" change_notx_to_x-0001-create-0644.patch &&
     +	test_grep "^old mode 100644$" change_notx_to_x-0002-chmod-0755.patch &&
     +	test_grep "^new mode 100755$" change_notx_to_x-0002-chmod-0755.patch &&
    -+	test_grep "^deleted file mode 100755$" change_notx_to_x-0003-delete.patch
    ++	test_grep "^deleted file mode 100755$" change_notx_to_x-0003-delete.patch &&
    ++
    ++	git tag change_notx_to_x_initial
     +'
     +
     +test_expect_success 'git apply restores file modes (change_notx_to_x)' '
     +	test_config core.fileMode false &&
    ++	git reset --hard change_notx_to_x_initial &&
     +
     +	git apply --index change_notx_to_x-0001-create-0644.patch &&
    -+	test_file_mode_staged 0644 change_notx_to_x &&
    ++	test_file_mode_staged 100644 change_notx_to_x &&
     +	test_tick && git commit -m "redo: add change_notx_to_x as not executable" &&
    -+	test_file_mode_HEAD 0644 change_notx_to_x &&
    ++	test_file_mode_HEAD 100644 change_notx_to_x &&
     +
     +	git apply --index change_notx_to_x-0002-chmod-0755.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged 0755 change_notx_to_x &&
    ++	test_file_mode_staged 100755 change_notx_to_x &&
     +	test_tick && git commit -m "redo: make change_notx_to_x executable" &&
    -+	test_file_mode_HEAD 0755 change_notx_to_x &&
    ++	test_file_mode_HEAD 100755 change_notx_to_x &&
     +
     +	git apply --index change_notx_to_x-0003-delete.patch &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged "" change_notx_to_x &&
    ++	test_file_mode_staged 000000 change_notx_to_x &&
     +	test_tick && git commit -m "undo: remove change_notx_to_x" &&
    -+	test_file_mode_HEAD "" change_notx_to_x
    ++	test_file_mode_HEAD 000000 change_notx_to_x
     +'
     +
     +test_expect_success 'git apply --reverse restores file modes (change_notx_to_x)' '
     +	test_config core.fileMode false &&
    ++	git reset --hard change_notx_to_x_initial &&
     +
     +	git apply --index --reverse change_notx_to_x-0003-delete.patch &&
    -+	test_file_mode_staged 0755 change_notx_to_x &&
    ++	test_file_mode_staged 100755 change_notx_to_x &&
     +	test_tick && git commit -m "undo: remove change_notx_to_x" &&
    -+	test_file_mode_HEAD 0755 change_notx_to_x &&
    ++	test_file_mode_HEAD 100755 change_notx_to_x &&
     +
     +	git apply --index --reverse change_notx_to_x-0002-chmod-0755.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged 0644 change_notx_to_x &&
    ++	test_file_mode_staged 100644 change_notx_to_x &&
     +	test_tick && git commit -m "undo: make change_notx_to_x executable" &&
    -+	test_file_mode_HEAD 0644 change_notx_to_x &&
    ++	test_file_mode_HEAD 100644 change_notx_to_x &&
     +
     +	git apply --index --reverse change_notx_to_x-0001-create-0644.patch 2>err &&
     +	test_grep ! "has type 100.*, expected 100.*" err &&
    -+	test_file_mode_staged "" change_notx_to_x &&
    ++	test_file_mode_staged 000000 change_notx_to_x &&
     +	test_tick && git commit -m "undo: add change_notx_to_x as not executable" &&
    -+	test_file_mode_HEAD "" change_notx_to_x
    ++	test_file_mode_HEAD 000000 change_notx_to_x
     +'
     +
      test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
-- 
2.49.0

