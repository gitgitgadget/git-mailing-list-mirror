Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D0420E310
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071835; cv=none; b=Qvcj0aWh89AMTCd2pElzor/h9n/M0mEnOSmavpi1obWU1+4NSTTfcHBfrkHiK5mBsIBzsIv4uSegOgnL8urkuUw5JEHXhFHkvaGVBAUaDiJC3G7Oaejaa7JAz95ZQd1TtUfHXvVOuu83jFNu9y4MEreeJgBuVZDcKX8YRkrtPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071835; c=relaxed/simple;
	bh=mnP/eIeyddsprQjbJ5j4kWT5R94K7zpMiz8gFfvNNhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poqb0lmBEQLmeKXUSObQDWyYW/K4zrp6H/HV922NLdj6hrk+zOfoNu7uEXogGFU0sJRQ9BBpr9qFiam9dNYndYYnOvTUD0QLljYz5wGvjIxpfoHONecGaJcxG45G4e/fCNB/T0ynNgLwWoTag15rtNLwxkt1YAEW6abB1/dPVzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M5ItjiDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NYGPXKE8; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M5ItjiDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NYGPXKE8"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BD38D114012F;
	Thu, 27 Mar 2025 06:37:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071831;
	 x=1743158231; bh=06AlNuR4CTpgnkt91LHbVtA+Vq9aPaC5SAotSYkUmBY=; b=
	M5ItjiDuNveYQMAKF1gfhgckQtaTVEBdCP5Xpd3fvJwysa+GuEzxJHPQU/nA5xLK
	v7VIK6zTnlqLLI4Isk8oLwNvdZLDGYc55RY2iWdMjXlqOU9hIVHXpsse9ZuEEpLo
	+17Y0bmqlNMD/ALfQCirP7MOU594/n5nFHM0XsOTNVx/U3serPpaHovNTUQ5gZSG
	grINENl6VHG9SODD3u4OxGkAeyMzNTGNH6aG8qV22OaMT++Rn1YjMtrvP2RTXYMV
	wznz8MafFTCQ4qWO9IwNKw3aLQ/UQTJRJi8knr+wvHhLPSxQ8RCavZl4yC03aMdJ
	TcVwkexINDpFCYhKmI5v6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071831; x=
	1743158231; bh=06AlNuR4CTpgnkt91LHbVtA+Vq9aPaC5SAotSYkUmBY=; b=N
	YGPXKE8h/ixr7vfi+ynQeavirjeGB5hMGlNFzxnjiFG5JlEgxMOcSPNnPY26XrcC
	4CavMbIArhaAwSKEjrYaAiCzahs486F+6PSlv/Kyw2KnT+antBMDk+kgYyOHvqyF
	3FNF+NmF59uweazWNAAqqwIyUDWvb7wPwX+NUZqJYZmQl0d0i4yjBr6rpEVBacCc
	tpj0tzDzYU8amRjw7BzN54lVgV0f0YgU1zEmPBlDSCthQu8zW1PIppiNZonX3doB
	wOdBEFeX6LOyDbWzPAKqgzcCl2pNvGVGDohvwBwK4sDlnhG/KPULhoCTTQJTZEkk
	IlX5KH1zzEHui9D9Q+IGw==
X-ME-Sender: <xms:VyrlZ_zteljFVk8LCTsvJJgOH4uVaIBP3jAz9y4FbqzFQ7_THONAcA>
    <xme:VyrlZ3TYbVL42qj8PEPuCCgFJPPxtMdtEB8l9suavb9g2EeGBxdssuoO0KxEXAWXM
    Nq7Eo5nUkWesz2t5A>
X-ME-Received: <xmr:VyrlZ5W5jePiVmu5ijHR4zKxKCKygy7UcfVpxZ4kxhEzVkKdSH6D4Km0SlGEF4jAK-cTemn4EeaLDCRvptwh-1Vw4cPMpO-EsoCbrDzOafkwMA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:VyrlZ5hOU8ia_aqRVdL3ZgDaoJbQ5xhMtUzsm0aTuUt4snMicgle1g>
    <xmx:VyrlZxDLeKRfgkEXsRWU3vKWj6ARK3G4NGdmfJZPvM1gmpuKzULO0A>
    <xmx:VyrlZyJyhSHOjW9RwZoovMRDUiIg9opmwGjUhoDmTZ_ZQe5vyoCWlg>
    <xmx:VyrlZwC2UVBTOxKDfT0JmHYbP-7KblJ1lt0DpJsLWp67H_DVqJUTUA>
    <xmx:VyrlZ078pHJuRLD0pbScFjFSkLR5vMqVD9oCwI1jfP4McutkAb0_YYN8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 08dde593 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:00 +0100
Subject: [PATCH v3 02/20] t: refactor environment sanitization to not use
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-2-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Before executing tests we first sanitize the environment. Part of the
sanitization is to unset a couple of environment variables that we know
will change the behaviour of Git. This is done with a small Perl script,
which has the consequence that having a Perl interpreter available is a
strict requirement for running our unit tests.

The logic itself isn't particularly involved: we simply unset every
environment variable whose key starts with 'GIT_', but then explicitly
allow a subset of these.

Refactor the logic to instead use sed(1) so that it becomes possible to
execute our tests without Perl.

Based-on-patch-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1ce3b32fcac..a62699d6c79 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -499,24 +499,20 @@ EDITOR=:
 # /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
 # deriving from the command substitution clustered with the other
 # ones.
-unset VISUAL EMAIL LANGUAGE $("$PERL_PATH" -e '
-	my @env = keys %ENV;
-	my $ok = join("|", qw(
-		TRACE
-		DEBUG
-		TEST
-		.*_TEST
-		PROVE
-		VALGRIND
-		UNZIP
-		PERF_
-		CURL_VERBOSE
-		TRACE_CURL
-		BUILD_DIR
-	));
-	my @vars = grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
-	print join("\n", @vars);
-')
+unset VISUAL EMAIL LANGUAGE $(env | sed -n \
+	-e '/^GIT_TRACE/d' \
+	-e '/^GIT_DEBUG/d' \
+	-e '/^GIT_TEST/d' \
+	-e '/^GIT_.*_TEST/d' \
+	-e '/^GIT_PROVE/d' \
+	-e '/^GIT_VALGRIND/d' \
+	-e '/^GIT_UNZIP/d' \
+	-e '/^GIT_PERF_/d' \
+	-e '/^GIT_CURL_VERBOSE/d' \
+	-e '/^GIT_TRACE_CURL/d' \
+	-e '/^GIT_BUILD_DIR/d' \
+	-e 's/^\(GIT_[^=]*\)=.*/\1/p'
+)
 unset XDG_CACHE_HOME
 unset XDG_CONFIG_HOME
 unset GITPERLLIB

-- 
2.49.0.472.ge94155a9ec.dirty

