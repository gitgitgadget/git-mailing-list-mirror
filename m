Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F731618B
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338379; cv=none; b=uEX2RlNshCOqwHmsohmQPOsMCVCN6zrL1dQ33Lkfcx7Ep9g0DfAcdSlqnr5yRYZj+Idd/nnI7cLgrWm5sW0SqjvI3uTBJgNgqgYLwwCuyg42WGaFeAt/YSq+7ZrSLY8IAnJiEdemJdYAelIupxgezxD03OXsEtfY+D71ZJXqLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338379; c=relaxed/simple;
	bh=QwaFflupcgZGtUiTur+0TZkVNF0tju6K2qOV2/CElLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZGUE6Yb6deY9GSEhpqCr9cuJ4KpB8xJvxqxXSuRQ4VzQCBNJCbmRjsXRvaX+52piSLEf9L/mUsZiNzKVDlVlV4MHHzwtF3pkJC6x1IQC8HLiT0/Or6rBj+WKLSFp+sTWuB//Yp36FfYCMMTCT5KLY2msaaM6zDiQUmYi7JgkV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tDriyoRN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9YYwiuq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tDriyoRN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9YYwiuq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC5BB7A0200;
	Thu, 16 Apr 2026 07:19:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 16 Apr 2026 07:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338376;
	 x=1776424776; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=
	tDriyoRNAK/Mr3teyzWMQHUMvHpJDu952ospvPuy7uvaDhjKfXobPXQ6MLRY2y35
	qrQA3s+q5gxvd9LEwAH0w29gAw+lC+eEOArGHVIgVA6B4hCcmlGOJ6vcmD3dIcpV
	Qic6OiJNjx6Uocel5q99tSi9+J/V8BTHdiO9ZRJyPaqagWfOCaZjWJPyh1YM/jUx
	NjnQbpVntYRk1NJXaekmR/1wTrbeNqY0rN7w4fsu2OOV56oPyqezkDQ0D5HnwZr0
	36l3sy6nyN1sFCgvza/W86grDTHYrgRV7hvfRu2proLip7wlWx6flcAPSFmON1x8
	A5Yz/7x55t16c2rXDH4Gtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338376; x=
	1776424776; bh=JH42nt/3fO7vfbU6MbHQgipsNo7cRzzerK9UINFMLgo=; b=e
	9YYwiuqcd5BEAxKPX9VnEonAAmtASwP31YGjMn8ztUO3nfx4ouM01IRFLXDjLboQ
	h/HS3b2kZpjgEW8JTFpKFOA4ZEF2iQ0OEf5hd9vE2pm2JUgPOcOtKxaHLLCu1fWJ
	9Q+7BlCvKXAP7aDrFIAcygGBtH0vBQ0Mu/Rx62jgfRlE4X8GbeZWoegqZy8PS261
	MkzMjseSzS4rKuamAsbR8TuPPB4FKge+kXn8Hjp4+irhLsp/5359FhuFyKtt/Jz1
	dKWWWOMgPV+zvTKL8SpLhw3FiUS9BLSkBDf1HzswEwaMbwhgeGX9iJXMrV0u4jC/
	jNU3c1acHztbxOWNwhWnQ==
X-ME-Sender: <xms:yMXgad7z8gtf15h2--tA72c5yT9_VTusseRlh4wqYNu6kY3kY2jwhA>
    <xme:yMXgaSVBBWReQ9_JI23OrzEq2ZxqbQLc6o3BOpsc1GRZkcoBetIrMZiuRI-bZl84J
    ZBXCST4weXzXI3zR8j3mrbz2-OFU-AOCRMMxbIsyOpVyFU3iMYCaQI>
X-ME-Received: <xmr:yMXgaR0DXqcOCbeRWusxzQV1QlpR0SatgL6AETxQ4UpxycvbZhasQK5zSjNVW7TPIbdBu96kevu_kwBD3BQ2ucQGbvYX1oVskJhOHdN8YA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yMXgaf3kWafIkh__OnLSLT91zcBqou9vxks3Za5flSIdKnab4TkgNg>
    <xmx:yMXgaU9Jn-6MPDwunKJ5XUiJl3TSglPlvW9Kbp8bur1O3-ddNDDYhQ>
    <xmx:yMXgac2xFNeUQC06_p6G7-KFO1_hOoI4sHY8uGrH1vlmZClh_2gNOg>
    <xmx:yMXgaR_sXEiZM0inwHycdXSHhcmMXJFpGqHuyCcw1K-VuuaiCVgpZQ>
    <xmx:yMXgaZHnk2ufoFobqGrpweyCGJFECZWfBq7UQvcNJ_40_KO2LuHCAWrW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9468b22e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:20 +0200
Subject: [PATCH v3 03/12] t: prepare `stop_git_daemon ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-3-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

We have a couple of calls to `stop_git_daemon ()` outside of specific
test cases that will kill a backgrounded git-daemon(1) process and
expect the process with a specific error code. While these function
calls do end up killing git-daemon(1), the error handling we have in
those contexts is basically ineffective. So while we expect the process
to exit with a specific error code, we will just continue with any error
in case it doesn't.

This will change once we enable `set -e` in a subsequent commit. There's
two issues though that will make this _always_ fail:

  - Our call to `wait` is expected to fail, but because it's not part of
    a condition it will cause us to bail out immediately with `set -e`.

  - We try to kill git-daemon(1) a second time via the pidfile. We can
    generally expect that this is the same PID though as we had in the
    "GIT_DAEMON_PID" environment variable, and thus it's more likely
    than not that we have already killed it, and the call to kill will
    fail.

Prepare for this change by handling the failure of `wait` with `||` and
by silencing failures of the second call to `kill`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-daemon.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index e62569222b..d172aa51f0 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -85,14 +85,16 @@ stop_git_daemon() {
 
 	# kill git-daemon child of git
 	say >&3 "Stopping git daemon ..."
+
 	kill "$GIT_DAEMON_PID"
-	wait "$GIT_DAEMON_PID" >&3 2>&4
-	ret=$?
+	ret=0; wait "$GIT_DAEMON_PID" >&3 2>&4 || ret=$?
+
 	if ! test_match_signal 15 $ret
 	then
 		error "git daemon exited with status: $ret"
 	fi
-	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null
+
+	kill "$(cat "$GIT_DAEMON_PIDFILE")" 2>/dev/null || :
 	GIT_DAEMON_PID=
 	rm -f git_daemon_output "$GIT_DAEMON_PIDFILE"
 }

-- 
2.54.0.rc2.529.gd9106f7525.dirty

