Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC423EA99
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222193; cv=none; b=fcdjs02k+1Q2oRq24+iKnwDtbviGrASIj7Zz98nfjinctB8a+Ljzp+uIuY34IKmjpwkFnsH3XafyVwEIAb0c5VuDWmJSa4pQ3w+7OOqX/p/U68sc/LbeJ00AVk3E4FMx29csQ49P7KWo13rkElfvRBu0oecZ/QoFfRN8Mt+shtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222193; c=relaxed/simple;
	bh=k+AXmwPwK9V1OAM4jJA0A4CKdEL766llUcZBtT/2FyI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiVmtBAySrL4obaB4rvGYg54FUInPjJIA+/0sZEAKW/tOwQClMmvSG77iG8tEA384ZK4iwmu7NA2ngs95VH7IX7QBNHShMvYaFGS4e3nmAeuvpCEawkl9mJ6n3u1AISPEw9qzv7982Ga3SAQ2/SyIJ8/VSMRbP2HigXeN8Uh8DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZzyOlOTm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=StL9NKuN; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZzyOlOTm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="StL9NKuN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F15CF7A03F6;
	Mon,  3 Nov 2025 21:09:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 21:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222191; x=
	1762308591; bh=kbqCSvlZHZEXWYBmoqxfbhd/HzMEw7rxviOXSAKvww4=; b=Z
	zyOlOTmr/yzD6dRS1FcoRuGIBhTkVH5gl4pLAunqih7t9zohus8dVyjo/EJ8hAhD
	b7sdzeIcRpQin+sYZrHCzcWN6xwc69Q94SGYW/35Jd/dagLhn56u+c6vKlOb+blt
	iddNIuw8AntshzOHwlfSzq7WLglrCg1p3H80wQFh3iBjYQTWJoeo0ysrDAZ/SCVQ
	7ACKF5tpKQE8vtg74NDSaclJkgz7cSPyDz0iSl1egXvKT2HZEwu21TXjvtEElwZL
	eS9Niuy01ylS2zqrKeE5mBrhtTxFIUprNwIAttHSsjksK+Rk/p1rUcY65KP//gWi
	rgveHctXbjTJ6R7uir4tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222191; x=1762308591; bh=kbqCSvlZHZEXWYBmoqxfbhd/HzME
	w7rxviOXSAKvww4=; b=StL9NKuNIAs0TWxf/luxA1lINl46UPv9/nUW4bJQy7ZW
	hmWal6Xl9clf8OX0B0tLWaEzknxVJMaWAx5Gid7ct9IDfZPcFk0+TRZN7X1tg1zQ
	2J1l/E62O6SCFoVE0+8z8mOrzT2T6CO+It4kR1ON5mllDvuyVzRwiiqMdq+6eJSc
	4g4JF09R5zfIRHfUki4TyXl4ljKF6+v1NNbO8qTZXpnTa3xaSLLO+3tTgGzB+OQz
	9pUwyDoE9vL9OKvmUxvM+ASHpi4mRLkU4n7Ov17tAA3FftfRQ6QgTGSoVHFLrWAE
	ADL2+a4gXCMoERHUrJHxrxOz1IprTnGDtr99KDFlPg==
X-ME-Sender: <xms:b2AJaXlD_zXccYtB1ORyKPI0fMVPgtmLBYfy9oYdclZtXoudfuyBfg>
    <xme:b2AJaQ0Qbk4PYxwPw_h9swNVvLW0tvhGf40yX51oMTzN4loRnmIuF9SMkaMsHNoOP
    9NoMnzbUjGrFOT9KDRWEG7afonhx-eMM7xaHxYi7dMJlya6An1N2g>
X-ME-Received: <xmr:b2AJabR5jY2sJihKaLbbp1exg2olgc88rI2XaDGWo_q3ToXcKncdJ_gvvGXVVsbR_KVY9GAaHheJewN_7K4i0kZ0rmI_xi__RKgW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:b2AJaavSXtLPCrMoIRwMfz-PUfEv-EzLwyYdY7LPbxFoF76PQIWsvw>
    <xmx:b2AJaYbSDy00DpbsyBIp0YXeiwem8ixCZGV9bsqhlL6PYBuChaOLYw>
    <xmx:b2AJaXvyAEz_fMdkHsMow_lYS927PUBQ3_10xh9QJ9kR3vJgi_ZMKQ>
    <xmx:b2AJaSFzOkVVXcX5mMxmkOlAmouj1zHwMKtF4gjwwVAzBMvPczgAiQ>
    <xmx:b2AJaS-CQL7ByE5xzfo00nNZGQIMH9faxFP8r7xwhvtZv0crL11lG4cT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 12/12] attr: enable incomplete-line whitespace error for this project
Date: Mon,  3 Nov 2025 18:09:28 -0800
Message-ID: <20251104020928.582199-13-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now "git diff --check" and "git apply --whitespace=warn/fix" learned
incomplete line is a whitespace error, enable them for this project
to prevent patches to add new incomplete lines to our sources.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitattributes | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 32583149c2..0accd23848 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,6 +1,6 @@
 * whitespace=!indent,trail,space
-*.[ch] whitespace=indent,trail,space diff=cpp
-*.sh whitespace=indent,trail,space text eol=lf
+*.[ch] whitespace=indent,trail,space,incomplete diff=cpp
+*.sh whitespace=indent,trail,space,incomplete text eol=lf
 *.perl text eol=lf diff=perl
 *.pl text eof=lf diff=perl
 *.pm text eol=lf diff=perl
-- 
2.52.0-rc0

