Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDFF2AE8E
	for <git@vger.kernel.org>; Sun, 22 Jun 2025 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750605965; cv=none; b=hHh2ekEABZVsF1tz2mhDQ7ucv98nOFrMdyvI4b/27CubKv9U/1ou7jUnMWshDPXWlespwo3mTxMWUVhXtcxg3zpGLKYDciJ3qIMlbArsIs009m65jCD4t0TqPH7rEQKj1MaL/JFCKGSvMV4Sj8VHm0NFaBMP335O1x6lwyr9IJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750605965; c=relaxed/simple;
	bh=F1qC8kviKy7B0xfd45lO2MFfUcDPoLMfp7dViOoJFvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p3IFs9Zt5gmVe+p0A7kZBh5BKEBwX6zXRUdWXokYpoKv7zTtEp9McfsXOEJS5AX8WZCK+3cvSIM9GTGxfrXCBGSA6dq2LvWFdkTHG1HEqJQgUubzpabX93nld8TZByPcjRe7yWA7DkK3iEBgrGniTUXNg6Ri+/T94VjhdO9YSNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=h/L/iRid; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="h/L/iRid"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZs-005yg6-IC; Sun, 22 Jun 2025 17:25:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=2grAiqWipjvvVQWmm2FOyn61jwcAfCw6ZgmhGGgsIMw=; b=h/L/iRidWVnf17yPHfiL1FGmnf
	qxWNJzVmxUc6NZKAOGhUo79dVt8Gzc4gx6w8M+bhaB6XVK0TXMv/IfpH3qiF6XvjJ4uUbxG9A9+6O
	vSG4q6P0BNryxlXhoKg7ATAKTBbaEYYGGx42Sv03YWVeQyqqdVGHyPpw557OVrOEVopaYchbX7f/V
	01DyAnaREnIL4vVlsxMohuNgRTh2pYmSdaqEf+EERAOchqeryxmZyqzqG8Bu84pkQ8ojMVSVHGQ9n
	n61U6Z5Kj0Gp5G0Bm6is1fTbU8V7UkhmkAgjw81KeUHseHefbiT55Rqde/NV45QZnMhz5alkiCNJ/
	RqYh2KiQ==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTMZr-0005Ol-V2; Sun, 22 Jun 2025 17:25:52 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTMZi-002aWd-RG; Sun, 22 Jun 2025 17:25:43 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/3] git-credential-netrc: better symbolic port names support
Date: Mon, 23 Jun 2025 00:25:32 +0900
Message-ID: <20250622152535.11837-1-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5dea3a8a86
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
References: <20250620041239.27839-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change tested with 'make test' as well as
'make -C contrib/credential/netrc testverbose', plus manual tests (such as
sending this series!)

Maxim Cournoyer (3):
  contrib: use a more portable shebang for git-credential-netrc
  contrib: warn for invalid netrc file ports in git-credential-netrc
  contrib: better support symbolic port names in git-credential-netrc

 .../credential/netrc/git-credential-netrc.perl    | 14 +++++++++++---
 contrib/credential/netrc/test.pl                  |  8 ++++----
 git-send-email.perl                               | 11 +++++++++++
 perl/Git.pm                                       | 15 +++++++++++++++
 t/t9001-send-email.sh                             |  7 +++++++
 5 files changed, 48 insertions(+), 7 deletions(-)

base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
-- 
2.49.0

