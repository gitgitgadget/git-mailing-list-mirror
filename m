Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD6248A2D5
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 12:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993679; cv=none; b=jMmX5YgFm3hmPIZr8U4hwmSumwXtmxwqBIQbYm/HfAyBZGTw29ro0m5EnFiuZOlssMW+1CrFlDrToMIz++UzeD+xjv0y+aRBfEInvdP7wEu4+hMh+HwkeuoBhIC5zV3SQcnlDbecW470obJob7TqaSox0z+Rhz7Iw4jP6L3R1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993679; c=relaxed/simple;
	bh=6a3wUNrBkO6Hw8O6fDvTXdoI/ukuRTPogEDb7gI/nwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UOmN3Kj8oMe8M7qLDVxCrn20J/lGybkSM/zdT13nILYhxEQZo8us8+5vxe1fKka2mbk1uz019CQLECyjnmveb4mMEUPhcXAOpiSNZjAM0hwFVLIxYBF5LlXe3LBJesEKtMXHdrKqpFjYa3yxXZXZKilkwN3Km13M3e2FU3rrO4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X1bfbsEl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QY4Wkzgn; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X1bfbsEl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QY4Wkzgn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 84F271D000AB;
	Thu,  2 Jul 2026 08:01:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 08:01:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1782993677;
	 x=1783080077; bh=o/1qyf0sGQb1cpD0oKHhzoAeblw4z25zbhG3BaJw+jQ=; b=
	X1bfbsElU6XbcUfj9sAGr4rVzTZ76xpcfhp9QbvoCTBxyCYVVEBg7F/3r8yVJGMc
	kHOmWYA9RDlmdwuBbkfP9qVrjYKnhYaSSqciCB3Hix9O74QxJhU6ixs8oiI04q+b
	C1kpXhiIA+d9D/cT9UvpqMatfUXeNgncccKgdColaFCOcuUuZHsiEidyYvDj4E/8
	UTCew4CEQy0LbmvshxZVJCPbP1J8iuYeLG1/IBQoQtwt2rwyFz5SNvhAZnBlqLeg
	fOhBnblvLumzaJAMlVVuNeuvbNdpxPlCqSD+KtMmJavqDrLVp2sVo65yfAH74nGv
	JirsV7qQQqtqyGAkeTY7xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1782993677; x=
	1783080077; bh=o/1qyf0sGQb1cpD0oKHhzoAeblw4z25zbhG3BaJw+jQ=; b=Q
	Y4WkzgnZEJZSu4Cpq+IaLq9yz640/09YW4JZyS4Q/4pK16PTnCAy/oOLpGy+VKXp
	ig2QHTXznjJjsJzo58LnU1Q6p6n3fgQOrd/JX3H+0NhGkttup27DR7ZaD6zzcIbx
	/Kjweb5kwMYmbB4QJBQNFxKmeMPSqe8eaHb3utAOQRG0QRnr4PWg3qAzrWxllN/6
	hWUGWFrb/qQ7O6LIXlcFg6xcu7bCfAWBZKJBwqpuQSKMcGonVzAIABztX+w1vsHC
	hoAo6im28o0jJzmFZWmCF9LUAsFy20XPFYDX5cIgD5JhHFrc4Die8CsevX8OICKR
	HpAazvlEStPjUNupAYsnA==
X-ME-Sender: <xms:DVNGalqGoLOTMrq-ErLZFkYh3p1iApblLD4Js7JPwON9wx3F-HPWyQ>
    <xme:DVNGavEH2EzQVA2I92LpvbwkCmplt-LtYK9QQ4ZNlZK_noTYnlMKfUYQjG05hp9SM
    d2r5kflYIaok0JOHUcx5ZRT5I3RMuDO2ERymO6XOZisJbK4vXikxX8>
