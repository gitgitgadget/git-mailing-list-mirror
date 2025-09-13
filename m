Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE97251791
	for <git@vger.kernel.org>; Sat, 13 Sep 2025 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757796879; cv=none; b=CK7zqX0H7RQ1SC9s2jUiWcM6GqwbHXPsdWPJ8nEWVffQUANCiotIUvFDHsdo5uIBzw9zcQjaBH7bNFszqQNByCMnNf1gcOP22namtauatJ0ZyUWY4fwfR9cVLu37e9vElq78F3zUvDh6AThWfECUpB3K4jzeBOTR0ZrdDqIwGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757796879; c=relaxed/simple;
	bh=8loQUQ3Gc2cr5gphOI4Ne/eYKq8pblM45dPkmJt2o3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Chml19znZ0qyZdoFTxN/Ng4EZJBH15w9cst1uEUN/mXbEqnsWFCxh3XLuuuxpey/NCeWjJbRElSzqwoeJPi4cj9nprrxFBFOIjmMg54YUhJrwKgN7kho3SMlIlRDtw4bP/JHMY08FvUUtoF0/I47+1uy0FSq33+PJq5KI5IWb0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSG/Ww3z; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSG/Ww3z"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so429506866b.3
        for <git@vger.kernel.org>; Sat, 13 Sep 2025 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757796876; x=1758401676; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VEzM7P8y/3KToAyU8MO3MdhBIIK/IgUnjflCT5/In3Y=;
        b=ZSG/Ww3zoCYE/cdRhfS2BOG6UepB12Bh73VkcuK1VXY0Y+m7weRv+Mma/Qz3jNa5x5
         5bcNb/aN6io2T1NpwzQOOalt6J+Lr5k2DTem3feZaonFAzzOztoAgM+5Y1xS5VqU4HRv
         BFGiHTWUm+7OamhuRiXYPulBwHCf5wOXlqz67riB/n3l4sGZbRoCScNgHQrh0iDjaZOx
         fvViiz5VFjhzrPHiTOOZfpiqLNrGs9pZDxpSCPnoieFGnBNaQiGxH66ECvWc9vfqcveZ
         kh++xESWA5KnWaE6C2uKjxli2RB73S6Q0V+p8Tiymq1LNdw2xesxJtJCWrHtpAStmzVh
         Be2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757796876; x=1758401676;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEzM7P8y/3KToAyU8MO3MdhBIIK/IgUnjflCT5/In3Y=;
        b=MB6x7xVO6iVlMYzEULNGcnJny/mN6EVF+inN7GlkPFOKzFNNmxiVRcp20Kid+k5Mde
         yb2AlqBvLZVr2jsZHrj8zBNFEVi0D+piWDRhWX6HnpljmvOnmgn8hxh5cKQVWX0ufsuv
         d+JGZEtllempMlNplhS/bZvOMgiZrnHBL1hrce33+H8bQD9hREqYQ484LUxT8yPnBO7o
         ltXP4C41icdIMFmg5Dzofw621sacceSaXZak4kUyM8XOEL9DHM8oTdt4GR/1eR6Jy1KH
         U6RnEHDXRiVOtA/ydmQe7XAe96M0JDv3jw22loKaJMxsDliOyxf+MSxv2Wh399k1KPpy
         km1Q==
X-Gm-Message-State: AOJu0YwUU814s1X95LnB+pFat7yZDcPDLtzJRuqh8GWNWFjbLmUeXUWv
	D+m2Ny8aVVoE2usnr2h2TBgECZEA6ep+u3axD6ApG/Y3nVoLJKo12vN8pyk2CucG
X-Gm-Gg: ASbGncvh2uY03PhUOsYco9OC93J+l3kN4w7TGfWZrJ4bXlHyvwGlNn23p1S6dTzquby
	971VTLPQBkpUHeyHwiohzHFTQLryC2z9zXrR/mpCfLGQ5dh+izU1SBdxlOQqEjh3Xo3qmLoCZAR
	6VqGkPmYU7/9BhsXaqPNCzCBectyW9x7gFumhVvqFB9b//fH6xMP6ORccaxPwVV/7gdI+GwNQu+
	r0YDusExUfRS3pZ+tSzTACzPWdYcEW5Zc2EQ9w0v7TXWR+vEFFubCTSwqo5tP2SQUYULCUYIfV2
	9in/oh44bD/RcEiT0WlVftJhfbMEDBp7FUg7/4Kro1Q7vZyLcOkmWvRraD0/qELrXpUnA2dotjj
	kIiI798yAN1LZKcNw95mxaQcMtABvOdvKeAhzBpQ=
X-Google-Smtp-Source: AGHT+IEeK6qPkcS7bDv4lmhpcjj+l2oYrKQLYMZdK46gDBvXf62vTeWZHzz9ixX+m5mZtCadcZawKQ==
X-Received: by 2002:a17:907:980c:b0:b07:6444:a6dc with SMTP id a640c23a62f3a-b07c3878986mr735390266b.56.1757796875678;
        Sat, 13 Sep 2025 13:54:35 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:5b4f:6b96:ff06:27eb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32ef574sm635383466b.73.2025.09.13.13.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 13:54:35 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 13 Sep 2025 22:54:30 +0200
