Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE1298988
	for <git@vger.kernel.org>; Fri, 23 May 2025 17:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748020919; cv=none; b=JFmfqxQlIgMaNuRaKWOZoGOqRNgMycHEDGKXrOkyk8W3bptL3HcieIqOMsAiKfhvKG7lEGz5idHCF9rIWDjc1F5OwY2VKPfl4cMsTf4sLCLbvddisLZu3iXX2kfxL+KcbGSK9oc4WFheSHr3u8Rw2G7C7TRWKG/ti4FuVpQw9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748020919; c=relaxed/simple;
	bh=R0K4K8De/k+bUigioXhLUhVNJjvJKCy4S0ccBlIu5iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXtf5D8g+49HpWD3vVHtBfxb2MMgwUdRWejH5pk7nJiz1wDBqgBfFy9PCgSUqk3gAlYPCwI4qkCxuOozGFD8ee8+duRAgrkaWDqgQUO3bpRvxB2ddU4tS2DNZZKTgftv3ei4yB8RxPLX13XEoq0KB9yR8A+kHfgVmKKX69Jj6SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZpV4ZX4x; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZpV4ZX4x"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-476af5479feso737021cf.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 10:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748020916; x=1748625716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HnWwxLMFhl4vOeO0s0FANDAyw/+cj+PPdWn1xP1p/c=;
        b=ZpV4ZX4xOmpCUjqSCHSyoDp54CA9rx7uaXxmIYwCYJc/nA2cMrr/porFYtGhwgqdpT
         qw/O3Gk9Mz7ZuxRXWg/hOPeAAw7gA0RsdL0fLpZLDtN0oBzls/AXPDrMh5o7trmDDpJM
         8jQP+WTZOgwn40zSbjVQ1bRIQY5hV05Ylitqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748020916; x=1748625716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2HnWwxLMFhl4vOeO0s0FANDAyw/+cj+PPdWn1xP1p/c=;
        b=hftDlyU0t/92uODjpekg4pDo6n/8id/MKg4zqnxWsLGVR2MfG+UTvBYyJGbMyIpteV
         cfUdGwBbuad/KrGNJ0xxBxDr/2hHqhrJqSBiLxhN6MOEISrlNdY5hWcjNWpOpmeCxwTA
         igCb1ngKEVcmOM6aOtGGqTXWqqqkcYGTJEctZLYRq0qvqbAwB5j2tO4OzDaXJugCicxz
         p5a+GPNU+y63H1fgQzidwg+4ZJh/aiRB8JaA4+Ku+iX6htJzhwcZqL5uJAHMdZpOnQ4e
         6P0dpOqi9VyLNO5F8fAli8MhzizT/V7SeK7FLbfOSCS9Unq94JDzNO1/5sz6hHFxUhKj
         YChg==
X-Gm-Message-State: AOJu0Yys3K1J9pzQnB7WB4tXV2xBxF7qOr4Te9fPffHGavpgqA7AMSgy
	T5BLE811YFQ0A77gSHVCc0AP9MobbFXkh4Jj0U9yGMt7aH4G9S72tP/frMoXGtZNmp4bwfkIWEC
	I/1T0QQ==
X-Gm-Gg: ASbGncvBrk42nVwoBgtsOZdGcrMPI3OJJrD2wJA5pKBQTmo7jt+rRhu+eQaBtXnvF7i
	tB5vu2BkWlwzZZxbnHoj0x6g/qoUK4Z6cxXYU/ltZfuA4Yr8Di1qTjYUhp5GoamRJRpMQyaDndc
	2sxVbQXi7NdSOCZAGup2kGG87qwAuMyjtlqnCCpG7rcqNffD25xv+EghNEPN7qqTfOCSWk+yWTX
	9gG5SLib6FED/6h5lKhy5y3Lr/aaCgX++FfGiURWwJXVKDo0z0AKBYC/eUj7eUE4JO0G+Ioo90p
	tUc+IV5A6E8fTsqn1QVtH24yOwdDSO6WeXXAC3vzIrgI4TwXOE5wunRLzrrjMugX+z4GJ10=
X-Google-Smtp-Source: AGHT+IHhYY8SlauBN/7TwQGdBAParyXivrQjTHSSh7QROzKIqrCVDoKIIEO2tQWEsd7rZgZ5PlCvxw==
X-Received: by 2002:a05:622a:4245:b0:476:9847:7c6e with SMTP id d75a77b69052e-49f4674db19mr145201cf.19.1748020915933;
        Fri, 23 May 2025 10:21:55 -0700 (PDT)
