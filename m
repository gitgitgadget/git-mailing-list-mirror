Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EB228642D
	for <git@vger.kernel.org>; Thu, 15 May 2025 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747341426; cv=none; b=ee3dtFElBovuBMeKzlvyjGX2gutrdg1cHYF/FSzKtjHjv7ZgJHZtB33xg94W4OhAiP4HMpFcwfZgI4YG2zGlEKFW72GmOPGBjg7aQefyOeTOXIQm+DLwDS5uJsUKs1BkRD0NwpMkXIJAf40F8biQ5n6xJA+9Kr7W7WDguOuPZPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747341426; c=relaxed/simple;
	bh=Alx3WcaSEA3+3Nj+WD5p8DAWPdwIk2BEWHjE2qNhfr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDEa5i60CXgLl57NK0k+6tD3hN1aQo1pQ5JIgrqZcC+SYLKfzkPsZjVXPYkZMq5uo0VzwtJEwKKCIe/Fzue69RYSBBVR/Fwi0+eboESONlD6sl1ssGmkc0vSD/TmhJ3A6RVgM5aeG0EDYYky3qk3BWw4953kdDyWcuXzHg9lq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E5OiA+Rt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4hehZ9G; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E5OiA+Rt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4hehZ9G"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CE24D13803DC;
	Thu, 15 May 2025 16:37:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 15 May 2025 16:37:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747341422; x=1747427822; bh=C+bm0t8vrX
	JunFcWvPu0jrXGYQdJnw60zi3wgZi97/E=; b=E5OiA+RtcixgFhSlIEcZBN9jNy
	FO/7dKZymPxSqxjd8JWGNMrS3sCrNnacXo2XklVByXTG/N9ILfC4jc5XMAD9X6Y1
	3tNGEOEZDIEYgcc1+/tjQepC6Pbvx/jvEc/mZAEvPVpCySfDgflyrLT1JY9CDAit
	gPzgAD+2lqFLruck+1+BCxpuo9yhICxwfT9pnEye1NNk7HaXPiqqSbtIE6KA/RGZ
	lSEPu2ecIVIFXQtrB1gIW1xln02Q/RPFSCI5w4fDeZHB8otU97NUFqnAgr0utEYv
	SM0hifSl3zywJKigT4FB8V5x8cS/2NoiVfiB4EvkDdkaIZ3LfMu3Rn5tAffQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747341422; x=1747427822; bh=C+bm0t8vrXJunFcWvPu0jrXGYQdJnw60zi3
	wgZi97/E=; b=h4hehZ9GlFZhNbiWxTH56W8XPLY5vOeGf+x+swfC+PIN5VynVBI
	4Tx3QJ4Y7O72jlvxgCyt8qk0Wu/u2IzKYR1xabDjTv6ix8Yy5AhhfIi2h3EQUM51
	ylWMtUnkzxbwY3oPb3tRY27p9akJaUBhVx7OWWhnDKLUTdJymTG0fKMAelN4/7lN
	NVD82SVaZb/8aAGsPtQyXNeEbRlJFqvOI+VIrGZDi7g1CuV6gF0gFJFOP7moZDzY
	CQikKLbaDcCl+/jXOKtUq/t7SYkmmwqdPW6L9XK2r21IXTVVdwCXWV6ijc8mw0k1
	hkdsM4R7MGojErbMAXjPx1RKnyEAOFZSqHg==
X-ME-Sender: <xms:blAmaG6de5X8cd4X9hso6Rh73KPwNhIjA6Txt1KD_vPk7EP51w0U9Q>
    <xme:blAmaP73cILINaSYsNcV07IuxjJUub42VxsyuiUDNxALs-F6jYdJRUU8hjVTBRfJT
    E9YaT3d_eyAKfNz1A>
X-ME-Received: <xmr:blAmaFcjcOJtDYdp6_wwgNgcTI2vuZImhW-UTsUZ1_m0rFyuAg3JCf41fCav9rbr0-210IYNnZdkQWgMyuQihK_04nui1feuVX7CVw0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:blAmaDKilnQj2VY_lopOdXJkHszxWJ3Ebjwm2vVcaoRvGqZ2GLRyOg>
    <xmx:blAmaKK_NxjDF_S7KI2FFta40GfFPJ_-qEQRcg6rNmw-O3BQobZgwQ>
    <xmx:blAmaEzAJgzOzKnDGklesF-7g_N2hZfnrw3ZZ8sv1gIlK8kKP_QedQ>
    <xmx:blAmaOK58Z0MWhEy2NBlB59Mk5VAdOYKcVGNCccp_Ko6vXxdE_5NhA>
    <xmx:blAmaK-52R97paqR1M2ALCFU__URKkQmIb-5BSV_Hefjm92ujHPV6263>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 16:37:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 01/11] commit: simplify code
In-Reply-To: <20250515194806.GC3320240@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 15 May 2025 15:48:06 -0400")
References: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
	<767b1e74fc70d78c7e3c84a2dc5eb7b607252f4f.1747314709.git.gitgitgadget@gmail.com>
	<20250515194806.GC3320240@coredump.intra.peff.net>
Date: Thu, 15 May 2025 13:37:00 -0700
Message-ID: <xmqq4ixlzk43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... there are any non-ita entries). Though in that case I'd think:
>
>   committable = 0;
>   for (i = 0; i < cache_nr; i++) {
> 	if (!ce_intent_to_add(...) {
> 		committable = 1;
> 		break;
> 	}
>   }
>
> would be the most clear, since we do not otherwise care about the actual
> number of ita entries. And lets us break out of the loop early.

Exactly.  If you focus on the warning too narrowly, the minimal
change in the original patch does look OK, but in the original (even
before Dscho's patch, that is) the intent is unclear, as opposed to
what you showed above.  And the update to squelch false positive
does not improve the clarity of the logic as the above rewrite does.

Thanks.
