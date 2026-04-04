Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46FB32470E
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775318649; cv=none; b=pwZF7mgt7xjjb/U/MDYjoc/rr2wK+IwMGmpfnIH+qyFyDTk88N8uYgCn2G4tFCjsxO22d+DDq+L7IszWq88rjnqb6KkZihDd3Md8iq3Yr4AQ+ZrvxI7tgeqO98ZsCgb2ETWjfund/T69AiqEN5Nb8dyxsPxoOfp2mb4fzl4vyfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775318649; c=relaxed/simple;
	bh=pC4LWCJkd3NPYgOLYxqjWsJnNvEB4H/L59V32AxARTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UlZ/GivQ7RBsFI0w+e7RhVexeuKFAkAqb76FxO0m+2Bl2nRymWnXElkoKjduU7T08H+6SK7YnAfyKonSK1tuP/POu/gznMGI9XXHQwKFImA7xye246ByF1PnXl69JSsNiTk0bQ5diMCY1MQsNKkhYy2ZiJPeRgpBPJ9GTPj2SkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXeQHVFF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXeQHVFF"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82a655cfab5so2314419b3a.1
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775318648; x=1775923448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oSpHQ6euKjGXSn/EyA0Sr0OWmsJriwoPU5IWbOx3Jo=;
        b=UXeQHVFFLyCN0btrE3tRPrG+N+ytyZOX7RnLrv4yl8xhdaFKlpfx+dRnR2swj+tSfT
         dn+gfQSkB5oyo0gh0N5aOKAuSUbsNvZVlDw19Koimzk86oS1j33kLQyPZf3OM9TaHQF8
         Df3jerTpd+Mlt8SyIHVMJwkDGe4h07qfzMjj+xgY2ap8LyzB3kedIgAvMZ0Z6yJ8dO86
         kxQLzpp9hJaAe0VocpOkNh2WM8Us27a3nccuBCkDW+XsOLXpCuFU50pbLnN3m7REpOKg
         BgfykGhXh3H9u9ARIzYrFgGbhbGxOl4xSiT58mjL85pQu/vpvPuRBPWkivmxld8wuOp3
         JoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775318648; x=1775923448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/oSpHQ6euKjGXSn/EyA0Sr0OWmsJriwoPU5IWbOx3Jo=;
        b=BeVQ9WmHhlFi/igMEvBUctV/o/X/51swq4KHmrSXnhk3C0eylMJl0hEFEwihhlLHAB
         F0zJGItxUT/PcA4//D8UdREHwEpJyiOpFe0JpAt0E72eZ4Dx8lN5znsLKsRpMav1kUmZ
         k9j/DXBXbJHLIxviHt+3b+Xt6HuP9avCTMa1Azzp2BA9fVjhDN/uoWghyyIE8ihclXNW
         +RbaoSZzuZrIpLLiWfD6JhktpJGlXxukCAlj4GXhYEeTWmRFJE0GJsW62sDigEVdp8h+
         kXY7nkuKGHqUZwdfzi7HGXyezsm40MIoY4bA7eU37j9JPHW1a1V7/NiqXTUNfH/KNZL3
         s4wg==
X-Gm-Message-State: AOJu0YyPQRw/Izny41EtPsQWPyza54qxPXpiebsBMrJLzO54AshT92sG
	+Xp4PiSIUa/IEm5e5GAc9DyvQkFrhe5EGrot7eEzVlWMsB9A86kh4ebQIUnNBQ==
