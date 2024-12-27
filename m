Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECF79CD
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735301455; cv=none; b=G51o5iAUSvmT+/xJ/z/WcmzvGlA7wiVdVhjEhycqVj0GZj3y07nxN4ceQ2KbFn0Rc20txvAuM/2UxtKYWYL7hZzEVr3GfJ82MEXFoQeX8jR3gJm5YIR8VwGX2os5P6dO8ryHYrcvdcNIpiNCAh5PZU6nfFp5FFZgD7UELDRBpkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735301455; c=relaxed/simple;
	bh=rEQI7dq6fpx5hB5eJ54aYh9OngRqIryXi8HhgZ0vyGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EIjoEsSZWpMtNwKDHwQg8RiwL1f8fRAUdmtrAZLP5zL5Z5kXZcGS++znvscBoFXTje0r1H8HQPhkqmecbAbOARxKJgh8ZoVlHRnajuf1fGbly91zp5cyfTd22HgHGOwJmaW2uSdPNMRPftL2LZzSLNytY087V0pxT4uMWXx/RqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a6uSXxhA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ro2Pq0fe; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a6uSXxhA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ro2Pq0fe"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A59E1140153
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:52 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 27 Dec 2024 07:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1735301452; x=1735387852; bh=PD51qlnif2
	VGwgwWQpMeCF/PiVw1RGm8lXaYHuNLcbk=; b=a6uSXxhAsi0O/GkLG76oXBbmpY
	K4o/CCdeilmiRsv5UjIc2tBMzmCceAD+Vm8z+eLarUZW0RH4GnYQjr7X2ESGQ73F
	ww2ESQ220l0kH8V8kMGx9TFZdE75nj6tpFddDFJhU4PGPDM985epKmFotseM8HUH
	jCKEponegllYdcbeQ0+WwyKcwEqPp57aKhO6XBailvz2JhYR8M8/ZdldLWRT3pol
	r9nW6TN9np5MpqDQZsO0pAICkLngIcGPshZdEiyF08jB1Ts5T1Dy3vOPSnc1W4LC
	cy/hbDzqN9hKpR1pG6uyQ2DSs4F92WTCBAshQM4W1es0xmSWzcYi/dpOjW+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1735301452; x=1735387852; bh=PD51qlnif2VGwgwWQpMeCF/PiVw1
	RGm8lXaYHuNLcbk=; b=Ro2Pq0feHPzipz2+WAkUP6tlj6FqZazvtljy79nqTkjP
	DqBvAUem4gfpbiPtJ1hwoo3kZ20ay/wP0ABniiTDSc0upLsf/0rFMPjTCdV+BaF9
	jZL4Usgs0WNkZO3Ff+5JT/ae1F2K4Txw6wHL/Kgk+W90jGYZKtTGePW8XKx4O6g+
	b9mRCR7e7jbL9SDFHyMLvg5fIRlixmJa/W6awdK05fBxcv04/HOO5ehzLfKokNj1
	SZA24B7KMYCFBM1ztamfM3iE9kWDrkPS5VRCy2U/Cje5JFBuscuKb8Bu51KJGjoS
	/MeyzmXhiH2fiSug12UD9d0ltLiaXW6zs1e3c0FWWw==
X-ME-Sender: <xms:TJluZ16jN0RPeLH5RePyc8ZXT_nDOb1Dy9S_4xv_IEzOU5-OXhl5ug>
    <xme:TJluZy4fFW8V5cCai6fSDThawJ1-w2FwLVXXINW4v1PKb3BShc1WHQGPWIZFFlfx7
    GXGgc0ov5LUdRV9gQ>
X-ME-Received: <xmr:TJluZ8fyyd-GcxQsEg7FHanQGixXVK5cyxpwgtC5utZMgxbInXPOr5Yeo9nHzRKE7YFsh0rBKwMIEvfd8WPSFYHxUjaY9snocDBh9jL_9BYVLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvtddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveeugeektdetie
    egjeeuheeuudfgveelfeevheeuhefgteffffevhfeuhfeukeevnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:TJluZ-KUcl_lnLdNAAvmLlUUGxRXtHQpyqxAzhqB-LYWGh1cuK-tKQ>
    <xmx:TJluZ5I0KA6VxL-hBBLwX3aq6TN_sUGRQCy2iTZLC4x_qVsYnfRg7g>
    <xmx:TJluZ3wq2LmxdMqKm0V4h1n0DvfiBd-_zANhnlEdwP2VbeBOb05ViA>
    <xmx:TJluZ1IQI3xSmhrAvIkUrPcAL8ytjI860dmiHZ84Tv4u5FNL0zWaNw>
    <xmx:TJluZ3iaPnav5no6y42uryZxGzfjORFCF0IOnzLB3JZK4E87ZID4XDJg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 27 Dec 2024 07:10:51 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 46c9b94e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 27 Dec 2024 12:08:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] t: fix tests with NO_GITWEB=YesPlease
Date: Fri, 27 Dec 2024 13:10:16 +0100
Message-Id: <20241227-b4-pks-meson-wo-gitweb-v1-0-14ca8515bb3b@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACiZbmcC/x3MQQqEMAxA0atI1hPQKJbxKjILW6MGmVYasYJ4d
 4vLt/j/AuUorNAVF0Q+RCX4jOpTgFsGPzPKmA1UUlMRGbQNbqvinzV4TAFn2RNbtCWTqc13dK6
 FHG+RJznfcf+77wcFcTNbaAAAAA==
X-Change-ID: 20241227-b4-pks-meson-wo-gitweb-b0e27379dcc6
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Hi,

this small patch series fixes an issue in case tests are executed for a
Git distribution built with NO_GITWEB=YesPlease. The issue exists for a
long time already, but I discovered it due to an issue with Meson where
we accidentally didn't build gitweb when its availability is being
auto-discovered.

Thanks!

Patrick

---
Patrick Steinhardt (3):
      GIT-BUILD-OPTIONS: sort variables alphabetically
      GIT-BUILD-OPTIONS: wire up NO_GITWEB option
      meson: enable auto-discovered "gitweb"

 GIT-BUILD-OPTIONS.in                | 71 +++++++++++++++++++------------------
 Makefile                            | 71 +++++++++++++++++++------------------
 contrib/buildsystems/CMakeLists.txt | 71 +++++++++++++++++++------------------
 meson.build                         | 63 ++++++++++++++++----------------
 t/lib-gitweb.sh                     |  5 +++
 t/test-lib.sh                       |  1 +
 6 files changed, 147 insertions(+), 135 deletions(-)


---
base-commit: 76cf4f61c87855ebf0784b88aaf737d6b09f504b
change-id: 20241227-b4-pks-meson-wo-gitweb-b0e27379dcc6

