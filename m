Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E538214A98
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463338; cv=none; b=rOQ+DYwGjbxh71tlfnNjEMuXdakV9sHlWJvwL/N9Wq+10vGwZe9+kRcGO3Oh7ZXKWKoFXgAI41zHZ0KffqUGfUneNyygWowRAVECM9Jh+hIPGRetIiZXk7p/HoW+V7gQ6SEhIARQEH2AueqqyF6F8KUfq8c2XC+yLkFNZcbCKIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463338; c=relaxed/simple;
	bh=mnP/eIeyddsprQjbJ5j4kWT5R94K7zpMiz8gFfvNNhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g7n8O8nIbdf9kfQ+Lkf9VBTfwCGrJm5+IyOTS8I+6Y38pCKsMBu8r7nWAOs+CEoKMeFgHgGyljxxZQJ03DlspRiP5lfzYdijC92Ij3EA4LqC1U72ovT044JRuDIvgj0Hmbol3hIxGXxz+0Y5crElLGVTEs2qBKnJ+mC5PHzez4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ww+AvOLw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1iRtRnOm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ww+AvOLw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1iRtRnOm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7829F25400E3;
	Thu, 20 Mar 2025 05:35:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463334;
	 x=1742549734; bh=06AlNuR4CTpgnkt91LHbVtA+Vq9aPaC5SAotSYkUmBY=; b=
	Ww+AvOLw5GHsaX4iq0wI+VRLdXXIW5Tthcmi4MYpPTLYrg812DQKV1S6qoFTp0t/
	VHJP11eOfTw6TVP1FfAzMme7ubqFZUTqihKbCoiPS0N8pvm6cRakia5KbD9C0+dJ
	YEOPDsZPCbfRKwtlCYAetOWNJij7IeRN33NM16acxjqpq4aURkl+AyGNr35+dh4Q
	7jC1I/c5303rEHdSY3lKpV07f7wuU/vGKNqpaPoLtPtOl6hPKRVzKtZMmO3VPFr3
	81iCN5IYVFMp3xOQHLPUQafNCBo1ImQY1fPde0pw7ZQpLiZV8mNdDVjBdO8Wxas5
	rfx6tlXq4PMnZUREeUyUwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463334; x=
	1742549734; bh=06AlNuR4CTpgnkt91LHbVtA+Vq9aPaC5SAotSYkUmBY=; b=1
	iRtRnOmmKJI34mBMw7cC7lB7ZCysigZMyV3yb6Oi49+A3J1PE66D04Af3HqGlZDn
	80gKHP6x4b85HCzPK9djG3qs89o/tfQyfXzAcjUWMpec+WcDtcOhn+ER1SMfyaM2
	V/SIXFHaUZ1OO3etgCV1wANixfJz650DMniTpcruTCcVb1XJuXpZYizT/YhIHNmB
	Q58QMKI/YL6kubYUSgysw4Qj7wNRJmWUBURCzgC6MAVejZt0fUsUorPIvs2ZrmBE
	ffKk7rnBqtBEGiYwm2n4j6CblEpWawD2+8emC5aVCYdVVAuoCU34mbKx84X3lPc3
	lwjmRj6daHaqvMfO4rxDQ==
X-ME-Sender: <xms:ZuHbZ1IViO0o_7mAxGUQ2gl3oEq8vNosC7vtGURnabmIwdBKKv1ACA>
    <xme:ZuHbZxLcpnG3QdfemP_aU47tRDoYRsncYwxWJKpUQrYMUivPmzPqI1z1na-XUvvnk
    rouV1q-VkjBE4oYYw>
X-ME-Received: <xmr:ZuHbZ9s3vMHLz5lA2NGNHm-Rq0c2htTqB4IbqREW-_yl4D8JVNA9dksNrB71xwKMxZ_wShKs4iNiHAl-Zn6v1c6RxdPePlPPql-dLODRWrgE314>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:ZuHbZ2b2GUQvJbk7FYUb-uiR10LBkzU_VkiaHJF8HjLBmmlhvx8GSw>
    <xmx:ZuHbZ8ZRuSimYfiWASEGGq7umyF-fRrB9dElN7aPafjjqnpmUdexjA>
    <xmx:ZuHbZ6BRzm0RmAoKjWFsfQ6tmGVMOOOR04YZo3iZh5y47JbQ3ZhX8g>
    <xmx:ZuHbZ6YSTJD6kKlAvLaXBJgwnfWEhtFFpdeCrc34y1c8wFkwMYrXHw>
    <xmx:ZuHbZ7mRFuIC5RTm31xMv5AWlKf-YhgIcnC5AjphIJLeAYDHrw6bEl2n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d15e9480 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:29 +0100
Subject: [PATCH 02/20] t: refactor environment sanitization to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-2-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

