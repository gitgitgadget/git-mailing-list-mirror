Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56671A2625
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485785; cv=none; b=dq68MLoTy34YrR6hC/LXiL23/GRQkNGisY3FPjgOpvQ3Tf7ik0cjDkmgy3nqcft33UTZKROcSouXChcQU0qTchU5Zev3AXW4xDpk35cRFpggRXa4SKd1vL9ntzzhaMLfxZy04pNXunfaUsLeKIl9J020vg4P5JtKFfXA/IMRu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485785; c=relaxed/simple;
	bh=SUTkDErwh/2420QFyiqh7ViEIcXNKG28IQr40jcDmE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMuG/py30BLm0H5og7HMzZi6G4ZC4faYKHCuEde7K6vr98koHJeRoq3YaCwM0ac28AxQtgQBWGT+fRK4CYE1r+hTBGzGcUH8CiEIQJWyxC0v1RMymmKmqA6Fb3GlP2l8HRk0jotVujRrXyXm629XGDdOgRN3uDhR6bZUz9D05s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GWE5TkPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AsGdQzbc; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GWE5TkPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AsGdQzbc"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id EF14513801C2;
	Wed,  9 Oct 2024 10:56:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 09 Oct 2024 10:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485782; x=1728572182; bh=Edrn/jY8KK
	Ig/SxNLl1HGOfkbyIXTVGJDW4/Di3p/28=; b=GWE5TkPZVXJjQyeZVA269aNYOw
	/SUJdqSKSnv2lLS+LmUUfwK/A6DBPQ0Src9JCP4JhnwIO49hzxGE509FmPNQJnnF
	kmD17Bk0FXt4YZEoshyDf6HUZhXEf+s1qcl4ZMZLNbEWou+ARRimSxM4WCtnHsH8
	+3b4Txn0bPZaCw8UW+vHu4fjmIbNEtSpxREbWC+5GkT6bSvv0xSzLbpjOdsW1rsK
	2UDd8TgsAJtYAhGc39t6wCyMfI1XK2bolGDGw7KX2NobdRI+wCXmdcgMqzk9A80C
	VaNToWsXnQZQjjz2j7PqMs8q2MU025lFx27WS8KgrVxzO44OB+tLByxID85A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485782; x=1728572182; bh=Edrn/jY8KKIg/SxNLl1HGOfkbyIX
	TVGJDW4/Di3p/28=; b=AsGdQzbcHTE0N+bcFGfoxzRIFmpplBnG/PWAbESfaQYH
	nZo84xQJWa5DYFRMtEZ0wAg4hV1YKyzjEe0UfGdMHOzgiodJX1qF3rNrubiJPDlS
	7N67dkYj4ETcoKZ4N+bSZF/6kYEvpN2nptLIN+fv3m2ZJklmzvl7rmlwTagUQBJH
	lauK85tI3jwmo+0gmjnGgiJ42X8tmEfioYFvEKankE2f5Fx8R4Jgu0Z+k7lwLvSB
	ULE7euYtK5W2RdzsxaDAHTAxwuGi9GFe/m2sZyfmMVdz1ehS+nPEUG0MOIVLisZA
	WwWZ9SEEAxuX1+tpjUSV5xC+2GIwwUwsWBcCZ3Z9Ww==
X-ME-Sender: <xms:lpkGZ3BuAxKcDt9o1BKCLnMyPt-KdFBLWoM7xLH5cRrBetwtzfiJ7w>
    <xme:lpkGZ9jB5Pfdr7KwIAThdhjIixauCL0fTQEaZffWco2DoM5yf4DzQFRaqUMyI69gq
    oW2W4NkOFcKHOEhOQ>
X-ME-Received: <xmr:lpkGZynxDg0oV4y1IsP6H1cQew5kkjR5UPKwMhd_FjVeFWjkwN0H96hM39E9-OxLqb6IKsTfjazVQ77ZLFc5W0EvlJ0ZTmxSgN0zOXzYYE3qUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunh
    hshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lpkGZ5zwtiB7xBASBZBrWz2cBlohaWVxGZKCHqot34ySfMEtOI06Lg>
    <xmx:lpkGZ8ReJJ4va9-Zw_N6Sahnq_OM3A7nZxA1KfqzsgmYwTMAJ1oqmw>
    <xmx:lpkGZ8YNN9hZmaVgwdLR612hcN2BJZDHBqnVMZiEjQdifvozCxDuAQ>
    <xmx:lpkGZ9RS9l4hiAevxx2CLmH4ey9ldaSMETECOB2VNuIdTTAX4YyRHQ>
    <xmx:lpkGZxI_OqLTbJf2UVEEPndpAplTgFkOFuBI3bLaq4woH8qJUD1ju5Xy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0dc47553 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:18 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 05/24] t1401: make invocation of tar(1) work with
 Win32-provided one
Message-ID: <958cf3a6b578449eb26caeec6cb7ab9ce3fe66e2.1728485139.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1728485139.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728485139.git.ps@pks.im>

Windows nowadays provides a tar(1) binary in "C:\Windows\system32". This
version of tar(1) doesn't seem to handle the case where directory paths
end with a trailing forward slash. And as we do that in t1401 the result
is that the test fails.

Drop the trailing slash. Other tests that use tar(1) work alright, this
is the only instance where it has been failing.
---
 t/t1401-symbolic-ref.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 5c60d6f812d..90af3f955c0 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -16,7 +16,7 @@ reset_to_sane() {
 test_expect_success 'setup' '
 	git symbolic-ref HEAD refs/heads/foo &&
 	test_commit file &&
-	"$TAR" cf .git.tar .git/
+	"$TAR" cf .git.tar .git
 '
 
 test_expect_success 'symbolic-ref read/write roundtrip' '
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

