Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CB129A9FA
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174456; cv=none; b=PKCGT6HDfHKuE2aQj/B+uGgWuMPPBtZvQZ7WXtn7xyDV5YEqhhxZhRe4Xr52vcvEOCYZx7Q83BXcFRhxtT/LxBH8oAZqjvNZmH3WwjonRcgAp3NiK1nXUAi5u4lRGPaYzhNCaov/wuhVjku8r4GiCukQDqnrgz+8ICQgaghRge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174456; c=relaxed/simple;
	bh=6rI1xu+KE4QzmLKZiPadQ3QpL6XU0oSrxNdl6oj2nyM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXsycMnXZ3IX/tOGqYN1sbB/pYQG453i3JqHT0tw3McpliVg0MNpmMbM8RTrdQhFJrJjF++FD2oNTE7P4Wl9XytUcY3ZQPNuDTJ4YxA9moMZJ7N72PqmzfnsgzHcE+S02OJEUa/MK74por8TbVHWUB3yPBEFGW1XKg6hdH2OXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gPaJKtKe; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPaJKtKe"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-24457f581aeso5359195ad.0
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174453; x=1758779253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAaYdoeigVV5YafQTpQnQzOdS4f8iA5KFe6h35Sa9j8=;
        b=gPaJKtKebKFNRdazDGrL7xJ0xEiMVdj+wBD3hTTJH/TWS5UPSTtvab4FBsTy9iJmO4
         umCANOLAqhJ4uTsnc2IBnTS32YnNNkLXkZ7Gc1ljdhKewZeH+6Khr5PPJDeeF/+b8+mO
         SSCp7CltWPuMO+Dls78htFtby9fQ6f4D0EJ6W8j86Q6DvRfwSYXqlEDKAtM+3lSvZ+NF
         WORdPtYELs6Q/9JtyErFNf+Vj2S2F1K4A7Uj7EeF1qgxWJGjBtua1naEpj4T3ne0Gsr0
         VOdaXcXGrBBX/qnH4OO2nAzFXyLA5UTXwdK+TGokbzJnTbMvaWnCy9ghdqOkzjRAedNS
         Vy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174453; x=1758779253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAaYdoeigVV5YafQTpQnQzOdS4f8iA5KFe6h35Sa9j8=;
        b=fYGPuWwrcPMmyBAFOH8IALubWC4UM5RtAMZAppVJSXDdcWnPzYHHl9AGyiGb83ObP5
         bj56eTO9565DHRHgqHiAfyts25/WwEoQ5Kg0ryVyfaZhFg8+urOCYRuh7jHKTOVWGpjn
         1HDNaMG47PGWiysP9fVYgcNafIaZtRvMLT/qpoVGJIyxhHRxA+++5Dez/pMO4v3p8bdF
         LINAu7tnfwX8jrayltfKxQ5Rr6l40pwfHNJETuzIpUPcWqUgqvKulXcAZAuC+NkeaPWJ
         uKJwIWHrEiNb0VQnbJ2aBdnUi/983ryxY2m7YoykXknyYpi/g5yz9EkfUyvYY3jXAoYb
         DX5Q==
X-Gm-Message-State: AOJu0YwclCdvPVfHEYuYSL9rR/xDwaDphvG7bgaUmvjTKrP9JOaovkxB
	CPh27q89f9MT9WFIydiC0vBDgkEREX1SFI+cAFRk/Jp4oxE5b9nb0z12h0l8bg==
X-Gm-Gg: ASbGncuW/T+YiQClpW/k5TM0rp8wj1Ut1gvCJH9QIusiRLykyC5MCnSGE2QfGrrEGmv
	lUDiLCQu2/ww1m5WqEe2n2aK++IkAO9yuZdw4lBroSue5rd9fiLascCU0uUvfn51a+kmtS1ijiQ
	k3y6sCK9zHw0pJLRYmVMzWShCnNVHX9EvqeJctLBeQ1OgBO+oWLzadtZYoBu00qqbYPeNbAo/+n
	ChhCDoQ0Hgb+HUg/9J9Ae9XcJcLZrnnXBKI7SevLWWslIWmvEznMuLywdb4dZKM23jevdVaE1Y4
	c1mXX0gO4j81nwyVLrk3u0zlbXVyLAbgjrmUyTivFfrds9+1Zt2+mkYql2+LPwiUkKjAd4evUY+
	Dd1+a7+AG/AYoTkkryW/f2xspaOIgLNlViP8aRg==
X-Google-Smtp-Source: AGHT+IHxcQBLtYIsPGL8JEI0ece5/VnmdNSF9mJZP5lyuh10cc6RXRi4MbcX1Ohr0+AHWci/P5BFVQ==
X-Received: by 2002:a17:902:dad1:b0:269:936c:88da with SMTP id d9443c01a7336-269936c8b6fmr6769625ad.41.1758174452805;
        Wed, 17 Sep 2025 22:47:32 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:32 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH v3 8/9] t0601: refactor tests to be shareable
