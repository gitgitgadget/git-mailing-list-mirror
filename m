Received: from mout2.freenet.de (mout2.freenet.de [195.4.92.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79C1DF72F
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729185837; cv=none; b=cCNlMzby2BQ5e+/Dgq72LF9ZGhHVGbjW+6c075eQWlPtvgOvP20bIQUhyN5ObV+yEsd0fd0wa8vow4RNKXJ1RWiKXEi839kpA5VpTcUaljHuGIEwpwBbUQk/vr+KS2AVUkuV6JwqAiTwtWp0kAsen4C4Dm41NpCMxUEIgNJCt2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729185837; c=relaxed/simple;
	bh=ckIEo7i5mtMCeaKWIP3nBd2R0VtJ3FK/fBVTP2gmVoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EY17tx+JogcXKUxOy2GmS6yORpklZwNBQrPxNNxRQ3YKzo1GEtyiYSv23OWzIgIeAoet8+DwldQ8Xl6Em5pfHTM1P7fnLFXgY927VxZTLFgBLg6pd7vyFJa6xrf15JnSTRdvW3JWRbZx1+F4MJAdM4XD63XV3ky7eoSrrW/g2pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=f7dkaCgP; arc=none smtp.client-ip=195.4.92.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="f7dkaCgP"
Received: from [195.4.92.121] (helo=sub2.freenet.de)
	by mout2.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1t1U8r-00CHtz-Df; Thu, 17 Oct 2024 19:18:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=8QEX18nlkg1ulQpu51cYf9NO6yGueMXroHyN6dq95wg=; b=f7dkaCgPcMh2D4wYWnb9WzjoM1
	acDHOhaRa99kCREu1eIuF4bXcg4PFGzFgOZupVkygTtRe5imot1qqXLgToxSPDwY3FO7waSEwJoiR
	3SvoTwhlrmQsZzrWaj5GagR7uSp7ILFfCc7FB9ojyzVaApK9z+ptgkXbRMHo4xDywv/T6wfpVWE7f
	MzWBaOFS7ZyNF5Z5nBpmqGgR2pWSc+k7CnTYTwz6HUM2x4nud9kvPLz8pUum0ekJOabkKkvVWWhgt
	u0FUMAPD3LXmUDVrMahqxeOCKg6Ik1R/5i9QjWvvo7QIHueDtUjmCp3Q7vV0inmQQcfE8FoKQddxo
	06Z+NOWg==;
Received: from p200300e2e7083000dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e708:3000:dacb:8aff:fee0:ca63]:54334 helo=soren-pc.lan)
	by sub2.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1t1U8r-000sre-2r; Thu, 17 Oct 2024 19:18:29 +0200
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: tboegi@web.de,
	phillip.wood@dunelm.org.uk,
	gitster@pobox.com,
	me@ttaylorr.com,
	=?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH v5 0/1] mingw.c: Fix complier warnings for a 64 bit msvc
Date: Thu, 17 Oct 2024 19:18:19 +0200
Message-Id: <20241017171820.2679-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <ZxAgmvoyxZNnY1nQ@nand.local>
References: <ZxAgmvoyxZNnY1nQ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 17291855093252F07C196CO
X-Originated-At: 2003:e2:e708:3000:dacb:8aff:fee0:ca63!54334
X-Scan-TS: Thu, 17 Oct 2024 19:18:29 +0200

Hi everyone,

I fix the missing space in the commit message.

Best regards,

Sören

Sören Krecker (1):
  mingw.c: Fix complier warnings for a 64 bit msvc

 compat/compiler.h               |  4 ++--
 compat/mingw.c                  | 25 +++++++++++++++----------
 compat/vcbuild/include/unistd.h |  4 ++++
 3 files changed, 21 insertions(+), 12 deletions(-)


base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
-- 
2.39.5

