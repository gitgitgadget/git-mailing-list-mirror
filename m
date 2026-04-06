Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B5A31194C
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 21:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775510226; cv=none; b=B3Z9JBl0zmtOry6bxCivkb2ch57RPj9TxMuvrnh6zyUiYclElnQAgqmqkR946bArGZeKseNjhtBPOQIXENGt/DxtbpWg4QwSh+dmFEew3fiITAlgJW5denqqeTzyC74kDTdvONtNNgOPn/0CZumIJdsbJipc3Je7teeavsoluhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775510226; c=relaxed/simple;
	bh=asUSt2kFT1YzF9BvHLHpgef/kg+P2fu7UkF42bOHNIY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pwrgD20ry/VmuL3QVLHx5qQUw1HRdQ07XsNyRutakfQ20t1VADd/5YRjO5SO17p1nqWHplHoSJ0GH4Q17/1/qdB6BkJG4+5fCXYILRAsWGOI3JIZkiKRm7xElCjNrmpm5co57sA+dZ3lJCSx3AJrNHwr5E+fqBiXWWV6+bqdyn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VP4CvD3f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qP7F1GHo; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VP4CvD3f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qP7F1GHo"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25D65140025D;
	Mon,  6 Apr 2026 17:17:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 17:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775510224; x=1775596624; bh=wFI1hj7NEt
	lF8IA8EhPadz9sChRuzbNk5g3mZ3JPNQw=; b=VP4CvD3fpLMNBeoLiCRU1KPiJp
	T9fe9wDez1qKiClfHYR7znxq2QWKxEhbF4RGQ3YSCC4L+G8OnMsS51nDLcZhtdgU
	bbJNgLJePMzqxlMwbP/poxveSty5K4bo2ajScs06/WvDk5lzIMs+9N0QJiEeGes/
	RESIb86EdYVUU7ROtGrTFyDLKcv4qbm/VmZHMTys6/m8dmbVTV/I2YuN+ZHXFyRG
	ivxHRQ5dwR1/LOG+tFjADe0FeWM1MZHFNCj4ao1SeUJgmYOJ5MIjulhvhA72WfRk
	6fOzbiGWQeu7HXCtThZzvte9iq8LVV0ilRSNgTdyx7bkBsJNNF8zvYcpyITg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775510224; x=1775596624; bh=wFI1hj7NEtlF8IA8EhPadz9sChRuzbNk5g3
	mZ3JPNQw=; b=qP7F1GHopPFrpXUZvq0O39kFaSDi5s4+nTw0D+FlhULBiZJnRtz
	q8/uMDV2exGkpw6ltXVbTGnz6dA4x7jOnmc7UTiTsA0TTHW3yQ3k0ewtGudnt93B
	IR96jM7yATu7Ru/Om44QccNmoXCxTbyv/37fsPmUmK78+M+jbeCQL+a1C5jXAX5k
	6ZHkvj+dpNx/xk+O/6ZtIfylWkmWeCGECP77R8lHd2/e9QQ/KFm7Ot295hfa+Mnd
	IlgqvOz+dMQmLIDLdOnvbHDTKkmDEhK3h1pp5ZLce1ZI9gxDxoTtHDnu04orLQF2
	3AQWnegjvFZD9aczIdGR14c0gTkcc2dIyiw==
X-ME-Sender: <xms:zyLUac_dSO018IpDPI4nrJpuvYxf0-iZGgbfUSkOqnuPC9MFtPejcw>
    <xme:zyLUaXRL1q6Mxey1yqHQq8odAR3r-ydy6mZDdd6kyu-br6nlK_TexNsb0bkKHiLy6
    tv4fVD__tvsRE-qt027Xhm9r3d3V2Z-fv9MW5nEiD76mwQVMQ>
X-ME-Received: <xmr:zyLUaVotFqcAPxXvnId2DKF-QHm6yipvXMCmeNWOfAxAQmY12RE1UeksbCHFpZpm43NRpTHsn1pylZja6tUMR0WpMMuoRuZ8cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteejgeduveeuteeiudfhhfeguddtjefhjedvffelteelhfdtveejueehudff
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhorh
    gvnhiiohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:zyLUacngtPnWQ7fqzTmcQyPTM6cUaggPCRj1Cc4FMVy2Uc-QuFEjAg>
    <xmx:zyLUaWd7xNxQkuYrKrRsNm_Jg01kt-G_JxBWrDFV-msNdLMcYX3vtQ>
    <xmx:zyLUaQrLHK2WsB_ovIsQjx4SvNTOpXDVZS9DLWl9X0pxAGUoGpL3jQ>
    <xmx:zyLUaYNr7DUTE4PMlkgx4w1DNJ75GjUXMoqh5L7XqmTFE-RM2evH3g>
    <xmx:0CLUaYgyYdu7zW3pSi0KorGaLF7Xglvq6Pho2rJuV_qoe35UXQTfG_RY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 17:17:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
Cc: Tian Yuchen <cat@malon.dev>,  git@vger.kernel.org,  Derrick Stolee
 <stolee@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 2/5] pack-write: add helper to fill promisor
 file after repack
In-Reply-To: <adP-MYYSmElK9wL3@lorenzo-VM> (Lorenzo Pegorari's message of
	"Mon, 6 Apr 2026 20:40:49 +0200")
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<3cd15429194c763727fbfd5981ba38c1dc2cc907.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<f2540dc1-fe76-48ec-91a7-82e32ced75fc@malon.dev>
	<adP-MYYSmElK9wL3@lorenzo-VM>
Date: Mon, 06 Apr 2026 14:17:02 -0700
Message-ID: <xmqqeckraiwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com> writes:

> On Tue, Apr 07, 2026 at 01:22:16AM +0800, Tian Yuchen wrote:
>> Hi,
>> 
>> On 4/6/26 08:24, LorenzoPegorari wrote:
>> 
>> > +		while (strbuf_getline(&line, source) != EOF) {
>> > +			struct strbuf **parts;
>> > +			struct object_id oid;
>> > +
>> > +			/* Split line into <oid>, <ref> and <time> (if <time> exists) */
>> > +			parts = strbuf_split_max(&line, ' ', 3);
>> > +
>> > +			/* Ignore the lines where <oid> doesn't appear in the dest_pack */
>> > +			strbuf_rtrim(parts[0]);
>> > +			get_oid_hex_algop(parts[0]->buf, &oid, repo->hash_algo);
>> > +			if (!find_pack_entry_one(&oid, dest_pack))
>> > +				continue;
>> 
>> Memory leak here;
>
> Yep, `strbuf_list_free(parts)` is missing here. Ack.

Also strbuf_split*() is a bad API.  Unless you need all the parts[]
strbuf instances all editable at the same time, an array of strbuf
is a data structure that is way overkill.  Splitting into string-list
may make it more palatable, I think.

We even went through a series of patches (and follow-up effort by
other contributors) [*] to rewrite callers that unnecessarily call
strbuf_split*().

[References]
  https://lore.kernel.org/git/20250731225433.4028872-1-gitster@pobox.com/
  https://lore.kernel.org/git/cover.1761217100.git.belkid98@gmail.com/

