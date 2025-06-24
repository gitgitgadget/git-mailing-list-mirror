Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C313D8A4
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 01:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729784; cv=none; b=HWElDxIRWi1KLXlRPgBuRKDWiZDFRJcJRzo4vZhdfoJSvL9fma4zaK6rMv/c6iQIbiL5UauNSNL0Oapm5IhzX+tpubdNQBvT88BeN+4gc3moJ2BOT2ba9Ixfs8B99wkxOOTOioDEEZx8h5GQcjEtyPTmVZEUVLk+NLGjBNUC4Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729784; c=relaxed/simple;
	bh=7FoI6uHhdHFl8d0A8xVmZ+XJjk1O4bdiLtB6C+l7XOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7U3rxV1jiQU8F74QDV/BLMAI+RVAyawTWjY4LcXUzdPNflJYrT/Osuq4xUIyUsihDk+/PYlIAxgpcxj5rtzfYObSgQw+Wneo8gUXGbkooCBrSluRJe61O4/rg2SPq3D9HOFfHM+fsKq8orinAgiG8GuLSZpelhx9Jr00d64A3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop; spf=pass smtp.mailfrom=guixotic.coop; dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b=ZkioMMPl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guixotic.coop
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guixotic.coop header.i=@guixotic.coop header.b="ZkioMMPl"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsmy-009c4R-CN; Tue, 24 Jun 2025 03:49:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=guixotic.coop; s=selector1; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From;
	bh=k/vY4O6WlsiqheZTYN6UDsIoj6GhtF5q+pBNwWrwkaM=; b=ZkioMMPlI+Y1OwOhnYP5o25H1I
	9CYISNN09YdvlaY+GpMS/UkfLLJmNQqGJkN+GoHXkkAGQ0XGHBLovBFiqN9TqOX6YFIdWTu+ec6Au
	CgoYqatkU35IN+aj6rnD917+JlK7+JHavbeO2AHprJ7Rm5v9LagLQ/PugDffM/9I89y0XsKHnU0Vu
	d3EX/bUm48z45RwM/ryTDVmBmAlejQ+eX3Bja4eCS5DKGaikka65A9Mwo+uo3s/Qj3CZkKdn1icb9
	CpxSgS3x1yU7w2bqK+I36kelMly+5NNZ0reWwzcUfIE/tb3L0hEMICw8FW/ItBm51lq7UQWMxInAC
	OW/7Df6Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <maxim@guixotic.coop>)
	id 1uTsmx-0002g0-QV; Tue, 24 Jun 2025 03:49:31 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (1476852)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uTsmm-00DjBm-2w; Tue, 24 Jun 2025 03:49:20 +0200
From: Maxim Cournoyer <maxim@guixotic.coop>
To: git@vger.kernel.org
Cc: Maxim Cournoyer <maxim@guixotic.coop>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 0/3] git-credential-netrc: better symbolic port names support
Date: Tue, 24 Jun 2025 10:48:54 +0900
Message-ID: <20250624014857.3748-1-maxim@guixotic.coop>
X-Mailer: git-send-email 2.50.0.84.g5fc0c030e3
In-Reply-To: <20250620041239.27839-1-maxim@guixotic.coop>
References: <20250620041239.27839-1-maxim@guixotic.coop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most suggestions from Junio have been applied in this revision.

Changes in v3:
 - rename is_port to port_num
 - directly return scalar value from getservbyname in port_num

Thanks,

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

