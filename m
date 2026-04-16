Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98518050
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338374; cv=none; b=RAdcP8UnjuOoedoJlNW/4GC4v85aenYHmhHXdKjr8PVw3NQ7gVDLkhUV5L9tLO9fgqKQPN0kp190xrIopdGXnSE7yepHf6b1cv+ijpR7GABYC6aIL4C3Tyf414yVIGXM7qQGSuBsxbZTcKO4v/OeowmaJywkrKK39vsxNKmhRzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338374; c=relaxed/simple;
	bh=M86DqBMf8uVizZ/m2UEhAdaZAuCt/HhSBndih+XWFrA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdX6tMI1YNL4gzEjRYxDuqhAIh9sBmtyotGZBWEwLfQbPixivdTQMlGrTuyu1LdLEtxvfl6GTmWAYQy11hC6ixHVpQ0B+xp1usbvZnRqTEvd56YLPsN66s38rjPuEwdBlDlrJKi5FG3F44duPKUKHrb9UN2JWeQoXBHVnxeCZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rDFAdeJJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLmuPgBq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rDFAdeJJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLmuPgBq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id A79231D00246;
	Thu, 16 Apr 2026 07:19:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 16 Apr 2026 07:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338372;
	 x=1776424772; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=
	rDFAdeJJVl+pL9Zf/y5vA3zUzEmizk5Msq4ssi+pj4wmcHKAhPmDjIHuq06cL1yC
	P2cYA7AM1Od1FkdfREKCSkzfwttx6UjQjiCrvT6NcplyQ+47PFr5RWNal4/HIAiI
	nRsD3da4AyYUw0YkSDCBVnHmBQ6fJE9VRPTLNYDIrlnuDrq6pj6zFa3cHCO2WW82
	optn7BnksRe8o718ipFbBqQUFIsi24Y1cMe3/94uWryFGBtfG3gW0wLj2W4K9j2l
	kTUR2+iobWPbwTs2ejJTR6KQYrc226O6e/iTECZ0XA+dSFOjlcd0/cce123TchYy
	+DMNhBpgSTRTuHYN5pRXOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338372; x=
	1776424772; bh=T6sX7uQ1AtNiPCB02afxWPBmrUQ2j9xv41uy9ejsvLs=; b=S
	LmuPgBqxzIqe9ZP2vfcbSMpgHRPs/UCNMUTmkusc/ALcn5bTrakEDrlT/dT3SdEs
	Gv+Ti+vgsvEm8s73ce3Kff7MwLjCSsQe6Y9fCWsOBmpRl+dDP4HPofEvfXYRGK9G
	5w+KH0WBNt3sE1p3tWPTmFIjx+Ofp+mYkVhdRr2i2s4y1XtuY7hRkseZqMAMDM0r
	owvXog4FfP4l5i5GZtnN9JdJw75d+B/ostdpnG/5kECHNoCuP59smnyLSql1mROp
	nB1sh2pKcN3Bqt4PKhkQW9nF2Fp+cMp2cq5IsjMo3LAx3B7SU4b+DzU8VSsRLOXb
	arMauHhA3bakToLZxpZtw==
X-ME-Sender: <xms:xMXgaV-oRclCFt1DH8-8Zhu5ITKUuL6oiZHuR6hJh0wmT5NAUMMp-g>
    <xme:xMXgaRICVJO6cymccI7VrMKwWX9FLEUoYLbwx9jmWKKG8E4cmATRR1uT6W9uX-2hr
    _5RaYgqn5vvrRHwmIxZDD3RwESggcsmeKWf8eSWFiXLVCZ-2SJjrpM>
X-ME-Received: <xmr:xMXgaQYWt-2bGlELOWT9N8QRhkQ_kDWM5TyDuQJaq5a1psQZ6LVDMWJIGhnyKVuFo_IK_j9XaS6ZdIqXPuW83w0DgwPN7orXeAn8T6BBzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:xMXgaTJIEB_Nu2Mw-ayD1EX4sKmfjWu_bG3GKljP2HHavXIyI1gwIg>
    <xmx:xMXgaeAkRS8eCRMJxCStOe2_XDSR0_esaE4aHKq9KImjsX06Hex4Iw>
    <xmx:xMXgaYp0o4g8FF0tpARWc5xaqn3MnwMYDxDpzFmp4KgxadlGZNI6mw>
    <xmx:xMXgaZikV5HkUDExNUsbZnMRrVCtKTb2VKrNzM3xTyjlNxJ9PdrBlg>
    <xmx:xMXgaZ7DP8D9T4xfGP8pNsMq7thnudnk9AhuN6CGMazJ6FS1fp395wvJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad4e8af9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:19 +0200
Subject: [PATCH v3 02/12] t: prepare `test_must_fail ()` for `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-2-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
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

