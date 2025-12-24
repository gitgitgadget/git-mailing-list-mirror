Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6DD32FA35
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536581; cv=none; b=bubNfiao1Aq7/SFAnrgg9G02mnMyBvljRZvMl5+JtXVfFDQDV7KHWyag3flZUh0ELSj3LwUOCbTKBnkU/Z61h5UxnfuCCXi9UZfqQkKn42slnd4J/Mqj1UbapxDcd4xGOHNIbNYhwoRkr9EsIEHAiCdQbFPGobLbvlEBEaDr7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536581; c=relaxed/simple;
	bh=41fhE98Wvh3DHiI4VONx0XFEuCq0sRhXuXjmD2lxUb8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuykjjNEoUF3HH4LTrtxGQYjX5it3U+KHBLR7L4cvyxkvCqYei8+okE8D73l6P8PLkP9pp5dCSCIEWjTIRGN+FuJeGyIGsc84YKpGkd3pF5pUIzDWA50WMY7OkG/8jhQVZW0JXvdLpEeCsWnZUUtRQjcbDQrS9zs9PMf59p6PXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLzkxBOJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLzkxBOJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779c9109ceso4231485e9.1
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 16:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536577; x=1767141377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVHkzTDs57bNtnTC82tqUHt659YWVgjaREuIiLvGx30=;
        b=bLzkxBOJyN0aO2OF+zvIgZmve4BPay+7mzcYjHyFRp4ZJRPcFC/WSfWk2B0PIAzsGU
         bTWIvl606LkcwUK8Q/SPElSSF73i4/8coRyV+7jhkKZrSZavYIe/KnQR5F001KTzUQl9
         w8wwo2Gv6n/+RYJ9FxtRAKsYPokS1xtKxCtSLiKaqVyTWZQCgCtJuIEnStage43paD1B
         BNuM5MDQjeKyPX9JtfJ81LlNZd3l0QjbAUUv9s162pKhWiCgS9jjNVkihh2mOzrM2xGo
         HxltFwczn6AESX3pjsb74aAtJFpTEBLDNIGsq2ho2IvHdsFtV3sN2DhlnhIp90W9Yky9
         DuWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536577; x=1767141377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BVHkzTDs57bNtnTC82tqUHt659YWVgjaREuIiLvGx30=;
        b=H6ZAQ9fM8i8gW8YEMB5hIoE8f/pyiJCFNVScPHfkFrufBtNF/nNo0rC8hIVEl/78Gr
         Lfp9PKUHKa9AKj/1gExA6xz5pnDzEoy4JBv6yKfzQxmOzmLKzTAOw4uJxXVelL7iP+yq
         K4FgpYXVGdVABb2LeYexRvg0eKuMm1hhfK28vZ3iY6l25RfRTYhiVwpy5XbP7bzKJayF
         XveLeWj8wcP+kEaBtIyamF/wuGB7a9/cZvqsEvjFJdZF7IlRYJF81cD5kP/2Sdm5rjly
         vjBoFN1hdCj621F2iMMk/jEczx7RGoCzDPQLyTrsvfdyYqFCFizV9LE/i5BgAyB7g4yW
         yl5w==
X-Gm-Message-State: AOJu0YzV0tP68UmNyqOyNF/kLOzrqVJouu6MbA0ZtjINmIEBDqoK58iv
	XGVrFA+hQhJGvK4/DbL01tVg9aRJCfizEkzODL2vyp+VIJ61/7rde7sLnnp1ygGK
X-Gm-Gg: AY/fxX5gKudfrZmiYqXf18mgz1RZ7pmEwWwoVwSaKIv952e1LKfZbJfOxdRxCc8pFZq
	jfWjl7tteBv6A5Dk6pTR1fkz6MbMajD7PGXgW/FPuYIF/THXUtV2lxmFc5o6vIqYrZ2vQIliMps
	xUGYimny+p/BhCkUM8WdJj+WT3j+WYy0xsd17C6WxU0bVULvkIm7Df5fS/Sst+S1tMCr45kLeiW
	QFsRGaiL42peq1PMa+VSqCUiur4xQu6UwkT/a/6OcHOYy4wo3bxekpw77nMB5/+ZKqqSpKbIXS7
	UXor4L12jRaYG56y5azUt4f8XxEw1trltp/rZqgK/+s0tCfj3838Q+vl0j6puYQAR0daJcvYmqS
	H8y5Z3rJQr+GJJPiMCZefpneQ7Mw5teIJYR+JiYgFahppVTB6WCuskqtjYf0irzV+vDOJQTEEjD
	RKJT24ByVK/fF7TkboBygXcD0JiGfjVN+YeTTdHKMNjDBTZsIm/Vj4bDEibYaur5HCCCR3Hw==
X-Google-Smtp-Source: AGHT+IEvSxvjsDWka/dNwslf3zyDaEyvNMUAUGk+GwNeGysYGEQyFBy/pZoZ6mVSzdh56nkYB054Ew==
X-Received: by 2002:a05:600c:b99:b0:475:d7b8:8505 with SMTP id 5b1f17b1804b1-47d195a4f1cmr96973125e9.7.1766536577240;
        Tue, 23 Dec 2025 16:36:17 -0800 (PST)
Received: from pc-128.home ([2a01:cb15:523:b100:b9d2:873b:863:c3d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d193522cdsm255240075e9.4.2025.12.23.16.36.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 16:36:17 -0800 (PST)
From: Matthew Dodd <mats.dodd12@gmail.com>
To: git@vger.kernel.org
Cc: Brandon Williams <bmwill@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mats-Dodd <mats.dodd12@gmail.com>
Subject: [PATCH 2/2] t5703: add test for shallow fetch with ref-in-want
Date: Wed, 24 Dec 2025 01:35:04 +0100
Message-ID: <20251224003504.52660-3-mats.dodd12@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251224003504.52660-1-mats.dodd12@gmail.com>
References: <20251224003504.52660-1-mats.dodd12@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mats-Dodd <mats.dodd12@gmail.com>

Add a regression test for shallow clone operations when the server has
uploadpack.allowRefInWant enabled. Before the previous commit, this
operation would fail with:

    fatal: expected 'packfile', received 'shallow-info'

This was due to the server sending protocol v2 sections in the wrong
order. The test ensures this scenario continues to work.

Signed-off-by: Mats-Dodd <mats.dodd12@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 249137b467..21f4049eb4 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -256,6 +256,15 @@ test_expect_success 'fetching multiple refs' '
 	grep "want-ref refs/heads/baz" log
 '
 
+test_expect_success 'fetching with ref-in-want and shallow' '
+	rm -rf local &&
+	git -c protocol.version=2 clone --depth=1 "file://$REPO" local &&
+
+	git -C "$REPO" rev-parse main >expected &&
+	git -C local rev-parse refs/remotes/origin/main >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'fetching ref and exact OID' '
 	test_when_finished "rm -f log" &&
 
-- 
2.47.0

