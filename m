Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D340747FB0C
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246976; cv=none; b=D4UKWopNsGZ9LuiwIhBwWNMbsX7zb74sFflOwrFVQMLtnCd6RJ5LgFvpDRaOJPTbUqGuy3QEybixdY5m0i6EUAukBBUeqyXMA2yoxM/XWx8y70/Mi3MTCIrIsCDEnz/ri9npzzHnNVcjEhgJoBpvOfZ6/5NxIFvYLsMY6FSKt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246976; c=relaxed/simple;
	bh=J/xw6C1ZDLP02pGJ0SomalnQlTT9D9NniRYKkVxdVY8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=MCNj8q5hTMKPIx4FUcszK9TbaQwxSmNhGnk+fcgmQePwlYYx0+tH6K5g3YYu6+h0LvjFs1dfoZa8iPEdebeIKFxs7oY/KWwUyOii3dMR4Lkb/hlke4cD7w2FbGlkW4jaQKuIfRwaZD7t2Uffl4JHxP3dN/eHeM2wbk6x6xfgPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AjJdkFHa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BzNkZ2MD; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AjJdkFHa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BzNkZ2MD"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C16E1D000E9;
	Thu, 20 Aug 2026 13:29:33 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Thu, 20 Aug 2026 13:29:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787246972;
	 x=1787333372; bh=J/xw6C1ZDLP02pGJ0SomalnQlTT9D9NniRYKkVxdVY8=; b=
	AjJdkFHa7K0sKL4wPw9//5cbeiKyxXxNCR5a8jVAVE6CpO9TnhDzFRZDGCXKiUzO
	YR6WMD4Hm9qxUIn/qC9ICGCyuNcrfBniKM4ZWdL7zfjYFeYYNSeROaJSiRDVlYrl
	Bi7yCw1BZtFOWXl0ZdRnpW/pM3UsZoHZJ+sDJMrnE2enSnzBBWvqzljXIRxm3+PA
	NY/umJ8wN3tKC/OcYo3aAE7uO/UotP8tmhQ+/qrv6m0gKjg5/5bnmAzt5o8rOaHa
	jQ26a5ZXwvHCAdN3I5y4K34iB7WigIqnHPYfNZ8fJcm6y3OUENZYxQz4p7RmqDj4
	bqQgo/ntzkFtFCLKNVUJtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787246972; x=
	1787333372; bh=J/xw6C1ZDLP02pGJ0SomalnQlTT9D9NniRYKkVxdVY8=; b=B
	zNkZ2MDA3A/oNm/PwJtZJs4D7pMWe27QJM66fO2RyBPZfSPD2PNtj6JA3ZTbLwMR
	g1+LNhcbJjZi94lSOOHuN/28RsrIhezbcfULDj4VNGZ+5ywj8zKmSZxLqQaDwkzt
	FPdgehoEhlfRLWlKqMVSDXZn33hBLbO49pH3yqJx2fEgtCVwKWOsfd169qpEu/Q4
	hChl9dWH02aGRgcKfAgbnhAbRhGF3Y1a0ttf1HKSzt13tK1GbX4rlIEw3/7k6/Q/
	xqkyIyTi0QKhnabHygUCKBYPRmCzk2BbnfyfByl8pDb3GE9m4BSvdnN5/ik5QC+8
	Br1O8SWe5gUfF3pjroGvg==
X-ME-Sender: <xms:eDmHah1PmWFp8qQ8aSv-JLExa3AWTSjuvJNa2dmr0W2mt9pIjHIsOtQ>
    <xme:eDmHai6RpTu67dI_QP7gySwHwBFG9UMinEM8DPfztArHFQLoP6OqloBnQaZNi3OAe
    s8MY658nlsfuOJBRtiGyQimcCRdaCjP8gbOwmWwheF-i05kq7SrxwI>
