Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C417C2192FA
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787949352; cv=none; b=IusxgGJtNFXLjzYYPUwWKqX/VlJqDFPaij4Y7kLDRLMdMsKoR/6w5Whna+pUmk9com1T8nOlQu4rjZTncL+bVHUr3X6iQ2w2LxXGzHWGrPqOiVoN81G0o9oSVgzmhvwAnYWT4bJF7qt+aGpqk1AyP7QXvttvb1XeVZ2lNxoTze8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787949352; c=relaxed/simple;
	bh=5HPLSAA4RaCXLCrmzOkh/6b4IUMuRiDfsqZBvE/o2qs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Omw5aLAQ/NemUcgwGa97F6/tZQ8/s12oEyLPZ0WJTWJei/9uh1YJV9UWLZg55XpPLr+DRmfU8zKlgfM7OAWGIhx4OQzdRpEBFkbQ710xHvo2gvAIs28qkhX1SEquVlfdUapEy6xuBATTzuOSq8EGNlNfy0LAHaL6SCdpcWD5ius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufxw/EyG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufxw/EyG"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1152165a12.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 13:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787949350; x=1788554150; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iPYdiIfFCPJ5sFn+FKWKRmVmwHcywim8fI1XSF+bdFI=;
        b=Ufxw/EyGptp0A3n5eeidxPBffVcIrJgBL19IFGT2HJv+AhmwcuMIRdQNAzIfyeNBtE
         6ygq2saNARP6eSrRNahbV+lAIXTSesxcWvkL18YSD+PnH5k4PTrZHYD+PdapYdLCW8AP
         UuK/bif+wcz26vfc8D97us+RtaIoN9DbwT5zFnqPopGyy72kh6idj3utw//hhG596wFL
         uHek1K7fP6AVA4PzZADl4OKDpOIcXIsOmmPq0QmmsaWvHHHbVfcmO4faljKEGrJ+IpLl
         aOAdygONYpJ9qitTDhjTne6a36L1tNSycd6x2A2I21OwazimSoIADdgJm/wVupGGjgSD
         /I9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787949350; x=1788554150;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iPYdiIfFCPJ5sFn+FKWKRmVmwHcywim8fI1XSF+bdFI=;
        b=F8S0yaHItarz2xySaW1txiHWAm4cr+oBuPejD1rwC0UIMIEhPlQELCEybch9Oow6cM
         xhnV9ocYV6OF3Q4ROxDS/7nXcjKcwvQCHKIRu/NeP/5a/Qs0di7tRHWQUAjrNKrukmFa
         aC8ENoSCNAviVWIz5HyR8A9MFmtsJ26DDwtV9hgVevYDTaBEO5IV+eYGn6BZbyuywlze
         ZEvB0RYAlx3PxipNvLSn0aRdy5j67syELVcn9suCXoQCbPvwckYOCl+a50/LvfFX+u7v
         5mvCvH3+T1CqBQVp2hYDRY4dXGEQpIZxSh+jgPWawvwj5iH/ACeacD49P5DEwLNPEWZ9
         SoHQ==
X-Gm-Message-State: AFuF++kY2xEC6NS2NRkxhOqfv9Indu+xp0RfLY16YuUfrzAR+l2MBVkB
	ZEZUqdrm7ztDCQ9dZbmAgZ4VYKKSCetx4lImt/BR88s+dZy0nnBeYLP2hHMcqA==
X-Gm-Gg: AR+sD13VHE7qh/gMgazyM2zfU3WEDXNQffaFEofhgwZ1CAEknlE5GTBG1Kre84wjAFC
	nNRZ08cf15LU1AhMhJSy4j+NVtaFvSzS4LlSgcq3UFRJX1uAa1DPYHlrbBktIjj1ab6ga+vRJm+
	5NbibNedwx8kiNOXTKj/o5zItr79E0ZTOaMKjGVfSP15eyzNKJGUkSxOVukmTrJpWT7oZrK2sQt
	VU547/WRbwbXnWrkDD37OYw3spoI9uqNPBs/YZLnjUr30WSJgo+O5G3OcaTFYOXUQ7pW2SeEZCW
	07vJBfkefABZWfJlfNPZl5GCUnNhIV26EWX4a/fa3zfIk/QtHd2VOYqY/DSgD4UXu/5RHGCxGPd
	1S2BEvpIx+o73eHcPu6rVpWdTc3iVsStDDOlg0ACMywANg2K4bk7cTW3SgQALP+XuKVvGcgEzly
	OKeQS1kjbfeNrDCpuEwHKHn5oyRZhhbIgm2f5NDFVbzbVHozJ/7N9y7gCchpg39VT0sQ==
X-Received: by 2002:a05:6a20:d529:b0:3d1:be60:2811 with SMTP id adf61e73a8af0-3d2682a18b0mr18329018637.15.1787949349867;
        Fri, 28 Aug 2026 13:35:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.213.243])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9595bbsm9139331eec.14.2026.08.28.13.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 13:35:49 -0700 (PDT)
Message-Id: <pull.2391.git.git.1787949348110.gitgitgadget@gmail.com>
From: "Diogo Castro via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 20:35:48 +0000
Subject: [PATCH] dir: fix negative pathspecs in 'git ls-files' and 'git add'
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
Cc: Thomas Haller <thaller@redhat.com>,
    Jeff King <peff@peff.net>,
    Diogo Castro <dc@diogocastro.com>,
    Diogo Castro <dc@diogocastro.com>

From: Diogo Castro <dc@diogocastro.com>

