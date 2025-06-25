Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260AB26656D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861561; cv=none; b=WOd7QjrPaJLHIKzqv2weWurFrsXjl9GzS2ftZIKETkmPJNhoLqFa8wvVF/jp98nVzPytlRRAVY/6EZ8btC9mwmb0fT2EArrcWGcqCdt+if8O3mknMtRBEUEn2tUguKCusVWYCRi2TY9T9mvOVMZNNtU2w9xgPrSepb0/F6b0Ew0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861561; c=relaxed/simple;
	bh=RpjrqELReX0Adjilyv2THiDd3QXDX5uoPd+ttcDFQig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1d8abMIbFL06SULTH3HJG0i9rlgizD7wOs2SxVsFgrC03TY9uaLsanCLoXftI0CV4/8FQGeZwHbZII9ZmKfxADmxSC93IbssI8UAACOhERXZZXkSeiEXfVPgv65p+SI+9bsapsyvG0UjSm7PX0eNPxbKE0wCuBaKZgKJL0gyrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=dkZ71rjj; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="dkZ71rjj"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4O-00EOwG-5Z; Wed, 25 Jun 2025 16:25:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=gM4NVWShX6prM+eOttGEnhQ65Y5Y0w/2DkngOgYQPb8=; b=dkZ71rjjx0mdS35O2a0Rpxunla
	SwX89GdcDTFPBafM8H6QiY5l1X8ns6suEWn9FyajT5CgzVfs58DhByp7UEjrk8NFzMR5ItAB2CJjF
	2/UDZhs4zrPpO/xmDjenuNbtgikVNmWvF7gwSm2mZmsxtqvo/OW974O52JPdPLXJ3mx97a5xqC98F
	dnuEYA2vPjwOfTiXradfRXgUlYe2+iJo7u67JyNvtfyKFD1KxGLL9aOjd7j/1BSZ+WJeSS7YVX3N2
	hAhR1viRwbUM5lgjecR5RyJMKOVrYwrzafWu0YIHSGnV2+PnH+5iHKdybglIHKPNo9tVimBpbUt8Q
	JiaLEw/Q==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uUR4N-0002oy-FG; Wed, 25 Jun 2025 16:25:47 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUR44-00317J-24; Wed, 25 Jun 2025 16:25:28 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 0/3] git-credential-netrc: better symbolic port names support
Date: Wed, 25 Jun 2025 23:25:08 +0900
Message-ID: <20250625142511.28857-1-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
References: <87ecv8k4y9.fsf@terra.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This revision fixes a single white space in a new test added in 3/3.

Maxim Cournoyer (3):
  contrib: use a more portable shebang for git-credential-netrc
  contrib: warn for invalid netrc file ports in git-credential-netrc
  contrib: better support symbolic port names in git-credential-netrc

 contrib/credential/netrc/git-credential-netrc.perl | 14 +++++++++++---
 contrib/credential/netrc/test.pl                   |  8 ++++----
 git-send-email.perl                                | 11 +++++++++++
 perl/Git.pm                                        | 13 +++++++++++++
 t/t9001-send-email.sh                              |  7 +++++++
 5 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.49.0