Date: Thu, 18 Sep 2025 11:17:03 +0530
Message-Id: <20250918054704.544254-9-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918054704.544254-1-meetsoni3017@gmail.com>
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
 <20250918054704.544254-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding tests for the new `git refs optimize` command,
refactor the existing t0601 test suite to make its logic shareable.

Move the core test logic from `t0601-reffiles-pack-refs.sh` into a new
`pack-refs-tests.sh` file. Inside this new script, replace hardcoded
calls to "pack-refs" with the `$pack_refs` variable.

The original `t0601-reffiles-pack-refs.sh` script now becomes a simple
"driver". It is responsible for setting the default value of the
variable and then sourcing the test library.

This new structure follows the established pattern used for sharing
tests between `git-for-each-ref` and `git-refs list` and prepares the
test suite for the `refs optimize` tests to be added in a subsequent
commit.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 t/pack-refs-tests.sh          | 431 ++++++++++++++++++++++++++++++++++
 t/t0601-reffiles-pack-refs.sh | 430 +--------------------------------
 2 files changed, 432 insertions(+), 429 deletions(-)
 create mode 100644 t/pack-refs-tests.sh

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
new file mode 100644
index 0000000000..3dbcc01718
--- /dev/null
+++ b/t/pack-refs-tests.sh
@@ -0,0 +1,431 @@
+pack_refs=${pack_refs:-pack-refs}
+
+test_expect_success 'enable reflogs' '
+	git config core.logallrefupdates true
+'
+
+test_expect_success 'prepare a trivial repository' '
+	echo Hello > A &&
+	git update-index --add A &&
+	git commit -m "Initial commit." &&
+	HEAD=$(git rev-parse --verify HEAD)
+'
+
+test_expect_success '${pack_refs} --prune --all' '
+	test_path_is_missing .git/packed-refs &&
+	git ${pack_refs} --no-prune --all &&
+	test_path_is_file .git/packed-refs &&
+	N=$(find .git/refs -type f | wc -l) &&
+	test "$N" != 0 &&
+
+	git ${pack_refs} --prune --all &&
+	test_path_is_file .git/packed-refs &&
+	N=$(find .git/refs -type f) &&
+	test -z "$N"
+'
+
+SHA1=
+
+test_expect_success 'see if git show-ref works as expected' '
+	git branch a &&
+	SHA1=$(cat .git/refs/heads/a) &&
+	echo "$SHA1 refs/heads/a" >expect &&
+	git show-ref a >result &&
+	test_cmp expect result
+'
+
+test_expect_success 'see if a branch still exists when packed' '
+	git branch b &&
+	git ${pack_refs} --all &&
+	rm -f .git/refs/heads/b &&
+	echo "$SHA1 refs/heads/b" >expect &&
+	git show-ref b >result &&
+	test_cmp expect result
+'
+
+test_expect_success 'git branch c/d should barf if branch c exists' '
+	git branch c &&
+	git ${pack_refs} --all &&
+	rm -f .git/refs/heads/c &&
+	test_must_fail git branch c/d
+'
+
+test_expect_success 'see if a branch still exists after git ${pack_refs} --prune' '
+	git branch e &&
+	git ${pack_refs} --all --prune &&
+	echo "$SHA1 refs/heads/e" >expect &&
+	git show-ref e >result &&
+	test_cmp expect result
+'
+
+test_expect_success 'see if git ${pack_refs} --prune remove ref files' '
+	git branch f &&
+	git ${pack_refs} --all --prune &&
+	! test -f .git/refs/heads/f
+'
+
+test_expect_success 'see if git ${pack_refs} --prune removes empty dirs' '
+	git branch r/s/t &&
+	git ${pack_refs} --all --prune &&
+	! test -e .git/refs/heads/r
+'
+
+test_expect_success 'git branch g should work when git branch g/h has been deleted' '
+	git branch g/h &&
+	git ${pack_refs} --all --prune &&
+	git branch -d g/h &&
+	git branch g &&
+	git ${pack_refs} --all &&
+	git branch -d g
+'
+
+test_expect_success 'git branch i/j/k should barf if branch i exists' '
+	git branch i &&
+	git ${pack_refs} --all --prune &&
+	test_must_fail git branch i/j/k
+'
+
+test_expect_success 'test git branch k after branch k/l/m and k/lm have been deleted' '
+	git branch k/l &&
+	git branch k/lm &&
+	git branch -d k/l &&
+	git branch k/l/m &&
+	git branch -d k/l/m &&
+	git branch -d k/lm &&
+	git branch k
+'
+
+test_expect_success 'test git branch n after some branch deletion and pruning' '
+	git branch n/o &&
+	git branch n/op &&
+	git branch -d n/o &&
+	git branch n/o/p &&
+	git branch -d n/op &&
+	git ${pack_refs} --all --prune &&
+	git branch -d n/o/p &&
+	git branch n
+'
+
+test_expect_success 'test excluded refs are not packed' '
+	git branch dont_pack1 &&
+	git branch dont_pack2 &&
+	git branch pack_this &&
+	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" &&
+	test -f .git/refs/heads/dont_pack1 &&
+	test -f .git/refs/heads/dont_pack2 &&
+	! test -f .git/refs/heads/pack_this'
+
+test_expect_success 'test --no-exclude refs clears excluded refs' '
+	git branch dont_pack3 &&
+	git branch dont_pack4 &&
+	git ${pack_refs} --all --exclude "refs/heads/dont_pack*" --no-exclude &&
+	! test -f .git/refs/heads/dont_pack3 &&
+	! test -f .git/refs/heads/dont_pack4'
+
+test_expect_success 'test only included refs are packed' '
+	git branch pack_this1 &&
+	git branch pack_this2 &&
+	git tag dont_pack5 &&
+	git ${pack_refs} --include "refs/heads/pack_this*" &&
+	test -f .git/refs/tags/dont_pack5 &&
+	! test -f .git/refs/heads/pack_this1 &&
+	! test -f .git/refs/heads/pack_this2'
+
+test_expect_success 'test --no-include refs clears included refs' '
+	git branch pack1 &&
+	git branch pack2 &&
+	git ${pack_refs} --include "refs/heads/pack*" --no-include &&
+	test -f .git/refs/heads/pack1 &&
+	test -f .git/refs/heads/pack2'
+
+test_expect_success 'test --exclude takes precedence over --include' '
+	git branch dont_pack5 &&
+	git ${pack_refs} --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
+	test -f .git/refs/heads/dont_pack5'
+
+test_expect_success 'see if up-to-date packed refs are preserved' '
+	git branch q &&
+	git ${pack_refs} --all --prune &&
+	git update-ref refs/heads/q refs/heads/q &&
+	! test -f .git/refs/heads/q
+'
+
+test_expect_success 'pack, prune and repack' '
+	git tag foo &&
+	git ${pack_refs} --all --prune &&
+	git show-ref >all-of-them &&
+	git ${pack_refs} &&
+	git show-ref >again &&
+	test_cmp all-of-them again
+'
+
+test_expect_success 'explicit ${pack_refs} with dangling packed reference' '
+	git commit --allow-empty -m "soon to be garbage-collected" &&
+	git ${pack_refs} --all &&
+	git reset --hard HEAD^ &&
+	git reflog expire --expire=all --all &&
+	git prune --expire=all &&
+	git ${pack_refs} --all 2>result &&
+	test_must_be_empty result
+'
+
+test_expect_success 'delete ref with dangling packed version' '
+	git checkout -b lamb &&
+	git commit --allow-empty -m "future garbage" &&
+	git ${pack_refs} --all &&
+	git reset --hard HEAD^ &&
+	git checkout main &&
+	git reflog expire --expire=all --all &&
+	git prune --expire=all &&
+	git branch -d lamb 2>result &&
+	test_must_be_empty result
+'
+
+test_expect_success 'delete ref while another dangling packed ref' '
+	git branch lamb &&
+	git commit --allow-empty -m "future garbage" &&
+	git ${pack_refs} --all &&
+	git reset --hard HEAD^ &&
+	git reflog expire --expire=all --all &&
+	git prune --expire=all &&
+	git branch -d lamb 2>result &&
+	test_must_be_empty result
+'
+
+test_expect_success 'pack ref directly below refs/' '
+	git update-ref refs/top HEAD &&
+	git ${pack_refs} --all --prune &&
+	grep refs/top .git/packed-refs &&
+	test_path_is_missing .git/refs/top
+'
+
+test_expect_success 'do not pack ref in refs/bisect' '
+	git update-ref refs/bisect/local HEAD &&
+	git ${pack_refs} --all --prune &&
+	! grep refs/bisect/local .git/packed-refs >/dev/null &&
+	test_path_is_file .git/refs/bisect/local
+'
+
+test_expect_success 'disable reflogs' '
+	git config core.logallrefupdates false &&
+	rm -rf .git/logs
+'
+
+test_expect_success 'create packed foo/bar/baz branch' '
+	git branch foo/bar/baz &&
+	git ${pack_refs} --all --prune &&
+	test_path_is_missing .git/refs/heads/foo/bar/baz &&
+	test_must_fail git reflog exists refs/heads/foo/bar/baz
+'
+
+test_expect_success 'notice d/f conflict with existing directory' '
+	test_must_fail git branch foo &&
+	test_must_fail git branch foo/bar
+'
+
+test_expect_success 'existing directory reports concrete ref' '
+	test_must_fail git branch foo 2>stderr &&
+	test_grep refs/heads/foo/bar/baz stderr
+'
+
+test_expect_success 'notice d/f conflict with existing ref' '
+	test_must_fail git branch foo/bar/baz/extra &&
+	test_must_fail git branch foo/bar/baz/lots/of/extra/components
+'
+
+test_expect_success 'reject packed-refs with unterminated line' '
+	cp .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	printf "%s" "$HEAD refs/zzzzz" >>.git/packed-refs &&
+	echo "fatal: unterminated line in .git/packed-refs: $HEAD refs/zzzzz" >expected_err &&
+	test_must_fail git for-each-ref >out 2>err &&
+	test_cmp expected_err err
+'
+
+test_expect_success 'reject packed-refs containing junk' '
+	cp .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	printf "%s\n" "bogus content" >>.git/packed-refs &&
+	echo "fatal: unexpected line in .git/packed-refs: bogus content" >expected_err &&
+	test_must_fail git for-each-ref >out 2>err &&
+	test_cmp expected_err err
+'
+
+test_expect_success 'reject packed-refs with a short SHA-1' '
+	cp .git/packed-refs .git/packed-refs.bak &&
+	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
+	printf "%.7s %s\n" $HEAD refs/zzzzz >>.git/packed-refs &&
+	printf "fatal: unexpected line in .git/packed-refs: %.7s %s\n" $HEAD refs/zzzzz >expected_err &&
+	test_must_fail git for-each-ref >out 2>err &&
+	test_cmp expected_err err
+'
+
+test_expect_success 'timeout if packed-refs.lock exists' '
+	LOCK=.git/packed-refs.lock &&
+	>"$LOCK" &&
+	test_when_finished "rm -f $LOCK" &&
+	test_must_fail git ${pack_refs} --all --prune
+'
+
+test_expect_success 'retry acquiring packed-refs.lock' '
+	LOCK=.git/packed-refs.lock &&
+	>"$LOCK" &&
+	test_when_finished "wait && rm -f $LOCK" &&
+	{
+		( sleep 1 && rm -f $LOCK ) &
+	} &&
+	git -c core.packedrefstimeout=3000 ${pack_refs} --all --prune
+'
+
+test_expect_success SYMLINKS 'pack symlinked packed-refs' '
+	# First make sure that symlinking works when reading:
+	git update-ref refs/heads/lossy refs/heads/main &&
+	git for-each-ref >all-refs-before &&
+	mv .git/packed-refs .git/my-deviant-packed-refs &&
+	ln -s my-deviant-packed-refs .git/packed-refs &&
+	git for-each-ref >all-refs-linked &&
+	test_cmp all-refs-before all-refs-linked &&
+	git ${pack_refs} --all --prune &&
+	git for-each-ref >all-refs-packed &&
+	test_cmp all-refs-before all-refs-packed &&
+	test -h .git/packed-refs &&
+	test "$(test_readlink .git/packed-refs)" = "my-deviant-packed-refs"
+'
+
+# The 'packed-refs' file is stored directly in .git/. This means it is global
+# to the repository, and can only contain refs that are shared across all
+# worktrees.
+test_expect_success 'refs/worktree must not be packed' '
+	test_commit initial &&
+	test_commit wt1 &&
+	test_commit wt2 &&
+	git worktree add wt1 wt1 &&
+	git worktree add wt2 wt2 &&
+	git checkout initial &&
+	git update-ref refs/worktree/foo HEAD &&
+	git -C wt1 update-ref refs/worktree/foo HEAD &&
+	git -C wt2 update-ref refs/worktree/foo HEAD &&
+	git ${pack_refs} --all &&
+	test_path_is_missing .git/refs/tags/wt1 &&
+	test_path_is_file .git/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
+	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
+'
+
+# we do not want to count on running ${pack_refs} to
+# actually pack it, as it is perfectly reasonable to
+# skip processing a broken ref
+test_expect_success 'create packed-refs file with broken ref' '
+	test_tick && git commit --allow-empty -m one &&
+	recoverable=$(git rev-parse HEAD) &&
+	test_tick && git commit --allow-empty -m two &&
+	missing=$(git rev-parse HEAD) &&
+	rm -f .git/refs/heads/main &&
+	cat >.git/packed-refs <<-EOF &&
+	$missing refs/heads/main
+	$recoverable refs/heads/other
+	EOF
+	echo $missing >expect &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '${pack_refs} does not silently delete broken packed ref' '
+	git ${pack_refs} --all --prune &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '${pack_refs} does not drop broken refs during deletion' '
+	git update-ref -d refs/heads/other &&
+	git rev-parse refs/heads/main >actual &&
+	test_cmp expect actual
+'
+
+for command in "git ${pack_refs} --all --auto" "git maintenance run --task=${pack_refs} --auto"
+do
+	test_expect_success "$command does not repack below 16 refs without packed-refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			git commit --allow-empty --message "initial" &&
+
+			# Create 14 additional references, which brings us to
+			# 15 together with the default branch.
+			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 14) >stdin &&
+			git update-ref --stdin <stdin &&
+			test_path_is_missing .git/packed-refs &&
+			git ${pack_refs} --auto --all &&
+			test_path_is_missing .git/packed-refs &&
+
+			# Create the 16th reference, which should cause us to repack.
+			git update-ref refs/heads/loose-15 HEAD &&
+			git ${pack_refs} --auto --all &&
+			test_path_is_file .git/packed-refs
+		)
+	'
+
+	test_expect_success "$command does not repack below 16 refs with small packed-refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			git commit --allow-empty --message "initial" &&
+
+			git ${pack_refs} --all &&
+			test_line_count = 2 .git/packed-refs &&
+
+			# Create 15 loose references.
+			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
+			git update-ref --stdin <stdin &&
+			git ${pack_refs} --auto --all &&
+			test_line_count = 2 .git/packed-refs &&
+
+			# Create the 16th loose reference, which should cause us to repack.
+			git update-ref refs/heads/loose-17 HEAD &&
+			git ${pack_refs} --auto --all &&
+			test_line_count = 18 .git/packed-refs
+		)
+	'
+
+	test_expect_success "$command scales with size of packed-refs" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			git config set maintenance.auto false &&
+			git commit --allow-empty --message "initial" &&
+
+			# Create 99 packed refs. This should cause the heuristic
+			# to require more than the minimum amount of loose refs.
+			test_seq 99 |
+			while read i
+			do
+				printf "create refs/heads/packed-%d HEAD\n" $i || return 1
+			done >stdin &&
+			git update-ref --stdin <stdin &&
+			git ${pack_refs} --all &&
+			test_line_count = 101 .git/packed-refs &&
+
+			# Create 24 loose refs, which should not yet cause us to repack.
+			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 24) >stdin &&
+			git update-ref --stdin <stdin &&
+			git ${pack_refs} --auto --all &&
+			test_line_count = 101 .git/packed-refs &&
+
+			# Create another handful of refs to cross the border.
+			# Note that we explicitly do not check for strict
+			# boundaries here, as this also depends on the size of
+			# the object hash.
+			printf "create refs/heads/addn-%d HEAD\n" $(test_seq 10) >stdin &&
+			git update-ref --stdin <stdin &&
+			git ${pack_refs} --auto --all &&
+			test_line_count = 135 .git/packed-refs
+		)
+	'
+done
+
+test_done
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index aa7f6ecd81..12cf5d1dcb 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -17,432 +17,4 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 . ./test-lib.sh
 
