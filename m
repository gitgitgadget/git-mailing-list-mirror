Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5807E214201
	for <git@vger.kernel.org>; Wed,  7 May 2025 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746614378; cv=none; b=hDZXs7MRw+osC3qrhYtuOiLQllHLB/83m2x2nre7kbllOlcYetauhrojM0qQue5cWMHBXtCR5X0aaJxezeQF7tZ7axoFq3jLMenb+iiXKVNKYWVXm+oNDqChKVRVOTkBRWioCFtp4d+668MQ73055fFNHYbKF+jNIkY/OMEl7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746614378; c=relaxed/simple;
	bh=v3doEWrBc4dNX0aK+QYsZNUoyaN3j3RzHSZimGf2gUQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jZePyGNHQt15qXzMwC+LBlgh2Rt+GD5VOEXfJuEtWZfTb+W5GSvBy3PhOMaB7cu5fEkI0lkhnY6sLxHCEb5M01s5PxC2BtrgxxWY0NkBvwz4XGJbavyyPJTLUMZTH+BbO+khlOPGNMi2oXQFcpkwr/Nirk/g7PWaJOFjhKgLbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=IXdZp3x8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ueu8gTxd; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="IXdZp3x8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ueu8gTxd"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FE141140135;
	Wed,  7 May 2025 06:39:34 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Wed, 07 May 2025 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746614374;
	 x=1746700774; bh=okZKWQ3AI3sHnmqf+CARII2xxC6wjNJM7UxH5fjfjsU=; b=
	IXdZp3x86cFLIbO0N2ytD7N96TeLCzwyg/XsPM77OazgoYURlMFjUKSXiPTmnAbP
	6YdKdfiLO+g2y2CNsmTAe/XkYGWokL1sZuR3/0lAJFxiEPzXUX1xEajuYDNb5f1L
	BJUyFi4AswlX+IKIRlUWzRJLyK/2aAEOJXFPqeeCWYcQQUAv6h3Rdrwwg6eNR13q
	pH2KokXpC0iMgy50F8p34oZc2WcBOoSRXDSVbkdnjYYztv8CHuZ7NLiM2hQRKLih
	3I9ZgDpHfUIhaBqoJ4WhcpJHzkytuWnx4TPcMqVrlv9KxSpCV+2FV/lFb7iykaOT
	LyoQKzaeYMHy/M2Urmbkdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746614374; x=
	1746700774; bh=okZKWQ3AI3sHnmqf+CARII2xxC6wjNJM7UxH5fjfjsU=; b=u
	eu8gTxdNjYKoUrF2NoP0kOXbAo2kgLe0HU6rNQOEE98nxeThhjb0N3USWMdKlQ73
	UExsGB+2UoYx2MSpn9l78a5DRj/Dn5bnYY35wGS+velS8/YX0oYGOuQoL6vsIJuX
	KtCEZsa2S8tLUNJJtNTZB/pcilunV8wb1z1ndFRFBgTiHWa71RBv41qdLJL7eeWb
	fUeBApD20jZKMeYlXmTX8Tu7KwawrPqEGRgZYhIKbUtSdUrn9cY3PBal9xB8hsr/
	KznTSoH2I+boxbG9slX1wYUKkKID4QNR68i7kfL04siL/oEyJ+zCNer6WaJd3SFn
	3YlGcPbWGXWHL0M1JZKXA==
X-ME-Sender: <xms:ZTgbaD7aVuzUGqQNVfaCYOoQe5vg7E5R5Fkc9czwWNbR3zT9O-M7LY8>
    <xme:ZTgbaI68LOYD8qmN4l714L1Tc_OhdvBWCj0CLQmo41YyrnEwRCKWrUanzsKNrn67n
    kQX-SR78IyvIFQkbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeiieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgie
    fgfeekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpd
    hnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehlih
    hnuhigrdgsvggruhhthidprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ZTgbaKc0vCDRVMhHd8A6TGj-lDcVk3K32WBa_nJ0r9JaVid-edDNjw>
    <xmx:ZTgbaELhR6hrNTSVUEoGsqCH6NsGxE1i9K_aAE8yJ_jRUHeSFVWmaQ>
    <xmx:ZTgbaHL5F1zFFbPIDo6eZdcqdR08jSBVFBrwZ01j6OuupUxFUvbVFA>
    <xmx:ZTgbaNw9UBK_edIKHsQvqgAKz8UhaykgLQYkasvyfUYlzWkhclTbLw>
    <xmx:ZjgbaPtynyo0N3lEWQvYbfTFjxIVIhj9gUCMjH5AWciQnBMw2-ckQDDP>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 24125780069; Wed,  7 May 2025 06:39:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tec1365582d89aec0
Date: Wed, 07 May 2025 12:39:11 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood123@gmail.com>, "Li Chen" <me@linux.beauty>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: git <git@vger.kernel.org>
Message-Id: <fdf7a827-d8ca-4edc-8427-a2c6eb470e1a@app.fastmail.com>
In-Reply-To: <0c4721c6-9ca9-41b4-a2aa-39f521d66426@gmail.com>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
 <196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
 <xmqqv7qdk3yl.fsf@gitster.g>
 <196a97f45e6.ee3375ac536926.7531113088063277926@linux.beauty>
 <48b86c85-bc39-40ba-a2b3-67de707dd798@crinan.ddns.net>
 <0c4721c6-9ca9-41b4-a2aa-39f521d66426@gmail.com>
Subject: Re: [RFC PATCH 1/2] rebase, am: add --reviewby option
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025, at 12:26, Phillip Wood wrote:
> On 07/05/2025 11:17, Phillip Wood wrote:
>> Hi Li
>>
>> On 07/05/2025 07:46, Li Chen wrote:
>>>
>>> Some projects require every commit to carry a Reviewed-by: line
>>> for accountability, much like the kernel requires Signed-off-by:.
>>> A first=E2=80=91class option keeps that workflow =E2=80=9Cout of the=
 box=E2=80=9D; otherwise
>>> people need to define an alias such as
>>>
>>> [alias]
>>> =C2=A0=C2=A0=C2=A0=C2=A0 rbr =3D rebase --trailer "Reviewed-by: $GIT=
_AUTHOR_NAME
>>> <$GIT_AUTHOR_EMAIL>"
>>>
>>> which is functional but less convenient.
>>>
>>> I would appreciate your further thoughts on whether a dedicated
>>> flag(--reviewby) is acceptable, or whether we should drop it and rely
>>> solely on
>>> the generic --trailer interface.
>>
>> I think adding support for --trailer is a good idea and if we do that=
 we
>> don't need --reviewby. The existence and implementation of --signoff =
is
>> largely a historical artifact - I'm not sure we'd make the same choic=
es
>> if we were thinking about adding it today. Different projects have
>> different requirements and I don't think it is sensible to add a new
>> option catering to the different demands of each project.
>
> It might be worth thinking about how we could extend the trailer option
> so that it uses the committer identity if there is no value specified
> which would reduce the pain of adding things like Reviewed-by:

That could be confusing for people who use trailers for
non-ident metadata.

I was wondering if `git var GIT_COMMITTER_IDENT` could be used.  But
that prints a Unix timestamp with timezone as well. (I don=E2=80=99t rea=
lly
understand why after reading that part of the manual)

--=20
Kristoffer Haugsbakk
