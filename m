Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF3D277026
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256394; cv=none; b=SwbQ1ES91Wob/pTMGMuCM4Bwn8iu8LhprhWSIC+sy2IXZe7K+njZXADT71g9AR1CTkAg7EdJh7JUDb6QiI1moZ3iu3lgE73LKEx2qHTpxSsyd5h0zemK4u3on2BD5n1kMVDKCasPxJhBqb6g+ztudXBGhv+wYSGiTsNCXe9Z1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256394; c=relaxed/simple;
	bh=Rje4/JTzuQagMVwNQqOyUHFHrwu9L/ss1j9e3EmXkz0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QS66KNWDt6qyzp7W/R6MXo8TAkBgox+KOa6DkuWy97O/QEH1inBU6ccjMU47ws7y5y6mrw20XNY8jl+2LOA5Ew4lSc5Wjr1LJ+m1YNNrcJzO8hzaMFgL1TB+2XX+dpTIb1xGvLAq2PLXbk7WyEgoDuRUjHsjxvTYIafIpO7I0/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a85U5BZ0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTDK+iX7; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a85U5BZ0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTDK+iX7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD1447A00E2
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 12:59:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Sat, 17 Oct 2026 12:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792256392; x=1792342792; bh=7utc98xgld
	zRl36oWL9A0OtcdLyw0xOPVTaJRFLsAuQ=; b=a85U5BZ0HzrUTzt1ECTk0MlDw9
	q9tt+Yj1Lh46gb6W/DoISUeB0Ky+OfHBpOcug2pKiy6Uuzp1HDbfdxZvkN9chNHO
	qA9okmEmFmknnIPPfhRcuvhJrMyxHxrYa064i4NQWKsLk2woZhMVuA+OsfmNUmLa
	KKlxMsb23O/+L+tUIB16S8YPX4fLiEKYYSraf69wFKBCWaUQog3kZ9S2NH1bzRD7
	XzwokKY7lv0kLGNBdMJIFRBQmw9bXoXTzh6oelkh5UtnCOaroRdUffywPt3XVJjq
	wn7yMDV7aDemilOH2okPqSFlMLd+AFuErxOVqVwbueiqy7FG7Tb8azfVQ9xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792256392; x=1792342792; bh=7utc98xgldzRl36oWL9A0OtcdLyw0xOPVTa
	JRFLsAuQ=; b=mTDK+iX7eQTUG/NUBbXgSKw+gp7+oUbgpHV8BfIb3Acwi7iFVuG
	lUHcNZIYHkpDb/GwPpzKEZXNpFWmm6pyGXwTVOeuOXqUiBhKZs1KfsAYiMguShs9
	uc2TK3M8qhEeHLajxeyxa0DW2sViTPJ8f/ZCBCOcqvuB8mDVmx1apXfSKlXOxJwC
	NQSYuRH9ZsIJxuRxIfc+8If5nYj1GJIKe0Vycn1Bb1Z5VQX9zmm5FRxKT2azDnb5
	vuHl4tUSSHTDQb85H8mqNfrpWGb0cPbPqJFD0VUsaQDxFokY+pjTS6518tv/M8g5
	Mr1oGFRfClE+PwK/dhv7yZZ6jj6n+5/31qQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792256392; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Rru5s3RHzxcA8373y6eGAsGr+I9A4LGsAtQF/FmOlbfm7Iq
	XIRSeTay0r4/7vs/wJZqZ01t4QnD+8/fAmgDAQVuOQuiUm9qJin17e+BvAe1zFNU
	z/m+tOtf+TCQe5eb5TvJ0DXT4gJOMoeyxZjzaDsRLitlrGrdgk3Vbu2pz1P6coYi
	4ii9FPTpsbG8A2wBMX/boz5lbHvpfb2QJ8IKwA/lZ1mUQReUESrTau3LRzSHGHAv
	jHQU1+AGPesm0TU88zLgxGuM46ZGJR+pUZ0AnJoOa8MYfWFENEQ9Edgh+o7IlWJ7
	f0Rd+pSUJozLJ+T7umzRgW8P5Z96mXhB2xp+9YQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aRKM7vsFkm6pXoluVGj0vQbV/HP1qBTM8zg4/C/wrYk=:Rje4/JTzuQagMVwNQqOyUHFHrwu9L/ss1j9e3EmXkz0=;
X-ME-Sender: <xms:iKnTankrdMJJekQx70XuW-VcsVcRpZZSTe9b9jcy315nNk0ZKrR8sQ>
    <xme:iKnTauh5giNjLdNbNymM6y3AMg6qRu0HbY7Of2htm-jeXf-fzmysOfQbMdK89zuX8
    5e7lNBaDhoO5aNrL-YIk2vVBBoJmT8FDIA_LG2V9Vy_mdMba0AI>
