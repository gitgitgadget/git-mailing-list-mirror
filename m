Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80E338F239
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258425; cv=none; b=JL+3xj08MDqzIsl+h8IETQ5g66Pz/cIWTnqew8mVpKLnQCJmDyi9PUb8rmzF4jmsrR8FKFJIIXJN/exNg68O+0fPeii/h8NlAwqXO0/5eK5hvA1zC9VGnzoqeQipowOeN5gtzpWbyUsBgNZxPiuRc2E6lVyQOMV35nixWn4Hi3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258425; c=relaxed/simple;
	bh=Sqxral/SVat7YZbY/zlwJPMjwZaC+tbEEgeKF5W+yDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kj7DXcx2WCK9ynTspkKVD4YshsiZxSMlsqTTrQbHFJCAjjdxj3zGQwt21Hb6c8Sj2ArM5qLod2E6Qw0gq2o/eKPbvHr8NgrJH7H6hxVE8zFVBgcCX9r48mM/0DgcPuWtQT6jzZXWeE9KWPx2jsfBc4Qr5E7UcuFVHlVugvv80yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Miv6F+J2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JtrkjNOx; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Miv6F+J2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JtrkjNOx"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 93528EC0197;
	Wed, 15 Apr 2026 09:07:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 09:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258421;
	 x=1776344821; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=
	Miv6F+J2xIyAjgQ52xA9UyGpL7GeDAaW8C8R2qpBtEJfA1seTJUMDIGv1ywrqlB9
	OpnTYqaG7/VKuGrUC1LKdZLHmvQH5LGqcXPmoc1+7xqrZn0UDYWU7N2TTkKMyH/c
	7fZ3P3fM4KQ4t0oAl5/JbZ/y9Sx9zSZJ7ofyaUjOJqs3m9dJPNtprnRH3eSvPG1s
	HUZDNdhd+2gq4LO4eYNRxtsAJfyO0++QUBdIz1hf8sylZRUodj7LMHfPThx0n2Q4
	dEeI1iNyl/9cPhN3a5fhbUA4KL+0T9by9yllEStNeMdoaUa0fjwe/y3MEq6A21d5
	OGbxhvn10xQxXX13T6fEuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258421; x=
	1776344821; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=J
	trkjNOxiz96ZNNaxnOVXVaLNUbMeSJ4DV7/d5TeLSH4YVOZQu0RfHjdclGGM6tsL
	EXEZs7xYGMLHFrijKMXK8USB5K11lLglaZM9aNOCj3neQigNVW6frJ3NAF3BvUt0
	1/xHoGXb1+BK07stOnYgRQx6bO67WjpMCWw9Q7vxRG7fTdPMIZGchV1LjrfrRnY5
	HkrKWi1WdZyRHm75rkBRum+B/5p7ecE7fMyDPW7BBfrZgoBrQVZClJrBD3MOoJbH
	70Xz4tRMJ1qHdduqCtNucYWbfx4xO0C/Lt7aSLBA6fXccCjX9oGqIgVo5TY8VDzY
	EgPlJxIA+SfjJDsRqTrDA==
X-ME-Sender: <xms:dY3faYCBcZ_VgcZlpDK1NIGul5rSKtHtQ-GPZeFp07nwwsXdhpIyhQ>
    <xme:dY3faR8bf_FZYUpcCMCenbLYFIR_FRFlorrPYZjQkJrmgPbHbdfNQ2iGaw4N_ayTd
    PM81vej2g-p5_VYAogmUVCBywXmCTmKO72Jmujjx0WL9iok5gEihA>
X-ME-Received: <xmr:dY3faY9ujhyAyw3UGbyAFj46EfNr21fs8wZXCR_6FrgJTHFDtW9aW3rA31wZmwgd327AEylr04NhxMxYb-iE1_z40RCCKuj976loYAJlg9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:dY3faYcQmPYdQ5NXvNYVK7NG_kV1Uvy4sLz-POD5Pkn-Qhp4woci9Q>
    <xmx:dY3faRHPbVbl9ZhbIesfJKcGTdeZnjtCHIoP1HEElcSJ2TGwer8zGw>
    <xmx:dY3faWfxByGgiL21-iaz-3iFKtfCjtZ950Yp4lU9DjO1kupLDJdX-w>
    <xmx:dY3fabFcC379mG_qTIR8ad5RpIwHHzhyvFy6ESx-y-oxnCPvvTnU0A>
    <xmx:dY3factrn6InNxKNVPD6oQy3tESo9JOq2lD9mpUNwPs7VbQCZEeg_Rrn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:06:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48c1cd20 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:06:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:41 +0200
Subject: [PATCH v2 08/12] t0008: silence error in subshell when using `grep
 -v`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-8-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In t0008 we use `grep -v` in a subshell, but expect that this command
will sometimes not match anything. This would cause grep(1) to return an
error code, but given that we don't run with `set -e` we swallow this
error.

We're about to enable `set -e`. Prepare for this by ignoring any errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index e716b5cdfa..d77a179bdd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,8 +122,8 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
-	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || :)
+	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&

-- 
2.54.0.rc2.529.gd9106f7525.dirty

