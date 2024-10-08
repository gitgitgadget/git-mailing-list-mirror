Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2151DFE24
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396738; cv=none; b=UHBlBo4nwweWSOYlW4/Ix3ght7kdJOn8CookbbSoiUfYDgcRjeR359nUmoKbrzvHnQH5s6hjYinDF3dERMNYKkPGqhXwzXds7K+WzEXPCJwH/SE7gjq5hb3yxZMJhvG1z324/TOdCvCjedhLCTYzVFAs1njLbt7tgbQEMKHfUp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396738; c=relaxed/simple;
	bh=4C2EoXD0qRgp37ejpHQAhG965/uTFbfCXWNMgiUmul0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QqTwFvB0pLqvE2g1FIPlVdeM3ZM6Y4H3aNEiDOIxVr1UM+Ec0TG7lBwLnbifO9cQ2ETDuVgXZ6Ub0qDUrlHTAxdchkl1Ht3KFPfCgKOz8th1Iq+ywSd7QPTMUdokkvppPLzhrOXTwx0vbnafOfLNDvX6xnCE+P5lz/AUCed9HYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op61965R; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op61965R"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so1940086a12.1
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396735; x=1729001535; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZkXyCwyPixrfrkjod8gQkMhmIivNdVBmrqEDTvbsk4=;
        b=Op61965RQ3hKi4m3MXxESG0/aw7xB5tSB6srlx6xahPvW8zrHezH0qdgVt9ZXOV9xH
         caep90XYTSDBgMb+GfQo9hWvWGCcgGADVQkjXQyH5ku5siwgPAzuvkj2N4JiPr8xPKdE
         59O4ypwmQgUAxH9VU+d5uwxedA+U/cNArzA039ZDAj5gxIV/QyqsuRbn0s8w4JkaHORn
         NsHwMzeg9o/FqNxsrW5aEoktleOSSBmBmTy6vNG9/DVISP4AprA/JHOH3QDi5MmW0CbD
         HOHfvtbTsH14SrOX3yRlQPb6rCNQKYj9qdcry0HQ5l+OA5S1jL3tA8NVgCxXmKq0yufu
         4GSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396735; x=1729001535;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZkXyCwyPixrfrkjod8gQkMhmIivNdVBmrqEDTvbsk4=;
        b=Dduqyo9H7OlHGaO0odkTtsuCm7i8Q7ulPD9/0n5hvEwEpijUfa35VGFsFfSWi0oE6R
         9wYzBJlOZEa1xckzTX55/L99pLyttgfVbmQChi3+tplFjSMl1yjYWLm3BL0erk7mlb5C
         XeFgXV7NhgvwZKXiyBRKMFocE/E1QvaBxPC6xy8VOycon0Pn5L6yOkoOko41u2fI9ex/
         8Hoz/RFPet0vm85ng3LuHOdpg8QbjsBE7/48P86PAQ/vdg/zDtNK2twy7t3+I6bJxqnQ
         wFIXqafr/8hvE0l2WYc0UTfEavDUb/23+Zur6R9/WDdoKSZ8+l8A6yLNJ+erA25BVCIy
         0wtg==
X-Gm-Message-State: AOJu0Yxd/4Yh9WTwqIqiqa88aQhccfqB+Cbt8hirPGo61j0v4yY4mFwy
	HPXDXn7QKKVO//ddLJWza4C7OT2E/wzCuBEDP8VWy3mIq6weFBU8bKT93A==
X-Google-Smtp-Source: AGHT+IHrXeaWYERhQ0jU+mNZxO/3p66Uo5oJkUrDrTaac9nMb+l/adRC9Qm6E6s4+FBoV8orCJ0ElQ==
X-Received: by 2002:a05:6402:3207:b0:5c5:c2a7:d535 with SMTP id 4fb4d7f45d1cf-5c91aa19bf3mr400539a12.16.1728396734441;
        Tue, 08 Oct 2024 07:12:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f4e93sm4297155a12.96.2024.10.08.07.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:14 -0700 (PDT)
Message-Id: <3113ead1e0168eeec5c3be1199918b80fa845264.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:56 +0000
Subject: [PATCH 10/17] p5313: add performance tests for --path-walk
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
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change added a --path-walk option to 'git pack-objects'.
Create a performance test that demonstrates the time and space benefits
of the feature.

