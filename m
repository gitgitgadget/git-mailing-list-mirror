Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA9F31F99B
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870211; cv=none; b=cf8uHcOAeU1P6fBQPnYDE6TFCV9eZ4q8EG53Ykz8q3s9OmXybyNIfYSXhH5uI99He/EtJ9tahyG7tTP5ZjetQMgYn+fO+2kTdAB5IcLAyAIJa29GPOo+PpPQtgtbaDtyIMG187COtkXEEV4aeTuUwEXARa76JDKNcXAUPrIdRyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870211; c=relaxed/simple;
	bh=U5aih86oubY8c77h8raNSD9237OBMrUSh3wsQKcSZac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPssisNIAkpRlPpa/v3H5+jwBeJvQvCBGD5s2uz23nSqoVGpV8ZICsSvgS90uHxEyqh7PMmSdZVEiNuuU0jIXjWf9EarK4FxHqao264d7x46uocsiUM1WU4muCkgt/B9jYHcyyMF2FOBNSXAbzVhDy+KpL4KMcva1DJylaI2yyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Zu2s8Lsh; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Zu2s8Lsh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785870201; x=1786129401;
	bh=U5aih86oubY8c77h8raNSD9237OBMrUSh3wsQKcSZac=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Zu2s8LshfSB5Do+Aj6e/8s4ANaVeZhqRau6bi0+pshPWFcwSfL7k0JP1MGZldhorA
	 MU3iiMlWePywFKmz7EmAjGeGr56fSP8B/G2xdKcRgfiwzVsLoQY7u7yO62J8dI0fNL
	 wBp0p3Bn6RdoyA5mk9du1do79uTqM8NEOk0pHWuCxfkvf9WRjwkGyOMj1+4giO7Xes
	 Q+mel+stoItc0VWoHOZrP8bTJ807O8KKsHZb34a+WhC3UM5yATEO0ehBxMYxQi0dkT
	 gLv7VMQwMnVrq4BEm6BoGmERPwqwNEt1H8PSd1LHdjXNKr3qU/laC1MBusNoGG/iKd
	 1dqnOj8dTiemQ==
Date: Tue, 04 Aug 2026 19:03:19 +0000
To: domen@cachix.org, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>, =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>, Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/4] worktree: add lifecycle hooks
Message-ID: <DKGE5DORETW5.1S9NXEX8KMQHH@pm.me>
In-Reply-To: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 30c112af8b302795d4ff7a96554ea7d4b57eb28b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Aug 4, 2026 at 1:14 PM CDT, Domen Ko=C5=BEar wrote:
> Hi everyone,
>
> First, apologies that my earlier reply reached the list as a separate
> message rather than as part of this thread. This is my first patch series
> submitted by email, and I am still getting the threading details right. I
> have made sure this reroll is plain text and correctly threaded.
>
> Thanks,
> Domen

Hi Domen,

I love the idea of having hooks for worktrees, especially now that
they are becoming more popular for having agents work on tasks in
parallel.

I'll try to set aside some time to dive into the individual patches,
but I would encourage you to take a look at b4[1][2] (if you haven't
already) as it greatly simplifies working with patch series.

Best,
Caleb

[1]: https://b4.docs.kernel.org/en/latest/
[2]: https://github.com/mricon/b4

