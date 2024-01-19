Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B31C58231
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695555; cv=none; b=t5uCLeKbUgvnP1M7+addBhn3Ykqsmx0v+sNNYnDMz04pK5Orxe3fy8NL7pkvAGtad74Eoif984qAVs4yG0BAt217h5w0rSDt9RsLBYTYs80M71uAlNxl77rW2icMhQQ4bUKx7RxuR9DKJ+XhJBpbDWTdOpbT8g71UWhYvuJ3Fno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695555; c=relaxed/simple;
	bh=0BNqy62I21DufwdVTrJXJjFfhrTvm0QQSsq7wxShHek=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nm//soMHHHeWr3s8fguHazut0snBskSMwACwaStbdmBQKTkXP5hk6fOGBbIRwjdWh/mmeKr15po+Mqfi7dCEZuWm4yM60Ck6KhtbpwE50mypFkw0Z+21oDDIXEJY+uKKlmhvRcztXXQ3pCCbsq1vz6l6PCpR3w5bnlZPwU/Za0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBB8fA5B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBB8fA5B"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e884ac5c8so12822655e9.2
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695551; x=1706300351; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZcL5wFS2YZ9ArnfVnbXUSI+bxzKkx1bzGbtQ1tm0aA=;
        b=GBB8fA5Bus3JELeTiaj/fpHaviUUXAogRVRqHR9Ju8VfGVXwtkrQsAY5WjuyDpbX9I
         42yDeCtTggqNeacnZF+lOCCNUPgG60gCYhyjBtvjYdTronhdERopbdZ9nRP5K2Y42Mwz
         ZGbET2B9/Tm98JWwWhgCr9kz2WwRk49LUTR0pK0M6zE9b/M0mRZJkAeGR65nQqG+mCSu
         IimDcflAxkz8+zMO5fOkPGWNibwN1jn4DBub6bsGb+sS/9uIAwqu2kFRKxF/n9YJxROf
         HDBpHf62wIg1IFZf5WQtuymdVmbs4qtwnKjYh5zcA3dA6ehOBVJOWShL5o0HDGbV5rkY
         R+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695551; x=1706300351;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZcL5wFS2YZ9ArnfVnbXUSI+bxzKkx1bzGbtQ1tm0aA=;
        b=Yd7bnEHvf7FIAdvocLZo8yr/fW5ytv99ImJ3Ykdv3DlLZO5vcSc686gkNhN8cYfngC
         7V2kBAjaLkfubMwBkottPKLj7IYhe/YfTj9PN6uMbUO7YEZzXpcZBuSN6/J5Zd0H8ELh
         cgOdTb3+HLq08Rgq11Ej7Pmya/UdZ1yM/4nk2zwJg6Fq6tLlqPepxKDYk62ALmjmsXjy
         ulAz/vWHRn9MnYWeOjgiRoGSAFVk7XAJVNfi+ZczEKL9wL64F/3Smjl0tzDF5tJBLncr
         uVbIEyYsJ1CQhSODmOCSyoWQXD9HxUFJbh2OL2TsgxLCUOhOJEhDI2RNahDHu5wadMmj
         23Fg==
X-Gm-Message-State: AOJu0YzMY/zRK8GXTux5JosbgN/zpIImSKR4bMsxLFbqwPfSD2dK86Gx
	klqOCsGFnpDI4c28K4hyKxsyb9lNfNWHRFtRM06AKQJ3toQbud98R6yIce1R
X-Google-Smtp-Source: AGHT+IFkzinLKChfqsMUjI6VGiuW9lC/mM7Hm4pIUVx+3oiEnDqeJFNx7zbRVezLTEnSKI0CsI+g0g==
X-Received: by 2002:a05:600c:3217:b0:40e:5947:bcc7 with SMTP id r23-20020a05600c321700b0040e5947bcc7mr92775wmp.174.1705695551110;
        Fri, 19 Jan 2024 12:19:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5224000000b003374555d88esm7275240wra.56.2024.01.19.12.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:10 -0800 (PST)
Message-ID: <976be7efc89ae39194b06d12989c30f849854516.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:59 +0000
Subject: [PATCH v2 11/12] t4202: move reffiles specific tests to t0600
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
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move two tests into t0600 since they write loose reflog refs manually
and thus are specific to the reffiles backend.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 17 +++++++++++++++++
 t/t4202-log.sh              | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index a2ef34eab28..17ff60dde77 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -364,4 +364,21 @@ test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
        test_must_fail git rev-parse --verify broken
 '
 
+test_expect_success 'log diagnoses bogus HEAD hash' '
+	git init empty &&
+	test_when_finished "rm -rf empty" &&
+	echo 1234abcd >empty/.git/refs/heads/main &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_grep broken stderr
+'
+
+test_expect_success 'log diagnoses bogus HEAD symref' '
+	git init empty &&
+	test-tool -C empty ref-store main create-symref HEAD refs/heads/invalid.lock &&
+	test_must_fail git -C empty log 2>stderr &&
+	test_grep broken stderr &&
+	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
+	test_grep broken stderr
+'
+
 test_done
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index ddd205f98ab..60fe60d7610 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -2255,23 +2255,6 @@ test_expect_success 'log on empty repo fails' '
 	test_grep does.not.have.any.commits stderr
 '
 
-test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
-	git init empty &&
-	test_when_finished "rm -rf empty" &&
-	echo 1234abcd >empty/.git/refs/heads/main &&
-	test_must_fail git -C empty log 2>stderr &&
-	test_grep broken stderr
-'
-
-test_expect_success REFFILES 'log diagnoses bogus HEAD symref' '
-	git init empty &&
-	test-tool -C empty ref-store main create-symref HEAD refs/heads/invalid.lock &&
-	test_must_fail git -C empty log 2>stderr &&
-	test_grep broken stderr &&
-	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-	test_grep broken stderr
-'
-
 test_expect_success 'log does not default to HEAD when rev input is given' '
 	git log --branches=does-not-exist >actual &&
 	test_must_be_empty actual
-- 
gitgitgadget

