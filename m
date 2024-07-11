Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7551F38F83
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 04:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670991; cv=none; b=qMMbR0W2gDZQ03O9Pw9nQE8bKC+ow2buUe4eLToPOLWm9JMeodyLDrP+BwMz0hUBzvcd6R271cbAExlDt1I1H6HjdIyjd7Jqq95xjMd7AUPXvMjpW+elydV4zFo+EjLcxIrrmXQ+Lklvbrf2TyKCWujkA9cKrXvMbMHPMXhEA6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670991; c=relaxed/simple;
	bh=OD+GO8550twbMVzG9AAs5aAq7KepI+V75WkLQFvA4QQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aSw9OCb1QUT9++9r+nrXBhMCrZS0JzBhPevkm9T4w4YyyZlUkt6sb3DcZoEHnf2Xl4ewkf39S322cLAuupiIchD9/hf+JBqQxTRqNdeiQT/cFO3a5S3hNLPsut+NkMDyPSlj85eTb/vFtaSYCccppyIofbRaUh+xf+R7H4UCXLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJur9PEr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJur9PEr"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70b09cb7776so409373b3a.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 21:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720670989; x=1721275789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKeqbJfd22/l6XZAYdto0akFbaV3uneX2ubhfZFO1zE=;
        b=iJur9PEr6chTQwbPiQXbW6dCdFFLSARLYzSUy2dMWQtLOJPsbBA9UUE3u7YzGp2Y1y
         IMvwIAYjGZT/E+McijypBTEv4ugdDqe8wbZFpftBcj7jLTVYRBx/JzGREAnGVudOd2YT
         1wIuTFbP+3ZoccTOP/yWGb0lEZt75Gp6sYZD4kx7OxJExzrmtRCM7HW2kv4SbuiRPhs1
         5ghDlu3C5/aIEHqUvdVIcb0Se0JckreSc97tCN3rICOSocwyRKv14H79jVCJt0n5/sS4
         gycpj0zjpOTPDDKXDLlpPF6mS30mbiKZfUXGDeGzpX0KoaBWOzkstU2TnQPuqlqGNHWT
         LJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720670989; x=1721275789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FKeqbJfd22/l6XZAYdto0akFbaV3uneX2ubhfZFO1zE=;
        b=eT1Ixnt/2B95d/k0TnMxVWOMGGDjkubEjZb0fGLUGa1PGaoeDvbpvfDVQLWTuDAjR0
         xNhcSzTdBfGRKNZygKda1OxgeQfnYRseeQYnYXRFMW3I6lHsxHW23JaiRzSgMEM74oUV
         aDPvH029jVLOSX773SYEX+P1pPAPzL0eIIM/dUF21+YEhBvM9CehK/xP6q5eZBxsbzfn
         ElfkX3lRX6bL/JbjNfPBIcBD/R2/vGUY0tH5tF51Ei+sudaEZkqzzkQF4D5pEuHJpaSD
         vd+7JGJST2xykDIlOIJHN0CZtAkoxInVPPIA2606avVQDiZpqZiJB5ih6v0OWhcPJ1rD
         oCUw==
X-Gm-Message-State: AOJu0YzTww/PDesb8x9EKrBA+E3OYRAGc/UnbYHsotPLdi3e2fc4cx2a
	NXuWTaEQMN/tfD5WHNndp3ZWFXNF0Hk3+9iVqYs+BYtFkSULacmi3QWId/Ct
X-Google-Smtp-Source: AGHT+IHASsCjtkpCKEsRcWH7847SFSp4yBv/Wlh7bRboKCgLa/nvv6C8crdHOcI6sArxpq8EDtcCfg==
X-Received: by 2002:a05:6a20:4320:b0:1c2:8af6:31d3 with SMTP id adf61e73a8af0-1c29820b81dmr9401767637.10.1720670989430;
        Wed, 10 Jul 2024 21:09:49 -0700 (PDT)
Received: from Ubuntu.. ([106.206.206.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1fbb6abf738sm40808595ad.198.2024.07.10.21.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 21:09:48 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	chriscool@tuxfamily.org
Subject: [PATCH v3 6/7] t-reftable-merged: use reftable_ref_record_equal to compare ref records
Date: Thu, 11 Jul 2024 09:28:35 +0530
Message-ID: <20240711040854.4602-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.GIT
In-Reply-To: <20240711040854.4602-1-chandrapratap3519@gmail.com>
References: <20240709053847.4453-1-chandrapratap3519@gmail.com>
 <20240711040854.4602-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the test t_merged_single_record() defined in t-reftable-merged.c,
the 'input' and 'expected' ref records are checked for equality
by comparing their update indices. It is very much possible for
two different ref records to have the same update indices. Use
reftable_ref_record_equal() instead for a stronger check.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index ffc9bd25d2..e0054e379e 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -158,7 +158,7 @@ static void t_merged_single_record(void)
 
 	err = reftable_iterator_next_ref(&it, &ref);
 	check(!err);
-	check_int(ref.update_index, ==, 2);
+	check(reftable_ref_record_equal(&r2[0], &ref, GIT_SHA1_RAWSZ));
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 3);
-- 
2.45.GIT

