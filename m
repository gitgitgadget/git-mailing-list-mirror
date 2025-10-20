Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E22E8DF7
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948323; cv=none; b=I1SgsCLruk0Hd1WziSYthKavDXFs6W7YeL6YGBu5dEMQL8bfvOOEq1T1zwpSg5+LPOxwt52sM+FXr4LBdLg4MLQQcHE0i8J7kNXySWHvP+mgZYgHJXEi2JEHBgBlgMpx1vh9qGfh8CJtcr2oTG6+KrC20+zc2sk/kkm06XfvZZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948323; c=relaxed/simple;
	bh=a+4TwsxHBEblygWcypEHNoSwBvwgL2tg4JPm6t/ht2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wliyc//EvU/mUXUUD778Ex4yVdADnHluiI+684Apo1W0ABfjTAmwyVBcMSU1Fq6wfCT47acMkNaX1kHuQk0GEipud5lMmgzXuVFQzl3LxTR5wVliKFNXYh4frrufgUkA1NN1yFn6qeVcRo6ty1ovGF7ERxrZ8oAJdv1yVIIbomU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9XvOu4s; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9XvOu4s"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso701105766b.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760948320; x=1761553120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GjXLffEfXT+gmLQpqEubUETgswes520pE9D7QD98cE4=;
        b=J9XvOu4s1bACDm3YKChM42q2JpiwnZY/B8tWDbkmRaryaMpLCe5vTm1PajzU4zfqCQ
         RFtUiiYvCI0BTioDzSnO8BpwNgw68bpYnI54fIU3appEJC/viW9qbq2fDNcXV+kM31hv
         lW7/uj3ACyZeJF8QA6KStinKxaCbxIWDe41/xQvDAP+sNKU8+gv+ylwqCumgT4mYIaUx
         iVdr0fI7ASWqq5PIhSz0IGGUnZdHSuXVtY5f1l94M8JpWR+wqAiLa+F8UPTzAAA7DDv8
         JBzPxAGwvtuC2Mcpw2xb2awykCLyWWjmR41qpswac6W6N3DdmRhncFUWMvN3JVh0+ELE
         4Smg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760948320; x=1761553120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjXLffEfXT+gmLQpqEubUETgswes520pE9D7QD98cE4=;
        b=hg6l+9zfh72xtfGvc1pYV108NQDNJjJDTsLU6wrnS+O7I0nhPbSVal7zPSpW/PqCqj
         3Tf1BdClM1f2UhcFhiXyJoBFAvHHnOQvZjvhHJG5A3R2JU7ttnyPkpkTNL8cSe4A0MTl
         c9A0R6nDAhfT7Qgv3UczGfcybiLCY4saT168e/wWRdAPjpvvbE7JHZPhDodNAupb6wuC
         955T1MYrqCZfi23PzVVwgpp0YvBWfX4oXKrmCvLYUK96e1qXs8ULiw6UEaosnmU9JuuF
         x8KlZzPJwvgNYSsfk3zrmt+4jG7SCZQjqJImtf9CTznvoyVb1f/pSz9IUlhcp7PhUGTT
         NLTA==
X-Gm-Message-State: AOJu0YyJSwW1FSKYUweJl+4d+bsN4k4RpQoGPFIGp8TXUCFp0EcfySS4
	K5UnnrQXzzdKG9GdEKTJchyYsU1GptJ3pxpL/8164BOverp0wSNv0AJMAQtaknnS
X-Gm-Gg: ASbGncvNVKZstxbxCCMMjvXsup6sdJt6SPfIC5w2BfvcmkCuy7TFZXeCbNbBLp6S/uY
	Vqym72I6ejLaWgA//orBcSnSFPv0D1v/bkRGVjwjhSJQRYLY6FaZ+ZEhB2oZaS/ZaYqaQE5RS2s
	3f88VyVQ07p9txMw/SK9Gu4ElErIIwvH+Q1LcRNXDAxzoKapD5MUMwc9LgjJRKmRzCUiT4iG6aP
	h2j186c+LHwDJrSRdm06jjJ8Yq1i6bNqLN7/XoY4i/hhEyalO/c6610RJFMsLxpdWlmGho9r8+w
	fMEvGR0gnYsVi/5hxR3GvXQ/b9YOnkYIVu3GuUcxMSUiRX6aOFHVe+sISXssvECOB4hpYwvrpe3
	JVzZBeLxLGgoTMUiwDjv1U+rsqAJmV7H6OtSdK4bIQo+UR9//EPIFuAe1PW92Orn2V0eHKS9xrT
	NG8d58wBqX
