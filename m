Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6627814B
	for <git@vger.kernel.org>; Tue, 27 May 2025 16:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362335; cv=none; b=KNRmhPjuZ6JC1vdkj6iA/gMti1uO8clqlhVIknZX6/CGfhbqyUM1QYpfPFvEUIST3sX1K/15xXqHtcAqEThJTmf7uZ6eahMXjl1VCrWTqYbiRT3jQqZ7PPKtwIHhP7X1GxEzNaEobE46WjeMMXVhn+1HvJmGKj2mHLcN4Nq1MWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362335; c=relaxed/simple;
	bh=k3eWpO0Zct33o/GZ7inO7UhAAqIUxOrBVi7JBWnAWXU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VEv2g1IEJKcm4KjuyW9aFPVUo/icWr1FczktBo8O/fAL0ni5mr3QyM8Ga0ulw6bmsBLHDEm6R97TPgosSRwRsBzrckcOmkp/rYkhBBQOK8BvYUsCcOZCjykTH0qLFmC/pvG3jN0kQmS2xMSRc5o0CzU1y1EJm7uSSt84m1XllZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=UjZnllvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g88E6Bm+; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="UjZnllvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g88E6Bm+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CBE125400FB;
	Tue, 27 May 2025 12:12:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 12:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748362332;
	 x=1748448732; bh=NhWCujaq0yD7L8ztBWAnbOpKTIwam3t+gpLR8yVLzdI=; b=
	UjZnllvyLSisaRylT01fW1fvbfyla8PQCtDONW+YFfVQt06frLZ6Y7P41zBjrIOy
	VD0gygnvvMZuoGcD1STHdVrniAHXLvWCXks3UDFQ1p11KF9MWg3Hiz+6dTdiTnGo
	7j+5XIGiY32oV9TiS8kwq6ASjSPKtUcj6Uk51oLtkRX7aEs+Pnxx4mAmDqD1dP+g
	oQQ8mZ/slldtoyIB05WZHRRpzudm7t5pTSZYWIpQ2RDsz9XRdpTtomfWO3phWvVn
	DTAkfSq08IY/31XTAeGTDjaJcVxq0K9QNCx++dI7OVUb2TgGkoGiO9JteU81M/hw
	Mr166d/B/oDAKIgcVjJnog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748362332; x=1748448732; bh=N
	hWCujaq0yD7L8ztBWAnbOpKTIwam3t+gpLR8yVLzdI=; b=g88E6Bm+xNP7ddODI
	dZNNGQPmGCkdYVzxiF4p/aO4z+oPXGEVoEkk5h8GeSwXYwiIJwymGsI08beCJFPj
	K+U0mifGZrwyavW0yDxGNGisbHMrzCh8zCWHIpkViTHQ3rmHRl8cZyuGoBRk05Dy
	Vx4fHgY+1T4y/4OthjH0cCp2fGc4JIM3McSaDVyL+5Ur1EHCKk4hMZr7I7R/CrBF
	f9WUwW/Auooiaa32xM7ke8dFb/P6g/APyLDjvH3G0fBFJvnu11fLhTACwGJ+UbMZ
	FP/wn0kJn/ZBpTFNLnXwQmpCVuTOSUn3tAatcBpmkf74K2mvH2r9NGl0c5Rh4XU3
	6KL6A==
X-ME-Sender: <xms:W-Q1aFcG8imydDri-Wihd8R5g07SiwI98R3Xw9vARWYqXd3dUuZc_KM>
    <xme:W-Q1aDP56N_sLu3_gWtTEWwFPYwwolZS02iz0tHPqWKkImTGPo4bFtDBHSimuENud
    OU3LThZXNaAGBEVWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdekfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghugh
    hssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghi
    lhdrtghomheqnecuggftrfgrthhtvghrnheptdfgffettedulefhfeekheetgfegfeejve
    eikeeffeeikeekhfevieeltdekgfeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrsh
    htmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprh
    gtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:W-Q1aOhEepIoxU8WwCnZJWxSe_q9MXzJjPKt4awAZwEzjepCtpE9Tg>
    <xmx:W-Q1aO8yuzLynkUvpXlXMjvNTpbPxhsuOXif8LMOjwF4Hol6l6pxMw>
    <xmx:W-Q1aBsuDzzBDQumvQorUyze-d_t4oJ-ibu_TUGNROp2K3_WwUp66Q>
    <xmx:W-Q1aNF_raFUvTTcbfad-Po0Qlfyx82qTK-EJP957qSQNqos60mQaQ>
    <xmx:XOQ1aKuzjzohNv6Utiab4vpCtrqFXjx-aniSKLfua_K2to723MH9K_Ko>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3A2051EA005F; Tue, 27 May 2025 12:12:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Taf9fec3ba48f0e1f
Date: Tue, 27 May 2025 18:11:50 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <code@khaugsbakk.name>, git@vger.kernel.org
Message-Id: <820b1255-c2e0-4383-aebc-46e49112fe2d@app.fastmail.com>
In-Reply-To: <ab009472-d15d-4894-aa83-0ab8b0d2dfbd@gmail.com>
References: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
 <10280d7d-af36-468d-82b8-e0e780c38ef1@app.fastmail.com>
 <ab009472-d15d-4894-aa83-0ab8b0d2dfbd@gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025, at 10:24, Phillip Wood wrote:
>> Do you mean doing the operation on the output buffer instead?:
>>
>> 	if (strbuf_read(&buf, show.out, 0) < 0)
>> 		die_errno(_("could not read 'show' output"));
>> 	/* strip trailing whitespace introduced by blank lines */
>> 	strbuf_stripspace(&buf, NULL);
>> 	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str=
);
>> 	write_or_die(fd, cbuf.buf, cbuf.len);
>>
>> I think that=E2=80=99s cleaner.  But I don=E2=80=99t see how it makes=
 the code more
>> future-proof.
>
> Because it is now stripping buf and not cbuf. If in the future we deci=
de
> to build the message in a buffer rather than writing it piecemeal to
> disk we would change signature of this function to take an strbuf
> instead of a file descriptor and use the buffer provided by the caller
> instead of cbuf. If we were to strip cbuf then a naive conversion would
> end up stripping the buffer passed by caller, not just the output from
> "git show". Various git notes subcommands have a --stripspace option a=
nd
> calling strbuf_stripspace() on the caller provided buffer would break =
that.

So stripping `buf` is what I should do?

>>> Should that be " \$"? What you've got seems to work with dash but I'm
>>> not sure if it is POSIX compliant or not.
>>
>> `$` is the anchor metacharacter in this context (end of string)
>> according to Posix.
>
> Right but what does the shell do to that '$'? It is not escaped and
> inside a double quoted string.

Oh right, it=E2=80=99s about the shell.  I=E2=80=99ll fix it.

Thanks for spotting.
