Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C73253F11
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186776; cv=none; b=TIrJmYauiBK6Liapd+tzRpkKOq7ziodryzGpSAulYGSAGxMSqOJcB2JfkFuA9nPT5PSugrzMDH778sJ+SfxGhUAbO7eA/1jJnL7fomoZIDcyTtLvSwB7BDvHjMvUOXcCpZc66QrGP0gMDRdcinVAY4iqNYqU+jT6JkCI116xPlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186776; c=relaxed/simple;
	bh=0ihzHjKwvhA+F6dR9QvO2/CYmiiU0FVmgeG4LmyORCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpGMNUkSwR1+wWDVl+BTtzV0MWTqC1k8z6T5SWhS38PCe9Y7kvtUACLwmEf4kkvldL7c7wDaNjT9f043/lXu0PWKESeBxiXVpiDMyOvJU+PI0Y1J+y7LiJAhwhimPNYKtwKk6kJiP6tnpTj2QmgacBpxdFhQcmdpJMv6TIJlZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land; spf=pass smtp.mailfrom=howdoi.land; dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b=PU7RMDqf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=howdoi.land
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=howdoi.land
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=howdoi.land header.i=@howdoi.land header.b="PU7RMDqf"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriab-008AuR-8z; Sun, 15 Feb 2026 21:19:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=howdoi.land
	; s=selector2; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From; bh=J/2eA0hxPgwRo5onrpXjDxi9yr1kuuVGu479IISG0Z0=; b=PU7RMD
	qfLlyVH5DAqgoA0qcIMcOGsklgiDeJlx1xat1BxUSmCrHS/GyTAqaWoHjpA9Iaf11YrVd2jYXBQmL
	vlTn+CrWDjH0dh0DNr9oN3su3ZcdRyk+PHUeW/F0MltwWAMndGnQoRQKcVmJIevyZ3gAXxKMNtREB
	9ra2K/KXh2Lfi3Z7mNLWFIoIpIpxXJDtlM6mNl88BPm8EiZ3VdKi3vuEHiOE16DcQEHYhSDXfmQCM
	QofBJY3NOMxaGO2b1uoV+LrR8E5cxWnts8BgVKNzzirqVzcxyud9YxZ/JzKdIfGGaO0LLWSwN89NH
	TAJkhIJYW208xhhqaHfCfeO+JHUA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <ask+git@howdoi.land>)
	id 1vriaa-0005o1-UR; Sun, 15 Feb 2026 21:19:33 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1204229)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vriaQ-00E3Nx-Cg; Sun, 15 Feb 2026 21:19:22 +0100
From: Colin Stagner <ask+git@howdoi.land>
To: git@vger.kernel.org,
	Zach FettersMoore <zach.fetters@apollographql.com>,
	Christian Heusel <christian@heusel.eu>,
	george@mail.dietrich.pub
Cc: Colin Stagner <ask+git@howdoi.land>,
	Christian Hesse <list@eworm.de>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] contrib/subtree: process out-of-prefix subtrees
Date: Sun, 15 Feb 2026 14:18:44 -0600
Message-ID: <20260215201906.889951-1-ask+git@howdoi.land>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Colin Stagner (3):
  contrib/subtree: capture additional test-cases
  contrib/subtree: test history depth
  contrib/subtree: process out-of-prefix subtrees

 contrib/subtree/git-subtree.sh     |  50 +-------
 contrib/subtree/t/t7900-subtree.sh | 198 +++++++++++++++++++++++++++--
 2 files changed, 190 insertions(+), 58 deletions(-)


base-commit: 852829b3dd2fe4e7c7fc4d8badde644cf1b66c74
-- 
2.43.0

