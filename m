Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BF384251
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 07:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756884; cv=none; b=q6ZBHZupMyGlrDLgP+BFuoVXZqSRi8YhVgmxZGKDeZT532NZS4DRjN3cOEE1e7LUjnyltILweOenUtStXmt/T0zGxcbNrIBkIVf7QIEpHLHbfckblibWaBhciHEbvxjmBY9OrqpSYkQapTsaVSkQP8llWSaKzFCdmClxwyRX1Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756884; c=relaxed/simple;
	bh=xyqbcv8pAj1VTkaJ2cyM8oR85zvgR9pNIWpyt5hh3g8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l1l9I80IFy6LaCVeEkgVOEvEtYkM5MN50dXjBKl9MazEqY0LUL2RL24+2o3cHRInoRf/c52yTPX+jZXurBgDLni83qitKwfg8/5ndv7CVfdtS9kzhVjSWk3G6BiDzsBS3J2teo6Xdnie53mFhyqPbaqZVcri1qpZhihwjKEvA9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rtFGKZwj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NB2IQdce; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rtFGKZwj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NB2IQdce"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B0BAAEC0256;
	Tue, 21 Apr 2026 03:34:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 03:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776756882;
	 x=1776843282; bh=9A3b/XMxKEtAgaHq1XqhO/1nmrFI3NyNx3/1AcWPxpQ=; b=
	rtFGKZwjHpoy1SOzZ6QiH+1h3AfuGoAOEbz8mxxyQVSLNf2E396+/hDHfYXTi7NV
	bCtI2OaqEbFJn1tOm+muSboqiTPAzhxZAs7HHg7hX7vSW1inMjO4TsdxP0Kk+EYI
	TlInlOMqKODPJ1xYMbrHAQfqJJUNnTWNxP+K/4tKUTHGvoOQ2BJZKcWfRA0pZQma
	ok+IfN8IIiFXwHnbFeD0OqlxEHw4tp9ItPt6RjwZoCJfT8pgbN1GVuY7+EqKQuy4
	MNl4N51GtkOmG5VUo1GGtEfzyPAV1QPw4HdFZUJqDUUErs0fFnNL1vIwVs8JTVjq
	eW6WbHu40hTY4TEOwTKK/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776756882; x=
	1776843282; bh=9A3b/XMxKEtAgaHq1XqhO/1nmrFI3NyNx3/1AcWPxpQ=; b=N
	B2IQdcekAkb4iT5d5R7z6EjFozWIK2xzzIziP0UWHZemlKiCONkzhbisEED8/YUH
	jnM7Ja6eLOPKRumvtJxkC0ywbO6WXkU5C4IzQWsOKXDgHzGJRuMSLk3CoqGdM44d
	27IQw5gVtl4RATCPfgCL/54ftt1CiPwG5L8aN8Sa++rWzJ83JxZ4v8ZpMxjUbBMz
	gyu7f90e+5Mqa4dDEPApMefiwoac9LvWWJ+iaOCRxqMEm0EWqpQUCMa029BLEvnU
	Nogr2tIkhzC7XkOLzw5ISMu7J5ZhcKuoPASg9UWT37rUzSATf9TfUu7nqA/0NJFr
	uANTavfzVHwX2a8FPBDDg==
X-ME-Sender: <xms:kijnaTDm4epYR7OrSoP4RssmTR6vL--2AvlNuDtjIPwBLP3WeKtM7Q>
    <xme:kijnaQjjbC5dhmQx8tV9KfuYS54mU3a2mogTeJA0Lgr-bK3lCZn2uvcOxw8o_ss4E
    0pIZxkAsDauC8oueit4I-r8rtAstW5rVsFw_z2cSw7pjwodhV05Mco>
X-ME-Received: <xmr:kijnaTnon0EX4fe5MxlYbMu_944_WRWzYrZPgNHXFyAFM2bGXygJYZ1g9fKqVD_3h5B72IjCGNgC0IpEg6jIYUUhBHrRM2kZQe93zINZVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeitdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:kijnaUokZfetBKJkOlPUAFuLAF7uKm3u9Kg8nrgg3yVHRtwvyDHRSw>
    <xmx:kijnaUElJIJoq0Wa-sjQTarmzO4p6pQeSu6-OK6fDMpSuisNvF0AgQ>
    <xmx:kijnaYyQXuc033dv9CgaB_7tKUlgGQK_VfLcYbl0e3ZsxmxUV5AjRw>
    <xmx:kijnaRpnHKo1Hvcps3YWAX5_Ui_WFLMnS6-sUNURxAMeiWZp97Sujg>
    <xmx:kijnadiGAeVDYVgLRXdUXb10AgUAU3V393fBQAgrAqKvRtJZtOtMZZw2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 03:34:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a03d87a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 Apr 2026 07:34:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Apr 2026 09:34:22 +0200
Subject: [PATCH v6 09/12] t1301: don't fail in case setfacl(1) doesn't
 exist or fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-b4-pks-tests-with-set-e-v6-9-26330e3061ab@pks.im>
References: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
In-Reply-To: <20260421-b4-pks-tests-with-set-e-v6-0-26330e3061ab@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.2

In t1301 we're trying to remove any potentially-existing default ACLs
that might exist on the transh directory by executing setfacl(1).
According to 8ed0a740dd (t1301-shared-repo.sh: don't let a default ACL
interfere with the test, 2008-10-16), this is done because we play
around with permissions and umasks in this test suite.

The setfacl(1) binary may not exist on some systems though, even though
tests ultimately still pass. This doesn't matter currently, but will
cause the test to fail once we start running with `set -e`. Silence such
failures by ignoring failures here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..0e0d07a1a1 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || :
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

-- 
2.54.0.545.g6539524ca2.dirty

