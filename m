Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483320322
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 01:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576697; cv=none; b=u8woXF0oeBjrNCiGO88V2Llo4avbQnnRZSCZQcrX5Tbm4xsQAb/AjPZQx2NpoMaKw3aa0B6gUOfE/5iA1pfSfJFReKyVOoXYsYETe0XMXyyX6MnrqUjszIT8VxjWLzdQMitBiZuZG1KgKOG41/P+co32fV2I+l4N96QUt52YGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576697; c=relaxed/simple;
	bh=d4cMi1k37doQ25kBnpTU9726d45IDM9Y0k2dcrFValM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4iNpPESLRQibDINbpiWAAgq8Nc0I8fpLLboNvJ4qen6FtUoJrK3HvML1q5qGLUCx1rCKJIDnmlVLRTaLHLhGwNBTFp1nbb6cHKJD92z2tgeXNoxPgP8q5JCGYlrNQRWWvAIc/PHPVK/5bIUhU2Ntu1rkokJn1ogZArRUha+7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F27B1t62; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F27B1t62"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-781421f5bf5so1908047b3.3
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760576694; x=1761181494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvz1FlcUVNVRlVsNX2gORBW6SR3qsIkt5g1CCOAkEMw=;
        b=F27B1t62L0viXtMqpWPC7Xf03jXj78EVJSr8Tg0/R0u1DnzVn4y8Ld3pyYBTMIyBN7
         hFhMQPjKf9/kRmcWxZ7cd5TIGSM7r48KUgeqR6qvat3F/3SnPJPEHKVZJUMnj/j1YLC2
         jMF9x20QOHDSU9pcDTVvJSRdznlY/vCsuVUXJUKDHgcktmMcCumftDGUalkJsunttaLP
         pdgCZ9fxQ2Q6amjS17ZaZS5bE4UwwFlJmXfDj8+Nc2DTgiZ2w1E2+re0oYdIGD/O1gW5
         T/yuQrKZe2e2lyMD+eDiQFWfUOQj5YgZgY/dSm7N9SbSFZ02RESoKoExeE660PiQM7VK
         MsGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760576694; x=1761181494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvz1FlcUVNVRlVsNX2gORBW6SR3qsIkt5g1CCOAkEMw=;
        b=IUU+aZAdZ+ZPf09eH9YxkDB9pilx90YCcU0kfBoDhZ6D+b4u01nUTinjWLcl2SN2Po
         dNVCtGwBn9cmmMt54EoZeslgXArhS3aXA6iLhKJQRUWu82Hfu+no2o/ygz4hv/i/mQs5
         vJyTmocaSuMduKh0AMs9ee8qOtMCO0yUPJCMlJ5VueFPc0ykAAC8IQm7CkQyGj9sqAY3
         4rQIiJKjRJXOMa7bZNTmaJdRCqMz4lhnzYhGDoN9CiqHYS9ZKKYRL1BTcNoK3RUtlMYz
         Xggh6suBmOPwNupaud92HF3O67W3nQQSx7OoYnrMndQyoFrb5a6l/x6FUDTnfV8s2wa2
         kf+g==
X-Gm-Message-State: AOJu0YyLcO/qh9DHO4wGsblnW/b9Sb3HaTaqxTKYxmCQCCslAc8VhGFF
	L3ukH4HgjKclo3YjZ0A7KtD6PlgZ7XpISUsD+4VV4pU3CwHgymUYO5pj
X-Gm-Gg: ASbGncuvVvwbN6UutETYNGNkqnL9K5ya35lOJ4/ZghnCE/Z4TCcPZmLX01W76F0SUpI
	gqHyd3M6niF8N4awP72T2kNLECg60Ngvvk1qceD6COC7aF8qHTnnopUu4WJpZRq179klC/ChzmJ
	ZrjAvoMo8oCMf9Ts+U25WkRCJ5Jdh0qV9X8VFsxABQ/s+5LtFtOI2qdEDSWCNlz0cQjWnNleaCX
	IcTPKCvhjFSr4F+nMGiSQD6vJZUTIp/qmCUMF7wR1vA4SfRBd0/xc0x+ffQUGfQvnjGCG1QQ01X
	B8o+7tgeZKks/GWAPNO7MWbmnIbDA3Ow0OKGBAw9Shv9StN29bR3mvDiE69p0aET3kxAi9ZCKgt
	gNRhf5lQsqk6uvqvRMJ8WiRhOqwZisX7/CsIdh29Dj5IAvQ9TCja6UK3XkzduvV0NBuyjQ9hD85
	gaS0Oa
X-Google-Smtp-Source: AGHT+IGOeY5iQEtj64SJ2aeHokHpV+xFvh46PgDTED7wqg3/8u9jsI3TvlxDa25DWJuYkArYbrAHsg==
X-Received: by 2002:a05:690c:ec6:b0:781:4f52:689 with SMTP id 00721157ae682-7814f52091dmr111699947b3.28.1760576694205;
        Wed, 15 Oct 2025 18:04:54 -0700 (PDT)
Received: from ubuntu ([105.117.3.242])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-782932f38d2sm3489597b3.50.2025.10.15.18.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:04:53 -0700 (PDT)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	usmanakinyemi202@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH v2 0/2] gpg-interface.c: use string_list_split() instead of strbuf_split_max()
Date: Thu, 16 Oct 2025 01:03:52 +0000
Message-ID: <cover.1760571220.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.51.0.463.g79cf913ea9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2efe707054 (wt-status: avoid strbuf_split*(), 2025-07-31) noticed
that the array of strbufs that calls to strbuf_split*() provides are merely
used to store the strings gotten from the split and no edit are
done on these resulting strings making the strbuf_split*() unideal
for this usecase, with the string_list_split*() being a more suitable option.

The patch series by Junio Hamano can be seen in the link below.

https://public-inbox.org/git/20250731225433.4028872-1-gitster@pobox.com/

This series continues on this path by replacing instances of
strbuf_split_max() with string_list_split() where the string from the
split is merely returned as char * and no edits are done on them.

Changes since v1
================
 - Added commit reference and link to patch series for previous work
 done on the subject


Olamide Caleb Bello (2):
  gpg-interface: replace strbuf_split_max() with string_list_split()
  gpg-interface: use string_list_split() instead of strbuf_split_max()

 gpg-interface.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.51.0.463.g79cf913ea9

