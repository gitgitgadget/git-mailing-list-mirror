Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778CD38A715
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943690; cv=none; b=P8w78G54ejt/Qwcxd6e8Vsz8FMrQ3sga+O5UL5r5yNbWmK+oqPP0PugJiKJ7CWmFdEAJaWzIvHuWYh05IBO2V408LXsI2HnOTfNzD+M+dVxEChe0kh1G8Bdz9cLtrK0FqCMf7RhIlxWtUm0RkS6elBsUc7zxrbfFfZ70hJ3V4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943690; c=relaxed/simple;
	bh=haCwItZ5d9ZGtSTCWjptrqAGOI3IjBQR2oUkqMfKpf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgqXCRNsCzYvmURGmqDWSgLMBtdgNd6dPl/lr9DBfMd8eAGjsQ8eoBxyfAoKba6lKJy28M1Fqqag/4JDRfpT1gNs6VscpxuKYK08XUSvd1yz4pedPyiLvcNJNhKOVFseQ90q2YstJUSH0C/ZJMqPHWNad34Ksryp1xz+Vy01oBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+CF1/fu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+CF1/fu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so10073255e9.0
        for <git@vger.kernel.org>; Thu, 19 Mar 2026 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773943687; x=1774548487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQmMS05GWxRnwbWKCSYD9QbJt8OtrsDg7q1/nO1IOgY=;
        b=i+CF1/fuiyMZ5QsziaIu7XhGgnGr/XQmhyWs1/YR6S+PTh9rj/QKZ9cjLvezAekvV5
         +OWOm+7qxlU/xgiipKQK/eMUh8aGzxOJMqX4A0Ay6/Pb+FAwYlM9pGenNVT4gqDSnvsJ
         bXUAtTzR8ZRDLA3zT8hZf5SNcNWd9P4BcD5iMKMfQZYF9ao30vlCFv/f9oGj/vIH8YgI
         F2niTj5j4mbKskxefZNPGgT74VnqjWc2nNy9RFqfWhCDZQX1Ki8PpdeABTN1UpsTZv4j
         yVtQ9JQ8vpaLXCdcXVKvQIRbh6+e4VzD+6btoVlEaPJQfVCM//4NYFN0cdMU5Di48C2S
         udmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773943687; x=1774548487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQmMS05GWxRnwbWKCSYD9QbJt8OtrsDg7q1/nO1IOgY=;
        b=NURT0X3EDUM59sheAgPvSA1PHJFecimqHrgjvmGVl0eop85zOCdD3pXgs4XxbhncK4
         IxtLSwBt3c9xf3oXkaSYZwBNykvFdZVLMOluQpjkFAEKIs7F7ryDxdoBAWAJSmU6Gp+G
         raXpUBd1Uh1fWDIziTOOu4HvpCHPsH5QzZnqQT9M7YmYLZ1RLzk+T0fNpoERDncAd2z2
         KYld2clcN/mwojYaWI7dKcAA+Jr6H0sDnWwQCv8s5uTjGx4WsMjHRP0XX92ADBv+XNzW
         ts6W2gbaSOBtupP0RsaPZCNNQjTMxW1mAczfzATE0L+g2bwSv3AL2fKVYX2nfQ2GL6eW
         SbwQ==
X-Gm-Message-State: AOJu0Yz/dJ8RSMKk8fiFOCeCBdzxYAuINeiDIqAXzwwO5U5YgOpCvHis
	NX2tNo/akNgvR3rC4VbG+05rIR/Zpb/PMJwypzmKJn8BgaquYOIwACC0lLrf7DPIF8nLDw==
X-Gm-Gg: ATEYQzyPvHlqHYFm/wZo8JacpmC4Xkz0fibwhGLJ+hlHIOEsgtu7MslkSbvWGeWVsGs
	LFUMqF1eoY+QRioAASgs4g+BjgqeKr+v54oRzzWc/pisRfD9vvpTnIe9psYwcTVKTl1MtaWrumK
	9vE3tmTXQvTmrjU8o0IKrY0dMocN9exYkHPAvOiAON8RslCn75mc9y7DdgbtkNODL1PhNifBTSM
	Pz8dIM6bMAdBqKc9vS1SaPzD0KHTDUs/Iq9Zybm2DlZUfN8ZF8lrXmhck22FmNgk1jP83DhyS4d
	p/YUlcF6SNykqfQbpmcJDqF0npZ57wfaRuSY9bG8nrMGOo6oB5o3r7yPiggUL6W0TqoNYRbajye
	UYZ4fDe+t3CIK2af0xLYNdedooPGnaOGB8+ObiEzlH7MkfFYlKyIJ9o8vH94uN3znA+OFJ9PH67
	s7OGBruGsJbNOxuMQbuxuP7d6+dsRBYYMqi+QOtiKlyKzUTs2P
X-Received: by 2002:a05:600c:c167:b0:483:9139:4c1d with SMTP id 5b1f17b1804b1-486fedd4143mr1122835e9.14.1773943687060;
        Thu, 19 Mar 2026 11:08:07 -0700 (PDT)
Received: from pluton.example.com ([105.72.248.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fe880c21sm1172165e9.8.2026.03.19.11.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:08:05 -0700 (PDT)
From: Bilal El Khatabi <elkhatabibilal@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com
Subject: [GSOC PATCH v2] t5315: use test_path_is_file for loose-object check
Date: Thu, 19 Mar 2026 18:06:52 +0000
Message-ID: <20260319180803.164335-1-elkhatabibilal@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160301.98039-1-elkhatabibilal@gmail.com>
References: <20260319160301.98039-1-elkhatabibilal@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use test_path_is_file instead of test -f when checking that the
loose object was written to the expected path.

This uses Git's path-checking helper, which provides more specific
failure output than a raw test -f check.

Signed-off-by: Bilal El Khatabi <elkhatabibilal@gmail.com>
---
 t/t5315-pack-objects-compression.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5315-pack-objects-compression.sh b/t/t5315-pack-objects-compression.sh
index 8bacd96275..d0feab17b4 100755
--- a/t/t5315-pack-objects-compression.sh
+++ b/t/t5315-pack-objects-compression.sh
@@ -10,7 +10,7 @@ test_expect_success setup '
 	# make sure it resulted in a loose object
 	ob=$(sed -e "s/\(..\).*/\1/" object-name) &&
 	ject=$(sed -e "s/..\(.*\)/\1/" object-name) &&
-	test -f .git/objects/$ob/$ject
+	test_path_is_file .git/objects/$ob/$ject
 '
 
 while read expect config
-- 
2.53.0

