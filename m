Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6914A91
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817175; cv=none; b=Ok3OAtVxPjEA0km1vETOioire9bKt5IpqdkXD89aIoMUixVesccryW2UxHgQe/5YubcnJdUrILjPQ3Rh2DKiTtbn1ytk1hIjl/ug1rSRehOBIA/5xCL/gBDjnCSbgoL8REVA9nSM8Z34JAijaNIKNSs82cV0kooI0hrGMZraeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817175; c=relaxed/simple;
	bh=9uc0i9Eu4u+ZhpgkCO084+NkEenVxQwpd9JfLKuSZnU=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RqGPFIHvQ2/05GtMXpXpibIyboWsSh7gfupOUfQat/PWYqI1dxOxsqjk9eQiw0GzIGFBrfoBxvPmwdvNh0TvtQ67RW39rEq2vJf0MEVeFh1rgkuNTzeFeBl4EpuqD5RBzHpoqHGDLsvpmZIBUqTqp4KdQapYdl+OjXk4r3HEXX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=fD29zkmU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJWvlLKq; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="fD29zkmU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJWvlLKq"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62F1C2540118;
	Tue,  5 Nov 2024 09:32:51 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Tue, 05 Nov 2024 09:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1730817171;
	 x=1730903571; bh=/c8+M1pBzhdXey4pCeNHR6IRLK+FNKlOcw4jpm4incw=; b=
	fD29zkmU177P4Rue0/25YCqWYXAYEmiAICDy5Pxtj8f0GMxBQ+9mJoEjE4hgGBcG
	9nw4/TeJHoZd8/HlbLPuNwOgqxak8apKkMgBYvz5udOzVqXRq30FcTrM2yRIXKSc
	wcELQSODIhnav2O7tVCDnWrsRB0nlUDrxQ4mOP0s4U6qcFwi/7ENwymiN80pDE89
	mBRn9Ea8msKALtBObP8uAE3Ox/lVHGJFiqkJPZW5U4fv0UhsbT4XDfFqK96GIhvn
	owRW6qqMnSVyRTvPkPyPekDPV2jl2LiEoMuXViiPQHvvpbpjEXKVPqFVcXj4Egng
	BBjqtDouAjc8+dCp80YEag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1730817171; x=1730903571; bh=/
	c8+M1pBzhdXey4pCeNHR6IRLK+FNKlOcw4jpm4incw=; b=WJWvlLKqMU2RsYy3S
	GUk4QAY5Jk7uzyIsMd7dq1eV8Sz4Mjm5tZMgdyDv9AMWAOsV7Ut1UsSN8sroFR5D
	uwrIjcVG5tLr3/EdQItFvVwUODn+zk5LSBaDipUNDmKpL9AVSlOoSli4byCcOpmw
	72i8oniZ3ZdovjHNRumjk36udw1pF0xQFKNqnTZaH++hS21m0XYSSTZXZZPgRc3X
	lZV1Tc3SHvb9W1ZoihsSYkRmVZfsTGLij2iuw8c0YFrHUvlIiKQTa70AVHngWeIm
	r78p4Us835Z9zhDsUYncO3T81KgRnJRBfEGbb4uwFrxSa90dd+HO6/FjDHl2zzoE
	q24Vw==
X-ME-Sender: <xms:kywqZ2xrOeHuRqakAxJyST8A9nNPhDamqQEG8EPZi_Pib4JSwMwlA1s>
    <xme:kywqZyThe3OASmuQ1nlfd_bT600RiTr8lO6p98-Js784TkRYxfarXbbieLslsS3-_
    l1_JDaMkqWkGFIyZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddtgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepofggfffhvf
    fkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeef
    jeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheptggrlhgvshhthihosehstghivghnthhirgdrohhrghdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kywqZ4WMlTTGYL9tR-zn1_oQlbcmVSNw-yQSrVzVqw6tLp15FAhW_Q>
    <xmx:kywqZ8i-a-U5atzIw5UwB6uukCKJUPZmYv_W2S6jPJ7ElFkHTA41XQ>
    <xmx:kywqZ4Cv6whhoRQXStNfou4H3fncSxNnahWHxXlhLJfYgUkT1L6_0w>
    <xmx:kywqZ9JV7dbof-LCcwrtBQnJgkn0n0LvTePPpOFvoBljKpR_PE5qlQ>
    <xmx:kywqZx7boGSrY7jqw2tv53PqFpUkSF-NxrF6i7mXbeAQg4q7v_0sTTR9>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F2BF1780068; Tue,  5 Nov 2024 09:32:50 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 05 Nov 2024 15:32:21 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Christoph Anton Mitterer" <calestyo@scientia.org>, git@vger.kernel.org