X-ME-Received: <xmr:DVNGavnvx1MB9D90StmVjSOODIH2-6yZSFB92FPHGBOdmV_ZDV6rs8m9P2ggBO0qyyUbG-rsZBAWG1U27QHK3r7tUBj5od9x9If22sDVZCuoig>
X-ME-Proxy-Cause: dmFkZTFsfeg47pLyJVh+MJCy0rSB+TH7HazKVe5gTjlZ9gCth6IsyEccbKvNWA45L+68n/
    BUJYDW0wyVqb8e98CcrnUplq3uYAkp4yLoeEN3QOYezDy8qHZJS5llCwxliJJYLjD8+2rU
    vGYXMACIgORGpxAXAfUrAPKXIN1YCFo3usZV65lQWeyqHFnaBiWXrMSLwnxObjbi944TTs
    Pe4Tl5/p6CYBVCvKaNN9pukZ3slG1X/28Pf51xd7ZjsHrY2FAweIVhugOSfKNLWxBmbw4b
    nGYOTbsG2d8KfEyYwiAYI8ncVC26Q7gZcl6HxLw4UR9RDpo7XDCIhWKkA/feygZ5aDQUUp
    rubjE6OQUiNS/1SfPuTvH8S6GAEygPiGEom4x6TCpjtNjHq1xIMSpjkdnmCYH/J1irzict
    OZPVy37yAevNFcPLpFiXQSckhCvTgj6AaaQ9qQMFVOmfselefHbdfFk5c2iDAECqNemtcN
    Qsn9cjAcWl6Ja5LAlJDmmLPZMZUr2wlBq64WeLqGl/i7NiWSRHVX41VDzS/TXIqMa4dMTU
    YHZihUdgL5J9GA+gKBpp5B4TqD4zg0i5tWRLDcIYof3dvcu/GtIrR14pGDvJYcbh5vmUKN
    iIZ94py53zenN4yCSgwVUzJtyEwS/wCnCheaZz47PamnrHwiG96hBD+WeFKw
X-ME-Proxy: <xmx:DVNGaqlmEV7ijbFBNDt3on0VwYKcbaakX74lnVvpwEYjF9JHkrTvmw>
    <xmx:DVNGaosH0ktkQB8zsG43Uv86Ct35DF8YKKSyMz7Sw7DEDRMV0vhTPg>
    <xmx:DVNGalmZ6YO9HgSRUc9771OqSy28GnYIzuM7HWfEGwly-OQd1Z6e8g>
    <xmx:DVNGartKGwR57XKq8sVIQKYw3B2xEQNfgabBwqff1bE3kAuDNQtQDw>
    <xmx:DVNGalr6fupS35gl9i8LKv4k05DLhR3ncnM0sUuu1XKcyni4yZqvu7IO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 08:01:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 81306f5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Jul 2026 12:01:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Jul 2026 14:00:58 +0200
Subject: [PATCH 5/9] t7508: skip EXPENSIVE test that is broken without
 SIZE_T_IS_32BIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-5-76b4d7bab3d0@pks.im>
References: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
In-Reply-To: <20260702-b4-pks-t-fixes-for-GIT-TEST-LONG-v1-0-76b4d7bab3d0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

One of the tests in t7508 is marked as EXPENSIVE because it ends up
creating and adding files that are multiple gigabytes in size. This
takes a while to complete, hence the EXPENSIVE prerequisite.

Besides being expensive though the test can only work on systems where
`size_t` is at least 64 bit. This is because one of the created files
is larger than 4GB, and because Git tracks object size via `size_t` it
will eventually blow up.

This test has also been blowing up in the "linux32" CI job in GitHub
Workflows since 7a094d68a2 (ci: run expensive tests on push builds to
integration branches, 2026-05-08). But that job doesn't only fail, it
also hangs, and that has been concealing the failure.

Fix the issue by marking the test as requiring 64 bit `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index c2057bc94c..dfdd78b6fe 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1773,7 +1773,7 @@ test_expect_success 'slow status advice when core.untrackedCache true, and fsmon
 	)
 '
 
-test_expect_success EXPENSIVE 'status does not re-read unchanged 4 or 8 GiB file' '
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT 'status does not re-read unchanged 4 or 8 GiB file' '
 	(
 		mkdir large-file &&
 		cd large-file &&

-- 
2.55.0.795.g602f6c329a.dirty