-test_expect_success 'enable reflogs' '
-	git config core.logallrefupdates true
-'
-
-test_expect_success 'prepare a trivial repository' '
-	echo Hello > A &&
-	git update-index --add A &&
-	git commit -m "Initial commit." &&
-	HEAD=$(git rev-parse --verify HEAD)
-'
-
-test_expect_success 'pack-refs --prune --all' '
-	test_path_is_missing .git/packed-refs &&
-	git pack-refs --no-prune --all &&
-	test_path_is_file .git/packed-refs &&
-	N=$(find .git/refs -type f | wc -l) &&
-	test "$N" != 0 &&
-
-	git pack-refs --prune --all &&
-	test_path_is_file .git/packed-refs &&
-	N=$(find .git/refs -type f) &&
-	test -z "$N"
-'
-
-SHA1=
-
-test_expect_success 'see if git show-ref works as expected' '
-	git branch a &&
-	SHA1=$(cat .git/refs/heads/a) &&
-	echo "$SHA1 refs/heads/a" >expect &&
-	git show-ref a >result &&
-	test_cmp expect result
-'
-
-test_expect_success 'see if a branch still exists when packed' '
-	git branch b &&
-	git pack-refs --all &&
-	rm -f .git/refs/heads/b &&
-	echo "$SHA1 refs/heads/b" >expect &&
-	git show-ref b >result &&
-	test_cmp expect result
-'
-
-test_expect_success 'git branch c/d should barf if branch c exists' '
-	git branch c &&
-	git pack-refs --all &&
-	rm -f .git/refs/heads/c &&
-	test_must_fail git branch c/d
-'
-
-test_expect_success 'see if a branch still exists after git pack-refs --prune' '
-	git branch e &&
-	git pack-refs --all --prune &&
-	echo "$SHA1 refs/heads/e" >expect &&
-	git show-ref e >result &&
-	test_cmp expect result
-'
-
-test_expect_success 'see if git pack-refs --prune remove ref files' '
-	git branch f &&
-	git pack-refs --all --prune &&
-	! test -f .git/refs/heads/f
-'
-
-test_expect_success 'see if git pack-refs --prune removes empty dirs' '
-	git branch r/s/t &&
-	git pack-refs --all --prune &&
-	! test -e .git/refs/heads/r
-'
-
-test_expect_success 'git branch g should work when git branch g/h has been deleted' '
-	git branch g/h &&
-	git pack-refs --all --prune &&
-	git branch -d g/h &&
-	git branch g &&
-	git pack-refs --all &&
-	git branch -d g
-'
-
-test_expect_success 'git branch i/j/k should barf if branch i exists' '
-	git branch i &&
-	git pack-refs --all --prune &&
-	test_must_fail git branch i/j/k
-'
-
-test_expect_success 'test git branch k after branch k/l/m and k/lm have been deleted' '
-	git branch k/l &&
-	git branch k/lm &&
-	git branch -d k/l &&
-	git branch k/l/m &&
-	git branch -d k/l/m &&
-	git branch -d k/lm &&
-	git branch k
-'
-
-test_expect_success 'test git branch n after some branch deletion and pruning' '
-	git branch n/o &&
-	git branch n/op &&
-	git branch -d n/o &&
-	git branch n/o/p &&
-	git branch -d n/op &&
-	git pack-refs --all --prune &&
-	git branch -d n/o/p &&
-	git branch n
-'
-
-test_expect_success 'test excluded refs are not packed' '
-	git branch dont_pack1 &&
-	git branch dont_pack2 &&
-	git branch pack_this &&
-	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
-	test -f .git/refs/heads/dont_pack1 &&
-	test -f .git/refs/heads/dont_pack2 &&
-	! test -f .git/refs/heads/pack_this'
-
-test_expect_success 'test --no-exclude refs clears excluded refs' '
-	git branch dont_pack3 &&
-	git branch dont_pack4 &&
-	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude &&
-	! test -f .git/refs/heads/dont_pack3 &&
-	! test -f .git/refs/heads/dont_pack4'
-
-test_expect_success 'test only included refs are packed' '
-	git branch pack_this1 &&
-	git branch pack_this2 &&
-	git tag dont_pack5 &&
-	git pack-refs --include "refs/heads/pack_this*" &&
-	test -f .git/refs/tags/dont_pack5 &&
-	! test -f .git/refs/heads/pack_this1 &&
-	! test -f .git/refs/heads/pack_this2'
-
-test_expect_success 'test --no-include refs clears included refs' '
-	git branch pack1 &&
-	git branch pack2 &&
-	git pack-refs --include "refs/heads/pack*" --no-include &&
-	test -f .git/refs/heads/pack1 &&
-	test -f .git/refs/heads/pack2'
-
-test_expect_success 'test --exclude takes precedence over --include' '
-	git branch dont_pack5 &&
-	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
-	test -f .git/refs/heads/dont_pack5'
-
-test_expect_success 'see if up-to-date packed refs are preserved' '
-	git branch q &&
-	git pack-refs --all --prune &&
-	git update-ref refs/heads/q refs/heads/q &&
-	! test -f .git/refs/heads/q
-'
-
-test_expect_success 'pack, prune and repack' '
-	git tag foo &&
-	git pack-refs --all --prune &&
-	git show-ref >all-of-them &&
-	git pack-refs &&
-	git show-ref >again &&
-	test_cmp all-of-them again
-'
-
-test_expect_success 'explicit pack-refs with dangling packed reference' '
-	git commit --allow-empty -m "soon to be garbage-collected" &&
-	git pack-refs --all &&
-	git reset --hard HEAD^ &&
-	git reflog expire --expire=all --all &&
-	git prune --expire=all &&
-	git pack-refs --all 2>result &&
-	test_must_be_empty result
-'
-
-test_expect_success 'delete ref with dangling packed version' '
-	git checkout -b lamb &&
-	git commit --allow-empty -m "future garbage" &&
-	git pack-refs --all &&
-	git reset --hard HEAD^ &&
-	git checkout main &&
-	git reflog expire --expire=all --all &&
-	git prune --expire=all &&
-	git branch -d lamb 2>result &&
-	test_must_be_empty result
-'
-
-test_expect_success 'delete ref while another dangling packed ref' '
-	git branch lamb &&
-	git commit --allow-empty -m "future garbage" &&
-	git pack-refs --all &&
-	git reset --hard HEAD^ &&
-	git reflog expire --expire=all --all &&
-	git prune --expire=all &&
-	git branch -d lamb 2>result &&
-	test_must_be_empty result
-'
-
-test_expect_success 'pack ref directly below refs/' '
-	git update-ref refs/top HEAD &&
-	git pack-refs --all --prune &&
-	grep refs/top .git/packed-refs &&
-	test_path_is_missing .git/refs/top
-'
-
-test_expect_success 'do not pack ref in refs/bisect' '
-	git update-ref refs/bisect/local HEAD &&
-	git pack-refs --all --prune &&
-	! grep refs/bisect/local .git/packed-refs >/dev/null &&
-	test_path_is_file .git/refs/bisect/local
-'
-
-test_expect_success 'disable reflogs' '
-	git config core.logallrefupdates false &&
-	rm -rf .git/logs
-'
-
-test_expect_success 'create packed foo/bar/baz branch' '
-	git branch foo/bar/baz &&
-	git pack-refs --all --prune &&
-	test_path_is_missing .git/refs/heads/foo/bar/baz &&
-	test_must_fail git reflog exists refs/heads/foo/bar/baz
-'
-
-test_expect_success 'notice d/f conflict with existing directory' '
-	test_must_fail git branch foo &&
-	test_must_fail git branch foo/bar
-'
-
-test_expect_success 'existing directory reports concrete ref' '
-	test_must_fail git branch foo 2>stderr &&
-	test_grep refs/heads/foo/bar/baz stderr
-'
-
-test_expect_success 'notice d/f conflict with existing ref' '
-	test_must_fail git branch foo/bar/baz/extra &&
-	test_must_fail git branch foo/bar/baz/lots/of/extra/components
-'
-
-test_expect_success 'reject packed-refs with unterminated line' '
-	cp .git/packed-refs .git/packed-refs.bak &&
-	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
-	printf "%s" "$HEAD refs/zzzzz" >>.git/packed-refs &&
-	echo "fatal: unterminated line in .git/packed-refs: $HEAD refs/zzzzz" >expected_err &&
-	test_must_fail git for-each-ref >out 2>err &&
-	test_cmp expected_err err
-'
-
-test_expect_success 'reject packed-refs containing junk' '
-	cp .git/packed-refs .git/packed-refs.bak &&
-	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
-	printf "%s\n" "bogus content" >>.git/packed-refs &&
-	echo "fatal: unexpected line in .git/packed-refs: bogus content" >expected_err &&
-	test_must_fail git for-each-ref >out 2>err &&
-	test_cmp expected_err err
-'
-
-test_expect_success 'reject packed-refs with a short SHA-1' '
-	cp .git/packed-refs .git/packed-refs.bak &&
-	test_when_finished "mv .git/packed-refs.bak .git/packed-refs" &&
-	printf "%.7s %s\n" $HEAD refs/zzzzz >>.git/packed-refs &&
-	printf "fatal: unexpected line in .git/packed-refs: %.7s %s\n" $HEAD refs/zzzzz >expected_err &&
-	test_must_fail git for-each-ref >out 2>err &&
-	test_cmp expected_err err
-'
-
-test_expect_success 'timeout if packed-refs.lock exists' '
-	LOCK=.git/packed-refs.lock &&
-	>"$LOCK" &&
-	test_when_finished "rm -f $LOCK" &&
-	test_must_fail git pack-refs --all --prune
-'
-
-test_expect_success 'retry acquiring packed-refs.lock' '
-	LOCK=.git/packed-refs.lock &&
-	>"$LOCK" &&
-	test_when_finished "wait && rm -f $LOCK" &&
-	{
-		( sleep 1 && rm -f $LOCK ) &
-	} &&
-	git -c core.packedrefstimeout=3000 pack-refs --all --prune
-'
-
-test_expect_success SYMLINKS 'pack symlinked packed-refs' '
-	# First make sure that symlinking works when reading:
-	git update-ref refs/heads/lossy refs/heads/main &&
-	git for-each-ref >all-refs-before &&
-	mv .git/packed-refs .git/my-deviant-packed-refs &&
-	ln -s my-deviant-packed-refs .git/packed-refs &&
-	git for-each-ref >all-refs-linked &&
-	test_cmp all-refs-before all-refs-linked &&
-	git pack-refs --all --prune &&
-	git for-each-ref >all-refs-packed &&
-	test_cmp all-refs-before all-refs-packed &&
-	test -h .git/packed-refs &&
-	test "$(test_readlink .git/packed-refs)" = "my-deviant-packed-refs"
-'
-
-# The 'packed-refs' file is stored directly in .git/. This means it is global
-# to the repository, and can only contain refs that are shared across all
-# worktrees.
-test_expect_success 'refs/worktree must not be packed' '
-	test_commit initial &&
-	test_commit wt1 &&
-	test_commit wt2 &&
-	git worktree add wt1 wt1 &&
-	git worktree add wt2 wt2 &&
-	git checkout initial &&
-	git update-ref refs/worktree/foo HEAD &&
-	git -C wt1 update-ref refs/worktree/foo HEAD &&
-	git -C wt2 update-ref refs/worktree/foo HEAD &&
-	git pack-refs --all &&
-	test_path_is_missing .git/refs/tags/wt1 &&
-	test_path_is_file .git/refs/worktree/foo &&
-	test_path_is_file .git/worktrees/wt1/refs/worktree/foo &&
-	test_path_is_file .git/worktrees/wt2/refs/worktree/foo
-'
-
-# we do not want to count on running pack-refs to
-# actually pack it, as it is perfectly reasonable to
-# skip processing a broken ref
-test_expect_success 'create packed-refs file with broken ref' '
-	test_tick && git commit --allow-empty -m one &&
-	recoverable=$(git rev-parse HEAD) &&
-	test_tick && git commit --allow-empty -m two &&
-	missing=$(git rev-parse HEAD) &&
-	rm -f .git/refs/heads/main &&
-	cat >.git/packed-refs <<-EOF &&
-	$missing refs/heads/main
-	$recoverable refs/heads/other
-	EOF
-	echo $missing >expect &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'pack-refs does not silently delete broken packed ref' '
-	git pack-refs --all --prune &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'pack-refs does not drop broken refs during deletion' '
-	git update-ref -d refs/heads/other &&
-	git rev-parse refs/heads/main >actual &&
-	test_cmp expect actual
-'
-
-for command in "git pack-refs --all --auto" "git maintenance run --task=pack-refs --auto"
-do
-	test_expect_success "$command does not repack below 16 refs without packed-refs" '
-		test_when_finished "rm -rf repo" &&
-		git init repo &&
-		(
-			cd repo &&
-			git config set maintenance.auto false &&
-			git commit --allow-empty --message "initial" &&
-
-			# Create 14 additional references, which brings us to
-			# 15 together with the default branch.
-			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 14) >stdin &&
-			git update-ref --stdin <stdin &&
-			test_path_is_missing .git/packed-refs &&
-			git pack-refs --auto --all &&
-			test_path_is_missing .git/packed-refs &&
-
-			# Create the 16th reference, which should cause us to repack.
-			git update-ref refs/heads/loose-15 HEAD &&
-			git pack-refs --auto --all &&
-			test_path_is_file .git/packed-refs
-		)
-	'
-
-	test_expect_success "$command does not repack below 16 refs with small packed-refs" '
-		test_when_finished "rm -rf repo" &&
-		git init repo &&
-		(
-			cd repo &&
-			git config set maintenance.auto false &&
-			git commit --allow-empty --message "initial" &&
-
-			git pack-refs --all &&
-			test_line_count = 2 .git/packed-refs &&
-
-			# Create 15 loose references.
-			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 15) >stdin &&
-			git update-ref --stdin <stdin &&
-			git pack-refs --auto --all &&
-			test_line_count = 2 .git/packed-refs &&
-
-			# Create the 16th loose reference, which should cause us to repack.
-			git update-ref refs/heads/loose-17 HEAD &&
-			git pack-refs --auto --all &&
-			test_line_count = 18 .git/packed-refs
-		)
-	'
-
-	test_expect_success "$command scales with size of packed-refs" '
-		test_when_finished "rm -rf repo" &&
-		git init repo &&
-		(
-			cd repo &&
-			git config set maintenance.auto false &&
-			git commit --allow-empty --message "initial" &&
-
-			# Create 99 packed refs. This should cause the heuristic
-			# to require more than the minimum amount of loose refs.
-			test_seq 99 |
-			while read i
-			do
-				printf "create refs/heads/packed-%d HEAD\n" $i || return 1
-			done >stdin &&
-			git update-ref --stdin <stdin &&
-			git pack-refs --all &&
-			test_line_count = 101 .git/packed-refs &&
-
-			# Create 24 loose refs, which should not yet cause us to repack.
-			printf "create refs/heads/loose-%d HEAD\n" $(test_seq 24) >stdin &&
-			git update-ref --stdin <stdin &&
-			git pack-refs --auto --all &&
-			test_line_count = 101 .git/packed-refs &&
-
-			# Create another handful of refs to cross the border.
-			# Note that we explicitly do not check for strict
-			# boundaries here, as this also depends on the size of
-			# the object hash.
-			printf "create refs/heads/addn-%d HEAD\n" $(test_seq 10) >stdin &&
-			git update-ref --stdin <stdin &&
-			git pack-refs --auto --all &&
-			test_line_count = 135 .git/packed-refs
-		)
-	'
-done
-
-test_done
+. "$TEST_DIRECTORY"/pack-refs-tests.sh
-- 
2.34.1

