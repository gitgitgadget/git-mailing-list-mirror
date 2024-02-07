Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB9F81ABA
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324675; cv=none; b=YECJdDpL18Uule/kCXfwzgKc70r92glAX6CDLICokAqSN3I/l2YyVDTeoVl4ME8w51KPiYBCMZ7X+ZTMLkjJfHgJWfeY7/jjTNbQgwRy+uuI7Aa0urURPK9O4SuunGvcbS2ylJVJe/dHJ7x8AgAC5GWoY4DxOJ697XKedZes51s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324675; c=relaxed/simple;
	bh=/MltqnnCkbZ9/7zF6FXwonkrB9mr/KU9njk+BG5JZ0I=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IBJIqSIfdnricwP3MfTBcUo5zQ5YS05Q0p9R9UbzM//QiLfz2eUsI6FpGOtnfvM0rjODxMAz7dS74fttIkmd6GeQ+8qlBn/h0dbtePjuhKSzQOiu1VSV7+Xrdjfpc0OQVwWK6BAzCFS9b1z/4+LCqe1VT4v3VATAAKt1SE9DIuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCqrguFn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCqrguFn"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3916c1f9b0so1513566b.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707324670; x=1707929470; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJM0XwCSR0s9gXTxQ2VsBsPLR5Gx5SnZJB+l0g+fPgQ=;
        b=HCqrguFn3KQ4rBjjc554tWZTT/xsuvR0U7CrPN1D29N/Y7HfV08OOSQCv//X5K2oE0
         3jStbaKXzDcIjfZzIAVNlvVPk7hsJ98NE3wE7OIzIFPSPCYkAwsV75rIKodJ96q5Mqjn
         qYKRgY8hBjLululjIjGFf+1cnyFMeNkEuNKT45vMF653seaYLZ1JfGtUOWVL7a7q1F65
         DIvKY/NYwrZ+GwqcfOvlY/XNYh3+fcnhWvuZTy7ld6prysvZjniz6lvNKSydEiDL7r+Y
         hZXYd/yQEVSmfcsgiv5TH+jHOJVOKN1NsmsDYQLKaGgm77WsagI6+jQkqmdq50lCVyuK
         VzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324670; x=1707929470;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJM0XwCSR0s9gXTxQ2VsBsPLR5Gx5SnZJB+l0g+fPgQ=;
        b=qUjo8ldhYT4WqdEUJQGYgaSNXIoFn9+Ul/p2FdEy6uJ3c9c9zIqyDFyzJI+rT4vMO1
         vCVdY7MJsT7UX8etJjKeR6Dqt9zG/hDVNnD9m9jksTGfxmf0x9KPhteRtgRltQ1pF3eq
         2VFdn+4CrMoLQ0G9K7XzLRAqHznV3EnFx2mkns0NnJxLE4/3CQWLU70SbxldRekwm0v6
         ZKjUlBxoaf1TZ04wU0YzzWzT1HCPZ9zkC1um/hzgPG3k2bLtAD2ovKpOmXMFmg/mn5WQ
         8IoT1ro4BFh1GtTD0DmNvRab2J/DBko8XWjlKvkztK76phlAr0+2ow3Fe2GdGvN273SJ
         FDwQ==
X-Gm-Message-State: AOJu0YzedA4nIcOse7O/kFoiK4AD7L0LkIpfilRlF6Lr9gMK/e9WHA3K
	2u0ZSzfPxfGJDLQoMX8gNsaJLtIL+QwVwlRXB5tK8hV+qcJWk+8kGRRnxvS6
X-Google-Smtp-Source: AGHT+IEAq0WhdepgQjm8z9nC2tXniwEOJIppZrhWb018XJ3RS5D97zWzAzNNHELTHRWLDO500Mc0vQ==
X-Received: by 2002:a05:600c:3512:b0:40f:ddbb:73ae with SMTP id h18-20020a05600c351200b0040fddbb73aemr5179892wmq.27.1707324279498;
        Wed, 07 Feb 2024 08:44:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNEvgyuTmUn8Cj0sqoH5wJrRj7we52N8MvuDRnTxJ0+Io7RRIcFwCrJTV3+I8maDpMtiU+0zECy0rDztNpQjIts9e7N91XwZUqbw==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b0040ec66021a7sm2608061wms.1.2024.02.07.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 08:44:39 -0800 (PST)
Message-ID: <b828456329956e9a0a50a33df63486bb3a985474.1707324277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
References: <pull.1654.git.1707324277.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Feb 2024 16:44:36 +0000
Subject: [PATCH 2/2] t1400: use show-ref to check pseudorefs
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Now that "git show-ref --verify" accepts pseudorefs use that in
preference to "git rev-parse" when checking pseudorefs as we do when
checking branches etc.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t1400-update-ref.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index f18843bf7aa..78a09abc35e 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -524,51 +524,51 @@ test_expect_success 'given old value for missing pseudoref, do not create' '
 
 test_expect_success 'create pseudoref' '
 	git update-ref PSEUDOREF $A &&
-	test $A = $(git rev-parse PSEUDOREF)
+	test $A = $(git show-ref -s --verify PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with no old value given' '
 	git update-ref PSEUDOREF $B &&
-	test $B = $(git rev-parse PSEUDOREF)
+	test $B = $(git show-ref -s --verify PSEUDOREF)
 '
 
 test_expect_success 'overwrite pseudoref with correct old value' '
 	git update-ref PSEUDOREF $C $B &&
-	test $C = $(git rev-parse PSEUDOREF)
+	test $C = $(git show-ref -s --verify PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with wrong old value' '
 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
-	test $C = $(git rev-parse PSEUDOREF) &&
+	test $C = $(git show-ref -s --verify PSEUDOREF) &&
 	test_grep "cannot lock ref.*expected" err
 '
 
 test_expect_success 'delete pseudoref' '
 	git update-ref -d PSEUDOREF &&
-	test_must_fail git rev-parse PSEUDOREF
+	test_must_fail git show-ref -s --verify PSEUDOREF
 '
 
 test_expect_success 'do not delete pseudoref with wrong old value' '
 	git update-ref PSEUDOREF $A &&
 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
-	test $A = $(git rev-parse PSEUDOREF) &&
+	test $A = $(git show-ref -s --verify PSEUDOREF) &&
 	test_grep "cannot lock ref.*expected" err
 '
 
 test_expect_success 'delete pseudoref with correct old value' '
 	git update-ref -d PSEUDOREF $A &&
-	test_must_fail git rev-parse PSEUDOREF
+	test_must_fail git show-ref -s --verify PSEUDOREF
 '
 
 test_expect_success 'create pseudoref with old OID zero' '
 	git update-ref PSEUDOREF $A $Z &&
-	test $A = $(git rev-parse PSEUDOREF)
+	test $A = $(git show-ref -s --verify PSEUDOREF)
 '
 
 test_expect_success 'do not overwrite pseudoref with old OID zero' '
 	test_when_finished git update-ref -d PSEUDOREF &&
 	test_must_fail git update-ref PSEUDOREF $B $Z 2>err &&
-	test $A = $(git rev-parse PSEUDOREF) &&
+	test $A = $(git show-ref -s --verify PSEUDOREF) &&
 	test_grep "already exists" err
 '
 
-- 
gitgitgadget
