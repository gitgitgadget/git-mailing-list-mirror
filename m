Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A983093CE
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598839; cv=none; b=b0XfL+6XRde4mqJvqVzr6cC5izqogf4gF4WCUvG2rdleTBXfpditNlllNn99EwsU5YS9a5WIGTDBExZr6Oh5y9iAvBh2FcTyGG8zJVvIupsshGMPHcafSAkY5pXkPHtBfWS5spEV3MymmKQvFkPnpxaRTSEY9kT0PwoZEuIVvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598839; c=relaxed/simple;
	bh=Sq6ag5QaxiAVuTARYrz/+Enwb/oJXCb3avWF8hgb7CE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M61aIt0VWyChKL0bS510YqG/XwPFw6Q9SsML6Z5g92Chmidj95uatvULlQW++e1ew2qcy+o+JA5++mOdzf0I8+lu1/8RIFrvt7Ljct9obxNGM8qdS26y9GfoUskTUjYyG81lq6yiTqV4er5JzhAmzr8AdfuQ//zR9MpT6H8agqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exvDUesq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exvDUesq"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so9596215e9.3
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 13:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598836; x=1769203636; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DfET2ei3uSjbRfsYKpOR8iw452K5YJr/kE8h+6XRwxA=;
        b=exvDUesq4YKBT9MhmgVfDoo2lCIoai3OqkUmrKJ7hR/4AWNAYK9sQbkUYL9tgSTX5I
         SDBNnWaONXEJImid+ePHCWI1D0eJQ1v4lRtVGDqogZYIUPrBqCdzrpU0y1TwUkkc6Sq0
         jhgYzPzTNeOXKaUjxKSZoUMYkdByFu3rubTev/8ZT7x0aN19ZP0S+KWimNKpFLZ10zF2
         HwqwSOx4E2xgwRvK86qm1mLJ1a4/ye5Wmb3oW3C9iewW0pzEBCOPSO8FLq5imCrEqTrG
         UbJWqm+BL431idGNPuyI/MME1J9MdsjRJV2DQpjrYC7M6Aut44+pqX/FYHm3RE9ydX9y
         Il9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598836; x=1769203636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DfET2ei3uSjbRfsYKpOR8iw452K5YJr/kE8h+6XRwxA=;
        b=PdrbxXMNiRPX1r0gOvaBeA0On9xUvN7iktTIFKSamZskNlbJahbwd9LRFQqkuyXa5S
         PoYQWe2F4rUVPR6Uo6nPaUm09nHePq0RRiM9Z4sXBY4YqAHA3Vq/3zR4Xk8ylQ/XoGyI
         2eIwst6EdduxAcCuFPMa22GJXX0NO65IV20tR6RYV/ybLLWygKh8lfHnfWVhOXGpxusi
         REZzaoN0laPSG0DorbOjjRF2Xu70nVtjsLznOY+ZHzjFnBq3mUIYB2ob7ryWKrfNGL3M
         uNo7yszIOQp55JGIbMzzNcbn0LCMm3q3+nYol8db5JBvqVxN3+0GtOMm6mZNcaSWSNgG
         E2Vg==
X-Gm-Message-State: AOJu0YxyT+d+nhF/h4tXTJcKuS3QmkxoTMwZEoH+0L9QWy43xzO9hOfQ
	dc7SwdXHqJhcmeUhxkYs7eIRQFWfhoh1iBuM7oDW1mmXlJSaMfzXxqD+MkbGBg==
X-Gm-Gg: AY/fxX4Voqbv2tPwOgg1VWZV9qUK7aIY4aVMF8H99Y+pCkKL11Skh1dFc1LgZeTVGhk
	D5Yi0TfP8XBe86RGurYOJrldKWB6ySIUpnDLcbOHu3vKFv/VoJCtvta6FRSjmIwIiOeU3TPeB3P
	GfSZYVLhuMNCyZWBPVP3IW8fxcjgIqL47104SdmJIluNGeCKlZ0IQvaZMiGPUbl3sMv4IZYfN/i
	OK8lQTsizfJwKsiDRVM6eRZt2sSU6aZtRAUrYcc5iMICOpZ/N86xRoHHeA0tOZRM7+Is6AarugU
	rG44OsNH9h1R+AMWvvlbPBPNA25e/mkRlPjbev1IGu4hx+hzD0pWjsVqC5CibUXW5c7dcwlnYtS
	BkmQKkpDtv+Z2bmLXH1Ro2aoXq8tMuo/G43Y5f8uowkKp2tzBywbd2CZBgwNcNlI8HZyFuhjkE8
	OUmUFZGCnENfMBlIXSOaE=
X-Received: by 2002:a05:600c:5487:b0:477:755b:5587 with SMTP id 5b1f17b1804b1-4801e2f055amr53463635e9.8.1768598835695;
        Fri, 16 Jan 2026 13:27:15 -0800 (PST)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:1edb:411c:5531:1628])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801fe67780sm23382025e9.16.2026.01.16.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:27:15 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 16 Jan 2026 22:27:10 +0100
