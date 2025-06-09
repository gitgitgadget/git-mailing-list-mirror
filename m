Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14E221D59F
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749503587; cv=none; b=KMmyjqcnTVc0bKLNNi6gPsb2ZNM/Y4kQ0uTbR57sBOIEEcxp76y1N5KYPL2C0MYWHL5Ow6S/U5nFwpkq79bkr2lhpyH3cgo/berX/gHB/bHa572TlXxQ2a/sb2tiofW80XGFBw3yWNY+Ssnx+yEfPh5toU/leN7WZsxvq16ykLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749503587; c=relaxed/simple;
	bh=qjdFB9SuFS0qi2dHIeULrUrA/LZlQEZyMg0GTSxIqCQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HQmUA06M9oCx/i9+n/fA3/qdK/6Oqq+7tPE9liRcu1wuEFHWFewUhyNwrkBW7oLE58VYisU8uc5Ycom7LHQGW5MkB0Qsz13J0k8GoVHHFg7FS4sxp7o4j1oFfVeE0M0OkhCn8/LLXG09QpO0tO0dhEwSI1ABZyHfJW7Ew2TZXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fy/9RE/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EVcf1Dds; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fy/9RE/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVcf1Dds"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 9112F11402EF;
	Mon,  9 Jun 2025 17:13:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 09 Jun 2025 17:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749503584;
	 x=1749589984; bh=JaZqJ+wIsXQfIHIvcC8qsJwVJU+wwIEeVhX6sqOJPzk=; b=
	fy/9RE/2bqqsc8ABi193HQ4sP5GAMkHDqMl9xGRm6w9LjqxgP+L2wSOKLMvO2FWx
	k5nePPX67JuhHjw9WcOvCa3l5TkYj1jrFCWsOrP2VnyobnV9X45gyXZUZPo+pqa6
	BxwRJRUQV5XNvRCtwITkjUiq8aebUvv/itglvDdQEXohCDBBxkK8Q9ISIlhC+8px
	iAfSvSpyYYT/qQcu9eCK30+Xhb7vApUc4QU9W1q9No6oq3nKJrV9fiwWeH7WwIMH
	OweYYpK0YlCnvkvdrUBaIamqbp8SRTCdddt4Og0pQ6hJBNrMyKQFw3gxRHgMUgmD
	Z95rOQ9bV0dNzBBsx7zuTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749503584; x=
	1749589984; bh=JaZqJ+wIsXQfIHIvcC8qsJwVJU+wwIEeVhX6sqOJPzk=; b=E
	Vcf1DdsP2xo8cEp/TDVJmE7+Vb1t9watdwSrMJJgN2VZbadpIF1rNIOjaxisT/gn
	w3LAzyCeYsVB0oaiUjlv7jehD56LJ+VEDWytn0WP/1JeKi+8xqJkz0T8KVihZvzE
	KzQ/fV/vKBePpmU+9BSvZQhZwdnBlIr1o66NyMnWwBk9H5qKMWFEhvdw4L33agal
	36cjSeh+hk3zUHqnFGsP0TBqAbQ5qYcNl+843RgmQhD9MldBLGuOlO0uB44WRIv+
	vDosTc0Z4qbIbikzQ+4nVg1CnknPfvIDrioowEGGRYixSaaALDjZHIc4aDSTzvyz
	x0W67oWkI9i/LRiFg/hvA==
X-ME-Sender: <xms:YE5HaN5D4VAXm05t3Zl0R__yO3TuJut_Ur3UyxZcxuay4E-7aEoAzuM>
    <xme:YE5HaK51gS8fi-hcp6JC3rOB4XN5Clx3j-a0g5DJmYQBa0ml1T8d6RjnSsb0R9GCL
    kDywcrW2BHaz3IAWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdelkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnrdhk
    nhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhoug
    duvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghk
    khdrnhgrmhgvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YE5HaEfHoeHpZsuqi02drla5hc6FxB23VEaoKQyFjglEzW8hrteu2w>
    <xmx:YE5HaGIPQ_eDku-youFb3y4WmnK83ZKgS3n3TQsF4lnVpnfNi2We0w>
    <xmx:YE5HaBJd--0w_q1o4Mncp-Ap1khazcOiMqfNaTLtMitsvOXUo4pX_A>
    <xmx:YE5HaPxoIxP7PF-SiAIoaj6lyqSg3OUd_1HBJymnhyjqyWj7s_0nPQ>
    <xmx:YE5HaMVmHarzQWL8dybX4E9Cf1Zp0WJn7PgvKLW1qxT9tiSzXhxhcrxl>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1F4551EA0060; Mon,  9 Jun 2025 17:13:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Taf9fec3ba48f0e1f
Date: Mon, 09 Jun 2025 23:12:42 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>, git@vger.kernel.org,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Message-Id: <5ca4e740-d243-490c-ad85-13b330165365@app.fastmail.com>
In-Reply-To: 
 <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
References: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com> <xmqq5xhmvuol.fsf@gitster.g>
 <CALnO6CDgcQCuhxcJLH-XwxB85mxqokxsf04CU4yseTy-=XUWLQ@mail.gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025, at 22:37, D. Ben Knoble wrote:
>> In this case I am not all that sympathetic to the idea of the patch.
>> The consistently indented lines makes it more clear from which line
>> to which line came from a commit log message; running stripspace
>> would break them into paragraph pieces.  These editors that complain
>> probaly can be fixed?
>
> My editor doesn't complain, but it does highlight trailing whitespace
> at my behest, and it tends to be an eyesore (on purpose: that way I
> clean it up). Perhaps Kistoffer is coming from a similar place?

Yes exactly.  Ain=E2=80=99t nothing more to it than that.  :)
>
>>
>> Alternatively, if it bothers users of certain editing environments
>> too much, perhaps the indent code in the output phase of "git show"
>> should lose the indents for empty lines uniformly, shoudln't it?  It
>> probably should be a fairly isolated change, like the way how the
>> expand_tabs_in_log bit is handled in pretty.c; give another bit and
>> teach pp_handle_indent to return when that bit is set and the
>> payload it was asked to show with indentation is empty, or something
>> like that.
>
> I think this suggestion would also help folks who "git commit -v,"
> which IIRC is also indented in the template.

In my testing though it doesn=E2=80=99t introduce trailing whitespace.

--=20
Kristoffer Haugsbakk
