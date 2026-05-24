Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9FB395DB8
	for <git@vger.kernel.org>; Sun, 24 May 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779644419; cv=none; b=SPvgTccZjtLMXg9RO3e07HFvug4tzULRbsZOBkQMW7ztlfpvBoxnQL0L4a+RU0LQixE9sD12U3Xuyee3Du06FWPu/i4G+rwqb9IpLRyvb4oOcCoqhncSZr2e3Gx8wvJRFBaAbTMuZpfmhq3MZOSquw7DhrsXxom0NXXvaGohwKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779644419; c=relaxed/simple;
	bh=WgCb9TqGEaq1v1mdPxPZE5YgcOr+JEbj2KrDzeP2QKQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PvWS+19tGc25gYWutSTK1qX5KyVU/z+ZT3wf8rPMRnyV7yalZozbGBVDliQgR7EjhJ0Qk+VDTwtqWCS7GXRm5YczbryEbF8FGdZft9OhA9nTbzH+G6VjmVt6VEl4cYrRjp6MNIkp95max9RMP/sxKp9EUF3WkgCllg+V5wQwLHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHAXpFiV; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHAXpFiV"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-516de78c4dcso18417711cf.2
        for <git@vger.kernel.org>; Sun, 24 May 2026 10:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779644417; x=1780249217; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Uo+S3PAQ/dEQGUjRC3llZg34KLay6rQRqrj8FD8aU=;
        b=dHAXpFiVy7A+bft9/ti3WcwoSTrOflIkY2kZMhMIuOvZPmLMOF6KzhuurOtApO+kWL
         KZVFqrbaFTvC8fWc8zdQubY4i0SZl9VILB77Mwsn5NF0wI8Kjkv4lTuoz1tmzSuMbim7
         IRL516+a/qsSgNcmFBE1kBT2GvisQJbybrZAAnCO0tfLfm0ECtpnN38aH5X63i0aLxB5
         6XIuzRqHN6E28vpdgdBVYZeI777uG+4vqFdUgAVLcRYxvjlkHgh66it4JlzVGKYx+0v3
         swPQBLkpENPVgI6g5RpO2vlG7VobOMnjjgqIgSY4gFMtDsK1YjHoqwA8iYgP3U2lQtbV
         59rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779644417; x=1780249217;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g0Uo+S3PAQ/dEQGUjRC3llZg34KLay6rQRqrj8FD8aU=;
        b=JWxsg6BnfjB0bnj72EbdmntQbu0oD4tcDvbyqoJSji3X8v8PWjad4uyBFDiTAmXlrw
         yVHDT+J7Nq68dqRxXVc6xrqr/emjBJNw0VXP0yh4GzHUvzyXcCedZYAl0bebqxLdJLlj
         xgS04TIex6sEavhjZw5ymzVaSp2rj9NnOSLSko0kaYrVzczW1sdJLtO/9gw5qhA2J7aj
         hZzMDLm4MMxG3Mz3KrSdSLWwv2ezqpKh0Z10XIo5DDqOZXYEHhJ1unbkJW8s/ZcibjHP
         Vw/9aKVsKYxm23F9abBToEY8Y2QgrwmItPAfj/0/Nqf93VdcGZIWcL+1cA9sy54wJmC5
         7zUw==
X-Gm-Message-State: AOJu0YzcUXtCyCpqGQYVwIe9kzoCWE8JWb+wfSUZDAEJeUzBHgIA+7Cb
	G7oiL5LVeWJRv4VOzZF1GIliJQl771nGUmFdElCa1qQP2uzPW3iB/yqZhQjssQ==
X-Gm-Gg: Acq92OEueewIHf+za4aHm1cxZiVgPrIqe3o4LGhGhQ+EqSOYUjjtJQUo1LdTgNuMkp6
	c7hwzw8Bv5aNI0kAGWpQRoLGZz8cxWdhvtokNM+cc8DvvVYBLHA2zpmMfvv4wuoYpjdFMAY4Q15
	MYqNdYkhPsFX3xMPtTZBpLy1j9XKNdiLJazkjuuc+8DqM4i0JGqpTtWUiD7VnJbCKiJjqYQJLda
	3uZUBwD3FCnp8fJIWhydiiEK2baqxhWUFukqIL7QRDdO5mZqhkP5m1osu+YNGCHdkA8k1iU2bBY
	u4eOdJcYDXblo75nrzziK9mbI2KWeApqtRSMvITUJz3gOwNu5yaHeqRNl/JJ2u/uSg6nSM3RkUU
	favw357DFNPFOnNtVJkHl5eYdZ/09FZXRD8+mHbdDNJwPFUmEitYD51mxI2iH0YF2HLoKSTLJpI
	04AQVSsTpkk73B7rj8HDBv5elF
X-Received: by 2002:a05:622a:684c:10b0:50b:4e4e:1a20 with SMTP id d75a77b69052e-516d440e798mr35822141cf.59.1779644417185;
        Sun, 24 May 2026 10:40:17 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.78.65])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516d8b2590fsm73102511cf.10.2026.05.24.10.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 10:40:16 -0700 (PDT)
Message-Id: <7c56d038307d54929d9eaa9b8cb3cf26af181702.1779644412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
References: <pull.2121.git.1779644412.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 24 May 2026 17:40:11 +0000
Subject: [PATCH 1/2] t1092: test 'git restore' with sparse index
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
Cc: gitster@pobox.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

A user reported that 'git restore --staged .' causes the sparse index to
expand. This is somewhat natural because the '.' pathspec means 'check
every path'. However, the restore will not update paths marked with the
SKIP_WORKTREE bit, so we shouldn't need to process such entries.

For now, establish the current behavior, including the sparse index
expansion, in the t1092 test case as a baseline.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index d98cb4ac11..d69434e7ab 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2573,4 +2573,54 @@ test_expect_success 'sparse-index is not expanded: merge-ours' '
 	ensure_not_expanded merge -s ours merge-right
 '
 
+test_expect_success 'restore --staged with sparse definition' '
+	init_repos &&
+
+	# Stage changes within the sparse definition
+	test_all_match git checkout -b restore-staged-1 base &&
+	test_all_match git reset --soft update-deep &&
+	test_all_match git restore --staged . &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git diff --cached
+'
+
+test_expect_success 'restore --staged with outside sparse definition' '
+	init_repos &&
+
+	# Stage changes that include paths outside the sparse definition.
+	# Although the working tree differs between full and sparse checkouts
+	# after restore, the state of the index should be the same.
+	test_all_match git checkout -b restore-staged-2 base &&
+	test_all_match git reset --soft update-folder1 &&
+	test_sparse_match git restore --staged . &&
+	git -C full-checkout restore --staged . &&
+	test_all_match git ls-files -s -- folder1 &&
+	test_all_match git diff --cached -- folder1
+'
+
+test_expect_success 'restore --staged with wildcards' '
+	init_repos &&
+
+	test_all_match git checkout -b restore-staged-3 base &&
+	test_all_match git reset --soft update-deep &&
+	test_all_match git restore --staged "deep/*" &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git diff --cached
+'
+
+test_expect_success 'sparse-index is expanded: restore --staged' '
+	init_repos &&
+
+	git -C sparse-index checkout -b restore-staged-exp base &&
+	git -C sparse-index reset --soft update-folder1 &&
+	ensure_expanded restore --staged .
+'
+
+test_expect_success 'sparse-index is expanded: restore --source --staged' '
+	init_repos &&
+
+	git -C sparse-index checkout -b restore-source-staged base &&
+	ensure_expanded restore --source update-folder1 --staged .
+'
+
 test_done
-- 
gitgitgadget

