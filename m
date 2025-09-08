Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CBD30F948
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 16:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757349713; cv=none; b=gJOyN1hbzm69Qz2DvcFXAMIbQR5FN4ye8bPj6EEJ5BWjggsOrVdsr/BUOLZPZ7vrgYEhdn/10zH+JhwPtrb3qyuVw5p6xeVUNERin4KpBhKJOEhLhlQ1OUz0jQhbF9tDvPji9XRkB3T7FnylWYCzZs98vdT+shXFgFcSA7Cskyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757349713; c=relaxed/simple;
	bh=1x7tu60zmdUk6KO1EK3etnBunnZcSeKpsvF/BMxbrss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h+jRU9odiHNRR7vxjN/+rrNHdxArOdPvCsG2Un1+iKUZULweSQ5lwOlG8VqHL7Xd1jM3NPUnDFIdpL+rFIoqZSw6lKhSDkdsxY70wbWz/+yCayEGXs5ppPBx8UBEkZ6ztiLpPxyOobM9OEr7sFraBlH0Y+FMsWWb8vC3xha3Wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CLVZD3wM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=li86T8xq; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CLVZD3wM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="li86T8xq"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 507917A0091;
	Mon,  8 Sep 2025 12:41:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 08 Sep 2025 12:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757349709; x=1757436109; bh=wyZzpT3bJm
	a0ofgMg8Y+y8ueaO+QxBYt6yfW138L/kk=; b=CLVZD3wMIMW20Wh7C3UHAQSHa8
	vKz7Zy/JTEuNz+mK0pKubETu/Z8j79hkO2tQn+/klIQitkLMIuhngYLsUObdrw7Z
	2vZhNW992yEm44GIpFtdI8CzoGSCvvPpN83XlbSNU2fDgnhn8qoZG90GAZ6VOEkE
	MkH2dBOUIdzjUzOaFljuQEHVauUxZpgGbVkCULJYcUL5fKSgv7NAL31gzL7qz/+p
	KhB+0Qu5erP0kJQoaosXNMX0tmfoqMlVOTKtv57JDIb/ItRLtmCYtE7+9tWbnLTi
	zq5e0UiaS5J8SU3aTwRhj0GR8N0215+NYixRmZxtDb/AQ+b+YWser/mQehYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757349709; x=1757436109; bh=wyZzpT3bJma0ofgMg8Y+y8ueaO+QxBYt6yf
	W138L/kk=; b=li86T8xq6T8c+jsTAxOaC4sMGJcz4YGTZqbRxNGb47geGBcZ6vt
	2VhC5cGnuVlXipBgNJFNus+aq//fK2ieSeiCAGpACLLhUeBhodVuRAHA+XunzaDn
	9q3HIXo+GjBdX1JkShHSOK6A6ahEtUjxqAo+OljT2gUq4PnyeluM9C9RESLPyYEx
	bALFmdCq67r7uN0q1o0TI/WIny86EpUeweneQMEUB4EZrbfqTLNV35TLN+GeRkJa
	PlSPNifQlZ212IeJR1lGUxwBkf6eJZtOPL0TqbW7sjQkPEsxZEs0H1DLvsrMnKbL
	56W85qB7QTX6hUsmezDgpftF+Xg24X4E8NQ==
X-ME-Sender: <xms:TAe_aJEwegsAuxdtXz8wRx_SfO0AXSKfu_iBwA6MOkwulLykRZPqBQ>
    <xme:TAe_aJ2GZ9GSIUBte6JQl0i3u7Fokz3pjsQCzDkHZNeFHlrCd2Vydp-DJeRL4Wedi
    MFVsyoxcDXDL5vG9w>
X-ME-Received: <xmr:TAe_aBmJYvCYGq5HN-tsl-hivCtXo4s3mgFDNToFgoClEZiUW5oJDrhoLRVdc9Wx04iruKY1WZYL9mdYxKeva93rw-I7bCBAjGNrNHY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvggvthhsohhniheftddujeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhssehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TQe_aJ-SQifQ1ikNSepKnb98QOzitC1O4RLaEY2EkfcLv3knuhAJHQ>
    <xmx:TQe_aGqho5eUTdRTxntqEGnVQrXwRHulzQvW3NOehYtDJQD6ZJyXIw>
    <xmx:TQe_aCk-oqPdxbi2tRrnt10ByY-QvKysdHkaPMl7gku6_x6PD0qzfQ>
    <xmx:TQe_aNiOKkNUNM43F0nayftte-BG9UAcGtpiWRLgcqR5Jypr87wd6g>
    <xmx:TQe_aNWwh7j7xmzmP69Wn7mlQB7MUb81ndyq4GV8OdA7qlAA_B0sAUJ8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 12:41:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  shejialuo@gmail.com
Subject: Re: [GSoC][PATCH v2 0/5] Add refs optimize subcommand
In-Reply-To: <xmqq348xyr5b.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	08 Sep 2025 07:07:12 -0700")
References: <20250906075147.1076656-1-meetsoni3017@gmail.com>
	<xmqq348xyr5b.fsf@gitster.g>
Date: Mon, 08 Sep 2025 09:41:47 -0700
Message-ID: <xmqqfrcwyjzo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> And when framed this way, I am not sure it is a good direction
> forward to have pack-refs.[ch] top-level files.  I have to wonder if
> the approach should be more along this line?
>
>  - Define the "optimize" action in the refs API.  What it really
>    means to "optimize" may differ from backend to backend.  There
>    may be refs_optimize(struct ref_store *refs) API entry point.
>
>  - Add the new action to the vtable for refs backends.  There may be
>    no action defined for reftable backend for now, or you may find
>    there already are reftable specific optimizations you want to
>    trigger from there.
>
>  - Figure out how this interacts with existing refs_pack_refs();
>    most likely it as the backend specific option, should go away,
>    and its implementation would move to the "optimize" action driven
>    from the vtable for files backend.
>
> Once it is done, you do not necessarily need "git refs optimize",
> but the "git pack-refs" could be the front-end to trigger the more
> generic "optimize" action.  In other words, in a repository whose
> refs are stored in reftable, "git pack-refs" would cease to be a
> no-op but can perform optimizations suitable in that repository.
>
> That way, users do not need to learn a new command, which may be
> also an advantage over what is being proposed here.

I do not have strong opinions between keeping "git pack-refs" and
adding "git refs optimize"; in other words, the UI exposed to
end-user is secondary, so if people prefer the latter, that is fine
by me.

I do care about how the code is structured, though.

Thanks.
