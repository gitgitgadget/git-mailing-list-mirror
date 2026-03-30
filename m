Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2F13E316C
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909429; cv=none; b=W8ypIlvg/zK+y/D/rH+mWjkjelytRtIXW3AbxiDXGnBk7u6n/tIH5AjP4refgnNl1YocSUkOdWHNYQT3kGh8IlFW2SLICKXqFZSYcjC6WO0ZkL28S32b2/M66L8BIyc+LCdF7kdkC9hWALBJtQL6aT2J1Y3n26kL3SO5LPUvShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909429; c=relaxed/simple;
	bh=kFRNVqbICzO4Rvn/NeaY40I9iyOb89MjBHc+dWYZDvM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CDZsYp+Suo4zv/4e6cI9atNjn0w87Jy617g3eDn1x5PeHTISYXRtigeGZ33kQ3DZHH7jGqHbbi9CdS4z5cZiTR8u+nD0VJ6WcszpeJaqju/jp914a6q1nTaN4Eccgfb6iru8f3XZM+8jIP1bZfRPZN/LUFOGVxqIFzEA9cHvgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lHAAKDER; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p890A20F; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lHAAKDER";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p890A20F"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 023E17A00FB;
	Mon, 30 Mar 2026 18:23:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 18:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774909419;
	 x=1774995819; bh=7/DMQWcBQvhNu59URsPVbvejVNli7YAHxn+DnDomvRs=; b=
	lHAAKDER8orCUdg+SX4nB1YPxmETTLxWR20DVgKxjV0rX7GfBv5zAcgDLCb8VYew
	3nPDDaKgaoI510HEjBugvjSTkcDKNhnPsGuOV/LnW12mrzsIb+2AND3gyuaVB1X2
	BOC1TLGM7Xan8AJ07EBn5R2+5W1nKfjINlKcfQuLlAN3ggGUOFHWKd3IDCqobAfA
	WwQtjZgKJ9V02yipwC8acjKz4RAdIJnLKCtyZZC7yqMOGwOUNsB152aiR2mj8EJ9
	GVoSjN6ngJg4Y9QrXLlv5nU1OduSYGcvXefJNKwaijNFkl8XWnw7aCxN9F7mVOSd
	f9ODwTL95g2OPTXKfrtBeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774909419; x=
	1774995819; bh=7/DMQWcBQvhNu59URsPVbvejVNli7YAHxn+DnDomvRs=; b=p
	890A20FuVknKP+RAfuw2oyiRj9UKme/B/DXU2NJg7UM/6/6oyIhI8ukdK9xVQaie
	3D+JSA5p4yjQh9YQLMxRPeVfmlzZUU49xxxZhgAZrLBYxyJQzNDB1MTvFZoH4Qw/
	S4RCBuOGY7Jem61/ZltySml5P/gw0/Z7u610g/VRUN7s1zfdm2SKCKL10VlLBqiC
	NJY5f5yW1xhzmMNFg+KaXvrTAPFZG/S/DM4fdo2r89KobETXuegTViTlXyXCVG08
	3OoQh48Wk98oakydkn8A+o38bWYLpzWv7oIJ4WMLdutyKEd/N0ePRupcPJbcX6tb
	dLkSth01ihHCIEjcPo5QQ==
X-ME-Sender: <xms:6_fKaQu_zCP_lUzs5cCzw8H_TSnVL52nL0WbFSgjj4mYI-Lr3uuTQ6g>
    <xme:6_fKaYQNhLVdTfBns67YENGgZys6JGizuGsXcyJLPim_H-Cbc9ckc2KhHfCf-GF4v
    3dMxOl6L0neG7GEIDtnR03y4aC1BPzbj6b8bIV20j0bNUg1rhp1Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhs
    thhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdeigfegjeeg
    jefhheeuvdegjeekleeguddukeeljeektdevjefgiefgfeekudfgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhes
    ghhmrghilhdrtghomhdprhgtphhtthhopehjrggtkhhmrghnsgesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehl
    ihhnuhhssehutghlrgdrvgguuhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:6_fKaVRDW0EVdQmYV14Dc__WzD6EHm-IUH3waZTFRxzX9CPBkzuCsw>
    <xmx:6_fKaQRNakFdNG8mnb80fDfP13ASjqfdw-z9a62Wfumx-oTci91ltA>
    <xmx:6_fKaa4fOggihffnwSzND_-VDfZ0Ne_0exn1mWt3sIqCSNxFU5WuZw>
    <xmx:6_fKac0qmtXZrAzrX5Jly0bGlnYYNGTGCRBoG3iV_DwC7AX-PswXow>
    <xmx:6_fKaXV3ot6UaOkv7eccm2EnvHl3eEDHjk_sOfGSeHyxOxSegTBQ-0mK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 897271EA006B; Mon, 30 Mar 2026 18:23:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdJf8Qpl78Hc
