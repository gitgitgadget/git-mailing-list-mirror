Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274242BE04B
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760474669; cv=none; b=uOPrt/Z2fTJmsZdaWUg7oXm5Cvs7Bm48t65MzYBezHnq6Vm07di+nIb4CLmKibdxtTgNKPBasvhfsKoVEfY/PNjn1JxgZrthJR4kWIWdbCNMU+qFoILnS4vmY5lKM/oiaLC7xrfuXCXu3WSPXj+6B6VbvxKh2eXBlVTUXl1Enhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760474669; c=relaxed/simple;
	bh=btxhCt3xT7sGfCBnNO6hLAxxO2yg/TQjawccMoaoWAg=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BwtQocXaxxZAh6p9R6c5WL0w4y7Y2MCBMzsWGUvxjfGgf0JGrg8HTAVJCnfWCU2W4HcvcSqA3ldTwUWLIFjxKhWIfY5XVE+jN5/dRSDxjF6PdJTuuVKC5VfcqcDLgBxTiKdMp/NfKT5LwFrk45hF3bI6+XE2dIz0OY658HEz5zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=DHEJFgDZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mx8TzWtT; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="DHEJFgDZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mx8TzWtT"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 316D9EC09CE;
	Tue, 14 Oct 2025 16:44:27 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 14 Oct 2025 16:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1760474667;
	 x=1760561067; bh=EzD6liYTD3MUw4RFTUn753IVVz84QaCYJ+ZerfBe36A=; b=
	DHEJFgDZH1oW7WxQPLTbvui7jdQhXP7KoPOr4AqzxWPgcsPETa8nBSEuB5tPq9RZ
	oGX903O1V5ERwcpjf7RMIbqkCn3DSOdpHYoMT0ZR4J5DvFMYvs5OaZPzfau2suT6
	By0yUs3pv/wOQg5alVFxzbPUhM/cILYHyT6VsnhY6LXBhcVyf7KM/tGu6Yz9D4FF
	GS6PpgJgWwHkqiWjOXsmQq7R0lifPo3s6cpVnyQewVxoJX2/XojAp4TopUW//bx/
	E5IkKGf+NHW95o2ub/r1jUQeaOhE5fj1C6cDjueDXRJRczaiQX7AXjEjKV4icg6b
	061C5bWMwmDFdlPfHaeB3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1760474667; x=1760561067; bh=E
	zD6liYTD3MUw4RFTUn753IVVz84QaCYJ+ZerfBe36A=; b=Mx8TzWtTdH67kl1Hh
	b1ZpBqABRecrwh1wOhfXuu4FWJyYsO1aHm9jh0kRkTebz27CYaisj+VsJbIHqTaN
	XX8I3x7S1b2Im+w0SctwoR+L7s9z9TMUD0fqGat4QhfP7xzxd1otlyJ3gyF+mAMR
	Psd6K0lefSd1WJ46CNwvPguK2nBzw8+/yXAa1oay1vQN57iYmyvX/mKDmSNxwTo7
	BwQhwpRTJpPeQAlyrSGhL5Lzsp80uRoa+IcaJgG5aRDIFC54T7EAyEKMxCb3TwMr
	TwzTA0My0n4hddps7OBme9g0/C6YT3tkAxATaptDXvufvWilhbt6pHX1HY1hfvK+
	BA/1g==
X-ME-Sender: <xms:KrbuaNylBwUeTShnAmjV3VGZOIiHnTbWhlHJ7DpeiFPGpEqkLqSlqPY>
    <xme:KrbuaIEapI2glj0nw56enjKM3uDAfn2hL8ogT0v-iyAWlc1_Ff0J9h0P_Bc3H1PkG
    6Xjgn9TGgeJH2UQ657KbF4lz1mYeQu9gGWO5dYIbKNjSKf1z9xwpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdduhedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvffkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgfffteetudel
    hfefkeehtefggeefjeevieekfeefieekkefhveeiledtkefgueenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepmhgvsehlihhnuhigrdgsvggruhhthidprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KrbuaBbEproTnU2fw36fLuf9GzbXlhH9npqxoYJBtKOjL9cWcoaH6Q>
    <xmx:KrbuaD2PC3QrQxOS0zd1gJ5lPib0N4mFzuUWc9cpOKuUt2HtVBymlw>
    <xmx:KrbuaHfew0VisiKnfW7Na5v3S6SIPjSnEGAxNkcEbSpSoYnl_rSZ8Q>
    <xmx:KrbuaEGJJRGXXRKURIIdn4DT1DzRk-o31cR3d_UrrHuU1WNpCMj1xw>
    <xmx:K7buaEhKA4zHmmdV9_LbGcS2UsDd0yYCMsSg7UmRE1yOONno1hx6WDGQ>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D5B001EA0062; Tue, 14 Oct 2025 16:44:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMyiYKusIPWs
Date: Tue, 14 Oct 2025 22:41:33 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Li Chen" <me@linux.beauty>, "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>
Message-Id: <4eb06e60-e088-462b-9f1b-ca800af39b94@app.fastmail.com>
In-Reply-To: <20251014122452.1851103-18-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
 <20251014122452.1851103-18-me@linux.beauty>
Subject: Re: [PATCH v4 17/29] tests: t3440: create expect files at point of use
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Now you start to change the test suite/file that you created for this
series.  There shouldn=E2=80=99t be a need to do a test file-only patch/=
commit
for a fresh series.

I saw in one of your patches that you removed `--keep-empty` from a test
because =E2=80=9Cthat is the default=E2=80=9D.  I also saw Phillip=E2=80=
=99s comment somewhere
that said the same thing.

The goal with maturing series is not to add patches on top in each round
(if that=E2=80=99s what you are doing).  It is to recreate them as if th=
e series
was perfectly written to begin with; if one patch introduces
`--trailers` and a test file, then there should be no need with
follow-up patches that improve the test file style, refactors it, and
so on.

> [PATCH v4 17/29] tests: t3440: create expect files at point of use

`t3440` is enough.

On Tue, Oct 14, 2025, at 14:24, Li Chen wrote:
> Created the expected trailer files within
> the individual rebase tests that use them,
> simplifying the shared history setup and
> avoiding unused fixtures.

The max line length (for prose) is 72 and I don=E2=80=99t know of a mini=
mum
(41 here).

>
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
> ---
>  t/t3440-rebase-trailer.sh | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>[snip]
