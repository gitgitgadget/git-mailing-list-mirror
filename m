Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA411DA5F
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 04:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751084508; cv=none; b=meUta5IhGSSNGe0Icubc/Xia3wYIcQ295Yh6kb+N/EbgcMoRbDrvVx1iFBjDps/O8f+5jbhHqsdjxExczPZ9LEh7HPnXKYbFMADg9bh/ZEdVXGL9R3k2ZDjn5K/TPyfa0Yq84hCCctQ7IbFozvFh2RwtBfpTRksScPkz5wBHltU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751084508; c=relaxed/simple;
	bh=9oqBNgVInUC8RNq+65sIkl2sNPVjUgLHp+FYADz4gaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqqK5IK2C2lxKNqNyGn5y6vdMOTZfTuLTtIlQsZNZGE/ZW2m4w1FQ24uqxOndFSwdJajW0qQgwlv06B1ayXhxGViLAMSRPYUMgXelJH/VroJbJWoFIri0W9BJQw9MFeELz7x1qGvT7Y2zcX+Y0knuxQc++39rf0KpY15Gb+7iCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml4tdXPT; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml4tdXPT"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-74264d1832eso912806b3a.0
        for <git@vger.kernel.org>; Fri, 27 Jun 2025 21:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751084506; x=1751689306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6N24RC6XfQj+uuclUm7XK6OUH5jQU2roVkwLOkO6rI=;
        b=Ml4tdXPTXeuv4kBffMfu3WoTanQ/3onMTQ7JBpyXKumLEOCty8F2rU5iPDOKDZZ8jX
         tHNsh3bQLj5QU5D6B/FrzZcRAWw6HaPgFJzRUwmiWQGcF3sL13pbhH9H3CApeWaD70WM
         6juvO7jEKIV0oq0nMnXy5AVE9HdBmhXZkKTNaodpdOTyA6s/0uyg5y0X3lIxbH7quMbq
         etJbJqY9ueMN4KhGfx7XoSQCfjoUGeXAzdr6DbYBQ+bkFKxl8VS+HZ6T97aWrsDYrwDM
         PPHeVsuJPO8d0CFcBrTTGMrZayW1zXJfhBzbWxfOmIilcSwDwyMXZEi023UZDviU7AH/
         PVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751084506; x=1751689306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6N24RC6XfQj+uuclUm7XK6OUH5jQU2roVkwLOkO6rI=;
        b=fnL39k5Rtd+aqB8NID895QdRZWUs5y56H348s995g2CVYkPTeEFWoO2KdmshoXTUTP
         pE75+iD1bfGZi4/nvBQmK6J9UKHUXp/PaOQtj18uzzk5volDoPbQaR2muwq3ME6QONwh
         M9qORWLjczC+MBjTCrXFf8F0sIsJF7J+u5Sbgl/uAVmoNN44PkpSG/mMzars1M2kn1po
         OG7vPNnv5jmot1CvfeoPG1HM1v69/AMPXg8WPVE4NUb0lypwyMadYpJiKGN6A4Qp5MQb
         J6OInPjvZ/Wre59O6fcSdaC2tj57qFasobx+P7bcIQvA7QZKFequzy8invB4gZQ6uJaB
         /YNg==
X-Gm-Message-State: AOJu0Yznbtg3aL9Rl1u/GUkyDeoZWPQNJn3fYJTmXcsQWHhc2cFHzqsC
	EZLnqCQfW1D6O1UwCATS+ui+S5nP05L2Ku8H6kYjNMf4jRou7cm0JdfDr5GmfUEM1Mx0kw==
X-Gm-Gg: ASbGncshbVPix3jNoRPd5bsbj6dKkbje/Fqm+N945I3slOoUNBvU5sWKL2eAvyf8Bci
	WF68jwde8v2L9g7qDPDrrVCNiEhPV/x3wXHtk4wrdZaX/c6LHcso9/aFWIpH+Iy6osjXnULfhm8
	TqmXqTIAeBqmmCfikd8QjWP2KJSG+iFG/bfq2xX/3ToRne/Jx7IF83y/VIgmsc2lIEWISRXwV0W
	YdWDp6KSRskQBIlDJMf1ytebB+6MxEJRb3i3AOw8A4H5bcFPc91quQUBCQHtZNvddhcvTCrW4CK
	nykOMCaVo4d/IP2tK/HW2pYoV8HsTt7YE0BOihC5nTfbp2M1Pq5ehYmFjYNsx7fiDzzu
X-Google-Smtp-Source: AGHT+IFaUjvqQ0d+1U0iQbrM0WgvA1ARphcGA7RBWYqeEUZoNtpGrMp45hBR4MinfpTbakO41jvkrg==
X-Received: by 2002:a05:6a00:2d07:b0:746:3200:5f8 with SMTP id d2e1a72fcca58-74af6f80718mr7343602b3a.22.1751084506507;
        Fri, 27 Jun 2025 21:21:46 -0700 (PDT)
Received: from r760 ([188.253.126.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af5580faasm3402914b3a.76.2025.06.27.21.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 21:21:46 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/2] bloom: enable bloom filter optimization for multiple pathspec elements in revision traversal
Date: Sat, 28 Jun 2025 12:21:38 +0800
Message-ID: <20250628042140.1097910-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.108.g6ae0c543ae
In-Reply-To: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series enables bloom filter optimization for multiple pathspec
elements. Compared to v2, v3 fixed bugs in forbid_bloom_filter() and
add one more test case in t/t4216-log-bloom.sh.

Lidong Yan (2):
  bloom: replace struct bloom_key * with struct bloom_keyvec
  bloom: optimize multiple pathspec items in revision traversal

 bloom.c              |  31 +++++++++++
 bloom.h              |  20 +++++++
 revision.c           | 126 ++++++++++++++++++++++++-------------------
 revision.h           |   6 +--
 t/t4216-log-bloom.sh |  23 ++++----
 5 files changed, 139 insertions(+), 67 deletions(-)

-- 
2.50.0.108.g6ae0c543ae

