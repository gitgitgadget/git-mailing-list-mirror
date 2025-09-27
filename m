Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C9818DF89
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987625; cv=none; b=mftDlUwWcYrFzdfd1oozWIzXFc+a8UYxK2J8JbfsvSMIl7zlKhMU2F3qrmbmgXb7Be4yMc76fGDyI/9hDHiJpQ+USMHTod1smf3GjCaKPJE8ANB0KOxRvVeaP9Bx5CL4MZN9Q9pOW3YoIuKP+dgSFGmDa8YkPpD1aAhV5B/FdTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987625; c=relaxed/simple;
	bh=Bryl9xO9u7QFJcOfK1awDNj2R8o2ZUdlSx7TWZutfDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fjR6saFKQ2vSpkZtWqd8ODNCcJM7G1Cb7Okvom1iq213NlBOjxqWJ/pXPHGABXOv4gs/CmJl/+jBWNNTpieL8q0nGkKLkFkz+zT4lsg1cytTerOckUouMz5fZiAyWf4sc7s0XMd7DJZYIf6e0BUe9HeWY3Y3Zs9GDFVhwM17+OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DkUA9Nz1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v9nspZTc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DkUA9Nz1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9nspZTc"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 682237A0101;
	Sat, 27 Sep 2025 11:40:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sat, 27 Sep 2025 11:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1758987617; x=1759074017; bh=S0oV+jZ7JB
	hNvzzhpGv+g+r72Oj9w5eilyBtzsKSj9s=; b=DkUA9Nz1GnF79JsI9j+sPT2tUH
	EmbPGdWew7FsdYJoMYLaS5JPANFmO763wJW1PRVsxup4Lm0a6NWQJa4ujLxa5BuY
	PxL2FjgaKheU/yFa2HKuEqpJa/OMhRjc5OEn2xZD+3REtdQbdiOcTSnQvizpCUYc
	Vfk2LL8Q+YJf/Ol1ouhL1oyqxCeALazLSCNXn7Z2usv/Mbw+9zucv9pqqBcJa7PM
	55+EWLqJWZxDuaIqqaI3DXmd+23t7352wxOoeROB9ZNfv8w8CEutlF8WsPM4xfnq
	2f95zDJjAqaLcQNDXx4qzcZ8HALw2vd+CeNtLyk8NbyUYasaxsH6zjqHTZfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1758987617; x=1759074017; bh=S0oV+jZ7JBhNvzzhpGv+g+r72Oj9w5eilyB
	tzsKSj9s=; b=v9nspZTc3HQVIuH3g0iY0o/eyqiVBx1xdZIvtlOBWemo3V2RyJb
	8cgk90CIEWsY6eIGkZA1e5aouBvnXsHhVV0Jf81TidLe6w1/X3bIX4ubISVfwJcV
	8sD4uT6kIZlERyYaw3Ir7BUWrCxX8yR40qsZn37MEOGmdif8SbcAuh+DnwpQnadV
	eSLHFrECz2GXPeJqkrlV15GyNAMty2guqQZah/jSbOZvtY81lW7sko0G9EbumEvr
	yO18KV6HCo07nFZI0NiKfzskBtpP9fNVEyghik9+NTGNBgQLKqpDvsYgRY7PvsWA
	ms6mh3OFT9TfjBoK2zaXkuch0xV+capuHvA==
X-ME-Sender: <xms:YAXYaCAK91c9gNUKp5e88zzIZ0D8okK1T4s3HuKk-xOYe9oeNzMpOA>
    <xme:YAXYaANROXRXKEoDqoWz_uijG8-e-0HyGVcrX8x59fD3qUNU9uNf0s-Pnxy24rCns
    PuJZUEOp4YYZ1A9nq28pZVtMLV5dA9Vpv8LXimFVIaMJy8XvGX-mdo>
X-ME-Received: <xmr:YAXYaPaKt4y9naVP0rl5471Eq-7MK4obQBh2eYGtP6Uw1hXUYMENO-QIfHgBuxELpLSAZPZEyX6EqQspIfM9x1Bzea7JJnANj8Uh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YAXYaHuetCOquKhmKsqEFa5vuZ42Crb7yfdyZp0mLthylTFhDb1Gnw>
    <xmx:YAXYaJPLI6R-j_uZLleXrJ-Ik7QOFh3MPj0gOcyeRwO9qPCup_cjHw>
    <xmx:YAXYaG7e18DWIlPa1Rvvog4MyVOaYQLNMjkWEQFXseK68XatUTRMAA>
    <xmx:YAXYaHT_MI3Tf9-LfyoAG6ISFFXLPnmKH8ZJAPNZeMX7WjcI0_PHZw>
    <xmx:YQXYaLHNoqQpgSyJrD1jzrGlyhI1C0SJxWQEx4XinNaYZrerNfBFtAPf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 11:40:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  karthik.188@gmail.com,
  sunshine@sunshineco.com
Subject: Re: [PATCH v4 3/7] clang-format: exclude control macros from
 SpaceBeforeParens
In-Reply-To: <20250927145049.723341-4-jltobler@gmail.com> (Justin Tobler's
	message of "Sat, 27 Sep 2025 09:50:45 -0500")
References: <20250925232928.3846-1-jltobler@gmail.com>
	<20250927145049.723341-1-jltobler@gmail.com>
	<20250927145049.723341-4-jltobler@gmail.com>
Date: Sat, 27 Sep 2025 08:40:15 -0700
Message-ID: <xmqqv7l39a5c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> The formatter currently suggests adding a space between a control macro
> and parentheses. In the Git project, this is not typically expected. Set
> `SpaceBeforeParens` to `ControlStatementsExceptControlMacros`
> accordingly.
>
> Helped-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  .clang-format | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

While this may be a welcome addition, I somehow do not think it
belongs as [3/7] to this series, whose theme is about "git repo
stats".

Perhaps make it a separate topic and have it graduate sooner?

> diff --git a/.clang-format b/.clang-format
> index dcfd0aad60..86b4fe33e5 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -149,7 +149,7 @@ SpaceBeforeCaseColon: false
>  #     f();
>  #   }
>  # }
> -SpaceBeforeParens: ControlStatements
> +SpaceBeforeParens: ControlStatementsExceptControlMacros
>  
>  # Don't insert spaces inside empty '()'
>  SpaceInEmptyParentheses: false
