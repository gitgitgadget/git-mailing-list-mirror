Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B038189910
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508847; cv=none; b=Dwq9YE3GFE594e5NJFgjYiigvNCEsTiLYg0ayADytgvohsrVF4A40nI5yqjVPhwZQ9kcyfftUwc/d3vWmaYclCSs0RUyJzaDkajfvGttLzXshhB/oc5qZAZegU/+dVP0Gcx6pfWFZvujmlim4vwTmXc1pI7wXhgk+gUavoAdW1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508847; c=relaxed/simple;
	bh=2bJTOHbTuYlnf6z+SCiVCdJ+6es/vvwIkH5X2+K/YM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiKZbmviS9TW4VOSA35PwLPGLcsQLX6soUraAgcSND31IO2r5XuSAom766t650GKxHX9t10csAwIYTl2JbyeW+/FbcHCkFaajv065viiJRzpUawZL5ULCR3U35LOnAgi1Px9wBLGBBjjDQja6Q9WrBgLitakpfaD/ZGbSkf7Ifs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l2wAnavG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mnNtSrXH; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l2wAnavG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mnNtSrXH"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BD452114ABD2;
	Thu,  1 Aug 2024 06:40:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 06:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508845; x=1722595245; bh=xF9m/dypcJ
	JxDD63UOCwEm1cn6P7L62v+ssoUYQOKvU=; b=l2wAnavGhHolEvLRl7NIgAY5wT
	huvlCyhqunvlJqscyTRJnSgsktTtGY4ataTDHnoE3hfhQ20/3N4TFxFVxQuf/IDK
	d8qlXnqO8Gi5msB5cR4W9Y98kMXspWkcZADpZGu/SkMDpZ/vJepMfPXMc91BZZd2
	TEQjzgTTnJLgLAa1iqkUUwBXtFk9fWQto7QriYJ2J3IDYHxHu5p+E3cTJ1kBNNFi
	K2sEbpx36sBXutsapwblJPeTHDN28ZOcovE7oZDugvisWZV7B4ducbppb3uXgcmc
	IPv0PvxCyG9Xfoiw7d9Xtx7a0HvfwPNVbgl4ZLFrca8eZVNvLq3k/ntAq5Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508845; x=1722595245; bh=xF9m/dypcJJxDD63UOCwEm1cn6P7
	L62v+ssoUYQOKvU=; b=mnNtSrXHt9D6ISOGmE7rEnOPtcICD+hpayGmXyrORT8j
	Mud2OtpcTto093x+f/DU06VYjjD2SE5Pz3EIopdUA/C+4zgjgPG/1vNUjzdVfe+L
	D0jJzup2NEr930DNfMcNIMdLlXuuQSC1wm3q8gYGUMqt/jbF+VA04ib3qnxhukOv
	cYLwnJJRg0qUu/D+e09UsXKZMaRv/W8bmjSP73+dPVtp9nj2mLmwJfA0HSBeGJe+
	N6gM3WO3kUSC/RsudvWanyLuQiWcBcCK+YMAXZ65WrhUoX/8J3a83U3eWcVw02IA
	YXftj1IbDkN0TIQuaYesMoxzC9AnOmn6Ko/m7P9lWA==
X-ME-Sender: <xms:LWarZkqL4JCPpaVLY_Kb4HH4eP2BAmJzTvCXUeWxbbELBhhvPtfhJw>
    <xme:LWarZqrm7UisCH_VW6aHS85nZQcVoxca5jv5svSEtO1sG9bKLfpufyRIUDqGNnBzJ
    5ibko-xMuHBmPb8Kw>
X-ME-Received: <xmr:LWarZpNKoNK3Ts_ryo9gco_gxjaHxgdVkw1F8nVSdQlRGCYHTK4kFE6WAnSYt1IgVTYxiiAKz9AT-Z4iXvgblpRNc73NEVwj2ftrryCEjqoYQB0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:LWarZr4-py-VxCK_r2SHPYvFInJN6dblo_4oHHNIncOm22QwJ9BltA>
    <xmx:LWarZj4vAGSBLySbPHYNFREXDO_YzSOtHYLG03bs_vyIJPalGJxZ8A>
    <xmx:LWarZrhtlJBIeBn5lFkPhLwIXtk_aTOIJF-wZaU0wZMnc8wfZM3AMw>
    <xmx:LWarZt6YAxI6FzKuw44bRMbRP1rapvQ4_-hVc6rIl5CZjygOLQdC5w>
    <xmx:LWarZpTTJEWYz-DNBN-rRG9lO78QRv_Yf_hS308L33cZU6iB3aTs-Mx5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8027a943 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:39:12 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 17/24] builtin/shortlog: fix various trivial memory leaks
Message-ID: <d52ac1a550a11b238346524e73dcf04a4f7e5a30.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+aMpfkxEHuY0ZDNm"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--+aMpfkxEHuY0ZDNm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is a trivial memory leak in git-shortlog(1). Fix it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/shortlog.c  | 1 +
 t/t4201-shortlog.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 5bde7c68c2..b529608c92 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -514,4 +514,5 @@ void shortlog_output(struct shortlog *log)
 	string_list_clear(&log->list, 1);
 	clear_mailmap(&log->mailmap);
 	string_list_clear(&log->format, 0);
+	string_list_clear(&log->trailers, 0);
 }
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index f698d0c9ad..c20c885724 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -9,6 +9,7 @@ test_description=3D'git shortlog
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.dirty


--+aMpfkxEHuY0ZDNm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZigACgkQVbJhu7ck
PpSiEA/9FsyfElR5DLufa15cYGD3CrqkWQ0bmSxjoM9t/HVUdixap4fk7geXItt7
bfCB7fHM/Vvf2xO+aJKqRh2yJOEVSuzp7JpETTydb/0QIxa6NWDZBlxL7EWjb249
9av/E6J6rK4wj4DpC8eslE/de9dbAxSMiocXVwSaBoMfdTlsDyTEIz/UxxQt8pDu
LD5cCJR2cYrJDG3oNGSJcxE+ymXoAT1HnfdRfd5Ew6rL0xTwT3Tynj/Yqw4MumA2
zuHn+w9MNccPTIsrkukRy9vH0VsWsUo+tR3L5oDaGJx/JNdnvaHBire2Qfc/v5uL
fwh7CAF9KXtD2G/vCd9vNk+ItlmK7gzV5zBW1tIWwSTGMC2ufslBRtvhh+AkGIpB
SY6FD/O+sM1qzejXLsZBtZ4i3sPj0m+sQceK1HZqTCs2QkKswwxowOAtmT7yZ84V
iZGRmK4NuFyJoCCX2jXiFMYGVEx82SMwPos+QdxE+WkjdtiXJGwzurEzoAPmv8vt
mApuUum+OvTAlLIH7HyuKUFnFeTT+saXanUxTJUOfZuIpesBbOzqMIUPPZK0/atF
5mlxTnOBPcAbr9fp/7xwldKjufwEirfTozhnLyx+S+eecfBnzjaeagmtrETYEQH8
24o/3Ts3LWaU9Wfgxm5J0zh/T/XMPGxm4ZpXXWmi4vaOPmb+KkQ=
=zFSU
-----END PGP SIGNATURE-----

--+aMpfkxEHuY0ZDNm--
