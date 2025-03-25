Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AB2E3399
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889717; cv=none; b=fO43gkAyyz03+sUMHsyXc5ZefwPNK7Y5bjA62nB6Ugh2MQA0G8AP+j02pCsHp6pxlNhIyfJ1Ts3IUKyYmHGRf+CKBxPTHvpbX9G51Uyvi14F2TTkjwTa5vj0xsYi1kSA6YSWJZoUm+dwaHCPNkkxT7fF9Zp9Uo7Pa72TcxaZD7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889717; c=relaxed/simple;
	bh=096NlR7sdFgad0VqB+iU4RJHMcxdjrvh3asPP+POyYY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s3oS12lzSDwvOjFkeT1np8QEU0nL1+zUtd4PIL/8ROrR65aS8eY5IsFcL8QwgF+82q9tqx63hpCvJo1nBYYhEJO4kldRoPnwtxOWUZP3LjAF1p3dQI928FHd+AfA7teDZVgGs3n8njcV4JJ9dMC2W1Hfst55ocvY593/9NXJlyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7sE/YgR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7sE/YgR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so36897305e9.3
        for <git@vger.kernel.org>; Tue, 25 Mar 2025 01:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742889713; x=1743494513; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vvyCzQ9HvNQFZGMQ0NzT8gRFysyDAzSdY8pTUbkuuzE=;
        b=b7sE/YgR1t9eu4eAetKCwES+2oiAK7O5tcLOf2HhVOdp8kQXgspok1B/gB5mIWhA2w
         5kH9HE9hdmwLtrU2iWOX9NCuFfR2Le1XdI/nnk6taCyNOT+ulKLAsLjQF6+CAbHA/TZb
         e3YZE7YgJHWQZb1BkmffOeCslVSid5UschBVOvCQJa+llzOSIMzt5nA1f29rMpzuUIaF
         6uWB0gXYP1REM4rbKKc45T0nCwIHai4XBbCTcqo34Z1Jprj5hgdTczoVC5Nm1nbnEENy
         ElYN9ES4mOsCRoWTrH0snkw0F1YkNcStv8+zuqq+vYpcEIV59TIDKwmOnHnNHWzv6kIL
         3aWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889713; x=1743494513;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvyCzQ9HvNQFZGMQ0NzT8gRFysyDAzSdY8pTUbkuuzE=;
        b=cg9Q1AHoXDg4COmoZ+ezuxUHy1N2x/+q3+pTZynLEU7V86u4cySGz1xGp+QMLRgSN+
         OGHrBTuaCc0lX4sAccYJ67+uD45bMvCzdz3LIkEe2Bw2M8plC5KPbYGivKO0wRwN0F6V
         WLeD3HeIZLotkGtxQ28nUCFJhVjTE2zOIb0Ef6d4aVvY7ZFEsWRmNHZY6TSxpiy4GRfY
         7tzryjUV2QH45LjJLc9jGjt+OI0NADykthdprofzMllH8qbR9Nn//fLjjll83V52pdZc
         tTeHIZZsalNSYLY8FaC/8XjdnHJl2Ea0gCNsrBTEq/j3nrvS6BKIbbH1eLayJ6cIWdQB
         5CgA==
X-Gm-Message-State: AOJu0YxhmTTr2AHM7dfzm1yHuIBq64Bqgb+YiIDQmhfGOFIBo1Yq0cN6
	R90kcbo6C/Z1jyUaOidWAIZhkD+/cPn7eMqWTKMq0Fcsn2KkwOyssjF7pA==
X-Gm-Gg: ASbGncvnxFT/J6bbUNH3vUpJSa1m20ZPYgunEPOBIfR0DINMOpvV98GUzTLbcA8fJ8z
	g2/IHje1f0dfd3SSyWUmOdgmgHYUJL5pJT1ks8fOlc55hQKiiufr/Y5NyF4CrA9PkGSuoYoYb4x
	jSItfo5ScWAE8KulwKtm4alRcu0P7i2iXJ3fq2SbhxGP3+NT9SacD85Cq8AkpX5lU2YfBeosiBW
	QHH6LYlD2KdW3hl1G/2UxNtM7ifCBtwNBGszSTBbVwag8EBcbRpoahXxs1aRtOAw1xQTjopdEA1
	zwHMjJiT6g3af2mHAWFFpJpi7BlKYnMURXjGF01YPFHS/g==
X-Google-Smtp-Source: AGHT+IECGkJvdOBV16X2ZCsVdi96u+MuOdeGxnIGSFqoupF4gsdoDqVyWAww530Atl4edJWhT5v2oA==
X-Received: by 2002:a05:6000:4188:b0:391:c78:8895 with SMTP id ffacd0b85a97d-3997f93d4d0mr9757445f8f.50.1742889713129;
        Tue, 25 Mar 2025 01:01:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac8745d9csm1046187f8f.95.2025.03.25.01.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:01:52 -0700 (PDT)
Message-Id: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 08:01:48 +0000
Subject: [PATCH 0/2] Avoid the comma operator
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

The comma operator
[https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
rarely used in C anymore, and typically indicates a typo. Just like in these
instances, where a semicolon was meant to be used, as there is no need to
discard the first statement's result here.

Johannes Schindelin (2):
  remote-curl: avoid using the comma operator unnecessarily
  rebase: avoid using the comma operator unnecessarily

 builtin/rebase.c | 2 +-
 remote-curl.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1889%2Fdscho%2Fcomma-operator-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1889/dscho/comma-operator-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1889
-- 
gitgitgadget
