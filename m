Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F96199935
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244153; cv=none; b=OA2ZbOMlBOyuQtRo+4FlGWvw4B2gaYYjx9yfrlQAnv2W0igGIySUqh1zhpu1+PkfSPGPRLrGS+eD88r23FIvt1+KtIiqfqMWhjWsFW9VBTe3SGHsMgBfj71rrgi+U6nTjaIP+jIRi2JPBIhloxYSlDfHefLdtyn9IpOmgeX4AVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244153; c=relaxed/simple;
	bh=aWca99CbvjawBPMs86vKGxOb+c2Z8Fsf3MkweJ9hQAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkDvYIYqJbDkOla6l9Y0b60FGILjNxq5OY1AijOK9xTSvvd8Nc0m6YgTPW/9OX9z1DMS1FLq/R+vno3TlKeRrcjLKUQXJO6Ev4U1nNthM/h9SogU3ZfRyNuiWCO+5TjflEhRpWasP29ktBe2SRiGiUQZZZWkkqc9lqvGh5qZtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwjHGZmT; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwjHGZmT"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2d3ce556df9so4165060a91.0
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244150; x=1724848950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2oZiqewD+NWCsYSxzcctnFWWSaZ1IPuB/5e1X8qvfA=;
        b=UwjHGZmTjaXnveRPwRsDAgGs5sUFT0yZwW43wsCZ/9MMXmsQuBht0Pwh8IkoXo/Ua0
         IqPEFe/zFrNmvH8IGvaFl6F80EXSFiuTm0TeQqY0ICo7QndiTlhYowmedpPLBIm/comZ
         Cf8c9j180fQdfh+VXnE/eRGROYLd9486jZvfbVRec3OGF9nvh7DJ0HN/DEfaUbxgWXoN
         ixBIigWB0JagwswPbe/zsu/UEcYMpnf3351w3lAJloDYcYATxTLx5NGpFt7cwR2+dkCr
         0G2rmydpdDfUc52HtH2MatbUiC875mlRVNJ8tLfpSISVuxT0anLh4nwgZareA9hb5tPo
         oCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244150; x=1724848950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2oZiqewD+NWCsYSxzcctnFWWSaZ1IPuB/5e1X8qvfA=;
        b=gLdPhkw7YP7rAtJFC7Eb1k0bf/yAS7lkhdfBBZ08wvk9clz0EsQX17DaalXwcaofZ+
         eEmVL7A7Nz5W8hwV+x33QwbMrmD7uiIeI7rXjLNx/0+UdVL/9T9rTncRC8D7iY4Ggk3i
         16Ind8HU8+acUzoYtWjv5IKFXjlkEDoiJFiQk46KFD9KZKTklKCSp6tSKvkw2S9yyrmF
         VgACcDRUKKl4fDHPi7piZryafbBmIShaWrwWpkeM5NFr1suwiDi7O6vBeJZMIqqrw75W
         leCC2Ug0eRpkuwMo4RIj5nYICxuqE+fhuZYR5lAPRSzYSqhIVPV6aHEJCNu+Rvw+zEF/
         cJiw==
X-Gm-Message-State: AOJu0Yz1d+MGwq4LLDMTGSsXgvPfSCYeMFQBVwFWdqidscpt3h1zy0GE
	Pt046b3jkZ8gmOyA4os3T6SKWyqpwx0+pfwEfzhqHrkGMLDCMfV/DXr67mQ+
X-Google-Smtp-Source: AGHT+IHmPEQZ5c4yG8N4ccAdrChHLcSr84yHn+eeHmQmzpp0AVKXzZ12rE1eu1Y4FaRebRYN8rHtMA==
X-Received: by 2002:a17:90a:c210:b0:2d1:b36c:6bc1 with SMTP id 98e67ed59e1d1-2d5e99e0d08mr2057365a91.2.1724244149603;
        Wed, 21 Aug 2024 05:42:29 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:29 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 05/11] t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
Date: Wed, 21 Aug 2024 18:00:55 +0530
Message-ID: <20240821124150.4463-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240821124150.4463-1-chandrapratap3519@gmail.com>
References: <20240816175414.5169-1-chandrapratap3519@gmail.com>
 <20240821124150.4463-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the current testing setup, the record key required for many block
iterator functions is manually stored in a strbuf struct and then
passed to these functions. This is not ideal when there exists a
dedicated function to encode a record's key into a strbuf, namely
reftable_record_key(). Use this function instead of manual encoding.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index b106d3c1e4..5887e9205d 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -83,8 +83,7 @@ static void t_block_read_write(void)
 
 	for (i = 0; i < N; i++) {
 		struct block_iter it = BLOCK_ITER_INIT;
-		strbuf_reset(&want);
-		strbuf_addstr(&want, recs[i].u.ref.refname);
+		reftable_record_key(&recs[i], &want);
 
 		ret = block_iter_seek_key(&it, &br, &want);
 		check_int(ret, ==, 0);
-- 
2.45.GIT

