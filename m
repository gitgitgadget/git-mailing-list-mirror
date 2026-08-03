Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F95257824
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785771555; cv=none; b=KxO7J8xB9W2ioI+UWIbJADaIkGMaD/QvTsZ5rUeV4qMjVbySP+bje9h9Y3YUn751ltdRSfnQGD3gtpe0jicqylvnpiihh9VhJ7TE95YsDkkfXf4d77EiUxiOU05bi5NQa+5c3otTaVuxDYggePIaTA9z/RNgiUvI/EInS1tynT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785771555; c=relaxed/simple;
	bh=Tcgk4dxeBPtq1ljYnIuKdrt0CFxgLnRHrrDfTqRP+Ek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aKY/Jc4LugczyxhbW9CwrZuzWTvTxqUeHjoCpKeYHMtFasW8A45yxMA+DR0EKN1z41fqqbvWcM2Vk2vJ4s2VWo+6q1+VCJJTFN5E7Wh2XBMQmF/vrgEXKdCFCexUJbsQnDDPH7SR2RJg6QAKTRCWxpnbC5pr9FzaxgByWDds3KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rDWvqqh5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hV1VcC9G; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rDWvqqh5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hV1VcC9G"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B497B7A0105;
	Mon,  3 Aug 2026 11:39:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 03 Aug 2026 11:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785771552; x=1785857952; bh=ITcGQNGp5J
	osytGJXIhCcKWx1xkYgJztV7Fw1TJeakc=; b=rDWvqqh5o71BYTWHRIFUH3Zinb
	Sol9rdKlIBMfxIGzEzngmThrqE81ZnktnBJ076RD/PmR7WrXkbe/4ZFILCOlvFvN
	46taNCHWQYwDbVA9yeC8cCgtrL8DJNC1i2EuVe5nNOpFoH41ZJtf2HM9pfDTJWyP
	Xu3vF8fwqVVvGN7rJVr6D8E+no6VUMYubhn03L2SqIP4Qkmkm0WNDcBNcfgX2E7h
	9QpVJsvTQcucp+YpzxVXT9HmJWbN+NVpbAkqHLgaKvl6Rb3nqHxt5++J7bq0as64
	UUl4ZeQqdqt+h+yl4X04DL6vs1elkOA15MVYv3gfYPTrnxP5F3LhagygqcsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785771552; x=1785857952; bh=ITcGQNGp5JosytGJXIhCcKWx1xkYgJztV7F
	w1TJeakc=; b=hV1VcC9GCysO4fWt37JxXBEs7tv4P93KT5fyg1Wqx0csPA5xezi
	wBCemptlW6enXxLNilUvSDC2NRouPA9fEXlqUXFmoK4Kk774bItKZ4PNMaIEs4u1
	C9Np1WyDyd0ZRpDQK7kWylxaoPeYesNJvxeTmS9jUTe4GR4iJEHFw9iGke3qVzir
	8bpWK3mKTgNTcuzUU4Xos4cMQMcECOdQ30WahAusmva8PGKzSa923ULQN8azWyXP
	cv62bNYj76MJtwJpWcGrHpty2mNJ+E2ZUjNBHu7krtDbAP2u6WH6ycRP/gCOnzc5
	4syA2Eo8PS6FDMxFYE5FTNklrJL785dL8vA==
X-ME-Sender: <xms:ILZwaqgIQrqFbB7YE5ErijsRwsAFHm4rDKbROBZyW9jR-_2g3aseGg>
    <xme:ILZwah6G8Wdd52VoaWlOPrZfV_VSxymzwwb-F2ojd51th94BkuWXv3eDdU0cCmD1K
    ynkkKtMnWkNl7cK7MagJad-HULsHJD1MzqWqnXlwc1waL2z8w3q-A>
X-ME-Received: <xmr:ILZwaqahD4v6fgyPHO4uvKmGyasU4Gwvst_8GDqlfFuZEGSZUOe4vyYgm5M9sGu9SV73Y0icQiA4C3Ig-fBrKExXCwdd4iQFag>
X-ME-Proxy-Cause: dmFkZTGelDltJa++KB+u1oVt+ehkM+ltufdvGJz6xEuGN1MXmRF9y5kJ35Xpkr/YT5nAF7
    VJhrn40/8ilB1fBl2XB4wtu6oB0YM2x/lnvAZpN5iu9ldipZrSFIiPXd5NQEL2gUr/cSgI
    hBoJ9z27QZPFviaJDLBujFxx+5Nad6Qoff0+uV2qES2Hhm6zyw+ZHyrqRFVcREYdlSNS8e
    sJqTGcp27UGqOxyZmbH+8751OPPvhYfa3UQqvlKuUd8+Gt7h4WLYvqUOnDuVSYbRytt4Tt
    cPSzX0kDd1pzYpWuNXy2sl/5gVsZy/mjdxOX+QoZTYK83buG1Aca/S4X/1pAfKUBBAO/N5
    mJEF1g7B+64vZM32Fe4DEYK+9R+IDbjmZ6XrUQAe2brWqmUTuanVwEb775Hr43KOMEY8fz
    BSqFI9lcJs5qAtV3geqGud514pRiImAteygJUlDdhoRsZGLZTEdAZIsZobe8Q8DebkZNA+
    0yRWhX0vdkvErdHs7Xt7ll+UmguzTYK3Lb2aDB8DJlpvIxiHw5RS3/ELGhR7VZb6LxSvWk
    oA8mbboMnjy5ZCdOr5gGc3p9pTZZS6TlqKnttpO7yZhiB2EJzETmVJI7sFPJQGbI9CHomt
    ZbLYVekTe6Coj/JbPZ0JzWC+Gndig4RM2OoJpwG/2Eej6QoBj+f5PrK9Av8A
X-ME-Proxy: <xmx:ILZwau4hjL-ptUTpdmZ0T7CdyKCUm-g63NmSapRnEnaHX_69KnCylQ>
    <xmx:ILZwalADpFX37S7jeLfDXNhyG6l8SZf4Lh8HAkFFYfbPImXRx72_Fw>
    <xmx:ILZwaseii0P1Yd2sWs69-Ii5rmu1VaGEdJNnerUChLQUneBMcTUHPg>
    <xmx:ILZwasJgYC6lODfWfVcjvpd2O3pWR47MZeg_PgOhVuTEluHRcxGDHQ>
    <xmx:ILZwavjxEczBKdjZ4ciYpbduOqvNx1kT8eXfsvz6wwLxammYmq-pu8ZL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Aug 2026 11:39:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: kristofferhaugsbakk@fastmail.com,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH] trailers: stop recognizing URLs as trailers
In-Reply-To: <20260803152025.GA189075@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 3 Aug 2026 11:20:25 -0400")
References: <20260609004340.GF358144@coredump.intra.peff.net>
	<URLs_not_trailers.b13@msgid.xyz>
	<20260803152025.GA189075@coredump.intra.peff.net>
Date: Mon, 03 Aug 2026 08:39:10 -0700
Message-ID: <xmqqtspbz00x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> As discussed elsewhere, we are free to match with short-circuiting
> because of the NUL termination. But that also means we could write this
> as:
>
>   if (starts_with(c, "://") && !whitespace_found)
>
> which is perhaps a little more readable.

"little more" -> "much more" ;-).
