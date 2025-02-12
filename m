Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DEE27183B
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330836; cv=none; b=Ubt848Fydm4kT5RVC7dnbbCH18pdwSnFcYcFMacGTth69U5CMB+NLjWoIJaCnPpMVjFbrnAyrOoaBDMVq6xm9+XRsBQXc/zWm7vmupGd61GaWgceXnKzwaxgXBFqyls/BXdo6eTXUUOyXNGl8MKrbrqAg6lDG9EQtFO/nzHE3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330836; c=relaxed/simple;
	bh=Rr6m/A9IQb396HWEa+1Qnky1V1CFb9AfduJm2EFAYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKdv00YSb8PmvwuDlofH04gXaIJRza4CiUgxs/pUksWTD7PdIK75KMPjvxLtb7IydOEDwrawRcT/olH2g2h/XQl3p7Xyz+5yWXcPRyZYfBoc++rQSyWtHdTgTZZzqBLUaqa/JXdPhQel1YKOVK/9FL0RI62sRkEVy64WJd5vujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWuUj3PU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWuUj3PU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f7f03d856so62832505ad.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330834; x=1739935634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VKzQoKAngCs6HWu9yDO+usfiXV22m58qAkD3sftzJCg=;
        b=eWuUj3PUWSgwa7yc/nIEGgVXCY0zuK8AwvsO6grSlY26pagu0YkykzV4bpA1nGMSHn
         To3w9OLC1kzZq9RqFoncZXPzIdWsedu5YqwViAO/ob7q8SoLqYqiWY6xnpBUc9Bn4L8p
         co3YQClbWvqRmil+a2jroJjjT/ge4t4xq0k/J5Y6UEOXiEongA6EzCHKfF69Z4vDJvFE
         KPHf0S/28Q7B9B0IpJhSrHCCgRZtHW5dYU7DwZmDKShy9bSROo2PZMBpL0G6ELTFbz6F
         5fESja/6casd5ETM4sI+tmITjVVCVZkhOUdnpXRF41tzT+X+KilU9Wxl5vtbCuCQ6YmH
         iU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330834; x=1739935634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKzQoKAngCs6HWu9yDO+usfiXV22m58qAkD3sftzJCg=;
        b=uq8TA6t2YtV9oY3tmor351UpF0dJ4CJ/FHtFkTqfEyVdvf+KpJ6C1d4WCUyFJYH16w
         bkqpPdfVYlfcsZCK+qqyrpodT9zf8FJ7C5EZd7q7MFYLgkIV2ip41iLB5CHCSagjZysx
         mP4qUz7B4owc/qWnfLj9IS0Z81cTffiUI3WahxygKPXXLPl6efSV9PLwYeNnDYk/1IIx
         P47cDFuo55jI/obbY1mwODoF8NjJuTzc8kEHAMUqKhHgqEqFL+J/7jAROeat0I0vzYqI
         gvQpm133GAD4volE3bjnOyozY92agIDRcU1ITorTQyqk4fpFbejZ2GGI7caNdBRDvB1U
         c/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLczZXYv/h8u6vA1EoQwbTHle9DIK63S33uwxjInzZ7DEZlmf5+G1cC3Ioo5wMIokQxsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YypTKrQEuQ0bSgq/6WnTb1M8j5RAhZ5FiwY5xBMwSmGoL3poxUv
	4QoX65+/mQb8E5tefJDzqGUZ3K87gK+ywKdOAeHipQIIkVM9rMdV
X-Gm-Gg: ASbGncuG4JIgwo/8hAborbuLR80VrCIGGQiJY633/hQLf9jdsCBs+B9zvytNCudPgoV
	uM+0ZCMLnjSZLv8PCaegNXGaHkzl3BsexGS5Qf/k9ZOKV9t+iu2WDzNntKXr6KC0PyrpLmA1mZi
	RE7OMiy2+kzFo6MbnIXPxJ9r1TQJtvoEsPJmo/B1C9smpacUQy3GQah3Hx8n/VvaAOX9D3r848n
	OekecLl1aXUGE8+Gq9ZycojK1mCHp5bhOHq+MmBxrr1o357W6j/BTqjGjLQzvGgZTqWzm8IazfG
	2vEUENTzL9Lv+x90keXf97p3q5C4F36HPM6k2L8=
X-Google-Smtp-Source: AGHT+IGH4YoDm8lG0E7Kenoo0hz/BMKCYf3ns/UKm3pkk/49tMTBtcRz7vjOX9/oPcE7ADEmBj6OyQ==
X-Received: by 2002:a05:6a21:695:b0:1e4:80a9:3fb8 with SMTP id adf61e73a8af0-1ee5c73efa7mr3001366637.16.1739330834191;
        Tue, 11 Feb 2025 19:27:14 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:13 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 01/10] t/t4209-log-pickaxe: Naming typo: -G takes a regex
Date: Tue, 11 Feb 2025 19:26:45 -0800
Message-ID: <20250212032657.1807939-2-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Not effect on the test logic, but as "-G" argument is a regex it is more
accurate to use "regex" as a dummy argument value rather than "string".
In all the other case when "-G" is passed a dummy value it is spelled as
"regex" rather than as "string".
---
 t/t4209-log-pickaxe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index a675ac..ed70c 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -89,7 +89,7 @@ test_expect_success 'usage: --no-pickaxe-regex' '
 	test_expect_code 128 git log -Sstring --no-pickaxe-regex 2>actual &&
 	test_cmp expect actual &&
 
-	test_expect_code 128 git log -Gstring --no-pickaxe-regex 2>err &&
+	test_expect_code 128 git log -Gregex --no-pickaxe-regex 2>err &&
 	test_cmp expect actual
 '
 
-- 
2.45.2

