Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BB1B141B
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723637540; cv=none; b=V1f8qZJYyDv0uCkK1VmRTn16ymgWraBwiz6BQaSnE0ziL8KTt3FBmECsy2wyjFwIHGUnrIzNi+pNWmaFRS9vBIS4LQfPhJR+mnB4SUfTlKoGh8Ci35CuoE9M2P4LPSzo2rRWX83dKs9p1R9O5PHMy+H1l2IfuUC55rYlT8S88+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723637540; c=relaxed/simple;
	bh=y8QWuzeMWkgAWO7Y0RUnKScNW38Ug9IKuBAyw556y3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhrcFxubHRx4PsCUNlS1pOdVNpyMBWB4XARALp0zpeNWe3XmcjYtsYBTE90bh44GX7GekTlPpi+NZts96HErDRJbTX3q37ixgImqEk0oTa2mBmXTOP/gaxeboo4LwW9iEFJgHBojJZhHwrY8qJDnOruw1w6yjQeHq9yVGFgOslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BY2YvrFM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BY2YvrFM"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-712603f7ba5so1260278b3a.3
        for <git@vger.kernel.org>; Wed, 14 Aug 2024 05:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723637538; x=1724242338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+c1XQHel+XDlSH4E90quDkE0tj80881AMnfI2bc++Y=;
        b=BY2YvrFMWx4ds8WmoJO2iOtqXQXtLW9nG+LUA2e7yz85mGw/6MkY+bnkGmDGPVyPuO
         2ZNK5SWB8LQzxJNxLwDuK5PO2HLJiT8mRmdwxwLtLZ98eFRwJHKEbvIVAsjMuSPv+l7w
         skkm/LpjtM3K+OlAzTlNT6D/5usYHWZptadi5MOC7UPyvKb4TSrpdGdI4XhsYnfCM/lP
         WpRBRvmBDE+AYZsvlST2Qtqi+BSfrViHlO1BNwmEENcNYLbNVLQj6iCqC4g8fHi5xwau
         JtMEnRxu4C77ltZoBNi9z/KwerO0w9Y2gXtP2LpuA/KpdZxwwDrcxm6cKbbvhh1WPyDY
         bIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723637538; x=1724242338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+c1XQHel+XDlSH4E90quDkE0tj80881AMnfI2bc++Y=;
        b=i2FU84QcFHDfR8oCU95FJ9RubUqJsbvdDsnckUELZMLvmw41qgXXWWGuJv+YH+SN1T
         8Is6LCps1homi+ViOV2dEfAmOm84lN7Pli9L+wXEdnsfoqSaBn/cXbAgmbciQbEV0hCv
         EpeUwheNl19T4fSgAKHqg/GqTSn1lYEaB/iBWtdm8FfNUrBsZzv5eJHJaND43kf2aLsh
         FhC4RWpnUgniZWdQZENScskwtyERif6R+w5Hq3P+Z/gcYwoV0rQ3JzikBm2BzMcmnUCY
         BDCG9S+sFWIrm45RhtFdPMrpQZiAILJ9MVpxZjQN0DV2cwgfoe912516DskNqbZ8yeqA
         G7kQ==
X-Gm-Message-State: AOJu0YxQ7BrTTgpJIQhd+T5yUJ0QSnS3xVZBKHAvTKNtqROnFiLXJvDo
	bGUznhAhN2RA2bJglAzGnjeQj42IdAgVm+NX7vsLhxZdcWESTca4R6W+ej3pWow=
X-Google-Smtp-Source: AGHT+IHlrwwkGwy06q+t0tEA95neRwAjhSlsFcm1hQmSQwhU8BZ/eUX9Otm+0tWhEFzX61/areffzg==
X-Received: by 2002:a05:6a00:23d3:b0:70d:87e0:9e7 with SMTP id d2e1a72fcca58-712673e8f7bmr3449277b3a.25.1723637537652;
        Wed, 14 Aug 2024 05:12:17 -0700 (PDT)
Received: from Ubuntu.. ([106.205.236.194])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5875200sm7195450b3a.37.2024.08.14.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 05:12:17 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 04/10] t-reftable-block: use reftable_record_key() instead of strbuf_addstr()
Date: Wed, 14 Aug 2024 17:33:12 +0530
Message-ID: <20240814121122.4642-5-chandrapratap3519@gmail.com>
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
index baeb9c8b07..0d73fb98d6 100644
--- a/t/unit-tests/t-reftable-block.c
+++ b/t/unit-tests/t-reftable-block.c
@@ -81,8 +81,7 @@ static void t_block_read_write(void)
 
 	for (i = 0; i < N; i++) {
 		struct block_iter it = BLOCK_ITER_INIT;
-		strbuf_reset(&want);
-		strbuf_addstr(&want, recs[i].u.ref.refname);
+		reftable_record_key(&recs[i], &want);
 
 		n = block_iter_seek_key(&it, &br, &want);
 		check_int(n, ==, 0);
-- 
2.45.GIT

