Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFEA1E47B2
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502927; cv=none; b=p9PGZ3/8XXu6Rdme1+8i6Fu+d09eOvDZjUe2KA25mBw3jLJ/1JB+OOyHHoUKdY6TlzFOIU4xAz1jD1yLsNYu05/cmyfofLZ0FEm5HTmBgQuh6QgSfGks5IPectd39f4Xo9X9oFvtBwcw+/Fj2QBrViGfd4AqNUkxmQ4Adxyn4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502927; c=relaxed/simple;
	bh=CoUcUvl7wjry1nkd7JB8gSM3U/7cVBYEK2rUj4VHpTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ev0/XiC0+buJLwfKI2/TUq7hhFGnhF/GzJh15eMzXpWESY4TBhmiCRduvVUVUGHGpjuQvVGeJZYvX9JudLI6LVC57TVloYka80wjt/S4/DTFDt/9GyXgmRJVZqxCSgk8Q//bLAZZcqMZmouFQ/QSt9DMGIcezDmM387eMSUg8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qNzRj2wJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MAs1D+M7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qNzRj2wJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MAs1D+M7"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EB14114022A;
	Mon, 21 Oct 2024 05:28:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 21 Oct 2024 05:28:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502924; x=1729589324; bh=Jnxa0HI/OB
	VE7O259KvPD+PtBB94BmqBqx4/Tq/621I=; b=qNzRj2wJ9SLI+gTeEUomm7s8QZ
	UhQbGpUoESlXl6+ov+rqFCF0zESvKTBO0Y03vB1dr8tpMHbEEXIQUs7y5WKSIgJa
	j/NJNawv/pxRTpVMp6ExTxyKvP35/+3E0m5d0pC5U92elIY7a9q/SCfqPVx3hPx1
	Yt3WM01oFjiqw/roBLyY7GYhI2qFqK6T/694gMsAGCdQSEf+zMUj+g/hWSdymUj5
	tMqo6Qvfklw5p2DoLefJZLtHzxeFWSJIiJxG7jU/qxfyib+RQCS5Nx14raaLt6cO
	lyZAL1yG2RAtph/SDJBpA6RHMdoGwySb5xuUYk3VyVLjv0JDao6OfeGf6b4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502924; x=1729589324; bh=Jnxa0HI/OBVE7O259KvPD+PtBB94
	BmqBqx4/Tq/621I=; b=MAs1D+M7KqO27dEa4ecmJ9DWxYDC/wmPQq1W572SVHmx
	8EvD3EzZlzNbILDXBA1g7FNem36UMDe9caKT4TodqFvD4MgdzrblI0w1126r8BJ3
	i5i7GSz867xrRxpXQNjkp9BJ15y22Qi2xMDBPFNW1T6OBiZj5omA8l/lIigPkawM
	2dvgPNery/r0w9ebAPl3in5hcIbfvnrypoytDCuW5t4IZxyro0/hn4oYKZ9vRXZ8
	F0WCrwtgeqMloVokU8Q0TKdZ9dEUzK6dsFGCPyXwgiuIpR6OEvskzdKornJDSvYp
	W/Vz0AF6G9l9fT79jUY38Y+Y71HLlL6+bIV+7fVSLA==
X-ME-Sender: <xms:zB4WZ-3-K8FOeoeQO2lbJclqHB_7z5wXjYMElATa9nagUWlySYrtyQ>
    <xme:zB4WZxGVNpcHWO06gRV6oqDTosTyyoPx96OANVGg5016Diz81fuc0pz--eL043zdd
    LemHS4LaJrLYZhBqg>
X-ME-Received: <xmr:zB4WZ24WN40sYTsARRNkCQWxyB0-npGZpYje5h86PND56GEYoOJWCfnK2TIe3NW6lDXuYHSY31na7hsziOoHN9M12_aRu4TuBV8kNnSeX4ln>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:zB4WZ_3M5vSGc0_y5pKsSMCt-13zey4fr3sU9-f3NhGTFd7N5MCreQ>
    <xmx:zB4WZxFa8D1grDBBIc2lzchUN1_urWmP83DHUqFx2txt1tlqeXnk3Q>
    <xmx:zB4WZ4871JZ0N99-7BuCi7mKBuyMfg_BYM4iUP6b_JnGfU9AQKz2zg>
    <xmx:zB4WZ2lnUUK_RLOS5K98RuYphPqCF2FISoyvqsh1K1CK7rxpDcuuKw>
    <xmx:zB4WZxDkrJQ7SfRSmMQVEewxNkYtVmU-b7bBrVeDw6-rZmOe9hC79dCq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e628ff26 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:16 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 13/22] transport-helper: fix leaking import/export marks
Message-ID: <ea81cd8db863c4421411442dd68be1d2ed1dccb5.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

Fix leaking import and export marks for transport helpers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5801-remote-helpers.sh | 1 +
 transport-helper.c        | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index d21877150ed..d4882288a30 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -8,6 +8,7 @@ test_description='Test remote-helper import and export commands'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
 
diff --git a/transport-helper.c b/transport-helper.c
index 013ec79dc9c..bc27653cdee 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -399,6 +399,8 @@ static int release_helper(struct transport *transport)
 	int res = 0;
 	struct helper_data *data = transport->data;
 	refspec_clear(&data->rs);
+	free(data->import_marks);
+	free(data->export_marks);
 	res = disconnect_helper(transport);
 	free(transport->data);
 	return res;
-- 
2.47.0.72.gef8ce8f3d4.dirty

