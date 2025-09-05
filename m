Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01938277CA0
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100384; cv=none; b=Xn5xEO3dUPVSzh3rxpwRqmOB7ih6aGMwM1CbQcz+jtD9/Fe/TjZ0GXM37frYXInQ97wzUv8gIH/d1JvESig8QxdSRifxhUIEYi0CHCgava8w7QTQKy/meNzZqG/IZqZVTVBJPT3wEJ7Hg1ykYNO0w3Ai8/DsJHUav7lye6cL4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100384; c=relaxed/simple;
	bh=psB4xAyZMEF1qyA4gypbCIAYE7GWNuO03bTD5Cnu+hY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jkn87OP+goasjqr3bozydfdufpYySYDdiCZpzqN+U++mNd4uQvI7pgZ26yCCK3eI3E5XIbyLwTZRDgV9NMRAdRaGVjTxEL1GbhK9RyliFEgWb3dH/A5hH0/SMWtuLArPIwI11ajm/7l8cVxJFntFbR6LKLVxidWHXF4UlKCV3D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxPh8gKI; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxPh8gKI"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24457f581aeso24387815ad.0
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757100382; x=1757705182; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Gx6lGGLrsXTm0t+zQmHe6Qi1rQ3ICUWRp3vHpVt/2w=;
        b=hxPh8gKIomfh9t4s/+FqcqiCbhjfj//X0Maj1sD/jH1lXGqQgGxMJYk0s7SeA3urPW
         J+P/dNQNW5207cVElhHcihN8z7MbFsEIQunm5kWqgEgjd6gavkeePPpw8+YiCaCfaA46
         DQKmkr0ojbmUByfTWREW2DcTt0Gap7NvN90ryb13NMlPpxQ77s8L/4QqfaV7jw1UcmKR
         g9zaioFxZoAe4LJ/Mxtr+oM43jq2eAFvhGOMRdX6xS6HGzPZu0E3i31HLMurx+MsfqNf
         x+FQMba+8//w3d/+FFvJ0Fo1yJL8ttuUD8Pr27ZRtdfywCblImYtmCZ3RTNhbHs7xHhP
         6hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757100382; x=1757705182;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Gx6lGGLrsXTm0t+zQmHe6Qi1rQ3ICUWRp3vHpVt/2w=;
        b=TDBDJYCGfGGJqbHbG7rudZ84Fvlhuo+HXcbY/smNf5RpT/c3JYYoalY8UkDlMAD4En
         b1QUAB95jr85RQxWiMBjtI0yKsZxFFZM4Pj7bxikPIaeB8fyrmjIctauSLmJiLbeGUOu
         Vd0WTN/uHi62ryZlLMwCztPmz9TIWfgAcxzEJrxvH6RE8U1vDJ9fHOOy1zrliBu4K54n
         UCN/T7TSopAgABhKucS14N09vlxLFwUNYNZACagQjtlO9NfqLwGxHlHu7ffP4FBRN1D0
         lgiVFtbvpujw/IkZxwZUTTVvJO7aoPW/4h4tGMyX4t5rM+xkLiPg8fmYfNXHJErVJxib
         6g1w==
X-Gm-Message-State: AOJu0YzoLbgv1LxS+R3V2qldhe7nzqFH4clMCEpclImCzz3FjtN4no+l
	zjGCX55P17PiRfsgYKnPS6jKeAxV0Gb15oklR3QcQcbtyWc6B19s1MQQlrI+pA==
X-Gm-Gg: ASbGncv6OE9cCmPyROQMsfgvVWB1VMQiWCBVnLwF8RvLEyZlcYvBIWNR7TSXm2oOSTm
	nAL5B4w5amA1663Cc5tIEXqZ5BE632egIdEG/hnaJmNilF/x9ilztRb4do+2xy/iD/2tKCV0t4U
	7u73e0o8XXEKwa9H7xDrVDS0CF3eteTQz9EGix0g8DAydhKLHeLb7w+uH7X814FYmAES+NM8EKa
	nUZZ0q+UfXXTJpGT9R5vrNphEuh9sut2QjuReaK/nzDf+Ns5rUKAwtXz+OH03qxPTeHqRHkqyZR
	7bBl8uu0Que7+CrIRiEEt+qaZZDrjEcUivFMnDAvawsyfguqnTidZD0KLRvdFd8mjQGY1tLj9hI
	06tyI/3/45/jWfyNXCuBgj40nrQ==
X-Google-Smtp-Source: AGHT+IGMfDj1CK8sjdW1erMBm2DtsR0/uz/o7STlSLGbd7GLFSy8qaG81OOGuZZZL+tOBNhswuRlIA==
X-Received: by 2002:a17:902:f60a:b0:250:1ba5:b207 with SMTP id d9443c01a7336-2501ba5b2fdmr23082225ad.59.1757100382002;
        Fri, 05 Sep 2025 12:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.166])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32b617b104csm8261574a91.21.2025.09.05.12.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:26:21 -0700 (PDT)
Message-Id: <1e5f43a417207e243a947d09255d71c26a52ef59.1757100378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
References: <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
	<pull.1965.v3.git.1757100378.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Sep 2025 19:26:14 +0000
Subject: [PATCH v3 2/6] midx-write: put failing response value back
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
Cc: gitster@pobox.com,
    me@ttaylorr.com,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This instance of setting the result to 1 before going to cleanup was
accidentally removed in fcb2205b77 (midx: implement support for writing
incremental MIDX chains, 2024-08-06). Build upon a test that already deletes
a packfile to verify that this error propagates to full command failure.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c                | 1 +
 t/t5319-multi-pack-index.sh | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/midx-write.c b/midx-write.c
index 070a7f61f4..0f1d5653ab 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1104,6 +1104,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			m = m->base_midx;
 		}
 	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
+		result = 1;
 		goto cleanup;
 	}
 
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 49705c62a2..2c22fdb931 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1100,7 +1100,10 @@ test_expect_success 'load reverse index when missing .idx, .pack' '
 		mv $idx.bak $idx &&
 
 		mv $pack $pack.bak &&
-		git cat-file --batch-check="%(objectsize:disk)" <tip
+		git cat-file --batch-check="%(objectsize:disk)" <tip &&
+
+		test_must_fail git multi-pack-index write 2>err &&
+		test_grep "could not load pack" err
 	)
 '
 
-- 
gitgitgadget

