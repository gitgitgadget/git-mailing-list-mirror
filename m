Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5B12E5D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908781; cv=none; b=Xj6abQmeqaT2Lgh4dMx/g1vTOYREqUY+srUuOcVueiNFo7GnATTjROdpOx7iicjNLpvjDnr/pV8ItqKLty4LLKlOixl3KCeWfvNGlvnggdKbRmp4N1zInsGrkXQH+GX14AqNaLgOEkRZaLH/tPUWUHWm7h2PWM5i0u9Va2XRRs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908781; c=relaxed/simple;
	bh=Gl+7wLvkBX0/4/540cH7hUxTcbXGMXNJhNWZGe0D0Vc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdcFimrbsEd7xb4J0mBRq7g7mFuirBNiQ8A4nnKPD1noL1EyjvjH60IRjyGY6N/XSoniwS+19kTl0xLVRIgBdy1Spgi/ZoyICbw+Hx3vukIUAqB5URJ5CLE3ieS76SiUxm3lubB70aI8Ila+IsW1l5FweEhLLqbwNJyodkZ/sys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=S7dXOeeN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JOoplgwQ; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="S7dXOeeN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JOoplgwQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D61E1380604;
	Wed,  2 Oct 2024 18:39:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 18:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727908774; x=1727995174; bh=YMKlqtCLpk
	Or7a2NIG9+OA5AMZxR+9z6q58HPA0o4+k=; b=S7dXOeeNbT1ccABCufyHYojlCk
	WbUQfPQepWreLjStbIRfYoSxXJZiwsr71WtcAjwShBpJwU7dXjUFm3esroWVe4Ms
	s1CBHcaKjZbh0p9iRgJzJ/dAYdyY2cMIUKLuRwR6A5elJvmOPh89Eo0LTFZ/8tk1
	n6xSj8rRjtFKp7bWoAZTgTFjOZJ+CQyvf4sS7Kp8mVevD+ADWdnzxy6HezLnrSTt
	ApeYIU/27abIcafynUkL/THjoKi6qELgntqD4c3auImb/q1TFI/gXlOiBB0Rvcta
	sTTpa4E/qmPt5AStrrz/dxadVh2Bdakvjpi2FFq6wft/LHlVf1nYNS9nJU6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727908774; x=1727995174; bh=YMKlqtCLpkOr7a2NIG9+OA5AMZxR
	+9z6q58HPA0o4+k=; b=JOoplgwQnISJklorG50dfpoUBsoGfejB1gBRVPbjcSKP
	wu/HBuqOEynQNLbj/YYEzntsZSSWvWGCjWTM1KDwsuImXLR25GKw4QMffKqwwKB6
	ZX6Z60KF68bS+IK2al23K0cwTybz/PfyAXo/7z3i7gU8Eruo92l9GzN3jCYVNFFX
	K1FYJ2V0MyE+Td03eqM7KzPIMZ25/kRWpRrTH4bYqo7LUEEgnzB9BH/vkoy3Fo7V
	NY+YkUc3juR/mCtD2zttFl3DT01a1IV713xn5ekYncaKGSZse0C1zslfIL0vBVzI
	w8WRhovOe1cLpCsCBhs17ROHo8uB+dxBFMlFNWU6Uw==
X-ME-Sender: <xms:psv9ZtFSG8oiqFEwgjJotHHAVzQggw8GAcVb3_5GKXNDWtwXnqH9_Q>
    <xme:psv9ZiUlrHixZ0SkxhkeCEV9mAjbB2ob3Vo4a-2xqwtCvlfVVEf-AC7jIzMQJiuWb
    pM2WPwiJ9mMrgMnqA>
X-ME-Received: <xmr:psv9ZvJmJ1ZIbwj7CM2RyBMjIvHMUlDS7AHgQpvV3crD3kyFpNoHfHOLyTUx7QCglHir12x0SKZXEFcandp7IkTRKMw-pWIykQyk_Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhhsehglhgrnhguih
    humhdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:psv9ZjGtPx1oOy9D4MquyQw2NyCd19kOf_egxCaXumsjT211_StbAA>
    <xmx:psv9ZjWIJg3e7Wu-uDakpya3HuGRVceCG26fjUvZGwY7ZDYnfd2F6g>
    <xmx:psv9ZuM4ij_4YFl7z1HbYA25Xv_wq_ivQqUJ12eDvmla_q8Hpe7OEg>
    <xmx:psv9Zi281_p0HD8U9Jsb25Ji47HZDzMTt2E5y0jAgNigRq8SH00bow>
    <xmx:psv9ZpzDIc6l10T25ap9vfcpEImaY8ImiX3sdZNc0aKQJxaSWwpaZEat>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 18:39:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mike Hommey <mh@glandium.org>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH] Fix unused-parameter warnings with NO_ICONV
In-Reply-To: <20241002200140.2123584-1-mh@glandium.org> (Mike Hommey's message
	of "Thu, 3 Oct 2024 05:01:40 +0900")
References: <cec3d068-38d3-4802-b2d0-77644dd425c3@app.fastmail.com>
	<20241002200140.2123584-1-mh@glandium.org>
Date: Wed, 02 Oct 2024 15:39:26 -0700
Message-ID: <xmqq4j5uku3l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Hommey <mh@glandium.org> writes:

> The jk/unused-parameters topic enabled -Wunused-parameter. Some code in
> some non-typical configuration lacked annotations.
>
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  utf8.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Thanks.

> diff --git a/utf8.h b/utf8.h
> index fcd5167baf..cce299d274 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -33,8 +33,9 @@ char *reencode_string_len(const char *in, size_t insz,
>  			  const char *in_encoding,
>  			  size_t *outsz);
>  #else
> -static inline char *reencode_string_len(const char *a, size_t b,
> -					const char *c, const char *d, size_t *e)
> +static inline char *reencode_string_len(const char *a UNUSED, size_t b UNUSED,
> +					const char *c UNUSED,
> +					const char *d UNUSED, size_t *e)
>  { if (e) *e = 0; return NULL; }
>  #endif
