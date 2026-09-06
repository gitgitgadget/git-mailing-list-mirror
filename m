Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E62BE555
	for <git@vger.kernel.org>; Sun,  6 Sep 2026 09:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788687696; cv=none; b=c47bzkt80B+QXOZtslBzO8mj03k/r4aQwz1b/AvTOdyUkyX4gkxNBXSt56VA3ftbHT6uqTurqzbOwOk+07mMkFbcP+1eK4Lofb+5Wa0BiGqvQ+/swTY6DoLbCv5Bimx+eakWuZAvz4JVCBNJy02TK76dWh6AaaZuREP1C+QVkfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788687696; c=relaxed/simple;
	bh=vOFhFo+mNJ/yN3KucUNv7zklLgC9IESLuapFD/KGpIE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=slpHIttle8JXBB/22T93nt/MQlehxLCCEXhM5Ol6rR2bqsle03aQD8bciro9xe1M5idZL2SD50NQzjl2/xAj8D5lVGnoyAyW4e2u3WiQrxaGe7oYFg3iL8v0V0M3A57kVH7RfLAQ7TfF1cvWdGt88PjZ0G76+ikGnG2LYnCHBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lIZ1LE+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nz1cPYX0; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lIZ1LE+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nz1cPYX0"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.phl.internal (Postfix) with ESMTP id 24AE1EC009B;
	Sun,  6 Sep 2026 05:41:32 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 06 Sep 2026 05:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788687691;
	 x=1788774091; bh=vOFhFo+mNJ/yN3KucUNv7zklLgC9IESLuapFD/KGpIE=; b=
	lIZ1LE+hXJpQ6yQsMSL16fB4BArKlbILIe0JI3xlkf13NH0891ycXU3V2hL2z9jz
	Unpc3ol3+n0MuYf0nIi+2nFH0Uk5yYmPsUdDr+DQbre87E22u94r8BXDPg5VKh0Q
	VsrGjjCjxq5UocqT3AIyFl+QC/7dmbQjNqZXzUtqw0zrfqExo5vt4UszVieJcke/
	BvO/4U8uPtmA2uPe7RgK9QpoXHm6zFIepmD/Npf3LOjCJAMKIshGnt4rkRiwSy2b
	lp1BZApT254gU2j1kEUuho2kWNcU9YFlSehL5yhnODJ81wGzLFZEsd/ZmQNS2Xfx
	SxgvuypQwAby2XhoKsSVxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788687691; x=
	1788774091; bh=vOFhFo+mNJ/yN3KucUNv7zklLgC9IESLuapFD/KGpIE=; b=n
	z1cPYX01EYyvO901bOGhGJX4WW2f6D98eOBV0mNDcuGEcICcqPM6myfuthThMEm9
	KDG/C5CtGhd5n7InzI5wDx/PisC2mYrHXKIyqqIl6SglKzJRdDYUtNqCgp+SJlYX
	EuYn6EhSPMOJClJCF8Ph0s+5ln9sqrHn87DTC/bo7f6OYqT1yyR2BPjj6rJdzaT8
	tY8xM80MWjQhFrcr5TX3dDePrtr4OP+whw0BOObWopQo62orinWu1l/gKshmeUYx
	0cYrCvUo8Pv9B5XGDBf/J2Zy0k6wxZA5adaVVj0Z7FxyBd9MyXXqUHnUUAyAWywn
	TMCi9z50deKegHgLvWK5Q==
X-ME-Sender: <xms:SDWdaryogMs5fIIE-aHC11610PRMSfuXa5H46VfnUjBrkmNg1qigTks>
    <xme:SDWdauGTP67yEzzG3unxltSGG65yccnOT4Lwf9QbQ8Alk2x13lg0jPsJRogNaS0iF
    atmsjXqGSFg8yOHtMH6WuwoMqRPFRb9tWrfckJaPZLO1AIkdXCb1Jo>
