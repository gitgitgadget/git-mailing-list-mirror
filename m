Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A045C41DEC9
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 11:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683617; cv=none; b=fZt3S3WUtt7XT9/OTB6OOJEf73xp9GtbZTXjRx7MzTLKF/qMAorsKE0FTkBbdJ3ChvF4MtNNJaLN5cL3UDuOTpm3pZIsta7a39l1yVh6Bm8MSvLaBevp/X+4992uKA5nV4kSSTGd49+Ej7zKvyCcJuM8ZBWQnK88Mp4lilGJTcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683617; c=relaxed/simple;
	bh=ZOVHbJMf8ShrZUmM2E+88UOmjCQr4dHvFe68IYNQTRg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b7qF0Af/w+fBverc0My2hjrpY/pbDdSYf42ULXwZmchQyyQPsl/0k/Gxq8RaVVITEaxkeQ5NElA9arWfpv/pAeBdVms/gej4VDX1namCtn/XBdfYsKbs6ByKC5sv/eLdeYHKQXHLpMIjlG8PV3eYmtbjYBi07QMzH1BqqrH4XxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpvum0+7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpvum0+7"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ccf2360620so6536345ad.3
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 04:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783683599; x=1784288399; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CUR8myBfXXrcyJW+eKZaIJ/k2w2ziI5vOCpxlQrtsA4=;
        b=Rpvum0+7+Hmg3eLTmHZgWV/Foto/H1d1bfri5oDvi1dPCY8TBR0L982tSHtv8Zad2h
         zDt4Q2nEsbdb4VgPXFBEXzpYIvg/YhNBEGZO8zZqf7HaDHOX9LdIbGhOj8ErYEpk07QV
         JuS+V4l/+e3DYVUiO3Z9+CgJFcGpHBBnfq96mJKdz8ZlgJXrsCUIeYu7BsG18fuQoUwM
         6+bAD+jB6pSXF1XH1pBV5eqzSZLAUmHV8YPsH5lCdvcqC9Xc2N4KFHqmj3jp/KCRX+Kb
         GYGxw2EDpG4Jf2ObrpfNdwEAakzaftZ4+tLYUj27uWs5CriwM3fmzIt8XviTJCj4PCXR
         pCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783683599; x=1784288399;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUR8myBfXXrcyJW+eKZaIJ/k2w2ziI5vOCpxlQrtsA4=;
        b=biQ37ECZddWJFlLiAq4c9JgdBZHkileAbhqkecYsMUMm8sDwHNC3sY+Z93FQCxdGRj
         wNwqNXSleVD1Yxkon/PIabr0CNeoO8HI7KcQwcpIJfGvpcA+xVJR/gVL4kv0lSYsWcXD
         sDsUc3+RUkskFV7gnkLV2Sx5reejGAAr7NWQfc0dISRvk0DgIkTNqXCtvWb7Ng28mOvE
         QGm4z94SXLzr/DQACrJWozdbERBMr66hzS3VgPcjB5FKbXu2WAQmy4XkVVhQZ4pBCWMm
         6/slKFs8Fhrz6St78lWcllys8bAA3mbXYlv7VeDT+pRiVqSEHplYITMNcnKFvf5t78QU
         n2Ig==
X-Gm-Message-State: AOJu0YyXX2TYdAyDD4pZgPG2g6Y05WO9cI1M024j3cwNpVN9B6ijr9Xa
	ynR4w8+Au0gzTWNx/vTv1Ezg2nvotiZ0tGq0lu4MfNJnsg0/yzUAGmUHJ9BN16Zh
X-Gm-Gg: AfdE7ckYg2bDvtnKN03M7GuVl61k0lKAd8faMqL4C917uQcIutu0E6ejh6U5rJPHcaF
	w1aJRLCJvQ+03ct6h1xs/enZYwa8s1xRUWaTYeOFdDkZ321WLwIFH896op8/u61Qi2b6A9L9uNI
	WxeW1/H70gZXDa+k0i0vQf39Ls/iBVZCXh1cjTHu6CSN3woqyVrNYS11FwhQW0JFq9J368UAuLL
	zdRIcyXgfrPDVUaJaIe0HMPSYdZirUoUwzGVqFC4rGygnXEt5Is+N6iK/ilMSujhd7uMNZPp2IQ
	kcJUqBNbnzAHOQdSyxi/nGQOuVTshZq0DsScH/OEQ/Or2ni9/P8YR0iszaU7GzSv04FVyWsS/nQ
	rdklrMSrrppVgkD6n2gFxELXN9S8qZVcPiUGaufAxX2pb6QIRcYIRBodTQfmSMNGWT5o2hlXrFq
	fX1aKHdvOutp44ggJE
X-Received: by 2002:a17:903:38c7:b0:2cc:6b7a:dfcb with SMTP id d9443c01a7336-2ccea42db5emr103133205ad.33.1783683599009;
        Fri, 10 Jul 2026 04:39:59 -0700 (PDT)
Received: from [127.0.0.1] ([172.185.47.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e28fsm59982355ad.43.2026.07.10.04.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:39:58 -0700 (PDT)
Message-Id: <2ef74b52fadc2bbffe7414b27db739546ab369c1.1783683577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
References: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
	<pull.2174.v2.git.1783683577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 11:39:36 +0000
Subject: [PATCH v2 12/12] shallow: give write_one_shallow() its own hex buffer
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The previous fix reuses the local `hex` variable that is already
computed at the top of `write_one_shallow()`. That works today, but
`oid_to_hex()` returns a pointer into a small rotating buffer, so it is
not stable across an unrelated call to `oid_to_hex()` from the same
thread. A future edit that adds such a call between the assignment and
the last user of `hex` would silently corrupt the output.

Move `write_one_shallow()` off the rotating buffer entirely by using a
local buffer instead. The current users of that `hex` variable are
unchanged.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Assisted-by: Claude Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 shallow.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/shallow.c b/shallow.c
index 2f96db5170..c567cc3c69 100644
--- a/shallow.c
+++ b/shallow.c
@@ -359,7 +359,9 @@ struct write_shallow_data {
 static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 {
 	struct write_shallow_data *data = cb_data;
-	const char *hex = oid_to_hex(&graft->oid);
+	char hex[GIT_MAX_HEXSZ + 1];
+
+	oid_to_hex_r(hex, &graft->oid);
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & QUICK) {
-- 
gitgitgadget
