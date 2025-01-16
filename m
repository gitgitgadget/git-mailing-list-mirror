Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE011DDA20
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019054; cv=none; b=cd76Bh/DOOIP+2CBkoaRkqz2joUgyl3Rl4W7JXHM9tnZAqPXUBZeRHkePr5uvBijft08v4KwkQSGS1k5kY8ZOYaTIchIilqyysfXTx9GGK/a63fQF1ZyACfB5eIFxP858oMfA99paf+R9mXY2x7nCwJNEq/ysEYNnNsGKwQ9ypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019054; c=relaxed/simple;
	bh=kuwOEBHAu5oIijm2zXaGkHG40Gytyox0w5FbxN1zcDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAmR44pgb6ZoDjAE5CZlzcBwyeeN8Ci3m/XIVJ2yWZ4C6BCvTKS+26wnvL+S55stEz6TQb1o5ID9Vi6J2z5WfNA+dHbfKqfqlVmC61n8AQDs3cVqAGK9NYMBcq1wyBzUnkSkuibs+LURPL8fcXdT/SVB8qb02mqUq/lKFuNxjgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jKIjDhvT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tMFrHR4V; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jKIjDhvT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tMFrHR4V"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id D768A1140113;
	Thu, 16 Jan 2025 04:17:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 16 Jan 2025 04:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019051;
	 x=1737105451; bh=5OOx+LgiZX3sg/PMtTijS0s2Wx8x92Z73aPPRqot1/4=; b=
	jKIjDhvTRhI/Kt6eorIBj8/kIAfG4l1Ms1p7LGH7HHTyz1s6aUEncJzzg5OXqppL
	4jhvCzWi+DEJ14srOlb/HjodVEaLzJ09ZWISQVVg12F+LiwBcvZODoto3QebTgeK
	uJhNecbISkgGVORCdohxTGVczbZv1TcvJSpcrmzB+dD+TTo+5gJlRAOz3Ptn70GK
	RtoWwfrLaWN/8MKO8YE5SptCkGp17Tb9IJ/8YUV2EV8Tu+0d74IJ+VUtYxRpgrqK
	rm0u6j+dDMwUQbxCi+GR1YeUOeS71t1H69VFH3ZSWPPYlfXvRgSKsmVbv1oyaqvA
	hsAKqGHoTt8mF7QVNaBtnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019051; x=
	1737105451; bh=5OOx+LgiZX3sg/PMtTijS0s2Wx8x92Z73aPPRqot1/4=; b=t
	MFrHR4V9NqjZceejp3ZVI2M9YzJpLlBSYa74IlEZOqrYJ4XygSN0PQRFiSqmeOgI
	jshSemCgwcLBkM3GxjgTTxmZFDIm5TaxZqKvGlYFCOZpvxXblfLfHXa4vmwH4JtO
	A1WXKyj8GAm912CKHlFn8TnuBS4AXVcc9p7K3hTE2lWIlFR+nMWhBSIrGz44yckK
	Pn1PeTpyfEbqVWeoy6cQg6ZMqXVPYwzUYJX8B1YKlKQgYdpswr1bvosNGKGPuBVm
	Hob0+1/AqQ5Mdyr7I4uD+hMRuVMqqXf91qwwOOSLX2PGuQdI8+ZJXyj280ihTR9Z
	zSAyoq08veBLUkDujYO1w==
X-ME-Sender: <xms:q86IZ49htIChGnwig3M-fj6Zo2WEQaR5YMxW7qnaW3VLU8DIVgLODQ>
    <xme:q86IZwsgPhZMXqRzi0b-BhqB_x7b-SLxKofy9nwU1g3qAYjnL-y_xoRI6sLhgdjFV
    ukp2tO0HmDoMTYJZQ>
X-ME-Received: <xmr:q86IZ-DewVQxT53ZWJArzWWFI_WQwqEc7lcxsX_prYRqtugc0_zMHkO41_ypa9gNpM6IaCeHdoerblz2UCsY3uhQxCk6lGmhri763e0h4zSwPf6t-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehkrghrthhh
    ihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:q86IZ4eRLEB7MSrtJozmZqNRiKeU7LMkpbXuR6HkkmlN5gYc5MMDYQ>
    <xmx:q86IZ9MEcdT8r1cD8pBJbvXwdUmkQsRE5ySgMGgpWK2xgyzfb2iZFw>
    <xmx:q86IZyk83-uMrpOH3Zew7mcnmZS2r9eEkpbckx3cuHmuwpemcOMWzw>
    <xmx:q86IZ_sEg3TfPrJSEk6iH9Vk42qCBKx4v1RBt9cJ9cTsWtZkFWP_NA>
    <xmx:q86IZ-qduRzjhiQf_9e1o-wP8aU3USeGgJ5dx2cyAOtGDzo8puHoRyUb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de8aa1ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:23 +0100
Subject: [PATCH v3 10/10] ci: make "linux-musl" job use zlib-ng
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-10-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We don't yet have any test coverage for the new zlib-ng backend as part
of our CI. Add it by installing zlib-ng in Alpine Linux, which causes
Meson to pick it up automatically.

Note that we are somewhat limited with regards to where we run that job:
Debian-based distributions don't have zlib-ng in their repositories,
Fedora has it but doesn't run tests, and Alma Linux doesn't have the
package either. Alpine Linux does have it available and is running our
test suite, which is why it was picked.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 5ae80b0486..be7ab4b1bf 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -25,7 +25,7 @@ fi
 case "$distro" in
 alpine-*)
 	apk add --update shadow sudo meson ninja-build gcc libc-dev curl-dev openssl-dev expat-dev gettext \
-		pcre2-dev python3 musl-libintl perl-utils ncurses \
+		zlib-ng-dev pcre2-dev python3 musl-libintl perl-utils ncurses \
 		apache2 apache2-http2 apache2-proxy apache2-ssl apache2-webdav apr-util-dbd_sqlite3 \
 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
 	;;

-- 
2.48.0.257.gd3603152ad.dirty

