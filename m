Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B85B285C8B
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776290239; cv=none; b=Qibc1orkwaGOnHYlL7H/1p3TnVaO+MjADZtJaGpz5nty1F5/+v1+U0HFz9KjYfKbiZT07Pm/2ytt1nc1xfbwE8SDXXhoZlyILKbPveJRvHy1SnjkGhEI1C3KyTsCq7RX/4zvm5MLUNO9WXg/BK4EszSzE9IFyljo8nlBJDIKpiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776290239; c=relaxed/simple;
	bh=iOA+tNjVmGSYp63QAlZEMbKC7mECgq/bzJhQUhENyCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pXh3Zw42g7gPKUp7WXLS+mRtSHYIpeFeRpeJY7p0HfpUr5QMK+CQeTpNCSsWGmSsc8JAQhecK44NKQxm5Ai5+rkWN3cG7upcyrJiVEaBehTQIKjzpYFZUqLvWUxVhP7G9fjzFuKRKiPz73ppNI5/H3DXMgSxE1XS4AIjSrgYREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TShgG3q+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U8rPokRI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TShgG3q+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U8rPokRI"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id D7E9E1D0021E;
	Wed, 15 Apr 2026 17:57:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 17:57:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776290236; x=1776376636; bh=lfu0mS/9mI
	dRhhykdXABCW/NuTvpPmQcydvihvVokg8=; b=TShgG3q+QaZ1eq1p7gqZAMq45/
	2G3qh2/ahaaNbQG0b5monStWH6j8P+Pfo7woiIvS4o73KC+b6MCWPY/ZS1cW3+DP
	YrdbPAKqfIte7i7/HZI2s0WfS1rgVXiIwNnBgW9hZeCPZtJaOGfmRA2U/MMbKU7k
	jXtoUwcVwlSMe9FSQp8iB9BFHbhtYGGISCvc3+QWuOgVTFdfya7fXZQ0atQTCkPv
	Phop8D8u9yXxtwsOWWZgY02H9z4lLQ3mPcuHhn8hifLXTUkYeyQN7N/zgyeH+E8h
	gRXH6kL8coKngGut+8RpQlCLYOuqUJLNKuOAl1AVkmlfgP91MQ1Hy5tMcXLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776290236; x=1776376636; bh=lfu0mS/9mIdRhhykdXABCW/NuTvpPmQcydv
	ihvVokg8=; b=U8rPokRIh+jRqEGYM7pcbEZCIpVXz7fyMq3XDKYw5jQklHhGqpo
	iqrKZVX0kYcxSj1NsgL3FOxhV2dn8gFvq9NaIQ9iRX0z7tCPtzSGAhjfrwz6FmbY
	yZXrB1hl8ill7hLPZ32qheFaDQVGNrFqEI2ea4fn61m8jJ/q2NooMSdekoPRYwtz
	928H+ULv368vJnTg2rCOCDamWHTMBcAbv5hueeVWcEbwpSj2dU3kpUp7tqauwmEu
	LeQq55TDEY2RNn90UAL5QwGcCWnfLvAWEMFIQv6+jcuCJiZRUbaEEBmy5njitzqm
	UVBQAo9VpK+rJBQnR7tLWtaDNaI5eMJsYWQ==
X-ME-Sender: <xms:vAngaV0xku_nOTx7TcroSx6gfl1stLMc0q_zB8Jj9jKDAZr6B3hOJA>
    <xme:vAngaS95gZzQta2Mk-1RBkWYCW5VBQHm6vecN7DuVio2gMi44xToLljwlpjM0-iiZ
    HRGeRjewQMJsHaPs95MLjCblrP2iCpF7g5Ta8NGNfiAdUH4FrmcuQ>
X-ME-Received: <xmr:vAngaeNlZxK682UZmDRqp06Yv8iAwenEMPhAykvGlSLy6Yq2BCIinLwfAeEkzjGqpGRedd6k1kHPx0yHmxcy8nmnTiJt3ZXAbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeghedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:vAngaed9dQic0uOCd-n8l-M7Nt3cOdjD6Dnhe1rBYJeHANIIWJX4wQ>
    <xmx:vAngaVXiLcEcdE174hWyxgEqV1ZjKP4ZO6tIF-Lk0EDBZQjLxFbwkw>
    <xmx:vAngaegVOtonkm1rJax2XsxCyQWYcNt8O3wvwnzpUjY1CVSolI4GWQ>
    <xmx:vAngac8Lg9JL01stimAZu7k5iLOyCf8KmKQarex9rJDaTyMXPwLBmg>
    <xmx:vAngadum3kG8zzWETi6l6CjcPWZMzMr-hCgmf65VxlxZZU4m1_aPEBLL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 17:57:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 2/7] fetch: add --negotiation-restrict option
In-Reply-To: <9a25b0fadebb5f0219ceeca9496fc6f84abd020c.1776266066.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Wed, 15 Apr 2026
	15:14:21 +0000")
References: <pull.2085.git.1775658970.gitgitgadget@gmail.com>
	<pull.2085.v2.git.1776266066.gitgitgadget@gmail.com>
	<9a25b0fadebb5f0219ceeca9496fc6f84abd020c.1776266066.git.gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 14:57:15 -0700
Message-ID: <xmqq1pgf6g5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -			warning("ignoring --negotiation-tip=%s because it does not match any refs",
> -				s);
> +			warning(_("ignoring %s=%s because it does not match any refs"),
> +				"--negotiation-restrict", s);
> -			warning("ignoring --negotiation-tip because the protocol does not support it");
> +			warning(_("ignoring %s because the protocol does not support it"),
> +				"--negotiation-restrict");

These are nice touches to make sure translators cannot possibly
botch these option names that must be given verbatim.

>  	}
>  	return transport;
>  }
> @@ -2567,6 +2568,8 @@ int cmd_fetch(int argc,
>  		OPT_IPVERSION(&family),
>  		OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>  				N_("report that we have only objects reachable from this object")),
> +		OPT_STRING_LIST(0, "negotiation-restrict", &negotiation_tip, N_("revision"),
> +				N_("report that we have only objects reachable from this object")),

Is OPT_ALIAS() suitable for this?

> @@ -2657,7 +2660,7 @@ int cmd_fetch(int argc,
>  	}
>  
>  	if (negotiate_only && !negotiation_tip.nr)
> -		die(_("--negotiate-only needs one or more --negotiation-tip=*"));
> +		die(_("--negotiate-only needs one or more --negotiation-restrict=*"));

OK.  Shouldn't this also do the "%s" thing?


