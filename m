Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7B4E36F8
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400822; cv=none; b=CnDCG0Au7A5vzOd9kDCkTcqhKGhnGA9ytxSLNRdMQlMwowePhWtNsK0roFCXJSNtkSM+Okwm5/dBinpOPKAVkF7VEQysfS+2+5ogYPytxaDpQvUZ8U/KN36l0AwARh52lx2aaKS8pBnxAmA1YNd50uWUe1yTKyFd+1qZ79b7o70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400822; c=relaxed/simple;
	bh=laZExpenkr6pf9XCly7/weCkeiSIV8WKzDxx/dKwu/U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CYbDJvqrjB+29xe69L4magoBv5i2nj73xb1KkExNQyjdaOfNjb/bQXWELQoloU8imRYwP1uPum7DrLrho3mQq4uVcXdQ0PpjpFqltuFolpRuQTpz2q7NC1T3q5XsHTZkJWFLzvSVvCwuU9636T1CLmG8RaihHAT5hbtecDG8iWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dicarlo.email; spf=pass smtp.mailfrom=dicarlo.email; dkim=pass (2048-bit key) header.d=dicarlo.email header.i=@dicarlo.email header.b=Bu97nZjk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RkhewT0V; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dicarlo.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dicarlo.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dicarlo.email header.i=@dicarlo.email header.b="Bu97nZjk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RkhewT0V"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 147D014000C2
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 15:20:18 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-01.internal (MEProxy); Wed, 07 Oct 2026 15:20:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dicarlo.email;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1791400817; x=1791487217; bh=laZExpenkr6pf9XCly7/weCkeiSIV8WK
	zDxx/dKwu/U=; b=Bu97nZjk4ybTnBlQuurR19qCGE/McEVPVKtyhZLcCpHdWGks
	iECVIhvWHrNrrFsDuejhh5lMAH6B32e1KDzHmtdRH1AKi53VVb6/jbTe5vzHckfA
	X3eGcy5CF/ma1OgNRkOmCwwN6/FWbhEXjuGXPS2BYPyzRrisGp0isYYPkS0BAKKQ
	gZDQDQSq8iTg99ImYlePT8X3pFSyxmKhnz8Se736Meer01twwDFSc60ZXFlhRSBs
	tLpKi445yy7bh/ztijkGOWUVfjLJOdDHWjCd8N57tRSNNt6brDAJV4cGj4RU1Hyn
	qdImqbdleVeNpVfnfOG4EL1CGDiF9GJW830hVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791400817; x=
	1791487217; bh=laZExpenkr6pf9XCly7/weCkeiSIV8WKzDxx/dKwu/U=; b=R
	khewT0VF3339AEUlvGArLg0dCvsvVY5fKSMu7or3SADv2eduhYFM1PTDoAwadxuC
	9bLxVCSE4xH+hDaTToqsguoCMTlHVMwo+BlyhIpw/Rb/i1nKyK7AgjIntThgKi/f
	76PDgNbywDIfPkJ8yFrt/YQ0wT8y2+cIjp9Oeng+kdDy+s1wEtS1knZZj8cBcIhH
	y9YKoxMcl/5O1Pb3+ILdsiwhmFvFMN00PND+XCs1bSkk81e10GjkVMmAr1GUqCZe
	lRGyxslR21VK0sr6/0TRXoFnqkxVrZwc5tKlgvyxgZqQRxO/bFxVZmXkPLYXf8UE
	EjccQdu5/GrlJOqMiKalQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=dicarlo.email a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791400817; d=dicarlo.email;
	mf=PGx1Y2FAZGljYXJsby5lbWFpbD4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:kcxf8gz6R2Z/tvTt8IwJqN91E6dkP/jJKgGVuvGs2G12aLu
	21dYrDKELdsyYK/rGj3zWfhetYRRFSnGdOmGeEyMPobPLmfDl5k81aZEtqjdKA+Q
	cc1BTXXFaIderagmwqNppJHWnM3uX9XgQ3dqIrXDB9w/5INwtpXytDWpRFaYBRAY
	jYbwqWFsaBKoOgTHtTtecdCpThQij1BPJSrb20e9V2b6MrMlZPONNJ744ctjk5r+
	DZjHjH+rMfrYQhMKbdABwMRrN2z/vu7rksUs8cItFL0xeeYsFkJ5Pmary6epSiiq
	atMCf6TAAk3vLsWizqc3dxyHqSVNjPdZdQgNYqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:x/iJHPb/ek31ucvcy9MfUdXV5/sFxaH8KWPe+LpCymY=:laZExpenkr6pf9XCly7/weCkeiSIV8WKzDxx/dKwu/U=;
X-ME-Sender: <xms:b5vGar-EICUIDjv_Oy7BOdqWfKjPasdn774p-cob7rpSZslvRtq1RQ>
    <xme:b5vGaijzvuP4rSzW7KjwLbqZZNND9OT8Vfgg97e2s6FnmNDUUBLbWexpRNfkTjK5v
    mAmOrFusDlwenxCkGnURl2l32H4t7p1BHxehPeKuwjK1GomwFoHv0WQ>
