Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BE2D7DF8
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591464; cv=none; b=k0fRldC3SPnpiT9wskL4lCaHdVVkcCx/Rcpapjjq4/FgA9wTROuYlMNbGKl2FrcRCoICf8CnlCWcyclIDBAy41k2yj7JH+qYG2nGzz2HJzHr23K69haxR5AMZ6Kne5I6DyDbPlqP4ukORkgrzZA3FNH181zVrZvAwiK0YYFDdEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591464; c=relaxed/simple;
	bh=VmHES+/UgbF4ChihEoTT/EQs5tsQtcYyR2N33zlG72E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a4u03SG43i5PBZQrcK03u4ya2xnxXjqyVABhk+wyL43gLJbaNNh3/uSPyNdx1g+coxXq6VOSc2HshdnsUxqcdrVV/9gwO1SvLoLlfRIALIMIMn44u881pCmGR4Ub3UDgvxS/X8mtEftPRiYu1bV7jpd7qX2CjPTx8oc6C/C93Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyB+WeF0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qq0Jrtwn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyB+WeF0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qq0Jrtwn"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id A52A7EC00B5;
	Fri, 16 Jan 2026 14:24:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Fri, 16 Jan 2026 14:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768591462; x=1768677862; bh=mDahkNzgvb
	3cp2O7FvVH3ytBH20NlK2a2f5PywBGwek=; b=EyB+WeF0cezLxnnm1T26KzoM95
	DihYAgziNg6Lnh/pz/k3iR2wvIq6pRWX37qFrJ264tDuh9DcOLFFXpvOgrf7vPIc
	+O7VUI39Hs+EYTelIrVypXauo2rVbn9AJaW0KzQMSdPM79Lv2eu11KRwTOTQHXuE
	s2x/VfRoDwqbzwovRAxviW/MA7QeRgnvhfWV2NMcGn1ZMGhKEYPAJhNO4kW2ee4S
	2Po5eoizfCagtknGZ9m6sxWBuMYAhKGMT7i/XVBDloBkk5452lOh0/9FmxsjEcti
	5a0PxWg4aptszh5DkgCMV+RVXZxPb+t+nYKPKi4u/RMvxfUr9U6aZTTQRnog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768591462; x=1768677862; bh=mDahkNzgvb3cp2O7FvVH3ytBH20NlK2a2f5
	PywBGwek=; b=Qq0JrtwnSyy0LQ6osvxSJfkPrghregYCcq+IIC6PcvbiqCu18n9
	TCgo5hSp4N/+Y1u1m6IG8E4Tu6b9yRX5CcS9t+cJoMjmiHYRpvM2wxgB5GGpN50f
	z5qdJOO4hopxCkEgcL56uFE9cVHn3VEt0cF+jaFF4eNC/TbDm7RIIjZ0sd8fweC3
	8vVXP973tyzuM82J+GgG5hnxPYJrUSmWhQQRHfKOr3qHAX/f+PXIUVU8N3YsetcM
	XEmXbtRutUdjac++nf4Kzl1TX0hxSF51hxxzYmoueWQenJwLBsSOwv6/ZJYs5NA2
	lZ4GDHQ334TNthvbGCdnN6XahUN4NGIUJdA==
X-ME-Sender: <xms:ZZBqaZGhZe1jdZQCDre-A8qiNg37ZUr_og_kve7zf0NS4SSwHfhssA>
    <xme:ZZBqaa735YpbWlzI3z6sMNOpJgC2m_6FYFU4wp70xxMEvEKOkpRXdNx_3WnnZZbi-
    39alyj9fHnqJ3sHqbeai_-_36xDzpTO708MnncwkQSmRb6LTDDvCMg>
X-ME-Received: <xmr:ZZBqafkBf2z9ARVVb4tT6spaBIq19c00hQuNpgx98BckclqvT829O5xUARg_0rGXSh0pFTdId-r-mMbVCdwiCA2D_0Xb5RsS_QXzUUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnse
    hgmhigrdguvgdprhgtphhtthhopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvg
    htpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrg
    gssehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:ZZBqaV6O2j3NzJI1pw3xUWLl_j71Gvx7-FJ2doCbYJ3zoYxGMzm-rA>
    <xmx:ZZBqaQTqvNBq4ppbxDpj_i08YpnM-aVg38ns29qZih_tRm2GQXQT5w>
    <xmx:ZZBqaTyzYafHaSBAlF4lIRO4v-zQoVl92r09rrITnoaKNUz8eO1nNw>
    <xmx:ZZBqaYqhseLu4t1KpiZSzSUcdlb0V8VwM2UTf08q5B0FwLV21O32GQ>
    <xmx:ZpBqaZRccNLDB4EL22AqQo7D3qwQWZS-ImPvHmh0eLfM6ziWChDYXWNG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 14:24:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Ondrej Pohorelsky <opohorel@redhat.com>,  Patrick Steinhardt
 <ps@pks.im>,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>,  Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v2 4/4] sideband: add options to allow more control
 sequences to be passed through
In-Reply-To: <bdd25bce-e69a-bc42-b7aa-a171a9cbce02@gmx.de> (Johannes
	Schindelin's message of "Fri, 16 Jan 2026 19:46:56 +0100 (CET)")
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
	<pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
	<fe109cd3319a5e3a1d1982a53963a601bb62b81f.1765981422.git.gitgitgadget@gmail.com>
	<aWD2x154F5f-c3pL@pks.im>
	<aWKLrIefrcSwReu2@fruit.crustytoothpaste.net>
	<20260115211448.GF1053259@coredump.intra.peff.net>
	<xmqqa4yeblsx.fsf@gitster.g>
	<c0af9072-cf21-a7e2-5b78-eb70217b462c@gmx.de>
	<aWnekt4ESo0bKpOT@pks.im>
	<CA+B51BEs7kuJ7s+K2vbZLSoaq3krGrqVncQAaTjSSNazFLY3tw@mail.gmail.com>
	<xmqq3445bn33.fsf@gitster.g>
	<bdd25bce-e69a-bc42-b7aa-a171a9cbce02@gmx.de>
Date: Fri, 16 Jan 2026 11:24:20 -0800
Message-ID: <xmqqikd1744b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> FWIW, I do not think anybody around here is against "opt-in with a note"
>> approach at all.
>
> Does what I say not count? Additionally, I think you misinterpreted
> Patrick's reply, who pointed out that Git should be safe by default (i.e.
> "opt-out").

What I meant was there is nobody who does not want these filtering
changes under any shape.  Everybody is OK with these filtering, even
those of us who do not want to give unnecessary regressions to end
users, as long as it is opt-in.

Unless you and Patrick thinks we should not add the filtering
feature unless we enable it by default, that is.
