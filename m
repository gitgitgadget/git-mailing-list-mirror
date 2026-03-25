Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1834438F949
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425161; cv=none; b=WSZWxex0haXgw7hyqEXXeU0kBMQjxlPj8VRDIsEzZIyWeeG/EysFd2YmMWfrlynqhhDWo9O25HZ2ZV8ccY4O2cwQFHhiMc6Qcx7xcukcGD6vLPTNMJ2/tqkhXO2Xr8X78g4GC7YDuwi1lQJgSZs96hnF47sdPeXQV9nZ980u71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425161; c=relaxed/simple;
	bh=24KjifkOkuM31p/8IxhXwegbLclxTef3sANPdFwaOm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ODSWenR8LRiQ8Xy3ZFFBurmSW1otorbLfMiGOH+ZFO9jML96W+UuldrmeU3IybzoEyoWHcyxUdN5uaYKQ7NXKFnYOW8R3ali0pNIhg1ZdCSKCkKRS8K3G3d2okiH7EkwnXBX/u5U3+P9HcPRpaw1kSNx7CRz229FgxWXNgRecfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njFfihRS; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njFfihRS"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-56cc67e01deso4452627e0c.3
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 00:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774425155; x=1775029955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n7efcP99Y1RElAZNDmFQ2hgvlVJZVySZuNynrxz1ALg=;
        b=njFfihRSTzxZ2au0powPl4STQXjTPGfH8Asd0E4GpNH8ipjGRK2ofEAWbXxLRmwI1o
         pGDKq03GH25jdqPSaiuux1PcZF/OwVUoJ5Gd7w6DKPklSB87uxqHD5DaV7Us32BT/Fk9
         uJBl/krCjMJ3I1GKA5rc4CSPZRCdfCpUczXlx7QIrqUaK9xoQoG3PLl9uUOQEWDdM80f
         Twh+MnCDYp4mqhxj+rLbvifILupH2gkiCa82Iek9gqTt8Kf3uNBylukHQhQaG5smXquR
         +Mo9DtR0lj8v/yPAiGDMJBNENNA1qWv8yr0GxaqVu7P9bCOBF75+CX3QTczMr19FLGgv
         CL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774425155; x=1775029955;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7efcP99Y1RElAZNDmFQ2hgvlVJZVySZuNynrxz1ALg=;
        b=AwipHOGluwqLlJGR1CEbYgtxBsXccATdhgMRZljNsje/W1/cN9gw1uSHlvpobBnMbB
         1CSKrUVTVdKggcaHvpulUAjop+Yh4l0qd8GwHswM7Gz7fnP+Irc6aR0BSxOpQnA0g44p
         cn/oSgBk7s/w0C8H7rhlhz0sVuPyVcF3k+/eKwzFjgMckq4lYxcAucZ5tv3Qo+mPGIph
         fRnfVwPtfqJT/Kl41sO7hExf00XcvNx5sySsmkmoKLMIlkdLKD98NutmeV8dGTt8UroN
         f9LJ0MJ2jptNdwMO7uo0Cm55M4K7ZEcdjjLbzp4zk4/oj2B3lWJ3xw4AUK15Qp335WeG
         rBhA==
X-Gm-Message-State: AOJu0YzPpUgtuijkTDjjrmsq7GtzQtBqVIwsSiXP1CV6rGh8gzAg38WX
	dAXYzUdFAnR+qPIjTh/EivR1oPXJfBg+kWlv4uHeEKRK+BdVY2QeH6g7u4aK+9GB
X-Gm-Gg: ATEYQzw0PS2tAIxP0gXF7/2C7Hsin198tspDXdzdqDYB7Gwaj+dV1HNpo5q4+Y+kFrz
	0ZLOMkO8dPGHjBcijvcyW35l+5reR0THcsDIGSvSBxSQQhjbNEkQbwomlnoKaVwnYrXLnRHhNnM
	jlDw3QB/9cpPk/2fJmxP15bm8nv1j6Z+DbFItbU7Rn+EF29U49EOOyNujHlqfByVsABDHiDNmPq
	vgJkq4+RQJe6isjNNBgzLFmJ7dMwDe108Ta7pBzTxqTAcP2ueUSI0U/IG5osFI/baWf4wDn6x0q
	mD1x03GHIaoNWsG3X2ixPf1PRp9Z58X7BsALuyEcSJgUQxNS4XHHHuMEUvyHPci8rA1oDmbvKeD
	e5VrSzki/dwipHZXh+3FhEoKz2ATgiMHqGVrXkcnR1jQAzxFvCKOFGyoPVf0IdXMXR4P75GTaRg
	DiOUYoV1t7spSXN/ikDyHP6vb5rNKX8hCuyPghQ2ikNXNmqzGnL7RY66lVMBY=
X-Received: by 2002:a05:6122:614d:b0:56b:7d4d:4d11 with SMTP id 71dfb90a1353d-56d21f0d31bmr1434999e0c.1.1774425155092;
        Wed, 25 Mar 2026 00:52:35 -0700 (PDT)
Received: from SQD-WKS-155.. ([2804:2164:80b5:ca00:1848:ce0c:8de3:8ebb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95136b4afc7sm14788357241.1.2026.03.25.00.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 00:52:33 -0700 (PDT)
From: Luiz Campos <luizedc1@gmail.com>
To: git@vger.kernel.org
Cc: luizedc1@gmail.com,
	peff@peff.net,
	sagotsky@gmail.com,
	Johannes.Schindelin@gmx.de
Subject: [RFC PATCH 0/1] add -p: support discarding hunks
Date: Wed, 25 Mar 2026 04:50:54 -0300
Message-ID: <20260325075055.354709-1-luizedc1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is an RFC for adding a 'discard hunk' action to `git add -p`.

Currently, when using `git add -p`, users can stage or skip hunks,
but cannot discard unwanted changes directly from the working tree.
This often leads to repeatedly skipping the same hunks across
multiple passes.

This patch introduces a new 'x' action to discard the current hunk
by reverse-applying it to the working tree.

This idea was previously discussed on the mailing list:
https://lore.kernel.org/git/X%2FiFCo0bXLR%2BLZXs@coredump.intra.peff.net/t/#m0576e6f3c6375e11cc4693b9dca3c1fc57baadd0

Open questions:
- Should discard happen immediately or be deferred until patch application?
- Are there edge cases involving overlapping hunks or edited hunks?

Feedback is very welcome.

Thanks,
Luiz

Luiz Campos (1):
  [RFC PATCH 0/1] add -p: support discarding hunks with 'x'

 Documentation/git-add.adoc |   7 +-
 add-patch.c                | 137 ++++++++++++++++++++++++++++---------
 t/t3701-add-interactive.sh |  58 ++++++++++------
 3 files changed, 149 insertions(+), 53 deletions(-)

-- 
2.43.0

