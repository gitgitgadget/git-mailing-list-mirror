Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDE248C3FF
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043271; cv=none; b=ZXZx7jvHdVD2jHtUhqW5vxwys/CZFuCKd3aFCrNpoM3RnEk4PkRsJgRBy8w7BC6cWD+udhuAdIXTp4bRTvDM2VbFbb9APpRsM/sBS4FIBCn8rUp/9EdZdIEtiQTxPAOx51sgQeFQRMbUXVs6hKXY34tX4K7L+bz6vmPPBumgnPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043271; c=relaxed/simple;
	bh=Tlb9d+AgQSJc4r+DOfOBHKvbIRKQ6KNH18omm8o9/A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Irvdso/rfu1FfEObxTdN8SakO5MCe0+clSTKS4g+u70Ui/bxc/d8tEKnRtx2LcqSH1FocjgEcl7o5ZDYqC6PeaIX2FLyY5WJiEAcN4rEL3T+l5OyDh0sqwTG9Nnc3T1gTHtGyKRnvWdytQEDAZ0lTzGESaMdjqSLbUAXR3GgSCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lqUAl5zT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OKkP8zOU; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lqUAl5zT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OKkP8zOU"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E335914000CF;
	Tue, 14 Jul 2026 11:34:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jul 2026 11:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784043268; x=1784129668; bh=wStYWigwmF
	kuASYd7x4QoG4F9pqH5Iz+aEHrLtET8kI=; b=lqUAl5zTn5OXUSaiR4ou/+Y2gS
	hvqUlv3GNDrIB+eqtdc+NSKO9zTU0SibclRc+T9RdRaOSQucQt/FSu+pCxSW2xIH
	oXjB8JCItQuuq7s78DokDD7e7rgk+v8WHvYqUZpVxoehjpAUaJyEQDYc1lii2zIG
	t8yGpPt9BeTM+e9jB1nBCeEkItpR3hfJp/ZI/xfqQ/8K2+4Tj56/W/r4jT97VKys
	nu3r0pqg18Rfmc0IY/PSjwpE13iK7GYjf2sJ1VIf5sgJt2ALs0B9MemXiiOEoa6P
	2EyWkLK9RTSTW3paywrkvCRlmOaQ7Sq108/nT9i9dL9Lyi/SvtgDkG4typsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784043268; x=1784129668; bh=wStYWigwmFkuASYd7x4QoG4F9pqH5Iz+aEH
	rLtET8kI=; b=OKkP8zOUhWdn18nBlSWPmlp/T+xt11TlIl0UmgXuRCnfuz/S1DB
	pnLVM7hOBGC2UDSophL5jGdGFPzxTPPDxIq6hU+wDQuoHUXLv3qkFVzsB+35tgI6
	SmNSUiZ9tx13Lc1GshUmOxFvNrE5hMg6yU4a9cIqeoxo7RVsoHBhLVO2JJH0/4Tv
	POVUYh65BN3hUPEQrzI9vl1LDSC/q8mni/txIuCYGSpwM0RO8W9OhZRaUvrbnx/a
	rZ/ahpSW5vswGV9y0tv5mW5bC+RGxZxa0sJoQWETqYWmU2FBYk4SrNUkeR4qHNjO
	pMaxTOeWCKVl8keOvHWQnyOiKqrBaod6Rxw==
X-ME-Sender: <xms:BFdWahAR0XXolY5OPvmsk8G5oXgCZpVD66bXQB-GfYPQ62n5R-iqpA>
    <xme:BFdWajPliZFuaJQJPwJjyXBHkn0cWKwlcAaLn8995dLlsPtAshNHYcRJd-NCkoqAG
    lZG3KKCpv5JMZeHwNlRLloze_efnsAzV7gBMFwiQWREMlaojQIs>