In order to get an appropriate comparison, we need to avoid reusing
deltas and recompute them from scratch.

Compare the creation of a thin pack representing a small push and the
creation of a relatively large non-thin pack.

Running on my copy of the Git repository results in this data:

Test                                      this tree
---------------------------------------------------------
5313.2: thin pack                         0.01(0.00+0.00)
5313.3: thin pack size                               1.1K
5313.4: thin pack with --path-walk        0.01(0.01+0.00)
5313.5: thin pack size with --path-walk              1.1K
5313.6: big pack                          2.52(6.59+0.38)
5313.7: big pack size                               14.1M
5313.8: big pack with --path-walk         4.90(5.76+0.26)
5313.9: big pack size with --path-walk              13.2M

Note that the timing is slower because there is no threading in the
--path-walk case (yet).

The cases where the --path-walk option really shines is when the default
name-hash is overwhelmed with collisions. An open source example can be
found in the microsoft/fluentui repo [1] at a certain commit [2].

[1] https://github.com/microsoft/fluentui
[2] e70848ebac1cd720875bccaa3026f4a9ed700e08

Running the tests on this repo results in the following output:

Test                                      this tree
----------------------------------------------------------
5313.2: thin pack                         0.28(0.38+0.02)
5313.3: thin pack size                               1.2M
5313.4: thin pack with --path-walk        0.08(0.06+0.01)
5313.5: thin pack size with --path-walk             18.4K
5313.6: big pack                          4.05(29.62+0.43)
5313.7: big pack size                               20.0M
5313.8: big pack with --path-walk         5.99(9.06+0.24)
5313.9: big pack size with --path-walk              16.4M

Notice in particular that in the small thin pack, the time performance
has improved from 0.28s to 0.08s and this is likely due to the improved
size of the resulting pack: 18.4K instead of 1.2M.

Finally, running this on a copy of the Linux kernel repository results
in these data points:

Test                                      this tree
-----------------------------------------------------------
5313.2: thin pack                         0.00(0.00+0.00)
5313.3: thin pack size                               5.8K
5313.4: thin pack with --path-walk        0.00(0.01+0.00)
5313.5: thin pack size with --path-walk              5.8K
5313.6: big pack                          24.39(65.81+1.31)
5313.7: big pack size                              155.7M
5313.8: big pack with --path-walk         41.07(60.69+0.68)
5313.9: big pack size with --path-walk             150.8M

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 t/perf/p5313-pack-objects.sh | 59 ++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100755 t/perf/p5313-pack-objects.sh

diff --git a/t/perf/p5313-pack-objects.sh b/t/perf/p5313-pack-objects.sh
new file mode 100755
index 00000000000..840075f5691
--- /dev/null
+++ b/t/perf/p5313-pack-objects.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='Tests pack performance using bitmaps'
+. ./perf-lib.sh
+
+GIT_TEST_PASSING_SANITIZE_LEAK=0
+export GIT_TEST_PASSING_SANITIZE_LEAK
+
+test_perf_large_repo
+
+test_expect_success 'create rev input' '
+	cat >in-thin <<-EOF &&
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1)
+	EOF
+
+	cat >in-big <<-EOF
+	$(git rev-parse HEAD)
+	^$(git rev-parse HEAD~1000)
+	EOF
+'
+
+test_perf 'thin pack' '
+	git pack-objects --thin --stdout --no-reuse-delta \
+		--revs --sparse <in-thin >out
+'
+
+test_size 'thin pack size' '
+	test_file_size out
+'
+
+test_perf 'thin pack with --path-walk' '
+	git pack-objects --thin --stdout --no-reuse-delta \
+		--revs --sparse --path-walk <in-thin >out
+'
+
+test_size 'thin pack size with --path-walk' '
+	test_file_size out
+'
+
+test_perf 'big pack' '
+	git pack-objects --stdout --no-reuse-delta --revs \
+		--sparse <in-big >out
+'
+
+test_size 'big pack size' '
+	test_file_size out
+'
+
+test_perf 'big pack with --path-walk' '
+	git pack-objects --stdout --no-reuse-delta --revs \
+		--sparse --path-walk <in-big >out
+'
+
+test_size 'big pack size with --path-walk' '
+	test_file_size out
+'
+
+test_done
-- 
gitgitgadget

