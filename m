Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432CF78F20
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819518; cv=none; b=KlzYdY4kf+XfszCx4xjjAY3Quf8mKeH0bzSA9qOrCUkAkDsvQcbyNgvwf6HyTPB9vAvm1+yoojF663Qk1g6VfIajzBOcijQUAH5MviUlLAzeajoBMrG7lojyP+Pia3lM0mOY+2RI12yL/XxQhrDQGnjDXm+VrpCmbIQQS4a4Vjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819518; c=relaxed/simple;
	bh=Cn1ST2k/46hq7mdHRJpP2U83GLXXcNk131IbJH0v71k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r0Od7X/BQsGgw8mVSzaxZxXuIdzXfcjzc1tyxvfI46O7Y5u191ZqVD1YcK4PLmoLJ5+PuFDK30puids/wG10vNC9NFrGxUD3F8yQWRKOONSzkZ94CS9Mn6Xr8dsuOdorFnyFio/rccCFT+X6QWpUbx13PoMkV/TyxRyBW0Yakqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WQqDEzTh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AHFytmyN; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WQqDEzTh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AHFytmyN"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 6983F1D00151;
	Mon, 10 Nov 2025 19:05:15 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 19:05:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819515; x=
	1762905915; bh=RUFt/xUgUBqGkCu6FsTgBTr46vGBW3I1/6dp+oC5cuk=; b=W
	QqDEzThBESCWaPUX4vPHms33LaLmXQMpMcd9P8cUQZneTYWeJaiCHYxnRw9DIh3v
	z+zYN8LdNlmC7WsP0PEplEdGdKKH5vtOAkLfNpmXS0Fz7JWcy8ZMn/+URrEQPk7f
	3blrx7EhPCJw8MQtj2/xTYD+4GaFCohauEV6JymrFF7A8QaP5zh78XYE8hs5Iawm
	gDHWjAYrxzBAvCeiE78vkd6i3aPzDat/NX1tnpGtzu9/Vx/ceMt3Jg8BG/+aFN7+
	c7LYT13YfT2/UIAVgkZ/0ERFQjmkLs/QbLU4l+lH1ghqxuekDyUyad0RxHfVNLpF
	XCUJdZINpc5CHBInDGrkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819515; x=1762905915; bh=RUFt/xUgUBqGkCu6FsTgBTr46vGB
	W3I1/6dp+oC5cuk=; b=AHFytmyN/oKe8zT/mUpdO8Nc+GijoTAdcPn17qmAUaRx
	xsB6YgEhUJdDRWmqy1fpit8DQWdkT3NGpPTRkuIV+zjLosBaSfep8gQQJLATgN/5
	m+eFUiXv3ww0Wh98CG7PV0NIHqtCudtZuLHPGxB2sTBs5tQZZDRb1sJdOIzpsfaI
	mv0hD8ebNGU2Bj57J1IvTLLm3jlxg89dRwGXXZIitv1h6UDHViWhsjP4PB7tqOTP
	PbpEX+zHio6uGuEvFYurtK/GLAo89YEzi/zPwohE5Q0KrFzhpL0ol6BW42fkhJ30
	chBWhtBZ7SOsEbN5c3uC4qnw2B9TGv+P0ihMKz6WJA==
X-ME-Sender: <xms:u30SaTNM-fxTi1IZXAXtKVrrlmkFixkAFPdxydLAzm3QltSnsouv1g>
    <xme:u30SaT_jMgJbK8CMQZoaoViHOIN7-T7sdeI-cLd9rHxZm2g-eAdYmz16MXTcPUvqi
    RC1nAzYQAmtGJazUqEAieMWDo1zXsLJ1N74VE1FAc7_GBADizUW>
X-ME-Received: <xmr:u30Saf5RMvzMWMuf_lst61QdBSWirjoMsl4AVLtOSWjFTzAmjTPknBFldMR1JfVToJDWwY925yG2RpILloTN8rWx2qQkDyeEGDCX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepkeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:u30SaS1mGZmeQdeZfVNRDl_fHIt35arOS1cUPEl2fkOTnF3TgtNLFg>
    <xmx:u30SaeBs3yLE73w_CTqIqITJP-R-_gX_Z4zzoMZJkNiE1_F2Ae7AKg>
    <xmx:u30Sac2GCtFwPJqnUcmSw6cHuj9_Ad0kjBycGFXmAm2UaJH0oC3T8g>
    <xmx:u30SaQtGKF3EWHi5N3LZ3xVveXbumD-aS_gF15xYjJTL6_Wjq_YZ5Q>
    <xmx:u30SaelvH2N2LtS7ERLuEqLey0I7glQqXW-yLoOGV9mdMItMsVsOyPVg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 12/12] attr: enable incomplete-line whitespace error for this project
Date: Mon, 10 Nov 2025 16:04:51 -0800
Message-ID: <20251111000451.2243195-13-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
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
2.52.0-rc1-455-g30608eb744

