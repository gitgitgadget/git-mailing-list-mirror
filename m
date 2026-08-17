Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616FB222597
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981011; cv=none; b=VaMwMR3WWWVyW2eMVhrYRSuZ6j9DpwMr6Zsqrh6Iiz/dnIDGaOdxyWHVxwicffgrR/Qt0MOON8UfVkKlQkvYpcKpTUHpeI/H6/GQwJULwZzfnb6MuvKbglnWF5rYIsd2RAYdJ7mQup/LtfkOw3DjBPQC4L3OVC2lZwGI8UZ+qlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981011; c=relaxed/simple;
	bh=WSfhU0eUiH+YTge7CjWm8lyJNBtNpUaL8HKo2cpj9/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fHRorqiSUtWVmM6PYihZc9nUuVPWZ0DXG7eq4o6aZeCOStdKdpgVT2K5jeO6iWhyQu0e7h3WG0fWmm61xBwkJCbpQ3dI9cvM55UsacyeD7Xz4n31EstYHtgWQKutsrAcKFsEEpvxz9kN2c5SINbuo739XkXvqMIVyy4VfzE5EpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bNhG6wa0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aTlrqZM6; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bNhG6wa0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aTlrqZM6"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 8F178EC023B;
	Mon, 17 Aug 2026 11:36:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 17 Aug 2026 11:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786981009; x=1787067409; bh=YjNfOg6qaO
	Eox70Mw4zNC7cTUcKqq9CiIzYSbVj1pm4=; b=bNhG6wa01TftfCNOjGrbyTF+AN
	oNrzxFpVsp6XIARc3HDoWRXkKFTI5R+N6rYNIt13JyNqL5lr9owDT3zUBgh5ubv3
	OFA+ZQc9Bx8L+sQGeS2JQsyHkyDNcCboNF/yVVAvxehthg31tgDjoIMhwrPW0ydA
	8vXFhLayOKlNhldW3duBeOtdWZ+Do2qbFJQZt/ej0JQ3DN6RvaOQ6Ftsum2+D0wK
	UKf+rwE8NL6zEF9H+Rer79hqDr/fERx13A3FkjtwuxyFkWv2AOvGnaIo8hdNk1Xv
	p5tOpUQVrlJi+7e2Fh0vmefinpE8yk3w5kSFaA/Sl4XwYXORcwLa4rrCqDGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786981009; x=1787067409; bh=YjNfOg6qaOEox70Mw4zNC7cTUcKqq9CiIzY
	SbVj1pm4=; b=aTlrqZM6ba/Cu2CDL/Y6clCCA/frW+pg4rEWGGHCh4a6gEEVQwe
	GKkWHUEdIScy37eElShRoHAweVFrRDt+1+cavh06oPE1uR0+JPseKrkKrb3ZnZOp
	6VdBvSg0Lj1aHxwZvWMIFVakXGdK+Ol8kibFMvepaP3EMEaCnyR4h6ilvdIO85hp
	eePKNoMycyayOY5okijCgJReIK58nV1rXzFLiEFmln9SjNoj02LPdhwpKX2tsdPj
	rWSrBfeF9cpLzkrZccfaXlqtNA3aNHnCnPRBcN+RF0vQTk9sSSYYD2c/yazI3egD
	15OqI/mqy4poYP5mr1qpIuPfT22+lwmcrQg==
X-ME-Sender: <xms:kSqDaiYxa7IjkwZ3ArblZgZGXqBcCN4C1quXloaNK7GKmuryppLYtg>
    <xme:kSqDan_xh7tW0mRbwY-XEYMV3oO84FilnXVielV3vb5hxlObwfTYF1eoQFrMeuhzu
    -CGa9IH6e2g2CT5TKEo5RHNLc_RZFnXbCxiRt891anZil0KXV8s0x4>
