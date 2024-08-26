Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651D1990CD
	for <git@vger.kernel.org>; Mon, 26 Aug 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693835; cv=none; b=iT+M2BZoJySM5ZsH/Y8F8mZ7FrXHU4AeqiMEfo5jc3GpK3jc6r29fsgoRg+UMqESuY9FT3q/97ATnLhN6KqSH0SIXm5vbskaiSCt35jrV9H+pGDhHQVnAybA8VY/gLSJZYqqbsZkNO8JIC3yo3xitkjCigBG0ZD2dg+SXvvqeh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693835; c=relaxed/simple;
	bh=sJ0VRYRsLodHWSLlqAz+pI4KocJX3VDyz8I3NvYooBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JD8BYmq9hrB1DJiuD0Vn6zVHWzcDSogRWrBp+E9WbDuSZrhLx0n6dgz459tF9uhwD5WBEBu3qXXjjVMTXNr0Rl5Kg9Jy9ZjRCyxjBrzOD93g+AqRIkUX53VCH6F3ASiMZcFCtgvNcTbp42PBdrGwTr3GgwcnWKYCimh9L7EBh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aZTh9yEC; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZTh9yEC"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39d34be8ca2so15261955ab.3
        for <git@vger.kernel.org>; Mon, 26 Aug 2024 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724693832; x=1725298632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ay0rvFNOxyfWnPotrmwILeHZOojUSwYE49paGRiLrm8=;
        b=aZTh9yECUNqifw8rfSi63fzmWnfwmwt4tNGfo85/UGhnuri9avXNzYTqH2IMmBm5ge
         AK6WLLEKx1ourGQYbO8Fxe8Mrj3eqDBF7P98MZGbxt227KelPE+AkIfwSIqx2NomKs28
         hqL3xAFxoOOW2/JwUtlVwwsqnt4UIdwvExL6UXLWGXAR4m4lGUGBSLnduqFMBz6dsayg
         8FUkvyBYPljuDbEAFRsuJnaCzZoZRtZxPtpaSFC2w0SxdDF3hHS67xUEXp5ifoVUP891
         ogcVR/bTfL0I2KCHoE4wsem2guG68fD+6neMY6wKQ6Z3GOPfpO/ArzkqGEp6gxi/F8DF
         unGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724693832; x=1725298632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ay0rvFNOxyfWnPotrmwILeHZOojUSwYE49paGRiLrm8=;
        b=oAfwLqzaOgtm2mrX18REGw+bzHn/Y1wpbymf0yQXirBgn3BYy9bRja/5bPMbMkHrPm
         SG5KgBF1kSR7imv0lB8N6XDzXwp4Qv+RecGjBq5DXiau3edf4qWNlQf8DAqxID9g2HPZ
         iTwkqdIjGX8fULNtIPbQJLYvbwux1hYFYwsVfHb6NfAonzc46mvkLwOsHTPoELD/lHQg
         SIBRb8ZjJJFNxpT7Yg9v3PnA+ZQTosMpzFxI5ghhsIEur0Kf+a06rJi+zUh0uBe+5RBY
         14wDSdLj86mGo8QzC2Pn62zNNF5+hMwvyupje/AwTlBFeToQLjPLAShFbzJW/XkR1SFC
         0Y+w==
X-Gm-Message-State: AOJu0Yx3AFROYHdICEA2FHle3Y6WRQYGwqqb6iuVkmOQllvwsqK9xSKf
	8xXV9ca5XfLkceB5YJaUGFdY9tHqcTqvimRVROsxG6KcpaASqpMCADpcakam
X-Google-Smtp-Source: AGHT+IEVXyE+1HnopvxvTwghmI6nNZmhj3aH4I9QH6sfdyAz3sKNBHUizvb/mhPCIF50hLqDCI1xJQ==
X-Received: by 2002:a05:6e02:b2c:b0:397:2dcd:80e5 with SMTP id e9e14a558f8ab-39e3c9ee72cmr100840065ab.27.1724693832308;
        Mon, 26 Aug 2024 10:37:12 -0700 (PDT)
Received: from Ubuntu.. ([106.216.108.198])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7cd9acdd9casm7997999a12.53.2024.08.26.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 10:37:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 4/6] t-reftable-stack: use reftable_ref_record_equal() to compare ref records
Date: Mon, 26 Aug 2024 22:59:44 +0530
Message-ID: <20240826173627.4525-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240826173627.4525-1-chandrapratap3519@gmail.com>
References: <20240823120514.11070-1-chandrapratap3519@gmail.com>
 <20240826173627.4525-1-chandrapratap3519@gmail.com>
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
 t/unit-tests/t-reftable-stack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-stack.c b/t/unit-tests/t-reftable-stack.c
index 5cb79ad8fd..4c694329e8 100644
--- a/t/unit-tests/t-reftable-stack.c
+++ b/t/unit-tests/t-reftable-stack.c
@@ -173,7 +173,7 @@ static void t_reftable_stack_add_one(void)
 
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 	check_int(st->readers_len, >, 0);
 
 	printf("testing print functionality:\n");
@@ -291,7 +291,7 @@ static void t_reftable_stack_transaction_api(void)
 	err = reftable_stack_read_ref(st, ref.refname, &dest);
 	check(!err);
 	check_int(REFTABLE_REF_SYMREF, ==, dest.value_type);
-	check_str("master", dest.value.symref);
+	check(reftable_ref_record_equal(&ref, &dest, GIT_SHA1_RAWSZ));
 
 	reftable_ref_record_release(&dest);
 	reftable_stack_destroy(st);
-- 
2.45.GIT

