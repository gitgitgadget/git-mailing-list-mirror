Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03487318EE6
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056571; cv=none; b=CQgf9KJjNLLD0UEnyyK9VJ6PlVVgXxolPrxStKpWlDkAj1EuP6vJqq1Ahqwx9fJWpavHFaD3shvpMRCifJazfTbX1Wap/5LdqoostMrE2J8w+I/1DVryDsr8Ikg8Qr5O8TzENstgaaW53M3Z6B1aNzjVpGwRM6IetwgNvSuBcpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056571; c=relaxed/simple;
	bh=QrPVxF5HaCmqTR3Q11XbgVZgns21c6DmQvEMe7g4hAA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mvMfeHc/ACyug02KdSGqdDGoIH3Hyct7kek/2Et+eJ9WrNc2apdGMoa0aCZ1tHenyVZUV6rEZHJkYI1R3x8v8Jh3woGidh5Qi6ZfWLlHyql1Om2KXRbILbTcaD44dee9Wa+Ngt96tsSdlmWf+LoBH/NZzG2GNYN0hqsKjKM/O1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LC7upnKh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I02jYtKg; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LC7upnKh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I02jYtKg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A27EEC05C8;
	Wed, 25 Feb 2026 16:56:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 25 Feb 2026 16:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772056569; x=1772142969; bh=QrPVxF5HaC
	mqTR3Q11XbgVZgns21c6DmQvEMe7g4hAA=; b=LC7upnKhbc5MlA8+2i6rOidvnz
	WaZ8tt4VZ7q46iD2AJuzKO0pYN+aV3T6F4ntmW0Ym6JXnU+Ti93MTvXNjRweuERx
	F0q67NKarhnJHoVV2O2AMZldAb2djU9vdZdEY3PkYHlhgEAWdtxsfTPak7fgwZCM
	Q0EB/5s2K7yv3pKcZW+jv17RC4jfbz6SEAnbyHavrZydXmWmAmQUjsyhjQA4mhAb
	xnXt4xYLA/RWLJmzcLDBLc3ZShivz0whPw4AZr9isacRJUoGDCU1c429+1aWRDDC
	nDrfM2CX/zbeZe0U7AgawoY4XUJyzwpS6aCp8L/kOCjWnnr+adt4vb+KH9PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772056569; x=1772142969; bh=QrPVxF5HaCmqTR3Q11XbgVZgns21c6DmQvE
	Me7g4hAA=; b=I02jYtKgQNeXGN6IHG6+etSAEquXFY1Bin7JHXiQ+ueERAJjjbl
	Mqs+UhgrUKnzc5dClwCx7DZ4Jfa7GDHWCwFei6qdsyllJsXE8M1bgkyN1CFaV+yL
	M5irXPqIe5tIpqodUJmHY5wQa0d0SaZLhtYxQk4AJL6ZzjtA93Q6aN2zA87F6jBL
	MxR04M+IdGk5/WHcrxJMRxP1tZs1jIFq+tSdeeh9QUvcA0YsXGvhfXHojpLX+uP7
	uSZT6Sm5/9/mUa8FP+R5O547ZZZcJE0ah9xD4qp0wn7NjOHKqpLK15Xx8pZVJ1Wp
	lqLUTYV16HUyxV6rVEey8cAyb02s6nFL5oQ==
X-ME-Sender: <xms:-W-faacifDofX7UnVeOFs-g0rPwRGQUZra9I0ibyQsgwyOLxm8YSow>
    <xme:-W-fabOLH5Xs2HFP8inEJsyFow0DCTOYw6lTxSzlC0Y0fh5hODto-XwusKRkiQrJl
    kLKyzmLYx8IXdJZ1KAU04Dx9cWNaIBzT8G9IkztkSnRcVUGNoJDjYA>
X-ME-Received: <xmr:-W-faQhb30Zmx14xwzOIUFsA_iEFNcm9PO_Nlmjl-QD4EKPwth0aFxLgi1nGVcBwY5VSowZjd9m4RusbhBYj5aBQeAGYbz9Bpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeegvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtohepthhithgrnhhirgdrshhughhirghrthho
    sehrfihthhdqrggrtghhvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-W-faW0AY438LV30kxGawyoFQAiwPJc-Cy0LY3IJJDjJsDCrNCu2MA>
    <xmx:-W-faShSRr2OFJIq_DRfcZLDKfhqvltN0nAA78dKYGeVed_zrzpPvw>
    <xmx:-W-faec4N4B1NnZ36GbJhpNkVSI4iw2VYuF6YazifV9N_Bn34eV9hA>
    <xmx:-W-fadnXgYOfhTyeccg7Csa_yPss-vJXNjpbdRZN8X88H36q0OZrHg>
    <xmx:-W-faVc6KiVhLSv-W_GOFdHaPyu5vXqjqChoiIjWNrqY_ltW2tpNNQle>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Feb 2026 16:56:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Sugiarto, Titania" <titania.sugiarto@rwth-aachen.de>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feature that allows the user to merge only specific
 files/folders from another branch
In-Reply-To: <b743b7fe-5f5a-4906-9ea6-0755acf5875d@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 24 Feb 2026 23:44:31 +0100")
References: <532e9d58b905404fa625aa59104ce8f5@rwth-aachen.de>
	<14775be9ed944bf684c3696e1a10f44d@rwth-aachen.de>
	<b743b7fe-5f5a-4906-9ea6-0755acf5875d@app.fastmail.com>
Date: Wed, 25 Feb 2026 13:56:07 -0800
Message-ID: <xmqq1pi88p3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Tue, Feb 24, 2026, at 14:44, Sugiarto, Titania wrote:
>> Hi,
>>
>> I have a suggestion for Git, which includes a feature that allows the
>> user to merge (I want to highlight merge here, not replace) specific
>> files/folders from another branch.
>> I feel like a lot of users have spoken about this online but up until
>> now, there hasn't been an update regarding such feature.
>>
>> Might be worthwhile to consider?
>
> Why?

Because many people talked about it?












Yes, I know that an idea is not necessarily a good one only because
many talk about it ;-)
