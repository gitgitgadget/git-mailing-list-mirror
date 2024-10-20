Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99F1E487
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 12:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729427437; cv=none; b=ozoC9FCbTxMUnGx2xMol0pdeacPGvvUam79X2H1sB+uUWCeg4nN+o4YyIjQTpg8wrlK6pIc9L0gioXvW7R3OM2bnnBRG5nUQ6SWql187JQ646Xrdt/rMPQwVgbx+BWTuDNBlK0rhL8gWCUoq7dxtrnmn8nwRDaVaaohbMLAz2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729427437; c=relaxed/simple;
	bh=Z5igtwAqzXgvGAeGb+N7ZedKDmXug/sZxg9bsIaGHvY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BiyzfuL3P5t7jsjtT8P+/BAhkQ9+tGjBLcDeXbk8ryM7zRSs2hQ+mtKhAj64xYJGecTsBXRAurt1FGOznMzz22wcsrsH06ox4xXaiMdvz9ESUu1Y1CrYaIxkDos8EJI/JFy/saOAgvJEghz6yzd/sFSUAN+kfmfrP6zQWFexXzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=imubnzYE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keyYx92X; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="imubnzYE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keyYx92X"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 722F91380215;
	Sun, 20 Oct 2024 08:30:34 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sun, 20 Oct 2024 08:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729427434;
	 x=1729513834; bh=rWTlGG+pp/OmuI4ldr32SF3El8WZPfhrL589P31XKP8=; b=
	imubnzYEIIXD8Eqggrzf/dp05RyOXiFeJPOziWUj4YbKoS/us1ywsD20BW6321C1
	o2W3Z5UfJtszvo8bFf6dADSCp/KmuTJ7u+4kF4lE7pd9Kthiu8mB4tnCu7NC6LYm
	/0X778qJcjz4d99AuAmHgGBKO7tPsG5lxLQXKQZriHV0L5HMwraua/E1fBqY/fWX
	9uUZ9VX74ywmbzL05kurmu0/PViVVjmOxp1nUXNgsUmQ1IRdjAv0wuUnBZNsyjnG
	aIWd1+SKCaINFQjnh65xvfoz/VbUqzp8lhhLNGwAj04FiMWM5rtj6qyD+hGUKI42
	Tts1FNzuE70Li10rVUp8uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729427434; x=
	1729513834; bh=rWTlGG+pp/OmuI4ldr32SF3El8WZPfhrL589P31XKP8=; b=k
	eyYx92X95+wcLsN5wrFqS4QwdUyWMH5ulCY74fi32zImy/Zqab98yPcTA4O49Jyc
	z3kObffAi9VzjRMF6Ls87jbegOzDlECQxxP6nYxXJR9JyI3y62geS8ZWs+ip16Hq
	8rm1ZKa/S4HwhcMOvtD9uapBsvUEzGzSFb8QQWi+IJX4Phdo/fJiWZfGGd+oPx7S
	eI4hLDKjLmjTbNKGgbKWw/cMi7omBPeN540AaqrgTWwMG/HYP4ZqDaTs+HPUdhHP
	DELh4JuYxpg+tB3mzNlSvujuxOgFMIvWkCAIsH4LQmv2SsUomI0opYmAmv3JrmgG
	iWgwGZaeITrmfIwwPDjIA==
X-ME-Sender: <xms:6fcUZ30IFDqNHu1GCeX-3VEBsQnTpSU4zs_brQHU5oyvwCQdEAhedKw>
    <xme:6fcUZ2EHWjveKQhbVW5kBaH0Cbmv0z7nd-5zwXNFd3ymxLqOjl5ZXndj0DJ9ER4ex
    Fx08I0sKlGdtxEYPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehjedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdeigfegjeegjefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfe
    ekudfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    khhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsg
    gprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhl
    ihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegsvghntggvse
    hfvghrughinhgrnhguhidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    uhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepmhgvsehtth
    grhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:6fcUZ36iwgo2CJhDxfZQ5IB-dBrc9dlG5uhUyqc45mAAnxFr5tyi8g>
    <xmx:6fcUZ83P58dr9M-rmrlEAtcf90ytIeBUHgNSxUx88sMe_ngXUQRiFw>
    <xmx:6fcUZ6FspfUut-IBrVfJkDwqY5vZaxByjeBYTDwMChO7TZiejjHShQ>
    <xmx:6fcUZ9-CWnqhqewNiIw74-QbDCkXALtvC1pTddnZ71ivEvTiDgaljQ>
    <xmx:6vcUZ90rSHACvpNmwPC73jtB5ZyaLSfLlZO-ifzQ93j1wv9SjD6J-AKw>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6954780068; Sun, 20 Oct 2024 08:30:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 20 Oct 2024 14:30:12 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Karthik Nayak" <karthik.188@gmail.com>, git@vger.kernel.org
Cc: "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Bence Ferdinandy" <bence@ferdinandy.com>, "Taylor Blau" <me@ttaylorr.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>
Message-Id: <bcb0e2d8-ebee-4835-aa43-05107199ee62@app.fastmail.com>
In-Reply-To: 
 <CAOLa=ZRAGmgfSHjAx6-1q9qV-aJ_Ciw=RZ6kpygqbSO+yAUEeg@mail.gmail.com>
References: <cover.1729017728.git.code@khaugsbakk.name>
 <cover.1729367469.git.code@khaugsbakk.name>
 <71d1e6364a21767a8d80c96a30282e6557fec426.1729367469.git.code@khaugsbakk.name>
 <CAOLa=ZRAGmgfSHjAx6-1q9qV-aJ_Ciw=RZ6kpygqbSO+yAUEeg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] Documentation/git-update-ref.txt: remove safety paragraphs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024, at 13:13, karthik nayak wrote:
>> [=E2=80=A6]
>> These paragraphs don=E2=80=99t interrupt the flow of the document on =
that
>> revision since it is at the end.  Now though it is placed after the
>> description of `--no-deref` and before `-d` and `--stdin`.  Covering =
all
>> the options is more generally interesting than a safety note about a
>> na=C3=AFve `HEAD` management.
>>
>> Such a safety warning is also much less relevant now, considering that
>> everyone who isn=E2=80=99t intentionally poking at the internal imple=
mentation
>> is using porcelain commands to manage `HEAD`.
>> [=E2=80=A6]
>
> In the new reftable backend, HEAD would simply exist as a placeholder.
> So either we do as you did and remove this entirely or double down to
> say that writing to HEAD directly is not supported. I don't have a
> preference here, so this looks good!

Great, thanks. :)

Here=E2=80=99s an attempted rewrite of the final paragraph for the possi=
ble
next round:

  =E2=80=9C [Besides,] Writing to `HEAD` with `echo` is not allowed unde=
r the
    reftable implementation, so this part has become misleading.

But now it doesn=E2=80=99t make sense to write multiple paragraphs and t=
hen end
with the most important part.

Maybe

  =E2=80=9C Remove paragraphs which explain that using this command is s=
afer than
    echoing the branch name into `HEAD`.

    Evoking the echo strategy is wrong now under the reftable backend si=
nce
    such a file does not exist.  And these days people use porcelain
    commands to manage `HEAD` unless they are intentionally poking at wh=
at
    the ref files backend looks like.

    Maybe this warning was relevant for the usage patterns when it was
    added[1] but now it just takes up space.

    =E2=80=A0 1: 129056370ab (Add missing documentation., 2005-10-04)
