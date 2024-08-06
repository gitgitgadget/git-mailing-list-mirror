Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA118D65E
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954058; cv=none; b=XvCP2GHd0FxAUVnNGcS1KzGGEUgP9cNwvS2mbZGKv4FKGfnH98sFDP5GWMk/AwR6C/30F30dc0Yp+a82TKiMqawMUpZqFrXmAmI1cmRx5FpWlOT+EZc3ZyxpMfG7ZgFkf4sMwqbglrweTwPKx8NCARMZCU2nKwsSYykvAFf2dFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954058; c=relaxed/simple;
	bh=AIcfdS0pRXjOVTTSZqcYF+VA9gRPqYdOWqcmxSNPIAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SF8CxppiocYeUxVQ4bTMrSe1dzi4zhW+hbKpUwNDjbMa5AhX7yYO243FdPEfMG7zP73ONhUqcmedA4unWr9YYisWHA34f9Dq7c1sI66zTMetdB+PriINFCax0MMU1l8/xYeGgcCYUHG52ayYPtU84uSpfGbnD15WqOg3DzukI+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7yC8RIQ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7yC8RIQ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70d399da0b5so547359b3a.3
        for <git@vger.kernel.org>; Tue, 06 Aug 2024 07:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954056; x=1723558856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCFZpgV+5bGVbTzJf54eaZtTsW9DJYX8HyhNCTSMIlc=;
        b=N7yC8RIQ1hfFNdw8g0BGJETwwEOxyRoUDYEngVAkvrsmpXE+1OT1ORSBC2jqfy7xOV
         PLZPPsFZRMeiru34ZMLVqy/NzKIb+JLlep5kpsXoGFw/PD+YtH8AvJOvzw6vjNHKUWuh
         qCtc0/yrPkHF6SfuqhbW3g5App51VFB7JOCCKzerBB37NMzWil0Hsh9Mg0k7ppjSuMHM
         IxakEQI0jAoQx7AiKk4SFZyaluvZBiMsLNOUQbhNguS8mcvU4ZTFxIoMYRq0DlT4M/bS
         Jb8xWBWOc3W2ny4pBpZV2uzeMU1ZU44ZqV/ClXiTk7EtFcj2mwjv6gCLJKUGftmzi0/D
         Eqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954056; x=1723558856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZCFZpgV+5bGVbTzJf54eaZtTsW9DJYX8HyhNCTSMIlc=;
        b=bIexRdM/yKMFm1fB9DwSvovhVbveuGeXmlHQwKDXRhgtC4rhH0wV3gkqmpzAkJnYM7
         5nLD1IhmBuyJygszjLsQwcaudLM2VWDMkG8mgR1bL61tuorLkIAPhcnO0/ekga8z9Veu
         VthIzW8jOGc4B8rslx6awRJKzbD1ghMTYDveLfJ4FceKDFtCeScIEmN6p2ON51u1OR+L
         ELUN6XomQqihlTtqseMEArCfs73RkwfzXTkusJFPIRbBTQAmt96qWBeexMgLEc8q+mpY
         uR9IgbofBfT3UrI68nzZnSE9QzWtcZ7E1p9b/4YNkIrNkN0aC6BIKebG4nCZwzy28jYp
         1zuQ==
X-Gm-Message-State: AOJu0Ywu5jeLVsCAC0UKyTZJp+pp1YuZfBmw7+CKbNhf49UwjsJZyid9
	BHCrM3vGfa7HAkpigBWVPDcbqK7iadQipnZDbG7LPqXWvRQJAqMnLnTQwdY9vRVweQ==
X-Google-Smtp-Source: AGHT+IE3CspApNe6NDizG2Sd8A4N0D+bXIZafgJp/bbVTF4YDdBG/eNwhNMs/ImggAEE7LIrW3ljbA==
X-Received: by 2002:a05:6a00:1950:b0:70d:87e0:9e5 with SMTP id d2e1a72fcca58-7106cf9f90cmr17417100b3a.9.1722954055679;
        Tue, 06 Aug 2024 07:20:55 -0700 (PDT)
Received: from Ubuntu.. ([27.59.87.1])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7106ec416aasm7040563b3a.70.2024.08.06.07.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 07:20:55 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/6] t-reftable-stack: use reftable_ref_record_equal() to compare ref records
Date: Tue,  6 Aug 2024 19:43:40 +0530
Message-ID: <20240806142020.4615-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240806142020.4615-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
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

Replace the latter instances of ref-record comparison with the
former to maintain uniformity throughout the test file.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-stack.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 14909b127e..0c15e654e8 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -145,7 +145,7 @@ static void t_reftable_stack_add_one(void)
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 	check_int(st->readers_len, >, 0);
 
 	printf("testing print functionality:\n");
@@ -262,8 +262,7 @@ static void t_reftable_stack_transaction_api(void)
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
-	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
-- 
2.45.GIT

