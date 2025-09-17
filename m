Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC3C2EFDBA
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758110577; cv=none; b=hVlJiwJGThafJNbOfZZrKfp1QYVurW9v0aOoaTcks+6/uVz1bRvw/TPJlgwR5sYiw5XIZu7Z0QbT1pN2rguIDCn3ZueIU3VR6fX4AFvcnbArCdZpmyMk7K+Qqfw45tYA1zz/9/MNDCzd7jA2RJoT9LTdUTCeMRfsuj3WE6oDgjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758110577; c=relaxed/simple;
	bh=uBix7NvxdMe6Z0L6g9MojcHwf4Uhirddr4nYJryR3Xs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BowgnGW8x7bGuqL0RnSZrZU343GplVU0x1GnpO7Oi7bXKriBuUZ82aCMAe6p4hN8Moi4iXN90Mq88d5TXBo1DGZQAYqaKXgfE/iSn5qRsEhbcFGhY6H8LbSOyc/dBSTxz9Lu57V7tfVEuIl26JHoVExXLDwWryoDxlXKgjE611c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Q1mKLJ6V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eRg7UspF; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Q1mKLJ6V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eRg7UspF"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 72D09EC02AB;
	Wed, 17 Sep 2025 08:02:53 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 17 Sep 2025 08:02:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758110573;
	 x=1758196973; bh=LAuvW0RTKPAO33+t6ZeeKtFMn7V+IrDAta2IPv9bJlY=; b=
	Q1mKLJ6VG9LPzUrlkucbOcKXxPox+btlpC2cxkTE97659+xqP8BvCB57CvESldK7
	3bNBp7aGcDigm9jt2/FEZDZq4OyWFjpqGOi5OjV/BlWHP3ZLELGlQIlFzRSfWAK+
	KWH+kSi8OnMAmVJAD3LCGuq0xZ+wsFdCTtjElzDE5T0FFyTMV8QnFsawLSqkiwji
	B5DOfISDt7ISsLvxJDAbdTWcgOEmlmD3yv36W11vBwkBuF+WOT0dhfs4Z9jG33iI
	tgidvUNAk+2js+dnLZVMCbc8rX2T2KIeDvpZlkRwIX2E4eY2YojHlCbYgfwtYj9l
	VW4Eaf+TOS27DfhuPSPeyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758110573; x=
	1758196973; bh=LAuvW0RTKPAO33+t6ZeeKtFMn7V+IrDAta2IPv9bJlY=; b=e
	Rg7UspFdGPdmaRgmwMIlvP1uBXRBIrsJg15tsKAyggHaIerDQ3kPseRaCQOohwTx
	1TOHxMbIqZ9BhenEwJSqHyhC1lm9krQiuP8hJfI5OHxe/13u+pwqGhlFbkQ50329
	ilLVfDXdr4//IY4g2TMyoKv7QY8QdCPly8jdeR0kvqTK7avHJoE7Ofm5aH9jW0dd
	XTfO9m7Tfr94N1GbWadan/3tZz52CxDbkEVRT4LSIwf5v8nqSdwYvwMae3AMSEaw
	G/C8GUWgarhXhR+4ZBMekzayLIC7XO00eKAC0SmNCW3kwzltA5Tc8YsUeusLIJ3r
	duIjwaOJq594LrAxLAN7w==
X-ME-Sender: <xms:baPKaLI-NtN9Sf3hLmvDxHzi2mqN3S5tPKB_8t_x_WeGCssgUhpxj1g>
    <xme:baPKaPK5ehpWc2jhm5ter6QPMTQCcd-nyjU5zb9ZlBy3MVVb0s6gygzFW4NpMlhLD
    Ektf2VhwkrtW3z2ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtvdekjedvjeev
    teduiefhueevieduueelvdekteevtdelkefgudfguddugefhfeenucffohhmrghinheprh
    gvfhhsrdgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhhu
    rghnghhsvghnfeeiheesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhs
    tghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:baPKaFkh95roMBZMqTvM3i8nHbA7cQ0q3F5_n3hVU3ZwY0TX0m4xyQ>
    <xmx:baPKaBn4sFVBrbJcjhu0wiC3lsHm22Nt82GankTqHKfn-37uQ7akPQ>
    <xmx:baPKaHw3fG9mUuTXAu5fB7Mcq7idHSuU8DXCIron00Z4rKisPIasqA>
    <xmx:baPKaGp-Fc5975f7XuESgRxH8Sg2PqFCAmzE1uW4dbOFgkU-SCUahg>
    <xmx:baPKaI3M820DtG18gO1KTe_DYSQ-ExUVt36ZEt2TfNfiD_cC4cGSDzuG>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 005391EA0068; Wed, 17 Sep 2025 08:02:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AvC9u0wtbNw3
Date: Wed, 17 Sep 2025 14:02:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org, "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "Wing Huang" <huangsen365@gmail.com>, "Patrick Steinhardt" <ps@pks.im>
Message-Id: <145305ac-dbfb-4162-a603-b6b60df2bc5e@app.fastmail.com>
In-Reply-To: <xmqqv7lhigb7.fsf@gitster.g>
References: <cover.1756308283.git.phillip.wood@dunelm.org.uk>
 <cover.1757518141.git.phillip.wood@dunelm.org.uk>
 <xmqq4itarqfd.fsf@gitster.g> <xmqqv7lhigb7.fsf@gitster.g>
Subject: Re: [PATCH v3 0/4] breaking changes: switch default initial branch name to
 "main"
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025, at 11:22, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>[snip intro]
>
> --- >8 ---
> Subject: [PATCH 5/4] initial branch: give hints after switching the de=
fault name
>
>[snip]
>
> But once the default is renamed to 'main', that no longer is true.
> A narrower audience who are new users that follow an instruction
> that assumes the initial branch name is 'master' would only need to
> learn "here is how to change the branch name to match the tutorial
> you are following in the repository you created for practice", and
> "here is how you keep creating repositories with the first branch
> with a name everybody hates" is unnecessary.
>
> It also needs to be noted thta the advise token to squelch the

s/thta/

Which I only mention because

>[snip]
> diff --git c/refs.c w/refs.c
> index 149a8d1cec..5e5a41ec01 100644
> --- c/refs.c
> +++ w/refs.c
> @@ -641,9 +641,17 @@ static const char default_branch_name_advice[] =3D
> N_(
>  "\n"
>  "\tgit branch -m <name>\n"
>  );
> +#else
> +static const char default_branch_name_advice[] =3D N_(
> +"Using '%s' as the name for the initial branch since Git 3.0.\n"
> +"If you expected Git to create 'master', you can rename the just-crea=
ted\n"
> +"branch can be renamed via this command:\n"
> +"\n"
> +"\tgit branch -m master\n"
> +);

Repetition: =E2=80=9Ccan rename ... can be renamed=E2=80=9D
