Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C118E04F
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 16:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134836; cv=none; b=nH4+ITxFcqikzXNSyNnhWiD/XJQ1jnNqF4rdA6VW1x+vUO8SApaZQg+je4WfpA9dgpQ1bCYGvQgaQ6Apc9Ome43yLstCknzkhWwqvWGbDTPtGaNQ+QkdrcXdRzyDGqzcqOwJZBfbHcLYMfPPMdZzUqXh4C5zwXkQ5F4mWiEy7Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134836; c=relaxed/simple;
	bh=cVnzW/t7yDjmYeF1m4QYbod7/h9J1VyvJhohHmlXetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iu8LzOMiwiIaJETrgkRpKD9bQ0gkrmSLYW326gIaQFh2wDAyPKoji2dBQk43JWSiQ45l54UD7NYEjjpA8/SUfN3A3SnzN7mxbihjzWro12bgwtujFdRHa7rT27j3PlTIKXqdpO+W6mRFGuxGoNZf/w6zo35CdjE8eG52KIeXt34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0f2FpXL; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0f2FpXL"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-369cb9f086aso673507f8f.0
        for <git@vger.kernel.org>; Thu, 08 Aug 2024 09:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723134833; x=1723739633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChTqVIhedESt7Td/x+aw8MzbS+2WwLSHTWPfcu2d+8k=;
        b=g0f2FpXLX7dlatSrdhHRfrNHliEtijZAQTfdUwLhlNypZOOkVh1To5HjH0sSqgSjeG
         CGsqrGO1/Sipl1JDTJIeFOOHlOr/np80F723G6ST15Db1bPiPkZtAh3id2R56DvrSSrW
         JppmP6sWFcWzqDkz+3TWtdWOFcrTAjLIfV/jlo3C5UO381W/BfWy2UmgB5HaG7OOA6ry
         eT9x7aN2vApjhSn6KqRohfVumhNsxTRRulpEGnwdJhFPFLVhbtmRD5GikxO30tosEop2
         1hQ4aLll4Aoe0FWPGd7tkP3YsPXW3ZMfrBv56d9MvXinSNiFK1wPsa4yArc6NCVbF1B7
         Yb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723134833; x=1723739633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChTqVIhedESt7Td/x+aw8MzbS+2WwLSHTWPfcu2d+8k=;
        b=Amz5THCpRvhDw0PhuXzplA14WyIed7kXsS/vTtiFtN8JUwoac73Vjv9KOCJy3NnZfG
         Q2KZCdr7j8bP1IH6NfpmDTh/AN/u02b4XnWL4eJYwHmq66NadjM0w4R5xpmmYQSoty/T
         1AR0lMrcalKRPtseyW8slfZI5v2MfhZRffMe8lMzCfSkKiH1c2TQmF5XixoS0elasHRN
         /+J/QLpCUfqhxIU1Up7tn/y47rcyDPmqhywP9j1BGsfQIqqjEXBkkzTbb9YMjKbNfA/2
         xMxeeViMmjl4rrN5asme7Z1dyMYLEM28Nhqs3Tw5SVdJ7H7Vanb5b+jR28KXM/4VqACh
         HkjQ==
X-Gm-Message-State: AOJu0YwZ7NejZwHmjf4Ck+xkma+zf7u+bd2fi6jOAoBbwYFJrYAT5tO8
	RO5ZS8gsHMVx+BaVrMBEC55ocqsDmC/3b5IMEUkkTwE8LLCQNti+VMIs+JoDlw8=
X-Google-Smtp-Source: AGHT+IHLWLaC9qtw4i+Ms4jatRGIsjPc6CPMDeXIO5CBbd67yb+U4C41AoaPZDtcTpaKZVk4axdcoQ==
X-Received: by 2002:a05:6000:12c8:b0:35f:122e:bd8c with SMTP id ffacd0b85a97d-36d273e0b10mr1818307f8f.17.1723134832643;
        Thu, 08 Aug 2024 09:33:52 -0700 (PDT)
Received: from abdobngad.. ([154.182.250.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27229689sm2415765f8f.95.2024.08.08.09.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 09:33:52 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v6 2/8] t7004: one command per line
Date: Thu,  8 Aug 2024 19:32:01 +0300
Message-ID: <20240808163302.17521-3-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808163302.17521-1-abdobngad@gmail.com>
References: <20240808163302.17521-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of the tests in t7004 has multiple commands on a single line,
which is discouraged. Adapt these by splitting up these into one
line per command.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 3100a4c219..09ce287559 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -213,9 +213,11 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l >actual && test_cmp expect actual &&
+	git tag -l >actual &&
+	test_cmp expect actual &&
 	git tag -d &&
-	git tag -l >actual && test_cmp expect actual
+	git tag -l >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success \
-- 
2.43.0