Date: Tue, 31 Mar 2026 00:23:19 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org, "Christian Couder" <christian.couder@gmail.com>,
 jackmanb@google.com, "Linus Arver" <linus@ucla.edu>
Message-Id: <5ba0bbcb-25a7-4ad0-ac1d-c86508eaffdd@app.fastmail.com>
In-Reply-To: <xmqqh5px6kz4.fsf@gitster.g>
References: 
 <CA+i-1C1DM0CHoFJ0A5CchQg=qDVLi_SSiZqcd0dxsay-Y94WTQ@mail.gmail.com>
 <CV_doc_int-tr_key_format.533@msgid.xyz> <doc_int-tr_not_rfc.535@msgid.xyz>
 <xmqqh5px6kz4.fsf@gitster.g>
Subject: Re: [PATCH 2/2] doc: interpret-trailers: explain key format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026, at 23:55, Junio C Hamano wrote:
> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> A trailer key must consist of ASCII alphanumeric characters and
>> hyphens *only*. Let=E2=80=99s document it explicitly instead of relyi=
ng on
>> readers being conservative and painting their trailers by numbers
>> (by the documentation examples).
>
> "paint"?  I am not sure what the latter half of the above paragraph
> wants to say, even though I do agree that being explicit about the
> allowed characters is a good idea.

=E2=80=9CPaint by numbers=E2=80=9D, =E2=80=9Cpaint inside the lines.=E2=80=
=9D Using the docs as a guide
to create very similar-looking keys. Contrast with the original issue
here:

    Basically, as soon as any trailer key contains a period (which in my
    case, it does because the trailer keys refer to versions of of
    software, i.e. "this commit was backported from the following Linux
    kernel commit which appeared in version 6.1"), [...]

A symptom of taking the examples from the doc and adding just a little
extra to it.

This cutesy phrasing can be dropped. We=E2=80=99ll see.

>> The previous commit for =E2=80=9Ckey=E2=80=93value pairs=E2=80=9D all=
ows us to segue right into
>> describing these lines as consisting of a key and a value, which is o=
ur
>> opening to describing the key format.
>
> And it is a good place to remedy the issue I raised for the previous
> step as well ;-)
>
>> Just like *trailer* we emphasize these two first standalone word
>> mentions.
>
> Again, I have no idea what "these two first standalone word" wants
> to refer to.  It is not even clear to me if it refers to a single
> thing, or two things---the verb "mentions" hints that the subject of
> the sentence must be plural, but I cannot tell what two things you
> are referring to.

Key & value.

Something like:

    Just like *trailer* we emphasize these two first standalone word
    mentions (key and value).

They are the only emphasized words in the diff. Although I *have* relied
too much on the diff context before.

>
>> diff --git a/Documentation/git-interpret-trailers.adoc b/Documentatio=
n/git-interpret-trailers.adoc
>> index e7c1f821619..92d9c95f9d2 100644
>> --- a/Documentation/git-interpret-trailers.adoc
>> +++ b/Documentation/git-interpret-trailers.adoc
>> @@ -27,7 +27,10 @@ Signed-off-by: Alice <alice@example.com>
>>  Signed-off-by: Bob <bob@example.com>
>>  ------------------------------------------------
>>
>> -the last two lines starting with `Signed-off-by` are trailers.
>> +the last two lines starting with `Signed-off-by` are trailers. These=
 two
>> +trailers have the _key_ `Signed-off-by` and a _value_ (Alice and Bob=
).
>
> Remedy the loss of "e-mail like" by ending the above sentence more lik=
e:
>
>     ... and Bob), with a colon appended at the end of the key.

Okay. I=E2=80=99ll try with:

    ... and Bob), with a colon separating the key and the value.

>
>> +The key must consist of only ASCII alphanumeric characters and hyphe=
ns
>> +(`-`). The hyphens serve as interword separators.
>
> The first sentence is a very much welcome addition.  I however doubt
> that the last sentence is necessary or beneficial, as "SignedOffBy"
> is a perfectly fine key to be used for a trailer if a project
> prefers (not this project, though).  I would not object to
>
>     The hyphens can be used as inter-word separators.
>
> or
>
>     The hyphens can be used as inter-word separators, if you want.
>
> but any expression that can be misinterpreted that the document
> strongly suggests projects and communities to adopt the "hyphen as
> inter-word separator" convention is not very welcome.

I=E2=80=99ll take the first one here.

Thank you!
