Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D7035BDCF
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792592; cv=none; b=VFMfd1jd0AuK6/lBWowx7/nXELwPdg+iOv+rixzdCeZk19u1axyOHfQRBujqJFFCBNUkzDZODjOn3/wDeC5doVfLFFyWSSl3xp7y49kEg74NRB4aEfD9cgR29oftf4nt8UXaxdHp9HVc7clbwrMXQIvLU+Ihy2gjYeHV4xhdz10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792592; c=relaxed/simple;
	bh=ccKkAzRV4zwwk5No7xg5umAOb0O+ZafRMjr3nd+MtQ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NTYmSlKVSNaaZPuVaci9srxNT2+WLYbY01cDSKJxPSVIsKEYlMdYAV/kz35pE08CWHbZu1e6fMyea2WWT1z2LCPuURjT+nyChSQwW3UQcX0/Q8CQmx461oocfYSEu6EkE6AFeGkNIPPgMM1pmuE5DZ6TSrcY0OLt3suCP4Kpx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iJIz9+Da; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JlkDGY8C; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iJIz9+Da";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JlkDGY8C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5570B1D000F5;
	Sun, 22 Feb 2026 15:36:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 22 Feb 2026 15:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771792590; x=1771878990; bh=Rs/f0J76Uw
	WF+SKAd2sC77IUS6Fg0XgDj0HFwCEUw0Y=; b=iJIz9+DauV+q30qPxlW790Hbev
	CRGfw3biEEjCE1WOIWI2OreIun/l4JU/w7EzQ8a0QHtNqs9zrZ0+SruEEP2XOXBy
	AsCCIbBeqMiU6bHtqlZWc8wpViYFJOY/dodpIc7d5+1v6bNUUiRuBofZ3Shyyjxt
	Bz/eFISj/E+euE84t/Q2ERiwj9w8dp4l7a6ivKmnC22N9H622vSycpc7PpjnEshp
	SfHy64+fcQt96UpXa+zZ6c0LYIHFO+HHjpLrNWDQGdfzsOWvpkmyH6TvJXcC1XpP
	QWb9dW6mpn+K1Iw/Ub5/MozhP4mlnOIXa86WDv3MTMu0T10BIwKVJ+qlrctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771792590; x=1771878990; bh=Rs/f0J76UwWF+SKAd2sC77IUS6Fg0XgDj0H
	FwCEUw0Y=; b=JlkDGY8CnkRiruU/PqkfdgGjhM0ezqRhb9x5ABE+OhKMonksrct
	lTmXF1cn6A+pjeKXVIe32y26Q3OsYfiOrncgiAk1DxJErwRQQySFh3KVVZTKqCz+
	oQ0V+w3OtY6JlWk/mfIV/aXQjmGAbIwYjS+nXqDxvR7zBUBvNrt0VX5cS/Fs+m9H
	GD0oyv28RNemtJ+VKs5ulskxMLN/3/iFdLhf/FQTCASTsvB3mLqI0/NFYTedqoGm
	y9APuN1lI49Fyn9bi4BNoIHY2ebogtpM+qneyiGeFvXB3w6kFEhu8TwD2L/QceyP
	KiCEXguZ4pE45/rdI4aPm5VUnljtVSlgifA==
X-ME-Sender: <xms:zmibaVMzw8rgWBdomWpZM0d-U0d09t8eINZwEbd4E2u35rOIl5yecQ>
    <xme:zmibae8s7GK-oOp59szKpqtW-uhKv5CMExZhSiBGbuBI6r4V53-tN_W4GtbmiZ0ZX
    EiAH77qWKgzIuCMbz2ArurVthXnCK9SnRNAIs0X-FKr1oPKnher>
X-ME-Received: <xmr:zmibaZTpK2tU3IZxZcig701mUtuElmGTZiSDHpjputw_CV7zmv7VpRmvujFJuFlABqJI8PChopDpCYcVEf7VIs-ucsTJS_nn0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeehvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zmibaQl6HZsZPf1M8jL1C89X1I3GM19zewt8IFyCfb9nIE1ZRA9z_A>
    <xmx:zmibaZRBvoIF5XVzcZxQaVapIwdnf2JzGD3ie2yeUTqiOaDdeu359w>
    <xmx:zmibaeMx87QlxaSJwVunRVocr3kbI9e7AFMYYiivWa63AfUIGPnQig>
    <xmx:zmibaSVDjekx815OH4QFIkj835-IYhxMocuB_uN21nCMsBhqaR1oxg>
    <xmx:zmibaVOQGsW2lKTeDCrp3_WANe-fbVITrOGPsMhUEHwyT-S8HdbsEf-H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 15:36:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] object-file: use `container_of()` to convert from base
 types
In-Reply-To: <20260222094158.GA1319383@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 22 Feb 2026 04:41:58 -0500")
References: <20260218210120.1146078-1-jltobler@gmail.com>
	<xmqqms11qmsj.fsf@gitster.g>
	<20260222094158.GA1319383@coredump.intra.peff.net>
Date: Sun, 22 Feb 2026 12:36:28 -0800
Message-ID: <xmqq8qckqzw3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Sat, Feb 21, 2026 at 11:07:08PM -0800, Junio C Hamano wrote:
>
>> Perhaps a fix-up patch on top of the topic branch like this?
>> 
>> ----- >8 -----
>> Subject: [PATCH] object-file.c: avoid container_of() of a NULL container
>> [...]
>>  static void prepare_loose_object_transaction(struct odb_transaction *base)
>>  {
>> -	struct odb_transaction_files *transaction =
>> -		container_of(base, struct odb_transaction_files, base);
>> +	struct odb_transaction_files *transaction = NULL;
>> +
>> +	if (base)
>> +		transaction =
>> +			container_of(base, struct odb_transaction_files, base);
>
> That works, but you can also use container_of_or_null() in the
> initializer. IMHO the result is easier to read.

Thanks.  Will use that.
