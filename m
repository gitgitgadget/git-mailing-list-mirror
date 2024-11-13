Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA335885
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731483372; cv=none; b=RtODukJiPt3LxIYRQoC46Jiyg1cLaukvJPf1x1gclUvZaqF2t0KccrkohLraHCX92tstGKJk7bsayk8a3sVoSVmO4457hOKUA9uJGCA+o5t8zMFKJv5DMzoXtIGzceLRb4lWqApE6QHtp6E6uC5PP1UCOrZFdiIqC5zs9qkHZEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731483372; c=relaxed/simple;
	bh=ap6fh0DFHa5+sSX55w4iUbVC4E2Z9LKV9z+gPMl9hrw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EWGGa8UdSJFmvv/0dTNrKTaQ0wDK6on8D36iaWhizHZdBGceZnqtBHGUCx13FPj8hOs96YFgpGiH3vMcVByM58VMvxZhItZKL2Kj1uHLZivXgc8k1J9ahev648+q9dwwNk/TtmYib9Rpvp8MBMo6sUXOpMg40FB682ZtFKUFcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email; spf=pass smtp.mailfrom=revi.email; dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b=K7cMjj9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYUskZof; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=revi.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=revi.email
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=revi.email header.i=@revi.email header.b="K7cMjj9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYUskZof"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 5297C1140135;
	Wed, 13 Nov 2024 02:36:08 -0500 (EST)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-01.internal (MEProxy); Wed, 13 Nov 2024 02:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=revi.email; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1731483368;
	 x=1731569768; bh=tcF5bm/UpdGBfrx/bX7IeSOL1RJMLGTk1mUVvwJDjXY=; b=
	K7cMjj9TLZJ9uBIHoPxnLaxAz1Aeoo7D3YwsAAD3eYXXfjzyWjZHu9FTvTj7sqVw
	dWnOXbdKvJlt3y+TLV3X6RExczwW8zmF6C5NFDs9XNN436oQflUAzL3eewhAjHeI
	5v7eMMp5oUAKi/837h5TsWnQ/xZ1hBAkXCEHonTZDMqPswRB1lJwiWs7yHjMnRuM
	bLj1VrSNSasb9lGKTcc3gGSOB/2aPcjwNG1vxrMgQJQ1jOx/UhGAmn/mdIoGtoqr
	CHovy9YVmJBkmUL8JWF5MBtbM49+h5zp2mVGgHFBDt7PpZ9d/fZK3PLTDymXSxQ0
	TsdOuvJnGwffN5UK8Ey4SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731483368; x=
	1731569768; bh=tcF5bm/UpdGBfrx/bX7IeSOL1RJMLGTk1mUVvwJDjXY=; b=T
	YUskZofJ8ADCip81OhzjfncA7MFNOHW4oB0maOA/o1XqCBs4mXm6DH9BTbPdlZ0W
	uB0kTaPbJhF0mUGra5ThUThoRmjgi54ujdXwIt7TZxbOsGfSEbh0PRkj/TfmYGTx
	1akVNq7TAGd3+JZPJvCchBzvbD/Ug0SSMFV701ZdjR+yApjERH90/lOrei7H6i+5
	Vt0iyMc7Wv/0owR9Wqa85mDnxBONWZcTutzszkbEDQWktZB86ZKKdDjMmRfeAAns
	Emuh8MC+4puoUfqTgbOLN6q7p7F+yp16gItQ8nPoBC5kxrf09d1jlJBiqlH9pYsd
	3keOuFpIF9Fs3mD1DvCBQ==
X-ME-Sender: <xms:5lY0Z6wHcReQLErRBnbEpTKiD-PdVa0vHkJt6C3KHg0OM6mpX2V51g>
    <xme:5lY0Z2Toigrarg8hcHFLjDIg4Hcvnel6xZRt9zhVJRm5AhM7UxRa7mszhxRJqrkzv
    d1SqBiBQv8DaJT2mVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudelgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenfghrlhcuvffn
    ffculddugedmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhf
    hrohhmpegjohhnghhmihhnuceohigvfihonhesrhgvvhhirdgvmhgrihhlqeenucggtffr
    rghtthgvrhhnpeehueejlefgfffffeevtddvledvveeugfetudettdetffdvgeegudeutd
    egfeejtdenucffohhmrghinhepvggtlhhiphhsvghsthgrthhushdrihhopdhrvghvihdr
    giihiidpfihikhhiphgvughirgdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeihvgifohhnsehrvghvihdrvghmrghilhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:51Y0Z8UifzVzZPjoSvKei6Yvj_WoqgPepMGkndxh7unWnpwaPoEDUQ>
    <xmx:51Y0Zwg43iikPVStOChxBBAYhPTT-YLAgzJEfgTxig5GBK2Rb3ybIw>
    <xmx:51Y0Z8DPmODFl4uDeI_zr0TWrfN6Ia_NC57N1jxYM-ATW9VYh26DXw>
    <xmx:51Y0ZxKRnXEmNkSbQ_DfRGrGWySpMMWv57SaqY2KXCiRoFw_WADUUA>
    <xmx:6FY0Z_MURuBQL64sF79J-26yLNHz1E5YYCXZkmJyTE8X6X0v4vS_IHc1>
Feedback-ID: ie2a949ef:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DC707780068; Wed, 13 Nov 2024 02:36:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 13 Nov 2024 16:35:44 +0900
From: Yongmin <yewon@revi.email>
To: "Patrick Steinhardt" <ps@pks.im>, "Junio C Hamano" <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-Id: <653fd6b0-0351-44ec-ba31-dbae0e2d3ca5@app.fastmail.com>
In-Reply-To: <ZzRP7cR6S6YCWIze@pks.im>
References: <xmqqmsi3262e.fsf@gitster.g> <ZzRP7cR6S6YCWIze@pks.im>
Subject: Re: [PATCH] ci: update to jgit 7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2024-11-13 (Wed) 16:06:21+09:00, Patrick Steinhardt <ps@pks.im> wrote:
> Seems like all of the downloads result in a 403 now. I was digging a b=
it
> through the mailing list archives (jgit-dev, eclipse-mirrors) and
> couldn't find any hint as to what is going on there.

It could be [this]?

[this]: https://www.eclipsestatus.io/maintenance/456545

--=20
----
revi | =EB=A0=88=EB=B9=84 (IPA: l=C9=9Bbi)
- https://revi.xyz
- he/him <https://revi.xyz/pronoun-is/>
- What time is it in my timezone? <https://issuetracker.revi.xyz/u/time>
- OpenPGP <https://revi.xyz/pgp/>
- In this Korean name <https://en.wikipedia.org/wiki/Korean_name>, the f=
amily name is Hong <https://en.wikipedia.org/wiki/Hong_(Korean_surname)>,
  which makes my name HONG Yongmin.
- I reply when my time permits. Don't feel pressured to reply ASAP;
  take your time and respond at your schedule.
