Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968931F993
	for <git@vger.kernel.org>; Sat,  4 Jul 2026 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783155208; cv=none; b=NHvfGhoUYhvUuu1900FkejOy3L5uqA3tp7/e9TLSrQym4A+9q8sfNb8KREHsleUfQGIbXy5wAUAQBUM6KSkWDfs+I+BeOtf/WaP2zZ0v8qyT/btN8UBJsh5csFXEf4BfLa8DJ2X4qIJiKUgKTOeTHIm4HsS7HtDBfvPAPmQgP50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783155208; c=relaxed/simple;
	bh=2Leqa/nCfwwWufZZ2dot4b4ftIp76JaBj5r8JOVJYJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FhhZ+lOOrU+qER45NwDdhzmVa9l23cv3Dw8FzrZr6GV72wJqnwYVdT5nRVszFWZp9hbPwcITPW8iFhYjULT6C9Qji1RPVN2IwdHY/YNLh5wTyIxhPRS0vaZ2HoJpGCfB+lq/6+F8U3CK+L6LoAw2ozNQdqtcrGsieG/by7N/mx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=onxCm3pK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="onxCm3pK"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b966dd74so4583435e9.3
        for <git@vger.kernel.org>; Sat, 04 Jul 2026 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783155205; x=1783760005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u8XXiDpcaNx2c2bBvm6KN7ssnfZNpvKfwMZr3ouRHY=;
        b=onxCm3pKBIT8iw01XdzFSXA8UtGKJj/mQiEOeq9l3YKsVyf7l5oQYquO0VN3zl2kuE
         CJazDTxajtM/s8PSKzqh6SN2oSqk8c4lrovUHlAuiPxEazmAqSjOYR6wrhwy3oQ3/FuC
         CNv1VXo6H0g48cbgWezW6TXySdmHE4w7BqPZ6j7KomFlOZADIk6kiNmMTyVTRUR6HzwG
         gUnFmhgyYIXFqr1AVTajQdD1wfX+Hg6u4ZUQKf43J6yP3aNls5WE1Orx18jWAl05pwZs
         A92MjeMGrfPH5vww99UfSmLSenOGlZuoRRkCSrEcnhVOLA8Yt1VZwae/+e7pF/CJ7Dii
         HTyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783155205; x=1783760005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6u8XXiDpcaNx2c2bBvm6KN7ssnfZNpvKfwMZr3ouRHY=;
        b=B1ddAQdkCoByD+W2BHuApLawpbnglV9yHTa9Ap1KaSQe7zCEUqtDeHyKUgWnC2tW2h
         98BfICyzusUjPklLj27ea0unEzwKqjA6OnsgdjSB7hggrU2JBRK2ugHOeuXCphHx5aKa
         IE+qQ3ripwx4UmlhgO3mflXxr2FMrjOFilglq612HUvNLPhKEa515Vl1K5TlGX6aGGK2
         H5LynhGaNnIYs1k7HMcF5uoK7tvPFuvjYz/XaLAzZEMDQlB/9VoQQSWegpV9hTXbmrX5
         y6SJ+/aSm6ur2xPizzi9bHdPDPAb0xYSrkiS+AY8KACMl7p6Yfb2NUzr6cykpyhZfupF
         lyXg==
X-Gm-Message-State: AOJu0YwRrbVsqnMOCMvasIZqkBLj0ncF83/qKYVQxl7JISdJoY9cLURg
	4uO7BAvGNv5IVxlYGHaW/5sdnhCF7Cs8QyqiOvC7B0j6HtvfGHbNOqPNSco2aO/W
