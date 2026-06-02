Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2193C8723
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390485; cv=none; b=HxMARtHeBO9q51lK5S4j69tYg4PbxIyU5ocwhCKstQ/HN21w4+hM1KRikcyHAQq8iCI3Cm29QPDygUyVRSX4zZCeYuVghPlONjYQ4ArRGn2MUKCzv33jCbFObKT+sfo/FHHG+2D3kVXA1E+n/R1xuewXqILGJjNEMFZG3JONgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390485; c=relaxed/simple;
	bh=ragQ5MnMNvs9g3OWzWS20ZN18/4KX71oBLEpRU0Zrv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gA0uxY3zNext78NOQRkorzz49eGa4iYsgbu90/4Aq7eohkMhDPbaCErobQG53DEMhoYsOu3giv0cLu9PO1g11V3UpEoThe+Yq9KJDNUjnrBSnWdnUwatzvjjYoRkgLiGjtf1zViB/1EgsT/xVOqGg7sNRgWpj2+bFwAyFRGSUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Li4kHy+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HQOE8TLd; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Li4kHy+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HQOE8TLd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 348AA1D000DC
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 04:54:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 02 Jun 2026 04:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780390479;
	 x=1780476879; bh=cH6qWVciwqoifPPPEPP0Zni9zrlrVgj+JSKDuEzmAok=; b=
	Li4kHy+PHuYNZu+sigo86bk2DvjJgllXKoPZim5MYmWh/0xojr4q3wqQvfC81QkE
	PonyJwmThmM7kLrWn25gBIMtTBykbWNBZUFBplLQ2aIkJ0ra5zFXr8hxs2IdR+RA
	MIFvJad/OlKaedSG7ovp4wBU/ISBm8ETu5igqlBubxbTt3P6Fb89/GaPs83wlIBl
	iGyDsGnW1vVEfRtdL798yIiJ8ri+J3UQodwwJahGKroGrpXeOzFA+mOuAsYRHDpS
	GPWvIzSdZ/W0QaSTIkz3p5KdNLSzNLElBCMKKdWOV6HL7dwmnzuo83gyyBifSXIL
	XuiB+Svd4Hxizi1m3iH/PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780390479; x=
	1780476879; bh=cH6qWVciwqoifPPPEPP0Zni9zrlrVgj+JSKDuEzmAok=; b=H
	QOE8TLdWgOARkykbYEem5yYER5v7Z4zKvjL87TU8qDiWzVdaUfVwXDyY2+Hznyue
	ZA9HvJ2xoYHVfD4tpnClQGiL0LnazfXAEcWuUG55LSc6NBoaiNq5mCHT7ykuDVMg
	n/rr2xMmyCUna5Cx/HsJ2tmgH4sYKh753EmAgMMcuz81ihPlAP2UagVTnzpWkcSy
	d3Cb84J3FI0rDZnuwHjKcFAZSFT/la4EaUovleQMuJ4j6UkjvlhUeXixk7JnGMUk
	ChpFMR3BDD3Jb51j603hgpTcR+cRRh+eEXcR8+BWkXD2eFos3/d4USukrWOdffna
	HUXaH0VvZcO4kdmfkYgKg==
X-ME-Sender: <xms:TpoeaoerdhLablA0x5L_B9XSiYt4Msxi3CkfB7wjxJcQId4Nx56JmA>
    <xme:TpoeahJntlMvmrP3HtHHkQ3baaYwZM9rY343pAhsLGGSdhzgeNHiqBKkWmS3B4Odg
    RVmEFsQlto7ecMaiKUwG4fevnuzDNP0-7FNUzUciRqoXgvF8tWwZw>
