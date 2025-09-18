Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD628312D
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 05:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758174450; cv=none; b=g+eRN+3/jyz9qZdIMu4TBNK6YbRoPx+xh6MAh1u/aAzEjzDZPAyABXI+lVzd5QTpUVyAI5zjMz+TCYdYxX86bfI+s5u3NNRZVBjCzIpM6XzbslnXxB9rlUHo2EW5kvLEEin5ZdgXQqxZxeBa5NKDCZLPf7NQFhWBvSINJXd+TgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758174450; c=relaxed/simple;
	bh=hGWZxsKzkmtmH30N8+0hZ/G8mstFgYq7npIutgHHw34=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3VKRAeBZtXXVb7R/+FO6DyQSDYfnsX2uVJZaN8AhAblIit4xTP0yI9cUTvHswSa+xzwrYG7pVI1g/QPbDl3n2G8q9y75850qpCmBFXqzHxMoVlSu05tqMzfkNhqP0i84GRSAEZGAsfdt4v7dMZqZInrkWykX09IgOLdtBG/dng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlQeyr9L; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlQeyr9L"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-32e34f4735eso504227a91.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 22:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758174447; x=1758779247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdzzTYsiGPhndDTqj3xVX++QuVdtr8GdDaWjj2gX2nU=;
        b=WlQeyr9Ly36IxlYe2wSTzpyKt3YtUQvDMpwRepu8oFVvbipvuZunJaQQIeAT3sX8IT
         ty3wdwj+vDpmj1IdJ+Y2IuLSTU2CuXgQg4xPX1ZDJsg/D1WRmzlXRDofSxUehep/4kGX
         uGR53KtYt532EIusq7nM8tDH3Bjaoxn5tX8EJSWGSnUagTkdrDwDpjtyGY3RhY9yU4FJ
         IpBj9vqszxct5nxqd23KljZBh2P0lU2Gu5szTnq6r/wY9qkU5y/GF+wJLEsBy37ac9nF
         bMiZCR4NfvvMZgLbRwdeRdwqXKoh60oY8riWuY9zgnxh6b/+jZMye0s8RYzW7Cap/E3q
         59XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758174447; x=1758779247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdzzTYsiGPhndDTqj3xVX++QuVdtr8GdDaWjj2gX2nU=;
        b=sNQQFNoL38N1nmp02k7Pzce0ATxcooJnyytNao5lnhpvN99roheJFK/fGK/QPzL5aG
         4YZ1KNMV2FWLIkSGTogMyrIseFIqm4fvZdu6ObPELC8R74owHCVB5B81HNM1RyZXjDm1
         iSUT52xnaevNgP70XHwEG/WUqMNzNyjHEmkRwRpDxmLcjqd4OMhb7SX/6AavcY74qEl7
         BtyqdtcjtaJ1DRV0gFXYN7e3To1RnAKHVUByI27kMG0qGgP3sle09E0UpIyTWAw24Mlh
         oMbO7d9cgNlP+nXXBufhiVNw0tkx/Kp6lMC1FlG1lFfoll6utU8hrhoxQuzLQfMUl4nM
         TvIw==
X-Gm-Message-State: AOJu0Yxlw1vkAAAERPOchQM7/7RGQhHcNaYwcw8HTAGcAU9sDk2IPu+D
	C+nb+RyqMAC8CcwcR9CtqoJPs63gsvvW+/Z8JZjtGO3jXHLS1ujh3AiIvXfRng==
X-Gm-Gg: ASbGncv3lyCk0pL+kzSPslF/ozPKfIBed3qfzamO6zZySH5EAVHBuxYCaPk6VFXegd0
	zZFY7zTyecs9A2t1BNaKG9es7GQqlWMhkNTlB7IW2wMqr9pe3OaLjajU4KuAN5WyQPfPM4nJ7ej
	HohgbZMWb5iwA8jpmU/nPeGW37JodyhtNm6N0qd9ApdVWVV41qHzpXhACd4QOZ6vm6QVK5tkB2D
	dTbbUEHD/1kkTJK6pxE+nsKv0lsRX24dyqa1r5kkOl7No+1GN1/PJR6evz/7gxDc42GK9vPycrY
	vZXuBbIwgd+AYbiuS56TT/6wfuEFsm14MYfcq64OGb9F4rDAmJLSfcXY/eXQ+hgl+xpxmTBYno1
	veIOkDvRECNMuVbvNcfjbsa3DCurI43c65uFuuA==
X-Google-Smtp-Source: AGHT+IF67UNDf/sQkw9XPrHiKO4HxmotnvbWG70UluF7HtW2mh/li/1cXIBlGXmY5a1xH4WyZj2+KQ==
X-Received: by 2002:a17:902:d582:b0:25c:9688:bdca with SMTP id d9443c01a7336-26813bf1f32mr59592325ad.50.1758174447379;
        Wed, 17 Sep 2025 22:47:27 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm13621535ad.86.2025.09.17.22.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:47:26 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][GSoC][PATCH v3 6/9] doc: pack-refs: factor out common options
