Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3021CF7D5
	for <git@vger.kernel.org>; Mon, 15 Dec 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765786872; cv=none; b=gzrBpevXrDane2yc4DzJuoDCTDT5fin+QDnSilKfYJOgVgqMWjdK270aFATLv4KnLbnYbWa8+dtovNGPFiOCCa/p2Gn50/IPQur30zwy9tfrWbXJSYvRdVTe0RH/Qv1V7PhG23N4GmAzxE085VqGVFlDslmwhKIJYDNUl6i9/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765786872; c=relaxed/simple;
	bh=q/qlMVhwON5xne0cGuky6l1XwtpgZXHLg9TzCuAMRuw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=odroKI9Rd5TBwBRcWN8QemtLBlhT1EaKol8+rUAr0f4YjNh6uTTk0yZsJKyD43JDhhHNtS4ehQ1hrHGBlj03vLz7v1BdtKX8F0q1BvjT2g2J9iTzIngSe5qGWvubWGBHl2JR2rtXmQUzX0js7FZKgel+mnbrqYQE9trVwa/So/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SWGzNI/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQ5aKKo6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SWGzNI/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQ5aKKo6"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 630227A0009;
	Mon, 15 Dec 2025 03:21:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 15 Dec 2025 03:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765786868; x=1765873268; bh=IJJIKubGzz
	UATreLZrn7uUUROzQhneKLq7CWyeoJAWg=; b=SWGzNI/npiik88P5wKp+iZ2ni/
	NRWRAdw28CbPvr4Gr+s6iTj9/xQm1EpiLpF6jW0aFjQgk8GGiWeGeN+ul3bqLCq6
	+gh3dP2CMKc+6nAYbcEJchhsXfDIsgpsfVgB+ZNy3y8rnIxo+ihR0hAKcqS89Ul9
	74m211zIF06akXfiQL/qlmjD0xyojbnhKyXCTfknXoc5G3JPp78N5tA2mH8OGtBO
	LDI8gl45ZCzcpNUeSBwe2LnfiqKFf100G0d1Sa0IGyUgwurYMjNvc4LdVR6i8wjC
	86Hjz60z5xriGLZUaQ4Lw3MS51E3IzyyAmZBfzc8P7Xt7my1bLc6bhLUZ9Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765786868; x=1765873268; bh=IJJIKubGzzUATreLZrn7uUUROzQhneKLq7C
	WyeoJAWg=; b=nQ5aKKo6QFz/5h+J+T6w7oPHUlf5WDmMIw4E1NQMPIU5gF49/fB
	pKsYM48eYR4lGzO2V1SbxCA/EqBCu4L9qv5BETK4errbDIyxKJHyN3+0uStRMV+5
	NPx5j3JFFGjW9LJGPE0tR7RJWB+M+dWpQn5Q14e1XG2Q591pWl045E1FvCRiRAu6
	codVE4r8vwrylS9XqYJatq4SXHgbj4GvCqk1vps1/nQciKvOrmbvzdf7nc1mt4xh
	lnqMPWGsVpuy2xJ/WcbVUBTE4yoZbwQuc2zfKZZDsKv1m1fABmjPuDsrTGYu7a27
	zLtm9p4ZKUWbPuHx5X+yza5hJtHeBzt74IA==
X-ME-Sender: <xms:88Q_ablszEzZ4rqSCqiI29v9s0ebzAx_KOQxy_mLdvQV-ziLmgYVsQ>
    <xme:88Q_aV1Bc2gufYfX0TVrMu6L1NWJUdQUMJYxvO6NCU3V10lOH7s_aAWAkjlQ189P-
    WqBd1i9Kj3IFgViNjCarTZ7EycG9-3ljBJpA0YJq0AeHarJYKVXtLc>
X-ME-Received: <xmr:88Q_aWpwcluoMwoDqDmrtwdEButEahDxW_HiSYsKuxx74C4ws8eu7PZSKW9V9vaEgKCeYkBZZbLQN8P65yxMMkMuPNO2_Dle3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefieefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:88Q_aScnkSd0lrkU6hoyZvIj-tbqTfgHUPwQkVFp94be7Z8QP0xmpw>
    <xmx:88Q_aVrrL9lLXykLkM03V-vo4IxC0agV7BzBU5gD5hkzMfqZ6DN0sQ>
    <xmx:88Q_aTFfaNhtOlGTmhxu_cPWsKq_86m62ypfofvC8--W_IPfJVBqDQ>
    <xmx:88Q_aVuhDbElgMaVBp6LRbO1SIaGjQnrvcClwPiJuftKLX01uxP9ng>
    <xmx:9MQ_abEro76Q2FuWf35kW3sjNqnhWKRq0urQjMTA9VFJjQ2LNrHfgWKN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Dec 2025 03:21:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v2 2/7] strbuf: split out logic to humanise byte values
In-Reply-To: <20251212223644.3090879-3-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 12 Dec 2025 16:36:39 -0600")
References: <20251209225820.2861276-1-jltobler@gmail.com>
	<20251212223644.3090879-1-jltobler@gmail.com>
	<20251212223644.3090879-3-jltobler@gmail.com>
Date: Mon, 15 Dec 2025 17:21:06 +0900
Message-ID: <xmqqh5ts88b1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> +char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
>  {
> +	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
> +
>  	if (bytes > 1 << 30) {
> +		strbuf_addf(buf, "%u.%2.2u", (unsigned)(bytes >> 30),
>  			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> +		/* TRANSLATORS: IEC 80000-13:2008 gibibyte/second and gibibyte */
> +		return humanise_rate ? xstrfmt(_("GiB/s")) : xstrfmt(_("GiB"));
> ...
> }
>  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
>  {
> -	strbuf_humanise(buf, bytes, 0);
> +	char *unit = strbuf_humanise_bytes_value(buf, bytes, 0);
> +	strbuf_addf(buf, " %s", unit);
> +	free(unit);
>  }

The old "strbuf-humanise" used to treat the whole "<number> <unit>",
e.g., _("%u.%2.2u GiB"), as a single thing to be translated.
However, the new code requires that in all languages:

 - Decimal point in number MUST be "." (don't some Europeans prefer
   comma instead?);

 - Number MUST come before the unit;

 - Between the number and the unit, there has to be one and only one
   SP.

All of which could be a severe regression from localization's point
of view.

The first point among the above three can relatively easily
remedied.  It is a bit more involved, but it is possible to fix the
other two, too.





