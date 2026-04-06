Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED3388E5E
	for <git@vger.kernel.org>; Mon,  6 Apr 2026 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492682; cv=none; b=NHlNDu4TVrXXz0bU2VRZklHfLh+FMhqk4iJSafA6/1vyheAdIvAmWNGyy7GMvhIQtIQDX7yfSKHEssagsXwfGgWlo/JqnHTvj2WNFntq+QjYs2Ircrkjq2Ik9x5TkA7AxKBQKNffWuNyeYufDlvSkIxMyfU6sReHKKehUPq/tK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492682; c=relaxed/simple;
	bh=tlgUg7u1veg8NqpspAV7SSSH8TWodGXh/vAOjnJ5DZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JIsJZiPWbjMrRoq6TTkawZPmWwKSAXS/x4OJ4SIcH+WtNaxLPTQDsl4DSBHtY1ry8zJ4TTA8M05AIMxSS49OpeRBm+7sEHHbK19pns2Qqm+5dxe8kQ9Geeu/NFm3iRBmVdpKPaTsPrezUpc5irp26rGi4W/rn2vnCjZDgQLhh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HnHj0v4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gM7gFvhz; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HnHj0v4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gM7gFvhz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3FB7A7A024A;
	Mon,  6 Apr 2026 12:24:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 06 Apr 2026 12:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775492680; x=1775579080; bh=tlgUg7u1ve
	g8NqpspAV7SSSH8TWodGXh/vAOjnJ5DZg=; b=HnHj0v4baIkoEcm3YMqLA9UAk1
	sxAv6NLD+VQmviJyc4xw/d9x8QWydKq1tDamP/LTyiK6hhn7Wgkpe3HdZ8mVaQJ5
	KwQf0GF0dJPUxb5kGI97SxqdUxi/EkGNLGx36bwqrXnbTQH8PxqF/CAv2pgCv/Ly
	rjgxZqMvluxTmx8uv3LJEJjlqM1KsETJiX1GnO3tmpF1LOi3wqY6V/CcCuK/uSZt
	3q266JEfOzbAg6M9Er7YFfOhIvmx4yHycdmATVUGDybN5FkUjGZgEPF70H9jh/5m
	oC4BFIgpDHXNwfwJUIWF6x/5g3a9BlqexHUeyKa3RKEAlCjFL6pNKJv+bqlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775492680; x=1775579080; bh=tlgUg7u1veg8NqpspAV7SSSH8TWodGXh/vA
	OjnJ5DZg=; b=gM7gFvhzyqOoWkW/lokCaNaL+8KOo+eoLxCrWCmdF1JIOFVSDHJ
	sa/QW3H4zZLgzzF4Nk8bYCyPPqY3gcM6JBDiz6W/9q/CJHw1lE0mud0TasnHF5la
	gzbZ8oJfxX/XR2y4x/3CSgRAuZXzP/s7tm0WajSazZTvbiRWnbWBGAbwor7GzgwY
	oakIcov51cY/bp8z1v/LAQ6wzttnbdoGBl4haJpAIl6m8rCF3W14CWY8ZI1D47Hv
	wePptuMdX42Wl9XN0qNRkzMhwOuVY7kAPFjMC9NCVicjk2Bhv7L22Q8PAXPPJWgh
	Uh2kElyBIfK9Qrbbrc6GCuyp6Hk8E/QYn+A==
X-ME-Sender: <xms:R97TaTWao7QamSW0UFtkUjRf9CRGySIl2KLD2tV5XBqfT5i201jsJg>
    <xme:R97TaeImxDd11oIYX_AE-vOqRY6TqF-s_y7a2gOraeUg-f5wNkNkQL3jYO5cUtJ73
    CQq3ykD9uzGSKf48FXODMdg9gvAxWMj0Y8slH9_kxTwZbKhjPFoHg>
X-ME-Received: <xmr:R97TaTBv6VR2BBrbxmK1p7FL7qOY3_SUEGeqNWktARkIngAZD4u8Z_659cVO7MEEzJ5e3R-APKM6MnVJ7jk7fzsp16gA7l2FuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffieetueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieej
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggurh
    hirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepvghmihhlhihshhgrfhhfvghrsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhtvggrughmohhnsehgohhogh
    hlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:R97TaecsFg_drJheFrS19Z284P1wzu109CVNuDBXjcsQkKeJcfNJBw>
    <xmx:R97TaS3YPJEYodB-vAW0RMp6QRmKZZuEFhoGK4iwO5J3BixS6t8gzA>
    <xmx:R97TaVgvPuKsQixOZvoVz1OqySVXOsIuB2gub7YnjRZADN0kZPDjFA>
    <xmx:R97Tabk0KvGe5vOjhcTtAN--bLmNFCONsc6zb8BfogoN7XM1fhL5KQ>
    <xmx:SN7TaQA6v4Kruz23wd2JZljlGljfbD6egh3AeEHKtQJ6AhZLBfZbBOns>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Apr 2026 12:24:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v6 00/12] Run hooks in parallel
In-Reply-To: <20260404082934.173788-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Sat, 4 Apr 2026 11:29:22 +0300")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260404082934.173788-1-adrian.ratiu@collabora.com>
Date: Mon, 06 Apr 2026 09:24:38 -0700
Message-ID: <xmqqo6jwcb09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> This series enables running hook commands in parallel and is now
> based on the master branch because all prerequisites have landed.
>
> v6 is just a minor refresh which includes a meson build fix provided
> by Patrick and fixes a trivial conflict with the master branch for
> that specific patch.
>
> Branch is pushed to GitHub: [1]
> Successful CI run: [2]
>
> 1: https://github.com/10ne1/git/tree/dev/aratiu/parallel-hooks-v6
> 2: https://github.com/10ne1/git/actions/runs/23974475271
>
> Changes in v6:
> * Included the meson.build patch fix supplied by Patrick and added
> him as co-author on patch 10 (Patrick)
> * Fixed a trivial code conflict on the master branch due to build
> scripts having moved into tools/ for the above patch (Adrian)

Yup, I see this requires updating the base to more recent 'master';
I used to queue these patches on v2.54.0-rc0~107 but now I updated
the base to v2.54.0-rc0~26 to include /tools/ update from Patrick.

Thanks, both.
