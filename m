Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E8368276
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922774; cv=none; b=szArVaowXUhd/yD8TSnH+eotVjm9SUWm65L7S+kfWhpVQ8ztU+LfXq+EfAtgF2pADKT+N0Kz/H8gB8kirKj/JMM5nhEfHuidnfZS7UIo5qN4c1BJoQzHJkwE4Q6CMOYSV/q8R4PCY/tuH2KBYIo4wxA5aDzA+4bIrQ/FI3U3kzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922774; c=relaxed/simple;
	bh=VdCyDSslq5cGyTFtZZWIpi0r3Cfvv1SgwXALUUEU7Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q//Ag07fNLJMgs2yxx3ZW07m+9YPi94Hak9xc2KjezALydV51i3Jej7m5xPcpMbwGcZfy2o9KM5z3zrzVn8daK/CiDodt2DDtQhwxqq+uuY3pvwUwNRyCkIIsN7jbWZJZ7Mm9RTR6M7fJm2vzcntZyn9b7VYeuxNiwTmIJ8iFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m7kWkUQ+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HOpt/tZR; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m7kWkUQ+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HOpt/tZR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7399D1400049;
	Tue, 24 Feb 2026 03:46:12 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 24 Feb 2026 03:46:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922772;
	 x=1772009172; bh=RakfAZhfsbVMrgx0X9hSTnK0MAOpIjFTDBabmFR1h7M=; b=
	m7kWkUQ+VPP3HXs2Vjegr276b8yNu2IC5H/DUV9zQ4RmDg2O1MsGUws/1le6jDRv
	4ZfREgn+hhgygJsC08zcrwdclF0Vf7Bkcmr+DcGoZMMfMR02vckmojAiHsNup73k
	iB+JVuSnlp5j+xSPKZFHWBSBBp7JEWg2+56hs0lm82cJR64YpN3RX9GAY/+VBsdh
	ahxvOqApw9cCh2stj9iUHho898DN39U0nisefRS4FR7CTfiFcZ5tWbpk7gfU2MFa
	ac6FnDwY6tFaO0I09I0UYjsByCngmqB4o0mGEO4X5Wo+QIyFTIGop/94Eu6LwNlq
	wCgZa5QKmcRINuvcJU2oPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922772; x=
	1772009172; bh=RakfAZhfsbVMrgx0X9hSTnK0MAOpIjFTDBabmFR1h7M=; b=H
	Opt/tZRiIbSpMWP7eDA67LsvcwurB4DuHQPpPNrUIeiYpq7LMvBpoMIdfW/o7r6q
	jkjnMqcuHOdtKAp/sLYWu3qte4xTaKP1wDiibvlPuY/K4mFnSP8Iw+A3W+YU2KcK
	fFbc2vzqGUsC8++OJolw1d5kMYfFk/fkJnxDXSDi6RcCCsdo3pgiIhs2Sp9UCX1h
	BRGHndsfJolPMINsISCLd/JqzTFTGrT+nwXOPOAzfjxE1CCHAcJQCo1OlWcugxvX
	qz2WDvUE/Ue+hKZ7MGnSmhBIGanYWzdIrvv/CXKp5vV0pSq6+00d6Era0awv1vyX
	MrY4/DZrDcFe+R5j+DIpQ==
X-ME-Sender: <xms:VGWdaQdbACysS83mREHOU8Uukrdy0lDK0KAeaQBqBQOjrqNXN-QnUA>
    <xme:VGWdaZPMkW3nrrvb_REJ12SIRgR5aPeKR6C1LGXE0C2Hu6Qyh6SBEfPg23RJWQN2M
    87wj1J4ozRqMWUcVRoYK7y3xWKvb8zEFZtqZIRnHhQ0e_Vbe9XlVA>
X-ME-Received: <xmr:VGWdaWg6TiT4-9BtJJgsI3VZRsSIZ1iF0CaHNBHPZjpBvTo1pkrCbQvoSlDNVJJqzroD_QgX4AFlGmx7CP-3-jtM3e6yjMJO9XttAPppOFZtGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeigfeggeethedvffeifeekudfgueelkeefhfduvdeigeektdekhfdtheeuledtieen
    ucffohhmrghinhepihhntghrvghmvghnthgrlhdqrhgvphgrtghkrdgruhhtohenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VGWdaU1cyJ6xVCW_YjNPz_-TFGzsuk1jnTzVAz7ukRuZbEauRwZV0g>
    <xmx:VGWdaYiweSgqSOwjAk1zguOnCl-8kLQNuT1fGjkrCEY5BCI3u4nOjA>
    <xmx:VGWdacenYIxzNzy0yVLi26GGPyIlX_Oqd7FdBArSV0mn3rAzywYqSQ>
    <xmx:VGWdaTlNQ2EHW3LVjsToZZeiAjuozCADcxtGwgR0w7qGe0Q2VflMzA>
    <xmx:VGWdabijQsD43sz5GWtToy4FvRHone4n178x3NGG09W63L7lgZ5yPcS_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:46:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44c5ca43 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:46:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:51 +0100
Subject: [PATCH v2 7/8] t7900: prepare for switch of the default strategy
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-7-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The t7900 test suite is exercising git-maintenance(1) and is thus of
course heavily reliant on the exact maintenance strategy. This reliance
comes in two flavors:

  - One test explicitly wants to verify that git-gc(1) is run as part of
    `git maintenance run`. This test is adapted by explicitly picking the
    "gc" strategy.

  - The other tests assume a specific shape of the object database,
    which is dependent on whether or not we run auto-maintenance before
    we come to the actual subject under test. These tests are adapted by
    disabling auto-maintenance.

With these changes t7900 passes with both "gc" and "geometric" default
strategies.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7900-maintenance.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index fe344f47ee..4700beacc1 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -45,7 +45,8 @@ test_expect_success 'help text' '
 	test_grep "usage: git maintenance" err
 '
 
-test_expect_success 'run [--auto|--quiet]' '
+test_expect_success 'run [--auto|--quiet] with gc strategy' '
+	test_config maintenance.strategy gc &&
 	GIT_TRACE2_EVENT="$(pwd)/run-no-auto.txt" \
 		git maintenance run 2>/dev/null &&
 	GIT_TRACE2_EVENT="$(pwd)/run-auto.txt" \
@@ -499,6 +500,7 @@ test_expect_success 'maintenance.incremental-repack.auto' '
 	(
 		cd incremental-repack-true &&
 		git config core.multiPackIndex true &&
+		git config maintenance.auto false &&
 		run_incremental_repack_and_verify
 	)
 '
@@ -509,6 +511,7 @@ test_expect_success 'maintenance.incremental-repack.auto (when config is unset)'
 	(
 		cd incremental-repack-unset &&
 		test_unconfig core.multiPackIndex &&
+		git config maintenance.auto false &&
 		run_incremental_repack_and_verify
 	)
 '
@@ -619,6 +622,7 @@ test_expect_success 'geometric repacking with --auto' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 
 		# An empty repository does not need repacking, except when
 		# explicitly told to do it.

-- 
2.53.0.536.g309c995771.dirty

