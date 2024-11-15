Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71018C322
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655306; cv=none; b=CpSC1uxaILax0yPfdFJ+FUh8J8mMRrUzsm/vxTkbqo1FofQv7huQqT4FQkgM96foFbEz/lcF+hqeJRSAi7A3g2h+QQUzA0GDTCzLQdld7zSb3qAlDjkkwa+1IW/WejMMWvbD2Trg/d6zturxQsE1hoEZeo3V340E+ST9PKhE3rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655306; c=relaxed/simple;
	bh=iMY/ElxkLQvIiB00R3ZslYgcjno6pOXE+TYrNF85hno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OvuLAjQsR59YI8vcAd8cE37yv9uAr7Mq7z1Tzrcr7Dc8J42lFQ7ej6Cm2/3LogU9i44f4zwpjgZ3jfUxlDLx6gUWl0qBLUdwvOxsrO50zjSqeTc1pRUyxmD8e1HqUqlXwS/fE2oRn9j/9er+GCB1bNPjUAPUFuG+flFDG7BoTWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e3fARYXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNNS99Yx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e3fARYXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNNS99Yx"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 99088114018F;
	Fri, 15 Nov 2024 02:21:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 15 Nov 2024 02:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655303;
	 x=1731741703; bh=+8zMtXcsn+24UQTurROtDWJOz82/V2ux7zxh00p7kag=; b=
	e3fARYXsbw/pflis0Zh07ru6+EyAePFrpCitW3oyfxYCTHMRnZPzjkrZiFf9pwIi
	xqYQPMlsh2wuJ6jWb5AwtODJB/DgRIqK0a2VvLNJlVUeYo52GbmUU5Y9K7YAgmbG
	PdzBxTr+WQD0swrOXMFWfUOZLjTd2B4VGt3UI86aPF/J1HygHELoEHnwSvHF+k06
	i9K+PDAsh6uDqFoZdDQanfzO7bWKnt0zUNR53+cxCfxgGLFpQk+GBlrNP9gIANle
	3QONywjBP0WsHSsU2efnQq3mW2irkeGFmL5sSN3kmXGH5IApHDUuoHS3CPxdt8Rk
	RLYYJ5tKKCc0LKUH10/EGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655303; x=
	1731741703; bh=+8zMtXcsn+24UQTurROtDWJOz82/V2ux7zxh00p7kag=; b=D
	NNS99YxGBA1kTp/WBdT8Z03ZcyR40D+JcNz93nuH8qxcgskaEbcRuhLYQJm77AnZ
	P1zXuR7TZOsUOGD/Dv5JHAgzdgeRISwu2cURdNA/bYEETrdRkAMNQcQ8hOJoPgNL
	JHuK8/TFLc659Ous6Aqklf5dnVL0e/ET68IQytiJTdK0xFbEA2p+He7pGCwA4A+s
	jBTZkBUK5HwxeCSkug/syMZekwt9o1+9xoE3ZH7VqAiKN9jjI4mtgl/uQFiQtAQB
	aOXazeE5gp042aiFKdGEjFr8e1f/KB0LJSCiI/HOkAnPcK2sopdx/KjW9I8GX9Mq
	b8YMLiZNOOiXPIJ7yKTDg==
X-ME-Sender: <xms:h_Y2Z4dAENavEioC8Kn4IBfGz7CQNxHG5twYBsAJre6e6ZHQjYxl1w>
    <xme:h_Y2Z6PfTpV0jea632SB-yjcyD4mKTE-mgaKg655cx3pQlLOKksPXEAPuCAXp7TxS
    TcTvXw360Ol_ezcDw>
X-ME-Received: <xmr:h_Y2Z5gCJuu3FbZNUANxNVFhFE7ofb7mNbmqLQZBFuG4LCX2kn90sFdK_dJINz5EAf5_UDQ3Bfd9oZUlKqiPJrDLjQyws0KgXSZ66bCbtuU4DrZCyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtph
    htthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepuggrvhhvihgusehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdho
    rhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:h_Y2Z98Wh74LozNtwMwiVpAMSTZvRRyJ_16a9xpvhLIlb11sZrAvjQ>
    <xmx:h_Y2Z0vb6DGyehPG30e0Q6WtJzCSKbRAI_9Yej8VPpFbJ7GlDdET9g>
    <xmx:h_Y2Z0FdNSkT6lc70ByiendnEyZObRJYGKkHZsX4Tf2b-0Wm1Ui5TA>
    <xmx:h_Y2ZzOsCkYi5NQi7Ge79Td8ZyeL2o8oz-UOABbZLn0uOP8kBmoczA>
    <xmx:h_Y2Z1nWOIxK6tOeEpAGkPKrwi4gHV_oBiMP98DZgoGqYNmZfbr0Rg0S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fad68324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 15 Nov 2024 08:21:23 +0100
Subject: [PATCH RFC v7 11/22] Makefile: extract script to generate
 gitweb.js
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-pks-meson-v7-11-47ec19b780b2@pks.im>
References: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
In-Reply-To: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
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
index 0000000000000000000000000000000000000000..bb81220da393ebecae28b675c299b626f0e698fb
--- /dev/null
+++ b/gitweb/generate-gitweb-js.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+if test "$#" -lt 2
+then
+	echo "USAGE: $0 <OUTPUT> <INPUT>..." >&2
+	exit 1
+fi
+
+OUTPUT="$1"
+shift
+
+cat "$@" >"$OUTPUT"

-- 
2.47.0.251.gb31fb630c0.dirty

