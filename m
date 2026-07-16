Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BFD397AE4
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 22:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784241101; cv=none; b=cSMkV51iY3I7IFzgSJuZhKdVeoGpBk+Ck0lhAJLAnmYAog0Nrs2UcPefm/1lZRogmSeS9lhTWqUCfseMb8VghKIW1k5D0HGQEu3OMC+EeWKCsMY3Ih9LYlHjAegCnfVKIYR/6zh7XtBgwUuizICE1HSswOkE2+7iOGT/v5UiJF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784241101; c=relaxed/simple;
	bh=MRHTCU1knZxd4OIh/HkCVq6bDI3ByLFmJppObst9Dsc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HUWYxfmM+AjPUjdWKfB/d2VXxpjmyuA0zzlepyN/e62Pc6kszIQkYVOMDdFtkv3SAffZfFll6q6pl6dycQUpdivqvGbLtuxB94abJRn5iQ/2oW7RUwEXzkOr2eWd+d01VqGw2pAi1T+yiidoSg+8C3eL/ZUOMfqf1lz2OctEPa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Rj0KeFFq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qf3hZmLd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Rj0KeFFq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qf3hZmLd"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41A6F140017C;
	Thu, 16 Jul 2026 18:31:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jul 2026 18:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784241098;
	 x=1784327498; bh=tUtYxKoN+QlqKSuBtDA/Tpyi5eRqvqyen7GmccGUEJU=; b=
	Rj0KeFFqIQU702XWEz3Qzx6blSghbedBPRIyyddxlqlpNfljJ9z9Gj2xno3kYU4p
	aokFJ8z8t9qURTEzduxk9zPJP8D1hR3feovHNwTSqOAKQMUmGG2Pa8+zUEnw8jkO
	BHXeAkXKLWnfdtkAcgyvbFmSpipbBm2jj+hc5WPiS/HyTXA18tUgV7Km0O9Uxs65
	WN2l/+nfxEuP2ZxwBjuLyHDismsvofjWKhgt+/P+Z/kBpasvHN8A2gX0swLtGmG+
	XJh1P2rcnB3CpzxkFHh5tZpHxVKtqjFZsbgq9ewcvyX3ta8Q7YLo4IirmIXgcyWA
	2pZIVwp0ehobHlcPTVq1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784241098; x=
	1784327498; bh=tUtYxKoN+QlqKSuBtDA/Tpyi5eRqvqyen7GmccGUEJU=; b=Q
	f3hZmLdnFf5FNZRVOmbII0wpNw6v1jdmYF/xH8dPcBlzSol1NJ8MNvzm6CrzN2En
	VzYUJYmdXyghk+3bY9W+4Q7dXVxe1M+AYvL7HcD06FOekEqdvov7SktzdaLEiwSo
	/ycHRnNafpBPawM68cEJgCPS3BmfPHTn9p7qe8FqCazuBIoEbI2Qh9DERky8A7JM
	D4shqIUa9dlr7xO4JAn8+CzCvBlQ4rUFaS/DsfUMKrJ9FJtjgpoQkwSRr/OYQTZt
	QMasNXKcQU8gpbMX+iEhJVGFJKxdZJ8tyLKcyW9xR+/C555IpmAKky7EQKaEdE/+
	yMVw+F+sa/L3MqbJQZyxQ==
X-ME-Sender: <xms:yVtZaqaY_oFXrWU1IlsTAM6xjpZ1ITDb_LZtiY3HU0xLiMg75323PQ>
    <xme:yVtZalkzBoaVdZKZhsUHS68kB8a_cyqrw3uWne_i3vpvoqOe-iyLWYcF61b9QpK1-
    VOTyjuKXgnat4JAY5wdDCnPHF2cGjt1A0tN1tjZbRvv-5erI4b2cQ>