X-Google-Smtp-Source: AGHT+IGWgrmSFxJN3iRKvMSTjCFqhCWIyP0yrrOqU5BMqEzRDTt32RXuilISvUeq6je5J8jx2Bxqsg==
X-Received: by 2002:a17:906:fe4d:b0:b3c:e14c:e24 with SMTP id a640c23a62f3a-b647195b339mr1279070066b.13.1760948319671;
        Mon, 20 Oct 2025 01:18:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5fd9:4a3c:9f89:6c65])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebc42bc5sm716186066b.76.2025.10.20.01.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 01:18:39 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Mon, 20 Oct 2025 10:18:31 +0200
Subject: [PATCH v2 3/3] t/pack-refs-tests: move the 'test_done' to callees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-refs-code-cleanup-v2-3-f5349ed0f6a5@gmail.com>
References: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
In-Reply-To: <20251020-refs-code-cleanup-v2-0-f5349ed0f6a5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=a+4TwsxHBEblygWcypEHNoSwBvwgL2tg4JPm6t/ht2s=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGj18FtBSnhyMwoYsfl2lSlxz/MLfX2Ffilmq
 89lti/shXNHG4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo9fBbAAoJED7VnySO
 Rox/ApwMAJhkV1TKr0oCEhZajjC6fYWwGbUhmWiw/FQNgEGxrEFcwISNxJSTVWSa2xnFsewljCI
 g77BoiiKBVcwfa/kDNkS89PD7XYnztQJLbqBLoEmHqgFbCbWpOqmwuHpWu6eN3yoXNelFCY7IK/
 aK+ucoBA00Tnq4SrgzJw3kW6nlf3zHOLdTWEEjP2jqz7Y+LeM+80BWCcQLzO7iLu++ejm8a4dmQ
 2/WH1hKdxwfvma+RdHL+ipSWhz2AggY6wvyKtR+JLYFMIC8BRqqMHVhNpM+iLc+6GnZDg0aFzlW
 MK1JzxpzuwHS5vI30CnHoVLlFhpyiwvuwOAHn7H55+v6bJjElYdHiOloLF0NjV6/Py4gAOnyFto
 6/Ue6sbQjPOjPXWT6qs6MRlfBzKLe1Cj99tagJvVcwK7pFZcjZZNOqXFCtij5mOszvJmi4jTw8y
 w1EzdLQ3sFthUVQmobbtGzd5TW1hzaJmRJDIy5NhDVKXEC15a93sKZ4OdJ2bKGHiLGknAgNzJD4
 2Q=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In ac0bad0af4 (t0601: refactor tests to be shareable, 2025-09-19), we
refactored 't/t0601-reffiles-pack-refs.sh' to move all of the tests to
't/pack-refs-tests.sh', which became a common test suite which was also
used by 't/t1463-refs-optimize.sh'.

This also moved the 'test_done' directive to 't/pack-refs-tests.sh'.
Which inhibits additional tests from being added to either of the tests.
Let's move the directive out to both the tests, so that we can add
additional specific tests to them. Also the test flow logic shouldn't be
part of tests which can be embedded in other test scripts.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/pack-refs-tests.sh          | 2 --
 t/t0601-reffiles-pack-refs.sh | 2 ++
 t/t1463-refs-optimize.sh      | 2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/pack-refs-tests.sh b/t/pack-refs-tests.sh
index 095823d915..81086c3690 100644
--- a/t/pack-refs-tests.sh
+++ b/t/pack-refs-tests.sh
@@ -459,5 +459,3 @@ test_expect_success 'pack-refs does not store invalid peeled tag value' '
 		test_grep ! "^\^" .git/packed-refs
 	)
 '
-
-test_done
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 12cf5d1dcb..3c706978ef 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -18,3 +18,5 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 . ./test-lib.sh
 
 . "$TEST_DIRECTORY"/pack-refs-tests.sh
+
+test_done
diff --git a/t/t1463-refs-optimize.sh b/t/t1463-refs-optimize.sh
index c11c905d79..9afe3c1ed7 100755
--- a/t/t1463-refs-optimize.sh
+++ b/t/t1463-refs-optimize.sh
@@ -15,3 +15,5 @@ export GIT_TEST_DEFAULT_REF_FORMAT
 
 pack_refs='refs optimize'
 . "$TEST_DIRECTORY"/pack-refs-tests.sh
+
+test_done

-- 
2.51.0

