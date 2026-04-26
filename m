Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AC175A8A
	for <git@vger.kernel.org>; Sun, 26 Apr 2026 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777187406; cv=none; b=hgzmkG4VZdwSFTQ03w9USgBy02KQyXcwTeLGLRTBbaBFGjO57jgyJqeQJGh8ekbivWfzkpo5z6E+IniFgzXm6iaYKXFLkst7C2T9CmwKnS25L6G5R6ZBwdqb5NZ2CV17PB2/oFVsBXfspbucoPHSIqMIlRin+57r9Hik6vanqy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777187406; c=relaxed/simple;
	bh=7xP3TsnWP8rYW435ouAYZeJSXAcyNQ5/SuZ1liI3rd8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lzwXhuoiIPUvN6GgFsq25qaqQ5Iy3Cjw6ts+HO1seXXn7gbITAmZJtcV76iRsUoktRm+eDpikIGMJedyueje0zzkgpJ5vUDn9Z8KqMweTlQrF9UADfUap1Zdx2NYPqiwZzIQxlF3QkY60BmDkUvh9/++CQ965KeEa/2yWrrCO/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=VJdAQNri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RZmYqhe+; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="VJdAQNri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RZmYqhe+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 34C5B7A00FC;
	Sun, 26 Apr 2026 03:10:04 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 03:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777187404;
	 x=1777273804; bh=cPS+SS2u/m0bRb7TNhZCAOtpoi5XJc3mqL3TPXiKBGs=; b=
	VJdAQNriln5f3PvUT/gcLSLX8tbAVcavmDj73GBC2pn0DfLMao0JxLHDh5fGkGRQ
	WUUrdauKP0GrBmN1YNWzKztSUqsbFXRykQKO5m9Bz/MA82vkD7hys5EWh4WYxe9S
	DfMOGnl+163JGn5/WrgmhduMpxXkKcp9TyeZw15kV5K5YxZqyOUjfQDUs2dWl2uZ
	X2aJvmKL/uo7j02EABXOoIu/PG68lmuX5Qtjsa2+E2KBIFVs9EuVC/CHOhHJh+Sa
	i4Hpc2Voos12RZ0P/S01QICTCE0/FGpPEsKW+Avb6+XRimsuITY2M9Zc8FAYXVH1
	qZCLDx+J05QEEnskndcFmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777187404; x=
	1777273804; bh=cPS+SS2u/m0bRb7TNhZCAOtpoi5XJc3mqL3TPXiKBGs=; b=R
	ZmYqhe+C6J42VSN9GFjh2sinEh/8aBsZrYoLBPeZzjiHQvS/UgSYXMi1c6+MJJqq
	nhnWYOz2sB00U/d77ukRgI1gA0oT74Dk2KAMaFwU+/g50ScartbVHIT8IosCViUK
	r7WYm0meULh6ZpPAjdSdtxgqvi6UX/JXEkUTVkQpSyNrESZMeBt12tCt94d/TScL
	VO1u0J/FlNKyoURw5X/JCdlRfEAAWSJj8QFVCyYVursVKHc5i4p3QIB4lYYIQ7yW
	xFeHbMcmpVbWaG4lg8RK4AquSBS09W2DBjOnixC9JA6juaejCn98KKITK7oqxr5P
	ijoVWwop728tqkOnpen3w==
X-ME-Sender: <xms:S7rtaZrmPeAT5nE6zmJqI6C2qeGcR_iJELVRFgVkVVTof_X_ZK7gWcg>
    <xme:S7rtaWdfEBXETrEDsTfbCZEOyaIOw4jn14y6EhY_i-w9U-lp2-kMbIyAbG6ddNw7S
    Wj_7e15SR7w2KGp_5z8SCZOC7N4rjYF6yOY5AblusuRP8ykAqUFTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejheduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeej
    hfehuedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S7rtaTH_UZMJPb12pH8h3jKRhMqbdtTFEuk3yttoWWnSVJa7JjnlXA>
    <xmx:S7rtaXMpvY7dI_puH4IbCuJ4PaW7pJ-xhZ6-me33AnSi7X0pe1xC1A>
    <xmx:S7rtaSF5XbQybrY6cGz8wRqnoBw2-OEHHPOlifldW0GATh9Bn144KA>
    <xmx:S7rtaeNC33zSXoi40CO6ueTXqxKMoWNzrMd29-9h_GEYyhEATzfYAQ>
    <xmx:TLrtaRAf2Pd0jdqxCZlEZli-xMpZtcm-VGR7tslDnXpoMKE3fk6zEgrK>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CA5CA1EA006B; Sun, 26 Apr 2026 03:10:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Af3IvHt69cCJ
Date: Sun, 26 Apr 2026 09:07:52 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Harald Nordgren" <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com
Message-Id: <c61933c9-e489-4f4f-b4f4-74267d5eb76f@app.fastmail.com>
In-Reply-To: <20260425174448.45681-1-haraldnordgren@gmail.com>
References: <20260425174157.44868-1-haraldnordgren@gmail.com>
 <20260425174448.45681-1-haraldnordgren@gmail.com>
Subject: Re: Wrong subject line
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2026, at 19:44, Harald Nordgren wrote:
> I know you are not Ben. Forgot to change the subject line from a
> previous message.

You mean I=E2=80=99m not Phillip. ;)

    Subject: Comments on Phillip's review

I don=E2=80=99t understand why you change the email subjects so often. R=
ight now
I had three =E2=80=9CWrong subject line=E2=80=9D in my inbox with lost t=
hreading
(webmail client) with the only way to distinguish them being that I was
the the CC on this one.

Most of the time whole 100-email threads like patch series never change
the subject. And to me it is easier to keep track of those =E2=80=9CRE: =
[PATCH
v5] florb: drop glorb=E2=80=9D than if someone changes the subject to e.=
g.
=E2=80=9CRegarding memory leaks=E2=80=9D because someone found a memory =
leak in a
review. Because that was a reply to an email from two days ago, but I=E2=
=80=99ve
been a away for a week so I think it=E2=80=99s a new thread about
something else.

That=E2=80=99s just my experience. My amateur webmail setup doesn=E2=80=99=
t really
matter here since I just dip in/interrupt threads when I feel like it.
