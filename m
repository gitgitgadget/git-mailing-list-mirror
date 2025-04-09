Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAA1CF8B
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222011; cv=none; b=XiAZq/bqo/0ZJFTSwcZFjwrWmq4ud2YeXH+ZfeWlPuIM5HrN7rdJYOYsJs8hCqUsj00OL9YtgZxoTw9Y0zwmMlX3R/CSE6qs6PRmI8NuCRFNOSK2dwBbYqprp+A700vxSqJFg0LyEbkAnaXyz5Z7odNCHsWJE0cTPF4sfGZUceg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222011; c=relaxed/simple;
	bh=aXBlcO7xNfl16d58LBt0DIWsHDDjQYJrxkEiRGnmS5o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LCqp/c2PEhqnz2iVYPMiE+owE2O49mFlLzsu8OmX6o02MAm09REvGA0ObDZEPn44zTn4RIwPdLIFXM3KEDxAR1LWUFIv027QXVhaC55VEwbXYXecTLf2oK8q8gXQuQ+EC6kKSXDGmjoIbPyWZsktPo0dAIFvt0DnI5PLsaFOJWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G7u54KW0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cz6CQFRG; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G7u54KW0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cz6CQFRG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C1B07114017D;
	Wed,  9 Apr 2025 14:06:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 09 Apr 2025 14:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744222008;
	 x=1744308408; bh=orkPhRP51prZRJ0VQXzOVko451Y2nCPzTdyXm/oyj8I=; b=
	G7u54KW0kz6SVkGEIzlYAwZxUcJul03Cy436QXSSFdxG36ggYvbC1VGlb5o0yoHz
	Q6iHdtBWnk/T1uS39bGubEsuhfzRC8WBMj4rpMK5cbxujpXiB0cvW8pqrhAEocuq
	NuPlcP1as9tWiiDyxd0ZAu3kj/YN45xsiSYozBrKyixzwEKVC+lFS9iNh14GI8mQ
	Ephbl0//PCIhQnSfLfQwNr/edES+DPWmIev+ni3wjc2Kyo1Fv8bzIMEkJuOjsOj+
	soi/Vp8ctDc8j2EZPxLSnIQ5mA0VfV7FAOZVuvkg37iCuK9eZkm9WsfNOmO/spEc
	HfXcVvc+n+lojISTj87uGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744222008; x=
	1744308408; bh=orkPhRP51prZRJ0VQXzOVko451Y2nCPzTdyXm/oyj8I=; b=c
	z6CQFRGYWRpvHl1bfwnqoABmXHKsojw60y51/pev2EW38K+/goqo/4DemHAo0fdZ
	3C9k7iRuKDSHGxZ088C0NkD9r2kT0VZdNyizpYhtPGtWlbj3GuikpBpHbmSIECxa
	//ykOAvD3xaqRWBDV2r12nGPbvSUk97yc6P7XWvtDg8sgV4qsZQdke++d5pkxs4x
	RcBjoswbwikPyfDFdCAW0mckP06oSgNPVRPn6KQop0eNzKztAVXwIupBHw4raNT3
	b/O+mXqhxti8GWlZrEepfWb/8zuJBAIc69YKKWUoHuFDEhjFsD1/qSplXunRD9o4
	eTzs/v/HvOF3oaFydmIPg==
X-ME-Sender: <xms:OLf2Zxc6vCiUVf1oTGsrAd-fSUd0xq6v2zxxQLaiSBdXcEPlKU0HYw>
    <xme:OLf2Z_OBfztjm8Ez5dxPaIImKC-H8aAsvuQeG3zM3v8hgR8UvgIqiGHlmW_9kRicf
    kBFqwNhC8NGzHECUQ>
X-ME-Received: <xmr:OLf2Z6j-bmElp3HGfs6s3x-Kic_OfJE7Owj24VcEbj48ubuq9gJ-4MH8N5zKWfTEiFbXSaUgZA_GXAdnWoadMHbTD3fWcN1oxFQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeiieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepshhntdefrdhgvghnvghr
    rghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:OLf2Z6_J0Oys0e-DCKS7cebLNM1gFlf3H5UZWEL_UF1FAjTuGFi0Ug>
    <xmx:OLf2Z9vdsFW1ZpZ5TX804QeEu3IMLE_jEIz42wyS5KVB8wp3VxUXPA>
    <xmx:OLf2Z5HUa1RXFLa-DxZpFAYkWlsiyavnYNk3YsUuZqYGDfLLQI3rlg>
    <xmx:OLf2Z0NZLflDe2Qhs9QJSh11Q5ZeQHRQV4yW1GSzvtBU8xl8WGhknw>
    <xmx:OLf2Z8m_OuqlDsvCqGBR2FwxNUMTGOV1ON3-nVg4zZpPvPMRO7Fu-1FS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Apr 2025 14:06:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Subhaditya Nath <sn03.general@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH] t7422: remove extraneous argument to printf
In-Reply-To: <CAPig+cRe9BQw=U41uOprZ5JRNgNTC46zMpyGjNy9b=y-hA8-tA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 9 Apr 2025 13:00:40 -0400")
References: <20250403144852.19153-1-sn03.general@gmail.com>
	<CAPig+cT1dQL+MfUctyw=9O5Wd2yUqA40pXSgsRHKfNf=6vxQ7w@mail.gmail.com>
	<CAPHxB8un1w-NBnfLne9d=vv9Sqa69eGoLhjOM0GcmhgkYKt-PA@mail.gmail.com>
	<CAPig+cRe9BQw=U41uOprZ5JRNgNTC46zMpyGjNy9b=y-hA8-tA@mail.gmail.com>
Date: Wed, 09 Apr 2025 11:06:46 -0700
Message-ID: <xmqqr021qkeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Apr 9, 2025 at 12:29 PM Subhaditya Nath <sn03.general@gmail.com> wrote:
>> On Thu, Apr 3, 2025 at 10:35 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>> > [...] for the sake of consistency and to match the author's original
>> > intent, it may make more sense to retain the argument to printf and
>> > instead employ `%d`.
>>
>> The problem is, there are multiple ways the printf statement could be
>> written -
>>
>> 1) printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n"
>> 2) printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-%d\n" "$i"
>> 3) printf "[submodule \"sm-%d\"]\npath = recursive-submodule-path-$i\n" "$i"
>> 4) printf "[submodule \"sm-%d\"]\npath = recursive-submodule-path-%d\n" "$i" "$i"
>>
>> Which one of these is to be used?
>
>  The final (#4) seems most natural.

It is unfortunate that this one needs two identical things
interpolated so the overall structure with "for" loop needs to be
retained, and within the constraints, (4) is the only sensible
option, I would say.

The other one in the example in this thread could lose the for loop
by doing

   printf "160000 commit $COMMIT\trecursive-submodule-path-%d\n" \
	   $(test_seq 2000)

but for uniformity with other parts that cannot lose "for" loop, I
would not recommend going in that direction.

Thanks.
