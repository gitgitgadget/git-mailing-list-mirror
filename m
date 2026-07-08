Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2AB3E16A9
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 21:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783546937; cv=none; b=EiT2fwy5B7oj8HvK89b3HMSTZ0R7O0NrSLeKGFqVAYwOe3EOYijGUEnJvCctEOMff95TNjM9qorA3uBxk4HNFaVkcOLXhtkxCKPItz6Yv1xlN3pzplPwRWF8cMrvOWvtD2rCt+xItWPwDJZiEt7aDNFqE5PXz8POvMYlrEGV5X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783546937; c=relaxed/simple;
	bh=KwF9TxGuo1L8w/f6mm7cOwnFUWKA2oy164d6erqwSnA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Oably2HWkkz8pV+20YcenheTIO9B0KZOWI8Od6XrYytVP1PCccnz53zz/0lQR1hzmfQqjf9zXmXxpYZWCcgeyG7OvIxlbiaJyn5gEvfjKYxqqV9Wb6afZUJz3eidX/DF7srB5vBjilfqZRcMFwh9aL2XskW9GonIP5d1VT/V4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZG/PQpF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZG/PQpF"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c999f162c9aso665417a12.3
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 14:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783546935; x=1784151735; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rngDcByDccskUGcHs4uQTjHn1jNB6X8s34BARSmbWog=;
        b=JZG/PQpFmhrzflC3eQOQNVGzRN3EaXXDx7G2Rr/K27SYLqOwT7hD2vABfszmXnSC0e
         cwPlUWXpPl+t8j/wkqs8T41sk3uyCQKTclKy+Zc3+QLHVOR+9wMuhAdCQp8dy7b+NlPI
         MAQ8yhGkolCDwaYRmviX46+Y8cIvV1IHNECS1PDjz+NvoICu3uDo6VL8voAMojFx3r/O
         1xX/bbI6q8yRavfCrklOmA/PKND7BM9hTlABFuRnkPslhFQJBYv3MtqJQVnCs5+spNap
         rXg21HQ+KFiukTFa2b96AJX7PQ2MT1Fq0vcz5ErkDjWZL7sSrYA1Z0Q8U/DVQF1sB+b0
         gEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783546935; x=1784151735;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rngDcByDccskUGcHs4uQTjHn1jNB6X8s34BARSmbWog=;
        b=LeNF9zED3cdKiSYAfcyBUela/L8ZSuRCD7ogaBAulEuXyLPobfk1B6wEJaB76fCIml
         xkumMtgXE7SKRP+8rw5Dr132CjpF+wIMUNOMRROR+xnf8bt22a2u/8yNSXvm3YGofomW
         0b5OtrSetzupvJTj8tWLZBaq8SJP6AqitISmAC1hBE5Lf9eMhjxBDJcFwKjRdeagNme0
         F1Zaomm5SGWMXh/GeRYjv7VTzEIlB9LkmIAS7tqgQBXA7y0JhYMnyJpiDr5UfINWixJg
         DD95AigYe51v19xfPWKOdNn+211hLCA7JWffs8fW2koqG1rV/OsC/2bF1VORM7ohfcwd
         p5fQ==
X-Gm-Message-State: AOJu0YypqPsX0x4/F8GY8r+wawcHQMFqjTQn3qGsgF21Uv4U6jQm9nyv
	c/J1/swJ6uf2sWLdBwgNDoXYAG2QXMCepx/q+CAZBRiVdQYZlgkAw2CtzPLLNg==
X-Gm-Gg: AfdE7cmcfKjBz9wCyi5s+45aamH+qKR+2ujfl8WJ+Vc3LJhWnSITwaUFaVXcq/ULNgb
	wyaq5PdTSp2Mqfydmws2z6hPOGwVpbn6FkVYCqkLFOmoZiY1PZfhh/U7AJx5QkRSXrWLbpeYHd3
	RrtuUbmJf+ksDg9OuDPNm42c2bkDXZW3Dqzuwap9dHdO22oaHDDlO9lPmWMTNA55GiricCyJ/cs
	6r+sb4MIGSzPnBRKVphTeNTjFB6FUKzAD7BB1JU+YuM2RqYFqEuuue1lMS9XKB2lheQ+CTQDDuh
	i2EgOI6+iO/E81d/FeX7QXgwPH+S2QpEDgaT7igvFJ8Yz8mnZ307TkXsYZG5u8awUgKkXaV85Yk
	0o1EXpYmCjeQP+tVVAKs2snVzqft0rZ9xrVlPH9JrKIE8qiVuLI66ehIlOqXT/eL10W8c50jlcH
	MDB4XgvuZKQKoNnFP3
X-Received: by 2002:a05:6a21:7001:b0:3bf:c07b:a9a7 with SMTP id adf61e73a8af0-3c0bcc23c7dmr4802833637.50.1783546935524;
        Wed, 08 Jul 2026 14:42:15 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.161.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174accae5sm36041245eec.29.2026.07.08.14.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 14:42:14 -0700 (PDT)
