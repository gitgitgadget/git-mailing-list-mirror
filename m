Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF6E3659FD
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 14:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214322; cv=none; b=hZC0ZQqp41iJshn2O/JAexla5UTIDDCQU42UwciTQWN+Bb2NHKtpD7ALyoXNQPNOP59dyEJRNxLasFboJdsXWDuLhIKzqE9l8kCn4YyttWLcfl10TTkP5gd/FHGnBOYMe5QPG3aYDAcbNDIiN4CTA7DBqIu2nGtNl0+wgbVtJQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214322; c=relaxed/simple;
	bh=mGMGVQV/EtfsNWPwEjqZm2i6zrRsfN/rJ7tpGqWp2+Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UifKez2nSws1u01KUZctSpufO31HqTUyeuh8mW3nfev97G2C4JxSHIXRFTqICMOR4rMt5uADJshWQGgF8nmq4ShVQyBHuJGURoKgEFtkKQiUVfkfxYubO551lMMjMK2h3crwXmYbRNPtz1+78au7vpHj/I2emiEizfER2U91u3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdcR9AqI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdcR9AqI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8f0579401c4so537385985a.3
        for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214319; x=1777819119; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O7iK154zG9qCUqWrNtX74S7hq50wUppdT6sybgdLsEE=;
        b=JdcR9AqImA4+J2CxsDTjG3gqmgMra6/eaeSkfleMEciBRZ1IMfYLrNUtwR+MAtqo65
         pqxe5d7VYtS7AQLOJSnCcN1yDqof4CJc4Mpnnv+Ke+ViqsnKyAR+2KSLD4hgVwGBA9VY
         GmeOHSl1huMc4tYYhHvfzZg70ZGRpgrSh4r4bcKs86dXcyA8yH+Y6hqinspqdCwHzQ37
         1P+/JXVLQgnLKAVBKV7UfivCM6mAfl5cA9cSWQfWPrKwRiGkhFmNha15R5Rf34D28lIL
         yLTddIWqU9DRXqiWJfPerxbJ0B8K3SLMaGi9dkT/BN+IdmKqMk6Tg49aSk3ggKUuryl+
         zFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214319; x=1777819119;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O7iK154zG9qCUqWrNtX74S7hq50wUppdT6sybgdLsEE=;
        b=NASG8KSDXUCEs5lwsadqQuDqRlHWt2JIk0HRWvjcbcAqCfxl6fd7dHEwrvOlPoPS8p
         T8bCN0K9VNYknXBMAT6aBSR1gv+eB+R0JlAdDadAZhouvJjxYoekLR6FJYSsfb6Rlo0v
         YxTwTsQASmkLXKksmHj5/PGwsCL8JrG84/f3o91zCYjhNuWmuOwpaKVCvL3cIApWmWdK
         MBO7RvldoKHs1KwVPg12Pz5HIfl7HXEIYPntk10/Rc5KBjfbu+HKqnmMhIUIDycFxdHO
         PNye92YLiugq3MEv/UI7QmbD1wRh5zk02fbMCpGoD6L1csAzjO2z0PByYWdJkXZX93Zg
         A+MA==
X-Gm-Message-State: AOJu0YzLzEvXdDvEyK5n0YlCT0VDJtSoroICSpdSziLluOVMO5jyguro
	1jrkYQnipgLQ2eIYCwtOAI9wnVAv6lYwKFk6JOrnktAyJJhJpWUizHDXXvJ8EJxG
