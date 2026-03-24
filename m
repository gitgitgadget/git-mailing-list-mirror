Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6213358B9
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774376010; cv=none; b=LdYRB/MlLBqvnevHPrENHvN/ttP9Fz22U35A396xqb8w9fc7MvWWoqs2YCNm8aNGcojBN2Dc9Oe9lSg5oJ0EuHni10B4roN4NyvvKNU9eVXFG+K8UhEvikjJRK9LsoDophobcs1+Jk/cR5nSwByBuTouEWkTNXfy58/vMx2as1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774376010; c=relaxed/simple;
	bh=SkEcQNTMSeZksYBwiWxgpOcA7NQphBI29gY7mSb9Bwg=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GrejE6FjbcJmT1xRF+GRJxYGxh0QqQUKBqhi/uQmI+UjEAECMgKIYvsXwvwDYLMqt2h1gPhhmCrjH93AAPN8SEgKgBkQrbmR4XTF8QhOeclUYDrYSKql9TPRR6u3Qii+bUGA48K6L9XO66mbAs14ncvpiQMG/fDeIugkqWsP/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b8jU9BJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=huPszqxP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b8jU9BJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="huPszqxP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3E595EC0102;
	Tue, 24 Mar 2026 14:13:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 24 Mar 2026 14:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774376008; x=1774462408; bh=VCwv6WlPqn
	AInp3V8ODCZltM8dWbd+kthE6y7GtD3T0=; b=b8jU9BJLSs7W1l3Ll8RKvJ7nX8
	3dWzNByfBRrbWnPEioI88FoJdKCLKmszFZfWxdHQWL4BHPckyljSkRTDhw4lWEe8
	NtzYwZBEHPRgmVa/hTDrcpOlt1lO0GfixnY0OIKrUN2G4u7hMXsAlG9TFfi/Dfjb
	H5yYNhqcYdna6F7WVv++DrRD26a4wluoZ0lsSOUP2AibhfajqVI3PiE4mIa9UNT7
	KX0Uxbf/jWgqyIushpp0A1z+wWzUglGUoKU2W74te105VLkfdkUyPS0cr/NSBhe0
	BiHUTJ+w2wfiXBc1dBOHLJJe1Z2nxHqFRyC+17uvbqKQY9W6PvRx8XGMW4dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774376008; x=1774462408; bh=VCwv6WlPqnAInp3V8ODCZltM8dWbd+kthE6
	y7GtD3T0=; b=huPszqxPuFRMYWvx9A2+njJLL0ER8zcViYRRa8kaS6V8zWO3wdB
	HjUhE1I3+2isXlTe8aUdxsQJQTrQh48VTsSwjtzThzT4bSy1Q90Jm4Hxq15Bv2xw
	QeOdslPI3F5+czwdJhK4BdtO2W4qmrrJL2POZ7O/5wXONEylhvZr14TbgYiKv25x
	69Wk10Sshng9m/WIYEhTuLSuVIBoKAneMTCHtkUHiQPcimuCicDZv7/ZGdeFtpJL
	Zu0a2cOmfLoEEhgQECNhCB22+bqMCgf79CL8dKYJdXyKSDF0NgxzfUBVj4Gt8qCF
	nUXNmkB42qZhqlsyMpu/gtjYSzPLcARvZKg==
X-ME-Sender: <xms:SNTCad4tjQnCCBQe34Cx63gCk2p1ocwDxU4wJPuH9cSPGkqfwGjTyw>
    <xme:SNTCaQ6bjY2qPsy_JpX22h2GMUsuBxfeQvNUBJqC9RUHJlFnYChej4i_9BAy_67FZ
    goAedb9BBr5LWkr63cuuqJdp-1M2aW6YwQL6oJEgB4QZZpbIkI5lg>
X-ME-Received: <xmr:SNTCaSGPyseNBptTtAF2W3E0X4XDTfFzH1--FIHIoC5grS8owZyLGtJ9x7bgR_2s3yneBoQ-tYDmaoLWw_QNFcDljkkKpVbz9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:SNTCaRTgHMbHcJZYgZYvi7X3sfYTkwnix3A5SIHgJ99cuMEGBU0_nQ>
    <xmx:SNTCaTve0x9rKP9SmA6s34frO16eMJUhaQ8Uux2_cCNMZReIvQ4dGA>
    <xmx:SNTCaYyM2owbbA4I0BNXcRBydMKCxXx2ICBJaRfhv4O8AC6UCj2f0A>
    <xmx:SNTCaV5S-CfJqsAXRlgWimdOMz6scD_5SGNX_-p_pkAqL5kKwGQChg>
    <xmx:SNTCaRSDlCD2z-hSmN1wyloYetlOIryUHUCgjUKl7dClWkEaIC5ENYC_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 14:13:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] test-lib: catch misspelt 'test_expect_successo'
In-Reply-To: <xmqqcy0t178a.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Tue, 24 Mar 2026 10:13:09 -0700")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
	<xmqqcy0t178a.fsf_-_@gitster.g>
Date: Tue, 24 Mar 2026 11:13:26 -0700
Message-ID: <xmqqmrzxyu2h.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

In order to catch mistakes like misspelling "test_expect_success",
we would like to eventually be able to run our test suite with the
"-e" option on.

All tests dot-source "test-lib.sh" as the first thing to do.
Starting the script with "set -e" immediately reveals one place in
the test framework itself that is not clean.

The test framework runs "$GIT_BINARY" without any argument. We
expect it to exit with status 1 (i.e., "git<RETURN>" that spits out
the list of common commands) as a sign that we have an instance of
Git that we want to test.  We cannot quite say

    git
    if test $? != 1; then you have not built git; fi

as the first invocation that exits non-zero is caught with "set -e".

Work this around by rewriting the construct like so:

    status=0; git || status=$?
    if test $status != 1; then you have not built git; fi

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * As we look into other breakages, we may discover more breakages
   in the test framework that need to be fixed, but this change
   alone seems to get thing going for many test scripts.

 t/test-lib.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git i/t/test-lib.sh w/t/test-lib.sh
index 70fd3e9baf..a2aa97fba3 100644
--- i/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -17,6 +17,9 @@
 
 # Test the binaries we have just built.  The tests are kept in
 # t/ subdirectory and are run in 'trash directory' subdirectory.
+
+set -e
+
 if test -z "$TEST_DIRECTORY"
 then
 	# ensure that TEST_DIRECTORY is an absolute path so that it
@@ -143,8 +146,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 ################################################################
 # It appears that people try to run tests without building...
 GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
-"$GIT_BINARY" >/dev/null
-if test $? != 1
+status=0 && "$GIT_BINARY" >/dev/null || status=$?
+if test $status != 1
 then
 	if test -n "$GIT_TEST_INSTALLED"
 	then
