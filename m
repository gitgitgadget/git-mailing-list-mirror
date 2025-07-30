Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACF31F463A
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905977; cv=none; b=MlGwKE/NFKSZuzOU7Oi5VPQrtvhI7k8hvxnBXCPoVM9fYJyxpRe8S5sUx5/4Xkl+WvdUnHExA6yGxLlTE9VUxLxxl/DKsyW227rMjBJ4QtmuvZEBgVUC1/GcQZd7R39ycwK5SUsH2TgNSRWBa0FmO2HLYUlaI/hRVlZm+cQ0HAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905977; c=relaxed/simple;
	bh=LDIaxCQDq12aCChlgloT3bgrL7ynZb4stPZCVF9ui4c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SfeS3Xj/lV3411l0XRwPzCG663k60+oO/0Fmx4Uz6avhKCuXcZ4eA+UffhWkgxkRK5DwgowxMELg5XSqy+l93sE4NdM9vWJVw7bSNxGUASaSZ/94PFTI4qBOKBimscMiv62Q6dFmbjdwtfUNX4gsx83SWHKGAr6TnyIfjUcGnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EfJcgC4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YoLAB3vq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EfJcgC4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YoLAB3vq"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 3DC9CEC120F;
	Wed, 30 Jul 2025 16:06:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 30 Jul 2025 16:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753905974;
	 x=1753992374; bh=LDIaxCQDq12aCChlgloT3bgrL7ynZb4stPZCVF9ui4c=; b=
	EfJcgC4KXJ+oEOGFnDe09i8gNXatUJGy652r+PSDaKFUoIrTnao6Y4CldjEXk4rb
	Rxp370UaIIXhEaHpgKF1lTKf0AcujNYIkGKTaWTi5GcZPJe8s0tiM+sOcu6TmTT9
	Cmc4a52aUuYUXGZKnHX/sohSb5WXFRVi3vqepiD80qShp0P9s3TugWl3UtDP6UT7
	Pk6IueIO3bgxFtvCt4Ksg8dK/veyeCQ3v85iku1Lghqnqqwb3ESuCOUUEj4GGDgC
	nJ5+VAl0X8hpuTaXOf8nnLiF4vBpxTMvHvT1ydqT2mtEohzWr4T19vE2Wujgn+A9
	cP+jos9ruLtD1lShAm1NEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753905974; x=
	1753992374; bh=LDIaxCQDq12aCChlgloT3bgrL7ynZb4stPZCVF9ui4c=; b=Y
	oLAB3vqzzq1UMVy9f9jTEaA5neSjVYpFB09Ck5Kl0i16UGDdrIIFT2LuTjC0Ykpf
	xyU/c3wboiaSBcM9uW8eq6qLgXjhuhVqbNDqWXPMGd6z5/lhC1KfOSHQC9811PkP
	m9W1NQj1EfpBFiDiWlZLX2y6UmBUyynrocEXfnqIvCRaNA2YGHuvSfxqNH6QAMLZ
	n1swfNrH8pI5HiSVZ7iq+eoPt/m8KmU4V95McPxNJ7w0ZYRRDXgKAvQyys+TH/fK
	eG9S/4+wspvbDyKL2gKreB/k7Xjv+O83I4hGS+FhomrmTQwJEbFVZyHOfBdGvG2C
	T0Y/vIKjOkn/DJOtKPqww==
X-ME-Sender: <xms:NXuKaN28-d95QRIhTzGtqE0b59eBaj5MPIs-1HHOeWa5fXht3S8ppQ>
    <xme:NXuKaBrUA2qFIINOmUHcReWKspqHzTB7-a7y8kyeRcCjpxczzVE5SrLP3FXg4NXfX
    Mf4kuzf8tiAGZKzqA>
X-ME-Received: <xmr:NXuKaEUZ2DZrKomxDkn2WKNKE4s6-y_LgEba9-pYjmM2K39Y5xc4GTq2XabZ9s3oQyvI7ZeuxT4oKwcmNkbqxUgnugxiodd8oms6eIY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjheithes
    khgusghgrdhorhhgpdhrtghpthhtohepmhhlvghvvggurghhlhesghhmrghilhdrtghomh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:NXuKaMaUB-qpflS9CWzScSh5D1oS5_hwrJZUXLyQ9UOFtD-Aze_1Ng>
    <xmx:NXuKaBecuaGKLlL3A3kZrbSlrfJlXBuGPslmS4H9iluHj9CHqcjZNA>
    <xmx:NXuKaG17UumHth5iXIy_pOJMv1Hrv_wYawrTRjB00L9KgjBdqovqNA>
    <xmx:NXuKaIJ250_-DyUvH9XKwDR-Cm3eYOY2pUSRK3YHx6cmXOsVCR8bbg>
    <xmx:NnuKaBGh08rqpe9G4RwZsG6etIkt-ruLdmSLmRjFUjbps6iwl9aQjXsR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Jul 2025 16:06:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Mark Levedahl
 <mlevedahl@gmail.com>,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/5] git-gui: workaround deprecation of Tcl/TK 8.5 in macOS
In-Reply-To: <20250730164052.15371-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 30 Jul 2025 09:40:47 -0700")
References: <20250730164052.15371-1-carenas@gmail.com>
Date: Wed, 30 Jul 2025 13:06:11 -0700
Message-ID: <xmqqv7n9l9zg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> This series, add improvements to allow running `git-gui` in macOS, which is
> stuck in an ancient version of Tcl/TK that is no longer supported by git.

A naïve question.

Just like Git is a third-party software from macOS's point of view,
wouldn't Tcl/Tk be equally a third-party software, or is it more
ingrained to the base operation system offering for some reason?

The reason why I ask this question is because I do not see how it
would make it a lot more hassle having to upgrade the version of
tcl/tk on their macOS machine than having to upgrade the Git to the
version that ships with this change, from an end-user's point of
view.

