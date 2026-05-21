Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5DF27144B
	for <git@vger.kernel.org>; Thu, 21 May 2026 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380858; cv=none; b=qRbZBJc/b5pbm5PccwGuONg/zMZX4TL0tokBkP56Il1bVJa9ObZYQ1k28sYXdiH2zPH8Q7lXInEY2l3NpikNlfkacFzaM5wy8bwS+oFbIAYwyY7I1PmvrbpC77cAcdDRVxG6h9z0DabghZIaYQN9nE3k0YtpDuucFXrrGFYAkdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380858; c=relaxed/simple;
	bh=TrCapJUb7ndF98ilqOEJvj0oyhXHbs8hNnUNRAEqQUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FF8uNPWhuWDU4DELMmSTvOeLR/l+FLbqIjF5TLBiBrYoU7mPdxhLMD+TMrObNVE6u+pB6AFA3vrCw4kGm9d6k/op9qNAmzXVLkZvlS+0EbQnwC/o+aLM8yGTjiadyUtxFMNk5bqsyFtjmBoMIZy0Uni6ZXdoaJ/p3eupDSdo/qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jyk6dSeE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M2DHgVy0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jyk6dSeE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2DHgVy0"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CE0C87A00E8;
	Thu, 21 May 2026 12:27:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 21 May 2026 12:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1779380855; x=
	1779467255; bh=lEul3sl8YCUIypxsy2niyilbMtlkrcnFyqJOKOOsl1k=; b=j
	yk6dSeE5uremTF33nT6C7DAaMn85wr2q8wH3I+odHiYfg1RyxyH+PEaZVtFs9FAB
	EZytr8z3ZLIkw9hyeyvM1/Kx8Af4k/tLuNNDygL6yxi4/Uxwf1WAQnYuuElKnL33
	pGfZddrBvu8yuEqMTGt6yM4WeMDUrqssdRzwQT9x/wSOQ7uLERRodhiAWZShCsAB
	UFdR2Ie9aKiF/F6vrU4xoyPIi0UNsr0653wTDizb7Z39yGYORqj1uJrWGtjtu0ka
	uJ4iEs2yiKlcSoE9ERMMk+HZovOKzJiORsfWDFPskahHuBNjB5i9K2X1HTJ5ye2g
	O25hJCUSwcP/P8XGp12Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779380855; x=1779467255; bh=l
	Eul3sl8YCUIypxsy2niyilbMtlkrcnFyqJOKOOsl1k=; b=M2DHgVy0p6moz0WRS
	+W34Oiskehj9lJCVO7MnPT5Dvzltlh9V24nbbHQkpc6SAy99g458Kvp6g54asSEZ
	FvGGjW7l3rPIoIwwnRiite6f5jofAA9nNrApbVqTMALy7ymPzO5EH73krUSDP7+F
	HCkQJpr8j1m83RZu2dtpW/k0MqelgrRgmD+JIfjOaSaEZCzeh/O2XrC46orxYv0z
	DfetVumQznmJUOVPkpDqvhCwz5UczvlBJd+bq4Gz8zr/fZpmMAYw1RU6nErVofhU
	zedG/UKQUs0THlmxbd+OuETd/sdswndAaRgtxSCJ9WX33wGP+FH8v/o3Y3oET9dq
	Le06w==
X-ME-Sender: <xms:dzIPairfTzh_eRlXOtCMup2eKBb1lGMbZIzymX_pwneGn4f0EQDCxII>
    <xme:dzIPanqBaEb33UaVntQsWI4LlmGAGUjXHnF44YN2vu9afZACBStMcIbc58s1QPoWC
    BGzvvVddfxkB16Emc0P7W0fi9UCtU4C9WAIS6Ou8D-TkrL0NjsYmTY>
X-ME-Received: <xmr:dzIPasPKNHUVS0BDxIAd3Nt5k6F4WEohaFPIJrwQX9C4iqTRyWphoMgiNT9BI5qbkupHB5pY4pmg7H3vYblxdyBKH_a6i-O6n1BeLBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeefheetke
    eftdeiffdvjeetueethfeugfetgfdtveehhfevffeuffdtheeitdefudenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgt
    phhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopegrughrihgrnh
    drrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
X-ME-Proxy: <xmx:dzIPagyViTRAW-Xxoy3bqgF4q-7OtJ7EyipPYRTH1ughaiswEY1S_A>
    <xmx:dzIPattzznY6h19cQ6U42Kw-tEh2H9gmCX5VmLL8LDvFrDTef1Dmbw>
    <xmx:dzIPah5keBjBWM1A9Umr2lIz27Kzm3fX_G6Prx-1MC-N7vmboL208A>
    <xmx:dzIPakSoyGyMXda5lIEWKhSniOJBfBeRQbEqBESmD6Wx9l9_kccqGw>
    <xmx:dzIParxyuPqbWZcFbHwzaweifXh8PsvDbvdXGIGynqPcOgEUtrgudXrp>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 12:27:34 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	jn.avila@free.fr,
	adrian.ratiu@collabora.com
Subject: [PATCH 2/4] doc: hook: consistently capitalize Git
Date: Thu, 21 May 2026 18:25:56 +0200
Message-ID: <doc_hook_capitalize_Git.6f2@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <CV_doc_hook.6f0@msgid.xyz>
References: <CV_doc_hook.6f0@msgid.xyz>
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
 Documentation/git-hook.adoc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 96c5c9c3c23..750df58e58e 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -3,7 +3,7 @@ git-hook(1)
 
 NAME
 ----
-git-hook - Run git hooks
+git-hook - Run Git hooks
 
 SYNOPSIS
 --------
@@ -15,8 +15,8 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-A command interface for running git hooks (see linkgit:githooks[5]),
-for use by other scripted git commands.
+A command interface for running Git hooks (see linkgit:githooks[5]),
+for use by other scripted Git commands.
 
 This command parses the default configuration files for sets of configs like
 so:
@@ -161,7 +161,7 @@ setting, allowing all hooks for the event to run concurrently, even if they
 are not individually marked as parallel.
 +
 Some hooks always run sequentially regardless of this flag or the
-`hook.jobs` config, because git knows they cannot safely run in parallel:
+`hook.jobs` config, because Git knows they cannot safely run in parallel:
 `applypatch-msg`, `pre-commit`, `prepare-commit-msg`, `commit-msg`,
 `post-commit`, `post-checkout`, and `push-to-checkout`.
 
-- 
2.54.0.13.g9c7419e39f8