Subject: [PATCH v2 5/7] fetch: utilize rejected ref error details
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-5-925a0e9c7f32@gmail.com>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Elijah Newren <newren@gmail.com>, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4230; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=Sq6ag5QaxiAVuTARYrz/+Enwb/oJXCb3avWF8hgb7CE=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGlqrS07SUpKHC+YtPIdL7MyZ+YzrO0GCXhYH
 KZJe4gL+VhapIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpaq0tAAoJED7VnySO
 Rox/FQQL/Rh6nvjt3HSqsehSL3DuzVJYuKPZNx4H9YrZfwlVI2bWI3yifZ9RlVjZX9GycAPLwpR
 6mx4VCXIYVl46Ycp4qt9lINs6P5u6N9DWJGenKyh+BUwcWki3/iovBYz0UfTPQOTfwgqxoAFz9j
 28gUx8qYTLQVkqzYscvJ4jGyVDfuVgac/1DrW2Lc+D1WVwkvlVwLDYMEmf+/MJVMAo2mMHvchrJ
 0+Xr/iBURSC6fdonHyEkDKIGU+L9zHP5PfQwSULEALhftu7DxWdCTWoaHiBn2O1bFHCKZ5KhIkz
 Opw5uMUXfW+5nTD1VOux89KxIIFNlUeHKEX1evyGbxr59CO6poLuwxy8OIa4jBu12TyDBmLjzSq
 uMVFeCL42nYder86Ow1UGuAoja2OdkuUYS2kSXb9awO/Dfb0pVMT9h7lc1mxgRQcCzQo5GgnrRJ
 yzKU6t8Vfe+2UKb06B72MPpc2+uSHiLjDZ/fk4+5yxdBfgBBPyunBNrAMD8RaJ99Jr0mmn3j495
 ZE=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 0e358de64a (fetch: use batched reference updates, 2025-05-19),
git-fetch(1) switched to using batched reference updates. This also
introduced a regression wherein instead of providing detailed error
messages for failed referenced updates, the users were provided generic
error messages based on the error type.

Similar to the previous commit, switch to using detailed error messages
if present for failed reference updates to fix this regression.

Reported-by: Elijah Newren <newren@gmail.com>
Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/fetch.c  | 10 ++++++----
 t/t5510-fetch.sh |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d427adea61..49495be0b6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1649,7 +1649,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 					      const char *old_target UNUSED,
 					      const char *new_target UNUSED,
 					      enum ref_transaction_error err,
-					      const char *details UNUSED,
+					      const char *details,
 					      void *cb_data)
 {
 	struct ref_rejection_data *data = cb_data;
@@ -1674,9 +1674,11 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"branches"), data->remote_name);
 		data->conflict_msg_shown = true;
 	} else {
-		const char *reason = ref_transaction_error_msg(err);
-
-		error(_("fetching ref %s failed: %s"), refname, reason);
+		if (details)
+			error("%s", details);
+		else
+			error(_("fetching ref %s failed: %s"),
+			      refname, ref_transaction_error_msg(err));
 	}
 
 	*data->retcode = 1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ce1c23684e..c69afb5a60 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1516,7 +1516,7 @@ test_expect_success REFFILES 'existing reference lock in repo' '
 		git remote add origin ../base &&
 		touch refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/branch >actual &&
 		test_cmp expect actual
@@ -1530,7 +1530,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'F/D conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_fd &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot process ${SQ}refs/remotes/origin/foo${SQ} and ${SQ}refs/remotes/origin/foo/bar${SQ} at the same time" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/foo/bar >actual &&
 		test_cmp expect actual
@@ -1544,7 +1544,7 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'D/F conflict on case insensiti
 		cd case_insensitive &&
 		git remote add origin -- ../case_sensitive_df &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "failed: refname conflict" err &&
+		test_grep "cannot lock ref ${SQ}refs/remotes/origin/foo${SQ}: there is a non-empty directory ${SQ}./refs/remotes/origin/foo${SQ} blocking reference ${SQ}refs/remotes/origin/foo${SQ}" err &&
 		git rev-parse refs/heads/main >expect &&
 		git rev-parse refs/heads/Foo/bar >actual &&
 		test_cmp expect actual
@@ -1658,7 +1658,7 @@ test_expect_success REFFILES "FETCH_HEAD is updated even if ref updates fail" '
 		git remote add origin ../base &&
 		>refs/heads/foo.lock &&
 		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
-		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		test_grep -e "error: cannot lock ref ${SQ}refs/heads/foo${SQ}: Unable to create" -e "refs/heads/foo.lock${SQ}: File exists." err &&
 		test_grep "branch ${SQ}branch${SQ} of ../base" FETCH_HEAD &&
 		test_grep "branch ${SQ}foo${SQ} of ../base" FETCH_HEAD
 	)

-- 
2.51.2