Subject: [PATCH v3 2/4] refs/files: use correct error type when lock exists
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-2-195569740b57@gmail.com>
References: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, joe.drew@indexexchange.com, 
 peff@peff.net, ps@pks.im, gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=8loQUQ3Gc2cr5gphOI4Ne/eYKq8pblM45dPkmJt2o3c=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjF2gghMP/XgacVA+2nvZtGRgbS4ktzmjF0E
 sLobXr6SJSimYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoxdoIAAoJED7VnySO
 Rox/QnUMAKJ0M7T2+nl84UNXaGMH8U6v5LD76eEWQxKjVZVmXAyu3tvaA5xu5ewhQ0YZM816aXC
 iUnBeaOc8rbY5JZVcHZkLIKpXMN1Kfnv7+zFz7vxqXfRS8kaOF70LKweW7nAi1MRYXMq8ziv6FI
 9xl0yzSoQ0muBSBohk6hvpWSI5NtjA+Lrl/4JvcxUJYsuPV34g7fxXGx4zkclgtr+Gec7iNcH/N
 FZuW0f3jKZ8Ln2mwynbQvYLW9Fxu23Qj6nc3PTYnN8jjSG6f6IHG+anpIg2UB1oGMYx70I7sJlr
 D7QqdtiaQPhreSrda1s8IHykYHq0jieY23SPTZUcw+0ialsuSC+t1IR+VM2OFIX3e3jP/taZDxF
 /5cfVm/12ffPv4sXtPL84DrRhgCmbTz47qNrAmQMDQ7l0Msjx8D9x6avxWRNCcb4HZLJO+oTcAz
 KuIMa4ryOq1bZTeq5IMELObYGQ1END5cWwOmW9czQBsI/qu8Jpda69zez6XiN7zrJiRlEk6n8f7
 xQ=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

When fetching references into a repository, if a lock for a particular
reference exists, then `lock_raw_ref()` throws:

    - REF_TRANSACTION_ERROR_CASE_CONFLICT: when there is a conflict
    because transaction contains conflicting references while being on a
    case-insensitive filesystem.

    - REF_TRANSACTION_ERROR_GENERIC: for all other errors.

The latter causes the entire set of batched updates to fail, even in
case sensitive filessystems.

Instead, return a 'REF_TRANSACTION_ERROR_CREATE_EXISTS' error. This
allows batched updates to reject the individual update which conflicts
with the existing file, while updating the rest of the references.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/files-backend.c | 20 +++++++++++++++++---
 t/t5510-fetch.sh     | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 01df32904b..69e50a16db 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -797,9 +797,23 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 			goto retry;
 		} else {
 			unable_to_lock_message(ref_file.buf, myerr, err);
-			if (myerr == EEXIST && ignore_case &&
-			    transaction_has_case_conflicting_update(transaction, update))
-				ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
+			if (myerr == EEXIST) {
+				if (ignore_case &&
+				    transaction_has_case_conflicting_update(transaction, update))
+					/*
+					 * In case-insensitive filesystems, ensure that conflicts within a
+					 * given transaction are handled. Pre-existing refs on a
+					 * case-insensitive system will be overridden without any issue.
+					 */
+					ret = REF_TRANSACTION_ERROR_CASE_CONFLICT;
+				else
+					/*
+					 * Pre-existing case-conflicting reference locks should also be
+					 * specially categorized to avoid failing all batched updates.
+					 */
+					ret = REF_TRANSACTION_ERROR_CREATE_EXISTS;
+			}
+
 			goto error_return;
 		}
 	}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 57f60da81b..6f8db0ace4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1546,6 +1546,32 @@ test_expect_success CASE_INSENSITIVE_FS,REFFILES 'existing references in a case
 	)
 '
 
+test_expect_success REFFILES 'existing reference lock in repo' '
+	test_when_finished rm -rf base repo &&
+	(
+		git init --ref-format=reftable base &&
+		cd base &&
+		echo >file update &&
+		git add . &&
+		git commit -m "updated" &&
+		git branch -M main &&
+
+		git update-ref refs/heads/foo @ &&
+		git update-ref refs/heads/branch @ &&
+		cd .. &&
+
+		git init --ref-format=files --bare repo &&
+		cd repo &&
+		git remote add origin ../base &&
+		touch refs/heads/foo.lock &&
+		test_must_fail git fetch -f origin "refs/heads/*:refs/heads/*" 2>err &&
+		test_grep "error: fetching ref refs/heads/foo failed: reference already exists" err &&
+		git rev-parse refs/heads/main >expect &&
+		git rev-parse refs/heads/branch >actual &&
+		test_cmp expect actual
+	)
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 

-- 
2.50.1

