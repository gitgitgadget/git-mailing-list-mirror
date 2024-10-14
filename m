Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E585D1A4F30
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908499; cv=none; b=NfbZj4n6SQFh/Tb0BmmRgywOk7d+aiH5he1KUWw5SixkvLSEPFoX5Cnx9YaZcVsrlz7UNjLvXPbR/Iaaku0LcJ/8wSf0nSN6A47py7XeY4o8HzqR/+h2ONnaVBIy6JwOt812BXxeZpK0/sc8PwFyVxH2ao8hpFwpDYt/Rigj9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908499; c=relaxed/simple;
	bh=AivzP14oKcMpocfx/+iJ/3wqhpuJyBerkIfxff8rzn8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRWSwZjJlp/C68Uv+KBFzgW7ychgkb3acs4nDZ+1/05fPmuhZ/6QBchewJ68WKrPMnFG9hXnmnFWjvcJmuLJ8dNNnVXrFogIuBjvsCw8yqHv3j9LP5oSAcUxmefvLPh+XnPU6Mos6oLvUT2aB6Ddvc50niuJjPt33p87v+vMUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BaYD0v8U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JE2+dplQ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BaYD0v8U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JE2+dplQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32E7211401DD
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 14 Oct 2024 08:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728908497; x=1728994897; bh=1B2585PgIM
	xaSR2K8p8wDvhkiDm40GBB5/JuaUgNzos=; b=BaYD0v8UFJlSLwkkeV+UhtWWnk
	aMJhT9/ynKmHelbBegKBOt47aiii1h5dNlXSafFk7E2x/FqJqth7149VX9LWgPQU
	Rk5YVrs5waZ205+i7tVy4PIyngylRCheU3/MdQO+1v21bHXxciyn+tPvG9GVoZs0
	FD2WeI8C+loOnNoGxGRqQQ2TiW+k/MG+hacIzCnBHoZgyqT0P8d+OI0CzsiUFQUr
	QBmpBR85LyOC6yHsFt7nCIyiLSTERBEKBcWnIaHMYDTzLhP9xboAxa7BeGguTzgY
	ZjRWrkAmahS7nrlpgiFYV2DT5uKnSm6hJ9gkqGrzLrCpiKZW2I4ThHH+TcKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728908497; x=1728994897; bh=1B2585PgIMxaSR2K8p8wDvhkiDm4
	0GBB5/JuaUgNzos=; b=JE2+dplQ8zgG4vaX2OxbA7b7O/P4JH2J3QwJTlmT5akT
	UVN41JODZgLn8Hd+BpUz+bNjki0ylsz3cK3l25IaD15xzE9WOdno2PJ92pUQvY/4
	JDVsGz0/35sqiyErcWYkVET06CWKO4eFgd7Kzq0vEEqH0UQCgvrdf1/6+dvpOcfZ
	YNHXBuPUvldlEvNO3nqCrb2zK65FzmJGiKlwUfjH6Yl7nQLPWbl6CIWu0mH9LuO4
	X2cYmBTdncuV6t2VoAc44qZBqvHz35o335WhGj5Iogt5M5NADPNnZxyi6d2c1E9V
	PVFWO7UWPf7yZfTEEAtw3a7Wk6Re5itln78zYL5N7g==
X-ME-Sender: <xms:0QwNZ9lwJJznKjt-OBeil4m72sz8QOTCqdBJp8kX78C_3lKmO9jWCg>
    <xme:0QwNZ40e6bZUdyAipsJ7lnHofQ2rVWsO-GG9WKRob-XmqOw0VbEnqI1vgBJQoYxVc
    vNGpz2mPtU3ivp_2Q>
X-ME-Received: <xmr:0QwNZzoIEbp2qH6fMgU7xLlvxGrJFI2gAtoobzx58a38_iaGaRuAO6WmivsRlBAQBZnWppMuOHeOYCPBjmOFP-JfTIgCbXFXcTVZHuh5U8YA3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0QwNZ9kIAK2l8F8qv_j2VUWHipcHq4Sa9GkEOsCN-bzvnzQemtEOPg>
    <xmx:0QwNZ71-RkOsRkfs_zjmetGqI-iDrrRTFPRpvcP2_lv99LjILz6BEA>
    <xmx:0QwNZ8tgBDgnJsvB8piyIOVG7UX4EQucee_CuyGaQW33P1hX1mj66w>
    <xmx:0QwNZ_UplYBXd7LGnpwUt61ABBpnPJCjmBcwHwztK2SlptRsXN3zYw>
    <xmx:0QwNZ0_2M3w2Q3xGSkU7-7MmHSg77PzrO6Cu93_6wcOn03GLyfYwiWH2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Oct 2024 08:21:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8f1bd89c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Oct 2024 12:20:23 +0000 (UTC)
Date: Mon, 14 Oct 2024 14:21:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/10] t7300: work around platform-specific behaviour with
 long paths on MinGW
Message-ID: <b94fd876adb1933e582984ce824398857c2e50fd.1728906490.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

Windows by default has a restriction in place to only allow paths up to
260 characters. This restriction can nowadays be lifted by setting a
registry key, but is still active by default.

In t7300 we have one test that exercises the behaviour of git-clean(1)
with such long paths. Interestingly enough, this test fails on my system
that uses Windows 10 with mingw-w64 installed via MSYS2: instead of
observing ENAMETOOLONG, we observe ENOENT. This behaviour is consistent
across multiple different environments I have tried.

I cannot say why exactly we observe a different error here, but I would
not be surprised if this was either dependent on the Windows version,
the version of MinGW, the current working directory of Git or any kind
of combination of these.

Work around the issue by handling both errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7300-clean.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 0aae0dee670..12ab25296b0 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -747,7 +747,7 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_must_fail git clean -xdf 2>.git/err &&
 	# grepping for a strerror string is unportable but it is OK here with
 	# MINGW prereq
-	test_grep "too long" .git/err
+	test_grep -e "too long" -e "No such file or directory" .git/err
 '
 
 test_expect_success 'clean untracked paths by pathspec' '
-- 
2.47.0.dirty

