Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4F414A17
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375385; cv=none; b=Lx1aVmhB4kD5td7l42/JCVB4voRCcwgWROfaWFLn66IqI9zLYL349JRyjVKEvGMaavbbkPC6yqNwmiLvlnnfmBy2TvDKuIYCYbOipHksKUP5xWNUxVoOHp6EkjUGIjY6OSpy7YGCz3BhQF7aMctE4nNd6eJ3NELWQ4pkGXjemF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375385; c=relaxed/simple;
	bh=F2iNWmC3lB/w7037Lv2gcu2tXjkRD6HwHTKD+d6kB/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eFviD8TjAi0Vqw/UV63eEZWnlScyLbrraSSeAwHaTE1KBDmCljfJ4PqRyevLZH7qegeLv8JdRRxP5eFsrDGmt3Fi/UDxH4nH9yNuF0vP+KoTdjl7nuvGxE2OXkmK2RSGywqzpryf2i1hsvgb3/GGFhyP34H/qxmoJ64qgY8mrus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ypy5kOjO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llpKZg/w; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ypy5kOjO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llpKZg/w"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 13A4B7A01A4;
	Mon, 10 Aug 2026 11:23:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Aug 2026 11:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786375381; x=1786461781; bh=UXCSbUjv/I
	GeIL1r41XwjMADFZXrr0sTlE6s07iyxaM=; b=Ypy5kOjOlPm9Hw9FVb6kRvt3Fw
	+8jKVtpEYKQqlBBduKTAy/mfZWx0w1ccK+iL1KoHZEI/Z/t+K7PsuAbqU1RoRP17
	4nn8Nqxcobdr2qqEzDaeAaHbEeVQfQamvo22PcDFbe9yKvtflBJFXVMk6pevNyFJ
	a2+sCQzs5pvj9HCRBe5r0pwTxLskxCawSk08oPFSJxULhy/9vbyIjAoZyjTp5BwW
	sdM5g3KngB2BDDaPpJwcDG8Mp7sYKnFvch2awMn9OKZEX1niaPKZxsqazU1limuj
	kaIFF8sRHl4S9hfD1mqoSmf47TXAkoCnV5pUltIGyTug0YK4lD91w5b2qVEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786375381; x=1786461781; bh=UXCSbUjv/IGeIL1r41XwjMADFZXrr0sTlE6
	s07iyxaM=; b=llpKZg/w7Z7voNEf6Fl4brV7UWFH4c/RXTi9MQj6i544M88Erbv
	mylAKFvSoNgz0cRGmvfxQkH1wdzi459HNmxFpHp4jAoXSGZD/q7nIAOhsS/kQPcd
	wAHbCnlcPReX7YN5K+aWSkw+pBL7ddJFbTOjqmslcAeRATYYbJPeYwCZ6kr18SW8
	fSlPPYWDnPx+BKQThSfsvuTSic83UuZlHS9EVW7Fy9zEx8wcIXnRFjqAZXhzP6pV
	lXFtR6DakUZNuXfF74FcdIxrJvzOWnHveiGniGfOs2L0e/SvCqSFumGD9fWc0+d4
	bsciA0dNhMzgbaOdJfduhD4CGoQNNCg/U7g==
X-ME-Sender: <xms:1ex5anfraBOpWHea3KJ74Gwjh8tD7PW6RbCkSwaPryJiXAGWMdAaMw>
    <xme:1ex5aqwHMbagy7kexJe4VKExMTjN5E1u2J12ASctsNCgRLBoCzuxq1x9ICm3f5tHZ
    jIooQ6g2FHTNeBdvV1t1Y2h73xyjE-gbJZdnH_82h4Az7ylq7xh_uI>
