Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3901CC17F
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748634; cv=none; b=NZOoiCcjF3AMB3P0NoVeSKDOTxmzc7UiM8sf7ug3rxNNN0bkIV6NtTDm0X9gMf619Lv6lMo/kFpnYuEOIJWvE98bndXrUipEqm/54Zmm32UV2ZjkhsBgt3oE7eeiTcrxMKYiOwKIoM3INlgKeOAnHWA70AEhZFVUhHQtTVIBvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748634; c=relaxed/simple;
	bh=95JcqyRm6z7AINnxbPC5Mb0uVpdiKWUwyIhA12+YOoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz/K5CpZFUj3oalwe3Y5zSKkJR3FKwCFP6KOaUimS7r1e3meiQcyQclXLMtTjU30nI/fR0vSiQs+Nmr3s4OIDynI6khzlOy99sprfbTLzIhbET8V6RWxfqCUlKUk8uEf3WsSB4EtphRH6aYj5D1Fr/zLr5mPcilGpJ1V6f1WJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EW3qpGZr; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EW3qpGZr"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so3490586a12.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730748632; x=1731353432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtLp8/PBIi1MihOMiKYRI3aZ8QZhgLLIiwih3DcAbDg=;
        b=EW3qpGZrfXmsLgvbudAheIp4XwSqyQlLrL2Mf0ui4bsjvYPwJdcaEVqEIlYLisXR37
         ASpUHrSQYs6QqRjp47yJEZulVP7l8PbK02FThxHW7QuXXt66hPBNgY/sY7pXV0Y3kt1k
         oinKRaS0P0yLIcHSV7TTocsnG8uPllIVsRnRtDi46Wu5FYpURUTKoJrq10v/83jbdB9M
         q3vH88t1MhXkmSfOqF49ll33jWCdzEm6+NkegvOeYc3K9BK5yFAJjTtu/sqlDGZQyZun
         SOsatzPijwur95aqU+EymNJHjXoK/O1YbIYFk0eFBV9WR3qS34Xm3e5wJdQTetjo/leW
         gClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730748632; x=1731353432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DtLp8/PBIi1MihOMiKYRI3aZ8QZhgLLIiwih3DcAbDg=;
        b=aQJrah22aTGkKiqMf4M4wkI21dPrqgukEqjtgwxbD0Xrav53ukCq7Lt+xywY1bzVVB
         fD7ra7uZRBOzwEjDoChvKccaC1cGbQ470SG6F4u+e8BIQTLuZze75+AYzJugnw7ZplYe
         ifwmmp42UqJb+uNcrxHS6uarJmwovy8iXmwPRCKNJ3OrIbKtBxM2BdMjaSfTFVkIuGS9
         ACtfrRoHaX8By1qPxlfGj5ijNp7BeVmIZkGln1FIrpnltyJtwdqExkUSr7er+DafcQLB
         AVZYwZQMo8nom7DxpoadaDD5tFk2L6LmJZavQfAuLX6v7NPBSY2Zj6agiYubneMgQASq
         Dt8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJIDiLf13ZEo4zV1rNAUQne/EyhY4JMC5UxFBqmU8Tjj+7qIZUGcoDd1HubetGK1WYWqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzti4nXXVdSjeWKNojEadITxVB4bCDksIUi8zqfvTzSzNxVOuOg
	0PH+PDzrIAp/60zdPwPHQzAmtvs6FsqpnRhVNyFQkl7m/7vO40ig
X-Google-Smtp-Source: AGHT+IG1GdRWhRXWKFF2Qc4DYSW2LoQXygLVMGr/HzcPEr4K0Fery2uK82UT37SHfv/7pqm99bHhwA==
X-Received: by 2002:a05:6a20:a121:b0:1db:e8c8:3e1a with SMTP id adf61e73a8af0-1dbe8c84fccmr2568219637.41.1730748631733;
        Mon, 04 Nov 2024 11:30:31 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:8017:2f6f:26a1:2e1:5d4c:875])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a8b3fsm7570018a12.28.2024.11.04.11.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:30:31 -0800 (PST)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	me@ttaylorr.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v5 1/2] show-index: fix uninitialized hash function
Date: Tue,  5 Nov 2024 00:59:57 +0530
Message-ID: <20241104192958.64310-2-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.47.0.107.g34b6ce9b30
In-Reply-To: <20241104192958.64310-1-abhijeet.nkt@gmail.com>
References: <xmqq1pzuylm6.fsf@gitster.g>
 <20241104192958.64310-1-abhijeet.nkt@gmail.com>
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
their own default when this is not present.

As stated in the docs, show-index should use SHA1 as the default hash
algorithm when run outside a repository. Make sure this promise is
met by falling back to SHA1 when the_hash_algo is not present (i.e.
when the command is run outside a repository). Also add a test that
verifies this behavior.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/show-index.c   | 9 +++++++++
 t/t5300-pack-object.sh | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index f164c01bbe..b5e337869d 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -38,6 +38,15 @@ int cmd_show_index(int argc,
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	/*
+	 * Fallback to SHA1 if we are running outside of a repository.
+	 *
+	 * TODO: Figure out and implement a way to detect the hash algorithm in use by the
+	 *       the index file passed in and use that instead.
+	 */
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
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

