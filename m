Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD261DE2C9
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838075; cv=none; b=pkMPYRtp/ofWuYApAo+6v7tN/h7cl+HUdCVRj5u7x2wYBauZh8P0k4SUiMwJzUn3ShpceuaC0Q50Oz3aX9uKQDjPrPDbIug+pLVwLjR6ywuQrrzuNpjLuvs3VvY9Ktgis7iqeYWmTtNRJVdoKxuG2UhaDf/IAZcJd8xjy8M/0/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838075; c=relaxed/simple;
	bh=t3Pb3+RRMBRe60o58lpdvDdPfNoyE10b181ECcPvQGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lqTTZ1Acy2ynUNwg9MQQPfokpCaBsLEMxvxONLnAlhpWdy4o7RgV4WlcFfUp9riRewmcD2kk6YTAp5LJlY4CdtzbQYvLgKeALPcEvw3wzco/pJBHUmF7p6Cn98sRyCHZ65PMOxQeMAFjp8WGC6xetFbzNMWQUDVXFZfpgyy0XJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OY+PCi5K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OY+PCi5K"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-748d982e92cso1448165b3a.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838074; x=1752442874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+o7e9aUGd5CHnAXuiSt0egaqRrT1oB/2k0TRu0zie/k=;
        b=OY+PCi5KxaPScPiNyex2cPHZ0tNMbIwIDSQEbdH1F7seV8Yjqcjm2WKB/U3gjlikbW
         ab/55sVzEdrG+YzAoKwzEE/ZTZ7Qs4N4F6X2cXJ987l04v0i+1kHQ02HrlCbiyYZrGy8
         uGnkiiohoFVcu0qRHj59Jh1THw7R3QTS2FZIF7rPXXQiDwnmZqzKXbnK44aGgaOtmmZi
         21KOAxam7+/GeXEfYdXBIS9HkehQHHDTHky5Ey+jyT9BiEPgkYTib6XyXJ1xBgBkP0U+
         pMNix4X/SYe+p74Ah3IKZBf75RT7awoOil1g/IRH56mIUgmKSu7pWO9NBAVRoxPiJsMs
         gwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838074; x=1752442874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+o7e9aUGd5CHnAXuiSt0egaqRrT1oB/2k0TRu0zie/k=;
        b=AKgdNEKWBQN/RJ6i79CP2uJ/wjTbAyfxpnmeZBV1w4ydrmo4a3zPxhPVhz8GJEMEZP
         T+om4PcCUTUlNXjunV21M+EI2sSEkCQdPK0i/W22Bni41q7BNOr7+RtaYcIVD69oZFSH
         gvsr7XNvpzG5d85DlAZ6qWGtPHFrLxOmzPE1s6UbLBCMzAkHtQwwa0Q5jLbmBMRcWDB0
         /fkAGNNGCb2lKDEYRSpjFS98MkYCRbTFzag2oYVgJwOM+UfkqwI9cEk+pbeIXxiGTrTP
         Ge6Lf1S//E5le9dbAwFD1tUcReksdT6nzYrINrVdPOh3irnz8+gPna9/ue5DbLST6Ri9
         xWKA==
X-Gm-Message-State: AOJu0YyAi1a5f8zb6BY7N2wJWQfM2uMHQYrUla4NsuuwmeNiW0l5vGqT
	A+oguN4LamhoYZihkd6AUhht/qxh/ifcjBBs7ZAlRSHNg0Uuf37r3hv6X9PwFHzvcrs=
X-Gm-Gg: ASbGnctu0uyKkiz9JehhSbd+TrcaJL3b+Z7Hbf6aG4RDrTMCy4EsA34uHLPRIiC96uu
	EM6OL2eH49XeHqO+rKJifM/vHiyiDuBRkq+nBAdjVKdQyZtFnlV0afgs/ajlraAJHihQCti+7rC
	ELSvMPqJk4nfGgmmYUs6pY0HhHq+G3zdC+4gVROvv8zT8fFomlZJT5DWZZIB/9ulY5iEVM83MD2
	uNAkfkcoLcAYwLzqkN/STbOSUTsFQi8qLMzYRGF4L8uhndpX+8B5EF6jNQKmnbKh1jloHeYPl6V
	O4U96mgoNOCZLkCVpe2SwO/E4pOFc1aoXFfNF8rwPv1iD5Q8qfNmfAzBxfTnhz/UDuH8ZrBPUGB
	lYx2UPHKu/z0=
X-Google-Smtp-Source: AGHT+IFTpyAjE7KdRSrhNv7LFli9h0MGW+GiVPvZyQRV6UGXyyH1aR3oWGn+hk6SRxgNR+Gia7xcWQ==
X-Received: by 2002:a05:6a21:48d:b0:220:1215:fea7 with SMTP id adf61e73a8af0-2271ebd9084mr9388767637.9.1751838073663;
        Sun, 06 Jul 2025 14:41:13 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee60c55csm7363968a12.43.2025.07.06.14.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:41:13 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	usmanakinyemi202@gmail.com
Subject: [PATCH v2 0/7] move builtin help test to t1517
Date: Mon,  7 Jul 2025 03:11:01 +0530
Message-ID: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In patch series which contain this
"[*]: 43a8391977 (builtin/verify-tag: stop using `the_repository`, 2025-03-07)"
and some other builtin commands, the help test was added into their
respective test files. Since it better fits thats tests that check
command behavior outside a repository should be in t/t1517-outside-repo.sh.
Patrick suggest moving the test to t/t1517-outside-repo.sh.

This patch series moved the all the test.

Changes since v1:
  - Fix some typo

Usman Akinyemi (7):
  t/t1517: move checkout-index -h test to t1517
  t/t1517: move for-each-ref -h test to t1517
  t/t1517: move ls-files -h test to t1517
  t/t1517: move pack-refs -h test to t1517
  t/t1517: move send-pack -h test to t1517
  t/t1517: move verify-commit -h test to t1517
  t/t1517: move verify-tag -h test to t1517

 t/t0610-reftable-basics.sh      |  7 -----
 t/t1517-outside-repo.sh         | 49 +++++++++++++++++++++++++++++++++
 t/t2006-checkout-index-basic.sh |  7 -----
 t/t3004-ls-files-basic.sh       |  7 -----
 t/t5400-send-pack.sh            |  7 -----
 t/t6300-for-each-ref.sh         |  7 -----
 t/t7030-verify-tag.sh           |  7 -----
 t/t7510-signed-commit.sh        |  7 -----
 8 files changed, 49 insertions(+), 49 deletions(-)

-- 
2.50.0

