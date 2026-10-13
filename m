Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB730D41B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858203; cv=none; b=K93Gw+zuQRTpKiW7PptUL9pY8ItZ+mmf5zOucIvsccRwjLmDRF5CVe7a6pCy0+6+vw0ElfwZjVrIfk2pJmRTrXE7CeQgA7LAO/zIlWwOat9/pHdz6Ym2+WWoFmfFBuqO9+1yI6gqUAM2NY13OBiThvrPZAPdRhue5BduJXYRngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858203; c=relaxed/simple;
	bh=wl6dQ3cBVpWOqlChduqnPgThh91hrVxy5AW4ORPHEBQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g9atlmU3/xUkqRa0B0m/SRIinnbUMPcl8fcVZVa7A+mBSzE2CMp0efiVf5ec98aO0GxDp/YovRdmamXZ8hzufnLnTf4ez9DGbYF/mHOdwt5iMxv4v6Ldqdl791Nd4LDctQsfVPEBP9T/7eTmTZKVHfaxMug12wCUi0CewE5xgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Vwjqt6pg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TYYoPncz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vwjqt6pg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TYYoPncz"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 3FA801D000CF
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 22:23:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 12 Oct 2026 22:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791858200; x=1791944600; bh=C4o4tYr19/
	myab0hlreWQ1oC/JUix2wqShf0p7SjENM=; b=Vwjqt6pgOHuIIlyAvN8YGvVM09
	OBz43DCwdm3hxVn7a6l/PNi5uWVv0+9R48IOSkr+rVT725A9+BzmMOg4Ul8fxqeN
	MAQcN2pwBpsrJKy4vJa+CgKK8pwt2MrHDRcmPJrIqCYGhdzm28kCUaw+e9lglRqn
	2mHHgpiXLnGJazz49PAoPrRKnhKxzIr6hzEmpbn3B5wnHI+PE3P83r4jMJLMHyFg
	s7C0cmngiW7L1eI9oX5Y5AaF2mq5vemA/fBLIhRR7UTRsOomd4Cz6FZJLYWZmz8C
	nI2S3YDrKGSW7DXzF7awTBjKzs/OgUoEiVrCij0yy6xhKg8NaLUsEFI4vTaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791858200; x=1791944600; bh=C4o4tYr19/myab0hlreWQ1oC/JUix2wqShf
	0p7SjENM=; b=TYYoPnczOmAzIQGK1rs8UbsRb0xdfHFibdZNA1XwXBI3onLPqaw
	o5cA4MXbB0vNMFfU/Euh6JjKX0zAq3Pb5EJAO35EcwbLvYq2aZb7JcZ3Doj3wqpT
	KwV1zy7hayMEMDawX49HqTCxI+N1K4vhGSHp/zXWvhoXnl62O53YIVrdG3cf4e1c
	fOBybq8pT757Z8LhHS4/+NB4pSqWfRTeePjuMmXeC8vSLAkp24HToRj/4v1WdYiy
	Z7KZq7hgamzsgYHC6G1qn8jtOg3+CYFf4wJGUHEe8wBiPEU5ARdyEXd7NI+w/tS9
	BKDu2FGPBk+YDd9jKywSszVnbl2iuqdsNFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791858200; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:NWiCv6Ia7P1AWrFFhxD2a2oyVHV8BReSMdzVn1qUKn+FBfb
	xtGA1i9AREtC3IXRnK+8LpP3dGT4LIDEYl8niobSHcZ4yJ+qn+lDDeJrrZ9HQWf8
	z+uit5xZ5ielHE7t1oC1bgHkDH1BtQYCaRU4yD4XrWrYDYDDkJbVTH7ZYfiP0FER
	JRu99V7ewKLnKB1ooZS/BLryQu/u/c9iwz7JAgjjSPpgX0zNDpAZ+SQjF/6ysygl
	oLbAHC7YouwSpOn+IyD6ZnP04ShQooCqcl6SZNePccKmWSABIc1zvhcPChcgwhyg
	gS7qAw4JPCAaIx+2GLvJ3gtkesykmovOLx3jj2g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:tusRry4fLgkqDSWFk4i7+sBEjXtN2c4fxsZchDdCX6g=:wl6dQ3cBVpWOqlChduqnPgThh91hrVxy5AW4ORPHEBQ=;
X-ME-Sender: <xms:GJbNalO4yftk5PVn0stPlKwr3grmrLdYA8JplnvDBViZY0Jnwv9D-Q>
    <xme:GJbNaqMR0FXBKgbymqgL5y4Bs-qLBhrDhgbr9Ru6Z0DSibllOdLSlXb4EbTkP4FIe
    WrefJ6r5sEFGUDw6dHeNmdpLtL8dh76ID4QQ6JNmoLeTLP0BIMmN0ip>
