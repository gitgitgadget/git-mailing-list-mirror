Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EB1F151C
	for <git@vger.kernel.org>; Thu,  1 May 2025 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746135261; cv=none; b=tEret1RRgVsXckVCGyiTg0hS/ahGbvp7OzpDcyykY9y/73v5dm/V9aLn2nn9qzGNlNnSPJ2wMoPRlgdt1DREnfxQbiP/ygX78IA51yBhPfiQbnYo1p8cCOo3vHgKlAbiqyy10DyWqsWPdgoILh712DCpDfdAZ/3Z+52B/8J3N34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746135261; c=relaxed/simple;
	bh=A60f/tAWajMam+Yx0y1xlw+UMacTKkzOMABke8slYew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n9liL73jTaHJF1+Vcwz5Qc/C8T34Ih1DxW7EWVNGavkfKOobq/rHJgOCBB73vTrHFXze7RnAFaXDg3wIGCruhWNYKQAjSlmWJhw8pHjOeHkjld5CW/w57d2FZ8f/Q8+/8E4XNbrNVz+gxGNbpqh0twuhiWlnzr1L3U6UtwYQA3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H5vw6Qdn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoeDZADx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H5vw6Qdn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoeDZADx"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 62AA1114027F;
	Thu,  1 May 2025 17:34:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 01 May 2025 17:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1746135256; x=1746221656; bh=fj5VPtLUJ1
	eArIjNGVIU0XLjeG9lRSyaJvPglYOwqTI=; b=H5vw6QdnE/9bHr97o4iutJuqiM
	Bq6ggfWTWrGbe3/AWRJeoKEatuMipeGNSQ9fO9i/NTjHeUiIWt3aBF1W+zw44Qre
	LIczdjOO8UaeN9l8n/Tfhcjtlq6YLeJt5nKB52+WS/xIhOUTAn4l17q8Nr7vC4bu
	FJF5Qa4V/GvGf7ABsindGjjatqW3yn/a/oFJLZO6XM8qUzuaP3QNfBLFzWQO2BsF
	K/L3U/i9TtBJsifnhgER2GPHDXWJA93H7Q0X28d22vPMCpj8BD2hzsEY7DSOKMfv
	4FSLj2RkRTWoDNRRMYlHVajMe1rMRDQThg+48ntuHxAfNRpyi2dAZbZKmrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746135256; x=1746221656; bh=fj5VPtLUJ1eArIjNGVIU0XLjeG9lRSyaJvP
	glYOwqTI=; b=YoeDZADxWrKKYTMneuRrhJsEecVuDczlmTJ1hHMVlt0ZEdK+38w
	s9v2fo6AyjTi4lO9efCJrPXRrdzIq6xiQT6YRNEVYguvEXFvTOVL45ChA98+jm4Q
	/D7hOaNgKSgsqDmvoKfeTkvmRXPkOUmeqV7Dqh14ozQ60JdZPpe8i5v+TAz7T+fK
	2b8CVhI3GKXErN7mFpKWxYX89nuOq+sld07Wr1ITzrRTdZyI9uEKssvGuptUMv6/
	/5ndGyf3O0TsluJnk/eS+g3d4CaYu/56BGwQITUBTAfGy/5ug+1nhi/sHjYjogpj
	OzOlXqirgtXPR77pnyj4bvoUcMuw4RxWMNA==
X-ME-Sender: <xms:2OgTaMcxfUJD53Aa6bt-51mCvpA1K6wzVt4A2fGVNjffZ_2k4Pj8Tg>
    <xme:2OgTaOMXcYe_27amREUaI9kCTzsvqmdqiL6b_K9oUmkeltb_9hMjBh5nG5_2knEyd
    L3CsVbSgCiGRrisng>
X-ME-Received: <xmr:2OgTaNh1QR25yaiyeYCKNdeaWCH29kV1BjjTs45OqbGMsLAxB01M3k_hPVYKR8do3lV9uOSXwVZMYQmn4gJGXrhR93JXxbGH2KRe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedtieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtvd
    efleeikeefudeijefgvdefudetgffhtddufeeufeelieeghefgueejudfhffenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2OgTaB-pwnyfGut54zmrFKv7wOnvgdbVd-6Kd9YMm1ElhGEL-AriiQ>
    <xmx:2OgTaIugqwnvd2PXS9jRRY3KDK7ubyZQ5srqcaufdfR6Egjy6mkxyg>
    <xmx:2OgTaIHZWlsw25P3uzsfB9PXH1atfMl0NagZu5TQMBadmYzzQGc2LQ>
    <xmx:2OgTaHMTolgWMyNV2736IHILP5iaGNKcSqlzBl_yc6kMFY5X61NOwA>
    <xmx:2OgTaIe7KfAhWI52pu-7QZEndx3so7USLEhdS4MBB2XqSP42O0GTMxFK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 17:34:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] A handful of doc synopsis/options update
Date: Thu,  1 May 2025 14:34:10 -0700
Message-ID: <20250501213414.370514-1-gitster@pobox.com>
X-Mailer: git-send-email 2.49.0-599-gc9a5c860a0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Continuing what Jean-Noël started with 22293895 (doc: apply synopsis
simplification on git-clone and git-init, 2024-09-24), use more
[synopsis] (rather than [verse]) mark-up and also make sure

 - dashed options in the text, including the heading for enumerated
   dashed options in the OPTIONS section, are `backquoted` to be
   typeset verbatim.

 - both positive and negative variants are spelled out when the
   option is negatable, i.e. a heading "--[no-]opt::" is separated
   into "--opt::" and "--no-opt::", to help grep hit with simpler
   patterns.

 - non-options are not described in the OPTIONS section.

The "git worktree" one is a bit unsatisfactory and should be
considered WIP.

Junio C Hamano (4):
  git-verify-* doc: update mark-up of synopsis option descriptions
  git-{var,write-tree} docs: update mark-up of synopsis option
    descriptions
  git-daemon doc: update mark-up of synopsis option descriptions
  git-worktree doc: update mark-up of synopsis option descriptions

 Documentation/git-daemon.adoc        | 107 ++++++++++++++-------------
 Documentation/git-var.adoc           |   6 +-
 Documentation/git-verify-commit.adoc |  16 ++--
 Documentation/git-verify-pack.adoc   |  28 +++----
 Documentation/git-verify-tag.adoc    |  16 ++--
 Documentation/git-worktree.adoc      |  71 +++++++++---------
 Documentation/git-write-tree.adoc    |  16 ++--
 7 files changed, 129 insertions(+), 131 deletions(-)

-- 
2.49.0-599-g90c2cffacf
