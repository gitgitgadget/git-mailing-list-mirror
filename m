Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3E421B191
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 05:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769407107; cv=none; b=jMdcpB3/z+y1OUblK0jsiVFz1V2adVK6g2spV6bZ+klZYg45NCWPkipRtgalUgOLdT9NlmohLx9QYAJKNfl7C7Nz9FOpc0YReIIm73v3+3la/UH4hLWOvv2sFllPrRJJQBfkMa9ve5tvsPliMaCDMkfzkOouF/8AMUyeTxKluOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769407107; c=relaxed/simple;
	bh=fyXqdEHJbHc3aKI/Cw9jEOEUOVTVWM8est+uVFFTbzo=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=krK6AsDY3akFv8Rly+wRJSEtb3KacRxILhlpGn3fHPexMjenOPkZeiqFwLQ/kWlE++lYCa+vjZJ3pNI619i6HnKFhqHy1KAKu8H3/lzw0StjgxdBn4X3X1tAYk9QNlThnJl2fgXqq5/m6upHQ8YjPoocDQCrCvcMD2cCnV1bd/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lhne+x3T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x4OYdHQe; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lhne+x3T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x4OYdHQe"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 02AB91D0005D;
	Mon, 26 Jan 2026 00:58:23 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 26 Jan 2026 00:58:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769407103;
	 x=1769493503; bh=H4quCznUVE3Mch1K27U2Z52BjB5QZdw8qc0MTDYWKDk=; b=
	lhne+x3TZlsbD03F73IeSK45ny+Vidpjj5/eWYjruHeFwoqL3kOWYbEO/EdKR8RW
	CEta2X+tIlxHi4v1k6dsKfVfY28UuG5uViq6VqQy4/BzHlQEkJ4esInsc1OHyPzu
	KfUkRX88OOqws5fpZnRmfkQLjyTSuJqJODRpzU5q8poNUL2kJdkYRnWgIX+MUZ8F
	JZ7Vn/JtzBPQKD36s8s9GT+X++g2feZ1/KBBibG/zuxIGJeC65BfsSBjDpyhY0pa
	/Rs6Z47/VVtchXFlzbJ7sH1M1cNlTbEYMZuNKyCwq81Bf6KsAahUiigt8iTu5EV5
	+W8rrKRPA+u6S+f8io/Xbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1769407103; x=1769493503; bh=H
	4quCznUVE3Mch1K27U2Z52BjB5QZdw8qc0MTDYWKDk=; b=x4OYdHQe4BN+TK9pa
	XOvT1gEMeT9d6nKMRrgy7rvqY66KtLIRumPhUkw7gD3OrHwATsEcq1p6Edi8FlJb
	4dIJ9lllUySO7uLOeXZ5Wlg6LaixXNvkVVFHZoNk+l4iCQPko4fzRXozcgMtAzAD
	MLZHMZ/tixX7CsKxJmRP4ij6L0Ik3RE6jhLenZJjG2LVbX7SBqG3Jiwy1UHuUntJ
	WBM5Fh9kJeH/CYBJJU4+ngoxWa5BIRHAg/m1sUvzT+R1Wn9M1/l6IBr3vOJ5+wuM
	RWtqBTYOg5XwPTZWysdKgvZ/sxobmeLD4g19F+19ZZXFlcVUcQ1+2CKf9looGd7I
	RB2yQ==
X-ME-Sender: <xms:fwJ3aSa2I0RTEOeI_OCcCrD7qrb0rxMatCuVgIbUJyzha0N_mAwefi4>
    <xme:fwJ3aQOGcdOnOiz99ve0W67i732VU6EfxHCJVj5FH14zCZnCC541gOP7WAGODcyx-
    bPb0n5zxGzi5R2DYq8orRBdEIhioCv7u2NUBP6hmRexbyoLD-2a5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheeikeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeevkefhgeejuddv
    ffehlefgfeejuddvieevueeifefhhfelieekgfetffeuteefieenucffohhmrghinheprg
    hstghiihguohgtthhorhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhgih
    htghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fwJ3ac2LaBl8HCobr0__vP5HRuWPu9UKBS7TyC60Uumc9u2zkS6ULA>
    <xmx:fwJ3ae035E65h8FZhUwzzZGhhTj94kdF2lsl63sbMpQvr_Ujcppk1A>
    <xmx:fwJ3aX85SCB-QBu3Km_Sc3aoY7j9luXHWe3W4mZOFn-sSiFpklHG2g>
    <xmx:fwJ3aT0WDtCz8nIOkzUWuWV6wLEoDaIIjXwE73GRh6F-NOBh88s_JA>
    <xmx:fwJ3aRUVI-QpeWBQkNtM6Vdf3aAkheNyaoh4ug3wAYZ8lxhjsYDI_L2r>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A65BD1EA006B; Mon, 26 Jan 2026 00:58:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AC2L5HFm1BQs
Date: Mon, 26 Jan 2026 06:58:03 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Message-Id: <0dec5e08-f4a2-4bcd-9324-b0fcbc2fabe0@app.fastmail.com>
In-Reply-To: <3926333.kQq0lBPeGt@piment-oiseau>
References: <pull.2036.git.1769202903.gitgitgadget@gmail.com>
 <d078e1d94fcf8511743787623f0c1abfd0321849.1769202903.git.gitgitgadget@gmail.com>
 <51016c02-40de-431f-a4ba-e08cb1bb8235@app.fastmail.com>
 <3926333.kQq0lBPeGt@piment-oiseau>
Subject: Re: [PATCH 4/4] doc: convert git-show to synopsis style
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 25, 2026, at 22:11, Jean-No=C3=ABl AVILA wrote:
>>[snip]
>> >  +
>> >  This format is used to refer to another commit in a commit message=
 and
>> >  is the same as ++--pretty=3D\'format:%C(auto)%h (%s, %ad)'++.  By =
default,
>>
>> Not changed in this patch but this doesn=E2=80=99t render correctly f=
or me. It=E2=80=99s
>> not inline verbatim/code all the way through. But it is correct if I
>> remove the `\`.
>>
>> I don=E2=80=99t know why `++` was used either.
>
> That's where the synopsis style fails. If we use backticks for this sp=
an, the
> parenthesis are interpreted as grammar signs, whereas here, we intend =
to pass
> the whole span as verbatim.
>
>
> For asciidoc.py, using the verbatim form '++' ensures that the whole s=
pan is
> treated as such. On my computer (asciidoc.py version 10.2.1), this ren=
ders as
> correctly.
>
> For asciidoctor unfortunately, the synopsis processing is performed ve=
ry late
> in the generation, after all parsing has been done. So, the '++' verba=
tim is
> processed the same way as backticked contents. I haven't found a better
> alternative. The output is this wrongly processed span here.
>
> This is the least breaking way I found. It means that for asciidoc.py,=
 we can
> bypass the synopsis style with '++' formatting.
>
> If I remove the backslash in this, the span inside the single quotes is
> converted to italics by both engines.
>
> Can you describe your setup?

    $ asciidoc --version
    asciidoc 10.1.2
    $ asciidoctor --version
    Asciidoctor 2.0.20 [https://asciidoctor.org]
    Runtime Environment (ruby 3.1.4p223 (2023-03-30 revision 957bb7cb81)=
 [x86_64-linux]) (lc:US-ASCII fs:US-ASCII in:US-ASCII ex:US-ASCII)

Anything else that is relevant?

>
>>
>> This looks correct just looking quickly over.
>>[snip]