X-Gm-Gg: AeBDietl0pZ5I8buyss2t1l4lp/IHp1Jfpe1XgpfHpCjFNYPP/JgV8tu/bYFW/F8qHa
	PBc8hQ1WFa2Yi9JiqmLkj6J19RKUyFt4rkG/+13sy1wa96SO3Y/9h0vbAtxgJ2X2OD77WDUFd6Y
	FzyzjllqEu/MuzGOBfeTE+g7gWNGEK7qmzd7Xm9bMlE8NVUVf1XRpwdbtadRRfmKRzf3FhZdA4g
	bNiqLm4FuqK3CP6bON4IIeDpe/SIofuQv5TxdG7w/qc3LO9EPUzHQZljoNY04RY8FYth3ipFABj
	SVgcpEiz/kO0tQ7AESNRDrtwSgwAzCcZqAXB7fLZ60xJquBWXiXgDfmda5nd7aiBSDG8bMXwdWb
	K4yVUeuwU9O8HbT7pSimUIrue36MPo3m/i3cdG9XMXHglEbOGEjv24PL7Geu1lrj53p7S6Q2vQb
	4SWygQouU7ShhNxkUTFep1kzANFDap+CDgJUnNwXS+cauCFDNgieN9RpE=
X-Received: by 2002:a05:6a00:13a8:b0:82a:6ef8:cb43 with SMTP id d2e1a72fcca58-82d0da7f10fmr7188303b3a.19.1775318647443;
        Sat, 04 Apr 2026 09:04:07 -0700 (PDT)
Received: from d ([106.202.56.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b3ccc8sm11763179b3a.19.2026.04.04.09.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 09:04:06 -0700 (PDT)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: ben.knoble@gmail.com,
	mroik@delayed.space,
	quentin.bernet@bluewin.ch,
	gitster@pobox.com,
	Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH v2] stash: infer "push" when push-specific options are given
Date: Sat,  4 Apr 2026 16:03:57 +0000
Message-ID: <20260404160357.11534-1-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260404143640.6679-1-deveshigurgaon@gmail.com>
References: <20260404143640.6679-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When "git stash" is run without the "push" subcommand, the command
tries to assume "push" but rejects any non-option arguments (i.e.,
pathspecs without "--") to avoid treating a misspelled subcommand
name as a pathspec.  The only exception is "-p", which sets
force_assume and allows pathspecs to follow.

This means "git stash -m foo file" is rejected even though "-m" is
unambiguously a "push" option, and the user's intent is clear.  The
same applies to other push-specific options like "--staged",
"--keep-index", "--include-untracked", and "--pathspec-from-file".

Expand the set of options that force the "push" assumption to
include all push-specific options, so that pathspec arguments are
accepted without requiring "--" or the explicit "push" subcommand
when the command line already contains a push-only option.

This was marked as #leftoverbits in [1].

[1] https://lore.kernel.org/git/xmqqtsu1jipp.fsf@gitster.g/

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---

Changes since v1:
  - Clean up untracked-file after stash pop in test

 builtin/stash.c  |  4 +++-
 t/t3903-stash.sh | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 95c5005b0b..197814241c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1877,7 +1877,9 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		argc = parse_options(argc, argv, prefix, options,
 				     push_assumed ? git_stash_usage :
 				     git_stash_push_usage, flags);
-		force_assume |= patch_mode;
+		force_assume |= patch_mode || stash_msg ||
+			keep_index != -1 || only_staged ||
+			include_untracked || pathspec_from_file;
 	}
 
 	if (argc) {
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..07bee22c27 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -414,6 +414,28 @@ test_expect_success 'dont assume push with non-option args' '
 	test_grep -e "subcommand wasn'\''t specified; '\''push'\'' can'\''t be assumed due to unexpected token '\''drop'\''" err
 '
 
+test_expect_success 'assume push when options imply push' '
+	git reset --hard &&
+	echo changed >file &&
+	git add file &&
+	git stash -m "implied push" file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --staged file &&
+	git stash pop &&
+
+	git add file &&
+	git stash --keep-index file &&
+	git stash pop &&
+
+	echo untracked >untracked-file &&
+	git stash --include-untracked untracked-file &&
+	test_path_is_missing untracked-file &&
+	git stash pop &&
+	rm -f untracked-file
+'
+
 test_expect_success 'stash --invalid-option' '
 	echo bar5 >file &&
 	echo bar6 >file2 &&

base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
-- 
2.52.0.230.gd8af7cadaa

