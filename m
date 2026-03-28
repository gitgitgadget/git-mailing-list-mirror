Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6075D33F5A0
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728196; cv=none; b=u4DO0tXiuBWKKp/CGhyO4n5MFKH2BvkjvKZCYvF2KHDJGXWyGkWqB4Iwe7oaZpD6nISVGFhxMWW4suKyCkPnp5Vsh1vpcfvIZkaguaj/YOyeIqiblGH0hkdBZ62LlyxEL1vPNSXOmLarp/tFW86vxDXY5MMT3WNxEuuLlxYAOuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728196; c=relaxed/simple;
	bh=FRoyrBwVFvkXPNztYJqKMbP/VNw9SB+B7whQsdV4SDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jloTkIEGIZdnmQLAm3zuSEpO1ZQhSBcnQtJDr+RetUYpfk40h6UcS2XySvLMfNxTwbSFhx1njOjADpWcOvtPkBX9fObyQCicFU1WiAEspaya6CGg87IxBioptl/Xm2hVT2RbOe8xo/q+UcPH5p3837sSGnKYM/5P2R9q9XCsjxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqME+BND; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqME+BND"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82748257f5fso2317318b3a.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728194; x=1775332994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76k2SmGe4TtR4e1s5g+vjKCkq62d6pqCmWn8PrBCg40=;
        b=PqME+BNDKX1waVk6M1m2UTx39D1j8UH2eqLdeYlfGxMUhT3TTw3JJbgU/xlf+7gqsr
         VOdkW09btsGLinYveM6T0XlC30P1IqK/lWTpxv0O2qWMGL8V5AgwtMpADCrCOX7nYZp+
         rGOIOLrvwYaEnFdfLYWMVO0juMKrbmsVwgtSqovAQ2/bmIcrnnKqUlcsfEiitKfRQOg2
         1vbVnK2BT4udL4OiZyellmI22A3cBJlFVaFA/9de5Vrgzbl29k6RztH3iCs6dJaQICa8
         fkZ2leibXpbtEeqTlRq/u+OMOoZ+N0eZXvVOm/WpayY1H3KnX67hm5Yqp909HFKtsgwx
         8G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728194; x=1775332994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=76k2SmGe4TtR4e1s5g+vjKCkq62d6pqCmWn8PrBCg40=;
        b=K4/coJvb0zcDWVmIuudvViR7dWcRmvU+9DqbIsVWSX9aA0DZq4YXh1VvBU36txMsui
         rw1yyjQ56mWApxu3c5mEae+XbwVKtVGO1giIxKvG0jBvG6hKTIArLhzEPUSnv2+W+9/p
         MGVQ+LreI/pqJiykTcnjh00D31eP+vIFGr7AYLQdZUkS8hdW1yaq0mbRFGlzBWcVw2eU
         8snYCxgOHo43iPbuJuNUMJ5rCDGGuR6vljR5EfM5FVoQroCMAyDbGHnhTbnpt+1NdsLy
         Rzy0I0UUjB16AWGCm1D8x3ukqnciNpZY5599dDbNTe8lffbFDUl7RPnFCHhU8kOAMgS3
         zIyA==
X-Gm-Message-State: AOJu0YyaZVDlxuePRmyHEl0mQfydbILdADG8Nw6i9PVyFyfrtF1QqkSF
	1mrV9W0O/fpbldZkWTa461LQjrswNlJ6z15R9HU8JkkUps2KXAGK3R2Kqb2zyGB8
X-Gm-Gg: ATEYQzzPJYka38Ka4J8kyqCk1QhN4zNVFdbwjKsJWREGdxQlbz6JiCy7w3Tf46+GAl6
	wY/5WQ9HpzYCdGH6CSEYVMJTxqMG4W9Qf81vFI64cOJ7rdYlSaM8s3f5BnyFxvL1oxd4Lo4Z+wO
	i3VKcBy7h3/f7NYVuf5dWo2Cd7KmJrSyt/OYXaJpK2D6nhOOVUowC7q7NS4Xp4qKww3NLEwf4EG
	Eibq+AmIVRCKYY08EmRP1nMexQTXxJQRYHQscDdjUXbLLhKJWyj5tZTHe0jO8IWCgFzVbWtkRBy
	UaBzmOv+TMCM7/Zlt4DKZi0VGyuE3Ae8al2YrjNSlCQOmOuzkDxWrawTBHH2+YVx8FxwT7LmMiV
	0UD9wuWumRzrSHnwCQWAa8XHWQDStqYp+rKNfnrpJvrsfIP/34sBo8JLNMoEGJUKkknhsoyNFIc
	eLQ/cE3NLilC1AX3euepbJ6lLXI27xqAth1/XhNPwlX6nHIbxHT3UUu/LmcPaMY0RbciRjjhYCC
	xvhI6mRVw==
X-Received: by 2002:a05:6a20:6a06:b0:39b:897c:6f84 with SMTP id adf61e73a8af0-39c8a6c2d62mr6663967637.2.1774728194477;
        Sat, 28 Mar 2026 13:03:14 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:14 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 05/16] t6006: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:44 +0900
Message-ID: <20260328200255.247759-6-vikingtc4@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328200255.247759-1-vikingtc4@gmail.com>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update t6006-rev-list-format.sh to redirect git-cmds output
to a temporary file instead of piping it directly to not hide
the exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t6006-rev-list-format.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 581984467d..8eaed7c502 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -289,7 +289,8 @@ test_expect_success 'basic colors' '
 '
 
 test_expect_success '%S is not a placeholder for rev-list yet' '
-	git rev-list --format="%S" -1 main | grep "%S"
+	git rev-list --format="%S" -1 main >actual &&
+	test_grep "%S" actual
 '
 
 test_expect_success 'advanced colors' '
-- 
2.43.0