X-ME-Received: <xmr:GJbNamjQ9wAxCKa5qg9AAEIcUj5_jl99BXA26Sn6-xRnb7asNIWKjjARPGYLuqeWsgq5f4Y_j3LnVhndW4OYifPRfRePv73U4SBT>
X-ME-Proxy-Cause: dmFkZTF5sQ2sTmcyQiy6O/4oOQFsbsVbyYgeBGOtkg3M8GnsTFvQEJqVa4Dwts4UT5nrpT
    4S60oc+Y5HjvIHKUy5hMLn8mNZxY5gHVKDpKLEmkAF2qngA0ja54okN9/ttrlrIl5aTwpg
    pR075jAix8Jla+CqfkMi/S3oqQHBxVTxapatcloSKuEXS9kb6X6H38PZA3Ludiw9u+nZod
    CNn9c+K1Q2DTQknQPWspSxed/hJ6iVUwjlaGIqy/h3ZW8TUBeyP2OnLJqW03jhcwbM1+ql
    miUWNhXaQyh1WEpCx2SULGnbeZ3Z4qJScr9i2AfhErn2enQCaVB1V7TLnR+6kxOnPaRgmV
    Uk++UWAOJTaNawo+wSFmomxVv0hpnJHalle1x4xcUpLFvzUr/JcfqiFm2JP9WsM8ft1SPN
    9EdEQlAmmZBf+9x0s682jDNwzaRGXnl5Tajztb0CJn0uVVs6vBBKK1QV3xoI3k32TiOU01
    BkJNC0d/M1vBSkjO1uajYZi4OxR/jteXrelAH6MPU/zSEtbJbIDa1SYbgUhYaquHTx8xym
    8N/Y1QNn8JYF0FsudhVrlovAlNUDTURICqk1iEkl8hHFp4oGmEiw5l69pHRdXVMgomdsdQ
    UX2WAUWcCZMi5uhdBd0NFl36kxlsBcmaLoGKOS0ujCbrtJmruaGs4qZmRBJg
X-ME-Proxy: <xmx:GJbNanuaUO2byeaJAyeafOen_zENr33VpcNtokpA6lFka-eawGDejw>
    <xmx:GJbNasQcNdG8GCHy_dJSXZ8OQq1MjSFygZ6cksdeIDhOZvBJ7hgCbg>
    <xmx:GJbNaj23cppxR02z406qBcqH0AorsfPvK_G9PFfqSI0UrDiRn-6gRg>
    <xmx:GJbNapsujxng6kOxhdP0jO22PBuPE8vDewXwdMuydNPIyDylglMWCg>
    <xmx:GJbNasD5NqUjgWQiZBSZNBKZ5U1Sj1OBrXYktXfm2X_cwL3CIsmQ1jTP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 22:23:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 0/2] branch: let --delete-merged find squash merged
 branches
In-Reply-To: <CAHwyqnUP72njKKap16u+kShHmhssiUXFUVRhURPP_wzwZsvtdg@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 12 Oct 2026 19:44:22 +0200")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v2.git.git.1791711665.gitgitgadget@gmail.com>
	<xmqq1p9vdalz.fsf@gitster.g>
	<03b187ae-bef2-426f-b6a4-def9f70c4a3f@gmail.com>
	<xmqq4ieqamn0.fsf@gitster.g>
	<CAHwyqnUP72njKKap16u+kShHmhssiUXFUVRhURPP_wzwZsvtdg@mail.gmail.com>
Date: Mon, 12 Oct 2026 19:23:18 -0700
Message-ID: <xmqqy0c21gq1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> At least the one-to-one part of the operation should learn from what
>> Dscho did in range-diff
>
> Oh, that's great! I'll take a look.
>
>> especially the part that does take
>> similarity of the log messages and authorship information, instead
>> of paying attention only to patch IDs.
>
> Right, authorship would at least be a good filter to speed things up,
> can't be the same commit if it has two different authors!

After thinking about it a bit more, I no longer am sure.

It eventually boils down to what we are trying to achieve with this
option, but "I have these pending works I asked upstream to take a
look, I want to see which ones landed and remove them from my local
copy of the project" and "I have these pending works, but upstream
has been collecting improvements from many other people in addition
to me.  I want to see which ones are still relevant" are overlapping
but different.  And I think when you start talking about rebasing
and squash merging, you are asking "is my copy still relevant?"

And the latter is strict superset of the former.

You might have instructed your agent to write a two patch series and
asked upstream to pull.  Somebody else used the same AI-gen and
created one patch that solves the same problem, which happened to
have landed first.  Or that somebody may have sent their solution in
two patches similar to yours.  In either case, your two patch series
is now irrelevant.  You would want to drop your branch that is no
longer relevant, regardless of whose work made it irrelevant,

They may be textually similar enough that we can tell mechanically
that there are already the same or similar code in the place you
were trying to touch.  "--delete-irrelevant" would remove your local
copy.  There may be salvageable bits (e.g., yours may have updates
to documentation and tests that theirs lacks), so if we can detect a
case where only some parts of your work has become irrelevant, that
would be very useful, too.

Stepping back a bit, perhaps "--delete-merged" should not be
modified to touch anything that was rebased, cherry-picked, or
squash merged.  It is good to have one stable and strict "if my
commits were merged and safely saved there, delete them from here",
regardless of how much looser definition of "the same patch" is used
for "--delete-irrelevant".