Date: Thu, 18 Sep 2025 11:17:01 +0530
Message-Id: <20250918054704.544254-7-meetsoni3017@gmail.com>
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

In preparation for adding documentation for `git refs optimize`, factor
out the common options from the `git-pack-refs` man page into a
shareable file `pack-refs-options.adoc` and update `git-pack-refs.adoc`
to use an `include::` macro.

This change is a pure refactoring and results in no change to the final
rendered documentation for `pack-refs`.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-pack-refs.adoc     | 53 +---------------------------
 Documentation/pack-refs-options.adoc | 52 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index 42b90051e6..fde9f2f294 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -45,58 +45,7 @@ unpacked.
 OPTIONS
 -------
 
---all::
-
-The command by default packs all tags and refs that are already
-packed, and leaves other refs
-alone.  This is because branches are expected to be actively
-developed and packing their tips does not help performance.
-This option causes all refs to be packed as well, with the exception
-of hidden refs, broken refs, and symbolic refs. Useful for a repository
-with many branches of historical interests.
-
---no-prune::
-
-The command usually removes loose refs under `$GIT_DIR/refs`
-hierarchy after packing them.  This option tells it not to.
-
---auto::
-
-Pack refs as needed depending on the current state of the ref database. The
-behavior depends on the ref format used by the repository and may change in the
-future.
-+
-	- "files": Loose references are packed into the `packed-refs` file
-	  based on the ratio of loose references to the size of the
-	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
-	  references need to exist before we repack.
-+
-	- "reftable": Tables are compacted such that they form a geometric
-	  sequence. For two tables N and N+1, where N+1 is newer, this
-	  maintains the property that N is at least twice as big as N+1. Only
-	  tables that violate this property are compacted.
-
---include <pattern>::
-
-Pack refs based on a `glob(7)` pattern. Repetitions of this option
-accumulate inclusion patterns. If a ref is both included in `--include` and
-`--exclude`, `--exclude` takes precedence. Using `--include` will preclude all
-tags from being included by default. Symbolic refs and broken refs will never
-be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
-and reset the list of patterns.
-
---exclude <pattern>::
-
-Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
-accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
-patterns. If a ref is already packed, including it with `--exclude` will not
-unpack it.
-+
-When used with `--all`, pack only loose refs which do not match any of
-the provided `--exclude` patterns.
-+
-When used with `--include`, refs provided to `--include`, minus refs that are
-provided to `--exclude` will be packed.
+include::pack-refs-options.adoc[]
 
 
 BUGS
diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
new file mode 100644
index 0000000000..0b11282941
--- /dev/null
+++ b/Documentation/pack-refs-options.adoc
@@ -0,0 +1,52 @@
+--all::
+
+The command by default packs all tags and refs that are already
+packed, and leaves other refs
+alone.  This is because branches are expected to be actively
+developed and packing their tips does not help performance.
+This option causes all refs to be packed as well, with the exception
+of hidden refs, broken refs, and symbolic refs. Useful for a repository
+with many branches of historical interests.
+
+--no-prune::
+
+The command usually removes loose refs under `$GIT_DIR/refs`
+hierarchy after packing them.  This option tells it not to.
+
+--auto::
+
+Pack refs as needed depending on the current state of the ref database. The
+behavior depends on the ref format used by the repository and may change in the
+future.
++
+	- "files": Loose references are packed into the `packed-refs` file
+	  based on the ratio of loose references to the size of the
+	  `packed-refs` file. The bigger the `packed-refs` file, the more loose
+	  references need to exist before we repack.
++
+	- "reftable": Tables are compacted such that they form a geometric
+	  sequence. For two tables N and N+1, where N+1 is newer, this
+	  maintains the property that N is at least twice as big as N+1. Only
+	  tables that violate this property are compacted.
+
+--include <pattern>::
+
+Pack refs based on a `glob(7)` pattern. Repetitions of this option
+accumulate inclusion patterns. If a ref is both included in `--include` and
+`--exclude`, `--exclude` takes precedence. Using `--include` will preclude all
+tags from being included by default. Symbolic refs and broken refs will never
+be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
+and reset the list of patterns.
+
+--exclude <pattern>::
+
+Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
+accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
+patterns. If a ref is already packed, including it with `--exclude` will not
+unpack it.
++
+When used with `--all`, pack only loose refs which do not match any of
+the provided `--exclude` patterns.
++
+When used with `--include`, refs provided to `--include`, minus refs that are
+provided to `--exclude` will be packed.
-- 
2.34.1