X-ME-Received: <xmr:TpoeavJ5_qH8UnaHwCemYaVQty6HqMQS0038p5rQ9HwccGFxCqyhcqj56mZszWrm8O8sCKdDGMtvdXsy1vOzsO5ZhfHX7Ft_x-dJlUc7Xw>
X-ME-Proxy-Cause: dmFkZTFdQn6gsMGq1HJIsMmjFp22ncYSmQVrk8WevwfvWUwjkYP+l0EtrHNsIg01q1ff3X
    E37NE+m178xRjRu99NbLGz5MKMtaeaBs0B6mKzawuRb7yJdBfg6fuvPHSMkn4rlU//Udo7
    lp8Srj327b7nCrzI49ha0BbdGXquGgzds4UZi+QZU8nhaYv6aKiW+qweISXTpOIR99SLYl
    6bkP5qdcDHEc7UjwNeTj0JN7845FSnbKTMtYI5JP2PexlEAE6vNqXu8B60KWNaxxE/knyZ
    poiJyneUoC1Polw3xchqoNSCAebhWyxVCiDQRc09BAQYa6idF5WLfL3AFIUPsQVHQuBNrg
    CA3j8hfPLzULxAg7hRMVIRiQudwnXA8fJ7wMBVxYKnU2PlsiD2+cbgvCowFYj/THM6nT1g
    rPEpPZ76Vlyl6Tw0vdl3tiegHY5OYwH3+UA64kGlSafaukdUdOQEQ5S3TNHLkTXFGovuO9
    6/HxOZyaphrCRj4niANwL9Rp3G2UD5i408bb+xMtSQ1x9Zg3+KEfPjEW99XZPCdYHnjTJJ
    dI6tFB1uSCOk3KsbqQYojkp1OWFPfaixzldW0Hf7hkdVV9e4UfYbquu74X3xbIdKeEVpNe
    BzRarUrWFqqjs2cFuMlxeit6RGKWRw7j6ap0BNYyo9B16TOu0Y2tQwPCROyQ
X-ME-Proxy: <xmx:TpoeajHZdkronmQdtQImUOWJmunsULHxI8lxNyNEopDWUHu_gP7DWg>
    <xmx:T5oeakl1DdRLNbF_3YPz9IOXEslaCRCXOXZTxSH_5QGLK6srtecaaw>
    <xmx:T5oeagJzEZCYk0buYq6w7pmTOepoOnxhUYnqyR_sOe36-9KEAZhLJg>
    <xmx:T5oealbNmNV3e71dDoCWxkCnXm3918jQwkzbiFjW5KOIdB1-Hn0k7Q>
    <xmx:T5oeauPWBwJdTl1umta98-NJ5vVkXSSJ0MOYFswPuIbMFuM_nF7RI68c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Jun 2026 04:54:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 93f9646b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Jun 2026 08:54:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 02 Jun 2026 10:54:29 +0200
Subject: [PATCH 3/4] t/lib-git-p4: silence output when killing p4d and its
 watchdog
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-pks-t7527-fix-tap-output-v1-3-db3da2a1b137@pks.im>
References: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
In-Reply-To: <20260602-pks-t7527-fix-tap-output-v1-0-db3da2a1b137@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When stopping the p4d watchdog process via "kill -9", the shell may
print a job-control notification like:

  ./test-lib.sh: line 1269: 57960 Killed: 9               while true; do
      if test $nr_tries_left -eq 0; then
          kill -9 $p4d_pid; exit 1;
      fi; sleep 1; nr_tries_left=$(($nr_tries_left - 1));
  done 2> /dev/null 4>&2  (wd: ~)

This message is printed asynchronously by the shell when it reaps the
process. While harmless right now, this will cause breakage once we
enable strict parsing of the TAP protocol in a subsequent commit.

Fix this by using `wait` so that we can synchronously reap the watchdog
process and swallow the diagnostic.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-git-p4.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index d22e9c684a..0afa5111ab 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -65,6 +65,7 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"
 
 stop_p4d_and_watchdog () {
 	kill -9 $p4d_pid $watchdog_pid
+	wait $p4d $watchdog_pid 2>/dev/null
 }
 
 # git p4 submit generates a temp file, which will
@@ -175,7 +176,7 @@ retry_until_success () {
 
 stop_and_cleanup_p4d () {
 	kill -9 $p4d_pid $watchdog_pid
-	wait $p4d_pid
+	wait $p4d_pid $watchdog_pid 2>/dev/null
 	rm -rf "$db" "$cli" "$pidfile"
 }
 

-- 
2.54.0.1064.gd145956f57.dirty

