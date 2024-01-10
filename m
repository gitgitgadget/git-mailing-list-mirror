Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A14D58E
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3FhfS04"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40d5336986cso58199925e9.1
        for <git@vger.kernel.org>; Wed, 10 Jan 2024 10:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704912752; x=1705517552; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0p3TiULwZJC5AIuWFRs5ppVhZ7TqXK+X0E5Qg88Kto=;
        b=c3FhfS04Dumq+5ifyTeqo5r/4V8r++OIcPOIFt78dzILj+fhXukkOXHTYkWoCEg70k
         12yj/7VdFuNRzFWK8rkZzYI9wCTRgzTCd702Ktf/pjEzefHTLxHel/goeV2fM+H2BPJw
         Pu4xr05iCSCttDW/5Xk0F4U2M7MBocwc92mGwkyQHiKJoCuF/2Dm/JJUV9bXJw/kbQW9
         0uUtkyShJensQADPv8N7CuwsCVaMFC3Nr51g9CZSFUqK+VEdaVUBvFsTCljnkUYgfdsg
         TtcZ+dA3i7iz0IjcStps7KI7BFYLJfLhrrCU4Oq01qbBbep+gtRYpD/rvqYUpXslSYtO
         SbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704912752; x=1705517552;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N0p3TiULwZJC5AIuWFRs5ppVhZ7TqXK+X0E5Qg88Kto=;
        b=fFoN1aCFgZoFpI2TxFnHt6jlnPeDSAahN7w49Hmcs48y2YLLC4KByim55hU3h2cdLD
         N8SDvYd2U/s7uIF3D4bC6FI3rqxDmi/cThCkYSC4+tI9pE4LZFEk70ILLMdQ7Y8BhBb0
         eupcGE+6JNZ3+DqNb9SfKIUgZzphLygrL81+vPaeNbczyEI7/m6JkqciFg/trndcqk86
         BO5SZQmojr2li9UwRH6m3MT+wxMI2d0f4UDrWQjkRtQT1PxmqrEwCijU52NuDIQfum+l
         6DMnG4o3x3mxr8wO/Z1wGyb3JHsQJjNpIj2jqyono4gpVYcyAL8fM3UdWPqQajLyqR9c
         Yuiw==
X-Gm-Message-State: AOJu0YzeK4xz89nuw7ZO16QTQ4gxBTso5m28q+LhReTcVuH24IMl8Ihq
	Rvl44gutt0rPVCT2gXobjcHFZITr798=
X-Google-Smtp-Source: AGHT+IFctur9rMdL6cF0Q2Qe2kuom5iadC81mRYcyV0wdkhahP0Pl912WKWR0wuRnalmAdmR5/W7Jw==
X-Received: by 2002:a7b:ca49:0:b0:40e:4ded:a87 with SMTP id m9-20020a7bca49000000b0040e4ded0a87mr816444wml.94.1704912751660;
        Wed, 10 Jan 2024 10:52:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-20020a5d6dc8000000b0033671314440sm5460531wrz.3.2024.01.10.10.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 10:52:31 -0800 (PST)
Message-ID: <cb78b549e5e826ffef39c55bd726164e6b7bb755.1704912750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
References: <pull.1634.git.1704912750.gitgitgadget@gmail.com>
From: "Justin Tobler via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 18:52:29 +0000
Subject: [PATCH 1/2] t1401: generalize reference locking
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
Cc: Justin Tobler <jltobler@gmail.com>,
    Justin Tobler <jltobler@gmail.com>

From: Justin Tobler <jltobler@gmail.com>

Some tests set up reference locks by directly creating the lockfile.
While this works for the files reference backend, reftable reference
locks operate differently and are incompatible with this approach.
Refactor the test to use git-update-ref(1) to lock refs instead so that
the test does not need to be aware of how the ref backend locks refs.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 t/t1401-symbolic-ref.sh | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index c7745e1bf69..bafe8db24df 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -105,10 +105,30 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 	test_cmp expect actual
 '
 
-test_expect_success 'symbolic-ref reports failure in exit code' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
-	test_must_fail git symbolic-ref HEAD refs/heads/whatever
+test_expect_success PIPE 'symbolic-ref reports failure in exit code' '
+	mkfifo in out &&
+	(git update-ref --stdin <in >out &) &&
+
+	exec 9>in &&
+	exec 8<out &&
+	test_when_finished "exec 9>&-" &&
+	test_when_finished "exec 8<&-" &&
+
+	echo "start" >&9 &&
+	echo "start: ok" >expected &&
+	read line <&8 &&
+	echo "$line" >actual &&
+	test_cmp expected actual &&
+
+	echo "update HEAD refs/heads/foo" >&9 &&
+
+	echo "prepare" >&9 &&
+	echo "prepare: ok" >expected &&
+	read line <&8 &&
+	echo "$line" >actual &&
+	test_cmp expected actual &&
+
+	test_must_fail git symbolic-ref HEAD refs/heads/bar
 '
 
 test_expect_success 'symbolic-ref writes reflog entry' '
-- 
gitgitgadget

