Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F2033CE9F
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 17:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402803; cv=none; b=ruRwfZrkc5ok84Wg+5QdPTCIu503GGDnXj+k/86p8YeCv/fl13zhECmBAro98YarkQF+WItZgdHvkUt+WZOmmIyjWepQ4W+k3cGFWc8O3GWV/9nYS72dXs6U2+fsMLV0spRure/xIOQiG7XvKi0W+XWhhGHvD2tn1SuNd4XVAEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402803; c=relaxed/simple;
	bh=vDKhS9y4Ow7oMbBGt2siXifQNR7P4VogBtIBeGh1sCM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mq0dCzTjTwPOuSgtDyZYW5wH0teLDikideALWJ+Luq7mtKux12FsDqk2Gq09VWc7p6SC+rHMAGi8AGglOEBoCl0B5GKsxT8KKp7o2vUjG/LzxSvu6hCZZDu9M0mSA6oqBHDzOlCqvKhoNFL6slTX4QXYDJiU5QD/x99fM7sucqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQK23bxw; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQK23bxw"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f7edf7621dso112193785a.0
        for <git@vger.kernel.org>; Thu, 28 Aug 2025 10:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756402799; x=1757007599; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZZ7JkWjZErA4tD/CR6UJbGFXT0eHRgPZt4EPOCpXYc=;
        b=fQK23bxwVB/4BEoECkYt+8DkHDkFZqMm/hD8HqPbzgK7gAwX7hmrCu223rY98P4029
         sO5Ygvu3OIdoSyPfQBMEHEb6vorWwkKxgAHhlUBadWUpwTKalrXEVu+XNdQ7cKY+m1fM
         f9vhvgRq2JUk3n8HetbIs/MikuTqcf8Mwz0kzdvIxGXqnedO1ivZsI4WlYYuAytAuVoM
         v8JF++OyaxiumBuQOsl87WELGw5BokctFQ4GN68kqqgTKrerQFNib1eCainZti+l5cAq
         doHUQUmzcw3hHrx0vAwW8allwDDvT/Dacxy88iquP5HDXxql1vh2dNXCcjl2omWqYH1b
         G6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756402799; x=1757007599;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZZ7JkWjZErA4tD/CR6UJbGFXT0eHRgPZt4EPOCpXYc=;
        b=NJoV77CTGK1tfe4SQRVCkpwXKIwKRbdMGGVPWFL/1SgcgfQEehY11ub4Zen8Acjgt1
         5iEn5IV/XGtZ/L1crqpCerrCbd1uvRI1KKHicsGZokbnTRypq6Jie2nRjkx0X6dUbu5R
         q/IdMlTo3Ks387aMKzpKYWQ3e2bLDkPdGHL1fkTviw7rjMS2stABQwbmfueL1QJCkmgn
         6w9o9Yv9Y9Og6u0xnAcZhelgml6ArdKDeAAmW2P1JbAqndUOb/yozoScJtNg1Klv73mf
         tlFfOdLS/StK78FcytqVYvT9KHDw/XEptKXcFNgtiYyAE/JkyyJFLjNJfQvgfJ9wZ4N6
         uW6Q==
X-Gm-Message-State: AOJu0YyJOaKYg6RS+nza1PId++g34eg7cL7vp4P9wbSv0CtuKdjJxZvW
	vGu/GN7D6rYaJRsjcRhiB/aadxQu/+NHFjxefsBUwTmirNYlFJFsz7RiTg9MtJLz
X-Gm-Gg: ASbGncsvjn1DMbl9iLPdBylRSRe/HS8ghFj63mHLN7+hDt4NABaXBWZoalMCLlFxcCy
	3KU8n+Gz9EY/3xfX2zqnf0Rri45h2Ntg6FCzbmgImzzvUyQoIsp7kbna/XaUkBuSgW8LofC2qLZ
	2l5Yw+lVMpUQDNM4/EzCqh9Y88jtrdWXT79Pvesr+7888kYtByCjWwfIjqBmPacqdjs5N9M2eDL
	0v3uo+jAM6vc8QMsAoCh//vLrviTLWEfqsCV7dBR5rFnqbeoSIqKHf1q1dW3lOccENoUhDfx9Qg
	4Inq6MGdgEcb14723IVj8iHB3wgyp0s3RGyLa1vSIVmFZz3GNZPFkG1dv2Gm7tcEkNLhmNIdqzN
	RPSDyVJ/xJQ9XSvuIsqWGdorqrQL5rcUtO3AUm4o3jEf3cQ==
X-Google-Smtp-Source: AGHT+IFqa1hJjfZku/zyS7OeQvS07nHXzKAYbzRzCJQ5q8r6fOfoPEx6GbcSaYw7R2fgZ/CWDdEfWA==
X-Received: by 2002:a05:620a:4694:b0:7e8:12c1:12c2 with SMTP id af79cd13be357-7ea10fe36e0mr2977848485a.34.1756402798983;
        Thu, 28 Aug 2025 10:39:58 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.244.34])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0e6f0e2dsm22280085a.19.2025.08.28.10.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 10:39:58 -0700 (PDT)
Message-Id: <709555c5316014b2b4d6648db407d15160769146.1756402795.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 17:39:52 +0000
Subject: [PATCH 2/5] midx-write: put failing response value back
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This instance of setting the result to 1 before going to cleanup was
accidentally removed in fcb2205b77 (midx: implement support for writing
incremental MIDX chains, 2024-08-06).

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 midx-write.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/midx-write.c b/midx-write.c
index d8f9679868..85b2d471ef 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1106,6 +1106,7 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
 			m = m->base_midx;
 		}
 	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
+		result = 1;
 		goto cleanup;
 	}
 
-- 
gitgitgadget

