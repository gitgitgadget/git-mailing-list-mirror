Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5719AD48
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 05:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741240691; cv=none; b=qwWK5iTzUvO0sYETkS4SRxC0Lz46c0D1gHTMbehH2tOM0UbNlNgeHudM4inHK1D2PwPpRHAynEHYjyTvcfzHPnBHtk2PMB3U1CktxokmqxpUuD1s3HtCOY5DoZCnKifBUpDxOUUBesD7KDwUUnclMIKaBuI4Y2YbSCBCkQdTdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741240691; c=relaxed/simple;
	bh=2bFavhysJwhG4U2Pq/U/T/fb3WvzTZvbuDgkkhwX0F0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CQFfZshQSRco+1HE2yicwNBtrg+OvbLke3bbZPX1f4ANR2s5Hg4Z7XO+H1b3+GqZplb6PoJhlRejE2s7Tc50lcaQ7cGvcm0xp/e1hmfHfYRbDxP1U2LnwgQp6sgrxUCQVdO5dmkofelUBwZA7BzdfPDvKUulllfzCGuTyN/UaaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzERE4j8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzERE4j8"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43bcb1a9890so10086915e9.0
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 21:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741240687; x=1741845487; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iM7BMEbR09X40sCGGRebJ5LTwomeJ4m2o/3+cFq/QB0=;
        b=hzERE4j8mVr1gyB/zCNaPtnr5ALfzOyXyCEPiAP5fGaTpEU30DigUu/kLqJqj7Li5n
         krISVrpxcNvPA9viL8+tUfoltBuRdmCOtQCR29U0WlT6nAEK17B9OOvi+2MLqcxI/4YL
         Cd5FktHsraDdzpexkkiQX7m7HXofwtxHLrsMlO+dUpjCMGj7wBs20JLYgZNL51AQTxYs
         qHQwsISsBeN12ifDkIVOVsvPT5k3NoINJjyKr4HUOR6NUK9kjnwfKa7Lr/9CR9jSjYQk
         YIqcLSZhBdIEy3TXyS0B2XyZrrn/FyTI8dXHOus+Xu4W6ST4R661dgn9sGn1aNd2OPtT
         ysgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741240687; x=1741845487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iM7BMEbR09X40sCGGRebJ5LTwomeJ4m2o/3+cFq/QB0=;
        b=eBotRRtxU/TMQa/q6GkXc2xBpawowD5W1PFE4NeykY93NiCCtjmXJ0AQJaTsZomn3h
         XCz0ikLHONP4r1fgZ2lgh0sxetGZSN5/EcnNcnWnfAgHzg3c0Fk2trgFkjr96yTh4j9Y
         tl5lLaYccQVo44LEomDoSVX5zjFj3qoo9iP2VMZ5SapqYvjF2vP7zTew4sDRczKDnwDR
         LS91XhKxhJRQu+6XYQ8caB//fYkd/yyR953UGBZjRd5nDtRMyysJ+xfyKnOwYWKLRiYv
         OdzZfpT/8GfQK4wGTeRzzjSKQoKR4uETgL5cqwerQEdB3h6WOku7pthYZtYidDPcIlLD
         sh4w==
X-Gm-Message-State: AOJu0YxlqazeZWVVQxfSWOHRjlTsH4W7q28utifMrQQ8LLn2Cfc/b73l
	QR/s/1QbrrPstort3jNBFmbFapOzIbg7JWD9G3hiyvY01HhrZwYCfBedSA==
X-Gm-Gg: ASbGncs4i2V4FFOe5WFV9WPPQIzKRqPFR70BbWt2B+WDsZJKptQC2Cczv0omU8BQUGa
	w+gQaUPPm/Hp9ItZtPrz7ojgWrVKOc+GQ5/ds3JpZivcSNLI7cxuNbAsyzlqeOyxA9CRWh6Flm6
	vasqo8iSRh33tbQw0GED2ulItTVOZNO0k8iJfGhEIDcrAjHoJe1ebAM0Fe6vA0gA3gOqpd+Acvg
	JDFsbEhZfNXYZE8cW+7odF/tojjjHZpKYGvTkev9FnSsFs0A7DdQQABK7k8yMgRi8IGwZh0eDrx
	oWtgVnnfuJY3n/kxElsAJnN8Kr++pbQjePSKnbBULaOIpw==
