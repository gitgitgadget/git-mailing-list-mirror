Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD382F39D7
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756193817; cv=none; b=LF9PhD2BPauMSDnirbYn68xJAvMsDEnmlbtqTxz0vIYYR8XhEU8fsN7dF4pFUJzaQQJJRDSps/Ekh3oOyT2R1NlXLF3oNN/pZ5DBb4V5kUw0rqKvMWvBWHL4+aAPwAG4W8pPeT3of/M+W2y30t2X9tpyy/zmVknTQ//2pyx14Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756193817; c=relaxed/simple;
	bh=BSlTzCdjFQBhk/JRccpJmtE8BFjz9TXaEtaXtVAvRZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gi1bSfDS9G0zTpnXdRalS8dQgbE1puu5wrHIDltsoRaqBgI14tvRnCXHIWLBaaztX1dh8n1g1+bwGZUpjr3W8TzeFCAwCW83HiMYXEFkK0QHJcAG9mRxLOUElbzcvwtsN7t3ZVkwrH8JSEDZp57dbmREwsq55nvrEIxu35Q6kpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McJ5vIb5; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McJ5vIb5"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-770d7dafacdso2253040b3a.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 00:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756193815; x=1756798615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebsfKpd+g93INpNC4EHIQQlmci2lxcvxCuLOdlUPB+o=;
        b=McJ5vIb55WVNyasgOCDkXtTv1ILV9pYXz2xJEJgwl2NkdGj3qbqDDq1T6hL/IWMd9v
         pHU4UoAEh5bgUw3l8BfQyTmPpDqIKejppTJ7s3yiROMF5eLTvYM+CV8QzaY8JhUJzhGJ
         nuqhrZqdgZQSqyMFP8dqAewfmAgwVAGaFUyOiiM86+40gvt6YL5ni6K4RhPp8K7Ys+X4
         OrsCXtvLeoPpRzfsis+qfbNO8Gy+O5+UuUHF2l1NgJZQq3LizOqdhE9EgZ2KPRPLBjuU
         AQo0Otj8mPv4uOa5VhccREmKDjP2ahzCY/N14Oag4jTK+GIZA59f1fu3tiZ9ad4Extjk
         uS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756193815; x=1756798615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebsfKpd+g93INpNC4EHIQQlmci2lxcvxCuLOdlUPB+o=;
        b=BUHQRP6UifAvhKt44qB3PVqZaujMsQB0BHtkXafTXT+Q9lcN8xmm8bPZUy+3fiFabR
         map92YZRHUjz7zZkZzgT/zly+DLlSaDehi9hQ93BX2/uEcfG+MQk+4Vy3bCHDNWMABj/
         6mY7QgUh1WpcizuKF75OBgXZpeXIkNCPdVxD8qAuVLqbDfjiuldEmiTnLieHXWUFFS3F
         4kH8yPAe/1kYgIAGnwIrnkbQ731KiTOOeKLRNb+YYVp2zpiu/ka73pqGT+FNGE9zDTFc
         /elqCOFp95iAtGnTsle+eq9YPtT3GMwlhyD8O9VQeh2RotInySterd9rUKf1bNCi9I35
         VZhg==
X-Gm-Message-State: AOJu0Yx0UW9rURFiEwABg/cKyNB7CWydEYwmz9L3CHZodXQ/0X84ATmy
	k3UMMdX9b98xXfNRk0g4BupRVugFqPzshvgLBm+etmsJ6rISQJ6bzbwHkReHLQ==
X-Gm-Gg: ASbGnctUn9Iyf2Tc307d9rqAjzfhWYUTlNsIfYNAQ11mA8isCq2aEKV+IrqzWDubPIM
	8lF55bpAO9vwAVJaFLlLAmYGCPR3yo3tjnYr/rQGiL7b7+OwOk3pKasCo03UrVi7eLRTKAO9rsB
	CyAj7wB5/iEeVYgVTdUwb8AgTcE8W/DP5jEcqA4S2uoNx+2QbjRPkY7GevrvW7nRtgHfInaeNsd
	pWfSMo8L+FOcJdQZDksh7oA2EGil7DQQ4WkQ17ACsgRrZ04UXqqIeOon064riaHhUgYekjadn0Q
	Hj46Vp5jMXxSZeJleAq1fvwHikpJQnduuGyLXpON+5Meo0aLlgI9sVEuPRcJxis9pyfsOrblxkg
	55t6COBGFmSZwXXp9z3s=
X-Google-Smtp-Source: AGHT+IHyWj5bX+3MYMfaFLq7uGqmGyxhij3O1JQV3C3cYDRoNQNnEi5zxScQC/N30Xd+PGODIYm26Q==
X-Received: by 2002:a05:6a00:14c4:b0:771:fbb0:b1ce with SMTP id d2e1a72fcca58-771fbb0b3dfmr864311b3a.25.1756193814951;
        Tue, 26 Aug 2025 00:36:54 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e814cbe1sm4046216b3a.27.2025.08.26.00.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 00:36:54 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][PATCH 2/5] doc: factor out common option
Date: Tue, 26 Aug 2025 13:06:42 +0530
Message-Id: <20250826073645.1074397-3-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826073645.1074397-1-meetsoni3017@gmail.com>
References: <20250826073645.1074397-1-meetsoni3017@gmail.com>
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

This change is a pure refactoring and results in no change to the
final rendered documentation for `pack-refs`.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-pack-refs.adoc     | 54 +---------------------------
 Documentation/pack-refs-options.adoc | 52 +++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 53 deletions(-)
 create mode 100644 Documentation/pack-refs-options.adoc

diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
index 42b90051e6..dac63e5e12 100644
--- a/Documentation/git-pack-refs.adoc
+++ b/Documentation/git-pack-refs.adoc
@@ -45,59 +45,7 @@ unpacked.
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
-
+include::pack-refs-options.adoc[]
 
 BUGS
 ----
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

