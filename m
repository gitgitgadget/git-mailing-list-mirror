Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBBC39FCA8
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674755; cv=none; b=G1v6X3nc4aKM3L63/GNmiC8vY06xve8XPUxt25YYRlcwuR0+SYl7JVnxCHTkKHUZuZdcCW85+UqAODKv9Q20ef8ux24c93/dbKY50spo7iIwBKjDpWpgp5JWWWCOPt93azWS9BSwP3PtfnWBTU+6PqjSCy3v/GCvbAuNBFtZtmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674755; c=relaxed/simple;
	bh=hH+CJgLvD++E8k9kkjOBSCRp+7Ui7Xa30AEMQQh6HOs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A2zGMy8m17jLP8clEPQA766+b7kDMc30P10csSAjy3Y1uNyEM1qrm9reU1jz8FMR3QLfTN0QWFnuixfCkthoBKG+tZtoglRSi6QO8Qzic2fQRHo4BtskWpLkhaWIVOLd6Wv6QAK/KDlVhuhwXP2u6h2Jsfct+abBJfVQ4YfsttA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sk1DiJ2B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l94JS7wH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sk1DiJ2B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l94JS7wH"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA34914001A3;
	Mon, 16 Mar 2026 11:25:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 16 Mar 2026 11:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773674752; x=1773761152; bh=Q3sUKPqq9f
	ptsIxl1WMp4iYnasRg7yNZpWnjO7EqvWo=; b=Sk1DiJ2BlCImnuTAiOV1iWEQj7
	yHs4QBQHHI2MKqFUA1nt/UMTOCkIlOPsa2p7+E5rW/jj1PJko+X73jKrhVxml/aO
	bqzC1Q3j4p6apAO+p+k+UH9LBdy3/e293dk29lFa0XJ9EkcKTW3ueJrdRqV98oXG
	V/wGbl0mSKuL07T5PTm9pA63M7UggpZSqzHPBy7SQPkUbxq0goL/RMGJEslGHOtN
	jYORElCQwKPZHiiwRTL9fb2XbbKeA5JIf+r6jXUxJHRm0HuJRWRJy8pfWDztyFvP
	iYDr/8c3xqwo8oS5vcAJuPqNbFhVMdVVNsiOkL7xKpIRTRzR/mLLnAoPZbdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773674752; x=1773761152; bh=Q3sUKPqq9fptsIxl1WMp4iYnasRg7yNZpWn
	jO7EqvWo=; b=l94JS7wH4F8rTjRgW8e8m4VQhue5SD8IWQrpM3wAkber91qQBMM
	0XKq3l3PAWQ4q58SbJ2fuFB8IwIULNO6PAyBckJhPKv+YYCD8bNg7xnl1C1WYGQc
	qtZYzbjGSsJpLxe/WpOoXKRQSX3oOg+8NKsA0KPIay5cqeEI/jPu+Uhj+D6Jdhu0
	pNmFWQuJCKxi+uiD2jYebSpnQwK9NWz4zeLNqEvmiYHM7CU1+DpQwoguH9cvpgaD
	ZE1KYo0i2NXEPkhLxUGXmZyHampBYOwtdlisSEgnqL0RU8tk8ElTEz/WIe1rtgXo
	V0EmwP0F/KUfGsatzdXx0/BFrVvIauXWmpA==
X-ME-Sender: <xms:ACG4aVgW8bfutztNIv0NGj8yS-lpfnT_9gbCfW-IsicbzR0tGyHYYQ>
    <xme:ACG4aReLq4bfY6YyQ5QMW7C-Ty1EqPX4LAePF0sz-cfo4hlKI-nf4JQ7-HoYS3Wwm
    Yf3dUYJJxlQGtUUENglDFzEyFE8ud7xQJowyd7wDU7AIsUGZ4Umhw>
X-ME-Received: <xmr:ACG4aSfrstX_hDbs0W7tHyu0rLxI9iZerjHbZuUo6812dWvlWONLI-NF_cN2b7S1fT8rzJrvjRgEuGYM-GElrJxgnOWwYIRnXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehrihhtvghs
    hhhjugejheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ACG4aT-tMT9wAYE9oCxgazgTCadnv7TZP7VUP60nk8Ej1zY20bjVyA>
    <xmx:ACG4aWnZQkzctzaglkXy-1An9YvJ0zhLyTbZlU7XfMT5u2Ig_GuA2Q>
    <xmx:ACG4ad9oKA3jqgbPhQgVJRMRsyGOQkk4-GE_24sf9SDsKSLux50eXQ>
    <xmx:ACG4ackK1GXzPJKT8nfETTXSqxFRjTIGBtGz1qXaM1W6GycY7sijAw>
    <xmx:ACG4aRdYFscNfojCXwerc822iL6WHJJvwTnnZhQVi773T1aunmZMAEQm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 11:25:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ritesh Singh Jadoun <riteshjd75@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] t/pack-refs-tests: use test_path_is_missing
In-Reply-To: <20260315081032.497-1-riteshjd75@gmail.com> (Ritesh Singh
	Jadoun's message of "Sun, 15 Mar 2026 13:40:32 +0530")
References: <20260315081032.497-1-riteshjd75@gmail.com>
Date: Mon, 16 Mar 2026 08:25:50 -0700
Message-ID: <xmqqa4w7re2p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ritesh Singh Jadoun <riteshjd75@gmail.com> writes:

> The pack-refs tests previously used raw 'test -f' and 'test -e' checks
> with negation. Update them to use Git's standard helper function
> test_path_is_missing for consistency and clearer failure reporting.
>
> As suggested in review, replaced the negated 'test_path_exists' with
> test_path_is_missing to better reflect the expected absence of paths.
>
> Signed-off-by: Ritesh Singh Jadoun <riteshjd75@gmail.com>
> ---
>  t/pack-refs-tests.sh | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

This round looks very good.  Thanks.  Will queue.