X-ME-Received: <xmr:kSqDagnCC0bDGHJ3J0Q9VVRFnhnG5gCAXDaSYoC00LiUNp5LN9T1xun4kNfoyuW7aXUQBj-NaZ-ngZfwdsdA0xuGOVoy9hVx_Q>
X-ME-Proxy-Cause: dmFkZTGz/OCYCOhiuwK1CYo1/DQ7nmS2n2+tc5K+qyfKEvG5QegHtuHtRBS3ZfZVM85uDn
    IG7gbyxL91S1N/3vX2JUrza967nSzWa3O5MWERbmdCm9yy33fn9U2igNDdDBIm4/FN6zKp
    WuqCJo9Qr1Rwmw4nh5+O7hkRO8lCLVvKEjpgMEEEv2yQxYh7tXK4NLjqmfi+uauapPt7vb
    eEqTJJi0fYs2aYNCikW1ntiFymYpMSZRxDUuSvG6HYysaW+ygDWMR8UbDh5K1E1CBhBr1y
    YidsB58A8OayyCTaUD02SsKXdD62HkCyufZfWFMp3SDNG8AtuvmTXd3rfVkyjOB58iHZEZ
    6yqH2utuK590Ann6P48MDNmTD/3PpFXqeCg3bfHCInOCL6KcpE10BTf4Iw0XuxAe5bclj4
    DfKeLymKwfR3pxAZYCPIKb/cu2yxxQcu3b6tvGeZ6ZDGTntr1dQAQe+52qUGWxVMimlorM
    xbw8nbeonEL7JF4hZBkHWJrE1GVnH4Ucn6B6kc3k1Mex31g2POOll3HOIOcHP5uMhR7dJj
    2i+/31toyD/dRAdLmh2RyLnz1pYAuUsIAoxgtWi6RpeQJtN4SfhHwlQ0ROloFL9CPXiHSS
    bryF55CZKgqn2ieGVg0niWsPCOwFfWgLsFX0WV40r/LNmIpS3U0JGxcbzAIg
X-ME-Proxy: <xmx:kSqDakxpLh8XOJezwK-kE9bv4a1DVMjVPgdl_Y1RYcKBcbljTqSFTA>
    <xmx:kSqDai5N7XRwhle0GR6fKW81ua6qMi5jiReyZafu5JcJ8uq_vkZIVA>
    <xmx:kSqDasXmahg_pWPf2OriFs5i4SHaNFBaVLPsyAEOoE0bWN62qr9b9w>
    <xmx:kSqDaiI8fM0yKJ3OPy2s6aYI3A4ZhknSmVRc9rf_UNOOtxjUI_SPIA>
    <xmx:kSqDaqifRUGozBm907zlPURVixsTTcW2UCqCHBJ0BxJuOWe6VRWBIqAJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 11:36:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Matt Hunter <m@lfurio.us>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Harald Nordgren
 <haraldnordgren@gmail.com>
Subject: Re: [PATCH v13 7/8] history: create squashed commits without editing
In-Reply-To: <f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com> (Phillip Wood's
	message of "Mon, 17 Aug 2026 09:26:43 +0100")
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
	<pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
	<8b3551d0d4ecb360775ea29507ee262c7bf9cd42.1786088371.git.gitgitgadget@gmail.com>
	<xmqq4igyszeb.fsf@gitster.g>
	<f34669ad-9157-4f13-a3c1-c0abbc660497@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Mon, 17 Aug 2026 08:36:47 -0700
Message-ID: <xmqq5x187o8g.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've just had a quick look at that other thread, it would be more 
> convincing to me if there was some explanation of the security issues 
> that accepting uppercase object ids causes. While I appreciate brian may 
> not be able to talk about specific vulnerabilities in particular 
> products, it would help to outline the security issues in general terms.

In any case, I do not see any reason to use istarts_with() in the
patch to deliberately allow upppercase hexadecimal.  It is not like
there is an existing machinery that has generated uppercase
hexadecimal for a long time and we need to support their output, or
anything like that.
