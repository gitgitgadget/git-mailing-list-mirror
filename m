Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0F723371B
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634737; cv=none; b=F3Qvz6r9MSAdFyhXmWqXPFp95lV1yleKkx+Dm6VThxp5G4aB7Fxnpx6Y8uxXroxLD8bkXda+nfK9dU+E7u0h2Ac/Z87dVU4pYgXz84stP7bnO5VwKkbQ7f+N5e7wTJgqT7g6MEKgTdSGTa+TRwTZhn5rzVNC8oRNaBRjVG1rcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634737; c=relaxed/simple;
	bh=AHvGIsOIfVMMneYiVhQtT0B2hJJtWq+vnJ2pIv9cWz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGcrTerGtuLAHChXox8uFFe1JFl2QsG7INm4aA1rRfv1uTGzu64ajY9iPi2x8YmSfyAqn1i2hbNdkMui4vKE9X/ukbLtsVwWYdItTQYpvaQ0noNtnJc3zVe6LNeudYfNz/EqZS3MkQXEJkCDoOKLhUZrCkS5pM3T9/pef0Sii8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UVCAz8vY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OoVAlM5P; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UVCAz8vY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OoVAlM5P"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 26CB211401E0;
	Mon, 10 Mar 2025 15:25:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 10 Mar 2025 15:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741634734;
	 x=1741721134; bh=WTOsE3pNXy9AXK69u6f22RpKKNpl4OuBsysvTWAYJgg=; b=
	UVCAz8vYJCnAeakrYeNuNeO6ocfkRl4l4+Ui64XMLSydF8lrpc6ZbERvl1ICtLZ+
	5e5OxTBYWPMWXhvi1H6IlMribiNsfFgUguxVCTEQscTsIMXpmu9nys59fdw6pPaF
	itxuZKDGe8bunU9hcHOZxnsu0PiuFaq+raDaolWoZhuQH91jSHHPAQjZbZYbA9QQ
	zPpu2zKb1/F1oG4C92L8dglM6JsvQxxhE0XJt4+Hj1fvX4t2bhZ236FUg//D6AL8
	ZhypylGKs7q712V4nhyz/MnfBJMsEVJK33lvSwrIiHmqwU5WM+ONKdixtizXXsf6
	jk3zPXAF82QiMzdKyGd95g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741634734; x=
	1741721134; bh=WTOsE3pNXy9AXK69u6f22RpKKNpl4OuBsysvTWAYJgg=; b=O
	oVAlM5PnkPza2sjMObyYj0UjlZRAaYEEKcVY+wo7eXKcCPVAZJZ/x47iOBAPYtPm
	WfCadIetmAgeTvASwpLZch4V2dmaoUZkB0atrxWQlz4I1pZeuHCHGHSLLb2np5a2
	Gus0HwpZhEvGPKvJaOeqEHWSCMRbexw8/Vjx1+0Hd0cEGhVx2BoqUoPEPIuWed4D
	b3mpKwaEq/zh/bEVLdymcAJcUMlrjK/CF3wLiOpOVWjhiK/5fbB3vKG2aw5MbC0X
	UzgF3m3Ylt5fWqievVqpsh/MDeKCh1A7JaH+V50UbuQeXCZEWavuSDKVf9YiKWu7
	IqQqZYx9IJDhwJUPPIdTQ==
X-ME-Sender: <xms:rTzPZ4ykFTRj-9X_fKaY_levSe-R-fwfdzE8i4kJ4cKlw2H63eE_oQ>
    <xme:rTzPZ8TzEgCtTBdftz7eppunJCO04xqpp0wz3u7HvgA4OE6DPluVfzagAFmiHxLYu
    Bril5O3eGNfFjT3Tw>
X-ME-Received: <xmr:rTzPZ6U6JLe2GPNw3wI-zYG1VCin0Yp61Pe2xiSKrvy0z3nPLhloqqPXn5XQOluqZjzXEkwP6GwwM637TNxkIFxliiEuTdB3dwvq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrhihurdgthh
    grnhguvghkrghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsh
    hhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:rTzPZ2iiHPLbPDHcSRWbAD-xDKnsSq7ugjLg4bjFHRPmhXZOIUmu7g>
    <xmx:rTzPZ6BaPvRbtY2iqkr3Q-VYgH5jO-mTtO7D_TJyM8fbF8Sfd_Wm-A>
    <xmx:rTzPZ3LyXtA1UnYV0ql098A8sedj8cEBUN5UO2FqG9xegQu_JK5L_Q>
    <xmx:rTzPZxA49dX_a3XYDQucS9pDmPbVV9Oah2IILHqt0q9ejPCplhAD5Q>
    <xmx:rjzPZx4Hx9u74Cp19neQgd5cKSBJ1ZiDywuGvCTaENlv9ZsaPWfP3gf6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 15:25:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  shejialuo@gmail.com
Subject: Re: [PATCH] environment: move access to "core.attributesfile" into
 repo settings
In-Reply-To: <CAE7as+aSRuo9sFxSX8M66HB3EOH+_OwugAnAJfN800_6GiDqBQ@mail.gmail.com>
	(Ayush Chandekar's message of "Mon, 10 Mar 2025 22:51:11 +0530")
References: <20250309153321.254844-1-ayu.chandekar@gmail.com>
	<Z86PUkJ1sbSH2VTU@pks.im> <xmqqwmcw97z2.fsf@gitster.g>
	<CAE7as+aSRuo9sFxSX8M66HB3EOH+_OwugAnAJfN800_6GiDqBQ@mail.gmail.com>
Date: Mon, 10 Mar 2025 12:25:31 -0700
Message-ID: <xmqqcyeo7kno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> But in the long term, isn’t our goal to get rid of the_repository anyway?
> So at some point, wouldn't we need to either attach attributes to a
> repository or have the attribute set know about its repository?

My point is that it may not help further the cause of removing the
assumption that certain operations only work on the_repository and
not on an arbitrary "struct repository" instance, to muck with the
attribute subsystem.  If it turns out that attribute data should not
belong to a repository instance, then it would not help to have the
globals moved to members of "struct repository" and pass a
repository instance down the code paths.  Rather, it may turn out
that we are better off passing a separate structure that is *NOT* a
"struct repository" that represents the set(s) of attributes down
the same code paths.

