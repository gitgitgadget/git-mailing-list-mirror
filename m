Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04A030DD3C
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346808; cv=none; b=KaVtEPjqmzKnMaYcNqUdnAqVJ0UW00rSANe5n4UvuYYh6BV7LBJwk94Np1BYbg+04xIPZZY5TYxF/6c3VyfG13JinGWGOcCdRuWOcCzZDURDEI+49eE6zE2vKNygqQwYrm9ODGoe2JvfAr9CSCwwLHxcvROP3gxJui0QKgf0oIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346808; c=relaxed/simple;
	bh=XQcIq6NXsvbydPZ3Epg6pVEEvNHBWrzPHlde4t9btA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nWF4F4jpe9B+ciF/gbhVKZAJGLU4Yzns8D6TAjAxwWCSDXyzRj6NRGggqsPxo30bjvM4W7o3C6HQJA+NsKHYT7e6ineU7y4BSZtOZvhxb9DACJ904T+CC4q03SusNaginja9iqKLcGlKUJQj/w60icwu2HTsMr4l/Lvv1WuYMyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gpR63yZM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNqXC5LQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gpR63yZM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNqXC5LQ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DAA631400224;
	Thu, 12 Mar 2026 16:20:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 12 Mar 2026 16:20:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773346805; x=1773433205; bh=SPf2akt0g2
	t8NKJSR6WPlstyFWw51HnqNuMoimxsSXE=; b=gpR63yZMp69j27s45/GgCkHnR8
	/PY40zRdqrFF5I+L6HscBmcMO+uTe9UaQzESJmoZGA9+zVklwf7Qd6EyVkv4ijLw
	mWyCiVE6CQMJpLKmQiXz4ELVxuVBWjo6Vk0kMUQ4610nmxg9HBW1EWM1jxUav0aG
	gU9ykwmKAjD2hmxsTB6/2e73DGisr5T6NGD4qAMHUeMuAzlrDGrAbAlguOT1MuJB
	3F8tZGHrOcPWWUeonyCI0VLb9zouxXzRmlZ+JwEZrKzARA7DUiRjL6eGS8WkVIEe
	RBklzC3dHXoSauUHtxRrEcPzJ68Vnb/zo7uPonDO2ptFPBhlOvBtY7T1uoAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773346805; x=1773433205; bh=SPf2akt0g2t8NKJSR6WPlstyFWw51HnqNuM
	oimxsSXE=; b=pNqXC5LQudI2BWE4fdj7OhG4Usl8oBaBvIgmw1eF5CPklsztl84
	MgXTwbAHnWS+vfVxDkWEuk0vSoWOqru0DAMYnCNDAe7THJmHJXw41GFTSPyU9z0y
	cz9v0+qYiabB4w64HueA4blzaOgfLzsmIVWatu6ptXMpnH7vU+lBswtRWjD+f8Hr
	Wt1uoFO/LSjMw5t1jyyZ/4o6uzF4l8cud7+Yz7yXuBFKLT6WJNh3P2HXgxdKDyfw
	MykbqYMyOxzyAsS6LV6p9MtGkSwT/HV3bsAwLudsnh7M48S+EGBnKjt/gFet2wrc
	/S3TeErInHULuGJBPK+MlBGArJVKfqSWtlQ==
X-ME-Sender: <xms:9R-zaZSxncRDaDVVXQECFl_u_tPdNvQzKJZx8X55DDgLtLIT85axVQ>
    <xme:9R-zaWfVkGillzSHgesky7gE_ceCgQzT5aRQi_u5ZLrAJ9RrSgGk-4HktFQB0HhCz
    kCCqYawLgoPZ-FN8FLTAWHSvQVK8BcIhMEuKXn-9mV1tHfSPhHNTA>
X-ME-Received: <xmr:9R-zaYrBHPsA544M94UxOXaFkwYMyuUsbSCF9nDjMRcq4IEg-I9oCXEb3FPGK9HTeYiHwXYaLhXvBV34hS3RtAcfWAY5KFmW6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghn
    uggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegthh
    hrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:9R-zaX_TRbz-BfUN0x9I9zJCfGGIEb_MFhDMuYhBQEZfWzIu2atqpw>
    <xmx:9R-zaUf2SGfYlg7bbk4sCOI3wo7RfjXVtjsyu1KTfm7bPTTQ24CprQ>
    <xmx:9R-zaRLF-LE4-tQlU2f-fnyz_m0xRCNxz2EezYVHgVYrXMdV8vZpDg>
    <xmx:9R-zaUiLmp4zU08x9RCMMxQu2EL6ecwbHMiTGK1nojkEurNfvZmXow>
    <xmx:9R-zaYfrv5g0_Sbnf7FJijqS-zg-A0On9vyu745PKIN29IY1fgMcnZuQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:20:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net,
  christian.couder@gmail.com,  ps@pks.im
Subject: Re: [PATCH v5 0/3] fast-import: add mode to re-sign invalid commit
 signatures
In-Reply-To: <20260312192228.481134-1-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 12 Mar 2026 14:22:25 -0500")
References: <20260311173147.2336432-1-jltobler@gmail.com>
	<20260312192228.481134-1-jltobler@gmail.com>
Date: Thu, 12 Mar 2026 13:20:00 -0700
Message-ID: <xmqqtsukdclr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes since V4:
> - Instead of introducing a separate `sign_buffer_with_key()` helper,
>   extend `sign_buffer()` to support a SIGN_BUFFER_USE_DEFAULT_KEY flag.
> - Fixed message in die().


I left small comments on two patches, but everything looks quite
well done to me in this iteration.
