Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B383509F19
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067458; cv=none; b=NQNmgkdvOejox19GCQjIgYcxQ7YGStiEz112D2Tp0u6AHKK9RuC2qtx0FVvdP9z0gXYQZT8r8TRTntaWIUqo19noX29slyuiD+/+wCmw17pVKoihZHZvSltDJOSv21TVm0JVolpjpx4norieq/CDPIWzcmPc8XkWtWamXHlNoBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067458; c=relaxed/simple;
	bh=u6dsC0LKQrQ9snNHTMgvb/HzjClqGR8OtiUEX0U1lW8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=qmbxcRy6p9BfOUwPJLwc8uGXdzqjD4+U/JZ9UbAsS7ifHe30/iW6yyDZfVSiTtZ2ZhNwXtBPqrY/F3R+pIl0FQ98dBc0H12aJdLUpUelSVmrKnUVZdaWhtgRUT48Be6mMCqcf1xoW8LjOoRLasOZcFjI9aiNT3FmFz6e+UIJdsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDQljEeT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDQljEeT"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso1027671a91.2
        for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792067457; x=1792672257; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bP097IaFVg+ee8qcuCUPV4BYG3UfgGA0OapDc5inZ7w=;
        b=GDQljEeTf8vtjbIiPTFqhCIiIHPdYQDTW/4FiKJLjv7cbkg8zA4DmOuTY9VF7NB1+5
         8YlC1uYLa0vd5WOT89QE8GqPUNwTi8+jAikAFy46uUrkj/HpIJjQesndjK4jpQp4YTU/
         kGs+6Yqs/AjE323xv17JtIlcTfT8GIqI7PuACFo+E9eaw05FMc62ziaK674xlsDluLrb
         vxIGL9h2fTfg+yctKAVzrv6yollTYF8A6qmsBqzlSH+1M79B8aFpvYNGMVs/QZBuyXkV
         v4mt0CxXKV7E+ZB/wrk+eQinkC62Q/AkXBHzn5aTpi3ksjTaTRnDdD5ybz9vxnnchJYD
         CM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792067457; x=1792672257;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bP097IaFVg+ee8qcuCUPV4BYG3UfgGA0OapDc5inZ7w=;
        b=DMAE9nGUppF6OEdzxuWJIRWDUMO2or7032QYIKsGDuOOxRp0YoQCGKT42ZLQu8eF8S
         ++M/tNHaZiZoeIrgF4wgBD6WPPtCi9GIkfWtJsin9AEokCfQcwPvaUnr0rtppPVDZKbw
         SLJsZbaQZnIiAnQazggliprfruPu89+W8TQ5JsNz7k3yWdCLmOPbb//eSK/L1Ay22kGg
         gQMdRRSrKPbsEFuSWNi22eEvYPccqIMpsERI9eC7OHzsEQ2HUqSLAHs2dcyyzsivNWf/
         IOFTKx7jYbuY2hy/wAxIDnmAFuug13SQlS8LKy61d2RvDlgTOWQH11D+SAHJqSlsKxjP
         osoA==
X-Gm-Message-State: AFq9FYK7zcGu/AG18kftDJxkx9M7Maoe9ouFdV80s6IB+mWBdA0tScWa
	o/vCZVX9+ypfRUVJQoajab7C1aQoLZdefg/3K5wmPb6+llHCZHREz446C98rYwWE
X-Gm-Gg: AYBFou3xOecrjKIqkCHEmwSwkWTY9Z3ldGcIXffWYIudLIAxaLAfzS4LaYu/T/9xMN/
	npyWyJ49NZ7IKRjTnmN6eSa6Il8anAP+oRznDGFso9E4mnHY9rGQR15pg3tvajJOPwKN0BGpdAa
	qnOXRqcU1PudxxAuYsDKS38+dlyxtfamnWo1wV0f2ZisEiCFEcCmTT/hmo9GzLDTW1FPCqf2rXf
	7eQ9r0JKtgyDd/B7wBYowUcJOUGfm0wJpvkhfUcLKD46n1RaVWxWJRx6QSO57sDmOIebqkeiKNT
	JKBkpqjccRy33/mqEz1JCZL5BzHdWtjTBSyzQw7usg2xyG3qa7/1AF1LlLbjCN2I2rhhu7PHCzI
	pM9+OOTOP3P4zVwiHK2HpA4DhpEWpKgc1qkLx7xy6DR76FZT2z14T+vQYzSlt9H2nLNaty5YeLK
	VIcc2kVDy/bDJ8RoRPEQLA9rTqdln3aXfO+xDKPvMONx3v2IO9MhMoO68iPo7NmjrI00wcH4s=
X-Received: by 2002:a17:90b:534e:b0:3ac:7f4c:a690 with SMTP id 98e67ed59e1d1-3ac7f4cbb76mr3119425a91.35.1792067456780;
        Thu, 15 Oct 2026 05:30:56 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.94.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac945e7320sm4218700a91.6.2026.10.15.05.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 05:30:56 -0700 (PDT)
