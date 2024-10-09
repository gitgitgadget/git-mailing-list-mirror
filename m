Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B0178CC5
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507193; cv=none; b=aS9na5YHhWgqWtmWNuVT68MjE/1dBOafl/irziamEz8FL94zL4zAcoQ6bMk2kczt0afSBrjUNww4pD669qbhNxfF3B7Tin5GMfZK8xmmNUDX6/rD8TtpAPL2bIRM+IVbQBz/koc8k1OVapbHLbmy6kLF0cbn7mYCTbZKcVRb7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507193; c=relaxed/simple;
	bh=crhhc3/PBCO1HBnqfd22bqpTjdTrObYMVYqIs07KJrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iwjjW1u4BF7ObFYq6+2kM+aRceIiEUH4vCMdVnL3RZCRZMyZ58BTbBK9MdlA0oVNL2LZ8tLWn+0+sU/vcL49g4zvA9UrMicv8E84zxnZhwcf/pVFintHbgQECxQNZ+hvp8BLlxZDEfismYjFI7w3g2nfc03g6PTzvjFRC68a5yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TMMFf7aU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niu2lhO6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TMMFf7aU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niu2lhO6"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F4611140142;
	Wed,  9 Oct 2024 16:53:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Wed, 09 Oct 2024 16:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728507190; x=1728593590; bh=4nVTFl/qpr
	d7AtX54MmWxJNO/1wEkllqQi9bY5FzD/8=; b=TMMFf7aU4uXsIfLPIYgRfGAq/r
	yW4ULsgeRKPYiZCiz9N273EGvkvMfVYVU9Zc4Z7oQLPQNOUjVY+1F1N1UuIZwADO
	SqtgeEh/im0Ls1LWgaPGqFmSajk0olhXFDVRQVIU+Ip1fQrRnfsgLsjCSJswsngl
	iP4CThzjJSEwE/yiVTlqTMz/2Kt0FEUuC7ciRO6zGGHmUyrbHkE6PgAmkmJrGJOi
	Xyk+AtQ29qfdqLYJWb7JD9TgkN3qWOOL5me/iPLFOCiO1N9SW2ZYAlgLh3I2Aq+H
	uFMbLRJM7kxoi6+V2iQ+D5ey618FVu8lLIfvn7/wilH4XN3pBzyvV1T3DGCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728507190; x=1728593590; bh=4nVTFl/qprd7AtX54MmWxJNO/1wE
	kllqQi9bY5FzD/8=; b=niu2lhO6B/k59Nl93/tJS7gJOix/FfzNJnT5N1AQv1MQ
	suPwTrAC3b93Pw63io2efX6zl4uhn7Q+boa8pYg4FiOzdrn89lb0VL8pnpAcp30u
	NHLYwGjCqUKOwYvZGxjx6/1WQxl/3+G5hOV07q7iiNSeEi3HyGVSUT9OcAuD6GJI
	lWZoNw/fWL49CzoarVGfdp/h2cVV0ByRg2+6aqfKOC3Yy9efu3H3tpddWnV4DnTu
	KpCuE6z0wTuBkHfYGypHyKyD925/3J1M4u0gGYsM3jOUmV3UlCI2N6QIJmk916y7
	JlawVi1MjfijVHIe3L59EnzLdDHHaM7fXOTE4C3K1w==
X-ME-Sender: <xms:Ne0GZ3JXSAEVvN1mSa5q1ToPLBH5m3Pqa7JCHa_f2MpLu9ILuoGRCQ>
    <xme:Ne0GZ7LDa0sQxo9YVZjgNl8EFKtg2aZ37uhk-E6bfjEr89U4kytEJYHYYk-h6qUw-
    hqzvpek1-si9CwAXw>
X-ME-Received: <xmr:Ne0GZ_uWLKqVEIG2TXBjKCuy9XBFiYv0u2TWnv_wus5I7RFZUerDIyTr-ktt_dGTl9NP3ZKghOHDwVi-HB1jtdLEdRx905G75OrL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghntggvsehfvg
    hrughinhgrnhguhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrgh
    druhhkpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehl
    rdhsrdhrseifvggsrdguvgdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvg
    hlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ne0GZwY36aKB3q3Y5nR7CD3ET9jvXW4Qdn_U6nihw-nHxTIYoWriKQ>
    <xmx:Ne0GZ-aVhw4TU5pNzyN78HrOmWXaDVF-nuNQsZFtjg4czg7ISO6pRA>
    <xmx:Ne0GZ0ATViVSHFZKu9RrS_DxXcd1e5NA1EZGurbEBg05dLYXy-f_1g>
    <xmx:Ne0GZ8ZDj-xNK9BGpwwb0zmMrMkXDypTZ0ybzF9ICQTqWIZFXbEhqQ>
    <xmx:Nu0GZ26e9Vzavzw4Ve-Tv3eLNHpCZrvSumOf4gEfvlu1yem4IcLLCVGS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 16:53:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org,  phillip.wood@dunelm.org.uk, 	Taylor Blau
 <me@ttaylorr.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Johannes
 Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 3/6] set-head: better output for --auto
In-Reply-To: <20241009135747.3563204-3-bence@ferdinandy.com> (Bence
	Ferdinandy's message of "Wed, 9 Oct 2024 15:57:25 +0200")
References: <xmqq1q0xhu13.fsf@gitster.g>
	<20241009135747.3563204-1-bence@ferdinandy.com>
	<20241009135747.3563204-3-bence@ferdinandy.com>
Date: Wed, 09 Oct 2024 13:53:07 -0700
Message-ID: <xmqqjzehq9qk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bence Ferdinandy <bence@ferdinandy.com> writes:

> +static void report_auto(const char *remote, const char *head_name,
> +			struct strbuf *buf_prev) {
> +	struct strbuf buf_prefix = STRBUF_INIT;
> +	const char *prev_head;

I think we need to initialize prev_head to NULL.

> +	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
> +	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);

If the symref was not pointing into the "refs/remotes/<remote>/"
hierarchy previously, skip_prefix() comes back without touching
prev_head (i.e. not starting with the prefix does not clear it).

Assuming that we fix the initialization, the rest of the function
looks more or less correct.

> +	if (prev_head && !strcmp(prev_head, head_name))
> +		printf("'%s/HEAD' is unchanged and points to '%s'\n",
> +			remote, head_name);
> +	else if (prev_head)
> +		printf("'%s/HEAD' has changed from '%s' and now points to '%s'\n",
> +			remote, prev_head, head_name);
> +	else
> +		printf("'%s/HEAD' is now created and points to '%s'\n",
> +			remote, head_name);

The "more or less" part is that the message does not let you tell
between refs/remotes/<name>/HEAD that did not exist, and
refs/remotes/<name>/HEAD that used to point at somewhere unexpected,
outside refs/remotes/<name>/ hierarchy.

For that, we can check if buf_prev->len is 0 (in which case, the
"now created and points at" applies) or non-zero (in which case, we
say something like "used to point at '%s' (which is unusual), but
now points at '%s' as requested").

