Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FD61B0115
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637534; cv=none; b=GHsk9luoLvE2Yy5A2QDBwhM2a3hGU1peiJescOOQt3f1r88EcEsAaiVtwSkGnoS3wI+c0lOD9AdCt3nc6CZ/EhG4Ot8AWb9T4Ph8zrtMjvXuMX7QNm+I5Mc5cCfpLyltxcNRTinWqJFyvviNYtlO2M07zEBlqh1Euxlwkpo8AeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637534; c=relaxed/simple;
	bh=ffiFLBpeTuxHH85vAR7Mtrt67fzWVtkw8vQccpRJkTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDXduaIjo8MQv/iZzuq/xLSqBACLK1xaE3we12o7znR4zv4wl22f7YkAu9KLGb0t3ulg+RHA3l+KBFY419HHB1ya7SAv8t+44Rm9PhbemvwxSzJmnOYlI0StY8nKgOZDRa9/LRB125a0HJ9XR3PKMGye7jFIxTww6nxsJmlqV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frTRK/B2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frTRK/B2"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-710cad5778fso5286456b3a.3
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637532; x=1724242332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+OMgJ1DTTaUsnbA54b3jnVl67k9qUgFGmxXetH5pNs=;
        b=frTRK/B2vG0xr6ip9z4SBwYFm9gszdEAdixoldTFdLtvAt8hsf5i4X0UYy+mlkfu7w
         WufWFnnqjY0tIaxlOWPrsYhH4zhu38KgjyUFOHyapM14MwPgmr+u24UT0Ya0lB6uhnN4
         kL2bdoiwjRFXxZOMXZi4bu3asB+fdQWTPEhfHFwk4IbOEG+nXs5lY2z1egbHpY+JOxjj
         W4YkR0vlWt3pSE7kVV/fCYoWlwg1qyXUxhc2Jbu7InVvgDSIs9nbmRHx9dugY2Fhzey+
         xQvvHDtQlqT5Xjvibw/7M5vKea/s/dot4et90Inb2h2jWmvVFxtuhQeqVfYZP70eoTUp
         sIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637532; x=1724242332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+OMgJ1DTTaUsnbA54b3jnVl67k9qUgFGmxXetH5pNs=;
        b=K9Zv3o2HdhXLLbZ29RiJbCcmQDWSqdynuEDweCyMj7Z2xr5jA5SrGLe513N61YW1TM
         8IgvGYlMvwwpP7Q6TwRnObeB/Ib32L5P4EPvdbKBZp9SCItMZo+wsDBBMFLXuMnDOpkg
         MP0cLh9oAWccVDQah9HM4cTKkZhds+AB7YBMvtW0L8Y1VFvETr1yaFxbLsQGWzb7bdpB
         anlXQvM9QBeFTem4XPuL2CzkNow61jsdSfAmvn4n+BC0g7Jfn2DCOAFDQ55l7kWMESmZ
         ZwvPWE/gc9NMHamq4bDO1qJhLjrxtncalos0Nc2/ml4rk6fRLVZlYXbGXoGTphTjsWfE
         ckrw==
X-Gm-Message-State: AOJu0YzvKXU2P0sxyg42zwRF90bohgX3NltEycJMS0P+DMr8Z/qb05db
	cBQj7G9ISWG1mKijFOMgH3hETsInNVCFxUNliXBYX8JhERx70Ps0HFxuriAjw/c=
X-Google-Smtp-Source: AGHT+IHYiBxmymtM1/lhUfFfCbwAIBufBiqWp99+egVlUls1FCQYArcD1508PwfoyeNKXPXa7Yn8xQ==
X-Received: by 2002:a05:6a00:2311:b0:710:da27:f176 with SMTP id d2e1a72fcca58-7126710224fmr3733598b3a.12.1723637531954;
        Wed, 14 Aug 2024 05:12:11 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:11 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/10] t-reftable-block: release used block reader
Date: Wed, 14 Aug 2024 17:33:10 +0530
Message-ID: <20240814121122.4642-3-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240814121122.4642-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
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
index 8ab3ff9ebe..31d179a50a 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -103,6 +103,7 @@ static void t_block_read_write(void)
 		block_iter_close(&it);
 	}
 
+	block_reader_release(&br);
 	reftable_record_release(&rec);
 	reftable_block_done(&br.block);
 	strbuf_release(&want);
-- 
2.45.GIT

