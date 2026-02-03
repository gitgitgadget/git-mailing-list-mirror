Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBA92D97BB
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157116; cv=none; b=KP70wAINwaykwGZXPdaE4m5btUQvJhI+/btgCs+cL0/ii6AkV/LAzcX60pVlUYHEarasPjMB4ixqtO56KlOJGnexySJPkNFs/r4A9IxGrCCxbL+wFmDw4kwaglXbt8Uprs8D5h1KLKtN/ZQZfNFea4YgmSfpADoDzYhW/JhmyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157116; c=relaxed/simple;
	bh=PgYMaPaavbB7k4WPHiHsDmaIJ+aH/0fXlKj4agGy+Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5Ef272g9bNuEL3Ft6iqlhoMAuThq1NMpGIK3Teo6ltvtcPZXpu9eCbym52aYfUzERh7SgP22fvvgwnxIRznn6E31LKm7VJyuvAkSotT5yaR4BE69mOLQf7KqmZSQ32QicFm4YG7wFy8O/K7dP1yQxxj6pAWwlKoxhjY9Kp+Q0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5gp7p8v; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5gp7p8v"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6611cab8ca3so3895806eaf.3
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770157114; x=1770761914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=87uIeoqydQXkP8z6os7SpoG3hKt4RiDpGcTaqez2VZs=;
        b=W5gp7p8vlhwPWaOgjNZ96d3gSzWJqzF6WfzO3gaygIGL5cvt3UnWt1oXD4jy9fETYG
         VFA1Nes69DTzn5L2cPuJUdHsczrI/dvP9N2nn1UK7JiL1fxo5ZFwVTQJO9x/eyLEIMi4
         dA+hWa9OblQHKo6SkK+7gKAC4GZXOEGs5rF5N+gLO43BfBan8xEHrSiOQKi0vAJxQ1kZ
         UYdBU0TIsLS6LdPkaDpfkh9CByIRxxVhts0/u68hgYYtylYe1Zc3NgX9LmLAeSin5S2Y
         g1qWWhO9/Q+/0fDNPIyRAr4qIkWSh0cr44ZLlI2R5UkPS2mUBpXyMCJBHa8F0vYVQ2/T
         j6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770157114; x=1770761914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=87uIeoqydQXkP8z6os7SpoG3hKt4RiDpGcTaqez2VZs=;
        b=ARuVGW+8KuGArni0xmvTOjc6B0k2CL17stdVWLbAxRPUCd+QMB6qrZu5n2uC/ePwLK
         aW73s8wwr6TLJENrECbafV/7kJdDQkKVTVFxlxSxkwxy3JhEOGiCsCiThNGphA7zckNY
         L92kQQcw6mTVQTdp8DopH/ewZnxWolG8fOJlWTSeNMSAS173Qkm6xy9VeVRpIw7HMQVX
         jk4+/MVEqHB1XRaRVr/jLRi984+o4rKzz9Hv1xiFLbhCgJFBH3oe+fJW0W88Bqz4Si/N
         5MHJ+r/mS4xNFOMV54Tyc8Ts0ipbHlYKcePBzrVX/KpuwU/ayYZIw13AGE2Y2Q5Mx5yt
         ar9w==
X-Gm-Message-State: AOJu0Yy42BzVvxjMcXsBOr6Ksikp756GzLBDV8aoKut+t1Skny7qx2C8
	11gdzjf3sUShWXv/5JwidYvABpoAulcu1BPtW5KJE1ySqpfzk8toUauVzesrtQ==
X-Gm-Gg: AZuq6aKMit0IRJ8wKL5Dko9eyy5MZky87QZRGxSJcsTXq1vGI8ATUhUZ+dFVjYidBd9
	kK/8iseSYVsmqNxZtEwTfplbR7LGZUndsE03nmJcpLiNWJ5HKf8BNXNKjBJF4DmX2yO2z5uaR6c
	hvKMP4h71arvnmUuic5SIZCf3tz34Heo7H3qaFsVFG61PQZPf5XnJuBiRCEYK0v/WDXwnCpGJwr
	RZvdpdKvgkvjviu1rN5VNzAfk1llLMeQ1xiewYi7NH9fajphz78Fl6NDH2MsX4Fwn28Xl6Ja7sy
	JKZIYI/25DDNpJ0S1/ikdq6pP9RZJEuB8Sh7SK3kzuB6ZhxfV12VlH8LXNwYapZAwzUevVhXKiz
	GnA5nNJ7uiKLgd+RPRb/GFxu+zx/xnWeAJGgzGs8VDlqgFFpjZRr0J6IAEKDv8d1HAtsanLAXq2
	lqKmWTskEKpiJibvtEYgA=
X-Received: by 2002:a05:6820:f0b:b0:663:39:173c with SMTP id 006d021491bc7-66a2342cc7dmr621853eaf.65.1770157113873;
        Tue, 03 Feb 2026 14:18:33 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a53c3c4dasm479042fac.0.2026.02.03.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:18:33 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/5] builtin/repo: include largest object information
Date: Tue,  3 Feb 2026 16:17:53 -0600
Message-ID: <20260203221758.1164434-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings,

The "structure" output for git-repo(1) currently provides count
information for references/objects as well as total inflated/disk sizes
of objects by type. Info regarding the largest individual objects in the
repository is not yet collected, but would be useful to users wishing to
identify such large objects.

This patch series adds the following data points:
- The OID and size of the largest objects by object type
- The OID and parent count of the commit with the most parents
- The OID and entries count of the tree with the most entries

Thanks,
-Justin

Justin Tobler (5):
  builtin/repo: update stats for each object
  builtin/repo: collect largest inflated objects
  builtin/repo: add OID annotations to table output
  builtin/repo: find commit with most parents
  builtin/repo: find tree with most entries

 Documentation/git-repo.adoc |   1 +
 builtin/repo.c              | 249 +++++++++++++++++++++++++++++++-----
 t/t1901-repo-structure.sh   | 143 +++++++++++++--------
 3 files changed, 313 insertions(+), 80 deletions(-)


base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
-- 
2.53.0