Message-Id: <43b401e0-df86-4849-8747-d5ab172becb6@app.fastmail.com>
In-Reply-To: <83639e75d9d04208aa0dee345d9ef3536de105c9.camel@scientia.org>
References: <ca13705ae4817ffba16f97530637411b59c9eb19.camel@scientia.org>
 <305dc9f7-4bdb-40c5-92f4-7438a9ecd482@app.fastmail.com>
 <83639e75d9d04208aa0dee345d9ef3536de105c9.camel@scientia.org>
Subject: Re: git format-patch escaping issues in the patch format
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024, at 02:26, Christoph Anton Mitterer wrote:
> On Mon, 2024-11-04 at 23:15 +0100, Kristoffer Haugsbakk wrote:
>> It seems to me (totally na=C3=AFve) that you would do something like
>>
>> 1. Blank line terminates headers
>> 2. Then there might be some optional commit-headers which can
>> override
>> =C2=A0=C2=A0 things (`From`)
>> 3. Commit message
>> 4. `---`
>> 5. Look for a regex `^diff` line
>> =C2=A0=C2=A0 =E2=80=A2 Now the indentation will tell you when it ends
>> 6. `^Range-diff` and `^Interdiff` can also make an appearance in this
>> =C2=A0=C2=A0 section
>
> Well as you've seen by the follow-up, such a naive approach is not
> really possible, as the commit message may also contain ---, unified
> diffs, etc.

It=E2=80=99s possible in the sense that it would work just as well as
git-format-patch(1).

You could make it more robust with some backtracking, like finding the
last `^diff` and movig back.  That=E2=80=99s OK in a file with only one =
patch
(`.patch`) but harder to do for an mbox file.

> [=E2=80=A6]
>> It seems like it would be nice if format-patch complained if it found
>> regex `^---$` in the commit body.
>
> Actually already when committing... cause there it's taken as valid and
> then it should also work with any following tools.

That would inconvenience all users that never use format-patch.  You
could provide an advice/hint about some configuration variable which
turns off this new default.  But that=E2=80=99s a lot of work to benefit
format-patch users.

Such an error would have to be a default because an opt-in would only be
discovered (in practice) after you=E2=80=99ve been burned once.  And the=
n the
opt-in error is of very little value.  You=E2=80=99re realistically not =
going to
forget and write commit messages with `^---$` after that.

>> The magic string is unlikely but could happen.=C2=A0 The solution is =
to
>> use
>> an indented block.=C2=A0 Same for the diff.=C2=A0 (Hopefully few have=
 to
>> code-quote diffs)
>
> As written in the other mail, there is nothing real obvious for the
> user that this wouldn=E2=80=99t be allowed, and in fact committing and=
 such
> works.
> The simple problem here is the fuzzy format which cannot be parsed
> properly.

It=E2=80=99s not non-obvious either.  The simple format is apparent if y=
ou
review your patches before sending them out into the world.  (I=E2=80=99m
paranoid so I do that)

>> But escaping things in this format?
>
> Coudln't one do something like this:
>
> If the line consisting of three - is the line that ends the commit
> message, check during format-patch whether it's contained in that.
> If not, generate the patch as now.
> If so, use another magic timestamp and/or (since that might get lost
> when sending as mail, set some X-git-patch-format: header, there adding
> perhaps a flag like "escaped" and if that's set, any line that matches
> the regexp:
>>*---
> get's another > prepended when escaping, and one removed when
> unescaping (well in the latter only lines that match >+---).
> * =3D 0..n
> + =3D 1..n
>
> Or probably thinking about some more sophisticated solution or at least
> a better character than > .

That=E2=80=99s interesting and a good idea to use an email header to sig=
nal the
escaping.

Thinking just about `^---$`: an email header could be generated if
`^---$` occurs in the commit message.  Then it could suggest something
non-occurring instead.  Simply `-----` or `***` or something.

But this might not just help with the commit message separator.
Apparently the status quo is that git-am(1) will try to apply the diff
in a commit message.  Even though it hasn=E2=80=99t seen `^---$` yet.  B=
ut if it
was required to see that first then you could do something like:

```
diff ...
<diff content>
```

And not have any issues.

Of course you can=E2=80=99t change the magic mbox string.  But I don=E2=80=
=99t see how
you can=E2=80=99t do some more expensive parsing and require that you se=
e the
end of the commit message before parsing this string as the
marker/delimiter.

Some niggles: the commit message might just be the subject line and
there might be no diff (empty patch).  Then looking for `^---$` will
take you too far.  Maybe just look for the signature line.
