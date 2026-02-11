Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D810361DAB
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 21:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845074; cv=none; b=JU6XTa1kCA+6OdP7iXozpKOzvikfz4fKy6wW5BtTMrKbtXWNCJK+WhU4GP9zHAsjxmF+MhAcJ/opCAz7fATHmNlTSU3SnpJFll60/9vzzc0kAZPIt8ClOuOGapGlpju2zGAdrddz2XxtUBSycztVcXvLUOZFnmjQvyUqEt9dPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845074; c=relaxed/simple;
	bh=e73AXqr1+eXp/PAR8OG9UdpbzOAbYpYzCrsZaUN/6tk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKH9ZoKzJ1Zn/i3IrNQuWpVvanqhpbUSWswcAyEVc0g3tjuTqUnKVkFgBmR3TaEguGaXv/7tnTfw9EYjxPuPuvcuZL4yFNK4usZCowhkPlyQlHdh9+0RDnXn23MhmVuAHY/psEiwzGuyq9R/2+NXErZF+ewodzcfpf30WhiZbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=x1jPpY/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=v3xIswIe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="x1jPpY/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v3xIswIe"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 67ED21D000BC;
	Wed, 11 Feb 2026 16:24:32 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 11 Feb 2026 16:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770845072; x=1770931472; bh=ZV59bIGFkX
	w7hamT1dt6Ia6tO4T+GjIP5WXZ7T/GhDU=; b=x1jPpY/AlX6BVjoH1wXDxohUJi
	6B5ui53Ab9popFdqf1qjV5YptWzpDAZQ1j94cFCd+IUkGYJo+ndbvH2VgkPhErzr
	5FMmXvmZws2pXv46FlOWqZb9Pa3khgdNCjMZ3ApdgtybUWf6TMKelHzlztnqqDCL
	9LK15dMFoKHVaxs0aK5gg/FXe2E2MIHNng8cxz9+i1s8BMQKt9wg70frZv3KiDZ+
	kpdbHWg6bgIe9OlHlKJknHjYuDhIvPh7TV1kMSZyU8r+hzajQeAxtZNog7KnczJy
	NAt+SO49Mu4w94jSKh4l+HP5jl4QS8vCcHbKFRC+UcKj6BWfbUhrIzEXjEew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770845072; x=1770931472; bh=ZV59bIGFkXw7hamT1dt6Ia6tO4T+GjIP5WX
	Z7T/GhDU=; b=v3xIswIeocQOKC8QgtoCdHW/DRjdgAXICqo2c2QGik7LhmJow/u
	qSItar84pGXTECh2DsMamkuEnzWdrAUN+FunXvCC6QVSKY2uVx23wkofGA91FORi
	JdG4loBD/I9eylAY5S+/K5J2eYb7DYlyKOzEFb2KkVq94r34dR8HrYa8V1mBlgm8
	cDdGa1DcQFosklhQnH6eBNZrxRcj/5reirYPAgoWYUfvXHcNLN6FTfB2iPEzXTJ9
	sjL2QSjaVxeW5bssVQiKZGredJp5mJN1jYRUpHMIaRROWch8jiRX8EXcrrHcAcFA
	POPwdLlBRqa1nkMoJwtvbPX7sPu8W2KGe7w==
X-ME-Sender: <xms:kPOMaSNeobrb6uF2I2N9Ry0cbFuAJ7nfEKe2HuZ2EmOJy00yqi97tQ>
    <xme:kPOMaX9Hu_Zc45U08rmCOftyBOo-zM5n5pIFoyRBOZNY4Dg1-ZtZpubbS8qd8OWhH
    IN-ptNYykIqMmsLF6s2nJm7XV0kydlIyl1Fvmnxdh3Xc7VXYOaA>
X-ME-Received: <xmr:kPOMaeSY98hXWaugFPNcomO9GUpn9SDiRAZCf0-mRaHuO3urxaDAYKeHdy_zwIzoGDwbI2LLP-tVVjyJEymNcH7fGvduuqMzkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdefiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrghnughrrghkrhesphhmrdhmvgdprhgtphhtth
    hopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:kPOMaRn_GIj1eN9KS1rD6QCVdhmIXhfzS3BvRE-SZQqkTSKXNgEGcg>
    <xmx:kPOMaWRJIu6hj770JrotGOxXQrptmXXoEMpH8JJs94nwRbRGmdW9-w>
    <xmx:kPOMaXNlT-FW9XGprgxQ0lPj3i-JaRUuDLtrkQpAfQPHQEoqtZGBgg>
    <xmx:kPOMaXWX4gsa20LuTJ80nyFEpEERdhyj6EB9LCtBS68MsOcMHkVHMw>
    <xmx:kPOMaTtsSnuiTGw8l8dXXne2EsNv_qravVmnUrt7tZd3BUS1WGbDiHRY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 16:24:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Chandra <Chandrakr@pm.me>
Cc: Chandra Kethi-Reddy via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v2] add: support pre-add hook
In-Reply-To: <2kX5wTQeOz3VPzUT6QiH_KyB9RMMtf8L3I8N6WtVWHaVQ1ZguBTaqAqFcFgOGpCqv-RJyALKlsENx-g7E3DMx3TzCfZoaRtPEpoDyx6d9kg=@pm.me>
	(Chandra's message of "Wed, 11 Feb 2026 21:11:15 +0000")
References: <pull.2045.git.1770737573475.gitgitgadget@gmail.com>
	<pull.2045.v2.git.1770822312474.gitgitgadget@gmail.com>
	<xmqqseb7rre9.fsf@gitster.g>
	<2kX5wTQeOz3VPzUT6QiH_KyB9RMMtf8L3I8N6WtVWHaVQ1ZguBTaqAqFcFgOGpCqv-RJyALKlsENx-g7E3DMx3TzCfZoaRtPEpoDyx6d9kg=@pm.me>
Date: Wed, 11 Feb 2026 13:24:30 -0800
Message-ID: <xmqqfr77rn1t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Chandra <Chandrakr@pm.me> writes:

>> the word pre-add ... would not look good
>
> Originally, I wanted to call these pre-staging hooks.

I was not talking about the choice of words.  If pre-commit
interferes before a commit is made in 'git commit', pre-add is a
natural phrase to use to interfere 'git add'.

It was a comment only on how it is typeset in the documentation,
e.g., should it be `pre-add` (for verbatim), 'pre-add', _pre_add_,
etc.