`git ls-files` calls `common_prefix()` / `get_common_prefix_len()` which
calculate the length of the common prefix of all *positive* pathspecs,
`max_prefix_len`.

`max_prefix_len` is then passed to `match_pathspec()` ->
`match_pathspec_with_flags()` -> `do_match_pathspec()`, which strips
`max_prefix_len` bytes off of *all* paths and `match_pathspec_item()`
strips *all* pathspecs (positive or negative).

This causes the bug previously reported in [1].

As a result, when we run `git ls-files -- sub/sub/sub/file
':(exclude)nonexistent'`:
* The common prefix of the positive pathspecs is `sub/sub/sub`, 11 bytes
* 11 bytes get stripped off both pathspecs:
  * "sub/sub/sub/file" becomes "/file"
  * "nonexistent" becomes ""
* Since the negative pathspec degenerated into "", it matches every
  file, and thus no results are returned.

When the common prefix is longer than the negative pathspec, we read out
of bounds.

`git add` suffers from the same issue. It uses `fill_directory()`, which
returns the common prefix length, but doesn't strip the trailing slash.
Using the same pathspecs as in the example above, the common prefix
would be `sub/sub/sub/`, 12 bytes.

Only `git ls-files` and `git add` are impacted. Other callers pass in
`0` as the prefix.

Bug introduced in: ef79b1f870 (Support pathspec magic :(exclude) and its
short form :!, 2013-12-06).

Solution: in `do_match_pathspec()`, only strip the prefix when handling
positive pathspecs, not when handling negative pathspecs.

[1]: https://lore.kernel.org/git/e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com

Reported-by: Thomas Haller <thaller@redhat.com>
Signed-off-by: Diogo Castro <dc@diogocastro.com>
---
    dir: fix negative pathspecs in git ls-files and git add

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2391%2Fdcastro%2Fdiogo.castro%2Ffix-pathspecs-common-prefix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2391/dcastro/diogo.castro/fix-pathspecs-common-prefix-v1
Pull-Request: https://github.com/git/git/pull/2391

 dir.c                       | 11 ++++++++
 t/t6132-pathspec-exclude.sh | 52 +++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/dir.c b/dir.c
index 32430090dc..3fb2764efe 100644
--- a/dir.c
+++ b/dir.c
@@ -539,6 +539,17 @@ static int do_match_pathspec(struct index_state *istate,
 			return 0;
 	}
 
+	/*
+	 * The `prefix`, calculated by `common_prefix_len()`, only takes
+	 * positive pathspecs into account. Negative pathspecs are not
+	 * considered.
+	 *
+	 * Therefore, the prefix can only be stripped from positive
+	 * pathspecs, not from negative pathspecs.
+	 */
+	if (exclude)
+		prefix = 0;
+
 	name += prefix;
 	namelen -= prefix;
 
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 9fdafeb1e9..dd54378019 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -425,4 +425,56 @@ test_expect_success 'stash with all negative' '
 	test_cmp expect actual
 '
 
+# `ls-files` finds the length of the common prefix of the *positive* pathspecs.
+# In this example, there's only one positive pathspec, so the common prefix is `aaa/bbb`, with length 7.
+#
+# Before the bug described in https://lore.kernel.org/git/e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com
+# was patched, as an optimization, we would then strip the first 7 characters from the path,
+# the positive pathspec, and (incorrectly) the negative pathspec.
+#
+# But stripping the negative pathspec would mean that `xxx/yyy/file` becomes `file`
+# and we'd wrongly end up excluding `aaa/bbb/file`.
+#
+# After this bug fix, `aaa/bbb/file` should no longer be excluded by `:(exclude)xxx/yyy/file`.
+test_expect_success 'exclude is not matched against the tail of the path' '
+	test_when_finished "git rm -q --cached -r aaa xxx && rm -rf aaa xxx" &&
+	mkdir -p aaa/bbb xxx/yyy &&
+	>aaa/bbb/file &&
+	>xxx/yyy/other &&
+	git add aaa xxx &&
+	echo aaa/bbb/file >expect &&
+	git ls-files -- aaa/bbb/file ":(exclude)xxx/yyy/file" >actual &&
+	test_cmp expect actual
+'
+
+# Before the bug described in https://lore.kernel.org/git/e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com
+# was patched, when the negative pathspec had the same length or was
+# shorter than the common prefix of the positive pathspecs,
+# then stripping the common prefix from the negative pathspec would result in an empty string,
+# which would match everything, and thus exclude all files.
+#
+# In this test, the prefix for "sub/sub/sub/file" is "sub/sub/sub" (11 bytes).
+test_expect_success 'ls-files keeps entries when an exclude matches the common prefix length' '
+	echo sub/sub/sub/file >expect &&
+	git ls-files -- sub/sub/sub/file ":(exclude)nonexistent" >actual &&
+	test_cmp expect actual
+'
+
+# This test is similar to the above, but tests `git add` instead of `git ls-files`.
+#
+# `git add` does not exclude the trailing slash, so the common prefix is "sub/sub/sub/" (12 bytes).
+test_expect_success 'add keeps entries when an exclude matches the common prefix length' '
+	test_when_finished "git reset -q && rm -f sub/sub/sub/untracked" &&
+	>sub/sub/sub/untracked &&
+	git add -- sub/sub/sub/ ":(exclude)no/such/path" &&
+	echo sub/sub/sub/untracked >expect &&
+	git diff --cached --name-only HEAD >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'an exclude shorter than the common prefix still excludes' '
+	git ls-files -- sub/sub/sub/file ":(exclude)sub" >actual &&
+	test_must_be_empty actual
+'
+
 test_done

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
