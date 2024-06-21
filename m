Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377D172BC7
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718971088; cv=none; b=Dj6u16Anu8favtzsY9Y2ABth/zPvZjozC6ShEbOCw8b6anYakvif5kR82OLO6N/B1UdvkibyybkMKApxX4it2Wsiq4D1np9D/KivZk697A1kc5L0a0LwgPwhbhmfX2asvNc5rdpptdSYBBcIScSBanE0kIfnzVLQnVFLpAmuD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718971088; c=relaxed/simple;
	bh=zVfrphsMh6HB8ICsJkGVrifwl1JaA+OPf/cVtHT0N0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kBfiiVVAK5hRBFaZnDVGlAxk6Lh7Ru9buDc9uwukXTY2yzVXgpDt77RIpEf0EuNNdVZ/c6yQVzu7bwvmsSUaQQFWP0/uC4vcZZuZ50CeRiVMC1nwWMdjag/FcL0CtFLwP8fUhrVhHSUt9B/KrIuCceGQQJyv+GmOBBUCMp0AvLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQNnr+Po; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQNnr+Po"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f6da06ba24so14245505ad.2
        for <git@vger.kernel.org>; Fri, 21 Jun 2024 04:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718971085; x=1719575885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPwUNDCbHOeI0ietUFo87O+sWRD05rlCSy3ODHoOK+s=;
        b=aQNnr+PomOjpZaHJ1sPcjo/Bs4a3At4o7qybW2eQTWUaeM4D7Sx4tr4s1vrCp/G1Pr
         mPV5CqsQEN/8ZarEPG4MS0WCll3vi+PNZG4llAx3iH/u4F7gUYjVeWfFDzot3LfKdQWt
         BI9ewgzPHKVU6E1eA82dXr/SjG8qlRnWvi/lM9jw/lBPsFPuerO//8xL3trzpp77C3Hl
         tPvW3zUcwNtKQwgpUbzXHdtLTr7IdU+tWZZe8zX2Qku1Ut65TNp6tWmgbl+SONrawr1l
         aQgHVNdilKc/A18s5opfUWXo7JCAtRxJ78qEzVFLLaeEkMh0bXPX5V1Eh3pkFQunCi78
         bZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971085; x=1719575885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPwUNDCbHOeI0ietUFo87O+sWRD05rlCSy3ODHoOK+s=;
        b=tElncZ+XrcX/fpLj+ZR7j/5XfQVQNrghm2Od05iYvxsf3CmfwKadnHpqCqtxXzJBqn
         7Tr9Yd2wZ8Of1omJmZ9tDN6DB0eEkIYuo0rULlzMvDbuDo4sNAtrR86CAQv3VFCuC3o6
         snV3Ku9Y4JlrZg289oXVqEJmYavolxx+4WgWs/AbT/FvuMQiEwjwNPHWDTGS9W+XYWO5
         4EBJbigjzvpPP4z0+3y3TmvquipNlwydt5snF8BjLPSSxohSi7frQuRtN9ZcqBSNgHgN
         N++9xnMIg20bKh/F9Kqp+4KLVSQ3dJJMoQbHhX4VoOYmxrwU8GMALrDZbAQBd42FLANh
         aWnQ==
X-Gm-Message-State: AOJu0YyJEQ7VJzDXLxWiTckIxfpKabyLZzt3JXl/wZoszcDMpcCMuyQU
	CRLGCcZXBO2zauQwuOb/5Z/ozwVv6wpMycICnIwjgdp4yG8X7nN6miDf6A==
X-Google-Smtp-Source: AGHT+IFv2b88fN5+9Sx4z7RgW2JA2OHMRUU4SncBCO/yi7KVr6c4D6dx+LWHvDe8NlECMgZztieWtQ==
X-Received: by 2002:a17:902:6e01:b0:1f6:a1c:e5b5 with SMTP id d9443c01a7336-1f9aa3db4c1mr64419675ad.24.1718971085339;
        Fri, 21 Jun 2024 04:58:05 -0700 (PDT)
Received: from Ubuntu.. ([106.206.204.195])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1f9eb3c5ee9sm12407195ad.180.2024.06.21.04.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 04:58:04 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik188@gmail.com,
	Chandra Pratap <chandrapratap3519@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 08/11] t-reftable-record: add obj tests for reftable_record_is_deletion()
Date: Fri, 21 Jun 2024 17:21:03 +0530
Message-ID: <20240621115708.3626-9-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240621115708.3626-1-chandrapratap3519@gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com>
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
is left untested for all the four record types (ref, log, obj, index).

Add tests for this function in the case of obj records.
Note that since obj records cannot be of type deletion, this function
must always return '0' when called on an obj record.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-record.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
index b2e1a892c0..766431ca67 100644
--- a/t/unit-tests/t-reftable-record.c
+++ b/t/unit-tests/t-reftable-record.c
@@ -395,6 +395,7 @@ static void test_reftable_obj_record_roundtrip(void)
 		int n, m;
 		uint8_t extra;
 
+		check(!reftable_record_is_deletion(&in));
 		test_copy(&in);
 		reftable_record_key(&in, &key);
 		n = reftable_record_encode(&in, dest, GIT_SHA1_RAWSZ);
-- 
2.45.2.404.g9eaef5822c

