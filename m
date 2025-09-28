Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D494C98
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759067681; cv=none; b=rsza4dF7xLFaOIlmiG/hv2BL5ybVPGDFDsUPoyNcrvRQyDZU6kuUP2aXHCSfnR1k/cx+RUDAxuNuxNYjQrHbLFUvjgrURzQ3e7FfJ5smPxenLg7AQFAejt1Xtu33cCJr+FqvNqLeVQ3CRrgsdSDvrCgo+FZwYOp0BiWosGSAlQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759067681; c=relaxed/simple;
	bh=ZRtHRRjrxPbz/VYv+aRUebNMaivmCU7dRix92ZIpLUI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAz7JETDjs2g92npbMbj7CVmZCXKC6TMKiXUPr+fusrXVEZ8qn0axNLnE87X6aXEPuM4wM153xn0JvEbbkrrs+El5zgkN5FLs/cQdsqZW5wMmUPAs6GwXvrdFU07zdrken/r8BypqL0FykpWMmofEuNs5qj+XQCVXl1Lp52/gu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDbzUrNV; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDbzUrNV"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85a4ceb4c3dso407459085a.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759067679; x=1759672479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mw96fqyhWy5Mi04SU19sQP58/iYbS7eNSeX/Tw28mJ8=;
        b=lDbzUrNV24Yzd0xog3cABzhXEYdMMGep9fUwYT04Y/OPJjyqBTb+dM/SFGcDeX1JYQ
         pENZ1tFt/X8AhIqxz5gdMzCnvaRdv6D2fjjxTx4sJJmon3dIYJAJp8EKlAkEqaDQUWX0
         XUGtU3H1Jtabpq6UXfOZKVWc9YnFZNcz/MQW16cdt55DwLJ9USVStJzLeqKtDz2ddKbt
         n2BnoNp6MSCqUzA5qTLuMGgRS25Qih4K98XfiSN1yySntLX/feylajGqFAqmnOVQOVjG
         UZDSk+ALkHPSq8cKu8ibvrIEvSB2kr/urE6+u41ys15XwKowwFxVOjXH1StMrr20MCsY
         IVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759067679; x=1759672479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mw96fqyhWy5Mi04SU19sQP58/iYbS7eNSeX/Tw28mJ8=;
        b=w+cX6AcJXIb6oCgOp2qDY4xXy9CNEDChbXyeDdML2NBjra/Xhavn2wa1jFa2ze0R1X
         IvlKrQSmjLlOWMCFvqPAJ+aGpoLScRZ45Zexz3ueMZEb7uumB20wljw9Hte14ObO6ebO
         jMg5pTutY9Rai2PfcgLJ0QaI+EfgpL3XCrgYHpYKJ0aP3TMQ80bInIYvcZCDKRNXDQcd
         n+vjYQuJ5znMH7aqvYCcvLH9+Cd6U5oIs9lrC4t4UoMnDwsaFuDIsGvHZnA+IHd5zLJa
         Sgw3+ZFfGkywaPhevjMHlPb7JzO4Ow93fcRfV5XfM0XymAJE89r3hcxbYXVVnA4uZ0tp
         bl/Q==
X-Gm-Message-State: AOJu0Yxh5XGFz3kJeL9dMKJ7Io6r9UTzh7lOMMxWAW0cIThbGAGhCMFG
	kwbjIKm5JyrBtKXqKLgneKWWe/OoqFxIKT+4n9LobkPI8zyy1TRWlbg3VP9gQEnq
X-Gm-Gg: ASbGncucCMvBGGZGmrPisYXWdp0Fm+UZP2oEr2YAcLWhqzwBVqjDl3fQUZCMa8uHrCQ
	XShu4IuGwE7s1FgXEVBuqJ5dcRQy70tHBT7kki0Fq/0Hl+M4/3/w5GR4je2svEqA8UDebOjzcKp
	6yyTSu/dBKBXMLsFUeUk9F6pnZzEgqGSiCOyToLWAAnCQtxxR7w8IZtSm+zXk7HFGT0ckldn8f5
	X14YHOEMH+hlgxTdvFtuHjagTgUqYN0nttr5zid76MoKmL1Ps8Xm3fdm714LFL2JC6GYC55a1B+
	Jf5BxBj0hc3KxebtEOhYIz+zFeoKQycD2N57p15DMrTe6P+CrbOxRuuVES82yEoUbNNBW0sOImt
	e1RdBKnI/hSldaBRuhJRUeIxXk9e9qV4l8sweQmoWSx6FmGGmCd4MEQndeI6aw1rQtWQ1UyCP5T
	xKmb/dtO7fhwY9PcdB2a/kOmCJHKeFCM6QAjf+h0xF
X-Google-Smtp-Source: AGHT+IG6i9+K71CaajBQB4UU8fwo9KRhME9JYAhYRWojgv20LfkyPUJ58uD+Tlc/jnskL4Kywa5zIw==
X-Received: by 2002:a05:620a:7106:b0:862:79a9:eaf2 with SMTP id af79cd13be357-86279a9ee01mr900477185a.20.1759067678635;
        Sun, 28 Sep 2025 06:54:38 -0700 (PDT)
Received: from USROMMRAPPAZZ01.rappazzo.network (pool-74-105-50-139.nwrknj.fios.verizon.net. [74.105.50.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c307ad101sm590426985a.36.2025.09.28.06.54.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 28 Sep 2025 06:54:38 -0700 (PDT)
From: Michael Rappazzo <rappazzo@gmail.com>
To: git@vger.kernel.org
Cc: j6t@kdbg.org,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: [PATCH v3 0/2] gitk: make Tags and Heads window geometry sticky
Date: Sun, 28 Sep 2025 09:54:33 -0400
Message-ID: <20250928135435.59623-1-rappazzo@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2:
 - replaced my commit to restore the window size and position with the
   commit that was already floating around from Hannes's repository.  I
   included this because the next commit relies on it to work correctly
   in some environments.
 - split the manage_showrefs_geometry function into 2 functions.

Johannes Sixt (1):
  Revert "gitk: Only restore window size from ~/.gitk, not position"

Michael Rappazzo (1):
  gitk: make Tags and Heads window geometry sticky

 gitk | 51 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 12 deletions(-)

-- 
2.51.0