X-ME-Proxy-Cause: dmFkZTEMHFixRkzHAcDSij1mYABGLHh2QCAQCy4IQ22kairEbSvVfGqqQ2sDJXvoFJY8h2
    StogkYt93BDsQjO6uLXIIzm/TsQgyIWQjpFSockDloTbboBiVboFJLDu2yZXYIRoAbNMuv
    luMjEdeTnbavmXtpJrn5L9Ih0XX23DmcWUREgpE+hvxvwJAvGSrXt9AhAxcQF2FD/JmjOD
    lQjvc2ptbaqGYP4S8kDO9nS1xQPDN2pG116M3sM8tVItt7nMhKsjgUULHGpUu17XDQ3NZt
    Rnz1E8Cq2AkDQUmICiduxcAzuJlLgy9bWU74+OJKSPW/GUPOVhf0FiTu2Ytgzf+q4BCUDZ
    zqJaAnZu3kI/Ml+FC3jF6D/pc/L6OnvO1yYgpQJjh4qBgKEPEWV0aIIoL2LTQcheYMthhA
    7cI8qJCeDE/6T1Lj4O2hYk+2klXZYUBuqJZ7cze1SCHgUtguGDBuMBQa5a1hliYsoQXXFy
    AtAq/pXHlaOKe9s+lApjTPXMtVKJXBDCrvz9sEQ7y+ob3+6mfaJK9mb1SUPp+Mv2VZPIGN
    FinIGusk4p6O6/UzfW/20jnw03jP1iCtaraJJmAR9ZyUC75+7yP3CKA0qVo+j4oOApATfa
    +viLWo7raKmoUtVK+X1onKlTL/Sq/mvWCk1cjHqsrCMBIVVwkr6OhoBCzGpw
X-ME-Proxy: <xmx:ejmHavh8-az1jS-Ykz4OHCdv1cd9LL8Xic1Xr3smK2jryJwVY1KlOw>
    <xmx:ejmHalV1DvUIdrlLCdormI2OC4RLynSmL_3LIxjx6ohkuasZ0Oohuw>
    <xmx:ejmHamUiZJvs1ovV1D_DxonD_kEW7Bz4f_ExnbPDgzPlM_8UCleojg>
    <xmx:ejmHatiB1frQKmhRqDjf3rTPMN30j5lFpOHA1onugkr6GOPQF_SRrQ>
    <xmx:fDmHath5fVSkjCPQX5rLFJ5NP3byfcGKV5Qjpdkw24gwIu_XAlGHBJXH>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 9F44422C0078; Thu, 20 Aug 2026 13:29:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ADgZb2__UmLc
Date: Thu, 20 Aug 2026 19:29:08 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Artur Bieniek" <abieniek@antmicro.com>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Phillip Wood" <phillip.wood123@gmail.com>
Cc: "Koji Nakamaru" <gitgitgadget@gmail.com>, git@vger.kernel.org,
 "Artur Bieniek" <ar2rekb@gmail.com>
Message-Id: <fa62cf90-61ae-4352-b823-455ccffe403a@app.fastmail.com>
In-Reply-To: <2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com>
References: <pull.2384.git.git.1787052873141.gitgitgadget@gmail.com>
 <xmqqwltn1o4e.fsf@gitster.g> <0c2607e2-16da-4efd-879f-82ef2c2aa127@gmail.com>
 <xmqqo6ewsrzd.fsf@gitster.g>
 <2b9cc581-7c8e-4cb3-9524-2b466209ac7e@antmicro.com>
Subject: Re: [PATCH] pull: add --hard mode
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026, at 18:43, Artur Bieniek wrote:
> One case where --ff-only does not seem to cover that audience is when
> the upstream branch itself is rewritten.
>
> For example, a checkout may contain no local development at all and on=
ly
> be used to track the latest state of an upstream branch, but if that
> branch is rebased or otherwise force-updated, git pull --ff-only will
> refuse to update it because the histories have diverged.

I don=E2=80=99t understand what you need a branch for in that case. I ju=
st use
the remote-tracking branch in that case (`origin/main` e.g.).

PS: Bottom posting is strongly preferred on this list.

> ...
