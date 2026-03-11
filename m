Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7321C38657E
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773260198; cv=none; b=h4wV8+++d4uzIcAi/Fcw7T0vjdjQyLBDoqTS2xTnBHIbY4J6mM+vk4PCDAsEO2IlbImIaxxusSlbzlEIr3ePRAOoTn9HthdRXuIAnLS7LduhzuopVqDLKFBhJrA44a3eEM+boUlCaRNdJEUDBsRXjb0Re4QejGHbMQ24kCOF/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773260198; c=relaxed/simple;
	bh=pp4J+WSMjt12558u2ohiQEU+m4TXukjMPJ4bZPDDo3s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VWdPEQq7WCUF3pNgh+tycnJAzpfN8//Nq52LoR3exsGI8zF53ODq4UoiGwaN77wMWFyq9R5oZUpA4ckCWrV66QSc3V05bATp5IWl0t04QYhW777HmTZDVYbOTC/bG4iKD6OP6OSaIwl5psAUO1m5H6apB8cAIW3EA0QfkFyHkaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mOs042pw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U9Y8OTT+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mOs042pw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U9Y8OTT+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 18A987A021C;
	Wed, 11 Mar 2026 16:16:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Wed, 11 Mar 2026 16:16:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773260194;
	 x=1773346594; bh=JiPbsCiGz6pd6q0vEaNPff27DfFarM/ognJ1k4phHc8=; b=
	mOs042pwZiWfUay6bXlpWFaUY5U6moKl0uv294f6ziBEYLUQ+t9utORMs5QjeLjw
	SjeVpOHujdfKNoSQ2/3ce44rvMSbAKyxhut6RlODwMElWqPZXThcZ70RiJ32oHzk
	5eqEhhpa+fad8crWX13UsphOqO8ZeJ1M0UyIPf23bqj6lw504uywB+O4dNhi7lmc
	3hjUyiH5MEI5z269UO9PUe3kWfhhuu3x8XScvRRPbfDusV+bzOgKio7faGCHzuyC
	3LTUq3CU/7+ekaLjGogML5QALXzYTLY/20IKEnoCIovoP+/hewCRiRJuvbaWmF9O
	Uaj3AGsNcmB8DVs8TokIAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773260194; x=
	1773346594; bh=JiPbsCiGz6pd6q0vEaNPff27DfFarM/ognJ1k4phHc8=; b=U
	9Y8OTT+R09mhYvxzdAZ8KvMzB1+HTC9R76QQPJ0NaqiCZT4Jn0oPJr6graySiCp+
	dNTY7iFH3eDZmiFVFHd2bgaVdBKggiZzxGmz9+7bQuWEsk/PVsv+b2Xa/euazTHx
	sqNFEyqwh1U3x3D0xmiXAbPyB1dxeXSpwpXhesJrigdw33cN2r0Aa/pELvbiPFdh
	n9joSwurTngG6dVhpVfnM3DgwOJdAF72Ob0pzlc9cFFdZdx74Z5VqZyXQ1c2Zabc
	sHS+0k3tY2hTO8dr3F7EuEFZDu+nPy7B/fINTVA4jN7P03wATqXElW45QGIksie2
	Pc9EuvZyHtc4B/O9GndIw==
X-ME-Sender: <xms:os2xaUFUgRo5l77kgbLORjFQ6FKvMLZ1ggWHK-6mu5iYD9woR8O6pbQ>
    <xme:os2xaYIZPmBg-FJbgZSC12bRP_CNkKDB62W7TM7TXK5aSWENAxuKXAvleEYjq0KdW
    r_QzPdDP6MLEN-9Y43ZHHnkjQdBUuKP8fuucPV7ptttJZlE-KSUOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfevgfef
    gfffvdfhffdvveevgeehhedutedvgfeuffejveejudegveefvdefnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilh
    drtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthht
    ohepmhesghhithdrshhtrhhovhgrrdgukhdprhgtphhtthhopegrvhgrrhgrsgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhnhgtrghikeeisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:os2xaZHop9bsHvmVR7vvm61Pnx_K19TVLuW36zlbWnzQN1Js1UpyHA>
    <xmx:os2xaa4y6NurxZv9xwYHU_H7-FoyC0JGahU5Bm2V2jiSEc0mBBYT4w>
    <xmx:os2xafkgdE833fuZoYzItw165y_970sUVfSqNVAIZXPHt05CTauS8g>
    <xmx:os2xaV7BEq6n3ho7ZRLJ4a0iGQjFeF4tsBwHWeYXohM6XwkZBXAumw>
    <xmx:os2xaTHiqA4g5FWuyyhjNqbXcMZkVkNeMI2Rj7UhEBUyQECqBCb9ZCoT>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3BA331EA006B; Wed, 11 Mar 2026 16:16:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Adl1l9tAOWUZ
Date: Wed, 11 Mar 2026 21:16:13 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Mathias Rav" <m@git.strova.dk>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org,
 "Karthik Nayak" <karthik.188@gmail.com>
Message-Id: <4b2a192e-240a-45d2-92a5-7ab669f481a9@app.fastmail.com>
In-Reply-To: <xmqq5x72qnu6.fsf@gitster.g>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
 <abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
 <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
 <bcbbdcb3-9c4b-4eb8-9e70-3eb0bd19b32c@app.fastmail.com>
 <xmqq5x72qnu6.fsf@gitster.g>
Subject: Re: [PATCH v2] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026, at 18:26, Junio C Hamano wrote:
>>>[snip]
>>
>> Turns out that this has been attempted least once before:
>>
>> https://lore.kernel.org/git/1472230741-5161-1-git-send-email-dev+git@=
drbeat.li/
>
> True.
>
> Perhaps something like this patch makes it clear that what the gitk
> command gives and what --pretty=3Dreference gives are not identical,
> to avoid confusion like this?  I dunno.
>
>
>  Documentation/SubmittingPatches | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git c/Documentation/SubmittingPatches w/Documentation/Submittin=
gPatches
> index e270ccbe85..fad0b41af0 100644
> --- c/Documentation/SubmittingPatches
> +++ w/Documentation/SubmittingPatches
> @@ -335,7 +335,7 @@ date)", like this:
>  ....
>
>  The "Copy commit reference" command of gitk can be used to obtain this
> -format (with the subject enclosed in a pair of double-quotes), or this

And now I see for the first time that the doc points out the difference
already... I=E2=80=99m really paying attention it turns out.

> +format (but with the subject enclosed in an extra pair of double-quot=
es), or this

I think replacing =E2=80=9Cwith=E2=80=9D with =E2=80=9Cbut=E2=80=9D is g=
ood. But why =E2=80=9Cextra=E2=80=9D pairs? It=E2=80=99s
just a pair of double quotes.

>  invocation of `git show`:
>
>  ....
