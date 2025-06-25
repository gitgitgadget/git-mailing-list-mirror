Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D33726157D
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750857462; cv=none; b=K222UIfTAHj/t+2L388CYvPGTlX5cabOKeahNGvOaynlIY7nLfKYE6gar8eZpxGWrzbQ2zerK6QGL73vCVFUItH6ESAdJX4O+1929lIhiOuiPeWBLvfS/eRLHL0X6qxmyRa5GIBDRv83I1FGmu/aOfL6C21qoGeEHwrVYQMSWfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750857462; c=relaxed/simple;
	bh=0hply5SKrlKDdIauArekM2OVpKs9I7q5nyekKRZEv+I=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=keQM6TYTijY6UCNVu0StwnvS1nW1D9+xEddsVg2sVKQTX4491ZwXDfvhizNnLFQzvLzVK6+ayt6vdmE6pVwhhD56ceJDT/LH0xt8DP9Rb14x70sG/f+y7yHaIxm4ByejlJVpOdclLqjtrLYHAN6MziOyaxZr3IxlN0mZYbcE3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Pyj6d7M4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZcuqkI3v; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Pyj6d7M4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZcuqkI3v"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AAAA1400252;
	Wed, 25 Jun 2025 09:17:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Wed, 25 Jun 2025 09:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1750857459;
	 x=1750943859; bh=M/G7IEJILwkqDwmMGLL6pK1LwApdvwlUEEb93yVC9p8=; b=
	Pyj6d7M4guPHR2gG3wzzrfKzynZiHVLp57GK2zouPBih0Bav1yWliHymFTFX88/A
	zMrFgdvyQUSWvZyKjDlmDU0fIZ8LM8hVsb8ozwPtWY9rJulHws5FttLY9jxcdNDB
	Ms7Kj3Hf9MeDJf/ZHUC3Dgummt4HhmUW+V8IYRobGbTxO6EFP91/CPV9FE25Ih5d
	hB7j4HS/MrJkh4O6Ex3W+BEkptZ5QMP0OQxu01tbh7vIlR2tVEa0FoZiI8H4es/A
	vkji8I5e/G5AAyJd8UoGdDRwgeGzTpqu97Rh9hDT/m1KnjQfHZwqfiKuk3A/8ZGh
	8Bo2NMUGTYZ5UjSBQrL0aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750857459; x=
	1750943859; bh=M/G7IEJILwkqDwmMGLL6pK1LwApdvwlUEEb93yVC9p8=; b=Z
	cuqkI3v9j7GD90HCdFyfKT3iu5Q5d4umpMhu+fn36D2XwakgUZtKiMjiRnvphAGe
	ar32625gHW7/gYpI7jmYgkErlevXr+YXh4XDarkQMZXJSVyseMTJg/RepEGVdKNI
	4lAoHyyCOYQ5sxmEtlWQTljLZ7bjSbpv4UhRbqn44JvHFcwGG/nPtVs6jp/n9S4I
	uSruiaW9G6/02Hc1xf9YpUp4qif+o2lcgt1pVe0bRiQrsNKVaFAZ+TvUI+kekZUW
	svVd+nK/gYs43V39Um5ogsV7ecwqxraglI9nWZZ6E+29IrbNYcFOe3Umpufo9kbr
	yS5OLbpmuC9D4G5Drz6jg==
X-ME-Sender: <xms:8_ZbaDgefan0yItHlMEG7XFceAAB0zq0LgT57WP9GflY5OGJ10m46Cs>
    <xme:8_ZbaABKAkeBgodwqW8bMWcpecBlXTR7_N7Q8n-_NACaaYR9ls7X4RXMx7VOfwiCi
    AhtzHJQcL7f1XHp_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvvdekjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishht
    ohhffhgvrhcujfgruhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeelfeejudejfffg
    leduheegheeufeeffedtgfeffeevudeuleffgeektdelueekieenucffohhmrghinhepgh
    hithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrd
    gtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegruggvsghskhhisegurhhophgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:8_ZbaDHa1XlWnGOxZ8oQrEKG9x5CgbB4PvlVUw7lvUDw-XV0MwCQkA>
    <xmx:8_ZbaARZJeohI33mxQyiL12plQqXuuUtjAvFfraPu9gRiXpSjlvbwA>
    <xmx:8_ZbaAxD1ANN9g7bsvnZ1B19SumrQh0zIGIZdPhiDXUIpzkYrgCOhg>
    <xmx:8_ZbaG7wkw2v-ZNMw2WDpPSkjWYNBIdv0zfpcOFS_aRgiV2fK-rr7Q>
    <xmx:8_ZbaM-0vNnvE6UzbJfdzpuBTRYQnq7wjFr0M73QsW13b19l4ExDSJa_>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id EB7D61EA0066; Wed, 25 Jun 2025 09:17:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Te6745ba8610a877d
Date: Wed, 25 Jun 2025 15:17:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: =?UTF-8?Q?Andrzej_D=C4=99bski?= <adebski@dropbox.com>, git@vger.kernel.org
Cc: "Derrick Stolee" <stolee@gmail.com>
Message-Id: <c0170328-764b-4d31-a66d-5ac56ff87be7@app.fastmail.com>
In-Reply-To: 
 <CAHKcSH2_Xse3o5Cq88Fu2s26AAJGNJMGeSvgHAyp-RLruVPnJQ@mail.gmail.com>
References: 
 <CAHKcSH2_Xse3o5Cq88Fu2s26AAJGNJMGeSvgHAyp-RLruVPnJQ@mail.gmail.com>
Subject: Re: Possible performance regression in for-each-ref in git 2.40.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025, at 13:28, Andrzej D=C4=99bski wrote:
> One of Dropbox SWEs observed that a specific git command in Go
> language tooling
> https://github.com/golang/go/blob/e515ef8bc271f632bb2ebb94e8e700ab6727=
4268/src/cmd/go/internal/modfetch/codehost/git.go#L758
> took over 20 seconds. Internally we distribute git 2.46.0 right now
> but the SWE had an older version of git around (2.39.5) and observed a
> performance regression between those 2 versions.
>
> We've did some performance measurements and the command like "git
> for-each-ref --format=3D"%(refname)" refs/tags --merged HEAD >
> /dev/null"
> spent majority of time in function "tips_reachable_from_bases"
> introduced in git 2.40.0:
> https://github.com/git/git/commit/cbfe360b140fe92d9c4a763bf630c3b8ba43=
1522
>
> Similar performance degradation can be observed in git 2.50
>
> Given that the command references tags I've experimented and observed
> that the command execution time decreased with the amount of tags I've
> removed from the local copy of the repo.
>
> Context: in Dropbox we operate a large monorepo with around 65K tags
> right now and growing every day.
>
> The question is, given the same command used to be much faster in
> older versions of git is this considered a regression and can be fixed
> in future releases of git?
>
>
> [System Info]
> git version: 2.46.0
> cpu: bazel
> built from commit: bazel
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> libcurl: 7.82.0
> OpenSSL: OpenSSL 1.1.1w  11 Sep 2023
> zlib: 1.2.13
> uname: Linux 6.8.0-1029-aws #31~22.04.1-Ubuntu SMP Thu Apr 24 21:16:18
> UTC 2025 x86_64
> compiler info: gnuc: 11.2
> libc info: glibc: 2.35
> $SHELL (typically, interactive shell): /bin/bash

+CC author.

--=20
Kristoffer Haugsbakk
