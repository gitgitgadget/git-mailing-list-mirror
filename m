Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C5204C0E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569845; cv=none; b=terdrAKEGTEBqVa05zV3D0613upbaxe7+BRPIGcBg4AMDFr3EYkbQSzHgSzIqtDSmLEbBXh2+wVobeyPNVgHUUbgMFw1MjGD8L5KUwQFfapLxRE/ypusYUroFE8LOF7YH7Gp0c4DfeWBYdnGufVGgiw0HinkQo51xnfBqfr6E/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569845; c=relaxed/simple;
	bh=yEngu0mFZfCrNwpH7f+Dbz6ewkQGyCXP4PTHgwsAFx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoB8NxQlkuV3/2NsVUfR37tPabHVPLsHuf6l96BXgj7CVa02977cOZ3hUDs0vAqV+ADyXqY+mK0YSqThCIQNuOLyt25Uh6ine6m3rxQBrpMkF2irsHfCZo2NQpYX4cX9sNQswIJAGOE5DUW2znY77J9yA24lU1u/JSwOqbygoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=T68RuN7J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s8MU792I; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="T68RuN7J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s8MU792I"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 094FB138084C;
	Mon,  3 Feb 2025 03:04:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 03:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569843;
	 x=1738656243; bh=UclrCH9YoHbIyjCA3LK3DqVdnF9P+oulncP1QH+8nRc=; b=
	T68RuN7Jk7x9t7152qDu5z0UH7qkYLopeswBp65i1+8qhctkh1yV9bQx8pZe+Mv6
	Nx7vjyZLLFztqzj/e7wh5vylvRrh4Ep45XLqWhTt5I7auK3dxz0ohOTOEWbWbxoX
	F1xR+zp3uHh7HKGEAXG77Oq4o7Q5/gyMgEwB3d3pTS5lDItZPu+ZRXShAWM/R6rx
	FQpNx3bfchhR7E/5zqXz01ZvbmkXATwuBa0pNyaRifSqc9Us6bfqxrDhiTIkKQ0g
	Axn2NTvOKEWa5zbW4/gLqPamTgUwmnKoKqtf38ni5uoPNuZzRu8EhRjabHM/zqpZ
	1wDAI2StBduvbE8XO0C4hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569843; x=
	1738656243; bh=UclrCH9YoHbIyjCA3LK3DqVdnF9P+oulncP1QH+8nRc=; b=s
	8MU792IW1NxoDhgi/FTiB9E64J6Wpq6934HWmd4IILIoPR23aQVCHxqyUr85Wzr6
	HRVtArgqzksQCnZvXwPlsEi9gyvfo1BFrmhlEl6bkDpUBJG38wpPl0XnpGO7+RHw
	UJmQbKHCLwWDxbJBFV5k2yhXVE7YWTDfGLiU27QwWuIPTTGsZ8t2V+JAGk5JUVgA
	4kcAQfCZo+BdgpGC7kziwh5Ps934h9JCIe5TMopd4kuymrOf/Iv5VORU3xAHmDBB
	/+KX5LRDxWVfFweMl+b4oybp83c8ysO0We0j/3Um2LrngG80OnqEgOiQFAGhfGGQ
	EcHI3LK44rXxo8S49aC0A==
X-ME-Sender: <xms:cnigZ_ZNuQyM-Oek4AZGvAmzjkh0Z8Wh0W-8cD-GGDHGtciTZ2Wf5Q>
    <xme:cnigZ-ZRr2EXrSM0DYRIhRmuYTa3z9YW0VUCX4NrZN29YcHy9yl38b1tjG5KBPPE7
    mQAQNgCDRhw0L8O5A>
X-ME-Received: <xmr:cnigZx_bogY3KO1_FAD3mBQouQ1kG3G1fbl4Sz_QuJBHhsV7bmPxL7cmf_925VvcVApNkgu57Zl9taaxsalv-mgATGre64O20Kn-d-CcU0lOdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhh
    ohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:cnigZ1qSrEsf3pIty-V7TFdgm932hmezmwZuRoxyLijeR7f0kTXdMw>
    <xmx:cnigZ6rwMndS6ZQAW7sldmyinsJ4HG82jG7poRAbHENVqymsTxzmvQ>
    <xmx:cnigZ7TQh06LBebXWnKuLvdWjYQjtTwJo7qO8U3waDDI6vtOf4hyZQ>
    <xmx:cnigZyom42Wu9GBQPZ5Lla5M8JUL_Tky4zbja5KbPt0P9pJv0ReVfg>
    <xmx:c3igZzmQ_yXAjFt7uZpxd7JiHEl8Ij-46anmkidPUdPRAvJSU9d3i7uQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:04:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6026100 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:49 +0100
Subject: [PATCH v3 18/18] Makefile: skip reftable library for Coccinelle
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-18-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The reftable library does not use any of the common helpers that the Git
project has. Consequently, most of the rules that we have in Coccinelle
do not apply to the library at all and may even generate false positives
when a pattern can be converted to use a Git helper function.

Exclude reftable library sources from being checked by Coccinelle to
avoid such false positives.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index d3011e30f7..dc2ac32e4a 100644
--- a/Makefile
+++ b/Makefile
@@ -946,7 +946,7 @@ FOUND_SOURCE_FILES := $(filter-out $(GENERATED_H),$(shell $(SOURCES_CMD)))
 FOUND_C_SOURCES = $(filter %.c,$(FOUND_SOURCE_FILES))
 FOUND_H_SOURCES = $(filter %.h,$(FOUND_SOURCE_FILES))
 
-COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
+COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES) reftable/%,$(FOUND_C_SOURCES))
 
 LIB_H = $(FOUND_H_SOURCES)
 

-- 
2.48.1.502.g6dc24dfdaf.dirty

