Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE85381C7
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 10:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727521055; cv=none; b=stGbu6xHoGkg18T68XQ7N/Irj0fFf4HfDN9IuzrM1155RNWVQipYat6HR35Nq7Q5Y8AQmYLI3vNBCVmvR/nLwmhd0Vp9xJXJMq95SVPri1diFJZySrOaaPkLlI+b506VosS9G8Wo/d4fUncuJc5fx0UqMtQ+0t3KFU9kHx6KgN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727521055; c=relaxed/simple;
	bh=1aWqzKBhT4uL/R7AYIQ3f1ZspqKJ9/ZNzzUUWS3mofk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=P/HTYkrE8iy0LCT3RF1UZDmxC3gvwQ5yOdrf8FQ0zLv+ooB9u6HoKcu/I6qxnVWkXWgyKwVzysLEzDpqiZ9RB0FTkmBcCnlFtSsp7jQ4ZOXSHxGMumTROYDbIPKlaR5eWSXyS3014fxoYLwrifpgUfdzAALdZdyI2yHAOizUbfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=WB2+L69Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B8YfSNbj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="WB2+L69Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B8YfSNbj"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 426FF114023C;
	Sat, 28 Sep 2024 06:57:32 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-06.internal (MEProxy); Sat, 28 Sep 2024 06:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727521052;
	 x=1727607452; bh=1aWqzKBhT4uL/R7AYIQ3f1ZspqKJ9/ZNzzUUWS3mofk=; b=
	WB2+L69ZA7ehLpLOh3Zotn12HgWuej29HOcjgP1NzCaV8jZ3v1tHd4Ltoa+VJZ8j
	fZk9UoOVI5mg8oe434m7Lk28L7uFkjZDr6awQd6ieOoQId7tCTU0q9LnDb0Rmzly
	7fQeo9KlYKnkJ762ZmD7f2gvEVHZ4HrVpSlqUBPgNS2ayVBMgExZC9nxsxKtzCpv
	sspJipUFoJmGyTNcNWxj4kGuz89JOwxiTg6CsQ/CZ6ggfeckJ2ubdqZtoMNg3Mk3
	M5sgd3+W2jAdLBvK2aewkmoukTTj5QSLsO626sNYomV3V1hR7IQ1QXfY/1Ex3m1L
	u1srAjG2STgLES+3I6RxkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727521052; x=
	1727607452; bh=1aWqzKBhT4uL/R7AYIQ3f1ZspqKJ9/ZNzzUUWS3mofk=; b=B
	8YfSNbjrwECQZ4YcWDAZgvjOTtIo4CZfbjqR7+xb2krj/vrlbQTy4thmiZXxT2cV
	EmY1V8KXgDJTkCBwViJFLx2b26RvjZ8QVUqKBauDju9gqQASZXCgkyfWv36qB+oH
	6MpGzbKbXIXUpY5X2e4b14Iytmcf0wEqpgUg3DimcO8Bv4jL7Mk6vbkw296+R23M
	e2M00s5fxYD4FG93f834LNKPvrs/Ex42iWLFWTWcBxbf38DXmZGb/flfgPqwx6y4
	FsXpg8ACk+UFJKwp/LqhI9FovkrpBukTSUgv2DEZ48W1lRbj4bTRn1/g9CBoS9zD
	6Nt9jZZCULxUn+3D30Opw==
X-ME-Sender: <xms:G-H3Zl6xQUus_ACIq-fAJJK2jLu7qMGjPaf-53pLkLnrMX2yMVyUIls>
    <xme:G-H3Zi4V8V6_BZO49K2AbTdUt1jTpJNkZj-TBSV8nDHWvcr2Lg6umtG_-F49yc5tD
    1bxYIZZ_p7wVQCTIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdej
    necuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggftrfgr
    thhtvghrnheptdehhfetffeftdeigfdtlefggffgkeffjeeivddvhfffffekledtteekke
    efuefgnecuffhomhgrihhnpegsrhgrnhgthhgrsghlvgdrtghomhenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrg
    hughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrd
    gvughupdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtth
    hopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:G-H3ZsewdWfpU6_6d63cZ_YJR0UQs9IcyL_1or5rhZSu-0d2ppjnfQ>
    <xmx:G-H3ZuJ6Rphs31y0piAg_MXNye09Dkzd4DKgwaTFqOJGBZYWGkMlyQ>
    <xmx:G-H3ZpIiBakNPNhZjNCvfgmg8kocgAKzQIHmCSBz-kNk7_kAtaQYMg>
    <xmx:G-H3ZnyAvY_3DMeQfkjP9N-ZEFXSyKO0ZEdt4lv0R8WtRMef0Nr2qw>
    <xmx:HOH3Zg9ZHiI69Sd7Eb6PGHuAoYcOjMw37d6VIgRNHHoDRbZRE3kYtf4p>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6C516780068; Sat, 28 Sep 2024 06:57:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 28 Sep 2024 12:56:54 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: rsbecker <rsbecker@nexbridge.com>, "Junio C Hamano" <gitster@pobox.com>,
 "Christian Couder" <christian.couder@gmail.com>
Cc: git@vger.kernel.org, "John Cai" <johncai86@gmail.com>,
 "Patrick Steinhardt" <ps@pks.im>, "Taylor Blau" <me@ttaylorr.com>,
 "Eric Sunshine" <sunshine@sunshineco.com>,
 "'Michael Haggerty'" <mhagger@alum.mit.edu>
Message-Id: <5a8f8c96-0981-497d-af46-a689811a0b77@app.fastmail.com>
In-Reply-To: <036901db1135$7024a430$506dec90$@nexbridge.com>
References: <20240731134014.2299361-1-christian.couder@gmail.com>
 <20240910163000.1985723-1-christian.couder@gmail.com>
 <xmqqikuijni0.fsf@gitster.g>
 <CAP8UFD34YJ23WSjaP3m8Ao6iZja_NJWfQ0BNEsaNU_F_X3qA_Q@mail.gmail.com>
 <xmqq34lkg1ck.fsf@gitster.g> <036901db1135$7024a430$506dec90$@nexbridge.com>
Subject: Re: [PATCH v2 0/4] Introduce a "promisor-remote" capability
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024, at 01:31, rsbecker@nexbridge.com wrote:
> I am one of those who really would like to see an improvement in this =
area. My
> community needs large binaries, and the GitHub LFS support limits size=
s to the
> point of being pretty much not enough. I would be happy to participate=
 in
> requirements gathering for this effort (even if it goes to Rust =F0=9F=
=98=89 )

git-annex is an alternative to Git LFS which doesn=E2=80=99t have any si=
ze
limits since you can use any (multiple) remotes for the =E2=80=9Cbig fil=
es=E2=80=9D
storage. Like an external drive.

(written in Haskell)

https://git-annex.branchable.com/

--=20
Kristoffer Haugsbakk
