Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8F24D9FF
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788709; cv=none; b=jsOnz89Z+tOXUY+7+dHUyjGINiDaP7i9kcvqbDhLzhrafk8mPld770Q/2+7zTbPqKlklKZjSZs6Dr/K/zvv9jifqkCh/bJECRcEG3UkQep+HO6Cr2tBZccpbhFYPvDbeksWt9u3P9PmFItoOT9flb/6SqZgEBmkpFfLfvsfHwGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788709; c=relaxed/simple;
	bh=c6NuoEPV2b5MqMtHYDF6h4XhoAfGJaCazNzoIZEn5mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCNMiCfqH1yymfKx3qhZLprkDxPoe7UyczEYk3LK2sXPqIlZXU3jg2p3YmRMpBRXmxCbnccO1ro5X74abQRP4wynFcmEzFuToPO+OyEj9GkIsa4hMpUqwE/CNhXajn9HQ/IxHkXin6iHrSGKvkF9e5AZS0EZ2Jn9R5jy5T1YCas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfX1fDD4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfX1fDD4"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5111e5e4e2bso1279210e87.3
        for <git@vger.kernel.org>; Thu, 01 Feb 2024 03:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706788705; x=1707393505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUaQ64beMWrLIMpaF6W97IbkMP2Q53oP91SRuxFXnHI=;
        b=KfX1fDD4aSOBGMi0q/E9Qz/229V6avC2FOY57Gz5O6xNHeaewg35QMQIqEicgbmjCg
         K/NhxGsVYjYA4ZTWIglq+JO6ReT+twTPXMmRsS81MsR+chph3xeEd2JX/hviPTKChqsp
         BBzz3Nj2RnjVXghM27wS3KyBcdXTu1JJ4e7zZfEDBBOURMlDX40Wwel8mOGTs1PT+CSA
         b/Yq3MIVJ2Wav70oFpzWNA5yttA8MwGJjcSrCl4+5CGuhgBbla7gvkyHEH3JD3zBA9fl
         FCYmgnOdTzMQGeZqQzF+Xl+YzcIe3s/aN7kcYld2llLMxPKFVSNTZ9mCqzl71UMIVyY+
         x8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706788705; x=1707393505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUaQ64beMWrLIMpaF6W97IbkMP2Q53oP91SRuxFXnHI=;
        b=qiQTPcbNydavLDUV8QS325whZJeJLIR6hss+1GwR9ECw9u3U3p3z7OV4i9Ygh7pu5x
         l81/ttfQnWXU1fH90IDBBnJdMVzvaJqudOtnulHMNbLwfEpko7p5+mLJ5/GfUhaYJoag
         6RM+zXyInk/P+53cXyhY+uGM5LJYYxdIgc7Oi4X0LRLBq4swY53uqvY9Mx9IhO1hbrhv
         Ps/RK8IEI7TchGq1fnkgaxAPY201Awg9xhMV9MsYwbokpxfpUnCIJCWMRevWwuMsCkem
         iTKJnVXaoaAZ2nOvKQJVEhJFFfafIZc6wBxQHdi18ibWaXSlxeRLYncCG8dmbUVqvuGt
         AdkA==
X-Gm-Message-State: AOJu0Ywt/lwjB4Apoo5GGef+Kb7DypRDW1EetQHIM8tAlg1iXvcnr7XG
	aIFVd53ssWNzedQ8sYqzbP7uyVTSUTvurqzcDz2KdJquaKaKjbbe452FXqek
X-Google-Smtp-Source: AGHT+IEI2lHpfstmJvcXIChEhHstl1Cp96EP4zgiZ7fOR+qAOJFQrbH3FkQVlImn/vDy4DVvZQNjNQ==
X-Received: by 2002:a05:6512:e86:b0:510:14c5:3360 with SMTP id bi6-20020a0565120e8600b0051014c53360mr1675163lfb.65.1706788704882;
        Thu, 01 Feb 2024 03:58:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV4MKz+uenWKRz6KtnStYqTFjNbLICfmPINhrvi98MN4Bqmb9mQC+OauFMvW3lPHVzYObKHZSxMSTyde24uHGJ0LZlBhHdztuoEtISJREXxr+MV1BdHDIeic2SvjliIoRJ6B9g7kwn32Xjvjn4m0a9ZMkf+8pY2CO5zKuGU4fa72P8wCw==
Received: from localhost.localdomain ([2001:861:3f04:7ca0:e1e0:bb55:1733:6146])
        by smtp.gmail.com with ESMTPSA id s6-20020a05600c044600b0040faf410320sm4113495wmb.20.2024.02.01.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 03:58:24 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] revision: clarify a 'return NULL' in get_reference()
Date: Thu,  1 Feb 2024 12:58:07 +0100
Message-ID: <20240201115809.1177064-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.496.g8be34ce359
In-Reply-To: <20240201115809.1177064-1-christian.couder@gmail.com>
References: <20240201115809.1177064-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general when we know a pointer variable is NULL, it's clearer to
explicitely return NULL than to return that variable.

In get_reference() when 'object' is NULL, we already return NULL
when 'revs->exclude_promisor_objects && is_promisor_object(oid)' is
true, but we return 'object' when 'revs->ignore_missing' is true.

Let's make the code clearer and more uniform by also explicitely
returning NULL when 'revs->ignore_missing' is true.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..4c5cd7c3ce 100644
--- a/revision.c
+++ b/revision.c
@@ -385,7 +385,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 
 	if (!object) {
 		if (revs->ignore_missing)
-			return object;
+			return NULL;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
 		die("bad object %s", name);
-- 
2.43.0.496.gd667eb0d7d.dirty

