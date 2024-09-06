Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F67A5C613
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725663377; cv=none; b=QQzSkbyWLwwcRT25AGsJw7Jti7zsSqfKSfsjlL8aHLqakblcM+ScqVOhOYpCU9sJBr1mvHl8Wvft35e0yN3FA/woUHH+HcN7gZqhV/8B0r9Ue/nQ5Jf7HK0i0jfnDcuF/Kth9sIBqzui+x7qGGBuBsXCKn5jnnKZ2UNAISDI/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725663377; c=relaxed/simple;
	bh=4JLSUFThIzJ82ICebacf+XjyhuQr8XWdcXgsX9QxBEw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OfIg94M8RyaIaA7SqhwSqIKxPd/zoVnacrKXUd+fbUO+I6AIjmWhMLXXFkR401wk9K1r9zZ5OyotXbQZcJgraYy8hPnh93mrosH443TRYRU4I2/BFq08e/UD3u0HmYsvXe5DH8yRnqS8kLxS0oLsBZrYGKG/JzinnJGavxX0d7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=zrbo16q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rX4wszdg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="zrbo16q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rX4wszdg"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5210D13800EA;
	Fri,  6 Sep 2024 18:56:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 06 Sep 2024 18:56:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1725663373; x=1725749773; bh=4JLSUFThIzJ82ICebacf+XjyhuQr8XWd
	cXgsX9QxBEw=; b=zrbo16q2aR6UnJ87jMX4Agj2mZKcma2XkQsdr51AjQWDnQXU
	OmG3ccBdUsZGyJHHXB+Yh0k5Q6fCfJ1jp/nBgDVlmc/Zr+6Rd9bL64T+aJsRFoqI
	dJyRZAew9mchxg/h+REbjwf2ZLiCv7LSTyE/Qfub7aRc+LQStFB6LXogfckZo9me
	GPKSmbJGyYQHEmZJF78ATdqZ0T5BFEjQ4BjTVzR33yfLZK3mUy9Meo1g4U6mYcR3
	JXLZjoYWTxLQaqkx9JRJqTpIeg253wHUX59+Qyp0AiJStKReYJSqnpjRHwhkf6eW
	3qdvV6jGDoEXBXB+ZDAxP62a/J1kx0V2YsGVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725663373; x=
	1725749773; bh=4JLSUFThIzJ82ICebacf+XjyhuQr8XWdcXgsX9QxBEw=; b=r
	X4wszdgH1lCd313jGQnd/RaGSIuKzDNEa/Z7hmBrhi0l+uyS+xrpQU9H/cP3rZGp
	mRhsYYxP3Zl41sEKHFM8cLOR8kgnkL4r18glXAxKXVgJQNzwQQUJ8/a/K0VHI5zW
	owJLTOWdlsYS51mVsojbmcvwugSwBeZMiJDWEEW5rHaJn9yNS/HRHsYPlq4E1YLr
	OBAxMR65YwloO9c2nfPraie0ewr6DtrUuPhuuOzqdQPnMSH6/CmuGl5lib9NnCuQ
	Vhv3h/Pj7ZZgfvamU0QTXSZI3M1y2fAsCUG4bxQek4w419d2t5hHUEaWVViub0X4
	VUAv0HyVOcnHEzE+qKpKg==
X-ME-Sender: <xms:jYjbZqwlmUWjty_AQANtFi9sPGJoAvuYfXlfvxOnAdVhdcGoSU6CiQ>
    <xme:jYjbZmSuk2RfC4w2DQZHWiCNsB7kc8vudwFYQvJLBWkfWwFWd8y-Deo94BnGtcjOr
    vMt1yKlO2Kvj-Wz>
X-ME-Received: <xmr:jYjbZsVwH_WSKdKvNFkM6oiEbUYyRFr1H_JFPHXZNj26ireXihvoxHLtHTBqjEBYhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeivddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpegtggfuhf
    gjffevgffkfhfvofesthhqmhdthhdtjeenucfhrhhomhepuehrohhokhgvucfmuhhhlhhm
    rghnnhcuoegsrhhoohhkvgesrghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvg
    hrnhepleevieffgeevgfeileduveeuudekhffgteegvdefhfehhfevffdvffdugfehtedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghroh
    hokhgvsegrlhgthhgvmhhishhtshdrihhopdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jYjbZghuM65hSXRbu9vul7jBHOKnx_p_bhUIvlbjmmDtXmsLGJ2yKg>
    <xmx:jYjbZsDNZPxfz1_xO4qzBEblguI8Hja01UsHpbX3faLnuk9RC1UuyA>
    <xmx:jYjbZhK3rLW63ccHDF6dvhbrk7JJUNU9RtWSurk580nBgf1nI9mg0g>
    <xmx:jYjbZjCwOVr328pBJ3WQGieMXjRtsyS7wrV1MmNzbVkNtJhjuG0Flg>
    <xmx:jYjbZvPSU95-2Or6pVVxeIGYIVh5-UYNO_zB947KxaxJn3KsyxoYjury>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Sep 2024 18:56:12 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: Should Git Tag trailer formatting work?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <20240906215054.GA1149961@coredump.intra.peff.net>
Date: Fri, 6 Sep 2024 16:56:00 -0600
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3A01E3C6-0AB5-4C0D-AA76-E5EE6A5AFA55@alchemists.io>
References: <E46F3EFF-66D1-4B29-BCF3-6FFAB2504411@alchemists.io>
 <20240906040434.GB4168449@coredump.intra.peff.net>
 <249C7637-0032-4D53-A8A0-83935764334E@alchemists.io>
 <20240906215054.GA1149961@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3776.700.51)

Thanks! Yeah, that'd be great. Will look forward to checking out the =
changes.

> On Sep 6, 2024, at 3:50=E2=80=AFPM, Jeff King <peff@peff.net> wrote:
>=20
> On Fri, Sep 06, 2024 at 09:22:33AM -0600, Brooke Kuhlmann wrote:
>=20
>> Yeah, I can render trailer information when using your examples but
>> *only* if I disable signing my tags. Here's what my global Git
>> configuration looks like:
>=20
> Ah, OK, that makes sense. We have to parse the trailers from the end,
> and the parser is not prepared to handle tags' inline signatures (in
> commits, the signatures are embedded in headers, so the trailer parser
> doesn't have to worry about them).
>=20
> I have a rough patch, but it requires making an extra copy of the tag
> buffer, since the trailer API needs a NUL-terminated string. I'll see =
if
> I can clean that up to let us parse it in place, and should send
> something out in a day or so.
>=20
> -Peff

