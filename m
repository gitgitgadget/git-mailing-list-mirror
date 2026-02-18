Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A22D46A9
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771381929; cv=none; b=rf7YL3Qn0YH+nHzT4SFy12Kd6nVtWB+njeRZaHFFb5vqVrOlbGhwV6GtZtEqvzEu7S6HaNxVTDYHqtObJ0WjEuf8oeoA0lXWr6R1U4hKGq32pgKfrAk/8g/apXxDPdMNi6AWDsKyE7dy7udHvpgoZNCsA734n8UFCUNvp4H3u/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771381929; c=relaxed/simple;
	bh=hjTJkh8a91S6lU++GCA+V6uyVin9tJZXJyxLJ9YnuUI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=I8j9rRYRr2B0LMfc3pFgQ2ztWQ4/3FNIArYqBSHlyNka3+ekSdvsPFAeGnOMMz4GcSBwclY2vR2YxQFEfPeloWZ7c5XjNgUkwAUSAv1PmK5sPdI4PgDs87vPFcy9/SKjGlciqANReJCt0YhHkHf2Up/aVf68Emb0PApAzapaUXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=KH1yJQJs; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="KH1yJQJs"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXMD-00GV7N-2P; Wed, 18 Feb 2026 03:32:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Cc:To:References:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From;
	bh=g6/cGFozlGaqfZa06rxNnH5wSNW8fbaNw/dG0XjI/1g=; b=KH1yJQJsmtroviiDsB6+wylLj3
	8RYVQKogDTswznTd7w40fcQApqHPe2mdOzGEHJDWf5P5ppGYKws23GRYdKk/2+YEaQHU5Ox5mBEUB
	EDFpJlT/kHG4GVyTspgX4PHnybeKm94bX/mC4ZavA5TGOTclJ1j6cth6dJtC4G1xDCa3XcjSf40Fn
	LmxKme8njsZm0rKh11KMZRgIjqGA0C+LYGe/ozFc3KbD60VBvGjvkcpK3dq1Lqn1tknIwfilPCYOM
	wAwHJzuSJMoz9PSKl4+pYKUwhyAjuAeYksb7c4Cy4RriIpZg/wYi5EBAURLo301VxbQ42nS4DSuUm
	3aIRqxJQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vsXMC-0007lC-PZ; Wed, 18 Feb 2026 03:32:04 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vsXLs-005i9g-1g; Wed, 18 Feb 2026 03:31:44 +0100
From: Colin Stagner <ask+git@howdoi.land>
Subject: [PATCH v2 0/3] contrib/subtree: process out-of-prefix subtrees
Date: Tue, 17 Feb 2026 20:31:29 -0600
Message-Id: <20260217-cs-subtree-remove-optimization-v2-0-4299e71a30c6@howdoi.land>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIEklWkC/zWOzQ6CMBCEX8X0qmtoAwqefA/DYVtW2SiUdCv+E
 N7dQuLxS2a+mUkJBSZRp82kAo0s7PsEZrdRrsX+RsBNYmUyc8iMPoITkKeNgQgCdX4k8EPkjr8
 YUxXQYZ6b6zEvyaokGQJd+b0OXOrEFoXABuxdu2g7lEhhCbYs0YfPemTUS/y/WZhMV9lhX5ZVV
 WjQgHLf3jieW/9qPO8f2Deqnuf5B0UZxuXNAAAA
X-Change-ID: 20260217-cs-subtree-remove-optimization-aca442f748eb
In-Reply-To: <20260215201906.889951-1-ask+git@howdoi.land>
References: <20260215201906.889951-1-ask+git@howdoi.land>
To: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Zach FettersMoore <zach.fetters@apollographql.com>, 
 Christian Heusel <christian@heusel.eu>, george@mail.dietrich.pub, 
 Christian Hesse <list@eworm.de>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
 git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Colin Stagner <ask+git@howdoi.land>
X-Mailer: b4 0.15-dev

* cs/subtree-remove-optimization:
  Remove an optimization that can exclude too much
  history during a "subtree split."

Remove an optimization introduced in 98ba49ccc2 (subtree: fix split
processing with multiple subtrees present, 2023-12-01). The
optimization incorrectly excludes commits from the split history
that must be included.

The above commit, and my later attempt to fix it in 83f9dad7d6
(contrib/subtree: fix split with squashed subtrees, 2025-09-09),
both introduce known regressions.

Improve test coverage for `copy_or_skip`, which will help detect
future regressions.

Signed-off-by: Colin Stagner <ask+git@howdoi.land>
---
Changes in v2:
- remove incorrect newlines from commit message trailers
- patch diffs are unchanged

---
Colin Stagner (3):
      contrib/subtree: capture additional test-cases
      contrib/subtree: test history depth
      contrib/subtree: process out-of-prefix subtrees

 contrib/subtree/git-subtree.sh     |  50 +---------
 contrib/subtree/t/t7900-subtree.sh | 198 +++++++++++++++++++++++++++++++++++--
 2 files changed, 190 insertions(+), 58 deletions(-)
---
base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
change-id: 20260217-cs-subtree-remove-optimization-aca442f748eb

Best regards,
--  
Colin Stagner <ask+git@howdoi.land>