X-ME-Proxy-Cause: dmFkZTFsCLGp4OwAbuip9meRCcbSWodBkHoLtGZKfji3lli44ISAcxa+ChMoqexUSFi4CN
    Q10CxgLMuey2ztR9Q4lHSbNvKLiwQaWwBuzabRkX2+iopOr0wQZszFUhU2nc9SJCIcSiM2
    jXg+K9jqk/zXvoKTwk4NKeb3+jhpw51OUcpyBGdDJVZgMl27obvqAqe7VV6EMCuJD2wkVj
    4qgZcnOXD6PgNaFl9BRhXUiIWuoRZCof7exuB5TS1IIC3wuSc07QaVrrtx7gG1lHWGer1W
    06254GEH/NwLUgDfCNT39hDg40bFYeyoKWIfrmUoiGzAy88tFJficS+dJMKYm2jPpjafdQ
    E6zW6FRiWBMElHPDEwkiF/x6qmErXtdPC9iiq2iDA4OmvZ0goVHtPt52lQAE7pIHQYf0Or
    rSyVbXJkqN6iUMhzo3CSrnA54/vvQ9CKLeJusOIgkZjyfBRP3a00nhkcPK2omg+XM7t3kh
    p2NdYjk9P4ekcQ5XIb9mn3zs04oVEkBdu/w6ZCwIXq978ZDNPb+vOqlHFLiAWNUEAxgiJW
    mBgn7vyTHsldjUK38zT1aEi11tBhKgePwv3Zhm/yC6ZSl45jolSRAQgb5LadiqwBjoSU16
    IzWQeORUvZaxh41CUEsIBIZChIPaVH84wPw89K1HiqVP7iAGrkvpQmpms7pA
X-ME-Proxy: <xmx:STWdaqbYZ5H07q2yYKkEklUqBxfPqxqQTNWlzbT9lgOKo9sZfIC3dg>
    <xmx:STWdarNwBLxPMrCtB7h_Z3ZEOrtv86sT5R3rrqlzI2QrqCtYsKAV1g>
    <xmx:STWdavYDatcUuLriUCFc1YbY7_uv8UbALsiWbl4VrononetnIIYrvA>
    <xmx:STWdap0BEUFRN0zkW9K0DX2guxGufeRLpmht0glGM6Lk383h9veLNA>
    <xmx:SzWdanqjw9xaxTa0ZZaDIUDNKlVGaihEDKiDUWqGZadxnQgmnfN2p_al>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 75DFE22C007D; Sun,  6 Sep 2026 05:41:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AzQf8o4jUb_w
Date: Sun, 06 Sep 2026 11:39:29 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aleksei Sviridkin" <f@lex.la>, git@vger.kernel.org
Cc: "Junio C Hamano" <gitster@pobox.com>,
 "Thomas Bachem" <mail@thomasbachem.com>
Message-Id: <fdf8fa9c-1e6a-4f7c-bbe3-a0b41cdaabd4@app.fastmail.com>
In-Reply-To: <20260905171343.34722-1-f@lex.la>
References: <20260903010547.85469-1-f@lex.la> <xmqq5x0mfgyh.fsf@gitster.g>
 <20260903200015.36849-1-f@lex.la> <xmqqo6ee9jtx.fsf@gitster.g>
 <20260903214551.53918-1-f@lex.la> <xmqqpkyt3qul.fsf@gitster.g>
 <20260905171343.34722-1-f@lex.la>
Subject: Re: [PATCH] push: fix --force-if-includes when remote-tracking ref has no
 reflog
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026, at 19:13, Aleksei Sviridkin wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> I prefer patches with human-readable explanations and known origin.

The following are just drive by comments on this point.

On Sat, Sep 5, 2026, at 19:13, Aleksei Sviridkin wrote:
> Dropped the trailer. You will not see it again.
>
> On origin: this comes out of git's own tree, not an outside corpus, and

Cool that it is only trained on Git=E2=80=99s corpus.

> that is why every claim in the message names a file or a commit you can
> check. The change here is one line, timestamp_t date; becoming
> timestamp_t date =3D 0;. I read the whole thing and can explain any li=
ne
> of it, [...]

If one can explain any and all of it, then having an AI write it is not
necessary. Referring to the =E2=80=9Chuman-readable explanation=E2=80=9D=
 point.

> and the sign-off is what carries that.

Weird LLM-like phrases like this one seems to be used a lot on these
`Assisted-by` submissions (by you and Thomas Bachem recently).
Inanimate nouns gain subject-agency in sentences instead of saying
something plainly like, I have signed off on this and I mean it. And
this is on patch discussions, not in the commit messages (which are
already marked as being potentially AI written).

I feel like I should take two courses in linguistics in order to
articulate this uncanny valley feeling.

By commit message volume, I would have expected the commit messages (if
they are LLM-assisted) to read more like Jeff King log messages given
the corpus training.

>[snip]
