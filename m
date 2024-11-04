Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4B01CC17F
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730748637; cv=none; b=pASoUhCC3O6hzWXV3adht+fl+efSQ69rWKOzuLPMVfNRU5zPD/UKZDOL8bVe9C03gBGmsauKT6ncCXsV7bO5eznl5Ci0ubEj2MOtz/eJyp3L6o7Wf5md0XiUBsbsM6/fuCwbLXkGQU4c3ArjaZ3A1Vv+oPxMu/m7XKMMOWxo9h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730748637; c=relaxed/simple;
	bh=22+mzHtuYhjCkUiFDy3nlxW5qBClR+FUa7VXEdevEtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KpcXtpXPCFQvxmQ3FWVMfKczYcufun7tklc627saoVCFYp6JOAA5JfsWTOmV0mRa7DfoOQOZsfXkuadUWIIU8McjtByN6ExdBsRm+pLyhJVvaQocf7KfYMmibTKQ5d/yaEhJj+3APHymEZ9Hwre72mDbkkbCa289jRm7oBtC3LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsmMCW+r; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsmMCW+r"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7203c431f93so3933188b3a.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 11:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730748635; x=1731353435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68JkCidPpTHQiUDC2+fSjRZ9TNeKt28M95tCg4AZyAQ=;
        b=bsmMCW+rzMaFxXrvqwC3x1y+mdRN1lvMhwaHpxmElo1QDox+loySM9C9CBgcdUxhOS
         Ab1wD6Wxhqz/zIyBY1lRZFWvrgE5S7Pov314VPU92zOG9bfnBCqQML2PO+XzjTKknzhh
         9NR0hLBqsjJAhkQIrECKRDyy4qRgNYmZ3lXd/7OJF0S+mMp8YmCauSY1tOUSrxu0z/Br
         YghDTa4Dv4Ejj9JPW8m/8tYY8zSto3oD9hRxtk7AGh+timZbhZc7UQWEYixWzIlu+FtO
         Bv/TCwOTpOSDQY80FtuSHsrWP9V8x36Ww3vYwf43MPaBc5uBsOyKVrXoU/R38FiWisxn
         kHrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730748635; x=1731353435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68JkCidPpTHQiUDC2+fSjRZ9TNeKt28M95tCg4AZyAQ=;
        b=Q13ukyviFOf5nk1bApU2qwdDVhRWQz++m+gpoQsiL2rIIAbk/oErl6CHWVhwgOEfdW
         qYMXtfkOE6vlRzXS79eYz7+dmqvu/Tr3KwcWlDnN5Qou6ZNZr86DfWP8mpMt0M1l4X25
         4GhIvA+DttQApmXUinqartJ9PGdRZ/O3Ar/0NajJx1R3jkgt4dQIdrkrwiPrVU9cs1os
         edfHVLyaX1+zrQs2yycqyCl6bEGHqc4yQXuhN385cmeUM0sL+hzB3dVSmCgw/qAibt7m
         gj4VAed00Td2Z8w95q1dgucSXILHM54JUJk7WRgUYxJ+J4xi7dDKiNMNVHysldrneJiW
         X3ow==
X-Forwarded-Encrypted: i=1; AJvYcCVfRrcBCPiWL0Q3RkfqGR2HvaAVTUHDWjP31s/N+vpr3W9Zc9kBgMmIx7wWZwWD1/f/rU0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Ciod18RtIvHRVpuuBaRd3axvius1puhZD6O0j7plkeqs1iYb
	hPOQeDoW98qdwWqTWG7NDrNxjmLh2eP3lNxTkNuTHbdUfc6m7VHllOCm1g==
X-Google-Smtp-Source: AGHT+IFeWW6M75jwpwaEe/js+YKkNVcFuuGpC6tRYVZ/XI828HxEuQsuM/YGpeYJnPjOxvHaE7SucQ==
X-Received: by 2002:a05:6a21:2715:b0:1d9:3456:b702 with SMTP id adf61e73a8af0-1db91d892f7mr18841971637.17.1730748635194;
        Mon, 04 Nov 2024 11:30:35 -0800 (PST)
Received: from localhost.localdomain ([2409:40c2:8017:2f6f:26a1:2e1:5d4c:875])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452a8b3fsm7570018a12.28.2024.11.04.11.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 11:30:34 -0800 (PST)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: gitster@pobox.com
Cc: abhijeet.nkt@gmail.com,
	git@vger.kernel.org,
	me@ttaylorr.com,
	ps@pks.im,
	sandals@crustytoothpaste.net
Subject: [PATCH v5 2/2] t5300: add test for 'show-index --object-format'
Date: Tue,  5 Nov 2024 00:59:58 +0530
Message-ID: <20241104192958.64310-3-abhijeet.nkt@gmail.com>
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

In 88a09a557c (builtin/show-index: provide options to determine hash
algo), the flag --object-format was added to show-index builtin as a way
to provide a hash algorithm explicitly. However, we do not have tests in
place for that functionality. Add them.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 t/t5300-pack-object.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 51fed26cc4..301d5f1b61 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -527,6 +527,28 @@ test_expect_success SHA1 'show-index works OK outside a repository' '
 	nongit git show-index <foo.idx
 '
 
+for hash in sha1 sha256
+do
+	test_expect_success 'setup: show-index works OK outside a repository with hash algo passed in via --object-format' '
+		git init explicit-hash-$hash --object-format=$hash &&
+		test_commit -C explicit-hash-$hash one &&
+
+		cat >in <<-EOF &&
+		$(git -C explicit-hash-$hash rev-parse one)
+		EOF
+
+		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in
+	'
+
+	test_expect_success 'show-index works OK outside a repository with hash algo passed in via --object-format' '
+		idx=$(echo explicit-hash-$hash/explicit-hash-$hash*.idx) &&
+		nongit git show-index --object-format=$hash <"$idx" >actual &&
+		test_line_count = 1 actual &&
+
+		rm -rf explicit-hash-$hash
+	'
+done
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
 	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
-- 
2.47.0.107.g34b6ce9b30

