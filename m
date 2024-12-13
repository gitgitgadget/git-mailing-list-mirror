Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B24C1ABEC7
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079750; cv=none; b=LXEKNB7GuH9ks/qWLiGUZQsa25kxnnrFbJBQ/Rig8fOgr68wUBmd95U2kZZhTmpWxopHsjFi0FKnaFyrNaxjE61s5G/bLmkjFLUsAp2uv8Y2W29FnbB0KP1S0nGmaIvP19ZlpFQ15eGvdNCI75SpWbitjtu4/xhYYa1yx97qrcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079750; c=relaxed/simple;
	bh=le+fhBAx1tWECWjcQuEK9SpiF/7LjOULWCjYs126iLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KY6rSj/d1xqWHtH6cNyCbnwK9rFszqSXie7T91rR2xRWU+zPiTgFr6enHKHYy/cQGC1VwPmXkofifuvZefYi5roCrL7KNYdmJ+tVzszyeJlTWk0hjuBxTon399HzBz/sYr7TJ4qmcZNIbQVJ1D1fJg1ypZu2+So3w42tF/1JGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HLC1lVE3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoF/TAdO; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HLC1lVE3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoF/TAdO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E7CDA25401EB
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 13 Dec 2024 03:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734079746;
	 x=1734166146; bh=RvZITFce2NJHk+0Nqa/fqBxKDEP4PcHL7d4p44sPRmI=; b=
	HLC1lVE3jdxj+/BY3wtp3Wo2JdVcFY4E8/iNvCGUhXgyA8kYuyOAsPvbHiPeNtnh
	hy5wamCcBHK7I5kjh5CDRRo/jIRq6XjuIVldLR2H5i34SCDaM2I2QR+Fh2URYFIs
	oa9JqfgqeF+k4c+9ich5i7bx5FlkWkZf+6ll+r/CcLxggHHQvlpb/FXKpHtSlgw/
	z40HiwsCgUUe/nTDTzNKIa1TE1k52QhtBM/RQp6mSDBKxMoWzGsV2rhOSTPSgIMB
	vzNqcAQUKFM7HfbwlbWaUC8X34T6Cp7sbib5XpKnDRGAwfMOhpgyXqiLRJhBMyn2
	bMsAQkntyTHMOzPMm82wAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734079746; x=
	1734166146; bh=RvZITFce2NJHk+0Nqa/fqBxKDEP4PcHL7d4p44sPRmI=; b=I
	oF/TAdO9GfPcCCodaaPW4Bk3J4CxHHAHFtX5fSqoDn4RatQPyeQD0JpD0E+eng0d
	uQCzNpc3/EAfK28bafwnlFRiEeV+WNU4LRbIxVQ8k82b1eJ1vtVRGhSXHlTHupNN
	dJ+s+tAqKB8sNUVya5mW7NDssUg/EQ6BI/SD0+BW/JAhTflTYao53+/euuWvnNwx
	nfJAmCnCAr6QCD2UQ51FptpM5JJgHVDBdepoe5da22x8laY+DDmj3POeM5WekCOE
	8WP4enP8BBaeOdVU9+oX6nyu0tZd+46vz/ZdiRa59oVa9u5s8fqxk+HSmBcrqhxx
	JkLCFHqHDMgTDHTkMXTYA==
X-ME-Sender: <xms:AvVbZ1HpHUd3PUQGKnGbKPqjmB76ntMIuqjkBMQ9mn34peVfKDDWUg>
    <xme:AvVbZ6U5_cOf6DeL10sEuD7ESe38jX3O6XNmvlwyoNQqsrCZNeD83sMOhgb66emwf
    jZmKuzrV7uSMItLWg>
X-ME-Received: <xmr:AvVbZ3IhGCYkFc5WU0MljTc9b1-pz0gBE0-A1Jz06w-SXY_kv5BSwrxbPQYE8Bp_ceFsXJH5WQtmLiFAPvR4ob-ndkCqtDUNq-CxZzdFlp4_28Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeeigdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:AvVbZ7EVTtxa_mpRL4bkW8LcIF951A-3T4jyVcKcYIMwnX1X7uCoSQ>
    <xmx:AvVbZ7UGLK5Nhg2fxbaegJ6OTQv2aTGjvPB4Bj7jhk4KfjzFsTYgNw>
    <xmx:AvVbZ2MViFxF6cnF2OCuvwQFqHdhqFXvrdWcg1RfczgYoaA34PlVhg>
    <xmx:AvVbZ62eCa3ANsE4iUqHjgIE29Am2blg38fn_I9ahDJ43t7r5G8Wjw>
    <xmx:AvVbZyfGdRJrPz1c9cslkcU0WrJAbGP9ckSeap32ioHNoRmlRzsoghNl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Dec 2024 03:49:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 27137d98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Dec 2024 08:47:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Dec 2024 09:48:33 +0100
Subject: [PATCH 04/10] meson: generate HTML pages for all man page
 categories
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-b4-pks-meson-docs-v1-4-0c7895952cd3@pks.im>
References: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
In-Reply-To: <20241213-b4-pks-meson-docs-v1-0-0c7895952cd3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

When generating HTML pages for our man pages we only generate them for
category 1 in MEson, which are the pages corresponding to our built-in
commands. I cannot tell why I added this filter though: our Makefile
installs all man pages, so a Meson-based build misses out on many of
them.

Fix this by removing the filter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/meson.build b/Documentation/meson.build
index 0d8b58145274c7854fe3fd91de469fe9d1e0bb6f..d36b2b0d8e7795d0520976c1e54a2f90b332cacb 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -364,7 +364,7 @@ foreach manpage, category : manpages
     )
   endif
 
-  if get_option('docs').contains('html') and category == 1
+  if get_option('docs').contains('html')
     custom_target(
       command: asciidoc_common_options + [
         '--backend=' + asciidoc_html,

-- 
2.47.1.668.gf74b3f243a.dirty

