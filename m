Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB7E37F735
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423067; cv=none; b=fbsqieZo8f3IIw63oG0Wb/Yq5PzQ9aCYDZpcGXtmnc1o4BkZfwS3JRoDH8CKSdGAdEL3mDPtzp+xGw5sVRJ54NtIBp8c57M2bNC8ZlLlZwrmmoNh5WFs9Gy9TjbCglOtDKAzPJN+PFq6jYG6mfAjYVgC1wxNQyZwfcexLmQaDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423067; c=relaxed/simple;
	bh=M86DqBMf8uVizZ/m2UEhAdaZAuCt/HhSBndih+XWFrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qMZQs0c2W9ZK5Ul9mrgiAwazHER97qNsfMbDgvYBgaawOn7vwrKlFzoI7dyU6Xxey10Z3iPc1BXZaQl3qh+9IW2EYYYzIQyRxglP2SnHzxKt5YrPOkPQRFA9RZ770xNBjTioDOp+CsJB5ZiI4R1MetGESQLDsO9cpBdwJTpy9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gcY2SjYz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJoF7fC1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gcY2SjYz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJoF7fC1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id CC123EC00AE;
	Fri, 17 Apr 2026 06:51:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 17 Apr 2026 06:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423063;
	 x=1776509463; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=
	gcY2SjYzTsbUS1b0ubc6S0Y4cxK+UCVa69iqnytwCt7zX3DIeWOzUyAHwIX6KdSu
	Mvlo0eJx/ElohLvdHdpEFXG9j5FhckZOGPz5lhDS5Fj6LVblaxRaKQsltfyT1Ti9
	636ooQ8KRLsZWv9YByD5Ik5gXnsH+JJaqOvxsNS6elk6J+yTPvzJayq2COTbfyqL
	ld6YXd71+xrQlErTnBuIZ9uF+Ubwi9EIo6UaCye9jpqszvXX0ckpD9n+hjPfFVXA
	tFTp0Vx1kNXzy56bgCOTWPjV4GcwKx1AYmJjB1kA664niw5MPxSFTWS2PFns4Nh7
	0www5BZ/8A/WiK/cyNDHWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423063; x=
	1776509463; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=E
	JoF7fC1ds6EOuOFh9MAVYOoiYfToLteYC+4hmFBJvM73E5Ll1MAokMuCXJJmtBb3
	KEGdY3vMI9srih1oHC7kb+9+oUbUPkf1qz9fZfLSXtu+iowBGeSfxnBJX2jBT5Ug
	sITnEhWEn3p8wbko7G4hAQWjRZN/naTJKL/VmV1P6gTwVrVPeaYIY1Aba7fLpXl4
	V8cSJXSuGCAryeULsKTl57D/3kEkcR9SLnG+XtHyARmqmwq3YdQVXp4q8N1aVs3a
	hjHbJ3rEyy0F0WSKDQRjVONJI3M0Ny08/B41GEzbEU6yaOGKKbRGmQcOmWiP8nWA
	NAAkHe//4Ww7v7DBZKuNw==
X-ME-Sender: <xms:lxDiaQKczHIPcqNB-SuHiHGRDjS8kr4rRCMdObG0P5xxShHXfvvKHg>
    <xme:lxDiaXL5TqbEipsXWSf-4ujHS35WmuWpYMtojbKDtfKGtBR8GNDPvWYdVj8EEmBy2
    Qki3THi_XoVONzWLFy2SjNP8m8qrpdWxqBrc7qlS9_fibtPLgvi>
X-ME-Received: <xmr:lxDiaVuvvgKal2aO2APymCMgTupbE4u7qQ0KSKixhbzarc82wP_Toje4uKsei0iMpI9CnVBQfjn0BdIL5hrMok8Lx3G6C32ZXuBvXJ4966SN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvght
X-ME-Proxy: <xmx:lxDiacR5wOctww9P67UiGQAQyZncWjXvQ4JLH4zQEoFt1Yny7qMatw>
    <xmx:lxDiaTMmS4BpUsRHHjM6lP9W3evoyi574YdSMVSot08EVUh0gA6eLA>
    <xmx:lxDiaZZj6-NjUBtUz8vv9A1i4byB3XzlOAu6kOH1sqVKp7zw2bRB2w>
    <xmx:lxDiaVw-5fDmN-iKeNLw4qTdNkgnIvZNSSH7M8tkxV6m-C8MwuDrrA>
    <xmx:lxDiaboeBAm4AnYk2oEAJ2shD91YMjWr28p4sdxuejP4_DwipbrH_1UR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c46262cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:48 +0200
Subject: [PATCH v4 02/12] t: prepare `test_must_fail ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-2-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

The helper function `test_must_fail ()` executes a specific Git command
that may or may not fail in a specific way. This is done by executing
the command in question and then comparing its exit code against a set
of conditions.

This works, but once we run our test suite with `set -e` we may bail out
of `test_must_fail ()` early in case the command actually fails, even
though we expect it to fail. Prepare for this change by handling the
failed case with `||`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib-functions.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index f3af10fb7e..5fd5494ef1 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1195,8 +1195,9 @@ test_must_fail () {
 		echo >&7 "test_must_fail: only 'git' is allowed: $*"
 		return 1
 	fi
-	"$@" 2>&7
-	exit_code=$?
+
+	exit_code=0; "$@" 2>&7 || exit_code=$?
+
 	if test $exit_code -eq 0 && ! list_contains "$_test_ok" success
 	then
 		echo >&4 "test_must_fail: command succeeded: $*"

-- 
2.54.0.rc2.529.gd9106f7525.dirty

