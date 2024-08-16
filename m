Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E403D1C2326
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830909; cv=none; b=a/HtXsXoXbaRagBur3VVPQvbBT+c0UJPImpEJPIoUsrSdydPYE014QtIfaIg1cGP9dMBu3BlI/TthcjCiSNUXDyJg3PM5Hgr3hJzZCLjTi1Nn6e3/Cr3gbKcX0vAeARGQPNMGYshdzYO8EhGhwKT6gnuUWqA2SPCuAAZGbibSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830909; c=relaxed/simple;
	bh=aWca99CbvjawBPMs86vKGxOb+c2Z8Fsf3MkweJ9hQAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMJ4kOhw/bMj1VGviQV7/QCqvNtD0suNWVQPFPAcCiBpPjVpRZuR1ivyKz204MJj+8yjM2LqYaFiukysShSJV0xFKSbMp4W9w2HYnUjA49OPjSmhEGMz4cbVbTJPu6RzwbWgR0Q9R+Yfph94Q3/tFWBHV+hczcTGZmOnAe6vH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjBBwL47; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjBBwL47"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-70f5ef740b7so2031955b3a.2
        for <git@vger.kernel.org>; Fri, 16 Aug 2024 10:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723830907; x=1724435707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2oZiqewD+NWCsYSxzcctnFWWSaZ1IPuB/5e1X8qvfA=;
        b=GjBBwL470yZu1uKtfrq++V12YgqpLs4bVx0IH0LMYkhAhP8Nza6XAsXT1daJS+Rw2i
         jkScqCBl7wEAoc2petwKwIandygRfOStL7yba+KyF/1+7lt4QzIW/BHF86LjO0Jl9Eh2
         LCaGaqrQNvGtnyNk83x+jv4m9ZsgaSwEHdvwB+zZhJH09PUGLTeJ8scJQ7RVejN7M3Ee
         8+GRKmtJxeOayTgBzrWEjuxGTsjYCrUI+gUZ9b9kGyYrLsi07+dXfU7fk0kpuwm0rH4B
         nyptvI9byPxzfQNPhmtu1atXEe3HNSkJS3qeg+woh/fX7GnP6uP2oCq/rkwi/TTNzZpv
         /m4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723830907; x=1724435707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2oZiqewD+NWCsYSxzcctnFWWSaZ1IPuB/5e1X8qvfA=;
        b=bISAo0zJftmnHSF+FxPgx5dYb6CnDdEd7uWtAS92X6oaSg6SzveBn0FvmyK0Ba4Eox
         DbRKFKZZ39JxSlVCM0VKST3Iqfw2atLVIdFbZCDVQzRDlwMaVKvjF7ZF6cfPsP+fSKib
         M7WvSDPav09YP3PIV6hYP2p4KjMh7QTlQiQ2IcfAjV2lh/Q27V/Y9e3vK2jnnoE6RVu1
         VipQurQzRpNurwjJYhob1akTfaDTCMf64jEyqEjSlOTys+d7C+TQpsikA/fVoWOV3Adu
         l0/vE5ZWOXJbwGGVXSrihQ4bhwRTAFHH2NoeuwaoPFhfTB0Mf02FBQI6v+i1yJs6/W2p
         isHA==
X-Gm-Message-State: AOJu0Yw7T+tbLPZsEbNX34nCxtS93U3NPkv2MeGDAIQC1U0Va4hd8Fo9
	+1fPnYVNvjvyjjo92gq51YSB8uHGnOmgW9a+JPX/N/PoyO2xMRzTNGBTTQ==
X-Google-Smtp-Source: AGHT+IEMvRrJ2Y/MR6p1+T8xGVKcBWIYK441ynS43P6OPDvZZgZVqNU4DMO9uyMHPEOxcVyso7M9tQ==
X-Received: by 2002:a05:6a00:66dc:b0:704:2f65:4996 with SMTP id d2e1a72fcca58-713c4e2a5e9mr4415468b3a.11.1723830906609;
        Fri, 16 Aug 2024 10:55:06 -0700 (PDT)
Received: from Ubuntu.. ([117.99.60.209])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7127af1e907sm2985600b3a.173.2024.08.16.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 10:55:05 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 05/11] t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
Date: Fri, 16 Aug 2024 22:55:28 +0530
Message-ID: <20240816175414.5169-6-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240816175414.5169-1-chandrapratap3519@gmail.com>
References: <20240814121122.4642-1-chandrapratap3519@gmail.com>
 <20240816175414.5169-1-chandrapratap3519@gmail.com>
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

