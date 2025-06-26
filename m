Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E062B18871F
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954537; cv=none; b=lqmAEOy0k7uaM+if68nCFMQTtpMino5SYoyLnXdBxHixwXVSmy0XAqrKMSPlvAi8lHRCM/cWqR2onREluiuAqgGoBrB3qaan3/pR2kJENgbw3nw84Tkm6NSUlFj2sRX+xpd4hF+GaufQap6gZOcMTN2xmq28uF6y+5+5ZJee2oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954537; c=relaxed/simple;
	bh=M5P0LB16DWLKvzx84DOOwafMjkGJs7Q9jWxspKaIEwY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=J0Jz0SS9nLIipZpnmpzAHhJ6lnbC+4NW86SLIxyKvNZa+WKHzS6xsLGYwkBjNdwYnZJ7i1gtbaYtSYOXO01ahs3qYrNEBB7f68InVWLkXtOEtm+GbsZpddfvQ6tCdDzyxuh1XUcm+swoHQEfaRVaK7trbNky2gBHENF317kkbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=ANeustiH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZefHJN2V; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="ANeustiH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZefHJN2V"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EC8537A01A9;
	Thu, 26 Jun 2025 12:15:34 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Thu, 26 Jun 2025 12:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750954534;
	 x=1751040934; bh=M5P0LB16DWLKvzx84DOOwafMjkGJs7Q9jWxspKaIEwY=; b=
	ANeustiHt1X4CUhFCqolHWG5/GQelbGiB63Z0LvGEMaGS58mY+HjaubyGDxpEIzK
	Gir8GuS1Mn2N/sloJ0Rf7dlpJFVFU/v74uXK13bCi+U9nbd+siN8LgLBzGpUuPSb
	g37NJBfy0Qh8RAVtQ5zxYZQjkvLCUDM3plTSm0tIWb4dd1cAhKHndZKqnKZ/mkl0
	vHJCd3QbC7Ww3z/k54VtKoubKJP1XloetSQe/PdYVkxweylCqRGSO8M19Ayqncgy
	z2xn2+JYIylLre34mQKyhr0NPPYiW32dMFJawz3VfgoF604DOPk1tWpsuqJYOyzG
	dXPZecKoCVpzDSLiaanlCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750954534; x=
	1751040934; bh=M5P0LB16DWLKvzx84DOOwafMjkGJs7Q9jWxspKaIEwY=; b=Z
	efHJN2V9FY/+DiE+NJrYeW4PQxtgJKD94EvEegDU/q7EPNdwD1ZamtEYq++HRHCh
	JS2Fy2vQesVCSumroeFobyNyEQK5J3DEsXrEa6Hu9jmTvW9etX1zsJ4FbdsPOEt7
	hB86B/TnmpZlJeL/jYAdxI7qWYe9pGCbMA9MzpUahGPzTaKCvpLJjwzPvRJUzszh
	6663nWdq/xzOQPFMmahoF/2TDtUV6CEy2P8tyV/DUnk5Am0yvCP3G4x789+LiGwY
	O8h2tZoTefBJaJh8ah0lXvvEMCfjR2OsvggMdns2o/tW0tKb+GZmB3G+PKepsY84
	Mf5459jYkKw7hL/mhCF4g==
X-ME-Sender: <xms:JnJdaNtZLgpH_HuhsHmqFUsJfIgJBezv3gyrWzRsLXGyN3hGM6mYi8k>
    <xme:JnJdaGcgUQKNq4pkm1okTFqd-RcH7uRgLm0M1HWAp8Fwqt6G9DzqPLE7dHjGxcIU8
    Qi9HbBi2n0OaS2_fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    foggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhf
    fhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkh
    esfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfeh
    uedvgeejkeelgeduudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgt
    phhtthhopeihohhshhhfuhhjiheslhhinhhugidqihhpvheirdhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JnJdaAyu-wciQvXyL0xKSZ_gchtm3c2uedctrd14zBnoXNJeWRI_5Q>
    <xmx:JnJdaENPe6RwtmtCv9x2ZqGS9oPxS58R9PIlub6Mj9GuCiHh9ZBYIQ>
    <xmx:JnJdaN-1vjmow6kK6jWGSfuEuhMXx7Eio3mKh8bJkym8JkxgjD3Sqw>
    <xmx:JnJdaEVmFHp3YISqi6i4_QNcAaCxsWNCGpUCir8uGnynGCiNI0ujZg>
    <xmx:JnJdaF2Qg06qwBG4duNdHi4zb2fWYwACRiZGxc7iCG96nQed5kuuSVxq>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 62FB51EA0066; Thu, 26 Jun 2025 12:15:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ta8b4a29a7f7387ce
Date: Thu, 26 Jun 2025 18:15:13 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>,
 git@vger.kernel.org
Cc: "YOSHIFUJI Hideaki" <yoshfuji@linux-ipv6.org>
Message-Id: <4e92bb11-1993-4cb2-be16-a972088f7cf3@app.fastmail.com>
In-Reply-To: <20250626161038.85966-1-carenas@gmail.com>
References: <20250626161038.85966-1-carenas@gmail.com>
Subject: Re: [PATCH] daemon: correctly handle soft accept() errors
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025, at 18:10, Carlo Marcelo Arenas Bel=C3=B3n wrote:
> Since df076bdbcc ([PATCH] GIT: Listen on IPv6 as well, if available.,
> 2005-07-23), the original error checking was included in an inner loop
> unchanged, where its effect was different.
>
> Instead of retrying, after a EINTR during accept() in the listening
> socket, it will advance to the next one and try with that instead,
> leaving the client waiting for another round.
>
> Make sure that the loop doesn't advance and while at it, make sure
> that any possible completed childs get reaped earlier. To avoid an

s/childs/children/

> unlilely busy loop, fallback to the old behaviour after a couple

unlilely?

> of attempts.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
