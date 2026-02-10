Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA127AC4D
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 21:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770759101; cv=none; b=VP7V1uUMWdikFuHrYiCQqcI4KcAWQalnUO7YzUdWUvPRnPf63XypbwUJ7BQiUI1QY25FaCEKer7CbpEzeanVIelAiFB3RS2kBT0VO6uvM2Gvol0/js6G/dYghywpqOXNoibzwJps206S2ji0P3y4AOHttdT0118EZTLv9ikzo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770759101; c=relaxed/simple;
	bh=RAJIcwvaLHdHKEKJFPdFmfSKdn8vF6DCz0UU8DIpnfc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CnOupE78l8Qdhj5IScnk1BQUa1FpO8fhTxVM7kb/nWYOTAWYIJfQGYdhvlLbOEo4eWRMH1jhBhu7/U7LyS77eRPaCeQpejlB8L5w0B5R3ivOP+GHk5EJfmw9c2RjIiqjytOx9onbaxJbmS4atixYVX5aGdDuMCkxUSEQ+qvnH6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hm92SuJx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C1DzL8mZ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hm92SuJx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C1DzL8mZ"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 409F27A01D9;
	Tue, 10 Feb 2026 16:31:38 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 10 Feb 2026 16:31:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770759098;
	 x=1770845498; bh=7Y4RKEzfCXHwFofLJX05iWvTMKeRaRQfQWfQcZwblfs=; b=
	hm92SuJxHtCyF0KRZYO5RSOQlIoZCzIHueEsmSe/L0zgAxsN/TMkfQn5zxd8Yqpi
	/b1JYT7uMwXOoAccCezoP+mRw0FGGorfvNx5f0dkFp6ES1zo6IQam40J5N0dynGY
	v13LzV+NkjTTG3HTtBKsL6Ehn/J21yqj4Kl+u3I7fBxBtMfzIxkGZTeLqUKnegoT
	+zwh8LfLFRuvKB+7qgMzuKM5Zal8tTqE6xW2tZAJ1hamMePKkhea6N2BFqZUjWFA
	cRLmWA/lMDlguYKlse5Nojn3XAFNQeEZV5eYVT9fw8nN8utcxXkNOb+WhTZicB9p
	yF87LwsB3/5CjYUdbSfyTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770759098; x=
	1770845498; bh=7Y4RKEzfCXHwFofLJX05iWvTMKeRaRQfQWfQcZwblfs=; b=C
	1DzL8mZgPxjcKqJnlhj8dMEC/ffzQNiii98pi9lb4LNLBWBD1PXzpuIed3GPekVG
	0Kbza6TCrlkOA4MJ2nIK3+uN+U+0QOPABZWNfbUuvSc1xZcbHZlLT2t41qfr7HSN
	Z87dojkMoEVKt+fYxfIPlImYjrKEu6Y+6+By/oiUeS0/8xYI7wjEeSIS3d+eH0dB
	9ZJpO9V/+EhebCuq8DPgN0ygy03XL2htOtTljZtiExRNHL0xi2sBHbWIbni9dgkQ
	uJnc1bqATVm4r0Uf3FxUCEuZC9n1ZkeRB4esd0D/iNOsSZH57VH4+JycRy3Ub4cB
	Hciwlr99r+O7i5ie02sHg==
X-ME-Sender: <xms:uqOLaUM5x7geXJc7i1BIP_iMdTok3ksmy9U3wIAaqQpDN85kdaklOQ>
    <xme:uqOLaR9UOPGmfsbJIgTbL4dUwjfFjHFboE64IWHKNgT1APC2-suNhKjPE0e5bqK6W
    hVbe2gnkdEb2Y88oBcAQ7FMDNrbH_08YOaQPDTfPXU98wEUy3HcPb0>
X-ME-Received: <xmr:uqOLaQS5DS1e1UwskWTaXYHrCdkHNMcJNtvBS3ZSwjNy2pdDlv0dyJYOjTgkvjo-VjB_6_2rghFYIF7syQzikzbZ4qSS9O5IGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheplhdrsh
    drrhesfigvsgdruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uqOLabls4WP3gQh5Q3ZSPgfvqL9uiHracIkAja9I-jpa336qa44Acg>
    <xmx:uqOLaYS2dmRk6NjUMY3tdRif1V4QQWWh3yMYAqf1IyO7fVEpEq9udA>
    <xmx:uqOLaROczHanyXxoLhZTOQ-VZjPWBzz4wC51dwgK-h0TfyBCGiF3tA>
    <xmx:uqOLaZWZxkz-Cu8AtCtWPBBKItwLpvZ-0ewVGLW28feHkdEUKcHW7A>
    <xmx:uqOLaRMGvHCzWKM59rYBifUVxNPr-lDIMAMeQSQQPfn2j_Jg8jh2DnbO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 16:31:37 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>
Subject: Re: [PATCH v2] xdiff-interface: stop using the_repository
In-Reply-To: <aYsylzWZXkKIYzOz@pks.im> (Patrick Steinhardt's message of "Tue,
	10 Feb 2026 14:28:55 +0100")
References: <f58fa33d-b015-4339-819a-9d91be60cd0c@web.de>
	<59fe4ac7-605d-4eae-b13c-46996dd8814e@web.de>
	<aYsylzWZXkKIYzOz@pks.im>
Date: Tue, 10 Feb 2026 13:31:36 -0800
Message-ID: <xmqqecmsxp3b.fsf@gitster.g>
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

> On Mon, Feb 09, 2026 at 08:24:52PM +0100, René Scharfe wrote:
>> Use the algorithm-agnostic is_null_oid() and push the dependency of
>> read_mmblob() on the_repository->objects to its callers.  This allows it
>> to be used with arbitrary object databases.
>> 
>> Signed-off-by: René Scharfe <l.s.r@web.de>
>> ---
>> Change since v1: don't add unnecessary #include
>
> Looks good to me, thanks!
>
> Patrick

Thanks.  Replaced and marked for 'next'.
