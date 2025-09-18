Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1EA2F3C14
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 08:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758183116; cv=none; b=h9KxqHqKM6jysdIWapqm1mDh3MABMBavH+SservIXP7D1EfLvsc5to3uMgGwEjjzrneiW2Yw425ZwCDeYDKrl8GOQKjThk7O3RLhdz1eYhiQ4IGjWmf6L1ry+zMlpDCNvsq8gEUrG9Nu9p6JGStP5XHwi5aZmCdAYh3omKtzwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758183116; c=relaxed/simple;
	bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M/u5TUI1lTCqWQADU4V0mccG1jySLplGZXSluYmGHU2m63VshnjYUksz/E+vsNbIs+Kk1kYz6GYbEc6ILHLzVUgXk1TDFEmLxV00iMDQtZhE0Gy2OfG4Pu2g5ocCco9HB+9pd7HIwr04nq4larF4wmEm8KOCVm3cM45U2CD69zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJIE7iWf; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJIE7iWf"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07e081d852so120850366b.2
        for <git@vger.kernel.org>; Thu, 18 Sep 2025 01:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758183113; x=1758787913; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=eJIE7iWf4JxN+G/JHQVgXfDeRAFK017sLif2c0PdzyoLDdMa/cy8MkJRdy6Txoth0a
         QWoyqbG+RhQ7nM8qbXfOvcC6jzq2dAQrEi2ALnC4mTyAfG+VyGyvYzjfchtCHmtTYTAL
         6ydWAfy3+J6f2fhDdpcwkVHFH3J+MCPH27sipaB6nYUcU0EL+OyywsYmqziQKj6OfJFn
         qtusGUFxoqGvsf7kITzgOhN4Btop5jEZgv/ISz1OZQw/bMgKKEeKngqhu1V4GC2Xfs+x
         uwF6U56Bv4Z7Roiy2hmcEgfUP6HNO40yw3B8eeX+ag79QJ1YVSAoVMD0jGKDpzArPLdp
         AucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758183113; x=1758787913;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvm1oKFZ+vpkVAHmHsvyiZuwnhtvDFDUJacA5oxlAME=;
        b=h3ytNkTqnKeEE89GYCumdShl5R2B3UG+/JqBKucApN+kM/mYMYhJifflav3HgKqxbH
         tLqSiOwrhQoBu+3VqW4HnyP+B0mUw89klIH9xsO16N6PUm4aGVsTiFnD8MGXG2daUCQt
         25mICX+CYg2y8a15LQqEuMSoERGe5FeB6eBMxwb4ZaAnBlrV/Bbqtn44VT+rdRvEJIzS
         u/dFrWTQCjS9pKiRlxVU+DaOqRRRbMHPE043OlUS4oXyYOLIPQW4O9vFYjW4vnA3KpOz
         2dvnuA0YwP60wlDsK10gJCu70vi1fkOtwy+8ewQQKr5pz5h/r/8oHELsEOUIKjnJ1aY5
         6w8w==
X-Gm-Message-State: AOJu0YwBaVqqTomf4ldgupCJQeyG1ukvMsm8lj+9cMsz3EMWDzRAaUWc
	ZdCpC1Ivw20k+scFB7P1w/I1/A6FPWJzI/+oid4ESBSk8q3Um4YJUUTR
X-Gm-Gg: ASbGncspWkARtbstiFuCE9CeXEYWxXCIGToKz/aVWwGrt5mVWrlD2pleaOd/ewv/xTC
	MDzfOS8opphpGfKJOmZoFjMna4EsRZJdidXuuWjk+w1mIshEL+kp6y8eNK5f1dPrpjgRxTUvbLT
	kfSA3VCIbuH+EYS0AYrOwfxIpkjHiX7GMY8LexBaHpTErp/ZWG4kLjUBR9PuoDjpbcO4MySDjzq
	IUleeL3Xx/PVNHHyNVcfdO79TuGgFgQWGVThb7BVx3n6TdVazEAvowew61Zq9pzlqt5u9qs/kv1
	yicE2l5VTSSyqQ4en05FbsrP8XiJ8pgptknWQZE2sk6xeNg5p53Ti9bAK33qJShf6XgClnAUTTc
	QmpZhkeLjXkQfIzdDsFMd10E/eg49IhPTQG4yRE+ByIT8v+M=
X-Google-Smtp-Source: AGHT+IHRCVXW5Z7EDNPsd0UwlOS9ECnXUzSAUSdPgTJ0CQgimf/64uoGOWwv1egoeQk4BkOrqQUfag==
X-Received: by 2002:a17:907:6d02:b0:b04:97df:d741 with SMTP id a640c23a62f3a-b1bb82ffbefmr546046266b.44.1758183113045;
        Thu, 18 Sep 2025 01:11:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:2802:b9c0:7d04:71e9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd2ce20f4sm139986566b.111.2025.09.18.01.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 01:11:52 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 18 Sep 2025 10:11:46 +0200
Subject: [PATCH v3 5/8] Documentation/fsck-msgids: remove duplicate msg id
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-228-reftable-introduce-consistency-checks-v3-5-271af03eb34d@gmail.com>
References: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
In-Reply-To: <20250918-228-reftable-introduce-consistency-checks-v3-0-271af03eb34d@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, shejialuo@gmail.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=649; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=NrJUe2zo/755ziLfa/YcRS7uqgD2cBYrUKpni6pfRH4=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjLvsMLLRZJV0/6tOAAao+ZYZ0xcMAvZVWlk
 M2HTa6HU5OmLYkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoy77DAAoJED7VnySO
 Rox/QT0L+wX1UTfIi4TsOyp0r8xopTguqctVi6mBga+F+clGAIfV7eS5a61WhW729awkZYtQi36
 ss3D7q+4MfmfoJx1MbA3+Oz8sbb05fBgVibWhKbH4Zmkiheqw31O/bAu1nm0VDVb0U47hrHcIT9
 81I+OiEtx8x4qVzaJ0j1vaBLa2Eq9cHjJwNiaxWmedODO0foHu8o+4mBfw+no4JXtfrnYZAdB3L
 ALdITvSn2ITNgbRrfP+rwe3GGkNH1qYDxumC1WxVj0OEq4ASc2LVgp4p+dUa/CsUGOiw0WlWYHK
 OFWmy3DWAKioBNjhaveu06d/IAdyMhYT9xfnXZk6qTrXMr+7IA8IE6hZfte99aDBr0HAxPsTlBS
 UVrbwdXCalA9Mj2+hJoUJarTdMsIltdGvBZb/HLiLp/YLT+Q49AFZ/Qct7Pe7ifVG8SBVQAm45j
 Qs8HJbF17h9dTOOxsjTxxo48wGiZTAG0KhM3fq05KlldTE1YHihLzU6P+9ne4ufw95vqSNTwBQ6
 JM=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `gitmodulesLarge` is repeated twice. Remove the second duplicate.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/fsck-msgids.adoc | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/fsck-msgids.adoc b/Documentation/fsck-msgids.adoc
index 0ba4f9a27e..1c912615f9 100644
--- a/Documentation/fsck-msgids.adoc
+++ b/Documentation/fsck-msgids.adoc
@@ -104,9 +104,6 @@
 `gitmodulesParse`::
 	(INFO) Could not parse `.gitmodules` blob.
 
-`gitmodulesLarge`;
-	(ERROR) `.gitmodules` blob is too large to parse.
-
 `gitmodulesPath`::
 	(ERROR) `.gitmodules` path is invalid.
 

-- 
2.51.0

