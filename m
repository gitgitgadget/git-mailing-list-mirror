Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C62F1C1AC7
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810360; cv=none; b=nKKvEiVUm8HHAVejXXbQoHlp9rjZ9Y0DbtqlPM2XnwLiN6nRYBQy7LwJAXpuWKaDKRjjHXWnhiEQx8ZRitaGzG1FslOA5S3zlPwPProeXnkHQ4hxh3YeRLQ/IF8OiNVc9W8nQzzSeWwusN8Y3Qi1XwLOXhutP7h0c/Gpe6ew0wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810360; c=relaxed/simple;
	bh=7megYNrvtibGMqI8Zc4a2bPZHtWVmDTH9qhSCB75xKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KlY/o3ekUgwZwcmwufgOox94JssBrJ1F2J+1b5uBgnkzwHK7RijIqnerhU2d//14kvo5vhiq/4LDqZ4QwGwPwC2BwmINNSTZx6oFcI+gzpBT0HcgRqlgLeB5G2EthPk2l3087iIJ/zsf/CygbesEcRdXF/Yk0P0GHLsOlybebZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zwTLdARI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3ujxVaBl; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zwTLdARI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3ujxVaBl"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 99E901380212;
	Thu, 28 Nov 2024 11:12:37 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 28 Nov 2024 11:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810357;
	 x=1732896757; bh=eF1CM333VfcxVLOGfxg83kv72YQaCN3SHuVMGEI/Wxo=; b=
	zwTLdARIltA596xewM7WCIKCCV2NvslBMpo41tmtQeVRE11PWdhT9EQPc61r8X0f
	2pRJj4nBYLV6TMADTgScxKIuQ7Qti0vrZR4DhaNN/M/sCiT//450VzW59iwNxeR/
	JTrmHXdu08e06hrDolRvldi43dQJ2akdXACLuDPIhDc/yXqwNXiCLkPRFcaivqJH
	GKVXqgedLFeRNXVZBRIaEQTdx21gURxuCbBtwpxx9+D8t/LFwwQtqIBjBVf6weYm
	KfzvlnXHzzALodWSwde6Kwcc3+0SrJCl/236REXxWG4QXKqqBmnnZZ+5H4+N51Z4
	2FoWIQStbcs+bVp/h9L0Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810357; x=
	1732896757; bh=eF1CM333VfcxVLOGfxg83kv72YQaCN3SHuVMGEI/Wxo=; b=3
	ujxVaBlC54nSRw82B3F2Apg3p1tGl2DwCKFV89muhW6wpEVt+HP/uhXnHFfKApT6
	sV8W2ugTCzGW6xCn3JFCcIrlBgBhmMecGAnd8I11C9Lt1EtLuCu73P6ldHjlBT+k
	aFzbHCjEn2E3xOrCY/IIiiy/yRWy/TIlKXgt35MCkWaGPspOjX5fWARhja4gzfUJ
	DLqlrS+7bK0VrrQ6I2SIen9HOtwPnm0SWStDh8B/ZcUvyE+X9OHNqZX2ZRFr6rEC
	95kYXb8B7fhrOdjI26eF4O3Z2jNK54iuCe4/l/TxQObcogJ/Lb/4v+PNLHSU7yw0
	hQWSv59jevzt9ZaB1rgig==
X-ME-Sender: <xms:dZZIZ7zgsnrjM6hA7Pu9gybm61xvewSF1CyfyVlimaugmnPOU7Oycw>
    <xme:dZZIZzS0WHETznkd4svvsq4YDBpBzRUHsdoZBxqesdU6Ck7DGuaNusPV5ryBwzc_H
    hrJf93_eq3ZC7WlFQ>
X-ME-Received: <xmr:dZZIZ1XK-yOPubRKxtzegkPCJJYojAp9zg5MkVb4zGUGuG17_xziX1P_SZJiMQffRm6TrYfASxYxhrBM7DZ0gwijVIyt9yIdHsRrb4NI2WGUIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopegthhhrihhstgho
    ohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepuggrvhhvihgusehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:dZZIZ1jwPAu1fuPEARoKTsdjXTm3W7zz6KPCjdViSXIDUzSq_0sYEg>
    <xmx:dZZIZ9ApRaZtD0MwYOXt0nSUFgEZwxxP4lmTnaP67Aq5-Ai2mXm47g>
    <xmx:dZZIZ-JJqlswWdUBoRY9qGh_gGMKRJsA5etOSpSe_36EXKpUdW5cYw>
    <xmx:dZZIZ8AS2JDE8yL8n3Y1f6ePnghvEuEYjImcMMNFx2bS0yi2dYNfAQ>
    <xmx:dZZIZyKZzhMeReVdZoVHNVKCtE64B5IlN56vC6FgbnH1Y5TtZ6Ddd9Pu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c05c109 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 28 Nov 2024 17:12:13 +0100
Subject: [PATCH v10 12/23] Makefile: extract script to generate gitweb.js
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241128-pks-meson-v10-12-79a3fb0cb3a6@pks.im>
References: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
In-Reply-To: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Similar to the preceding commit, also extract the script to generate the
"gitweb.js" file. While the logic itself is trivial, it helps us avoid
duplication of logic across build systems and ensures that the build
systems will remain in sync with each other in case the logic ever needs
to change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gitweb/Makefile              |  3 ++-
 gitweb/generate-gitweb-js.sh | 12 ++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index 16a2ef2d1e5664d99f6f1d8ff4224c36769c55fb..d5748e93594eb6181269c2fe272bf7ef980cbe68 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -115,9 +115,10 @@ $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
 	$(MAK_DIR_GITWEB)generate-gitweb-cgi.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS ./GIT-VERSION-FILE $< $@+ && \
 	mv $@+ $@
 
+$(MAK_DIR_GITWEB)static/gitweb.js: $(MAK_DIR_GITWEB)generate-gitweb-js.sh
 $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
 	$(QUIET_GEN)$(RM) $@ $@+ && \
-	cat $^ >$@+ && \
+	$(MAK_DIR_GITWEB)generate-gitweb-js.sh $@+ $^ && \
 	mv $@+ $@
 
 ### Installation rules
diff --git a/gitweb/generate-gitweb-js.sh b/gitweb/generate-gitweb-js.sh
new file mode 100755
index 0000000000000000000000000000000000000000..01bb22b04b8d8910608fec6376f07d570ab02a33
--- /dev/null
+++ b/gitweb/generate-gitweb-js.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	echo >&2 "USAGE: $0 <OUTPUT> <INPUT>..."
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+cat "$@" >"$OUTPUT"

-- 
2.47.0.366.g5daf58cba8.dirty

