Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30083296153
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747070320; cv=none; b=lDTEJ8sWUeDTRSjPJmSwHJsePY/zpr8/D5ZW1N3V1p3qNbS+8OcylF4xrnq0AVclx//yrvZikEovDxfW7WBh/8GA+EOEzuRd4YGHGGqmVoOWGi0kHqFX9IfMFlbds+M9vBhcca4AqWChIs/dxaHwra1lDwioj8+dHDwJrG7tg0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747070320; c=relaxed/simple;
	bh=qGT93tVzM76IYmvDc++NrPlKLkkiBwirRJp8YDdKDaI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rv0OfiTx8T/3Nx+EQsleKCqMM4f/ZGiLjg2iuyhUJcyBfb0FNQUusdtzWhP9ByhZ/GVoa/Eif8y5DPs7shhUt4rT5PGsZXAp5KgPK4+XrsoFnU8nlQJpMJ7UYDCZyy/T3J+VEC7YFkoi75yUbNlRsPrbYJQhNuoJmhIShnb79NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W40rozg4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tvyzFc0T; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W40rozg4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tvyzFc0T"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2207125400BD;
	Mon, 12 May 2025 13:18:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 12 May 2025 13:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747070316; x=1747156716; bh=qGT93tVzM7
	6IYmvDc++NrPlKLkkiBwirRJp8YDdKDaI=; b=W40rozg4OlZq0rcz+otsgtYP3W
	ZivdYLSl/ugrSwCLp729bdktO6uOG1wOpn9WG1OQZcRJrE9pE++w+72Nz0qRJiL5
	DSuD9cMD21L2/jq/vo94ZVlkzjUVwvhDJaYS289t4/wEe7Z6uEdJkxKPLsdWb8PV
	1+Sr4s/AKxFGhgw9soILRyH2IAaCC6YTeq0vStVVgSf8g9xOcIU0JfhjQ9Xb8eEl
	Vmh19cL4ZLsmkRfoul+nS2y1OPeAQNdNohJVRBeqVDZHCN59czqY5bbk++lmWVRl
	FUxd/TUOEHKa1aUvw1MrH+vzV3juMy3A40koVkecct4MQaB8vPYf6X/A1Pug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747070316; x=1747156716; bh=qGT93tVzM76IYmvDc++NrPlKLkkiBwirRJp
	8YDdKDaI=; b=tvyzFc0TVQCLNCSRDXl5iAM61TLiqhlcAJ7ARz1SNaLCZ0TgT3y
	1QOsdraXVwIvr3sKYtj0Urx8IZOMT7qn4YiI4sXtqn4gQDF+NhvTS6PzY0bQhVnJ
	soMwkTgo41RPc18wNXY1laEFZmQ6nMFq/JOeCp8IO/1xX0h/OONIFMGfxxpD7EQT
	nsw9BnDKEX4tP/iJNMQpW/mHLTwMaYY+6vv4uWWF35bT2NOP4G2C6tfFDukdg+vo
	dZn5eA1bdcyzC7fCUhveLqD3vnlEufUaoOgaihgScJJAaKJO6SHYAJ9fE+TTNt4b
	UG8dJFWz6rLKri46pSUE3/+zOsRfARW9lCQ==
X-ME-Sender: <xms:bC0iaJgxu06KRSxa7eyiMysYlpXQswOuAFrw-lD-HjUBVyTKsFU3zQ>
    <xme:bC0iaODJWIQHTIdDHYODOpDERALlbKUpAZ-lkj39rF6GKwtjZ8b_nsdYUYabS1s-H
    v63-8YLfEOeckwFRg>
X-ME-Received: <xmr:bC0iaJGMDXEZf3uF7IY7PvWjspCLPZwUMzz9GFJr9Sg021IrvYHLDFhHWqhC1RzXcxNxBhnBlmXjJa1WhOZBJQ51Etp9g10WMTV8yi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhhvghj
    ihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:bC0iaOSLnuf6fbu7gIeXcSiiGivzRc_aO_tok8N6RGsg14TkmdSjCQ>
    <xmx:bC0iaGwspPokvRtWgGdKyjj0enOoNEtMmeq_DJ10G9ZnmZFHcpO3QA>
    <xmx:bC0iaE6ORlTlIqF9iracP7LezpiKs-MMPEIamCq9mOCY8X5msbpSaQ>
    <xmx:bC0iaLw8aoyqO-vR6olcBKK4_INex3vRGFMGRVAwwI_xW3Qp-FGGbQ>
    <xmx:bC0iaOOXuhjnoMpYRjsWxlv3f7TXM574gwmF8gYznJPwUZZl8NQbiJYo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 13:18:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  shejialuo <shejialuo@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
In-Reply-To: <20250512155654.GA1219668@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 12 May 2025 11:56:54 -0400")
References: <aCCtQDnWII-knmEc@ArchLinux> <aCCtx2mqihlc0M7H@ArchLinux>
	<aCGzIlLH_ESNg6-v@pks.im> <aCHoovrKiSUemBCL@ArchLinux>
	<aCIIL6IWiiWiGbFd@pks.im>
	<20250512155654.GA1219668@coredump.intra.peff.net>
Date: Mon, 12 May 2025 10:18:34 -0700
Message-ID: <xmqqh61pu4r9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> It may be useful for fsck to detect this, though, even if the default
> message severity is set to "info" or even "ignore. That would allow
> people who know they are using modern Git to increase it themselves (I
> don't expect normal users to do this, but it would probably be useful
> for forges which run automated "fsck" across a lot of repos).
>
> And then the backwards-incompatible Git 3.0 thing would just be tweaking
> the severity of the config (and in the meantime, it would help flush out
> any unexpected instances people run into).

I came to make a same comment but the above has everything I wanted
to say (and more).