X-Google-Smtp-Source: AGHT+IEvQXOtR3x9Vf+RX9kHMq8maIW+mLqaLWAHJyqTfn6Yxo0PvJndJ0ao8EGXIWxt2pbg1tEr5g==
X-Received: by 2002:a05:6000:2185:b0:391:21e2:ec3b with SMTP id ffacd0b85a97d-391296d3f23mr1060278f8f.3.1741240687128;
        Wed, 05 Mar 2025 21:58:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e34fasm840043f8f.75.2025.03.05.21.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 21:58:06 -0800 (PST)
Message-Id: <46c90ba12a5afd0e697a224c7951771b649b336b.1741240685.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
References: <pull.1872.git.1741240685.gitgitgadget@gmail.com>
From: "Benjamin Woodruff via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 06 Mar 2025 05:58:04 +0000
Subject: [PATCH 1/2] describe: implement --no-optional-locks
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
Cc: Benjamin Woodruff <github@benjam.info>,
    Benjamin Woodruff <benjamin.woodruff@vercel.com>

From: Benjamin Woodruff <benjamin.woodruff@vercel.com>

When used with `--dirty`, describe may update the index in the
background for similar performance reasons to `git-status`.

This commit implements the `--no-optional-locks` option for
`git describe`, which allows scripts to bypass this behavior.

Signed-off-by: Benjamin Woodruff <benjamin.woodruff@vercel.com>
---
 Documentation/git-describe.adoc | 12 ++++++++++++
 Documentation/git.adoc          |  3 ++-
 builtin/describe.c              | 12 +++++++-----
 t/t6120-describe.sh             |  8 ++++++++
 4 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-describe.adoc b/Documentation/git-describe.adoc
index 08ff715709c..97b4c656078 100644
--- a/Documentation/git-describe.adoc
+++ b/Documentation/git-describe.adoc
@@ -198,6 +198,18 @@ selected and output.  Here fewest commits different is defined as
 the number of commits which would be shown by `git log tag..input`
 will be the smallest number of commits possible.
 
+BACKGROUND REFRESH
+------------------
+
+By default, `git describe --dirty` will automatically refresh the index,
+similar to the background refresh functionality of
+linkgit:git-status[1]. Writing out the updated index is an optimization
+that isn't strictly necessary. When `describe` is run in the background,
+the lock held during the write may conflict with other simultaneous
+processes, causing them to fail. Scripts running `describe` in the
+background should consider using `git --no-optional-locks status` (see
+linkgit:git[1] for details).
+
 BUGS
 ----
 
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 743b7b00e4d..f084b2f0f1e 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -189,7 +189,8 @@ If you just want to run git as if it was started in `<path>` then use
 
 --no-optional-locks::
 	Do not perform optional operations that require locks. This is
-	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`.
+	equivalent to setting the `GIT_OPTIONAL_LOCKS` to `0`. This
+	functionality is implemented for `git status` and `git describe`.
 
 --no-advice::
 	Disable all advice hints from being printed.
diff --git a/builtin/describe.c b/builtin/describe.c
index e2e73f3d757..d4fea55352d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -704,7 +704,6 @@ int cmd_describe(int argc,
 		} else if (dirty) {
 			struct lock_file index_lock = LOCK_INIT;
 			struct rev_info revs;
-			int fd;
 
 			setup_work_tree();
 			prepare_repo_settings(the_repository);
@@ -712,10 +711,13 @@ int cmd_describe(int argc,
 			repo_read_index(the_repository);
 			refresh_index(the_repository->index, REFRESH_QUIET|REFRESH_UNMERGED,
 				      NULL, NULL, NULL);
-			fd = repo_hold_locked_index(the_repository,
-						    &index_lock, 0);
-			if (0 <= fd)
-				repo_update_index_if_able(the_repository, &index_lock);
+			if (use_optional_locks()) {
+				int fd = repo_hold_locked_index(the_repository,
+								&index_lock, 0);
+				if (0 <= fd)
+					repo_update_index_if_able(the_repository,
+								  &index_lock);
+			}
 
 			repo_init_revisions(the_repository, &revs, prefix);
 
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 76843a61691..ae7b6901ed6 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -749,4 +749,12 @@ test_expect_success 'do not be fooled by invalid describe format ' '
 	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
 '
 
+test_expect_success '--no-optional-locks prevents index update' '
+	test_set_magic_mtime .git/index &&
+	git --no-optional-locks describe --dirty &&
+	test_is_magic_mtime .git/index &&
+	git describe --dirty &&
+	! test_is_magic_mtime .git/index
+'
+
 test_done
-- 
gitgitgadget