Message-Id: <pull.2353.v2.git.git.1783546933992.gitgitgadget@gmail.com>
In-Reply-To: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
References: <pull.2353.git.git.1783458106037.gitgitgadget@gmail.com>
From: "Henrique Ferreiro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 21:42:13 +0000
Subject: [PATCH v2] unpack-trees: avoid quadratic index scan in
 next_cache_entry()
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
Cc: Henrique Ferreiro <hferreiro@igalia.com>,
    Henrique Ferreiro <hferreiro@igalia.com>,
    Henrique Ferreiro <hferreiro@igalia.com>

From: Henrique Ferreiro <hferreiro@igalia.com>

Diffing the working tree against a commit with a pathspec can take
time quadratic in the size of the index when the pathspec matches a
subtree whose entries are the first entries of the index.  Fix it by
having next_cache_entry() record how far it scanned in cache_bottom,
so repeated calls no longer rescan the growing prefix of
already-unpacked entries.  On a Chromium checkout (~500k index
entries),

	git diff HEAD -- .agents/OWNERS

took about 8 minutes before this change and 0.07 seconds after it.
The same diff without the commit, without the pathspec, or with
--cached was already instant.

Add p0009-diff-pathspec.sh, which builds a 10,000-entry index whose
first path lives in a subtree (100,000 entries under --long-tests),
to guard against the regression.  Comparing v2.55.0 with this change
using GIT_TEST_LONG=t:

Test                            v2.55.0           HEAD
------------------------------------------------------------------------
0009.2: diff pathspec subtree   7.16(7.12+0.01)   0.02(0.01+0.00) -99.7%

Signed-off-by: Henrique Ferreiro <hferreiro@igalia.com>
---
    unpack-trees: avoid quadratic index scan in next_cache_entry()
    
    Changes since v1: adjust the synthetic index size based on the EXPENSIVE
    prerequisite.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2353%2Fhferreiro%2Funpack-trees-quadratic-scan-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2353/hferreiro/unpack-trees-quadratic-scan-v2
Pull-Request: https://github.com/git/git/pull/2353

Range-diff vs v1:

 1:  cc1aaf01cf ! 1:  c8f1ca389d unpack-trees: avoid quadratic index scan in next_cache_entry()
     @@ Commit message
          The same diff without the commit, without the pathspec, or with
          --cached was already instant.
      
     -    Add p0009-diff-pathspec.sh, which builds a 100,000-entry index whose
     -    first path lives in a subtree, to guard against the regression.
     -    Comparing v2.55.0 with this change:
     +    Add p0009-diff-pathspec.sh, which builds a 10,000-entry index whose
     +    first path lives in a subtree (100,000 entries under --long-tests),
     +    to guard against the regression.  Comparing v2.55.0 with this change
     +    using GIT_TEST_LONG=t:
      
          Test                            v2.55.0           HEAD
          ------------------------------------------------------------------------
     @@ t/perf/p0009-diff-pathspec.sh (new)
      +
      +test_perf_fresh_repo
      +
     ++count=10000
     ++if test_have_prereq EXPENSIVE
     ++then
     ++	count=100000
     ++fi
     ++
      +# The entries exist only in the index, which is enough to
      +# exercise the index scan.
      +test_expect_success 'setup' '
     -+	count=100000 &&
      +	blob=$(echo content | git hash-object -w --stdin) &&
      +	{
      +		printf "100644 $blob\taaa/file\n" &&


 t/perf/p0009-diff-pathspec.sh | 32 ++++++++++++++++++++++++++++++++
 unpack-trees.c                |  4 +++-
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100755 t/perf/p0009-diff-pathspec.sh

diff --git a/t/perf/p0009-diff-pathspec.sh b/t/perf/p0009-diff-pathspec.sh
new file mode 100755
index 0000000000..6079db52c2
--- /dev/null
+++ b/t/perf/p0009-diff-pathspec.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='Tests performance of diffing the working tree with a pathspec'
+
+. ./perf-lib.sh
+
+test_perf_fresh_repo
+
+count=10000
+if test_have_prereq EXPENSIVE
+then
+	count=100000
+fi
+
+# The entries exist only in the index, which is enough to
+# exercise the index scan.
+test_expect_success 'setup' '
+	blob=$(echo content | git hash-object -w --stdin) &&
+	{
+		printf "100644 $blob\taaa/file\n" &&
+		printf "100644 $blob\tf%s\n" $(test_seq $count)
+	} | git update-index --index-info &&
+	git commit -q -m initial &&
+	mkdir -p aaa &&
+	echo content >aaa/file
+'
+
+test_perf 'diff pathspec subtree' '
+	git diff HEAD -- aaa/file
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index b42020f16b..ed9fef453a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -671,8 +671,10 @@ static struct cache_entry *next_cache_entry(struct unpack_trees_options *o)
 
 	while (pos < index->cache_nr) {
 		struct cache_entry *ce = index->cache[pos];
-		if (!(ce->ce_flags & CE_UNPACKED))
+		if (!(ce->ce_flags & CE_UNPACKED)) {
+			o->internal.cache_bottom = pos;
 			return ce;
+		}
 		pos++;
 	}
 	return NULL;

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