X-ME-Received: <xmr:1ex5am86BGmKvvxwofJKN48yubkDIOleOr75Xa9zOkP-t7vaisRZxJBWMpQKddJhnUecN2nS9lEdVbXUbnkGU__n5qnbZzqVDg>
X-ME-Proxy-Cause: dmFkZTEjt0ixz/4WYr1KqQcIgRfZ2Z+4sGmFO6Ndkb54n6KwFkOyzG/b0hjpCNu4UVz5oB
    eoyjcqSk/Lvo5yjIrJFqgQIn6yMGW+BkHHf5znBFrDZ8wD/B2wxXOETy/847i/yrgIbcQq
    MnzUEwq4dWx0CR9twSE2GHTYloaCIKqbPC96KEOZxGBX1Ln5M+aNUzo6EKzm1dznQEooi1
    /H7JnTUazFm2HtfcUIWyeWEci3eCo0v9fsGLwsbersULhyDj6LgWFIDFPcWo6+XxakEEts
    Ff7C/1I9/ofoWqtfgzyQHflxkOIoh2Wfm3bQvbZOt3qhwVR/QXhKqS0KW26vEqv66GmhPC
    PxAHD6tG/arOWYoMyNb4qVKS1tncm6wCFnXjuG2cqp+yseuGLsaqJtUGIqFNG6i+wBOebr
    Rcl3u13eRi+ZtACBOSwNWxv8m1GvSlWfuiK9G3Blsm/7VCEq4KXHtjQv2IRRGaA4gaorOk
    nxTjhiMItgMG/ghrXCvP0Pfj1K3dx8w+057iNq9Wh6ZWarLUo46sPmcCztSHFKE86kn0F4
    HGzVU9PTHcF4xXQGsEEWM5ypORp7QfnFS3E0TIArtELGhzByZgFooCqBYiKo35Pdonsfap
    7sG4plXiljnoxhPfm2OlMs2Jwc9//eKgFFSAGX8a/zwU4OpTKPHi7DXWv7vQ
X-ME-Proxy: <xmx:1ex5aqhvVev4kXvGhksffCXk_hPb6KW5x-8DPi_te10GDOAjl15EJA>
    <xmx:1ex5alHa3uatVUHOIuxkDXsbNxa42jURa2sF6t5ZgllBEimbfSfZNw>
    <xmx:1ex5ah8WjnkEjXfZcBubx29qG5PjzfGKJLoG3RPVtB3_i6Ov0SdV0g>
    <xmx:1ex5akxAXD7mHsdYCg_bBHJGUJflOqXNkxnO4ch8Cvvo1KGYliuXgA>
    <xmx:1ex5ard0UHgbwZ3BHE-T0xuVTNWJcZ1StCoijlGKkcpI7MZ6itWfjg2->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Aug 2026 11:23:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>,
  "schacon@gmail.com" <schacon@gmail.com>
Subject: Re: Can we do better than "git checkout/add -p"
In-Reply-To: <26c2f7e0-03ef-4c45-8175-adcc2e0395ac@haller-berlin.de> (Stefan
	Haller's message of "Mon, 10 Aug 2026 09:26:55 +0200")
References: <xmqq8q6ih924.fsf@gitster.g>
	<CALnO6CBu8ZBDk9YwLW2jVJtBUk1=pvai5QHiLN6XLOOL-3KA=g@mail.gmail.com>
	<xmqqfr0qexps.fsf@gitster.g> <anlpmNSjBUJ8p9RL@pks.im>
	<26c2f7e0-03ef-4c45-8175-adcc2e0395ac@haller-berlin.de>
Date: Mon, 10 Aug 2026 08:23:00 -0700
Message-ID: <xmqqldae6luz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Stefan Haller <lists@haller-berlin.de> writes:

> On 10.08.26 08:03, Patrick Steinhardt wrote:
>> I've been playing around with the thought of introducing ncurses-based
>> interfaces into Git. I've been mostly thinking about git-history(1) here
>> so that you can just move commits around, squash them together, drop
>> them and so on. But I think fancy stuff like TUIs can also be applied to
>> other parts of Git, as well, to make things a bit more visual to our
>> users and, as a consequence, easier to use.
>
> That sounds a whole lot like lazygit to me [1]; it does all those things
> in a rather intuitive way, including Junio's original use case of
> selecting a hunk and staging or discarding it.
>
> Is it really worth adding such functionality to core git? I like the
> idea of tools specializing on what they do well; core git on providing
> the core functionality, GUI tools on presenting it in a UI.
>
> [1] https://github.com/jesseduffield/lazygit

My philosophy has always been "do not compete with your customer".

If we add an officially sanctioned XYZ to 'git-core', it would hold
an undue advantage over tools built on 'git-core' that perform the
same task, not because ours is implemented better but merely
because it comes bundled with 'git-core'.  I do not want that.

An exception is when our XYZ is truly of "we wish someone had
written something better that offers functionality like this"
quality, serving as a "usable but perhaps not pretty" demonstration.

Thanks.