X-Gm-Gg: AeBDiesNKkwjDXJ18Bogbb8HC4reQhIkP4R7zW8Gs3YdITmoVEtY4gWsogJJM73hUmg
	tgLsDsbNaDbT1c2KRwy6vLYERNfErgic1s9tHTYlnn9R83Y7WdqUNjX3N0eTCCsJrzvYuYAwk7B
	h7kGNzlBH7wnErypNv9ZTnMXw539v0GRpUb/QTX+D3L9bOtMrmCukxRc+yWqhiGm5yjGLiPn54x
	EB4x4M/RqKMKAfzaMHBfXcZheRK+UYZnrqhBJ2QOguoAsWY73ewZPrTYQjax8+JAeN2wpWrfj6L
	Ww98U5yhJH+CVYpBaEJQPXwKZ+d2mBueg5E/iGdQXw1nRtIirfFgOQCH816CbyNjBPk2r+U6pOl
	IgDIQ/CUBmQno3WHyQgqR66wpVRthg2ngtZcmfElY5MiGU3FrC6zjmnory2UqsLvWr4JfCNhuoC
	ZhiJW2++AUWgQTfvOpIpOKaht3TufT8ETP9A==
X-Received: by 2002:a05:620a:4096:b0:8ef:ca26:dce5 with SMTP id af79cd13be357-8efca26e0eamr2919529985a.15.1777214319409;
        Sun, 26 Apr 2026 07:38:39 -0700 (PDT)
Received: from [127.0.0.1] ([20.98.18.66])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm241980256d6.13.2026.04.26.07.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:38:38 -0700 (PDT)
Message-Id: <179fcf5369dcccf4c2bef5d991e33bb92cd71bb8.1777214316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
References: <pull.2098.git.1777042877.gitgitgadget@gmail.com>
	<pull.2098.v2.git.1777214316.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 26 Apr 2026 14:38:29 +0000
Subject: [PATCH v2 1/8] test-lib: allow bare repository access when breaking
 changes are enabled
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

A future patch will change the `safe.bareRepository` default from
`all` to `explicit` under `WITH_BREAKING_CHANGES`. At that point,
every test that operates on a bare repository through implicit
discovery would fail, regardless of whether the test is actually
about discovery or about how a specific command behaves once inside
a bare repository.

The maintainer suggested [1] setting `safe.bareRepository=all` in
the test environment's global config whenever `WITH_BREAKING_CHANGES`
is in effect, rather than adjusting each affected test to access
bare repositories explicitly (via `--git-dir`, `GIT_DIR`, or
similar). This means the test suite continues to exercise only the
historical default behavior even after the user-facing default
changes, relying on a small number of dedicated tests in t0035 to
validate the new, stricter default.

Since `$HOME` points at the trash directory (which doubles as the
test repository's working tree), writing to `$HOME/.gitconfig` also
creates a file inside the working tree. Exclude it via
`.git/info/exclude` to limit the fallout, though this does not
help tests that use `git ls-files --others` without
`--exclude-standard` or `git status --ignored`; those are addressed
by subsequent commits.

The `.git/info/exclude` write is guarded by `test -d .git/info`
rather than using `mkdir -p`, because some tests (e.g. t0008)
expect to create `.git/info/` themselves and would fail with
Patrick Steinhardt's `set -e` preparation (ps/test-set-e-clean) if
the directory already existed. For tests using `TEST_NO_CREATE_REPO`
(where no `.git/` exists at all), the guard also handles that case.

[1] https://lore.kernel.org/git/xmqqse98cc51.fsf@gitster.g/

Original-patch-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 70fd3e9baf..72ed87b781 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1597,6 +1597,19 @@ cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
 TRASH_DIRECTORY=$(pwd)
 HOME="$TRASH_DIRECTORY"
 
+if test -n "$WITH_BREAKING_CHANGES"
+then
+	git config --global safe.bareRepository all &&
+	# Only write to .git/info/exclude when the directory exists
+	# (i.e. when git init created the repo). If we mkdir -p it
+	# ourselves, tests that expect to create .git/info/ themselves
+	# (e.g. t0008) would fail.
+	if test -d .git/info
+	then
+		echo "/.gitconfig" >>.git/info/exclude
+	fi
+fi
+
 start_test_output "$0"
 
 # Convenience
-- 
gitgitgadget

