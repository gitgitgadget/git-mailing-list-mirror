Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441204C4F69
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790606531; cv=none; b=c7/4+DztWZEZr+BGXWqwkrk8mphgtmGu/ZEC1fEVuzjxyFqPTIl7OBmfyzAvQ89jR/cXVYOpgPYxEGwiYCjsA7qWYkz8ksxxVI/6QjXzkxn2nosIboDE3+stKWRwdWOQJqkL5A3gEWSLgwvxfu+DwqJXMnJDguWPbl5YSwfYv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790606531; c=relaxed/simple;
	bh=f0Tl9S5Ory6Nzj5zhiQSnusDmOBbjTYIlgmaEcsCEo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M1ZFgfGK696wBgjIdEzumI3dlT0mi1mrV5RSKdWj8lE+ApXtvlQ+rSc+0SbhA3xcU1+wkLBBfOrc9OI12hqebWYF+F3SU8Bqp0xjGLGGaVSok8S0Nm/WulVUUyWpxjUF+ElTVykCBKNlEHH2pkyjPRp/cZmA3in1IJ018BADryE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V836AjjI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+54zJb2; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V836AjjI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+54zJb2"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 02246EC0196;
	Mon, 28 Sep 2026 10:42:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 28 Sep 2026 10:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790606522; x=1790692922; bh=Yv6sTZONz7
	CzYMK3skMarSQBTsH8gAlVYHZtB6Jdd2Q=; b=V836AjjIQck0wIbq8ry9M/esuz
	VxT7s5P3HdHhlN8q525imNJsBYLBERZFYrEVf6pZCzkzqA5bIzHLgr0U35xkv2rh
	Km4lfvS5f6om67/vxFh+Kr7RnF0DuKMqIBfKESO/6I7n2OWJ64O6qrwX6g6Zkzh6
	0rcZtlD9bIgmeRgxjdvVsAxpGmmHgsANIv5UmY7RiEzQu1SpE3fEiMKUBsF6hbbw
	Xewpo+eADf2YTZzAQ6BVV/RTL09syEy8laMfKCUiEYxJ5I92h6oFD0MA5TgeRquH
	4jWA/yyJre5saenU00AEVQudByL2NAmYQcjMC2b/jisjdY4yJBICeq3OtLuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790606522; x=1790692922; bh=Yv6sTZONz7CzYMK3skMarSQBTsH8gAlVYHZ
	tB6Jdd2Q=; b=a+54zJb271Dg3EUNfT1RQB4Q4C7Bcs97GS5H/L7XeK3ETbhGz4j
	CNyjg7m+HHeLNJPAUtXfH4NWN9VZanzbw2ZUmQZj/sDrxtTuuUPSrl8XpRn/1QwM
	gyA3dIfXd5qIPiOoKiTvmyxr4UoI/BquNo978FTrtzzFGzGdXvj4csHTKlOISi2D
	8e1NYptTH6g3d+eeCEr5Ut7LzL3UkduM/XguzpKcs2jw7NFOnAJSFpuimfwSpxUl
	UPLQEI2Iok61RihRCKZH+L2KHFWEdspCF3Nliu8Q0gfLWVdRCXAZLjYHOxLhserN
	wBB+g3/xLAjG9aZa8ABlFlRYIMpU1FGmNoQ==
X-ME-Sender: <xms:uny6alXdm6jdrNkOvgzJ-cWsvEkOcUI5K9fyilrlJ3qZ-aIf3CVn1w>
    <xme:uny6avDQ1EDurIL5KCMiRZZpOHj9mFCsC6U_tqFR5-Bki4Xj5Dv5a00wzfXcBt3ar
    wxALhrJpy7SJqIFYgFpcUuyhEmyB6xV9kYP942CNEtoVK3Xkw3AT9g>
