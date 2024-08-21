Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED5F192D80
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244146; cv=none; b=LV6T1TPG8eHrs/yN0TBonvbsCNJrXBccmPaGAt63kVzp+08pAuph1A4qflDuu+1o9C38JcBGRq57vJxZ92M/MkMtx31Gu+A2W682UXq6aWNZCC0jfW9D1i73bSTZKsOQQlKaxXMlAB9EY1/H5ETjDp66PWzdKL1N5OdmIX3eLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244146; c=relaxed/simple;
	bh=kuNMT+Mz/B48UOGZINSIcyE+FXrNDfjXrncrh0vdxZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbXLmv9fs5VvVlmHCp3PWEHpKMR12ypHD7ntcrALsC+1XW4YICtpnKmk0ZexMsWUnG+nA/lK4yljd4eInbF8mEucJt6017gCEBGuMkl7XiII/gsJr6yquLZPuStzBmJukBC8Ej5+/WZmN7O03oQzAc6kHNw+9jfxlBR4a0fvhXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtgDDedL; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtgDDedL"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7bb75419123so4443769a12.3
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 05:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724244144; x=1724848944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIhWqQC8cOCl9rCuLpzbSL3YED3IjToOqwNVrWzcNB4=;
        b=dtgDDedLevhNLU+AekEBzdCGCZLoD4a/XqLSgWSNfq67XxKQHYBGIw2VE92Kptx8PO
         ihQJuWvo1IdbdGGKiExnaUeBG6YShvJnCkFnXgsqosylnFmKAIUZ/KTrqjnswZwaY4tL
         RIiuIv9jszt4+59LmSAPAt9I6OQATpo//wHOuyXvxe7iAdxiP1kaWkMdKuINvgEubhQC
         XOtOjTWHARJKkVNxwME29J8FGKjTRvNpy4nFTq4PNjlAq0DAeDzq0NDBKl7jCcQjx+XI
         ZxTkKO1Q/FlMBZz8MtihQh/d3jxHcHOqWkAwzSsw+rlxTmuHLGdZc2DsvlkVWJ9suvdV
         9dDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244144; x=1724848944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yIhWqQC8cOCl9rCuLpzbSL3YED3IjToOqwNVrWzcNB4=;
        b=L5ufggSi11Vj19bC14TCrkQFM2gp0OP1HQopzipBymzMs/0d4OnxDoSk+svQvpJVzp
         ILf6gPlhzJyYwbr1VGF6UGY1KUd5+fc9VCpaRXlGD6ivGviZCyfXfzqWK8vsCNL1Ndhl
         4U4rGq45FX0IQISIqs1qrXqPBqoBgVN9pdRwd2kKPSbL+o9ALAc4hSawhRnjPlmF+GJQ
         aYduKPo0xPfPmLR5GWIBONuuB3NgZbQfRjspC2e8qSDLkDXVj1b9yQEBf1ls3URHBgmv
         lsYcfeNruNjHkex9f9Oh4dZqlGDJY4yiCZSAU3nhrR2F9uoEiQqytFdyeO8CAEcMZmGv
         fIhQ==
X-Gm-Message-State: AOJu0Yw5nCBZYyxJrTiA+vLFZji1Yo0Pqj8Q+m+22205QWf3oPskGopu
	KJnBfuyRRPZgmIEtWrlaFmykhfrPv7MeOoB2EHF3QNFQewJnJOheu4BuExNC
X-Google-Smtp-Source: AGHT+IF2Czw/wV9fEvArBhzgUGIT5VlxmGNwIwFUn1cjiqyxCBLfub6bGKjTihI4goz5m5ZCyGKBkQ==
X-Received: by 2002:a17:90b:282:b0:2d3:b1d1:b63a with SMTP id 98e67ed59e1d1-2d5e9a2ae04mr2460306a91.22.1724244143780;
        Wed, 21 Aug 2024 05:42:23 -0700 (PDT)
Received: from Ubuntu.. ([27.59.95.0])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d5ebba8853sm1670963a91.56.2024.08.21.05.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:42:23 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/11] t-reftable-block: release used block reader
Date: Wed, 21 Aug 2024 18:00:53 +0530
Message-ID: <20240821124150.4463-4-chandrapratap3519@gmail.com>
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

Used block readers must be released using block_reader_release() to
prevent the occurence of a memory leak. Make test_block_read_write()
conform to this statement.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-block.c b/t/unit-tests/t-reftable-block.c
index b1b238ac2a..eafe1fdee9 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -105,6 +105,7 @@ static void t_block_read_write(void)
 		block_iter_close(&it);
 	}
 
+	block_reader_release(&br);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-- 
2.45.GIT