Message-Id: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
From: "Venkat Ragavan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 12:30:55 +0000
Subject: [PATCH] refs: fix loose-ref seeking across directory boundaries
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
Cc: Karthik Nayak <karthik.188@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Venkat Ragavan <mail2venkat21@gmail.com>,
    Venkat Ragavan S <mail2venkat21@gmail.com>

From: Venkat Ragavan S <mail2venkat21@gmail.com>

When seeking through loose refs, cache_ref_iterator_seek() compares
each directory component without its trailing slash. This can confuse
a directory with a similarly named ref that sorts before it.

For example, with these refs:

    refs/tags/releases-z
    refs/tags/releases/v1
    refs/tags/releases/v2

Starting after refs/tags/releases/v1 can position the iterator at
releases-z instead of descending into releases/. Iteration then
returns v1 again, even though it should return only v2.

Include the trailing slash when comparing directory components so
that the seek follows the correct directory.

Also handle two related positioning errors. If every entry in a
directory precedes the cursor, stop searching that level rather than
descending into its last entry. If a leaf sorts after the cursor,
leave the iterator positioned to return it, even when the cursor has
remaining path components.

Add regression tests for shared-prefix names, missing nested markers,
and markers beyond the end of the ref listing, using loose, packed,
and mixed refs.

Signed-off-by: Venkat Ragavan S <mail2venkat21@gmail.com>
---
    refs: fix loose-ref seeking across directory boundaries

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2258%2Fvenkatr21%2Fvenkatr21%2Ffix-loose-ref-seek-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2258/venkatr21/venkatr21/fix-loose-ref-seek-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2258

 refs/ref-cache.c               |  6 ++--
 t/t6302-for-each-ref-filter.sh | 55 ++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index ffef01a597..a3bc2dc11b 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -506,7 +506,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 			sort_ref_dir(dir);
 
 			slash = strchr(slash, '/');
-			len = slash ? (size_t)(slash - refname) : strlen(refname);
+			len = slash ? (size_t)(slash - refname + 1) : strlen(refname);
 
 			for (idx = 0; idx < dir->nr; idx++) {
 				cmp = strncmp(refname, dir->entries[idx]->name, len);
@@ -520,6 +520,8 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 				slash = slash + 1;
 
 			level->index = idx;
+			if (cmp > 0)
+				break;
 			if (dir->entries[idx]->flag & REF_DIR) {
 				/* push down a level */
 				dir = get_ref_dir(dir->entries[idx]);
@@ -532,7 +534,7 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 				level->prefix_state = PREFIX_CONTAINS_DIR;
 			} else {
 				/* reduce the index so the leaf node is iterated over */
-				if (cmp <= 0 && !slash)
+				if (cmp < 0 || (cmp == 0 && !slash))
 					level->index = idx - 1;
 				/*
 				 * while the seek path may not be exhausted, our
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 7f060d97bf..826fc1b9f2 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -746,6 +746,61 @@ test_expect_success 'start after used with a pattern' '
 	test_cmp expect actual
 '
 
+for storage in loose packed mixed
+do
+	test_expect_success "start after respects directory boundaries ($storage)" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit --no-tag base &&
+			git update-ref refs/tags/packed HEAD &&
+			if test "$storage" = mixed
+			then
+				git pack-refs --all || return 1
+			fi &&
+			git update-ref --stdin <<-\EOF &&
+			create refs/tags/a-leaf HEAD
+			create refs/tags/a/nested HEAD
+			create refs/tags/a0 HEAD
+			create refs/tags/b HEAD
+			create refs/tags/releases-z HEAD
+			create refs/tags/releases/v1 HEAD
+			create refs/tags/releases/v2 HEAD
+			EOF
+			if test "$storage" = packed
+			then
+				git pack-refs --all || return 1
+			fi &&
+			echo refs/tags/releases/v2 >expect &&
+			git for-each-ref --no-sort --format="%(refname)" \
+				--start-after=refs/tags/releases/v1 >actual &&
+			test_cmp expect actual &&
+			cat >expect <<-\EOF &&
+			refs/tags/a0
+			refs/tags/b
+			refs/tags/packed
+			refs/tags/releases-z
+			refs/tags/releases/v1
+			refs/tags/releases/v2
+			EOF
+			git for-each-ref --no-sort --format="%(refname)" \
+				--start-after=refs/tags/a/next >actual &&
+			test_cmp expect actual &&
+			tail -n 5 expect >expect-later &&
+			git for-each-ref --no-sort --format="%(refname)" \
+				--start-after=refs/tags/aa/missing >actual &&
+			test_cmp expect-later actual &&
+			for marker in refs/tags/zzzz refs/zzzz zzzz
+			do
+				git for-each-ref --no-sort --format="%(refname)" \
+					--start-after="$marker" >actual &&
+				test_must_be_empty actual || return 1
+			done
+		)
+	'
+done
+
 test_expect_success 'start after used with custom sort order' '
 	cat >expect <<-\EOF &&
 	fatal: cannot use --start-after with custom sort options

base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
gitgitgadget
