Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A013D5259
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 20:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792356943; cv=none; b=eiiXvHGWV5Csi5krIM1AD+IVe+CVCd+Kd7gCNbBhJ0Uu5v4qEUsqp7r07PlQKy3DbQkx3OyaBKQ5pgHXqzfafj/SrI3DsCEj3aIhpCNKFRdFadXWXoV3/aI4rF6nHoc4EuZ8F2uNdeO8hRmjHbOwHfcTqNafQ9biKlE+a9a9sfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792356943; c=relaxed/simple;
	bh=ZXRxeJlr68Rndmk5bl3XkEqTJE5qPzjmpVjvT1Kp5kY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nn4JbWMTTZqa6ppDEScr01heYm350ckBr2X2RTMXv9UC2EbUJog7A2NIIBz9ifswrRUng6peh2Rl4jmdfgVc5y5ftqBMeNLuN7l9f5CjsUZfX4Tllekcp/k+aEn75nO1eBq0dte3c4Z0PkIOP3F87rgf67J+VCdxsrkvlC4ok6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HqIEeMZE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=egCXyu6+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HqIEeMZE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="egCXyu6+"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B5986EC0125
	for <git@vger.kernel.org>; Sun, 18 Oct 2026 16:55:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 18 Oct 2026 16:55:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792356940; x=1792443340; bh=j6tQaSN+cR
	kqY+uK5C0NiR0SOvjYcy83+Ph3pcEPKPs=; b=HqIEeMZEjPleo2d7i80Wex1Udn
	Kwnqewfpj7yzmGLAL1tjTfbn0P3HyLhykhDoXz2inmJwvlQ5wYe3jWVmvwV8M4Ju
	hTKueUr3RVUcYw3ze7n2aKoCNtpmv1HA8+Gyh7wikwlN+6A58rSBwEaXzFvzqkIH
	b/6uvHInRXi8xVwFFn2n89g8qac82ducnHoJncvQgdR4RcdI9PQH8joyf6Qu6X4T
	x3WbeiSaJgiO94R46B71WUePI82DcVu8goAmVDWVWO4UjizEUpl8q8sjRIvbQ5o8
	3wh4MEbw1Cm43jKmK4DW9JHqlcv45FIIxXt8A4nCHD1SADJ82hldRE7eXRfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792356940; x=1792443340; bh=j6tQaSN+cRkqY+uK5C0NiR0SOvjYcy83+Ph
	3pcEPKPs=; b=egCXyu6+8CJmlO8sjfienGX+m3jz1h3h6nGZWVSZ8Hf3+NGjjxr
	+S1HnLk0ch9RIiEYIBwB/VBgcn0mSXC71Spk+8BdOQhKL17n4fdN7fSFB0pe1M0g
	F1WRipQaVyHIxvP97YYf6EhP1NJyUCfH4qK8B55oLJDHe/4GDeohou5uIZowGW9v
	n/u4cuzIwOd83dIqf84sbpyuzUd7BY539LE1aP7XNV8ZUnKA/auuGLCMj+8e9Ssm
	Gpwl+0MJzDGeetc6tKBPrZj6XmQI4ikXwNabOMgeJ7iZ3dQq0aKvJWdC2wJ6Slt9
	sNg7Xp/BZrfjewj77uFBSfHN1QGUazLHavg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792356940; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:L2nBW1KrfZrXnSMN3F5WOEzkOgdlh/I5oE0KCK2lC+whZv2
	WlQ75BDdTuQKTduRvMsozxYJjXe4hF8HNH+tIJLwWEcscLYVK208akaA+0He98Ue
	1FeR32EqSMTH8g+wr/7w+dAtFLO/8U20UgRRuuVkQBEa0pkgGxhKHZKCvGuLPCl4
	52ulwSX/3D2Qkhby8hxY2ogN3JWb/3xfPhef4C7pbqixpunn3VtiQ2QiBrc1R/eH
	0QZUhTBMUf+XZUDnew/qBsC8NnqRCv58S3ut378nDyeAD7edqyEjOzytRsdDTK30
	LgXXQtXTDtsBB/qRR51DtRTbdvTAq9CzJAe1Psw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:65JWOtd6D7bZRQxCgiFk0PzNm/6tibMz2hTCzkGRm9U=:ZXRxeJlr68Rndmk5bl3XkEqTJE5qPzjmpVjvT1Kp5kY=;
