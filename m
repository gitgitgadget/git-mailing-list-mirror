Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687E1CB51D
	for <git@vger.kernel.org>; Fri,  1 Nov 2024 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730482096; cv=none; b=g2iPkeMGJE0fgVGy5MSURiUBUzAxLz6FHDxm6+kCi5ux5YSXKRup/tAHSAR8wgT0CCCy7FRJqZFvFX18skI167klAUZ56HfIDM1rE3oaRf1VXJFWSaLOgvDDvqYKj+nmq557VjgmA1p+6DEr9E4+eUb33RIyF8bIfZJ6Gr7IRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730482096; c=relaxed/simple;
	bh=yTH2QAecezbpMWjYlytI0kU39dlDfm/yGF8UOD3g2B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2HvHTeaoG1UvkU79izqdkif5wsRYtim++Cgp8Bp6SHns7ntFvVhCsWYfz76P/4NQwK783qv11pTCI4szbhSyqUy4puX5f18HVa2s/tsfWWcAg2RnMkInFHPKKIkq+llO0wzbn+bxJb6qRSQzqbLkwMpQirjTwO/H9uCqf4pZc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLJTY/m6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLJTY/m6"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so1723608b3a.2
        for <git@vger.kernel.org>; Fri, 01 Nov 2024 10:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730482093; x=1731086893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YM7ZnNcCGOoF/9r0YoWWhOcqnzK5IFv/WI8M56iIDIU=;
        b=mLJTY/m6gxB7BqoZoVRxmb2/PJxqFc5gxt9nJ4Kmpf8kOEjBvl4dlhU57z1VCb75ne
         09zKu4Zcc5iXuDg1LTdaAoWGcgvGun2ohV6RoPFwax9bmJ7/PqVZP1jtG8QAUggfaMAl
         VWtLY3J+KsZlokjlGFs3L5fqlgl5WVC7odPR9V64y7yZ2edw9hvfBVlsfs6GGytPFbwT
         +F1MYrY243lxI5AwBFjBn5OosdbMEZVxIAEYB/K10Jv09PctyZWs2uO0KfMlYEzmIyCh
         RbLkHDdP7Cw6BEyN/qyEFomDTIJJZAbjlxmmRekaqnCxQi68wn8SeUXRMvpjhHxn0utU
         TYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730482093; x=1731086893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YM7ZnNcCGOoF/9r0YoWWhOcqnzK5IFv/WI8M56iIDIU=;
        b=GM+KfyJ7srJiMcWdgtDpQrmcVdwjzYF5JqN6kjSH5XgDHMJ66iXBM/p7zBgTBONmKl
         lqp/LlBUeDZxieptPISnY3d08OaC0Cf+93rJC+gfMghvk2wJLCO5YXW1oZM6+GOlMnRO
         w/Ygcq+T7ruokPOREUR1AGNfyomKF4j8VhNre6WbeKPnjHmA/MCn5PcY5K0FAONmxUSN
         b7YXREmomRn831niwi7jxfIVtWwsNH4h6WuXXHUB+q8fL4WgtnwelHYxfA7k3u8dJGlX
         df/b2pMazySW8Tw1rUkkznOyvHnFmk/KCPkorOiF3mQNXTFrazPiIm57Pl6yZviLjpxd
         LDMg==
X-Forwarded-Encrypted: i=1; AJvYcCWV8y1lxKvHyvMLXsQz+2nt++90RAwMt8SDqshibDwhLsrseg62rcQ1ObvO5lKK1aSab+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTApgsr7NBimD+9JILWr+G3QOtaBgic69VAfDRFaNtRVFPW7hC
	YJa33Scpbypa8KpypzpgsCEt0O5IV5gjqYRtoIqR2Gac7TElo/vH
X-Google-Smtp-Source: AGHT+IEkK0RbPEwACvmKUOUDj0zTF13fcAdghdwTkK8k3UMucSW1DUrgMSMsJ62KlNDlA4fbRG+CVQ==
X-Received: by 2002:a05:6a21:1193:b0:1d8:d6b6:94c6 with SMTP id adf61e73a8af0-1d9a83ab108mr31282599637.2.1730482092998;
        Fri, 01 Nov 2024 10:28:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:8047:df83:f910:9147:a415:d1c7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e920197e7bsm4971376a91.0.2024.11.01.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:28:12 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: me@ttaylorr.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v4] show-index: fix uninitialized hash function
Date: Fri,  1 Nov 2024 22:58:00 +0530
Message-ID: <20241101172800.21997-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <Zx/NE/9HFNr9V2H7@nand.local>
References: <Zx/NE/9HFNr9V2H7@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In c8aed5e8da (repository: stop setting SHA1 as the default object
hash), we got rid of the default hash algorithm for the_repository.
Due to this change, it is now the responsibility of the callers to set
thier own default when this is not present.

As stated in the docs, show-index should use SHA1 as the default hash
algorithm when ran outsize of a repository. Make sure this promise is
met by falling back to SHA1 when the_hash_algo is not present (i.e.
when the command is ran outside of a repository). Also add a test that
verifies this behaviour.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/show-index.c   | 6 ++++++
 rm                     | 3 +++
 t/t5300-pack-object.sh | 4 ++++
 3 files changed, 13 insertions(+)
 create mode 100755 rm

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbe..645c2548fb 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -38,6 +38,12 @@ int cmd_show_index(int argc,
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	// Fallback to SHA1 if we are running outside of a repository.
+	// TODO: Figure out and implement a way to detect the hash algorithm in use by the
+	//       the index file passed in and use that instead.
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/rm b/rm
new file mode 100755
index 0000000000..2237506bf2
--- /dev/null
+++ b/rm
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+echo rm $@
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 3b9dae331a..51fed26cc4 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success SHA1 'show-index works OK outside a repository' '
+	nongit git show-index <foo.idx
+'
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
 	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
-- 
2.47.0.107.g34b6ce9b30