X-ME-Received: <xmr:yVtZagiVTLAYM0uTZhljd9f6eyPVoX6pL07OV4I8YBLXPv9UaVxdCIIA07Luw-K0vV9D-8aCMGlyh9XqHCuj9xxeF8HaiA-3UYc6nUY>
X-ME-Proxy-Cause: dmFkZTGLTBbDC1ClaE3HH72X5pIVRxCVc3/zI5B/fqtypum29egg3xr03hylvvOFhKpTvG
    Ya+vqup3z1rIgZ4K6LRVs2X9tAMdPRFyKNhUy0TgYZaCBmHDK0EBxGjcFI1atJwt1ba36n
    JcPVXxhx2aFMrXrDMR67HpzQxg7NPDt4kmGLlR0JrsfSb+H9Tjt+RdgYT2OJOy9f9ku7go
    K0d7LZvrG85UBWelU6CosiPWuAbuKrdXjsHmm+Fw5/WgWKRapRTwk61pM6fhu++4kikWQL
    94fXMQIsm/ZY0n5z9V2SrSrFsJmU0t0WZSTAL0OwooTnjrOpi0Y3EGj25078fJ1IwmSqHW
    QHyIa69Z4XId/j9NmKhDkAdmzzwXUtGVFxClqY8c5iQwCyXtja1+TNONvDN+pH5aQww48V
    Nrf/mtQuqaVQWHKef4VUDzI0hlxnqLILpPVb7JTU8CLUdWxWsgIA02/yX99Yixbg+qiRj9
    Pa8uiGI6z/OrDIxwP4Clmv7ZO7wSNWis1jFujOttwXI9Oh0PQ+UoaKQ/ekOAN31AmnUGMW
    rbriql0kyV+J8qjBffyrr/Wq1HS/8fu8TGvAgXOvmyPw1HeqewVgKAlo5PD+T3nWn5MdGh
    X1QTmkbRSfIeQObHuMXtXk5qQ2wqAT4SNRFDX2r0FXEfuWcYIZmn3OJuA+FA
X-ME-Proxy: <xmx:yVtZanQqWZQB66lYNJju1-oSgjhL7ZdYcxj0NvBNqNg3iGF1gnd9kw>
    <xmx:yVtZahaPWfjQcHqpXd5p-p7oeq-M6z8ouIFx2X5ApOU18OoL5R1eqg>
    <xmx:yVtZakSD3CeqxfJ2F1V412GzwsVToohh0UlvLvx14t0ds7Vq2v5ICg>
    <xmx:yVtZag8XTuG3dkSu1Q5tVvrg10JfL-OZyByXYCURnQMoawogD07NSw>
    <xmx:yltZaoPhzXZBKdKiNwwWL4sYIIbeTx_sQU6c_yArOplG9lrL6_0nJXcI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 18:31:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Git
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Elijah Newren
 <newren@gmail.com>,  Jeff King <peff@peff.net>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>,  Justin Tobler <jltobler@gmail.com>,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: .mailmap etiquette (was "Re: [PATCH 1/7] parse-options:
 introduce OPT_HIDDEN_GROUP")
In-Reply-To: <CALnO6CCauJhCmgKjV6QJ44cZD=2ah6=rJaV0+2ZMYTo7ycghEA@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 16 Jul 2026 18:14:56 -0400")
References: <20260716165517.433849-1-christian.couder@gmail.com>
	<20260716165517.433849-2-christian.couder@gmail.com>
	<xmqqcxwmeiwq.fsf@gitster.g>
	<CALnO6CCauJhCmgKjV6QJ44cZD=2ah6=rJaV0+2ZMYTo7ycghEA@mail.gmail.com>
Date: Thu, 16 Jul 2026 15:31:36 -0700
Message-ID: <xmqqqzl2d0s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> Speaking of .mailmap… if I were going to send future patches under a
> new email address, would you prefer
>
> (a) a series with the 1st commit being a .mailmap update (subsequent
> commits bearing the new email address, of course, but unrelated to the
> .mailmap update)
> (b) a one-patch email with a .mailmap update
> (c) the same as (b), but only after commits with the new email address
> have stabilized in next or master

I am not sure what sort of complexity you are anticipating, but
having you send (b) and me applying it directly to 'master'
would be the simplest approach, wouldn't it?  After all, adding
a new entry to .mailmap does not invalidate your old identity;
it merely links the new one to the same person.