X-Gm-Gg: AfdE7cl/a32N8ZcKKmXpj7vLJvLwUe7K+zLt24yG1pqe6P/YV4QlsbtROxBZ9VvEl+x
	Lx2PBvGzK1JWyNa1S8T4VnsOvQqS3Fa4kKFlckqC00fpHcWvC5HO1ZZ0w2a96nCX5Pd2P4yrbgF
	C/XKFUco1oaoj/Xt+UXEqFtrouEuzCX0lOVUTD4snwNFsnuJbKmssuM3LrIYh7PY09kMYZqyYam
	FK/U3SRw312+e4mDoZnEUsDWtY6fdVXf3Pad1wrK6N7AgoBU5gXbi3jmladlgF4wg5DVsE3PhEL
	vYBaaRNA8VfyJoeLmE78lPg4ku2Wf/FbJg1fkMbOS5/i2Btd8YP65UHbKfZUchv4Wpz9DXcmA3W
	0+UcPpJJWk1CduFG9BE8kjJi/9e2Cu4LfQzFBivWS31veQRoOWPhX72g6eDfSuGklbzlSK32OzK
	MYJxdcnl8m8dyv0D5CAHxvoBCqTWq4pmzKhgxT2tv+pKly34fLLwRvf8xlZCS/ztrFiK3GggMmL
	uLVidfMruRCneBdOdV1CO8IBveI6ybxM7oPFZyHvsdupkgw5Dhf2ys/fCNpQf1q2ZRCQkDjJKns
	ojBx8OMFMX/dDS2fmZ2cJu1anCEOcPrYl1K2Yj3E8uzmIaxRsMwRbhP2dUKDl55Lr0pwwMDyesh
	2iQWK34x2mw==
X-Received: by 2002:a05:600c:4ec7:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-493d11d9562mr25934315e9.14.1783155204942;
        Sat, 04 Jul 2026 01:53:24 -0700 (PDT)
Received: from localhost.localdomain (62.174.240.101.static.user.ono.com. [62.174.240.101])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef23feasm214141535e9.2.2026.07.04.01.53.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 04 Jul 2026 01:53:24 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	ayu.chandekar@gmail.com,
	chandrapratap3519@gmail.com,
	christian.couder@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	krka@spotify.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk,
	siddharthasthana31@gmail.com
Subject: [PATCH v7 0/3] graph: indent visual roots in graph
Date: Sat,  4 Jul 2026 10:52:32 +0200
Message-ID: <20260704-ps-pre-commit-indent-v7-0-a94706cc8376@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
References: <20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260612-ps-pre-commit-indent-39ca72816382
Content-Transfer-Encoding: 8bit

When rendering a graph, if the history contains multiple "visual roots",
actual roots or commits that look like roots (i.e. have their parents
filtered out) can end up being vertically adjacent to unrelated commits,
falsely appearing to be related.

A fix for this issue was already attempted [1] a while ago.

This series adds indentation to the visual root commits, so they cannot be
vertically adjacent anymore making it easier to identify them.

Before indentation:

	* A
	* B1
	* B2
	* C1
	* C2

After indentation:

	  * A
	* B1
	 \
	  * B2
	* C1
	* C2

Indents the visual root commits that have still commits to show after
them, and if they have children it connects them with an edge at a new
row.

If there are multiple visual roots adjacent in history, the indentation
starts with the second one, avoiding redundant indentation of the first
one and cascades after the second.

	* A
	  * B
	    * C
	* D1
	* D2

This series first commit is a cleanup that brings a common function
from t4215 and t6016 to a graph functions file which they both use, so
the new test file for indentation, t4218, can use it as well.

[1]: https://lore.kernel.org/git/xmqqwnwajbuj.fsf@gitster.c.googlers.com/

V6 DIFF:

- Replaced the queue peeking with a 2-entry lookahead buffer populated by
  get_revision_internal() (second commit and graph_peek_next_visible()).

- Changed assert() with BUG() at graph_output_pre_root_line().

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
Pablo Sabater (3):
      lib-log-graph: move check_graph function
      graph: add a 2 commit buffer for lookahead
      graph: indent visual root in graph

 graph.c                                    | 282 ++++++++++++++++++
 graph.h                                    |  17 ++
 revision.c                                 |  17 +-
 t/lib-log-graph.sh                         |   5 +
 t/meson.build                              |   1 +
 t/t4215-log-skewed-merges.sh               |  33 +--
 t/t4218-log-graph-indentation.sh           | 453 +++++++++++++++++++++++++++++
 t/t6016-rev-list-graph-simplify-history.sh |  25 +-
 8 files changed, 798 insertions(+), 35 deletions(-)
---
base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
change-id: 20260612-ps-pre-commit-indent-39ca72816382

Best regards,
--  
Pablo Sabater <pabloosabaterr@gmail.com>
