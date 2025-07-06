Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFA8846F
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751838648; cv=none; b=kq34SHR3vfhZyS9XEDi+QnyjE1YOzzbjBDiGzGPQ7WYQvYQ82kPX5PNKFVo+YbX46yb3bgN5wKRkqPzfnvXLS8VAutNIg4IadWx1t0BD6/bmlZY7e3DBafksLYsDBw8A+8LK3f04FDfhQIgrdf3+5yqzBN4Ejjl1EQuxfp0IjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751838648; c=relaxed/simple;
	bh=Y34xFMXSSc8JJTH6Ujy44cfIhIIv7fNkabK8jh+gBDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z0X8Ths9upolRK7QvtSUrxar6zFaI33BEKlDWyP4ZRWPBJ58A+IcbQWvOSWEqeE94loqsMUTH1Zmj74fd+HkhYQFerJFUhR/T9qzeP0Y4JiUB5GZY0INQMotmRNIIz/gNSEMurFyAaJnVfkl5+F6vhocAuGqkGAyeaucaQspaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VW099qzS; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VW099qzS"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1631785a12.1
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 14:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751838646; x=1752443446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GI//1jHfKK99/7636C/KS63ejO3PkzNVFf3bDNgjdhk=;
        b=VW099qzS1tWKNesHIEDYItgL6AkRccq8ec4N7QV7/nbYGliC94ERxknGFs+CuipoB6
         qshprguIjnxSYr1o8v2yghOC1/Hpq/OguCJu4nRRtmtblgW1TUA3Gjwy8REjhigLXXFB
         LdxYu6zN4NmNO73NAwhslgg0o1a7gvOHmaOjfYqPNg0jq3x4TOXdenezt2yi67FYSUOK
         V68mQ+/Gw5o3+OTB55fTkM4PP2Ob8OghDO6AoOrSBAZ/ThXcOOPM1cHRJ6EF6Wi62VAY
         zVlFN0CXjhYhIJuqwNt6o6k5htMjLudKaM0UFMxRQMyKmGjtFDHNxMIK5ADUhQQIfmi0
         kj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751838646; x=1752443446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GI//1jHfKK99/7636C/KS63ejO3PkzNVFf3bDNgjdhk=;
        b=CmHOJGycPpy5amIThpLb6RU3jZtBD8ExTLXQO6d7WnDNEDZQwCgeU8VThf/+UCWy07
         YMejo/chKKH+ycgsFCA1Pis3r/G01/WyXODJdsYHgq9S1zu9Iiip5D6rnYwdk1T6aKqf
         guBfuSdqCbgCILLRAha5eU+Yd/NzX7mXalAK+o644UghK6IXKXxWDoM2GpdIqTgfC1eh
         oRBOEP2C2vqd1FDXBcIxh1T15/LFThDCQnnzMzHD6HalCvZ+KDUL4H4Znb7P58b/IYCX
         Rzfb+d4h21xdUcSCOkKFrtxgP7A5Sz/VxD7pE3diXunibzLcx3DWXhg1Bw1DXtIA/kjy
         G1mw==
X-Forwarded-Encrypted: i=1; AJvYcCURmwD0ecV0AzOo9hzyrLf7iep8ZqbVKLG5XE0/h4kGIwTbd4ll7qtYWnv4yHS9kR5hhIk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjp170UdwNHFctgEZOpEOdcgZKxv4SicIwoXzs4etZOA9BudwB
	NcvuXpGU/eiGbeFNCBqV/LgQA3rFxRexKH5t8KYOrlGgW80CVYNmKequ
X-Gm-Gg: ASbGncvoywKYnWmO7h+iuPlpMJp0LCN9TlS8qPrOUz2+8DGdlvDOO68nBRCLdSUkl+Q
	5We9q5X16hVNgxZUYSZkNufh4WQ0OTo46fFn7RtdxktdycIzVtUZTBaM/iX0lcw0bLvrPbnoy5K
	mayYhi3YrIIiYGBD74q6APXeBuKEM854uIkDZjSgI9vcDxe0XezkKnbUB12gpnx5HwNb6CcKYaV
	y0cWWCdDzKZssEQ2roj/P+17a2jG5e16A4ByAkv5RRr9z2MGVT11h+C9HJlpc3zAVeIbD9keMoQ
	UwaIyYHPgJfHhRlLjeDDI7U3aFS/PAkdCEzQRD0sx1uxH/6WZ31jmeoY2wE3DUZtV1rtvP3gzfG
	Od0boEACPnxs=
X-Google-Smtp-Source: AGHT+IExPSjbbDcqydibIrgbXGQxESF60pStdSwFjPHLBLwFdIwEwWbnxg43vsxw3QClyRjHVgIlUQ==
X-Received: by 2002:a17:902:e5cf:b0:235:6aa:1675 with SMTP id d9443c01a7336-23c91070e40mr103288255ad.52.1751838645663;
        Sun, 06 Jul 2025 14:50:45 -0700 (PDT)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8457f308sm72912335ad.149.2025.07.06.14.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 14:50:45 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	ps@pks.im
Subject: [PATCH v2 0/7] move builtin help test to t1517
Date: Mon,  7 Jul 2025 03:20:32 +0530
Message-ID: <20250706215039.715732-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
References: <20250706214108.714499-1-usmanakinyemi202@gmail.com>
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

Changes since v3:
  - Fix the typo which I thought I was able to fix in v2

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