X-ME-Received: <xmr:iKnTaneytzKwUo0Ox1wbfPbo4hIJ4ozJzw09GIbR-RvOQypO2bdxbXP7vNCWUInbfy-kTbQzUnokkpL1-9kU-HSgsVVsJ1vUAJ63>
X-ME-Proxy-Cause: dmFkZTEst3DkLEcx88AwKjHnw9XRHYFCwKuyasI31hL1NUwS8anKejOVDJTb7oH7AMKeKG
    SQ1z2RLSkifxaD/Flzs3u9cGDtwCzUGtP7Uzs0AsZ2g78dX6EV5Gjr5ytJZLDhExA8krjf
    o7bz3lwthVRNh84DpFZJlIWwUEyXX+VvWmCZwrOeYV7nCTNcwFWR5UVXqvmBt55km4L8QJ
    hvXJLjnXSgUyDLR4eDLzgxLLPvcXpKbV66IwyFtN+K+2y9Ql56Ta1BP8APWlJCNPG4KnXp
    nVJBR2lM5yMtl92ZMGh86DYnJZ1cqjz0h6K8D1JPFk2czqOx8Ooy/Qb+TIxNQaJoMwJBbs
    vQUj+rsq1KFVE79B3GIzY5m6CRoEDVZphcNM+NBV47XYhzVNjiSlJMpKb5vDVAPOO7GfmE
    vcmHbuXz1t2RkLGW6MYzp1SBjUZWxZuiNbOmwvKLvRid3dp1DO+qdt1LwwWCEQL7dsfIiO
    D9CWnAXMMB0nPXa+WObEDxjUEmW90udPV6jjuqm7pYqLzLNlQZyEwZoD7Xr3dlbSm6aWuZ
    u23R65YJzF1ztgK/e/VF2NfTybVhLILM9M7g6/QfYtaK9ciUqvjlpuAOgyjeyZPZjgOPCr
    VS18uOr09zSAOAKQ+2dJkLGplnuZXgtj3yE3Io2YrxsndB5UJ/3TXb1fIMBg
X-ME-Proxy: <xmx:iKnTamhWLz5DuKNY22NtLc2v2zNIepojJ-38bziWPyKQOHrLksFtlg>
    <xmx:iKnTanwJH0BHmzw6fhw8cywctBg_G6QIGjoeVydKMGcwKIsPHFcxOw>
    <xmx:iKnTaqOQPAWw2RlARC0QPYEaymxW4gy9ml5DR0fG2hUnW9XAIwvo2w>
    <xmx:iKnTagV-CGMpnRbIZh6QnJrvqGoNbUhyAX7HLTiY_lGIkOd9RA-14w>
    <xmx:iKnTavhUPYfXT6YylSzsKVLT-iZgCqmI6U4dptk-bVHE4V52xjnJEHUz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Oct 2026 12:59:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,  Bence =?utf-8?B?Q3PDs2vDoXM=?=
 <bence.csokas@arm.com>,  git@vger.kernel.org,  "Jeff King" <peff@peff.net>
Subject: Re: [Bug] Porcelain allows creation of '@' branch
In-Reply-To: <3d9463a2-d099-4f9d-a380-4c5036da1c20@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Sat, 17 Oct 2026 18:43:05 +0200")
References: <4e8d8b75-ddf4-4602-a2a8-26e5214c65f0@arm.com>
	<CALnO6CCph_xC394v_BetLPyoriYc9dLZY42LsXhjVNdvt2e-cQ@mail.gmail.com>
	<958622c0-e0a5-4e27-9815-cd1fff2ed111@app.fastmail.com>
	<2006115b-bcf2-486a-ac7a-681caae686b4@arm.com>
	<fc3de093-a051-415c-b40e-f9df5c914704@arm.com>
	<xmqq4ielirpr.fsf@gitster.g>
	<CALnO6CA7vxpmhVB3pi3gpVcbtCS_yHtA+a1Ud25P00JDAqboAA@mail.gmail.com>
	<d7450b0c-89ad-4963-9229-198f40cf72c1@app.fastmail.com>
	<xmqqh5ilfpfj.fsf@gitster.g>
	<3d9463a2-d099-4f9d-a380-4c5036da1c20@app.fastmail.com>
Date: Sat, 17 Oct 2026 09:59:50 -0700
Message-ID: <xmqqbj8sb6ux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> It replaces my want to use `@` which means that what you wrote
> back then:[1]
>
> JCH> I suspect that it is much more productive to deprecate and remove
> JCH> "@" that is a built-in synomym for HEAD (but "refs/remotes/origin/@"
> JCH> does not act as a synonym for "refs/remotes/origin/HEAD"). [...]
>
> Would not affect me. (Not that I believe that it would happen.)

I do not think it would happen, either.  There are many things in
Git that I have publicly said are poorly designed, but that we
cannot correct due to heavy inertia.
