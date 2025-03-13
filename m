Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FE82E3379
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875480; cv=none; b=HK6yJqajo8pSPdgYOz3fsUh6P5u9A36gM/CZuaICXei2zQnTymHYPCjhQMZ/Sq5BBtPGYX74Dg9hych2+lBRe1YMZrZNgBUT379SK8xJ0sq4TwGYEOuUMCjxOEBP+PWuCTqE8VIzBZHIsiFyZ5ezJV9v+PPSjM0NK/mGgGG1hm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875480; c=relaxed/simple;
	bh=0QM/UDNUT0rLtld5FtUXa2xojC/LIz1ctq9vYe3hmrw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sIWMdBUcAfiI+7eCgq6YkQgD4z+NNB91At/lsXgu0f0J8IQXRVuZ01kf1gkHdjNY5pbJfcCAo07j/cieKanoNh6JANp1hLvWDQvdqxwvntx3k/Y/u8qYYLFiOI4/+HN2sLYoZGHBycIugF1pp7M37COfZRfhqDH8yHHRUqlay3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JwTOk7w5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h1FbXd0y; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JwTOk7w5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h1FbXd0y"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 20F6B1140253;
	Thu, 13 Mar 2025 10:17:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 13 Mar 2025 10:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1741875477; x=1741961877; bh=n0L0OVoemX
	2yCLv9AEn0Z7jxRHiOzPzzwiW8dE3A6uQ=; b=JwTOk7w5dFoyYmEWec2d52VDgB
	xRl6jA/Dddnl8YkgLo3LlGfSeSSizWjx+NtGPJQzaRRYcbHWcPbuRBTEFBzcNBEe
	EsNbiuZBjwpbOpnR5TvKanf8iC987rDTnUwgoRQoJrkGQ0gjrdgphioAfazDv52x
	IeBr/RW7XQYlVgCdAqxVk0FPINIRPvPRQTU1OVP1rULqYPdpF0TOzc8fifbQhCSY
	1ooUjlO2aXOWwsgUd0TvYimg65AlsiULd6dztNAUe/X2TiorcWhSZ24SS2nE9zVM
	gvjgni1VkIi5PBFpnXX8EYbVclDU2KV0v3agNi7BNeC5C6ObkaqsRwEO9ZpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1741875477; x=1741961877; bh=n0L0OVoemX2yCLv9AEn0Z7jxRHiO
	zPzzwiW8dE3A6uQ=; b=h1FbXd0y5WIMC+JK1Th2+p1UqiXNNe95levXorsUU2Od
	BNmESuXUYk5Z6xzgg/bFwBldYK8ZYwXUpCZpllWp2/38ylpUF3/RxmPR4Vy6S6kn
	1R4UnDGH+lrmSuinznaa2BUmKbwFHjvASY1TYFUC+B/0G9RuwUxFFOnQn43grEgO
	CzzsoyzlIcdI/wFj0zHFPAxCnu3ZKcKBpWtzOzT3BjNDsavXmjxEuXUdTbBVjz/1
	earUNAZLwFU/cx1Ip/82oXje148YkUOJkF0kr5ZgeRqWlXTcGbvs7jF6W2jG6tA/
	ZiR2atDKU8hbUSPp0i9A9+6PCTXEEYxFugGZIIDI5Q==
X-ME-Sender: <xms:FOnSZ6NZ69DiMvUAPdHv04-ErDXbLtR22YyJkVm06UMia42li0JkZw>
    <xme:FOnSZ4-496qfglD_e_jKIu9amfcUi3mxLzrZO3KY4QzcoDYzV4sAQ6AQiLTyEkym6
    dnFJN2RH0XQweNZdQ>
X-ME-Received: <xmr:FOnSZxRnfniDldkkI7EkmgSECIachhcK2i4XIgjyWAR6bOtqnh0VOywvfSXNSUctZxirMyo6B8iWTADKN_KfF94Kvv2Uf37J250mT728Y4mdESrjhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevueegkedtteeigeejueehuedugfevleefveehueeh
    gfetffffvefhuefhueekveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhope
    hjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FOnSZ6tHwYGJXD-7bMUn2fXxiq9erpTzNqhtummRiedA18Dq8KH1Uw>
    <xmx:FOnSZyfqln0tORyDlsKWw0_8-T9XhLw7m4i_003q02jCzibb4xRbXw>
    <xmx:FOnSZ-1Yez7JuIvSOjdCeUiILW-yjdaJOlt-3DF7BavcQ3FE2HPwiA>
    <xmx:FOnSZ29cg1-SWISx99cMkBkrRUko2byDTqFaQAi4BYwnFdltpMZPEw>
    <xmx:FenSZy4PC53QJo8wvmAk3jI2aZAmAs1VtGyHPCB4mgUsMHN3_HN3DKhs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 10:17:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 214ec71f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 14:17:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] compat/mingw: fix EACCESS when opening files with
 `O_CREAT | O_EXCL`
Date: Thu, 13 Mar 2025 15:17:42 +0100
Message-Id: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAbp0mcC/x3MQQqDMBAF0KvIrB3QaKn2KtKFjj92SBolgSqId
 zd0+TbvpISoSPQqTor4adI1ZNRlQfIZwwLWOZtMZR5VUzc8tby5xF8Ny85+FWfVg60fHbjtZyu
 CDk8xlIctwurx34f3dd2C1i6fbQAAAA==
X-Change-ID: 20250313-b4-pks-mingw-lockfile-flake-49dfcce8e7c2
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Hi,

I finally found some time to have a look at why t0610 is failing
regularly in MinGW. As it turns out the root cause is our emulation of
open(3p): when trying to open a file with `_wopen(..., O_CREAT|O_EXCL)`
the call fails in case another process has marked the same file for
deletion via `DeleteFileW()`. This gets triggered by t0610 because we
race around locking the reftable stack and thus causes the failure.

The fix is simple: we get `ERROR_ACCESS_DENIED` in this situation, so
instead of translating that error to `EACCESS` we translate it to
`EEXIST`. This fixes the flake on my machine, but as usual when it comes
to Windows I would very much like to ask those in the know to point out
any obvious mistakes I did.

The other patch is a while-at-it patch that I was wondering about while
debugging the issue. It's not needed and I'm happy to drop it if you
don't think we should include it.

Thanks!

Patrick

---
Patrick Steinhardt (2):
      compat/mingw: handle O_CLOEXEC in `mingw_open_existing()`
      compat/mingw: fix EACCESS when opening files with `O_CREAT | O_EXCL`

 compat/mingw.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)


---
base-commit: 4b68faf6b93311254efad80e554780e372deb42f
change-id: 20250313-b4-pks-mingw-lockfile-flake-49dfcce8e7c2