X-ME-Sender: <xms:TDLVavduC12QZFRDt93Ogkc3k_xa5kR6qNwuJUYq7FddHwJaq2wjCw>
    <xme:TDLVao5qtViGHKa87bKJj8Xiua6MXz8LCSRofJMf9v75xVaL-I44J4ZlKlQ5ZA6qU
    TQ1kD9rmP6hhz-FGyqG-17RGyMcrIsaKQxldCRSD7sUFtSMW3_G7Yk>
X-ME-Received: <xmr:TDLVaiVNpWpnKp5efkXw8jbtwmWDrd7sFIevGmeCwqHbqIqT9EuCMTaIBjjOMPfDoMppfMe8y27jkWZl-sMC3jrqC3kPHhf74ALo>
X-ME-Proxy-Cause: dmFkZTGN2N06yIm17DekHiCsDRenJejAlqgheVu/4vNecMHZrfLQpqJqxlAjNLjnrqGgQ5
    2PrNsBkvKJE0HLYchu+czFVP6OskB86oBRDpFVd/F85hUBRegPyiwfwgSCbWKrCYhoxogy
    oB+f3PxkhrWnjPirosCu3TupRpZdG5biFJfCtc19/rsbPOO9f1YtbYCApKFjKOZEy3mc/E
    tuUk5PzOOJ9cn/xtw3sqbkAqULLgoxxcbqdP1s+jEtJVWjz4ctCpmTDrM8wYefn/jBdKaH
    AIseok1UVki/rSQT2WRUQCVdXONo9YDmOtmK/CeU/cNw0Q9nacew4nd7Li1K+A2Z8+1lMW
    U8B5mAEwwr8RoEPR2nFwIHMNZbEjXYUq3neVr7DeAH5bwC0bWcOos/qESJ/SmTtEE6oaN4
    pNXhtM7/YFvA4NKDv0wlaYtkWALN5G+nJjC0yVN9xoiEwravWANwQlj4IdUUoJciKh97BX
    ZJYTTRsZ54eTNKS/HVFTgOyI1t0OQVqpYUuYtAyb7iAr79ty1szljXA4Izw7FdJQDVOPde
    zw1PwvM68YkTLNn/zrobSl6DcwxCk59EQ0MsjSE+2eirYPPI7RnTfipt7Y/71izgAS2XfL
    BMUoJwaDqkYChUznvVT6c8kDa656cjnIb8A1+pl6OrhV9OE+KP5+IG/+6LHg
X-ME-Proxy: <xmx:TDLVan6GugNv7uAGZVQfxDXNAcylaoI-1MHHPdgWmWmfuBMwpew6xg>
    <xmx:TDLVatpG3tGAPdLqFTsCbZwTH0bC9rs-lO2TsPpTjX7yBNUKH2Mjxg>
    <xmx:TDLVaqkldPs_zpbvIQJ4CcJ0TuBolUokJRLwGoL4JNUSiJlSYgNLyg>
    <xmx:TDLVapNVHr5VlFHZOTi0djdZ-mIC8Arj2AfPwBPdK3jgiBPj3-VZzw>
    <xmx:TDLVaoA_mS2gvX1P8LnHe39s-zdgGguqMHpPol5ao5yHyzkrwTff8-NU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 16:55:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: kerylefondji7@gmail.com,  git@vger.kernel.org,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com
Subject: Re: [Outreachy][PATCH v3] builtin/var: refactor to use
 parse-options API
In-Reply-To: <e7719810-0e47-4031-a35a-9e1fd5727be4@gmail.com> (Phillip Wood's
	message of "Sun, 18 Oct 2026 16:09:15 +0100")
References: <20261018145222.579-1-kerylefondji7@gmail.com>
	<e7719810-0e47-4031-a35a-9e1fd5727be4@gmail.com>
Date: Sun, 18 Oct 2026 13:55:38 -0700
Message-ID: <xmqqecdmafud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... In many ways the main point of a 
> microproject is to get candidates familiar with sending patches to the 
> mailing list and interacting with reviewers.

Thanks for highlighting this important point.  Highly appreciated.
