Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4662368267
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922769; cv=none; b=mH4DkETEu0k7FiebFzkvv/VXfLelj0qA2NsOctRQ727XVgrcHkHK86jseGVSjS4+dTtmMTMdjKJhMlCf8AbP6VAa9AnyzVv7QWBopu18dgdDxZXyyjeg67ovaAJ+doux47taHcooCg5na6RkNKHu8k21ClnIE0aBpINrV6vUmuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922769; c=relaxed/simple;
	bh=IPwzR/tLcqyJX2ST9ZEhyl2zH9iWylWNkYFwcifLDeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kGRG+Z8aOyJ22BMyBw0EP+HPblwgQDJNch7RVVIi5vQryC954TtyUTCEFD1BUZ5I54d/UMmtKfcCfgl7JqJE+3muQAb8UC571+iSIhYbMcE3N24Zq7w28NPPxr0e5ar61rb6AaT1Bn20pAqeaK3aUYpU3zfmHu6vZ5OzAX2KM9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cjr+ysTn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U5Lb+wtI; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cjr+ysTn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5Lb+wtI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D4991400049;
	Tue, 24 Feb 2026 03:46:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 03:46:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922767;
	 x=1772009167; bh=uYg+3N4bJXAWuoMqRYkvHk6ID7H06J9+3V7useXoUgc=; b=
	cjr+ysTn+0SZfTxDPQHbu4Pq455BuXhOsBzzd5OroSPoz66AjaLzm3Od2MlH/TIZ
	X+bMustifpqHqn7sI2gX+g8PPc4mO8V0sSsNEw6RAGktW17+K+8qUX8QfJ44+kzn
	1L+wsik2zvuYAnmGBL93R5qvCUd/unvEeUaq4Z8ACaMn1+qDSiZ3wTx2jvUTCCL9
	wjJVOqWEoqKiAuvygLwGT/h4iQ5eYoJQHCfbHhovvdgv+eM8K1u2+rPE8uUIOFIK
	f25/VmdXGFlyKku3J0u+DsiXMHu4Lu5QaL27qG5Cn6PLHkd19kdYQ5lwk2NKTGYF
	NtOaA6hd2ByAZ3DdP61dcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922767; x=
	1772009167; bh=uYg+3N4bJXAWuoMqRYkvHk6ID7H06J9+3V7useXoUgc=; b=U
	5Lb+wtIw9OS0a+WV4fCB4N0cKm7pe4GArERFGUXYjvo2GF832It0MuSabglcbpzz
	pCZhtCdFLErvFlavKTn/ClauwaNGNfkfpv5QVzYL+nh5jtX7uX7owpuV0p7ruoQc
	oLdlxMWPBFjwdTr9x5jDbWCzWW5Tyu2NBHwIu+GgZYXnzNwc1wsny0n6hHo28JnV
	YqbMmK1mE1jn/DEs5W0NUVt1sm+CXiN/0p0yGG9Hh+yw0BOy8do+JpVN2XdnfmJM
	ha+heazSUnbipLRi9ZLSxaB/4LAm+2rUL9hS+CZ+U8RiYvhfCjYyXTPyvQFZBKrJ
	f4EvybrjzEbeEwFOTx9LQ==
X-ME-Sender: <xms:T2WdaS1D-lvdlDHuo7bE6cXn_610zyYclDKwM2EvTB1Fx6D_eAm_gQ>
    <xme:T2WdacHIk1iUDSEKHkha2nK5-YtzaIe9whh4yBgVUGH-NmEeEtIoN6JdG9Rk6E02O
    Lae1QJCbcsFEvQLYDuVcByUe6D_4SYMJuWmBTVOyqPjLkndjID9aA>
X-ME-Received: <xmr:T2Wdaf7tH1sZjh_Mm37LQ7fq50mvYIyqVNi4to-lVqfG9dQUsnnZ0aZ3ZUyEa_oAUPSBWA_LqKw5vTifUBLV2c49kDdG6oYJkGyDT9pgOQYhGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:T2WdaSuXsv_b095dG6YtMnVSZp_3RBE0AW2A5KIXtKbJxsEBYt7OSQ>
    <xmx:T2WdaQ41wKWOsIKEGBLz7qzenV-SlzNVPkcGASWmSDRvKFD8MrR62Q>
    <xmx:T2WdadV4_53K0z2DISZmDvxRGiy3cC-md3F2nQoMREApJ_afHCT0fA>
    <xmx:T2WdaS_knG7OdmZkDlZpD-AAvs4CRZw9VquvvzEtp3hHOkWTBuNEpQ>
    <xmx:T2WdaT3EjR0MJyrkwP0G56-fDCm4qG3iroX9pCUvav0ksqQ7nq0F4Eru>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:46:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a525e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:46:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:49 +0100
Subject: [PATCH v2 5/8] t5510: explicitly use "gc" strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-5-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

One of the tests in t5510 wants to verify that auto-gc does not lock up
when fetching into a repository. Adapt it to explicitly pick the "gc"
strategy for auto-maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5510-fetch.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index c69afb5a60..5dcb4b51a4 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1321,6 +1321,7 @@ test_expect_success 'fetching with auto-gc does not lock up' '
 		git config fetch.unpackLimit 1 &&
 		git config gc.autoPackLimit 1 &&
 		git config gc.autoDetach false &&
+		git config maintenance.strategy gc &&
 		GIT_ASK_YESNO="$TRASH_DIRECTORY/askyesno" git fetch --verbose >fetch.out 2>&1 &&
 		test_grep "Auto packing the repository" fetch.out &&
 		! grep "Should I try again" fetch.out

-- 
2.53.0.536.g309c995771.dirty