X-ME-Proxy-Cause: dmFkZTEM/CzZRB6jKMo+5g6aP8aPQn+5OS8bujmwxTsB8ZRChJMRE5zAIDJqRw5B6tTF96
    uIujw+mvqu24JNpIEhUHd3LrU1qdD8ggkl+NgJnZqQiWJ02RQRJo3OH2DxjK4wCPMReCTo
    9pa9xxfYZbHLCi+olFho4fDvMzOY61ORkEKH8F+pcxO370Kx7jQ0olBaC5lPphQhGELedb
    ApKYaKD8BxAmkWPPdX8OSB/FSQOGEsVO1jARslC6bfCXG0ESO3rdv0wscP+7c4Gc1PT2RH
    ZvxPbsYAVcayTf10jLYsaJVRoAZxZtXoAlP40INSMd+0DysCCUbR3kph2R+f47mbnicgJG
    3M/N9HBIMxpvUn/DOQ6f/2lFYmiKdW5TQAsa/vyaBUsGYI5hJmvAKhzdaiM11nE+OjpCgp
    OfE+1JJpINZXRxTCxHZIbCZLG1BN8j1CWhYxiYNjST8O3qq2O3ZQN7htyrEKKsXwiWJQu9
    45S3TPDs2Wx3lnyMPi5zDfk/8Ha6a9yQF3AP6Dj1vaWhtz+Sf0KB6jOHEFtkBPg8gtVnfw
    fZkVfLj+Cu+/rzU335czhh2mJi1Vrdr8Q6L1yeNJfdleKFqC+jEjwBGMwEYtjQd0bM7QIF
    RMYs9xDoMtij619f/lxDW/Jv/4r2lu5RqQ0lRwzvBTtdgPf0Cl9VWEXZZH2Q
X-ME-Proxy: <xmx:cJvGaqqZIXC-6jJ6jTgEikYlf9Z8WcIvqZ5LzlNWrVWDvrXT0BxTMA>
    <xmx:cJvGamly7yoZmPfGqikZZ68Bm97FPhvWJAQyHomug94r8xsxwBsFZQ>
    <xmx:cJvGamyKUNm3JSYgM0Cx9NApdwOEJbUl75dO76SLU1RIP2vDVuPwOQ>
    <xmx:cJvGamnjz8TCIxSm0e9NHg2rrsiXcJ7pr7yOcvHEkJbepa36ZPhkog>
    <xmx:cZvGanQ1bT83hftf37aB54uawTAeBzlcdbeAubZjgBKyhNVnc-bcDSyj>
Feedback-ID: i3269492f:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 51CEEF8008C; Wed,  7 Oct 2026 15:20:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 07 Oct 2026 21:19:02 +0200
From: "Luca Di Carlo" <luca@dicarlo.email>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org
Message-Id: <d6dc70f6-f155-4a5a-b647-ac24b2b1ed37@app.fastmail.com>
In-Reply-To: 
 <CALnO6CCTbWLn2rO9ASr+5K07vqkaWCx+H8NsCxaAMgHUYR=z5g@mail.gmail.com>
References: <e30c5b13-5ca3-43d1-a87a-d807b71bad7b@app.fastmail.com>
 <CALnO6CCTbWLn2rO9ASr+5K07vqkaWCx+H8NsCxaAMgHUYR=z5g@mail.gmail.com>
Subject: Re: git non-intrusive clone
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey,
You are right, I've re-read the article that I had in mind, he downloads=
 it as zip before, not as clone.
`.git` is not cloned.=20
Sorry for that.=20
Thanks

On Wed, Oct 7, 2026, at 20:54, D. Ben Knoble wrote:
> I may have misunderstood, but=E2=80=A6
>=20
> On Wed, Oct 7, 2026 at 4:40=E2=80=AFAM Luca Di Carlo wrote:
> >
> > Hey everyone,
> > I am reading more and more blog posts about job interviews that requ=
ire the people to git clone a malicious repo with commands executed usin=
g git hooks.
>=20
> I don't think a _clone_ can ship and enable hooks on its own. (I know
> of at least one npm package that wants to install Git hooks when you
> run "npm i"/"npm ci", though=E2=80=A6 turn on "ignore-scripts" for tha=
t.) That
> is, you should be very careful executing anything from a cloned
> repository you don't trust, but I don't think a clone can ship
> executable hooks in a meaningful way.
>=20
> What *can* get you is an archive that includes ".git/", since it can
> contain hooks that Git will execute (modulo safe.directory, I think,
> but that typically doesn't apply in these situations). So: also be
> careful extracting arbitrary archives!
>=20
> Maybe you had other security flaw in mind, or maybe someone else can
> tell me how we fix this beyond "tell folks to be careful" (which I
> agree doesn't scale well).
>=20
> --=20
> D. Ben Knoble
>=20

Luca
