Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4452D1DDA24
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318968; cv=none; b=gGo031Y8NG/RwGiQu3MMHYSmmtJtNM24kNPnar59ZrHPGgQHmGPz4xbAfGin73LMveE3R2vYB47evRwALAC3Hud1q1FGx1ydO7G2CDCdx74L0DNAILsYPPbANUHCovAKKjUxcg2fRi7/WrsIh2kSIurzdV+UsDRBghfNUZmxqHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318968; c=relaxed/simple;
	bh=QKfpbfdT6kIAN5p0vpEhOfom1tEQoBIg9rgzZyCqNK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pj/eAUATO1j8dkdNZ+s3MFpDIrSdRShD8FbVEByAi8VDtzVq44zXUpPp1XcCQj6KkQgB6O0m6j9s/vmRXBnDhCpE3GG8HzuEoKhDanOwj+LKIZ14tgJfcrFGZ33xd8MCk+rnshcLOrLgm1B/0nZAaKaG9q37XujYZ9qx0Gv8aJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RH8DCEas; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH8DCEas"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47117e75258so16390835e9.2
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761318963; x=1761923763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rlYzHqcMkT60Gb5k1OWCpd2x8cxxXvk4pbxuc0tfqzw=;
        b=RH8DCEas6xUAxqgkkQqM8bNy4uea7FBHCoG1QNi2+lvAO17GPlqsDJn3uAYLbDlrMa
         f0sxF1vKwuqfdzm1j4Jk4DHh369NLPQSgfxMRQEt6skaYYbWH/Mdhm4+fCjfXe4h3Rvr
         IACC+QtPFO0lu+oJ5WIsHlFh/NxvG9I/tJ0zrVW4XMZYPjus3Wz9EbRRjZXkd30s3c8A
         l6wl+1NkzRufDb3rXDCH4eTVv94aaqvebgugVQ0IUkwuoLWmSw2RpkiQSQCDmz06Gz5e
         fYfuxpOR3/diK8ysATyZ96zp7l/kvfN2hwUT2qqePIXMZR1ktmWErjukpRI4dcMZdqA5
         uyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318963; x=1761923763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rlYzHqcMkT60Gb5k1OWCpd2x8cxxXvk4pbxuc0tfqzw=;
        b=mBP6Wdf5A/JeWfs0YpGq7kHLSIiSE6Z8JoNuCrQq+7zt81HGP2QtKL0VA8L9OcUZP/
         +48LajPPONVcgRynAQYQ9QMZcP3esM42M1Tx61qsZy74lu+qCX27OI4f+HHp917oWfCE
         WpE1gZh8KsiqwHjA6du2LGE8QlvRPmMsKEIpf1prqZMqGOr5pA1MS1uzz1dLk0BiINGX
         nZ+QX1vNnQZ12cqF0F3TNUP9NRD96/gkgdEZUJ61cokJLFhc35r/7D6YZWIaPALwvCTZ
         dV51sPhNDiME7Jj4BMzcmrjkYfdxeM9gDRQ3HUVPaTrKJS1prG9Il9MXJ0QgKiKDzPhp
         xxmw==
X-Gm-Message-State: AOJu0Yw5MsMZeU2IhM/wQguHWFL99e3Fugpez+dcjz++wh9yFGP2uZ2I
	v/wFtJ9A+Ahvmg6vooTRdMNSBeazsPLj/85dJdMc3Z6BZ4oeuufnZyalWlk7+Tz9
X-Gm-Gg: ASbGncudZ9WGNgCUYNauuV3cRLaJxcuVfETzJXiG1+M8I4qw7K3vn4QPqLovXHFrLl7
	r5SKfoO6ZHQ1DEIyl6LL0tGeI4oz0nk0RX/27oCXr7wUfDxN6KhaN7UWCaxOfQp+gtOcQERYqAR
	XeyRibRKZUWtLBSJY3uQVeXNqEfdNXz2amGV/glw1kenPhn+yyAKXPgf43JrPWHwlnYn50H/nhb
	PtqyqxzGwswtdG4Md0Do2E08x0Er3Y/DR4P2GNdfVjEkhhIE3ixPvN+5k2ZPyTtdj1aHJ/HtgnD
	6wv9IwkY1zvIVMe+CPrW3DbOD/7aRMf91Q47imlNJlYsLTu9SEJg/4+ayIErst9YAqa8VC0Cirw
	dJ6AgRXpntzICxTI6HQkSMGdQ5DQ97BV83aHTkF0B93ju/G3o376hl+Y+T88RtrSBk15X12Cs8a
	wMI5euJ7lmBLwkGkERU+a22ttK7Q==
X-Google-Smtp-Source: AGHT+IESK3C+ahGbbnss4q7Bb3Z9TFm1sy2QJ5XiwUx/I7wOXb28Jsa6Gp5DW/BAEdTxwWS7R2j4Cg==
X-Received: by 2002:a05:6000:2203:b0:426:d53a:fbb6 with SMTP id ffacd0b85a97d-4298a0a9217mr5462019f8f.31.1761318963015;
        Fri, 24 Oct 2025 08:16:03 -0700 (PDT)
Received: from QueenJ-PC ([105.113.80.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897f57efsm9954885f8f.18.2025.10.24.08.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 08:16:02 -0700 (PDT)
From: QueenJcloud <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	qjessa662@gmail.com
Subject: [PATCH] MyFirstContribution: add tip for confirming patches reached the mailing list
Date: Fri, 24 Oct 2025 16:15:32 +0100
Message-ID: <20251024151532.1968-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After explaining how to send patches using `git send-email`, add a helpful tip
for contributors on how to confirm that their patches were successfully sent
and appeared on the mailing list. This provides reassurance for newcomers and
helps them verify their submission.

Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 02ba8ba5f6..94acdaeddd 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1158,6 +1158,13 @@ prompt for each patch that's about to go out. This gives you one last chance to
 edit or quit sending something (but again, don't edit code this way). Once you
 press `y` or `a` at these prompts your emails will be sent! Congratulations!
 
+[TIP]
+====
+After sending your patches, you can confirm that they reached the mailing list
+by visiting https://lore.kernel.org/git/. Use the search bar to find your name
+or the subject of your patch. If it appears, your email was successfully delivered.
+====|
+
 Awesome, now the community will drop everything and review your changes. (Just
 kidding - be patient!)
 
-- 
2.51.0.573.gb660e2dcb9

