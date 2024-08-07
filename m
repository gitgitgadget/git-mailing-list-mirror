Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8325D1E6755
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723035814; cv=none; b=BrMBHchgj7Xl0Fn/PfOQ3WyerbM4njMCdWMG8IG+uzeU4JCVVI8TVfWfWCGP7hzymKQzE+MXLoAEGJaTJUWaKMi4KaaVDni4nNyzsoDoS0k+MCdYI1cosYkhZp3/pM+BQAubMQSAaxCRE9Ja6AhbKGD3Fnm0dA9zoGGZt6MNLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723035814; c=relaxed/simple;
	bh=cVnzW/t7yDjmYeF1m4QYbod7/h9J1VyvJhohHmlXetU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmWtr0XrZp6wapPSeKlUGICV7Kq+wUs4HofNi45SxWweN8M/n8lOuxm8xsLQT1VZoSnEA/vzx+/XnLPeUjUgborUfHDQWgy/Wlv1fJpUZS20WQdUku8ULKDKCoLV4g2kHjYzK29okiXxLRacfldskajiBScfdeJB7HlZSetZB0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ4a5vZC; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ4a5vZC"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2f032cb782dso16535021fa.3
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 06:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723035810; x=1723640610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ChTqVIhedESt7Td/x+aw8MzbS+2WwLSHTWPfcu2d+8k=;
        b=DJ4a5vZCpDk7DTjaOYcKk6gZFesuX98kbXy8np+NQHjxQVBazUVVREsHdcbU5WcC3s
         3ziUn/WGMM7TYBl+W3CA1JbsvjZQli8LcyyJEnEXKs6/Z1Rwh8rKN6UZt6WHRx2l1VC7
         7F5QA5VyyBQNxqdkljyBD+M2xki8fZSjlULHlrARRT9cYxdmMMcOdcGdJOrwWzaT1JeV
         +qfUxR2rUIyvZ3qhj55HYudGbsf6V2mxgTZw0e9k4InKDREzXdoO1iIs0Q7hqF2fF1Ub
         xxddwFlKbGZSJJVXZFarYV8Yde1t2z5MGD2OW5pFG0RzHK+OIwKEu/ACoJVUa1cNqHQb
         ox7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723035810; x=1723640610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChTqVIhedESt7Td/x+aw8MzbS+2WwLSHTWPfcu2d+8k=;
        b=c9g4S3QsFXEN7d++VCatYbseImQ9TlrQrJDQOSbxUF95J3p1hmw+irxQVrRRibGWy4
         mlK/JcUISVrdQFjpy3MY7huyFJtic052DicNFcME8sBnih2Go/NpG9N97L718VD2GMQz
         Sbar5x8OqHLFLs0xJRpU+oStyCubwH0lbXaQ30HLYTKKBZeaKtXSM6D2laB1lnX9eTyX
         ZOjWq1AcvHGHTLX7NEBwu2JTJ4QuiszEywAmCJPqfKtpemxM+V+90Oqu3eVME9UM1b0O
         wnoEcVHoVyrCBoeN7zZmz70EDJIDZMtc9U+P96PCfHAygrW4uzvKpdSIlrNi+yRd9ijG
         ukLw==
X-Gm-Message-State: AOJu0YwkGGEvSLNpuM3IU0A4aM6gzpTloxO0s/SRKML9/e89ISixGbGY
	TMeGQQrB2Vzo+nhGo781RbW30vJ5fNDc5VJOHQZw/hh1uFF9y+zYXd7sZl8B
X-Google-Smtp-Source: AGHT+IGjKXcFGETKOGWKtIWGOK6kQrTxpoUDrw8Sr2wn1zvGeEUln6QsNQQCFKQrun/EVRyij5GBcQ==
X-Received: by 2002:a05:651c:95:b0:2ef:1db2:c02c with SMTP id 38308e7fff4ca-2f15aa83909mr123920331fa.10.1723035809605;
        Wed, 07 Aug 2024 06:03:29 -0700 (PDT)
Received: from abdobngad.. ([154.182.238.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057968d8sm29196825e9.9.2024.08.07.06.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:03:29 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v5 2/8] t7004: one command per line
Date: Wed,  7 Aug 2024 15:58:38 +0300
Message-ID: <20240807130259.28381-3-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807130259.28381-1-abdobngad@gmail.com>
References: <20240807130259.28381-1-abdobngad@gmail.com>
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

