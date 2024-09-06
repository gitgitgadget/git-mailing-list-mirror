Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517111CC155
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 11:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623112; cv=none; b=dM0ZtD1DjaiVtD5bXDqOWH6ToIwllLfpmlAXxFKRpIb8Hidj6kdoaWm5bNghvl2D/3ghTASrRoPtHckGh/OrfXu8H/ROh6RNFEcG9sL4MPffEWQOJbyIGhYLfFWx9lstYYTWS7YmFp92UKj13NvxgFwiQcsssjCeFILfA0BkyYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623112; c=relaxed/simple;
	bh=2U+WMvKHa+2d2IVhUXykqOVonsM0YnpV1uo35PWuBsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fmd5TtX04Hc/gyoiyiSEdlKcqXeM7DZ91ulcJ/kwaTTGLvqnLoe572B44B4jj4CFCG3eNC1ES5E0BzJzuso/0kAXJLQ+BeSHhvHeL8zn7FKoL/9aolxEL27Jw3ZhPKCo/GGZ4oVFhbdKJAxKoOP+o+Bjmb+l8EbIJXXNUfMbe9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a071Ayg2; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a071Ayg2"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2068acc8b98so17570765ad.3
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 04:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725623110; x=1726227910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVcZRrxptk9c3lqA9Btm7t2TmO4L6+yRtFB0PVVE5vM=;
        b=a071Ayg2ZL9sNXTL2sSCV0EMTjtfT2O/wR1MTHK5N8qG5E9fcrW0G1P6kIQJMEFHmN
         LjxixPv7FjQr9AcSeTHsfqTUI2qUBJsDYYuCP4vtD/tRG6gMnU9LuRRkaD0+vsRoH3Nm
         fYklwftiBteLLQb8iZvqrWktMP9t3CnwVHJrJL3QI8/d/rV7vQeHubFDmKEPeZIP2ikV
         FHSdV1PMSipUw9Mtv9/xxcl8jh3Z12lYbCYmnPaRG4yFnUofpbKMXVNsEbyEP+s7NpOQ
         uM9x++9qFgvgVMQaS7v6BWHfsS5JF+DK5C5Y14/tLBDuuzxodCyy55G44qICDhwKfw8x
         KVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725623110; x=1726227910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVcZRrxptk9c3lqA9Btm7t2TmO4L6+yRtFB0PVVE5vM=;
        b=OGzpBtjq/g0TLfV+QHW5NWOGGJMHFp61aiNVmjgP6sPq//1YL6ol/QYbXdYZhrDuIL
         Rth/qenqR6/uWhfwEz7AH2lEOBCrnJNWenAA+SvNqbnzRc8Z2kpaDYeJvNI9gSHgkYwN
         HoCuxsThHTjCb/ccttCI6drlnDgxz3MlpM1vuVhrp2kvYt/C6RkogPxqBpaL+FjF5F1c
         RC7g41U3y2Up2xv5JVFGM4SyVeuz08eygkVFLG3riIaRFVBP7kkAN0wkmiXCN8bDbl5B
         Zl6N89TUx859kLpxOUobSTsi7Jn19NTjb5+IuF1/Qy/SV4VqvenIROcaE28P6wFy31EA
         xgAg==
X-Gm-Message-State: AOJu0Yy/9MYfJ6Zm4UorGYTtMfMqTlt9bl254M+jJaEqVeB0aaPRBYqO
	YXCQPdEVYGjWxMjvHaohIOy24TDlcZ6iAPlTr22jL1C+ITaYmPJJ7VwG6k//
X-Google-Smtp-Source: AGHT+IETrl0y873NUtXjqnk8qIkJoaO4brfTfG4/23z0G/p8tYDYR9KjZKo5p6y0RsPD3T2xuXZrxw==
X-Received: by 2002:a17:902:ecce:b0:205:6552:1099 with SMTP id d9443c01a7336-20565521122mr204147745ad.8.1725623110180;
        Fri, 06 Sep 2024 04:45:10 -0700 (PDT)
Received: from Ubuntu.. ([106.221.74.130])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae91371bsm41903685ad.26.2024.09.06.04.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:45:09 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 4/7] t-reftable-stack: use reftable_ref_record_equal() to compare ref records
Date: Fri,  6 Sep 2024 16:59:13 +0530
Message-ID: <20240906113746.8903-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240906113746.8903-1-chandrapratap3519@gmail.com>
References: <20240904150132.11567-1-chandrapratap3519@gmail.com>
 <20240906113746.8903-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current stack tests, ref records are compared for equality
by sometimes using the dedicated function for ref-record comparison,
reftable_ref_record_equal(), and sometimes by explicity comparing
contents of the ref records.

The latter method is undesired because there can exist unequal ref
records with the some of the contents being equal. Replace the latter
instances of ref-record comparison with the former. This has the
added benefit of preserving uniformity throughout the test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 8047e25c48..4f2ef1a8cc 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -174,7 +174,7 @@ static void t_reftable_stack_add_one(void)
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 	check_int(st->readers_len, >, 0);
 
 #ifndef GIT_WINDOWS_NATIVE
@@ -285,7 +285,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
 	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
-- 
2.45.GIT

