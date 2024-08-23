Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5C0185B4B
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 12:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724414768; cv=none; b=EAKDqWYB+kYBQoCc38jIQiWAr917Qz57MwulwwMyRr2oKfxnguR7oRVgu33Xfv3Zj64sah5nBQvzK13lqBZtJKaGG7dLxrvdNQiLD7cYvabTIBV48n+xQkTdPN4uk7n3wh1QbjgitW15+j1gZzcDF+gQi55xibDZTD8roihKsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724414768; c=relaxed/simple;
	bh=ymOFRTchUIsvowXtT9KqcTMAhcw/Zgji+GnLroLOXXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idjJ0iBK+djRd09x6C8fczPx7EdVeoyzw0vLjjQ8Ueq6umT0vMI0r5QJ7/sUcFrA7z3jNcCq2irEb+PVeqRl7G14vSPDg8Eses8yVL690qpZEVafV2ZQ0vMK+1ZU28eMOXS5+eeKlurTMtQfH51cBYZJuolIQpYzGyIfDv2Btd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJUD3QuL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJUD3QuL"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-201fbd0d7c2so17455595ad.0
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724414766; x=1725019566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPhdjTV0RBndXHafzhCVZVbKtPFjw0YgL4He2pYCgQI=;
        b=JJUD3QuLW7N4g3mPT6TxLpsnS0y/Erf+sGe7jRNpLglfdZNae+4okOJCOCmIR4e/oj
         tAirsbZv2LBwKLEvekJXTTRpjH9z6xfC15X2J/zREtZierO6J+tXNyqPNr8lmdLlsbbs
         1zOQuTkx32voG5OwbXm6rX2GkF+0fBRU/k4G8FzQyjstmEJldTGZIIJymNgveFXhKhql
         WgckeQwhQxl4ApMKnBCu2bW9agaCeETjrzHFYmB5PgT2/eTYMsMZY4PwcpnHhuirhHcs
         svqSUmoMaDEY88pycemjN8BZpPnUedc9mTmNvDmcE4M43yScFykbMEWtUAl2wwJx9WCL
         LwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724414766; x=1725019566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPhdjTV0RBndXHafzhCVZVbKtPFjw0YgL4He2pYCgQI=;
        b=mpF2hk/fUoF57hYHD7KrrEa3x3f9+d5TukLZ2rSENYaehY3Zrn3y+1mIIfilYa/IiI
         wv5JB5i83ts6qsJU8h8mw1SD1WqAfcPLffa/RZh0oaEGCI0kTiaQ+oKPcqC8T0bcu6qS
         6qX9ga77dZv3/HMU5AaqmFP5YBf11EWyCAry/RYOiA2DAAm5hAVCcBWvFMzy/R+IgQ2i
         sF1GAIOuCV7g8J2nHR62MGYayCYLhOn88dd6RwV3rdOSqH8+lQ/L8K4lnu+ANSyMy6X8
         jRyA7lWaiVgUiAwCkWnrTAN9p/1sK7dC4nxqFMvlonCfGqqgsASpmCOeJm5yFTNhFSZP
         +/2w==
X-Gm-Message-State: AOJu0YxhhU8Bes4dYP6CfoEUXcKWoDqi3OUhkF9QN1logRvqEreHs1Sn
	tIVLS+8M/JnxcqHMgbgR0qN9rZSRcGsiStz3ejs25XF7HegF4TEJgZrTCg==
X-Google-Smtp-Source: AGHT+IG68MgpRyantru678/g5Il/Hk1s02vkTQNs5LvLSkDNWy0mF76bIxNLMdiMHhqR+dQTN85foA==
X-Received: by 2002:a17:902:e8d2:b0:202:27ba:3639 with SMTP id d9443c01a7336-2039e4bd532mr17426185ad.10.1724414766210;
        Fri, 23 Aug 2024 05:06:06 -0700 (PDT)
Received: from Ubuntu.. ([27.59.94.77])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-203855ddb10sm27171925ad.177.2024.08.23.05.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:06:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 4/6] t-reftable-stack: use reftable_ref_record_equal() to compare ref records
Date: Fri, 23 Aug 2024 17:18:49 +0530
Message-ID: <20240823120514.11070-5-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240823120514.11070-1-chandrapratap3519@gmail.com>
References: <20240806142020.4615-1-chandrapratap3519@gmail.com>
 <20240823120514.11070-1-chandrapratap3519@gmail.com>
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
index 917d059fca..7c76aa67fb 100644
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

