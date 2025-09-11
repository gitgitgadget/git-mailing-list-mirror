Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8762E1EE1
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 08:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757578525; cv=none; b=m45zLu9KxpZcg3aDUSI476GPLjahSbRwd4cMbYfDlT2UT8lwuphEIaHxeTPsuJtz9ttMnNZ969JJi9QWxm9kwa+qxKAqskNzJ9ZvHS+LZIKL8LkQ60j1minNvJdN98IFH5xJfrk2IhtysOabdRkffJBV73VOhRIeji9N6+ll3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757578525; c=relaxed/simple;
	bh=KqWQzjnvmo7nenXpDTF3fyDIQqNYEwvgj64tivDxUj4=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lp2H2PgOl6fB+gPNHQiH7HxcCCb0wjEcrT903Z0N47aFLc5F1pQmLTmsK5m6/DZyekcP4evYeuJqthxcbHHAx7HjWq75NP4joWNVrcWH+/xk+RwTEzD7Y32gwPHtOmV4eOS8BOUhZkXBmXM2bD0ICML4gIne3ItUI9mO1dsQfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Ht+Pn9P3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KHRF9vBW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Ht+Pn9P3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KHRF9vBW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id AB6AE1D0021B;
	Thu, 11 Sep 2025 04:15:21 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 11 Sep 2025 04:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757578521;
	 x=1757664921; bh=iey5lXSv19Jo99CgDzZa2pv3iCIN/XljZoaQAzqQqvg=; b=
	Ht+Pn9P3foOhcnRROy60LMywZtxDr8nzuumG8AXKG8d/naNFyjuxxn+qnvIsACfO
	zP6H3vtPkGrNJc5NdDDbCU6ZBAhUQQzwPgyyPMNQw6jXdg8RnLejNR0h/oJxzFvO
	zjdxxEIIYokKNUMdLrgbGBpEgcoilVLkw1QXz/jJFthu/jASU3zrHMDlcr1NK6bd
	8jMLD2ch4u/BBYPfC6Rrt6pi6aA/2ge25jNlMfcvyF5sAOqNP3T/jgh9c6Z1Dex/
	20hcEDnVKuvYiRRFW02yNaWDUS6NGFgK56n/UCSxlEWDVpXTP6fuVzjn+BURCXcY
	Kgr82cUrcnuDBVc857cHiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757578521; x=1757664921; bh=i
	ey5lXSv19Jo99CgDzZa2pv3iCIN/XljZoaQAzqQqvg=; b=KHRF9vBWrp34eDXZN
	pug1wmmErOwSpd7eoAXhTjwkGrsMiCVl+z9D8o4liwyuIHChjqlOG6F+5/5qKA+U
	rMS/j4ZUblrX5rBzBMaljN2dlIsXNyJ7IEjxLtN1UeyQq2ZcBF6zJAIt4AgWIaDj
	eROdkMLjJDAGq1wdU1k3EGEZw82AD5BHatzPp965zU0PMG/l215ItzOMfmuX3duI
	7fqptE8yzlVsjthF1WvyQJXW5q8Gd5/e0wLE6wLVyqhflDQb3MVW1s/cssLs2O4/
	pvpEUfvXN0MNCk/5i6EQgWyl893bCgMxj4q6zvEhjOiCRNpVKs4l/0yTRgvCv0za
	rhHqw==
X-ME-Sender: <xms:GYXCaMjU9hra8seFGeZwcw1A7665atTjvUF_VGwG2-nxVnVntwDA9TA>
    <xme:GYXCaFBlmh6vujZXJ90dU4S3eowlQyulRmx25AzYoJ680scL2CKqAHFMubNRzQiVS
    3y8h-w6izdoHg9Bnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepofggfffhvffkjghfufgtgfesthhqredtre
    dtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpedtgfffteetudelhfefkeehtefggeefjeevieekfeefieekkefhveei
    ledtkefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdp
    nhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephigrnh
    gtkhgviigtshesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GYXCaAn8YtzSEEmGTg_tb4pEex5KBmnEqh8x8ZX5S6b8f69P8fr4JA>
    <xmx:GYXCaIzjp9RqPszDIwaP1AtUiiG6QnZtwrfaLt7vVr4uHGnOL2a3tQ>
    <xmx:GYXCaAmWkyyWr24MwF4Hfu9WbEUhrgWM11YHqhzD4fZG8d8uCEpyZQ>
    <xmx:GYXCaJeqg42raSrHnZB2TLvhF4rHT_5gXq2nvd4GD4-07jlfGATpcA>
    <xmx:GYXCaAuVC6hcxqU252_pMxfGKzODogJz-PP7IeoEKayae-BXeUfX7O00>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4FE841EA0068; Thu, 11 Sep 2025 04:15:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1nvvMdi6G8F
Date: Thu, 11 Sep 2025 10:15:00 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: ynckz <yanckezcs@gmail.com>, git@vger.kernel.org
Message-Id: <fccd1ea3-c57d-4c41-a31b-f0563848416a@app.fastmail.com>
In-Reply-To: 
 <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
References: 
 <CAGyVUB5QLV+HQMWT+0kDu1_H0uXHK7kTy35WqhXQaETZ5if5EQ@mail.gmail.com>
Subject: Re: Git private branch Feature Suggestion
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025, at 01:28, ynckz wrote:
> Hi Git developers,
>
> I have a request for you. Could you please add private branches? This
> is a really useful thing.
> Imagine that you want to publish your project as open source, but you
> need to hide the .env file in a separate repository. It's easier to do
> everything in one repository, but in a different branch. Maybe there
> is another way, and I'm just dumb as fuck, but here's another example:
> Say you don't want to release a new feature yet. To do so, create a
> private branch, make the feature there, then merge it into the main
> branch.
>
> Maybe I'm a dumb ass, and don't need to ask this of you, but GitLab,
> etc., anyway, I'd appreciate it if you could add this feature.

I use a sibling repository `.git-mine` with files that don=E2=80=99t
overlap with those from `.git`.  This way I can have two =E2=80=9Cworkin=
g trees=E2=80=9D
checked out.

--=20
Kristoffer Haugsbakk
