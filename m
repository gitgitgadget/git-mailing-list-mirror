Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E60A3C8719
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390483; cv=none; b=Lg0uydzJ4eZcC4+MSKZ18SFNEhYjsEatoV5EtzzSyjpoaUZvl9/jWjBDT8q1j5NVvTLo7f0GhclVsDez4s8XTPrzizjgaEZTdjQ44EwqtJb85EFFi6FPqi2jeYNuRfyD02hcvTrVbW/7aOIQeWwl4xQklbLdCvd0SKbcqEOg/1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390483; c=relaxed/simple;
	bh=7IRyQsElUpfWeCShIAnp7rpNMP92OwY7P0BtA9mLwA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZKIBSt4ivFPMnAnuHrLMJMyM4RguJzn468TXGZ1WounNwLSY5xsTCVEKEZdY6Uvlm/gqkhZVu9GhlbS/VUTjWfjykr/xBqqvH2nyd/r40fM67l/nw4WXUJGExkWU0htWSdGZ3YZHlMswlX6B4OJ+YmS60UFkLy8fpCOTucBe2HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gFFXG3ru; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5SXWLqH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gFFXG3ru";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5SXWLqH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 444B91D000FA
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 04:54:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 04:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780390477;
	 x=1780476877; bh=xyxM2r/QLJOPpD918GEsmHm34QgUdABliGQqbtQP/IA=; b=
	gFFXG3rubWfuj3neeBVo47unN8iVvVQQs7/z1ALy9XaD9+SzcvEgn94UQCLn4s7W
	HLuhokadSGBsS+N1OCoyEOhOAlm5X4Wfri+X/rwO1QEIvG9aVKGIQMU3IJejJVAR
	D9D+fXZRG7ULU+hS/cMNDXOB8BD07LFBsgIC9RSel5ATqA4ZEPJkBIQQzb50Yd5I
	P7gwKb6gysPzRqOCI6QpS2nC9g3T5ZUevKXXau8inV4VnjxeOZ+6/eMUA2g+Ina8
	VlAGRxa6lew/USacJk7URAKV0zGpfSmrLCIYaxh38GdCthvlVUZ5z7aQ6kpc2aw5
	/9q5JB6v/+awdtoe/Mm7fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780390477; x=
	1780476877; bh=xyxM2r/QLJOPpD918GEsmHm34QgUdABliGQqbtQP/IA=; b=B
	5SXWLqH5JubD7+QuCMYnWmqn9Y8iBb4Tizdkrx4JvxxMAyDaIf+bqkvq8WSViw4i
	V1p8e7jo9GYwV7AalsU1o450aSVJKZmlt61FfVq/RSkwfnQ6QPfcQZMrIkQMTgnI
	KF80bP0eYrSf5L9vw9OHg6Qnb8Za9EVN5w/bb+bMSrPpZbzW3TYcO9bMa+1QfLDC
	gB14fkD8hL6lPvVEt5Vxgk8UW0Qvs0uXgOTT4bKIwj/OZRYyG+X5fStx6QMdIGvk
	r2d4LE0hHqOHQxOQj09ztyOtKVuUI14BXZuUw1Rntv4Cb7rJx0rGSlnqUyau94J8
	jc7/ucUSvZlI/LBBno0gg==
X-ME-Sender: <xms:TZoeajr0fQTsy2_A6Far_kO8bpMR9LCrY2BroyBtFZeCszOjxTOrLA>
    <xme:TZoeakktJSvop1WcOyKQnW6rbmXZOekJfrMJDxeWKezFg2RyowysyddJOK7pgjNBD
    mm7SMR5pFI3iwYP1aUwaAf26zmpz4MJoqUJFl5y71THkKNQHD9mrg>
