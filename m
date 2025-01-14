Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C628EC91
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855785; cv=none; b=tIfuGu397mei3DzMI1OIkfzsFxaw2W1rsBKnO6UKruWKYtoD08pRo5qKKm80gcv8cr2MQ/NrvaZ6bwStxzdQRWre+E5gFO66Uwk+QrVSn7z15vwk4ffZ9IrMr13CTOkJikBAu6vZa0JBsscMlEpUqbE1+mATT4gdWhWR/A60W+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855785; c=relaxed/simple;
	bh=UM2eqku/ZOVM12Xp8OXQTv3skvz3RQUKKnUxKPH6GLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N2c34Te3LPHJvWO9lKtIQxCMns/TDIsNpDjcGmzNnFVBZrpq+2OdgDzK78hsoZHJmi2hb3F9Uuzze8U/rOD0c5LoI7P8WFemX3qdtZX1QZcyYz6MPS0v7N5GKaphWlyX5ifKgjBaA4FrCcSD2ZdzI+/stE/UoJiNc8CnUDfTZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Bf/52B8z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IUEhe0Ng; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Bf/52B8z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IUEhe0Ng"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5B9F7114015B;
	Tue, 14 Jan 2025 06:56:23 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 06:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855783;
	 x=1736942183; bh=pco7noKo0yiW6uDdt3Ue0s3iDrCPIIm2ghhYXyasGkA=; b=
	Bf/52B8zR42SXmHBezX3mbqS3g7pfaFjOve0eGaOQTxyjA/RoJtihPqXSuLBMWnq
	HY+qYBmAUF0z1IUsNk0UPxPgaKuRzYgHoMwhJo4d+jmgWFwuspLxqP2DE4fN+kDC
	bhsmCkBph2Ume+oCFnHqlVeemMvbMxVZXMsNeQHs0TnnihKQ4Rm8pMgKiBF19O4m
	V8Y46EyRTc8M+wwiXuxVYq1a2u+hg8D0kB9KXs0G2WXbFbtJUvgFzmYrjjxDetS6
	46UgkJpqxd9gSSXdvgMKn0fJQDklcsUkzGCvoQXXPuLp9DdtRKhbs8iiFWOzfoou
	Pep93zxUsy2Jx8IwfJf/yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855783; x=
	1736942183; bh=pco7noKo0yiW6uDdt3Ue0s3iDrCPIIm2ghhYXyasGkA=; b=I
	UEhe0NgncTjbdOf2PbIXrz+UE2yoDnF+3X/VN035t4WgrLgSeWj6yhG74FNeiO4c
	kLGpQO1F8zK+T+Tpip1xX6f3AFMI4w9MKKyH6pkrV6EV+KcS0UUhL2eGKI3qRyVm
	JVSueJbbk+4pjc2siiBGkFA9Cd2gHJQWzhS20UGVOqseHXsmS9ZJt6bHZyZ7aLN6
	Bpim7SNraTOXeBwZ80CI6c39sRa12PnevOe7tQJNBXeQvzTLafDlgeoPrRCPae0a
	2JCau+YGhOkiW4FkoGj/IOOW6GxRdx4eatnzMNPX2bfP/6EmkYR+ZD1WMMetld2F
	J6xGW9yviAG9D7/fb4Mow==
X-ME-Sender: <xms:51CGZ6ActQfLn00Ptr-g_gcpy-ZpMpxg_jsCPsKzYypbW_aywTyzCA>
    <xme:51CGZ0gMS2taVjeDrKFvyIeiSDsNzFd59P11f-cUG91iUXybclDP5Sk-Il69SUIWV
    cxoEsAkv9jsodByNw>
X-ME-Received: <xmr:51CGZ9lCvdUUQ5cBSRAzSQF_90kWMq-S8Fsq_rpRXe3IXk0DdY0nFIXx669pZjErjWVN4rTxbVqOmI8vH0GTME8afnm1vBo3NNcu-1uv8jRtLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhr
    thhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrg
    hrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:51CGZ4zYkx59vZycHyv1a-mXRNkJ2aLAhwNg9P8fHxoVv2DnOtu1vA>
    <xmx:51CGZ_S_1B7mrS7X1y5HhUuwWumC7h9HlYCEjeEWDjiOO74ZYoVYvg>
    <xmx:51CGZzaP4VJLbDJXKW8ADpbRT-gTuZs-DiUXqaw40KtaK-3TB0BhBQ>
    <xmx:51CGZ4QPGj24qzaz-8z4S0Lhwu1IwPLXTL0pdAxgiXZfDAVgb12k2g>
    <xmx:51CGZwKkdfKg7o3UBCfVMGHYThWCfBINhiorKhrmDt_QddRPJseQGo5W>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:22 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 52e9405e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:56:20 +0100
Subject: [PATCH v2 10/11] ci: raise error when Meson generates warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-meson-additions-v2-10-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
In-Reply-To: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Meson prints warnings in several cases, like for example when using a
feature supported by the current version of Meson, but not yet supported
by the minimum required version as declared by the project. These
warnings will not cause the setup to fail by default, which makes it
quite easy to miss them.

Improve this by passing `--fatal-meson-warnings` to `meson setup` so
that our CI jobs will fail on warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/run-build-and-tests.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 6c828c3b755153dab179f73346e7124bda49c90e..964322055f5db0eae0c794b543664e24ae4249f7 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -52,6 +52,7 @@ esac
 case "$jobname" in
 *-meson)
 	group "Configure" meson setup build . \
+		--fatal-meson-warnings \
 		--warnlevel 2 --werror \
 		--wrap-mode nofallback \
 		-Dfuzzers=true

-- 
2.48.0.257.gd3603152ad.dirty

