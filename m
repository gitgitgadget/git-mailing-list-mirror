Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776E47A73
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729529324; cv=none; b=gv+AMAlc+pnl2WukCZqmbAMYP2UK6d1xxV1/oLU7e4E4Wp1deatxJiyL7MDYhsjrjvjQJ/vD5e3XIjxjvRvX5XsLfMMJSJSDBoLvNMMxC8cBGd/BaRXbADwTzdfFkDdqKxTpNrXF/jcDwN4kucy3OnO/TIflDvtM/kD27ErrCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729529324; c=relaxed/simple;
	bh=f94ClILKllFVGsJmt8h4merwc14F5dtBjDkpTTwLXg0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gp4uchCF2UZbWFKgXQATGFqeXJpLUtcXLdG30ISaw6uzT/2PBXOB8sTANC3NTLfUzWLsu/6P4aB7+FT8tsXl3o9USEIUp3zYkyDpH5eSNH34dYmvKEvcMC+1ebwQd2j5jejPvpoXp1MSiY7oZVPcxB+WZmiZ73T3wKWbPSGBh9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=mWutuLTu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lzxTdNpO; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="mWutuLTu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lzxTdNpO"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6176025400CA;
	Mon, 21 Oct 2024 12:48:41 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 12:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729529321;
	 x=1729615721; bh=zPPJJshDYebGj/KDYwfCRMYXHwLwaLc9eZHILl8r+jI=; b=
	mWutuLTurtE+6yYD490/E6nJSKuEOmFUUrZq2LM1qbXfdr4bRJVDkE20GFMxWUqZ
	TCc0gGsHI1m15RE4QCi2BuZxhCjYk9K+ADdj9BrhqYxuanZrVxWvKuRNdnS345MD
	yTTNh/ALv1JAQYYSeT5IUNaCIuLIkjLmv1FmwHsFgHhqtae/PLyjL6qeHQ1LDY2O
	FkPL0IVV3cK/8+vlpNeY0iZ4Cri+gfaWVeRCRJu20/2c9b7df26OVWq9ophSD3uL
	bpeyzFaape1UJv71BgLmJ00fUeCzbKMlolrbDnYz/SZ4+6ekfZNky2KigcRFfLoq
	00xZfBq54+OW6gHR/qbw6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729529321; x=
	1729615721; bh=zPPJJshDYebGj/KDYwfCRMYXHwLwaLc9eZHILl8r+jI=; b=l
	zxTdNpO3vpiUV+lJjElK2I1ZwVrQRYuGTZpJ0Lni5pRT7vjPfoBRUAXWifFgst02
	ez4+iN56Z9AJnCJImsvfH+8XoFTK16dKnugKqFz16aVmgUkZc8GmBwR5POJX2WXM
	jgDikGnG4Fi5NBqtgC/xXnmIt53yylqs0m5wqi7jSCbljo/dP8BlWmf7ANmMSVs5
	5zNj2NW71QtjGY5zskGUHZcjAbrvKx41SrzIJUQS8Di2eu3IsDp082e8WTrQaWxr
	E6zveLyos71WNKMLbhZTN5U137C2/Um+SpZGXG4JE/9VLGuCBga21DbiGwGt/gUR
	qy1bBrbnzdEeGy/egypNQ==
X-ME-Sender: <xms:6IUWZ4QYUzwiDO92IgsvxsAIoyK6NcrHpuNiBqdDzyVBEjvmsXVdAk0>
    <xme:6IUWZ1wkDrFzYrt04emLmcaiV7nQLgoz0HQs0nl111_YaKwfpDLzLKe4oLC6euCEH
    fk0sKUZTao93_MARg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffr
    rghtthgvrhhnpefgleegffegkeehkedtgffgheeifedvgeekjedtvdeglefhjeegueelie
    ffjeeuteenucffohhmrghinheplhhoghgrlhhlrhgvfhhuphgurghtvghsrdhhmhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6YUWZ1174FvpL---qHg4ktWNXoHvtDbw6I_YU9iKj77Uvi2KaE5R1A>
    <xmx:6YUWZ8CACXIh3BQVML0ULcQM1LcHucGBpVoHPNCyEt0JzBDzokjwig>
    <xmx:6YUWZxgW_IR9N4vh_QfMUz9VKwg_nzp2PCPaS5FJyefg-F_hWLQLKw>
    <xmx:6YUWZ4qUNcqp7gtor6C6PT6eV7AY-mq9xEfObdMt5ACRLuZ12ks0qw>
    <xmx:6YUWZ0vOeoxgFwKZWZ_JZ79fvpmEN9nlZOgAqyDeqzn9XVLKL8_C367z>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E11EA780068; Mon, 21 Oct 2024 12:48:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 21 Oct 2024 18:48:20 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org, "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <d66936b8-d12b-4035-b563-328ae9fc4824@app.fastmail.com>
In-Reply-To: <ZxZETN7WjbNiSRyF@pks.im>
References: 
 <ab7d4c8d89c075de05bf04f1f9dc195145455964.1729439476.git.code@khaugsbakk.name>
 <ZxZETN7WjbNiSRyF@pks.im>
Subject: Re: [PATCH] t1400: fix --no-create-reflog test and description
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024, at 14:08, Patrick Steinhardt wrote:
>> [=E2=80=A6]
>> Notes (series):
>>     From the commit message:
>>
>>       =E2=80=9C The test itself is fine and does not hide a bug:
>>         `--no-create-reflog` is not supposed to override
>>
>>     A source for that: roundabout through git-branch(1):
>>
>>       =E2=80=9C The negated form --no-create-reflog only overrides an=
 earlier
>>         --create-reflog, but currently does not negate the setting of
>>         core.logAllRefUpdates.
>
> Hm. The "currently" reads as if this was a known shortcoming rather th=
an
> by design.

I read it as =E2=80=9Cwe might change our minds here=E2=80=94watch out=E2=
=80=9D.  ;)

It feels very emphasized.  Like the documentation was expecting
your surprise.

>>     I *suppose* that the same applies to update-ref since (I suppose)=
 they
>>     use the same underlying machinery.
>>
>>     See also git-tag(1) which says the same thing.
>>
>>     update-ref should document the same thing, then.  I have that mar=
ked as
>>     a todo item.  The changes there are a bit too involved to implica=
te in
>>     this submission.
>
> So I'm quite torn here. It's documented, even though the documentation
> doesn't exactly feel like this was designed, but rather like it was a
> side effect. The test also contradicts the documentation, even though =
it
> only worked by chance. And as mentioned above, everywhere else we
> typically have a design where the command line option overrides the
> config.
>
> Overall I'm rather leaning into the direction of making this work
> properly. But that would of course be a backwards-incompatible change.

Good point.  It does feel inconsistent.  I agree that the conventional
pattern (to my knowledge) is to have options override config when the
options are given.
