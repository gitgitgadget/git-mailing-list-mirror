Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCB369234
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775068976; cv=none; b=ZtgO1Yjq9NqvjF409Ufp7jNQ0qyHmEdovmMFwQa/bR6d03Wfo7tvTQHpJh2b5AHcpej2KQPc4xvx8GTcZOWC+YhJ72gptoXpdT+ctF5GgHKrDSleeKt8/E3KcrPe2s5uu+VDXu0M7dgKpjZWd5gzX/x0qdEuRaVRKzAeUnaoBJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775068976; c=relaxed/simple;
	bh=ALGsCnXV44miorXSmdtfJHpK5mKc74qxXfyzDgdkFIM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BeMwD7SlVeT1Q137rvtJTszYlnzIf0K/2Sfvzw0aHkp5/hXe5peLPt+qoDeEjO6Wk/LyptSrlj1AW68XrXAMgwMcbAV7zdvijcEYeJV2Z6BON6sP13N0wHtoR6jCEg7ofDGD4DpXIngiduAHeijSgFddF6x9OtvQ6Hd9FZVcpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PT/oAmcd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtZEqJcG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PT/oAmcd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtZEqJcG"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2B68B7A00B1;
	Wed,  1 Apr 2026 14:42:53 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 01 Apr 2026 14:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775068973;
	 x=1775155373; bh=ALGsCnXV44miorXSmdtfJHpK5mKc74qxXfyzDgdkFIM=; b=
	PT/oAmcd00guWxMHbA1wbXW4dIPVL5UoZ3FKxTf8yc4PuGu9XySIsWK6a+2aYG1q
	AWh09M7rAQegnZcHIYCyS1SWYIYEneahZ6wIvd8ptXVHDRQp/2m72DahgvLWMYeD
	r/69qo3LBbqXT4qJS/NHziG1ExhaSW3bKGBzRMfi7ZSzj4qKT4H616cjuEyW0eXY
	tfWXLxFT15I4+2pk/iPH35FODz715w+cbczuyW9MKCbsdY3gkBgqHJUOmcI/TuOt
	OWAKAuSPolDRqEhzv1Dr3kbj1A0c1lC+0O+aqZQNDl3x+aqUxtB4gn0kGuUp03Bj
	IEYWBUabL+J51xEvlk611w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775068973; x=
	1775155373; bh=ALGsCnXV44miorXSmdtfJHpK5mKc74qxXfyzDgdkFIM=; b=j
	tZEqJcGmk4vdV97Y60j3DC7Dffh0VrU6ndRrNEGeQhzRD8SAZGeyyfwT5XmWP6nW
	Yup+39CIPTK29n+JY+5u5huFP2+XPrQoJgYBMGMqPHYZUlpGv0M8M2IKm7E/53Wz
	n/5q59Rqf4cmDfxNoO91mQHYBmh5vChuBSjGtgcXmNQ3fRDrY8FovgmQyXaqMIZa
	Nt8Gyyb/bnXzjA2B9D4XitdvaGI4o6c2NbiDHwV8ATxKdlf4seZongYmuK0pcLdg
	Lqep/d6h2PQPZCPV96ImgAA8IXS3ti5hvQGZyJ6kq2D1okWz9qJF2VYC5UhHbC6f
	24IsvVgGetEWY9H/IAKhA==
X-ME-Sender: <xms:LWfNaW2XsVq4tkND26_BMuDiO2ZT7Go8xcgmVjdHRHnIJhYKzwy6Og>
    <xme:LWfNaQhf9_t6odcL297HCQCD2kex_GRpMqq3wfpBgVxr6Br5RV0sEcwYpT4CWkupg
    b7IVN2UNzCUCNr8trOcU6rxkYs4x2LP2R7nrV62bDHrw3uTXGW5>
X-ME-Received: <xmr:LWfNacSukkdarciS1BYXY0ewn3BQ3wjF4IQuXWoyA-xmkTnwsSvrG3-x1zOQkQn94mZLjXhrvdcrBjj77O1ZF_uinUE2RH7EGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedt
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:LWfNaRgF8z9_kj4FIqvlyYtA7IN6GQE723_Ikk6CqRODhuao25Zw-g>
    <xmx:LWfNac42jn3SR9QsvV3Zz2s3pg8962-oSOsIWKuqDoMW_N7Dnbk_Tw>
    <xmx:LWfNaeDqQ2_vXvi0gcKJtVOCKbh1Zkx4jCDK1JQSLSuHMVfGyAzX_g>
    <xmx:LWfNaTZLQ5nTWMJ4EX_LA0cQG1jueOa6FN7z323C3XKisCn8twDasQ>
    <xmx:LWfNaQrxtjmtCRooRkhfdzW6_aMYREL9K3usAR7_AnGmjyZi6alyS1L7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 14:42:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] hash: introduce support for the MD5 hash algorithm
In-Reply-To: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>
	(Patrick Steinhardt's message of "Wed, 01 Apr 2026 12:42:28 +0200")
References: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>
Date: Wed, 01 Apr 2026 11:42:51 -0700
Message-ID: <xmqqtstuv7x0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> We are currently in the process of migrating to SHA256 as the
> alternative to SHA1. But we believe that proposal is misguided.

😜