X-ME-Received: <xmr:TZoeal1J8k5ceL8dlm1pVo5t_GzuBFU_kSWRysUXSjk0iu6GKOAdbnM_nssM0AI6HD6HNGdHWiQP9kwUUcN_oqz0n0iBVv80SfO3g7bm4w>
X-ME-Proxy-Cause: dmFkZTFdQn6gsMGq1HJIsMmjFp22ncYSmQVrk8WevwfvWUwjkYP+l0EtrHNsIg01q1ff3X
    E37NE+m178xRjRu99NbLGz5MKMtaeaBs0B6mKzawuRb7yJdBfg6fuvPHSMkn4rlU//Udo7
    lp8Srj327b7nCrzI49ha0BbdGXquGgzds4UZi+QZU8nhaYv6aKiW+qweISXTpOIR99SLYl
    6bkP5qdcDHEc7UjwNeTj0JN7845FSnbKTMtYI5JP2PexlEAE6vNqXu8B60KWNaxxE/knyZ
    poiJyneUoC1Polw3xchqoNSCAebhWyxVCiDQRc09BAQYa6idF5WLfL3AFIUPsQVHQuBNH5
    6WEVg9rjyfjjRayeGwmLTz96/7yaDDNAYshZ144TIrJKOM4Hs5QgFhbyOgPGpF8reH6Hpm
    EVmNAVJJhGOS38NUjbYPMqemqd+woL0oiijbbfCZGoZJILZPBrZ9fVp4gsNZY2cT4FKE92
    90JTJbd7RoBm4U2aTCMa/8jajms6cTI0QVINoFUiAOVIh8yfWuLkOYeZsP3Eq+lEsLC13o
    HtxtrQK2gPRypE89ncKXlNJYsHngeOSyPAg6X3V8JV8DKnkiPSLR81393/tbTmjP6qVUIw
    QGe05sMKsxtu4koNT0qjCljCk1Fpv99plnztkvfkn0CLcfo2d3vTqmcpHtlg
X-ME-Proxy: <xmx:TZoeasBLRPsGYPnUlYPJj1s-bzilh1rP1EO_KptBKzm2qrp-O5c-pg>
    <xmx:TZoeaiy2R05GzjeETBYYudJEcXlynrXC2Tm89gw6LwoJzYj3tNwFzw>
    <xmx:TZoeaqkFb5wFkjDP-KfKB2axhgnHQsQpHo8yZ4DudOLsSfjRQS0IOw>
    <xmx:TZoeanFIJi_PHTW2klC8GfZuDmL9R_CtCGBPz1ScXiUO4JSW_0gKJw>
    <xmx:TZoeajIL4wm4bZo4omROPMVJhvTfoldZzAxOak6yHWOvPgWMiPrEiOGa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Jun 2026 04:54:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 09fa799d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Jun 2026 08:54:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Jun 2026 10:54:28 +0200
Subject: [PATCH 2/4] t/test-lib: silence EBUSY errors on Windows during
 test cleanup
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pks-t7527-fix-tap-output-v1-2-db3da2a1b137@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When tests have finished we clean up the trash directory via `rm -rf`.
On Windows this can fail with EBUSY in cases where a process still holds
some of the files open, for example when we have spawned a daemonized
process that wasn't properly terminated. We thus retry several times,
but every failure will result in error messages being printed, and that
in turn breaks the TAP output format.

One such case where this is causing issues is in t921x, which contains
tests related to Scalar. Some tests spawn the fsmonitor daemon, and we
never properly terminate it.

The obvious fix would be to ensure that we never leak any processes, but
that gets ugly fast. Instead, let's work around the issue by silencing
error messages printed by the `rm -rf` calls. We already know to print
an error when the retry loop fails, so we don't loose much.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4a7357b547..d1d24c4124 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1299,10 +1299,10 @@ test_done () {
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
 			cd "$TRASH_DIRECTORY/.." &&
-			rm -fr "$TRASH_DIRECTORY" || {
+			rm -fr "$TRASH_DIRECTORY" 2>/dev/null || {
 				# try again in a bit
 				sleep 5;
-				rm -fr "$TRASH_DIRECTORY"
+				rm -fr "$TRASH_DIRECTORY" 2>/dev/null
 			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi

-- 
2.54.0.1064.gd145956f57.dirty