X-ME-Received: <xmr:uny6ag_kKtrmpybi7RhqfVX1abYKwwOrVugZfwCEo2jsmzmTKmcHRl-JXEqB3FavJF8qfN1PR0xVbuLcHdRlEeAhf_p42M1U3amD>
X-ME-Proxy-Cause: dmFkZTF6TlHE2Z2GM6gBgUs+yMwZdlVuxPvllB24XprOE+AQOPIf3ti6+tVtyHz8cAkFf8
    eGQccOw1VAI5NbI/SS1yfBUeW+3M3SSRw7LyPxGdGxKhgwzPqZj2N4nMCLwIfvQ7BgZiSZ
    x3k84pRQta2TLEXTMUdiXSEU9N+vS1fScruVhg0yJj3J/asvDrKx893DWNymAxpZtK5eU4
    ZlDXFaQhdPsLvIa3h9FXWtCvSRqXXz9qzeHbgBnB/+OFy8niahGmjsZtbfQJKq7XBvLB5b
    5ukD6cAhkHY1OyqPf9cH9lluXrFsKjPG9GWKa35TAu/4cLumDO6SnGLNIo3nXSawL2diV+
    i9C8cQJMrmGh4OFUhKaoAMZfV+KFGAcNa1JEtgpt5reuL+I9/01EtC1l6lraNMnGQuFMmO
    Xg2lTSsgiyK+1z9xI9DpREI+ipIQ3EG1Zp61Cwx1nw78CJ3qBDWHnVOVPctCNEudEz4iBn
    NRuqhBh/Sb4F4OW9DK9mxI78osPekNzBOy4s5g08EbJGmd/br5aknoD5kFhXKQoWAvg/k7
    XQfeJmAAeT7LB3ZEGF1W74SDDzTO98gXkKjMuXQIqi5q3QmCh5qrBdxckQV/lantHRafaG
    9YEnG8jbzzrcSLSUyuBDGhTIqu1DU00IncS+83V+S6XidF0sOImRxmbDds5w
X-ME-Proxy: <xmx:uny6auGn5zRwOFGQDs2zJxpuOxfHrBR6-HNFFSGZI5eBMHa6NxpnVQ>
    <xmx:uny6amOHD6SHaKFyKmFPmUdyam6WYKFnETgoT002iT1q4QTaBYbIYA>
    <xmx:uny6agcqlhpHNrUMJ1Oz9eFlt4X2FQXAkWwbSQ9yKmgxDspg6m4lOA>
    <xmx:uny6ajtZx5EV8w3bhBg_Qmw2qSa87fDBj9axHalWD5A-2X0TgSeVMg>
    <xmx:uny6aqcKX5TvP11zEv7jNRr3_nP-RJ7gCIgJTVYm0lwrlRG0a1vgN1YP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 10:42:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Josh McKinney <git-bugs@lists.joshka.net>,  git@vger.kernel.org
Subject: Re: Reftable reflog timezone encoding differs from specification
In-Reply-To: <arpZ5xCwFXc9ikrj@pks.im> (Patrick Steinhardt's message of "Mon,
	28 Sep 2026 14:13:27 +0200")
References: <85f7daa8-d60b-4348-ac2f-b1a68628af7b@app.fastmail.com>
	<arpZ5xCwFXc9ikrj@pks.im>
Date: Mon, 28 Sep 2026 07:42:01 -0700
Message-ID: <xmqq33utphdy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We should use the one that we have in our specification, so in my
> opinion we should fix Git itself. This is also because JGit, which had a
> reftable implementation for far longer compared to us, implements the
> specification correctly:
>
>
> 	private PersonIdent readPersonIdent() {
> 		String name = readValueString();
> 		String email = readValueString();
> 		long epochSeconds = readVarint64();
> 		ZoneOffset tz = ZoneOffset.ofTotalSeconds(readInt16() * 60);
> 		return new PersonIdent(name, email, Instant.ofEpochSecond(epochSeconds), tz);
> 	}

Thanks for checking.  I (unfortunately) agree with the (unfortunate)
conclusion.

We do not ship reftable files over networks and reflogs at the
conceptual level is not shared across repositories, so the issue,
other than the trivial part of updating the implementation, is how
to migrate the data in a local repository that uses reftable.  One
time offline conversion may be the simplest but I do not know if it
is worth it, given ...

> We could of course retroactively declare that version 2 of the format
> uses the syntax that Git uses right now. After all, JGit only knows to
> read version 1 of it anyway, so that could kind of fix it. But for any
> repository that uses SHA1 we used to write version 1 anyway, so this
> does not really buy us anything, I'd claim.
>
> In summary:
>
>   - We have an upper limit in divergence of <10h.

... this.

>
>   - This only matters in the context of reflogs, we don't use these
>     anywhere else.
>
>   - The risk for data loss by a change is limited as our default grace
>     period for garbage collecting reflog entries is 30 days.
>
> With these points I'm inclined to call it a bug and just fix it, without
> handling backwards compatibility.

