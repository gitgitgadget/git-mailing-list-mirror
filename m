Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB314A4ED
	for <git@vger.kernel.org>; Tue,  2 Jul 2024 07:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906608; cv=none; b=Hblyb1hCks6oXgNJr1G4nAoiZDS84QiInC4P4OmMuBpRtoJotpvZ7rEa85BdFMbX3InavMQqy+ST6gFBpauJFPr6WSG+Z3pn4FwWdiGW/ms16hc4Q3/OyUltLw3aVn+bkTAhxjNehu0RoUV0KeDP4BVFIEHXxGk+sTnf5Y+ozfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906608; c=relaxed/simple;
	bh=iv+3fFdtLIdU+4u6UlJ5P3cnS7lOA4o9C5D2O6OyAHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHAI3mCi+bxdblBn6ve0UhiVNTft0l9XQz8e7PHMrB+D0c0tPM5TBxtPBSN7Zmt5QC+n7vKwtKyzMb72Vz5zbMRtamDTwRMtCBODeTtuqn9UGA1MCmMz9X/5bMiwuceu6vNykrWc4xnu7t5lCtT1p3t2klLlZPYinnwb7NpHGZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M14zifMC; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M14zifMC"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d5666a4860so2277960b6e.2
        for <git@vger.kernel.org>; Tue, 02 Jul 2024 00:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719906605; x=1720511405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F72auR7oyKgzk8C5heFV/L/7fLzB79XOdeFqoq/Kf0g=;
        b=M14zifMCcE8+4p9DM8TXXNKQCI3Gr3lwyU4fLkwWB0ii+t6FaNau0SFI87MQfqZ8T3
         wMttfthN9GXMDGxig1Ih9/KbrqH1P3mje8rEWMj0bVVWifrcUo6KpHeAXjCHJLK6zLRU
         zBvQMLgwmDAQ3TDaCmO+zVLV2yNKIBwA9C+83SbeGNsQoMIIgHoF/HOlee3W8qth8ZVq
         zE+77hJvC1b7XOLHi8JvaQdYUc/fGYZl1s3Jsx8aWr0GxDUDK3Me23ZW0x53p8W6CgK7
         tlbsKs32PZQWhWZ0gcq3W3UvUJbcylzTTbMN0Ffo9n2m7h/pUgTVwNt4RDf6NI963dVf
         tdqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719906605; x=1720511405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F72auR7oyKgzk8C5heFV/L/7fLzB79XOdeFqoq/Kf0g=;
        b=fm3EXIh9dRaE5wU0PQLhYxPN47Mz9snHWhAELZxYSlWR+TIyrUmpbcMDZ/KmHSD8Gq
         vzgVtsHmM3nsBtk6O+kJy2ooDfeQF2+zXuHP5yzeSF0r147/Wc0PyLnm8pBMEEgh2cTm
         rQkYAAmUo+a1sLibARTPHLz7GjUGOKKiS/uhil+nYhHUiXrnVjXIpB4lO1HG4+3Z5BTf
         /d9RG6fdQn5LsBAuF019UMYCXwswdqF+V9SLQG++O7tOiVT2gfuZKrB8knu6tWUACAqh
         u3OPaEjYiaYr8jet4aL4eqC29mVcQZuL6BTnz9po4iyk3hhgopSET+NddrmkNH6/T3nC
         223g==
X-Gm-Message-State: AOJu0YxkY65ZHcys5e6rX0e3h0Tb+Y4QFteVb2xxCk0cVE4KczN0lzHA
	DwEsQrTWcsNNN1HOOz23BgPhLAcO/9h2cTRK6B58pH1z5sx+W0I7uJhXVyIvay4=
X-Google-Smtp-Source: AGHT+IFlE65zoQGihcxPLX6rtiEgKMCQXjonLhKPKrCGaK6mlWfURyR1nGoVrPlWvhpmgyR4LLuuuA==
X-Received: by 2002:a05:6808:308f:b0:3d2:24d3:80f3 with SMTP id 5614622812f47-3d6b4de2410mr10626182b6e.43.1719906605477;
        Tue, 02 Jul 2024 00:50:05 -0700 (PDT)
Received: from Ubuntu.. ([106.206.197.80])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-708044ac424sm7772626b3a.161.2024.07.02.00.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 00:50:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 07/11] t-reftable-record: add log tests for reftable_record_is_deletion()
Date: Tue,  2 Jul 2024 12:52:20 +0530
Message-ID: <20240702074906.5587-8-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240702074906.5587-1-chandrapratap3519@gmail.com>
References: <20240628063625.4092-1-chandrapratap3519@gmail.com>
 <20240702074906.5587-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reftable_record_is_deletion() is a function defined in
reftable/record.{c, h} that determines whether a record is of
type deletion or not. In the current testing setup, this function
is left untested for three of the four record types (log, obj, index).

Add tests for this function in the case of log records.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index 170c804825..6ece76e416 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -220,6 +220,10 @@ static void t_reftable_log_record_roundtrip(void)
 	set_hash(in[2].value.update.new_hash, 3);
 	set_hash(in[2].value.update.old_hash, 4);
 
+	check(!reftable_log_record_is_deletion(&in[0]));
+	check(reftable_log_record_is_deletion(&in[1]));
+	check(!reftable_log_record_is_deletion(&in[2]));
+
 	for (size_t i = 0; i < ARRAY_SIZE(in); i++) {
 		struct reftable_record rec = { .type = BLOCK_TYPE_LOG };
 		struct strbuf key = STRBUF_INIT;
-- 
2.45.2.404.g9eaef5822c

