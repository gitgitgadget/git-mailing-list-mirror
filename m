Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548884D599
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 04:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725769100; cv=none; b=t7wtVVfm37KE2sY1ahoAqX2kxdZWkvQWA47w1Cjcf+zHZwyzQtKZyCgW1icOpPZfBj60Hqr2gIIks9XQ+Ft3AFNjKOCsvBONQ0PuDv+i4ai+uC26ajNIDW/SBVQ1y6KarNC6qfdEoNq4gdsbJSp5ukSpstTytOavXICKPZcW4UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725769100; c=relaxed/simple;
	bh=2U+WMvKHa+2d2IVhUXykqOVonsM0YnpV1uo35PWuBsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Etc03Dyt4JxWas6kmlPR7fAgbiMcNUy9svuaeFAHPv6XAOnsLJchue3I99lCAHmhleOx2woYk+om23hVY3zCp7Chp0kLqTczFfn5Tdd+Ffg9ekRfXcxpOV0cOJchBzInMs4NmGGawntGKn4GrfcvjUXE2C5rCROq6+NuI7GuzsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0Lx6Pz5; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Lx6Pz5"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e1c49f9b9aso284231eaf.2
        for <git@vger.kernel.org>; Sat, 07 Sep 2024 21:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725769098; x=1726373898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVcZRrxptk9c3lqA9Btm7t2TmO4L6+yRtFB0PVVE5vM=;
        b=E0Lx6Pz5G5Mylg6WENK8yI37g9An8UmidYeZOb+rjKCtsElG/a9imydt5F7YrfFYQE
         aUX02O7mBy+xQ5dmJ5lW0o541utQDcw++nZo6GJiiEsRURy/jQ+iSTiVCyvXidR4zJr0
         GmfbfMbCoTNHCIYFXamc2IipUiNN9q6p+yocHALA+mYtjelat+kXKmQ2oUeboJeYGadJ
         MpqPhPuhtUT9awTsggG6RleztFvBGCKCASZFWVCZ2DQqgRu40lp8jq1TshbWeK3JWsJR
         1WVB7QwvMdNo01zVggNsok5kM6eidZj3WRE4rYSYHjq5kaM5KiStCdXPd9XArBkTk3c2
         b43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725769098; x=1726373898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVcZRrxptk9c3lqA9Btm7t2TmO4L6+yRtFB0PVVE5vM=;
        b=xAra1+zlRgKkz5CL4RifLP3JhQvbnkOG7J87m2TOL/sxrTY+HAxo+VjEUwohW70wjn
         rKsvFduYCka5gPdXewiKnUEMAyIYe5yTw8/vWFxPsB7+rm7dt1AJHxEyhzdyHXH82Eg5
         8BEJ6QSnGzqH399XZV5HmruuGyMuPgpFYmt8Vm+v/0bBg2eRLgf+X0Ui7CwXwK67lE7u
         qgZeCEAEUjD3qHJaIcNR25cnHSRaCvJl4/LiuldArCx3XGM6Iz909n6J7VILzPPPGnR2
         u37OB1Kua9kY8Mw0QobXg18V2mRud1QBRBQqQQhIOC82Kr7UUZvbQ/RnxXPOZG2JK+lE
         FJKw==
X-Gm-Message-State: AOJu0YygEIJKTlLF7j9r6cTe0yuYady4+SJbY7QExZwOWKzSgqcJD/q+
	24m0n5tHWVbpXnHqQPJ9m0Q3aQOSuVzaa+yuOvjZZYDCD8a680aPGe0g58G/rmw=
X-Google-Smtp-Source: AGHT+IG+gg3NWGlw+S4klxAVtsxrsZupFcFBLrTBb7PYME4AOUxRMmahiRi7saFqQvFbcc4KI6bBGw==
X-Received: by 2002:a05:6358:52ca:b0:1ad:282:ab1f with SMTP id e5c5f4694b2df-1b8385e645emr982829555d.7.1725769097647;
        Sat, 07 Sep 2024 21:18:17 -0700 (PDT)
Received: from Ubuntu.. ([27.59.86.31])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-718e596883csm1533253b3a.121.2024.09.07.21.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 21:18:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 4/6] t-reftable-stack: use reftable_ref_record_equal() to compare ref records
Date: Sun,  8 Sep 2024 09:35:59 +0530
Message-ID: <20240908041632.4948-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240908041632.4948-1-chandrapratap3519@gmail.com>
References: <20240906113746.8903-1-chandrapratap3519@gmail.com>
 <20240908041632.4948-1-chandrapratap3519@gmail.com>
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

