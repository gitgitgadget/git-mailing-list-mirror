Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67D723B61A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185821; cv=none; b=OFtjG0nVPlK+BuqrlFxrfvv+T9C2EzqfnvCQauZ2AC9Kjpe1gzUoW9hQH2z00BoIukDoCPl24nIpJ2QFrG1206750qH9oDjK05+P9i1aAwnzyYVqmgqLreJNpgXHr7cHYAOOVDkiSkLCFiftV12ft/V9lND9UhMWkon8eidZwgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185821; c=relaxed/simple;
	bh=EQjYwsSE0gcyd2u2msAgMgD9Nv4EXc0TQ1NQa/MQBaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBMkeFUUOxzoNK31N3BLJ9JVvXj5XL5ioM9Rq784G+e9zTOnUS9ypx/J+Kt4QQE4sveR8KlwFiYGw8xmZK+6cojCvLXqcKi6DbM29U69STbfsd5tCddHJRSKZO3DFbbruVeJnacKlrOuh3EK+HtIT2y9obKCoWgyPTx9GhIFmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=dmXXlnYb; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="dmXXlnYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1752185817;
	bh=EQjYwsSE0gcyd2u2msAgMgD9Nv4EXc0TQ1NQa/MQBaU=;
	h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=dmXXlnYbYISdARnqRZKjZb8kUe27Q6A8xWyz8DddYy18PCWKXuCGD+FSYyjAje2Te
	 V027UXIShvEbtKtE9qIPqFkNW4WYgk6LPR4+9WL++fRSd7RZeYDS/yZIy79rKfhva3
	 wB9jcPuaOhQwqgvozUyp3fbqlGhWfK8/wv+vryUovuFeZdS57n92+g0AieevDNTWM7
	 j5QxhuI5uJ08DD4lXFDgPIMj2rImJhyG+hDAzEWSGdAixdcEyhPI+rLX9JbU4f4uTA
	 bm5NHXJbNgvGPR2Be7JV//+3HWHjNq4rCBIU735SalhRd7Py746NqloXbr7X3U5/U0
	 mS6EKXhVt1IQXDb76ydppK6UEO990VspdP0Q4H1Wd1sYrUzSQdhWOuTtpoWzOyy19o
	 07AOS+xqs8hXckmh5szDhKS7Mp5dahBaHkXFJ7drmUSqaxS3hMLLF52BMdSUXBUYSO
	 ro2rXcXwNscRHPEa6Uv09Mc4kcYvW+Mg2RAxDSDVrq1JUSWD9G9
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:828b:3227:a916:b7f5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 999DF2006F;
	Thu, 10 Jul 2025 22:16:57 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Yi EungJun <eungjun.yi@navercorp.com>
Subject: [PATCH 0/1] Filter C and POSIX out of Accept-Language
Date: Thu, 10 Jul 2025 22:16:40 +0000
Message-ID: <20250710221641.857081-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.50.0.714.g196bf9f422f
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At work, I've seen some cases where people provide "C" in the
Accept-Language header of their Git requests, such as when they provide
us with debugging traces, but "C" and "POSIX", while valid locales, are
not valid languages and do not belong in the Accept-Language header.

It turns out this is actually very easy to reproduce and fix, so there's
a patch to filter these out.  I have not actually myself seen "POSIX" in
the header, but it's equivalent to "C" and I've seen it in non-Git
requests in various places online, so we reject that as well.

This can be seen in GitLab's issues as well at
https://gitlab.com/gitlab-org/gitlab/-/issues/412077.

brian m. carlson (1):
  http: don't send C or POSIX in Accept-Language

 http.c                     |  8 ++++++++
 t/t5541-http-push-smart.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+)

