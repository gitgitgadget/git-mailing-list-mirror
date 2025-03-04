Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A72F24EABD
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 18:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113006; cv=none; b=eAKMK9YOtAxoLm9wVBoS0EuVUnqLeBfm/McwzNaTD6BJ4o4Ebrh+9xLXtizKieFEEWwnAWbMju6+rsrjqtat3dAYaBkPR7IN4k1ZPxJ1andlaDcJy3Iq+Sx/sauym2ixWr5cvg8nzR0XEM4Ge0Ru6vglOJOTmMCi97pBYhXr3rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113006; c=relaxed/simple;
	bh=HnyiRq4W727nKqgczeNEb2iYmR5JIbk0L/mOxN/v2eY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5/1GgNCc82DObzQnK/puWxVvdHVzZfH14/sB+6qOdMFr+BP+Q+dcmESwnVaDw1uqkBc+KfSZIpraIJku00MpEUb5EwdJBIxJ1VCm/F3fLT6W3VL1jEbhAZMc7ZIwpZ/CyLECgzewjUQrgpkMuLNofJMrg+V2v9W8QCYzEC2QY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C+EiJrWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4SolJ31c; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C+EiJrWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4SolJ31c"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 192831140093;
	Tue,  4 Mar 2025 13:30:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 04 Mar 2025 13:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741113003;
	 x=1741199403; bh=IQQt8et78IbSOinIxnnAxQMaHAUqRFrzMQAUfzmygXs=; b=
	C+EiJrWr2hCzAEkmCot6MH6d/v1wxQx5lbZbnYLINtgKKdRE6Tebp2RWNRhaFHj+
	SnqauhatejYM2M6MHTCNCH2LZb46djerb/NY4uQYsCBj/xrtkwxu72ScOZ61vHdK
	x4tNh0eLA3a3cg+mA6IGOrVI+D11JLXJCQav7HPneJDtMAqOn+sHy5zSxmLzpmnm
	45KFMsU+lK1ASekL8JazPLh49DtRsB/AabrNfNkRciXsvUpt5m3IRs7Z3heSvG0g
	DkCbqhVBi3Bvtq5RqedB18nLseKeq8Rcnl2mnwWbii01DRXalv9KEkTnlkTa6r6w
	jaPXvYFZUkJ3ZCpl0uhhQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741113003; x=
	1741199403; bh=IQQt8et78IbSOinIxnnAxQMaHAUqRFrzMQAUfzmygXs=; b=4
	SolJ31cUGzM6oQxumPwHfOSHSA7nvASEFGRop6U74MUdUutEy7FeXNNNLm8OWyWR
	tQkFrxRd6qOVwQPlUjEg/2vYfv1ZSzA8YKtrXzqBV0SulD3O2AcOapEGwAmRvXxu
	/LWmiTRFupklZKDfM01OabugXm71hhjFHYSDHzb5AMp7EetHzqVC+bI4P46So+KV
	5/wQOwdiiyiYzPwt9VYAReKDtpok7CYq6qvioLgiiy6lkNFoHcM5zWyrQr5DNnfC
	HnGus865+eQ++ZeXhMzAOmc7BSU17HHoD/KcDFP1swPyFxdHWBj5+C6nJWuJdYYs
	9FWuOgcAln2HRWgaIwjow==
X-ME-Sender: <xms:qkbHZ4GnkFmb1PAvANTmI7w2IabIoCAEV2ppIQXooJqpnPXQrQ0BEg>
    <xme:qkbHZxVU96kMurshVyNXYgIAZ5J3KXbN1y0yUZQxXIFwKnjF8Tbtyvyl80r7h1rDb
    A0Gx6Yg2AV3Th1faQ>
X-ME-Received: <xmr:qkbHZyIDlkTYu_x3GE60dve8rLv1qpwA4w0r8QiXyCBGyUZmimeCVx3wy_kK-CNb8PQ5IeXp_aY7_m6rBIXCbTNo5rY3eGLPnNXe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutddvjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhih
    hnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepuggrnhhimhgrhhgvnhgu
    rhgrtdeltdegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qkbHZ6FN654SJqELIhDb39Y6JGjB5WIP62jatnNr324IcwJnjSHY9A>
    <xmx:qkbHZ-V3nnyEuWwGMW9j0S3qUmtrlqGSL9VtHSd-fBQes584eEPSxw>
    <xmx:qkbHZ9NmMw0hKauCe6ysACwq1IQSq6HsrduQOvuOT9T91PbHaIkTiw>
    <xmx:qkbHZ13rZQQGEA_QI1Se3bpdpdFsBK7ZISG7QGF5sq_99lUa5gB4LA>
    <xmx:q0bHZwcd7Mar0najntI51ZDAvtFQ_wABKs5-hwJ08YD5_14F4qA8Iw8u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 13:30:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Mahendra Dani <danimahendra0904@gmail.com>,  Patrick Steinhardt
 <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 1/1] t1403: prefer test_path_exists helper function
In-Reply-To: <CAPig+cS3QZhZ=W2WfM3T3EngaMOSV37KH4Pqp78QHzOAODtenA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 4 Mar 2025 13:07:22 -0500")
References: <20250301105838.1481-1-danimahendra0904@gmail.com>
	<20250301105838.1481-2-danimahendra0904@gmail.com>
	<Z8WD2MeHpOH7Ni8A@pks.im>
	<CABGrwBB1-UiiPEOptN9csVP1WYg2X=SWeMxxiyDfz02VmDp1vA@mail.gmail.com>
	<xmqqldtlt304.fsf@gitster.g>
	<CAPig+cQ275qBWzaYmMXydiA_8+CTx3FhAAY+o8ro+hD03wzu0g@mail.gmail.com>
	<xmqqcyewr8j7.fsf@gitster.g>
	<CAPig+cS3QZhZ=W2WfM3T3EngaMOSV37KH4Pqp78QHzOAODtenA@mail.gmail.com>
Date: Tue, 04 Mar 2025 10:30:00 -0800
Message-ID: <xmqq1pvcps2f.fsf@gitster.g>
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

> On Tue, Mar 4, 2025 at 12:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> > On Tue, Mar 4, 2025 at 7:05 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >> Mahendra Dani <danimahendra0904@gmail.com> writes:
>> >> >> >       remove_object() {
>> >> >> >               file=$(sha1_file "$*") &&
>> >> >> > -             test -e "$file" &&
>> >> >> > +             test_path_exists "$file" &&
>> >> >> >               rm -f "$file"
>> >> >> >       } &&
> ...
> Yes, I understood the implication of your suggestion, but as mentioned
> above, it's not clear (at least to me) why `test -e "$file"` is there
> at all since this test is not about checking functionality of `git
> commit`.

Yup, I do not see much point in "test -e" there in the original, and
it does not change even if it were "test -f".

I would understand if the author wanted to have a "slightly more
intelligent 'rm -f' that knows where a loose object is located, and
removes the named object no matter what", but if the objective were
to ensure the object is missing, I wouldn't have written it to
return non-zero when the object were missing in the first place.

And if the purpose of the function is to catch unexpected cases,
such as "the loose object file should be there but isn't" and "we
located the file but we failed to remove it", then it shouldn't have
the 'test -e' guard and 'rm' shouldn't have been used with '-f'.

So, I agree with you that the original is already iffy.

Thanks.


