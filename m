Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0300A33A9F3
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 20:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728195; cv=none; b=HFTSDZhrMDmqw9VSJCo+89AHYKdUc6zj6o4ENHjq+FWYeoIOVVn8wO2o9TQuhsAs1DHHZUk4dPu9V6R40+fjyilpsc1GsF2mTyltlJTrnfrXVuLvXEHGDOzBfX39+SxXlYl0mmosu9rNNJGJWdA5mpptKQUKusCOp/N+iQeZQ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728195; c=relaxed/simple;
	bh=FjmttKKbbUap9iwu5b66v3D3o9zy9kI7gzFj9lB7/Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rb6Ljm8nqE7y+v7gfEqXUHEvVfRXGG2aavMrDJ4G7IujDTvTPokS6fSsKyf9YGkUUmUY3XSKflmLu+bsRy3ab0rdiJhIChWPmqkD7WqAifSUcG7r33i+RjKs9YwU1L1+swaBO1kH7CNimbd8xNqZp8h0OCw+KW/Ob82zrBSA/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4eswBfF; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4eswBfF"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82bae83318bso1504628b3a.2
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 13:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774728193; x=1775332993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjIvC54P2gxgSivr6zFFQ89dj9oMwBZ0Z0AFWqguFis=;
        b=Z4eswBfFMiqh6TIzKG3F13PAKxUIo82iBS0sUVFt7fBFr/Q/iGzA6YlNy6Y3FWOTUU
         Kyn5J1cWN1HAiGj2r+Hol/92EoN4T+ZZvg2rdOl86UCBGvJb1FkAQx0iRnpCt1iqpdbg
         8CYUxVexhmTzCkWnT22pjUGcw70k8UgCtphdOG5/FBD4FeEZs5aQ4QLKQNdNi+MhbQoy
         DldLMeOYWqYZnFymk8A63VVl2K+8zw0MPy7NDHLGJJM6eqnx3vJYQYNs1yiIvdqArxu3
         YuXECP4eNY5ifdR1Nz5yl4YoNGElLGP1o5FPXoszM5jX4LyqPhbj9h1rKRINoc6ULesH
         r1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774728193; x=1775332993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NjIvC54P2gxgSivr6zFFQ89dj9oMwBZ0Z0AFWqguFis=;
        b=nFuUs/eQM3b+uTAs5/RUNoA8gmtBoZoJQXLGmMLIhy7suqyxZ8vCNWPrW4dlRf9OGe
         0QQFkL9bpVFj0dlK2kXOWm0dCLlXEXUlr6PM9j+rDAJlV0aFxxhXX9hZBJgxdBZoTXVS
         wKYoSXR1K76qHnHvtcTg5tjQZ+QCmEUJ/u1f/a/wh/ezgX6RIlgiVtn13EEdHzZYnK/q
         1yi7bhLoVxdekwDuhGk+g7JtDktCNbgQqL0KRVWHVah0Q1dhmCAc7KxGbGS3lwIB8on/
         RNt5abtUkMohqcLaaytxeJwAtABVBU7Nv228FYZMY2usXtnzcTeOEXp0WMjY1m6LFV3C
         1sLg==
X-Gm-Message-State: AOJu0YzPJ5Yvr/X2kzP9NTx2Zrw3rR4GV6slwokVLMgzmAJyCw17vJwv
	foGVR/WtRCkceBe8YWqx6lnTCYtwhExTCbMS4/QAua+Hk5Qilp5PSqF0ci6BzMJ0
X-Gm-Gg: ATEYQzxpG6THpyQd/i41G8tphoPCKZi0WbjxheuR8Ry4B1kV2/t11Q66iTKdpeGu0WJ
	FwFk+k7CVBgGKXtcCgXS9SVpPj5CDEo6gcUq9wY25qMvBKr0XZmrTNLoW0fi58eQPbe5wodGRRk
	94xKSE/nYE182NW4ZyC9pyc/pcmhQrspOceKgddwUWmWao6oU+74DSldUZRVripeq4UFxqBqAku
	+sdseGZmcdh/I+6Kq2lYoRcgqXRfMDZUJ2oX9QMRte1QyBE2BLEgUdWIcLb6uTnLo89DBaQtVow
	nBOgByYDPo5XauEBNpj6ugLOYdKZEPmHc6CZW737xHzMEh8+upPqVovOkn0VRDZZ0tAfFEdcGhp
	EwcjyRmG80INWpol7FCr4sqWXwV4wI5VP9KghKSgNjWOIiqOC6HLwfOlE3xy4mSrCGqa7oiYhvR
	HD7qPMY7ImgJY3dFURS0RtxHvmMXiUcx3Pc6lFwQbgsNHUY9dj4WkatoQPm3c1Kdz2NAIcjtRwh
	CA5WEu5mg==
X-Received: by 2002:a05:6a20:3ca6:b0:398:7973:277e with SMTP id adf61e73a8af0-39c87a593b9mr8239083637.31.1774728193138;
        Sat, 28 Mar 2026 13:03:13 -0700 (PDT)
Received: from trieu2-huynh-trieuhpn-ubuntu24.bee-live.svc.cluster.local ([27.122.242.65])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917bb31asm2359786a12.23.2026.03.28.13.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 13:03:12 -0700 (PDT)
From: Trieu Huynh <vikingtc4@gmail.com>
To: git@vger.kernel.org
Cc: Trieu Huynh <vikingtc4@gmail.com>
Subject: [GSoC PATCH 04/16] t6101: avoid suppressing git's exit code
Date: Sun, 29 Mar 2026 05:02:43 +0900
Message-ID: <20260328200255.247759-5-vikingtc4@gmail.com>
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

Update t6101-rev-parse-parents.sh to redirect git-cmds output
to a temporary file instead of piping it directly to not hide
the exit code of git commands behind pipes, as a crash in git
might go unnoticed.

Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
---
 t/t6101-rev-parse-parents.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 5f55ab98d3..7281889717 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -39,7 +39,8 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'start is valid' '
-	git rev-parse start | grep "^$OID_REGEX$"
+	git rev-parse start >actual &&
+	test_grep "^$OID_REGEX$" actual
 '
 
 test_expect_success 'start^0' '
-- 
2.43.0

