Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AA3AF64E
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780567676; cv=none; b=UZO32S0+DNp8cIoPdXQUd5Lafs9XBp2J3cbQclVqLJHVmsPjTSN3sCKwGUmKHSVtpogHQGw956T7RYWZlqIeqR78Hx0MRzkuzay+57oBOrkkddDQp43FOChCQbXcL2eE9EDom4lT16/sKlcjqFIVeTkGyBeAyNyJsDzqfcGqG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780567676; c=relaxed/simple;
	bh=7IRyQsElUpfWeCShIAnp7rpNMP92OwY7P0BtA9mLwA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPoUF6Iy0bP29LMpdGV0qxb/Usp2qZMj+iTeplzlCnhfZxM3Puc53eG8tLvdgEAvnG+ZrXAXipk0YVtbq6NJBhIbGhoZJnz3AXbTg1HgElbSALd70Scwu6xARUjXtnN99f0C3EgVf4zYT6X+trwuB6Lv6cZo14ynBTgXnOVLRfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=swBaN5OD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnR4S0Np; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="swBaN5OD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnR4S0Np"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6A35914000FC;
	Thu,  4 Jun 2026 06:07:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 06:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780567672;
	 x=1780654072; bh=xyxM2r/QLJOPpD918GEsmHm34QgUdABliGQqbtQP/IA=; b=
	swBaN5ODZ/3Tw6ThAg2Va/r/QNUIpvbFvTsssHkklQYJ5sgSjxvhzlwLe2USKRy8
	zKBwsVa6LRfFRcWGW7GTTyFi30nk11kvL8SgzztsHlltFU3zmRCcrDSeQRBsRrk4
	aXqL55x4HLLj8sF8KPhrlUPGj6D6ge1iq+Vkq0ZK6vtA+35c4qiPwjME9gRlLDrV
	rQcV1vk9PooFRyKL+p7OyFF8vWviLNfsjxzf7+KyREl/nwAloeboDyr22h1F8gc7
	mEqAmTP7j+Qix3BXZSK3n4ia5P4V2lVP2E0vm66n/gVT37C/Vd7Vn+J3kC1fGhk+
	dSAeHSDk53F2U/BX5iLg+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780567672; x=
	1780654072; bh=xyxM2r/QLJOPpD918GEsmHm34QgUdABliGQqbtQP/IA=; b=G
	nR4S0NpBYz8ZZx2FURH6VH17+1/YHqXq6Nr8qGEF4/0n2Vph0isoVEzf/iGtv6PC
	QA5mxl0XbsUDNXMsdQjKEHjpnDFu9VNgrtHOAORe332ULnE7gyXU2OcSSFFiqTE/
	+XRAVw2eSrbUe/KD4Hb/01VYb46z5uuNGQInkeo2nhvHEcmolzQY0CJwvdXxedEi
	Nxx0qdVwcmRZ40qrlQQCS3TP5julo1tWQITXufzgzRszlV2MI1JgYOPy+lWtxCsc
	HhWZNPdW70UtmW1OsauPRKhf14RxsazUWVV5+3NjjOx3nWngLDfbOnqRMYpWboc6
	nnRtWndl8vktun5JkT73w==
X-ME-Sender: <xms:eE4haraFreWxh3ucng1S7qHYMvvN_Lj4kzNSEA8BBnqdqFnmt5yarA>
    <xme:eE4hatp6Sf1Ia0zb98_uHDIGiJ4Bw-_1_XGH3C0qPX8F4Krsw__3nTP29oo3-pRXR
    7qH_5pP32x7cbh3B7J2i9g29PzBDBzn1wtu1crg9jP5I_XeAnahjA>
X-ME-Received: <xmr:eE4hanauaxKINut07FZUjyT3xqzyMhtXyHh2-Alh4QzcfoDk2-jPug2rlWkgY7IiVDFjxv4mQEWPbmghk398ha1yFIA7fbN_ANxgvLdHb8c>
X-ME-Proxy-Cause: dmFkZTGMbu7/w/ZaywpulTbV6q029k+4CRvBefE38zDB+oDDpe7/ZuzFboKkGddDMpC6H8
    Q65cMH2hqNVIApiwywAi1d3oCMuupua5C6XrHnnITffKfmMRVwTdI5GHkudmJ7ZKEZrrYX
    CKOmv9t1NwRbtoOICGlQGTcGJ1FFYgaEdOYRqLfZqhIlP1ZWNMKv3dVVS2jOfp6CH85ck+
    X+GJZjSuAt4gnXgZR2jlgA8pvi0autxCCmFsaQ4hwO4cz1AmajGgQcBQ3nWLBS5d6EXh4c
    RYSw2h7nb13kcCW4tZMqTZU+tBdbJ81eaW33xVcSzp0LPE+7+IuXs8Di5knqCnrNht8gSd
    9Cw43u2syeGV+Rr7AtLy3dNIyxUevf95yeIn0eF6PqrSpvPDbo9sIbt6L5TUPhMgZdrddL
    8KuKv7zzeaWbtcFQciplOyWBJISVPiRcmerdlNraeSGk7UvLSLx29zdXs2mi6Ux84XTR7i
    VPbz9AYbEcaU2hZESfufRVB8KYyNwx0zrL45NgiAJsfvNcuNVQZ/jeQlIfyBgYZTGtgqKe
    u13zvqrqI7R+JGvSJsusgffmcq7W4QvE/bLtYKIK4Sha5KpSiQ1qNWyLCKAFmhAzYQizF3
    B3f2uyGdVBPQFLPVLz9zWK5VcR8Y/Kb8EPd4K+3PlNqaMYJ0+G8J32XQZfeg
X-ME-Proxy: <xmx:eE4hatTHwCn7gVqc_Uehs5EbglGRzinlVEPmoSkOKrnYqFj-P2FJ8w>
    <xmx:eE4ham4OnxTvuI5quoG_-hT2VHzlurbGIbWGcteDgJTc-ivJyeiBNQ>
    <xmx:eE4haqwC680N_F6Sh4zpWMRJZOgTcOzmFtaYh49Ef4O_BI-SOUCr4Q>
    <xmx:eE4hatRrNdMPj487tTWPlK-NaJmgUQlg9wGa2VGtjOrW5sSRGsbdZg>
    <xmx:eE4hatsfNKCdPrGzL_v3CLdBViBADIldzdYhaFKvi7o_JznZSN7l79QP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 06:07:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eb990782 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Jun 2026 10:07:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Jun 2026 12:07:36 +0200
Subject: [PATCH v3 6/8] t/test-lib: silence EBUSY errors on Windows during
 test cleanup
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-pks-t7527-fix-tap-output-v3-6-7d766ed481e4@pks.im>
References: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
In-Reply-To: <20260604-pks-t7527-fix-tap-output-v3-0-7d766ed481e4@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
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

