Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E228DDE
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 07:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712560554; cv=none; b=SxQEXTEFbcTiTesIAYBWOmRzqKPbpUTj/6TGJHnhw7QO2wa2NtKmAUvBpWfEYSR9bvpwwlWHbqKxWzCYsZeYXtTVLuNEugvW0Xw79Uz9zzCBTu8BeMyS74LqTFMeBCeQcJ5SwlhdhsG06UbAbqBWAEhPUzLPetH95yutHXHhp1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712560554; c=relaxed/simple;
	bh=41Qud1lZi+Eexl8Ws2FeKIxgiqGp3FTdpf6EWPJuAMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evi3H0SrH4ZwXAaW0mAgSkqh8qc0cNwJdjs7C1tbIqzVnynUgglUpfsDLqyi7o6vVqHPouJXTb9coQwdZi/6Dqvjij9xn/wy189pC3XCrUc1gcWZIb3yJ/EIA2S9vnI9avLCJoSYtlQ59ayxNVbQt6M7D3zxDzSDRSM+QDLhSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=tUWULNUg; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="tUWULNUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712560543; x=1712819743;
	bh=41Qud1lZi+Eexl8Ws2FeKIxgiqGp3FTdpf6EWPJuAMQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=tUWULNUgmyrysXjwSGUt2nc82Acy8gWZODxiKGw101RDSsb1yd8n5x+CbNEETm7kR
	 oFZpFw3iMe4x5rRXHJMLEs4B5qM6+bFzY32jbM6QuHZjCsS7q9MLTQVF4Xi80Bp8dR
	 amoFbjF1TqB02IbaBMilkQZVsdqv+UPBAVy9Uhl2sToaO1Zvavwmf/3cUQGElHLyZG
	 6BKG2zPCVaLNL+fIO7VHC4r1j+5+p6pdI9Suv+pguxnmjVCFAg8KERAO1MiduJPuiX
	 LrOWlI/YFxhiwax+5d4slZSYX9WC4vou5+ql766sixJF3N6sAsSG18puwyMjoOIQz8
	 0s9d7AJ830Luw==
Date: Mon, 08 Apr 2024 07:15:35 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] fast-import: tighten parsing of paths
Message-ID: <1B15EC5E-E0E7-474E-A0D8-3089918394A5@archibald.dev>
In-Reply-To: <ZhONyBIFlWbNHNwN@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev> <CAPig+cSu5dLoDew-efAB-H95B53fteDGNO=_1jc9i_MUqdpw-g@mail.gmail.com> <ZhONyBIFlWbNHNwN@tanuki>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 7, 2024, at 23:25, Patrick Steinhardt <ps@pks.im> wrote:
> On Sun, Apr 07, 2024 at 07:46:52PM -0400, Eric Sunshine wrote:
>>=20
>> Lack of response may be due to the series being overlooked, or it
>> could mean that nobody has any particular interest in the changes
>> (which is not to say that there is anything wrong with the changes),
>> or that people are simply busy elsewhere. It could also mean that this
>> reroll is good enough and reviewers have nothing else to add. So,
>> cc'ing potentially interested people makes sense.
>=20
> Yeah, for this patch series I think it's mostly a lack of interest.
> Which is too bad, because it does address some real issues with
> git-fast-import(1). Part of the problem is also that this area does not
> really have an area expert at all -- if you git-shortlog(1) for example
> "builtin/fast-import.c" for the last year you will see that it didn't
> get much attention at all.

Unfortunately, my upcoming patches will probably suffer the same fate, as
they're mostly fixing parsing issues in fast-import.

> Anyway, I'm currently trying to make it a habit to pick up and review
> random patch series that didn't get any attention at all every once in a
> while, which is also why I reviewed your first version. I'm taking these
> a bit slower though, also in the hope that some initial discussion may
> motivate others to chime in, as well. Which may explain why I didn't yet
> review your v2.
>=20
> In any case I do have it in my backlog and will get to it somewhen this
> week.

Thank you!

>>> I have several more patch sets in the works, that I=E2=80=99ve held bac=
k on sending
>>> until this one is finished, in case I=E2=80=99ve been doing something w=
rong. I want to
>>> move forward. Thank you for your time.
>>=20
>> If the additional patch sets are unrelated to this patch set, then I
>> don't see a reason to hold them back. Feel free to send them. Even if
>> they are related to this patch set, you may still want to send them.
>> After all, doing so may get the ball rolling again on this patch set.
>=20
> Agreed. Especially given that this is your first contribution, the
> quality of your patch series is quite high. So I don't see much of a
> reason to hold back the other patch series in case they are unrelated.

My effort comes from reimplementing fast-import parsing as a Rust library,
following the implementation, not just the documentation, so I=E2=80=99ve n=
oticed many
mismatches between the concrete and abstract grammars. Perhaps it would sav=
e
reviewer time to submit those around the same time, so knowledge of fast-im=
port
needs to be evicted and loaded from cache less.

Thalia
