Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814C1990A2
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 10:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530931; cv=none; b=pq1+kIahg4lPTa7K7eXAsPBGghYk+PBtI53P7xsEDboaMt8NNIW09GYtoqovjVs5eZCKG4r+wUgI3DjfIKPa8SmW+kLNygzdRt1pSJAdcdWUWedJ62WJwopDtEhcOVFqYa05Ss2pczPZv4OwCAoZIOq3lJbBBnwSk5uoCk4BLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530931; c=relaxed/simple;
	bh=6WIz0KxmsEq4YqZdDv8BZapbfCTO97/jvUfFYWkYrbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESa3jxKoq7qgEt63rTd/XbizC2TeII7ZdM83iAP66gb2cr1HQ/oIlyVtVAuBIoY6dRyUhU9hu1UaHp0SWTI2VwGEVrnMXh/JmL5/V8jxNVcV1XL0zJzgYmcxORj7w99e4t3wb0zrksJdxGCna+CF5MdfQk7xog7O6cyKl1jv0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R1Jhb89s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRQulyQ7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R1Jhb89s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRQulyQ7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D3881380359;
	Thu,  5 Sep 2024 06:08:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 05 Sep 2024 06:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725530929; x=1725617329; bh=N8sIT0MLok
	6ky59KH/TRK5QPJZFFmw5Hj88jdbLgu98=; b=R1Jhb89sTSPCrfI8P9Ylb4iCFm
	dl6uZpAx0cB8GYJQP1PlDwSoW99T0JcoZ1tPpuUze2PcMa0RSl/PwvYz86RCUZn8
	tVkBPMQU8TD/BGGVxkujbJeY361khUsqKBGuM+UQ1yywmOlCfmLwda5prOdWMlby
	uiCd+bSJWLe/kGFx74vVqTj26CzpqIdeOcZvSwa1z8JYNbIyTeNv6yBARsK2Wdjc
	cmq5D8xvsjTtOMSpROfcLfCuMuB4E5OyPPN2QT2NRpHNtOEAe7M72SVC0v1H0wTw
	UxN4+66M2/EYz1inkWfM6vZdNqeg1Ijp8nkUrofr/pcgn7PgeRtlVEWDEBxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725530929; x=1725617329; bh=N8sIT0MLok6ky59KH/TRK5QPJZFF
	mw5Hj88jdbLgu98=; b=eRQulyQ7cXY7RTf551Pv6OOczsP6TYrDRQVUS38VgMr1
	uxiu+SP7C1yvpLTWFBWC1j6DhnVQgit4PN/MXgAbbIUAMEBB03DqDAg9dCMolTkQ
	wZaDUXGZ/4b+tUSsNv1UdR9YySIZVspcR2micN9ALtHZ6FiDXSKFBEpRIQNYSby2
	bQaiG7XeF6/Wee1qX2qyRX9sYK9CDOdy66tOCSA2iLrrato+71wde9umBgQ/bl57
	fW9Dw5KXdraS+cJxyPXW8KBRiQ+LTpj69XsxW2/B6OFxhIBcjEpsfUe3TUzirhBx
	0vDf6rgq0alfTYYBh5KDjlVwh64SZYFegJkUjlHCYQ==
X-ME-Sender: <xms:MYPZZmUw41fVoN2E0gjEQRIeGmGhFqcyTBtMYsCpol6Q7zmPRamyig>
    <xme:MYPZZil1SAQVLeQucTHAquOudTQsexZ_YoxlstOqTKszQtccKOdIk8iaS8xLTY5PX
    ZfYEWQJhUY9icEwDw>
X-ME-Received: <xmr:MYPZZqYQSXNLya6Vo1gz3WNrPu8zzLZovbMWTjwqd9Qbq-O8rpF7zytFCGJYAr_bCcVERaLSObfxuY-8c2HLGoWVul50KnfjHqccLnY0LkKPICs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    shhtvggrughmohhnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:MYPZZtWm_EzUQrKCdgIh_KDsiRCKY-dnbh5v36GeEKeDrZ5v6nqr6A>
    <xmx:MYPZZgkrFoQ0LfWEAf2MOtPsd0tRL-LmmNnEZl6kenUHF4wJ0824AA>
    <xmx:MYPZZicFTSM1RnDQbui2t-ZuzOLwrkvRo0_YYEOtFnlxL0fO0Tbb0Q>
    <xmx:MYPZZiHN_T7f3E8h6ab-sHtDyjouBgX0QEDQmxoCOJyd0j4rM7lbvA>
    <xmx:MYPZZuZ4QZAEa31e3IY1LYolvMQ2gMCQX-UlITxmpzkxGQ15-Zw7vQZC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Sep 2024 06:08:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de4e03d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Sep 2024 10:08:36 +0000 (UTC)
Date: Thu, 5 Sep 2024 12:08:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Josh Steadmon <steadmon@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Toon claes <toon@iotcl.com>
Subject: [PATCH v2 04/22] builtin/push: fix leaking refspec query result
Message-ID: <834a184c855c6e7b788771ccfd6a4f63dbacc358.1725530720.git.ps@pks.im>
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

When appending a refspec via `refspec_append_mapped()` we leak the
result of `query_refspecs()`. The overall logic around refspec queries
is quite weird, as callers are expected to either set the `src` or `dst`
pointers, and then the (allocated) result will be in the respective
other struct member.

As we have the `src` member set, plugging the memory leak is thus as
easy as just freeing the `dst` member. While at it, use designated
initializers to initialize the structure.

This leak was exposed by t5516, but fixing it is not sufficient to make
the whole test suite leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/push.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7a67398124f..0b123eb9c1e 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -72,13 +72,15 @@ static void refspec_append_mapped(struct refspec *refspec, const char *ref,
 	const char *branch_name;
 
 	if (remote->push.nr) {
-		struct refspec_item query;
-		memset(&query, 0, sizeof(struct refspec_item));
-		query.src = matched->name;
+		struct refspec_item query = {
+			.src = matched->name,
+		};
+
 		if (!query_refspecs(&remote->push, &query) && query.dst) {
 			refspec_appendf(refspec, "%s%s:%s",
 					query.force ? "+" : "",
 					query.src, query.dst);
+			free(query.dst);
 			return;
 		}
 	}
-- 
2.46.0.519.g2e7b89e038.dirty

