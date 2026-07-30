Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B3E443E3E
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427374; cv=none; b=BhOvlPhb6gPcPhIx4zLmkIKeH8CmpHUKiy9Trn4Wpu5bPVSWvbMAE1P22xJEem/Hyg4LvROQT2HpcFSYVcX4hPxfQKDwvHZaZiYZOrM3X/k1IKjKkHOIzABhFaq9UzPG0aaPXa43ogHvNJFMfExhF1z2Q62WXiblhkqH72Tnop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427374; c=relaxed/simple;
	bh=F4yqGnAXWOi3OyeE2mExDvaqn6QdM7EFQbXtWy5JMvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BH0HsHZaA16CO1hJKl4wcOZijsJ6ucqBJbPgfZtZuXshhUQakhB5vJUiRhNg0iojFFt1mwwXGNN5iU1yKDBxuEkL5vw+EFjiag6qV/K2mA1qa0vOu3yua6L0YfrN18qK0IW0ToCZzGVjtJCCD3IwmCk2udJnZMe82u4SC+kXEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PvUeAFks; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LaSb5pmD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PvUeAFks";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LaSb5pmD"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 90D197A00BF;
	Thu, 30 Jul 2026 12:02:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 30 Jul 2026 12:02:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785427372; x=1785513772; bh=Q/r2gzZkRh
	ibBm1ZTMKzFZNrGGnaI/lXV+NQxeXozUs=; b=PvUeAFksKEDmxdmz0NIJzxmFLR
	6jm6KaIZT2H8gD8O67QCF5ZJuaEB6xYCQd5HLca6Vp1h93mMe6WFDOVTRufhjpop
	WZ2jDIZfQJOzGOCs9Bn4O6J/uNxAFmd4vGzixc41nGKlH2OC/zZ550kDXJXptrqC
	pdupnwfqDWtu5aQb2xo2LEuNsZheZzS/yZ5fd4q/yXsUt8fz4YNclaemUDkmhvk+
	AsH6cPWG4HCgsgIb+HbcIn2Y9hn4IZCUafOkNrXf1mv5gB9FXbt/kBSalpxjBM9G
	W6McBLzRE5LId6NrdYaTwScYF8r/TcU4MX6D1h/gCH0jcDdNt5c2n9zkzY6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785427372; x=1785513772; bh=Q/r2gzZkRhibBm1ZTMKzFZNrGGnaI/lXV+N
	QxeXozUs=; b=LaSb5pmDVbgHZqD0ZQY2Jengw6GqSUDyMjL2bLuvXdjv7Yc4pdM
	IZhuHi2QmjAo6xn69sH4GVxVrl1MtoNWH8k1u/dL7/as5r3+y3+v7r/i4H0LAWhq
	z17SZoF7FKj1ZrNb0jt/RxsK0y6vWMKnG+wFBF8lNoZV2fUOCSQEluwmyaC+xrig
	coun9rwkEsR84NuSDrwliKMeZG84ZFeYdMFV7ZOkYeO9GbiXywocnuOPa3Is1UKZ
	rpz5WoJQz0y5vlvUP0e9PiqAm1jjpzdhYnEZmAQI9njey3DR8TFiA1RMS90NkPxr
	NOQ21oCqIiaSe6rDGMLUc8WN86YpC50gVsQ==
X-ME-Sender: <xms:rHVrajJ3V26RZIXsSdP-EoDSU7heg4phcXaczo8KjL30B4hALS0tuQ>
    <xme:rHVrauCSmekwfVosfZOh_ekHTrtDw5fQKM8HE0D-ZqP8QCA7gwJv2zq3UyjEBWR0g
    7LYHDaAphox5fzMn6TQT9Bp6U5CfZKaF9Qr4UbIMQX-hShFKi46KAI>
X-ME-Received: <xmr:rHVrakBc67klzN57b2rTju-uyulJJ4JmhtHwzFHm4fJGxVVpLDB-j20pl75K76XoZfOnNpwdlm9J8K2fMfYxVXuNBWuYA2luvw>
X-ME-Proxy-Cause: dmFkZTFrTeJLx2ROhG/y7I0tjCA08gNUDwgrUfeunJoePzpKw3qCs++5cDrPukm4lYKm90
    xLEfIaarloGN8t9QtmBACmK83EVHPA/7micS3jXj2yU/3MlQtKqM3lTSc9a4YC8hG5vhjH
    XQOdh0ojjc7+IeFOlZnM6BAvjVuPszYONVcYgisWtktdUlMWMMXxWuToAIwe1SG9K86Iad
    XAE5Oh9RzRFt4uhFOedBJSMobZqXtCbN47kBecVypbkH8XlsLlEwT7AdjW8yAqUR6gFzik
    tDPbWlcO1Vc4xy4f2ox5bDAfONWuKyCoLNk4YbuWToYWrAMFTJPU1MsJCAGKQqpJ+z1kA9
    Eadpd+MqxPmXIXTieOuFANPT01I2M0CUE92UunYCXRbInRegcu1fEnMzE4HZPsvn1+I/Cf
    TjIgD4OVzcEpWkeIKMF8ZLRgPdLEXO7fphIeTHCTts38vVxXLoMzIbQYI8qaGurQZHM0ts
    zRG60edFaexJ2W6l+9pWZCzW+hLLwH4BDna1QaAtGs1dgfF64dRO96WdMtwhDg5+KgU/I6
    6bkx2rE14NF2bVyYTv93bDolW2TCK/lOuE7aSbPEoSaB7zNt4/A5WEjfv6rTit4I4tbeh0
    IHpIvX1NQa3oPbceYAqUoeP/fMpD3BJLbh7bfJ8GhFFinsQLNeQof/Tqyn/g
X-ME-Proxy: <xmx:rHVraoDxuK6lXIZ-z4sEZ-EIV6gpGMGYVVzqWlETBM-TkmSIGL2RQA>
    <xmx:rHVranqQzWSsjMyN6W_Ve4kCXzBSvYudFIbquaMqlZwXqByj0TIkpA>
    <xmx:rHVraql5yJtpNGdN4e5lrxIdy-C3yFfcXWxhH5mRkn3VevGclpgpHQ>
    <xmx:rHVravzqrn0hAKba5iLa9giDpZoPhvY6xyEHte1T3ebB7g122Aazig>
    <xmx:rHVrarQzZM6eUCz-Ok04K7trs7IhfYPP3eqAU8-maKHcgFXi39Ohy8wM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 12:02:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,
  Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH v2] merge-base: add tests for --is-ancestor
In-Reply-To: <pull.2186.v2.git.1785392350660.gitgitgadget@gmail.com> (Nikolaus
	Schuetz via GitGitGadget's message of "Thu, 30 Jul 2026 06:19:09
	+0000")
References: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
	<pull.2186.v2.git.1785392350660.gitgitgadget@gmail.com>
Date: Thu, 30 Jul 2026 09:02:50 -0700
Message-ID: <xmqq8q6slb2t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Nikolaus Schuetz via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     Changes since v1, per review:
>     
>      * Reuse the E---D---C---B---A history and the G/H merges from the "set
>        up G and H" test instead of creating a separate repository.

Looks good.

>      * Add a test that --is-ancestor requires exactly two commits: too few
>        is a usage error (exit 129), while more than two is rejected with
>        "--is-ancestor takes exactly two commits" (exit 128).

OK.

Will queue.  Thanks.
