Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F8919E979
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952184; cv=none; b=lcEmAuzZJQIqkcxBRINsVjpncTwP7gFAMMj2QLBOTIEidpdGB1RQ15q4d9Iw6GI+coXpi5Hnemk2S/lIBB27crB5C4rK15r9uemD4vBW9ScA0buenJNB8KaS0gGdeyAUbQVIqwY0i8dcifZRMiZfAGWmQJyKxX2yAZwOYgAgcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952184; c=relaxed/simple;
	bh=PJsgMwg2shoVYCuX4jYQLfiRjzlnB5PqnfYk6fX9oos=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=K8eFYdnKh5jLj8Y+yUhYRRoIfG30AostuO3F81upnDOHYdPeaJip2cnyVwX3Q3rZNFW/hJv/042nXC8jR4Myh5TXvGNZMkI97rHt+sK1xQ9myQYtCKQ1B+1CbKoU0VmWKBBh6RAd4ToS4C9Ri2cQUijJUEbltt6T9RN0FGKeQsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=WL0pVdlx; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="WL0pVdlx"
Received: from [195.4.92.126] (helo=sub7.freenet.de)
	by mout0.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tPgEZ-0042YY-RR
	for git@vger.kernel.org; Mon, 23 Dec 2024 12:04:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E/reRS3Gdt7CNKzxFbVWBIbwuHYBIB92LlYtzAZTgkQ=; b=WL0pVdlx0kyPTajXaaWp5bROCV
	fTGIfanUbnqH0/Uf7e31Bx3hSv2dLm7aYm0Oi8CGVk5RoQh+NiioH/CeRE6odKF1T+igEgaQ+tuGf
	DfXL6EBwryUhkn0MFvu7Y8C9rfG2kmQc3Fp+8GDJg2zeGOdgzLYyPc6OqQYzj9xE9iH81VnNucKR1
	S2xDjX980rZ05f+qrW5dkfhVmVgfTEGXJloernh5kwB5B0nDDEJKaP14UoH+50pZ+i4YrJMOqND4I
	shC31fCGE6XgEbUeodtsx8JbYsXB6NWZYv892xXc+q68/q/gPsHgCO/Vs4MCvAB0/uh0aXdHlIZtR
	ETnVyHwQ==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:53566 helo=soren-pc.lan)
	by sub7.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1tPgEZ-00BYML-IF; Mon, 23 Dec 2024 12:04:23 +0100
From: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
To: git@vger.kernel.org
Cc: =?UTF-8?q?S=C3=B6ren=20Krecker?= <soekkle@freenet.de>
Subject: [PATCH 0/4] Fixes typemissmatch warinigs from msvc
Date: Mon, 23 Dec 2024 12:04:03 +0100
Message-Id: <20241223110407.3308-1-soekkle@freenet.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 173495186308F2F0DDA93EO
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!53566
X-Scan-TS: Mon, 23 Dec 2024 12:04:23 +0100

A smale series of patches to fix some typemissmatch warings from msvc 14.30.
Most of the missmatches a 64 to 32 bit conversion on a 64 bit Windows platform.

I use size_t where the variable values cannot become negative.

Sören Krecker (4):
  add-patch: Fix type missmatch rom msvc
  date.c: Fix type missmatch warings from msvc
  apply.c : Fix type missmatch warings from msvc
  commit.c: Fix type missmatch warings from msvc

 add-patch.c | 44 +++++++++++++++++++++++++-------------------
 apply.c     | 37 +++++++++++++++++++------------------
 apply.h     |  6 +++---
 commit.c    | 10 +++++-----
 date.c      |  6 +++---
 gettext.h   |  2 +-
 6 files changed, 56 insertions(+), 49 deletions(-)


base-commit: ff795a5c5ed2e2d07c688c217a615d89e3f5733b
-- 
2.39.5

Thanks

Sören Krecker