X-ME-Received: <xmr:BFdWambDaalu6JkP5kuDCsttz3h0xUOPayrb7Aymzbt-vFRd_759jeZ1IJ8uHWSZSyRwTswvaqRwpPjJ9ogp-vjR0glDoWVy9ene5hs>
X-ME-Proxy-Cause: dmFkZTFpgfZBE1nYwDmlhBCm1PpOWHh+yE5bfzWaeEoLl4QXbtooPd5R4Ses883HDVrrVi
    5i6dMp+a64ICJpr7lRtDJ95ppfeDLeXnYTXI/FTsrDRNVN272Wjx+DrYV+6jlBVQTDGiOU
    CZCii5tUdAf3slku6sF5/oLaVACeCki4noWIm8K3xYk4R011LMjWFcR8bWKvVbPcOeHckd
    VpphIPsrC4qEDBnZilZoVt0LjG222LnHbcY8t6/a9Rf/C3B+DpHaJGZ6ctjHZPIZnPbsSu
    H7syPtgIMqHRyF1Qdbt51meHRKoqCpPpP6oL3ltm4MLBvx5GF20eqFMg5/eOPZVnmPo4RV
    pNgxIIP2MXIg3lBSPiKwDf0zCq+6VmS0QmrnbOPq617uH1DCl/PEGWWPTC6zaFvLgdZ4eb
    9uPvJgdaHvaBLq30FVDWqB7JPM09XZ8B8YstXCQPT3Ogm+ohiF++n9wSPETQazBn6Mmpnd
    pwTMx2kWDE8oK2LDSvnRxHU0LTfT+L5E0hdsFPQti1XRHrJ2pxkeBqB8KZK5Pg+WcSjEps
    VP+o3qJDIZ87ZGAIleEU3bzDvLHrBFTNUBciks223557PoeeAAdR2UEyoOovlwMq4TAjQ6
    ky0nWOeBu1wLNd2WQF+mlwJOiX3MTIhPmcPRK/6Qa8Esh7PYQJ3BGN3YoHCw
X-ME-Proxy: <xmx:BFdWaitGi6FZ_LurBVZhNIsoQBpC-iU6gbkXD1osJBZ7cWuxayK5rw>
    <xmx:BFdWaoNRcUm8P5CIXX4EokhrJxncCnlRo5SPvgPtGMT1o9GdqmJxBg>
    <xmx:BFdWap6Fb2Jqv4i1wH0w6-CVt7ac9tNV90c9xx3h3PqH5PdYwU98ig>
    <xmx:BFdWauROOFtEYSJiv8yZ390CpXW2H4C2XNal3f6lKKia2mPx3O2_IQ>
    <xmx:BFdWamnXG1FXYUx_Cb2YBWaJcCpF2K8TXhMrPvivv_WEUrF6mfeit17d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 11:34:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  Glen
 Choo <glencbz@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 2/2] fetch: add fetch.submoduleErrors to make
 submodule fetch errors non-fatal
In-Reply-To: <20260714132959.3368867-3-paulius.zaleckas@gmail.com> (Paulius
	Zaleckas's message of "Tue, 14 Jul 2026 16:29:57 +0300")
References: <20260710122655.3066377-1-paulius.zaleckas@gmail.com>
	<20260714132959.3368867-1-paulius.zaleckas@gmail.com>
	<20260714132959.3368867-3-paulius.zaleckas@gmail.com>
Date: Tue, 14 Jul 2026 08:34:26 -0700
Message-ID: <xmqqldbdvb3x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paulius Zaleckas <paulius.zaleckas@gmail.com> writes:

>  t/t5526-fetch-submodules.sh      | 89 ++++++++++++++++++++++++++++++++
>  6 files changed, 168 insertions(+), 4 deletions(-)

In addition to what was pointed out by Ramsay in his squashable
patch <387a34d5-fdf5-4513-9aaf-4e73d9304c1d@ramsayjones.plus.com>
this round adds another use of raw grep that is caught by the test
framework.

commit 8f7761ee72b3669c1aee98142852437d016c785c
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Jul 14 08:31:57 2026 -0700

    fixup! fetch: add fetch.submoduleErrors to make submodule fetch errors non-fatal

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 614d45ab71..19d17440cf 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -1408,7 +1408,7 @@ test_expect_success '--submodule-errors=fail overrides warn config for fetch --a
 	git -C env_override/clone config fetch.submoduleErrors warn &&
 	test_must_fail git -C env_override/clone fetch --all --recurse-submodules \
 		--submodule-errors=fail 2>err &&
-	grep "Errors during submodule fetch" err
+	test_grep "Errors during submodule fetch" err
 '
 
 test_expect_success 'fetch.submoduleErrors=warn: inaccessible submodule is non-fatal' '
