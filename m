Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8738CFFE
	for <git@vger.kernel.org>; Wed,  3 Jun 2026 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465203; cv=none; b=UB3ymFvyS/7aACSyzKgXNS951DiGbIrKDJeqlcXfWbSOQYTUQaDX1ChTRx9jfJJTB2hVHz5ob2+BO0I+Tad5S06pAyexEZ8w2aZeaBAqZmJjTMv+MlSKI+/gO8TbDw6hX908vfQN4qyEiMjYZ93mpVQ0jIMp//amBfN2lOJQqZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465203; c=relaxed/simple;
	bh=7IRyQsElUpfWeCShIAnp7rpNMP92OwY7P0BtA9mLwA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AMn3/sz1AnxDNOJlE52SPXGn8aCzb3MBLU9wOtZIAC+8sQ5HCv/dpkzzX7PN4Uz68/+LBiTEa/8r98AtTwcYFu+E1qgsMTZann+GjPxCgN+Ks8f0PDe9nHykaMzTPWMYn9cxz4LtdEu4E3+tbspqdcEpZREl1IhRKaVRWw9xH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZWEJ5In; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q39Hlxsx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZWEJ5In";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q39Hlxsx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 301A81D0010B;
	Wed,  3 Jun 2026 01:40:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 03 Jun 2026 01:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780465201;
	 x=1780551601; bh=xyxM2r/QLJOPpD918GEsmHm34QgUdABliGQqbtQP/IA=; b=
	TZWEJ5InPhPnsnaQtwpFAOdSm2SmgHmL8cqY7a0Bjo1iKktGcQQMtxCxU3llDb2S
	nbDvfhVvjp6qFg2/VEJkmOz4wM/7g9yisNMi+0h8WBigXeMV4UEg4pP1toqBD24F
	64yQP80mm5odc0mKQNWRZDrb1Umw4MVpJrPRT1uIeJHESAXT+AM7wJz4IbSjVTY6
	kZORbLh/gMvM2ltkSGlePbmL+Zj6gMKBO61Vu2Z5QTqeH8bjM7v5k5aksPV5AODZ
	9J2Qw9hnsdKIEcumG+dTQ1TzcUSKjCYI0VNOJq0xNwdwAFbWgQWAW3ZuyQ+etHfg
	N9moN0LHJqBzw+DqrBrIjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780465201; x=
	1780551601; bh=xyxM2r/QLJOPpD918GEsmHm34QgUdABliGQqbtQP/IA=; b=Q
	39HlxsxNGlxJDkn807TJN63F/UB7r07bE/DfmUGQ6sAk39UKD3wNIb6zTeby6hv+
	Ry3D5Mg0iEqeO8k91s1paFidTja99evd1AJgQARcV2XiHnT8NLRlowua7KB1EL3P
	KDtoGXtXJ3C2JH6rhNGAxUIN/sCpP6ZYE//3R8PMidW7v23sUi2GYEDaAUsVAFYv
	OSLx412IArNGOwkKpjfOGloWOpoEY8QtTvSBcCnkoA6NGH57KgzgoYlsAMyt4H3u
	U9lqFx0mQviGqMLy8tgPT2+RKU2t8NgaB4wj4TbqgQWcPdW4rGZgZ/XLXe11lwNJ
	h49XMJFk5puINfq+leFhw==
X-ME-Sender: <xms:ML4fatKPkNFJRq-u1XzXO-eVAf7psFHrnJ_BxrCmE_VkpwdMr40O-A>
    <xme:ML4favKH76Wgq5XtXtrMVIPXqP5TobTA9s_AMifoBZ4qFHv-xbsAxgFH17inQ-xE6
    u1mUWlCyqtftI3YukVpM64H1yrZuT7t1wsGePi2ehowpirVkVLlJA>
X-ME-Received: <xmr:ML4fajVEgT7b198AYuLFZoF2nWoGpEOwRE_hm92Ta1EItHlsTFf0VPyC0GFZ78HLGvr_sUCEOoM9QQYCgRGnexo0JGmnzcftEnXBU1mUFsW5>
X-ME-Proxy-Cause: dmFkZTFUCrC/B3GeJV6Wc3Opoypu9S9eFMRUE/E+0w3XMUTXL8HQa/6AC6L7OltLX26a2O
    NCw5UfFDMdSlJnEp87SnaK9aaP4qYyYyCVZEEX/5OfWChozr5XCwOQzUcixOwNIGdr/ANL
    HX0lvKBkcKX1GIbvxRg5F2sv6YBZ322xZ4PrgxfspTkCThVHrChE1teRunRHWQ/kayYcUk
    AM0hvsyz2pNSZzYNdK2FO+iL9i/JpdMlW0bb60yj9rKN6oUKE8y4fqjoFzTPANAoGHgZRf
    B3hxWFfUsjC/m+dvhnSBuLn00iFDwOGFk2eFx/x5niLa7l+HEtx2rufCMQWIgCzC8VF8nM
    STGsj10zU09Cv74YPe5OAX5STOV0adMQZfwwdHwZFRh90eLxBCmIwDW0LBfvMACqBfVbuJ
    SrN7Vy9M2f713PG1hAGEOpVETZQwty0eif3R7nVi2GLaSl0mLZJnJai7q84jojj9lm7vIG
    ujUNn2N2NtNTn/UR9tftw4dRcFpf84rhB2NOu4DNiUuQWsKCbfQMRSLa4RBl/xbVyDV4dS
    fJaWAStRAEFFLCjAlyb2HBK0GLzwBcgWtHJL4xc6W57xFK179nkIy1KteJ8xFjDK0ya6nm
    AWrE8jQqTR8QYUdRj26OGBlw2wi8VDGxUMcX45mZwXn5VlpgxiPzrqaVnIMA
X-ME-Proxy: <xmx:ML4fapjxB78j5pOchB5KlyFBJr_KAD0SEALO2MrFEErw4OnBzmc-lg>
    <xmx:Mb4fam_rVusyGl_vccrV33hSw2gni9XRxVe_lC65nKN9VipnZt5itA>
    <xmx:Mb4farDjczVctQeo3EbTeRUcCh-Awd1L04i7LtxMooCc_iwtKfvcVQ>
    <xmx:Mb4farLEvEIn0O1FNEl5zhOddU1YH0CYWsTPhg2uPVWEpbcEhTz1TA>
    <xmx:Mb4fagjv02Tm8MxM-0XSh_H6qBuEyokoVQXrr7lYZ0Rh8Rmj7WoqhaHa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Jun 2026 01:40:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50d6b3d1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Jun 2026 05:39:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Jun 2026 07:39:45 +0200
Subject: [PATCH v2 2/4] t/test-lib: silence EBUSY errors on Windows during
 test cleanup
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-pks-t7527-fix-tap-output-v2-2-cf3af5694e20@pks.im>
References: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
In-Reply-To: <20260603-pks-t7527-fix-tap-output-v2-0-cf3af5694e20@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

