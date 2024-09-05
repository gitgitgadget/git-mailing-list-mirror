Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86829199E9C
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530987; cv=none; b=AkC65rLQ8iHE2tq8HF5k0H1kLFYnUTO+bahZbrP39oe+BhWI6akL22W7tjO8rWCHJccZGJA4qi62h+sniuTnXinVmyV6+Du/4QT094kFTotFMcMVWN2/xHPxYItVpw+OewvFbKKLQ6S0N4AR5mwDwiW2QdJGn4SaXT8nvjfL7kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530987; c=relaxed/simple;
	bh=w8nRoE2GNGJ7UiiPKRXUYY4+URjWQKB134uaMe+/hl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nm0HG9g7AGf8n6KM746S1C4RobVgmoD5dfwctScWkhlFdHKyszuWu2Q2XV12Hocdblxbu44ZtxBKERkPnNe3Cgz9Ao2twbZ4/ZiZGEQNZ/VAIBr0pzQ+3uE924lE9ds4xv8TniE0Z6bOomz2XMYe8yVRnXxpIAO3nqHB280HBH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ud0JBrvU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQHf/bZj; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ud0JBrvU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQHf/bZj"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D384E1380359;
	Thu,  5 Sep 2024 06:09:44 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530984; x=1725617384; bh=8NClZX3ow5
	IHFqE4ul4j7SyAUEmLpaEshm/2VgeY2B0=; b=Ud0JBrvU9odqlIB9DnTUGLaKNq
	qTRWqisKYcJHpDYcX5CjW3S+nrgeWc59J8PvpJa3vejzN7cWeJG4iXq5XKZQduzW
	M/Dp/dinK3Sb1370arJtYn6PBYGWM0lduyDznifVmqKcGfRcbTEdyEBhW1yDwOZS
	Ze/2nBnGHTUpWvOsb6q13RuNOzGDQcLe9LMnzxxdzGtkdCFnc5XFUGjQ8iRCVoyy
	Fp9xNKcibgxkJbwUOdjeMFClbZ8O+sFE/oFEvxZSKZdUWftcbrOHDLbr5Iav74qz
	2TqNDrHxDVWQsTbhrzGEpfzjwdCqgp57czUnDFYJtpMIcyl4S/7p8aUcDLVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530984; x=1725617384; bh=8NClZX3ow5IHFqE4ul4j7SyAUEmL
	paEshm/2VgeY2B0=; b=qQHf/bZjGj9PaKDvtWTNa7QBm+LMzrxEDyrZNF6dvMWv
	THo3Z3Xlv0+KGA2epJaQdObDF8csbVZJ44STJwLE9yJTtAoP2iHKCiCkl5pq6U3I
	3qDJbaUL2sL75HtXKFlU3HF9SIeTz1kJZm5uhPP6osC/UtP5D+ftifa88NdMg+Ln
	WUyRQXHPqTeShyz1MFxlzgqx+GgT8lbYK0IdmJ7WXFN+wsyY2ZATnrKxsY5BWa+z
	234cqMYYIKCvJG6JiAKJidP1tNPpOJ79XJCaO9D66lcZjALsWYG1nzT3xX9H7x+z
	I57X+O9rqk1QBc0mcFL0H9xaipD0l05/C0OWcdydfg==
X-ME-Sender: <xms:aIPZZgk9jvUcglBkp4sqERwPK4VIoC-5-BPLDt1PC0qaZVLD6UidyQ>
    <xme:aIPZZv0uqLLXqbSaa1uHXPOzPtcR1rh6NA1g_J6Q-_GBVapbHA6gOpC1G6synvDPQ
    ku5IOTi7VFtLsISAw>
X-ME-Received: <xmr:aIPZZuqnb9r19vcmuRsQKSwha4BJvuRzAMMiUoBkKOPVOw-3LFX4fro2XTHpW7sIw_rfGdJZ7gSQ0IwpyJc1QCRjQisJz0Pbw6P9W1mWtazZkbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepthho
    ohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:aIPZZskmAk_wvEIPmx6HNl4yyRbwg8bg4F0X9WZPp94Zlx47mxHgGg>
    <xmx:aIPZZu3dUt68Gtw7hUtaaaSpgbz4GQaWay3Eu6pPUzYpAoGhQM4Jfw>
    <xmx:aIPZZjsIDrqDZiLKO78_CN5vhHVoV17mcnvMeJVrUnYHw4LrY-YEOQ>
    <xmx:aIPZZqUUYAb8rTqtd8X4PJqwtYHE_W9WidX9xEnWia52QSd3m0yowA>
    <xmx:aIPZZor2GCmzH0d1K3yrwSgYgmxHxkLFtBj1LGO3WHfYtubnpdBK55s9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:09:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 270e0db7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:09:32 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:09:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 22/22] builtin/repack: fix leaking keep-pack list
Message-ID: <2368924995ff5cbb6b95dcbaa46a7ee18cd52d03.1725530720.git.ps@pks.im>
References: <cover.1724656120.git.ps@pks.im>
 <cover.1725530720.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725530720.git.ps@pks.im>

The list of packs to keep is populated via a command line option but
never free'd. Plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 1 +
 t/t6500-gc.sh               | 1 +
 t/t7703-repack-geometric.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index a382754feee..3ee8cfa732f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1543,6 +1543,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 cleanup:
+	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
 	existing_packs_release(&existing);
 	free_pack_geometry(&geometry);
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 1b5909d1b70..58654b3437e 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -3,6 +3,7 @@
 test_description='basic git gc tests
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 9fc1626fbfd..8877aea98ba 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -2,6 +2,7 @@
 
 test_description='git repack --geometric works correctly'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_MULTI_PACK_INDEX=0
-- 
2.46.0.519.g2e7b89e038.dirty