Received: from redacted ([2600:4040:9ce0:6400:e585:dc50:f5e1:64e7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-494ae3cd517sm116219891cf.10.2025.05.23.10.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 10:21:55 -0700 (PDT)
From: Mark Mentovai <mark@chromium.org>
To: Git Development <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v2 0/2] apply: set file mode when --reverse creates a deleted file
Date: Fri, 23 May 2025 13:21:52 -0400
Message-ID: <20250523172154.93810-1-mark@chromium.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250522220235.8650-1-mark@chromium.org>
References: <20250522220235.8650-1-mark@chromium.org>
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
 t/t4129-apply-samemode.sh | 209 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 205 insertions(+), 6 deletions(-)

Range-diff against v1:
-:  ------------ > 1:  a0af8d15f664 t4129: test that git apply warns for unexpected mode changes
1:  457ab75888cc ! 2:  00760c9ec492 apply: set file mode when --reverse creates a deleted file
    @@ Commit message
         apply: set file mode when --reverse creates a deleted file
     
         Commit 01aff0a (apply: correctly reverse patch's pre- and post-image
    -    mode bits; 2023-12-26) revised reverse_patches() to maintain the desired
    +    mode bits, 2023-12-26) revised reverse_patches() to maintain the desired
         property that when only one of patch::old_mode and patch::new_mode is
         set, the mode will be carried in old_mode. That property is generally
    -    correct, with one notable notable exception: when creating a file, only
    -    new_mode will be set. Since reversing a deletion results in a creation,
    -    new_mode must be set in that case.
    +    correct, with one notable exception: when creating a file, only new_mode
    +    will be set. Since reversing a deletion results in a creation, new_mode
    +    must be set in that case.
     
    -    Omitting handling for this case meant that reversing a patch that
    -    removed an executable file would not result in the executable permission
    -    being set on the re-created file.
    +    Omitting handling for this case means that reversing a patch that
    +    removes an executable file will not result in the executable permission
    +    being set on the re-created file. Existing test coverage for file modes
    +    focuses only on mode changes of existing files.
     
    -    When git apply --reverse is used, reverse_patches() will now additionaly
    -    swap old_mode and new_mode for what's represented in the patch as a file
    -    deletion, as it is transformed into a file creation under reversal.
    +    Swap old_mode and new_mode in reverse_patches() for what's represented
    +    in the patch as a file deletion, as it is transformed into a file
    +    creation under reversal. This causes git apply --reverse to set the
    +    executable permission properly when re-creating a deleted executable
    +    file.
     
    -    Tests are added that ensure that git apply sets file modes correctly on
    -    file creation, both in the normal (forward) and reverse direction.
    -    Existing test coverage for file modes focused only on mode changes of
    -    existing files, and only in the forward direction.
    +    Add tests ensuring that git apply sets file modes correctly on file
    +    creation, both in the forward and reverse directions.
     
         Signed-off-by: Mark Mentovai <mark@chromium.org>
     
    @@ apply.c: static void reverse_patches(struct patch *p)
      		SWAP(p->lines_added, p->lines_deleted);
     
      ## t/t4129-apply-samemode.sh ##
    -@@ t/t4129-apply-samemode.sh: test_expect_success 'git apply respects core.fileMode' '
    +@@ t/t4129-apply-samemode.sh: test_expect_success POSIXPERM 'do not use core.sharedRepository for working tree
    + 	)
    + '
    + 
    ++test_file_mode_common() {
    ++	test -n "$1" && test_grep "^10$1 " "$2" || test_must_be_empty "$2"
    ++}
    ++
    + test_file_mode_staged () {
    + 	git ls-files --stage -- "$2" >ls-files-output &&
    +-	test_grep "^10$1 " ls-files-output
    ++	test_file_mode_common "$1" ls-files-output
    + }
      
    - 	git apply patch 2>err &&
    - 	test_grep ! "has type 100644, expected 100755" err &&
    -+	git reset --hard &&
    + test_file_mode_HEAD () {
    + 	git ls-tree HEAD -- "$2" >ls-tree-output &&
    +-	test_grep "^10$1 " ls-tree-output
    ++	test_file_mode_common "$1" ls-tree-output
    + }
      
    - 	git apply --cached patch 2>err &&
    --	test_grep ! "has type 100644, expected 100755" err
    -+	test_grep ! "has type 100644, expected 100755" err &&
    -+	git reset --hard
    + test_expect_success 'git apply respects core.fileMode' '
    +@@ t/t4129-apply-samemode.sh: test_expect_success 'git apply warns about incorrect file modes' '
    + 	test_file_mode_HEAD 0755 mode_test
    + '
    + 
    ++test_expect_success 'setup: git apply [--reverse] restores file modes (change_x_to_notx)' '
    ++	test_config core.fileMode false &&
    ++
    ++	touch change_x_to_notx &&
    ++	git add --chmod=+x change_x_to_notx &&
    ++	test_file_mode_staged 0755 change_x_to_notx &&
    ++	test_tick && git commit -m "add change_x_to_notx as executable" &&
    ++	test_file_mode_HEAD 0755 change_x_to_notx &&
    ++
    ++	git add --chmod=-x change_x_to_notx &&
    ++	test_file_mode_staged 0644 change_x_to_notx &&
    ++	test_tick && git commit -m "make change_x_to_notx not executable" &&
    ++	test_file_mode_HEAD 0644 change_x_to_notx &&
    ++
    ++	git rm change_x_to_notx &&
    ++	test_file_mode_staged "" change_x_to_notx &&
    ++	test_tick && git commit -m "remove change_x_to_notx" &&
    ++	test_file_mode_HEAD "" change_x_to_notx &&
    ++
    ++	git format-patch -o patches -3 &&
    ++	mv patches/0001-* change_x_to_notx-0001-create-0755.patch &&
    ++	mv patches/0002-* change_x_to_notx-0002-chmod-0644.patch &&
    ++	mv patches/0003-* change_x_to_notx-0003-delete.patch &&
    ++
    ++	test_grep "^new file mode 100755$" change_x_to_notx-0001-create-0755.patch &&
    ++	test_grep "^old mode 100755$" change_x_to_notx-0002-chmod-0644.patch &&
    ++	test_grep "^new mode 100644$" change_x_to_notx-0002-chmod-0644.patch &&
    ++	test_grep "^deleted file mode 100644$" change_x_to_notx-0003-delete.patch
     +'
     +
    -+test_expect_success 'git apply restores file modes' '
    ++test_expect_success 'git apply restores file modes (change_x_to_notx)' '
     +	test_config core.fileMode false &&
    -+	echo "This is data, do not execute!" >data.txt &&
    -+	git add --chmod=+x data.txt &&
    -+	git ls-files -s data.txt >ls-files-output &&
    -+	test_grep "^100755" ls-files-output &&
    -+	test_tick && git commit -m "Add data" &&
    -+	git ls-tree -r HEAD data.txt >ls-tree-output &&
    -+	test_grep "^100755" ls-tree-output &&
    -+	git checkout -- data.txt &&
    -+
    -+	git add --chmod=-x data.txt &&
    -+	git ls-files -s data.txt >ls-files-output &&
    -+	test_grep "^100644" ls-files-output &&
    -+	test_tick && git commit -m "Make data non-executable" &&
    -+	git ls-tree -r HEAD data.txt >ls-tree-output &&
    -+	test_grep "^100644" ls-tree-output &&
    -+	git checkout -- data.txt &&
    -+
    -+	git rm data.txt &&
    -+	git ls-files -s data.txt >ls-files-output &&
    -+	test_must_be_empty ls-files-output &&
    -+	test_tick && git commit -m "Remove data" &&
    -+	git ls-tree -r HEAD data.txt >ls-tree-output &&
    -+	test_must_be_empty ls-tree-output &&
    -+
    -+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
    -+	test_grep "^new file mode 100755$" patch &&
    -+	git apply --index patch &&
    -+	git ls-files -s data.txt >ls-files-output &&
    -+	test_grep "^100755" ls-files-output &&
    -+	test_tick && git commit -m "Re-add data" &&
    -+	git ls-tree -r HEAD data.txt >ls-tree-output &&
    -+	test_grep "^100755" ls-tree-output &&
    -+
    -+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
    -+	test_grep "^old mode 100755$" patch &&
    -+	test_grep "^new mode 100644$" patch &&
    -+	git apply --index patch 2>err &&
    -+	test_grep ! "has type 100644, expected 100755" err &&
    -+	git ls-files -s data.txt >ls-files-output &&
    -+	test_grep "^100644" ls-files-output &&
    -+	test_tick && git commit -m "Redo data mode change" &&
    -+	git ls-tree -r HEAD data.txt >ls-tree-output &&
    -+	test_grep "^100644" ls-tree-output &&
    -+
    -+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
    -+	test_grep "^deleted file mode 100644$" patch &&
    -+	git apply --index patch 2>err &&
    -+	test_grep ! "has type 100755, expected 100644" err &&
    -+	git ls-files -s data.txt >ls-files-output &&
    -+	test_must_be_empty ls-files-output &&
    -+	test_tick && git commit -m "Redo data removal" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_must_be_empty ls-tree-output
    ++
    ++	git apply --index change_x_to_notx-0001-create-0755.patch &&
    ++	test_file_mode_staged 0755 change_x_to_notx &&
    ++	test_tick && git commit -m "redo: add change_x_to_notx as executable" &&
    ++	test_file_mode_HEAD 0755 change_x_to_notx &&
    ++
    ++	git apply --index change_x_to_notx-0002-chmod-0644.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged 0644 change_x_to_notx &&
    ++	test_tick && git commit -m "redo: make change_x_to_notx not executable" &&
    ++	test_file_mode_HEAD 0644 change_x_to_notx &&
    ++
    ++	git apply --index change_x_to_notx-0003-delete.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged "" change_x_to_notx &&
    ++	test_tick && git commit -m "redo: remove change_notx_to_x" &&
    ++	test_file_mode_HEAD "" change_x_to_notx
     +'
     +
    -+test_expect_success 'git apply --reverse restores file modes' '
    ++test_expect_success 'git apply --reverse restores file modes (change_x_to_notx)' '
     +	test_config core.fileMode false &&
    -+	echo true >tool.sh &&
    -+	git add --chmod=-x tool.sh &&
    -+	git ls-files -s tool.sh >ls-files-output &&
    -+	test_grep "^100644" ls-files-output &&
    -+	test_tick && git commit -m "Add tool" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_grep "^100644" ls-tree-output &&
    -+
    -+	git add --chmod=+x tool.sh &&
    -+	git ls-files -s tool.sh >ls-files-output &&
    -+	test_grep "^100755" ls-files-output &&
    -+	test_tick && git commit -m "Make tool executable" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_grep "^100755" ls-tree-output &&
    -+	git checkout -- tool.sh &&
    -+
    -+	git rm tool.sh &&
    -+	git ls-files -s tool.sh >ls-files-output &&
    -+	test_must_be_empty ls-files-output &&
    -+	test_tick && git commit -m "Remove tool" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_must_be_empty ls-tree-output &&
    -+
    -+	git format-patch -1 --stdout >patch &&
    -+	test_grep "^deleted file mode 100755$" patch &&
    -+	git apply --index --reverse patch &&
    -+	git ls-files -s tool.sh >ls-files-output &&
    -+	test_grep "^100755" ls-files-output &&
    -+	test_tick && git commit -m "Undo tool removal" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_grep "^100755" ls-tree-output &&
    -+
    -+	git format-patch HEAD~3..HEAD~2 --stdout >patch &&
    -+	test_grep "^old mode 100644$" patch &&
    -+	test_grep "^new mode 100755$" patch &&
    -+	git apply --index --reverse patch 2>err &&
    -+	test_grep ! "has type 100644, expected 100755" err &&
    -+	git ls-files -s tool.sh >ls-files-output &&
    -+	test_grep "^100644" ls-files-output &&
    -+	test_tick && git commit -m "Undo tool mode change" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_grep "^100644" ls-tree-output &&
    -+
    -+	git format-patch HEAD~5..HEAD~4 --stdout >patch &&
    -+	test_grep "^new file mode 100644$" patch &&
    -+	git apply --index --reverse patch 2>err &&
    -+	test_grep ! "has type 100755, expected 100644" err &&
    -+	git ls-files -s tool.sh >ls-files-output &&
    -+	test_must_be_empty ls-files-output &&
    -+	test_tick && git commit -m "Undo tool addition" &&
    -+	git ls-tree -r HEAD tool.sh >ls-tree-output &&
    -+	test_must_be_empty ls-tree-output
    - '
    - 
    ++
    ++	git apply --index --reverse change_x_to_notx-0003-delete.patch &&
    ++	test_file_mode_staged 0644 change_x_to_notx &&
    ++	test_tick && git commit -m "undo: remove change_x_to_notx" &&
    ++	test_file_mode_HEAD 0644 change_x_to_notx &&
    ++
    ++	git apply --index --reverse change_x_to_notx-0002-chmod-0644.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged 0755 change_x_to_notx &&
    ++	test_tick && git commit -m "undo: make change_x_to_notx not executable" &&
    ++	test_file_mode_HEAD 0755 change_x_to_notx &&
    ++
    ++	git apply --index --reverse change_x_to_notx-0001-create-0755.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged "" change_x_to_notx &&
    ++	test_tick && git commit -m "undo: add change_x_to_notx as executable" &&
    ++	test_file_mode_HEAD "" change_x_to_notx
    ++'
    ++
    ++test_expect_success 'setup: git apply [--reverse] restores file modes (change_notx_to_x)' '
    ++	test_config core.fileMode false &&
    ++
    ++	touch change_notx_to_x &&
    ++	git add --chmod=-x change_notx_to_x &&
    ++	test_file_mode_staged 0644 change_notx_to_x &&
    ++	test_tick && git commit -m "add change_notx_to_x as not executable" &&
    ++	test_file_mode_HEAD 0644 change_notx_to_x &&
    ++
    ++	git add --chmod=+x change_notx_to_x &&
    ++	test_file_mode_staged 0755 change_notx_to_x &&
    ++	test_tick && git commit -m "make change_notx_to_x executable" &&
    ++	test_file_mode_HEAD 0755 change_notx_to_x &&
    ++
    ++	git rm change_notx_to_x &&
    ++	test_file_mode_staged "" change_notx_to_x &&
    ++	test_tick && git commit -m "remove change_notx_to_x" &&
    ++	test_file_mode_HEAD "" change_notx_to_x &&
    ++
    ++	git format-patch -o patches -3 &&
    ++	mv patches/0001-* change_notx_to_x-0001-create-0644.patch &&
    ++	mv patches/0002-* change_notx_to_x-0002-chmod-0755.patch &&
    ++	mv patches/0003-* change_notx_to_x-0003-delete.patch &&
    ++
    ++	test_grep "^new file mode 100644$" change_notx_to_x-0001-create-0644.patch &&
    ++	test_grep "^old mode 100644$" change_notx_to_x-0002-chmod-0755.patch &&
    ++	test_grep "^new mode 100755$" change_notx_to_x-0002-chmod-0755.patch &&
    ++	test_grep "^deleted file mode 100755$" change_notx_to_x-0003-delete.patch
    ++'
    ++
    ++test_expect_success 'git apply restores file modes (change_notx_to_x)' '
    ++	test_config core.fileMode false &&
    ++
    ++	git apply --index change_notx_to_x-0001-create-0644.patch &&
    ++	test_file_mode_staged 0644 change_notx_to_x &&
    ++	test_tick && git commit -m "redo: add change_notx_to_x as not executable" &&
    ++	test_file_mode_HEAD 0644 change_notx_to_x &&
    ++
    ++	git apply --index change_notx_to_x-0002-chmod-0755.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged 0755 change_notx_to_x &&
    ++	test_tick && git commit -m "redo: make change_notx_to_x executable" &&
    ++	test_file_mode_HEAD 0755 change_notx_to_x &&
    ++
    ++	git apply --index change_notx_to_x-0003-delete.patch &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged "" change_notx_to_x &&
    ++	test_tick && git commit -m "undo: remove change_notx_to_x" &&
    ++	test_file_mode_HEAD "" change_notx_to_x
    ++'
    ++
    ++test_expect_success 'git apply --reverse restores file modes (change_notx_to_x)' '
    ++	test_config core.fileMode false &&
    ++
    ++	git apply --index --reverse change_notx_to_x-0003-delete.patch &&
    ++	test_file_mode_staged 0755 change_notx_to_x &&
    ++	test_tick && git commit -m "undo: remove change_notx_to_x" &&
    ++	test_file_mode_HEAD 0755 change_notx_to_x &&
    ++
    ++	git apply --index --reverse change_notx_to_x-0002-chmod-0755.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged 0644 change_notx_to_x &&
    ++	test_tick && git commit -m "undo: make change_notx_to_x executable" &&
    ++	test_file_mode_HEAD 0644 change_notx_to_x &&
    ++
    ++	git apply --index --reverse change_notx_to_x-0001-create-0644.patch 2>err &&
    ++	test_grep ! "has type 100.*, expected 100.*" err &&
    ++	test_file_mode_staged "" change_notx_to_x &&
    ++	test_tick && git commit -m "undo: add change_notx_to_x as not executable" &&
    ++	test_file_mode_HEAD "" change_notx_to_x
    ++'
    ++
      test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
    + 	cat >patch <<-\EOF &&
    + 	diff --git a/non-canon b/non-canon
-- 
2.49.0

