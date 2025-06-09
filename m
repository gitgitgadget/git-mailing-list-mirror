Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A5217660
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484809; cv=none; b=meF+81Wm5wwKhzUnJIBoy5KX3JMWLBSkGdH5bUArBJ6JN8cdfzw229lgumF9WKeDHAN5Avmo4ng3cYFBiohjeCYwV577+nCjtqmZ2qxE4tGssNVPYAWDbY5ZMk03VuydAx0N9aYkXVVbODjebxFtcK2C7nTiJ2YrB9+XY5sQZA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484809; c=relaxed/simple;
	bh=zDehq5gmAxBkTkl22afA9yvI4DUqS3Jpz6YL4DA2z9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dkjwy5aWc9TIdQOmyUyl7PlCuAFQ7xm+3irQ4Lsxn4zILver/9rS05NMrvhT1RapQNu3SP44M48nBcVZFpauVXCPITg7DcoLGt9Bh6DBVAcDtTLTnlHECFIjwj38G4XWj/OYa4S6LrkRxAKZ69dPnKG/rsOTqVUQWIe5wukFdR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=RjQHIjXy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixr31u1L; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="RjQHIjXy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixr31u1L"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id A2C1413804D7;
	Mon,  9 Jun 2025 12:00:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 09 Jun 2025 12:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1749484806; x=1749571206; bh=PVgmAVFdlNQKHcWRmL1wV
	gRsAJxlk5n+PQTztRB+Fnk=; b=RjQHIjXyjV0AcCGrV6KIXWc1HrjRk+ozOajJj
	Ci2dfz+I2j+2gc2vUCKmATZHU7l9ARksiNUjwuCbswjmMkam7yq22dzYG77isk9v
	yN5KI/b2xYQfYpUXpy67fsIW6BIvVGkqZGBb9DlWyOs+8N9jII6bdA16d7puQE5Y
	dps9+WWiajDh4+N9UBxgNXc6kfzGSsG1q25euUmOf5Td5yK/bFtm2uVAsbTHm5ST
	TCbTar6QPyYSD/zvCiaGWcaFp3hc2onNMM7ZZS9HqcfBuNMOdBNNLw+m4Fw3lK0G
	Z3Tz0Xqhmfw2wjFpzZcTAJ8hOLD8F2g18ealTIN7edPrJEBvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749484806; x=1749571206; bh=PVgmAVFdlNQKHcWRmL1wVgRsAJxlk5n+PQT
	ztRB+Fnk=; b=ixr31u1LKhdnQLqgY92AYwSFUxIbI/2rRRKpU6NPHwtQgNvw/xi
	xC7hToNcyeu6Y6LPq+gdfHOZmsQ+QnDTzNwWt4CWby0Bq647uxDmwHDSOkASwO9T
	K+869mcnMdcD4BDqoCjtSMoEmSj7G2wV0WLxF0dQwcTCEFyBEaGNApSR+oylFEAC
	tibjnp65JGRNHhKnG/c7HgpmJbUzefh3+cXmIgd5XYuEpp/RIt5TvOz2VCCCSDqS
	VlNOOUU00va+lU4pEsssHF/DQVzT+UAZomDtfbF4ov/ejvlBWa/qWKMZUtM72qXJ
	FOccKc/LMzvXlEc4WGibAE7h4DBTmfN2G/w==
X-ME-Sender: <xms:BgVHaIFnzMolpY3k2jNZyD72c61SeN1cKTRaDOzLYFctHFJ3Dfhkx-k>
    <xme:BgVHaBUU6I6oCHF_IENRaomtWF4Lu826RC5mQJTpJHVfo-5ud0dFo0RCiPnLQQTej
    JYKtto9FYVoikq0bQ>
X-ME-Received: <xmr:BgVHaCLDlwuJ24RkntFAu6LRwR0AR80ztPvDf7DY1oo8-08SWxGnmKHzFgWy0unqL-RGD1zEn5V4E-OIK-Sfj4TG1bkjQRKF8_mMW_tuZmtPZiX-svkCle04og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfh
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmnecuggftrfgrthhtvghrnhepvdehledvjeehjeejheevtedtjeekhffhffevtedtfffg
    keduvddvteefjefhuddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhl
    rdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehk
    hhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BgVHaKENKu0rbZyuM0o1Vf-cx-dse17mRXHK8GFzXPS7iurMQQR3tA>
    <xmx:BgVHaOU31i1nR4Bs_90poRKA4Zynix6kpHObFW7s4nf6585RPMVB9w>
    <xmx:BgVHaNMmcJhqjQZnH9ce9uShS7pDJuH6Ded-EJvp766XzQ6SluMD3w>
    <xmx:BgVHaF2rw-EobxkHjfHw2dxwjz2IiIkOSnBCecDGazy6zghYiNRznw>
    <xmx:BgVHaI2yuVI2QJhZmJstAMtMn1X0CAY4RO5TvfBKC7hbaOwoeYPrUA7E>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Jun 2025 12:00:04 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] doc: maintenance: fix linkgit syntax
Date: Mon,  9 Jun 2025 17:59:42 +0200
Message-ID: <567195e5577c6c32b46f784a797fbf366873a0f3.1749484736.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.rc1.593.g32ee0d3380b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    I get no more hits with this search
    
        cd Documentation
        git grep --no-index ':git-.*[123456789]' -- '*.html'

 Documentation/git-maintenance.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-maintenance.adoc b/Documentation/git-maintenance.adoc
index 931f3e02e85..540b5cf68b0 100644
--- a/Documentation/git-maintenance.adoc
+++ b/Documentation/git-maintenance.adoc
@@ -172,7 +172,7 @@ rerere-gc::
 
 worktree-prune::
 	The `worktree-prune` task deletes stale or broken worktrees. See
-	linkit:git-worktree[1] for more information.
+	linkgit:git-worktree[1] for more information.
 
 OPTIONS
 -------

base-commit: 8db3019401f8093fb895f581be641fe7e05aa755
-- 
2.50.0.rc1.593.g32ee0d3380b

