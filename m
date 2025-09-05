Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6F52F7ACE
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086717; cv=none; b=Jm61WOPeVTVmDRGVfYnP/r5hrDyV/+wLRGSRx9XiJ6dl0uJZAz0DGeY8aR/5e1n5YGatDFKrUEwMtIs3LldPgR7vqDxBzw7bxqkEHie6BcqcJTiKXcmRCM21iMDyg/ePVLSPxVrc9025fA26udvZxcUyIYZkait4XuycuVq2LcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086717; c=relaxed/simple;
	bh=a3uFfh4nxRrGEp+lgCoDn6KAMa8O0/H8IeJyMMf+twY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Tyyo+i9Vo/99/fBkh6W/t0pgdR8yqt8DqWZz5EnDBJkNmDYX+d+n618mjHLOLOrEU+4pHB63Zqli4mrh2Z9UtuM8HTyxWsUg9tbeqvn6tEXMAD9lC6u0x5NAnIQX8qRXj7fLP4mPaHz1C5O4XmMlSA6VxMddWc0tpSzbL/5zJHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=J1kbM0JE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j//4EOMG; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="J1kbM0JE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j//4EOMG"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5D38F7A0377;
	Fri,  5 Sep 2025 11:38:33 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Fri, 05 Sep 2025 11:38:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757086713;
	 x=1757173113; bh=1z+EezYFhCBIZjO54EaOItR0CC+0fghX6v7icZxTjRY=; b=
	J1kbM0JExyH2kFQxf1UitySPk18h6Hr/ONiQitd7CDn294Z/MwD2E/9/+91g7waw
	68J2jZDwkUSA0S4W5WcjqenZgSF26bBZADH9q0KyufF31x49+QsXJ4cbNQisbjg3
	vFrxbLD/T9rX58YdO6y1ahmbm29pibZEH13vUQ/6FwIN2sW/3iIEHVqUZGlF89sH
	DvA185VeDDcwfSLF3SouOxoRAOr03MfuWshRQgV/ndx6wtwNAs89P1yQNL72glc8
	9a3ocM+xmCB3FXlZSJpziywk/Uv3r1rNXvyQX4O3+vn8vyerectBYYiyZcwmnqPC
	LVEMMZygK+ILifeadjaFEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757086713; x=
	1757173113; bh=1z+EezYFhCBIZjO54EaOItR0CC+0fghX6v7icZxTjRY=; b=j
	//4EOMGRoKbfMd24U7q4EqYCieDd335zEfL0VsYd2GeECTApECkUhk7zjkv1BSLV
	/6RmGc0FFqTdQrIl682xbe+il0lTp+3Sq5yaQFO1S2cMLvtQJ7j3fymcwkFv5EbX
	oq+bHkhEFRzDKKhLT8OyWHQJIaYa/0X6626HWlPTxmpTMbWT5rWO6eC5BKEvl5wC
	zgcAD4oILOHwIoAZkchS7wG7Lu8bA6YgcLwZf9MgaBLk62uIKXSgJgydCSK6U9jv
	vQyFhFsnwF+9VgiwrNMJRRL5+dqcLsH+TsXLvo034FVWA3MI1FLd9v2uI0xtIuQk
	kgqhrrRzgig6ppn1D+qEQ==
X-ME-Sender: <xms:-AO7aK1jAUvOs--4JNOrL3JibLxDMHHb4-9ugZpDfi6kpRKpxqyyb2M>
    <xme:-AO7aNH6lmB0tfgDjX5BG0dTEiKiu4bVywCwbysQ-T_UBN16mMqkFj31HQ0zrYJBJ
    iIfZowKohjirl7J_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthho
    fhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeegjefh
    heeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhg
    shgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:-AO7aFX61f_Xy5g_OKIFrHBe8I40-b7Ze-V1HjrNEH7N05IRZFGdjg>
    <xmx:-AO7aCuxdd619BMGma4YwRSX3xeCpTJVr_2EqWeagPDteeAOSDN-ag>
    <xmx:-AO7aAZr6RZoYhOKtm1ecIOW8sug1Iihm9VSHxVkDyPJUwYqrBtUag>
    <xmx:-AO7aJU9S6vWc9-2_LxWVWxQEU6rJcInSe5hGoCP7RHCUx3Q8qzTsQ>
    <xmx:-QO7aHc4FbnpG1cQfrCBgGmPgrFqqxO_mqwm0ZJfyT8vftSOtXdJrMbL>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AD3691EA0068; Fri,  5 Sep 2025 11:38:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AwDhMGrf3VWc
Date: Fri, 05 Sep 2025 17:37:03 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, "Toon Claes" <toon@iotcl.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt" <ps@pks.im>,
 "Christian Couder" <chriscool@tuxfamily.org>
Message-Id: <cbee77df-19e7-4070-aa79-a80107cbcc65@app.fastmail.com>
In-Reply-To: <xmqq5xdw537l.fsf@gitster.g>
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
 <xmqq5xdw537l.fsf@gitster.g>
Subject: Re: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025, at 17:27, Junio C Hamano wrote:
> Toon Claes <toon@iotcl.com> writes:
>
>> This patch is based on 'next' at 1ba7204a04 (Merge branch
>> 'kh/doc-markup-fixes' into next, 2025-09-03).
>
> Can't you be a bit more specific?  We usually say "do not build on
> 'next'", but what we really mean by that statement are
>
>  * Your topic may interact with some topics already in 'next', but
>    it is unlikely that you depend on _all_ of them.  If you are
>    willing to depend on a few selected topics (meaning: you accept
>    that you have to adjust your topic when they get updated, and you
>    accept that you cannot graduate before all of them graduate),
>    identify them and build on the result of a merge of these topics
>    into 'master'.  State how you constructed your base in your cover
>    letter.
>
>  * If you are truly depending on _everything_ in 'next', then stop.
>    Wait until all of them graduates, and then submit your topic
>    after that.

It seemed like Toon was applying the part in SubmittingPatches about
applying fixup patches on top of the series once the series is in
`next`.[1]  But then used `next` as the base instead of the series.

Of course that simple topic named kh/doc-markup-fixes is irrelevant to=20
what he is fixing up.  ;)

=E2=80=A0 1: =E2=80=9CAfter the patches are merged to the 'next' branch,=
=E2=80=9D

--=20
Kristoffer Haugsbakk

