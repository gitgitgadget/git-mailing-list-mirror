Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCB2611A
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 05:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705469351; cv=none; b=Gzdf9KtUXjKdawmpbV/3VbPiQgleLjKi+hsCXt8AfpRiouopalQqVhXZz0ia83+siXrUw3uWU5eP6s9ITeUSFb5UfEeIp/Dpw4ZQF3yrkA7b5UzZ+GmK/t4V6BYRm6zB4q+lDVV1FuH6Qbgysi+HPluyImpeLr8IHXSccVpEeuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705469351; c=relaxed/simple;
	bh=16oMicNDUcgNH4Er7l1eMAuA2iOoIBkYDFeKk7xISUA=;
	h=DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=tbdkQ56Z/MsPvEy2BD4S1mm7AKvyw+TgAmfHz1LpuALjLLSYkM9c8anXVClj4Ejj7/kloctV2obclEieiCFsAvxAoMf/5RN6y6GQO1N0WTh7GGylokpZLQyH6U08Sc4OShhMQ9V/ywzE4ykKTwGXT1AAchbA9OMObfhO+CB5VXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=i5ZU5VCR; arc=none smtp.client-ip=185.70.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="i5ZU5VCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dlgxheby7bc4deio3gvpmju2vq.protonmail; t=1705469340; x=1705728540;
	bh=16oMicNDUcgNH4Er7l1eMAuA2iOoIBkYDFeKk7xISUA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=i5ZU5VCRVG0DUnnlp3qEs9wGUgDAlkrBZ6w6dd+IZAGmtRaEyYbl6RhokHkl2nlXT
	 YzhUJ2wRcj2driMLqE3N9gwfpehMLRlFcFHKXLtNcdLXRozlb1PtqXfL8jsgkptvUl
	 M9Cr4M8UAqEVK3JxznZ47X4LH4DaT1YJP0JnIK1pRH2iYJSR8aSETBbBJu0jF2Ht3X
	 I7h+BbzkDeheqG9TH9D6CEmMtIvEkHaMLZuHOa8c2T3an0vxIGsooj87YnVo4BCpbM
	 I6ysJZaS3Eedo9HgIsrdD8A4jPcqak3E3f4CTPZm2UeM7TJRRuYnM3o8epgBXFpffR
	 wFmbl/VJdzgQw==
Date: Wed, 17 Jan 2024 05:28:36 +0000
To: Junio C Hamano <gitster@pobox.com>
From: Mohit Marathe <mohitmarathe@proton.me>
Cc: Christian Couder <christian.couder@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>, "britton.kerin@gmail.com" <britton.kerin@gmail.com>, "peff@peff.net" <peff@peff.net>
Subject: Re: [GSoC][RFC] Replace use of atoi() with strtol_i(), as a microproject
Message-ID: <Ec-xbd5ISDrcz8ybM8oJkVEhX7hgEmENoeek1n4K5M9buOfQ1SwOgGqAZRyMnYGYY1AFG1ppUKwXi3V63dndTzAjnJj7Cs0cVrtqwROg6oc=@proton.me>
In-Reply-To: <xmqqa5pdav04.fsf@gitster.g>
References: <OqD4xQ_p-jcftCbAw0ovvrBztfiuoMGcTonCc0i6x7Ziy-hx3uA-Hoz4-3tfRI39KMj-V5OZIGgOe66b1eyX3YrKZNThMYjjMkn6g4-Ww8c=@proton.me> <CAP8UFD1d7FSa=mUzzUA5e3eSEcCVfaymxWewo5GjdDBi4GyE-g@mail.gmail.com> <F6ejgAfr2IMRNR3Tq0CDTHeT9xMWzJ9ley8M_fnSX97ayRNRp_CEgA62WdtOooi9bha1WJPGB53ptJYQFII2lCbIflwgNvbIaefw7nK8w7M=@proton.me> <xmqqa5pdav04.fsf@gitster.g>
Feedback-ID: 95862732:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> A corrupt patch may be getting a nonsense patch-ID with the current
> code and hopefully is not matching other patches that are not
> corrupt, but with such a change, a corrupt patch may not be getting
> any patch-ID and a loop that computes patch-ID for many files and
> try to match them up might need to be rewritten to take the new
> failure case into account.

Are you talking about the loop in `get_one_patchid()`? And how should
the failure case be handled? Should it give a warning or an error?
