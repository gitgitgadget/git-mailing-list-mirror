Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290523F417
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767105222; cv=none; b=WjoyjZGCdZggqKuekh6jmRIafpNhBmBhWRJZWO+okDpf/+nf2++wL16i+RaUH68XZlwiwiLb/GmrHUsFX9fNbfzQ5uZv9Rc7qIrp3Bwre/7hJNhuyOLC8wabYcOJ46I+Q18SXMW3JqRoulxsxL80DxAVhfEupXpaVS7jW2DsnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767105222; c=relaxed/simple;
	bh=x3WPNjZtQ6eGhtzwFZ2Wfcw5AGFtlEyemrpB/n5ns8o=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WSEPNpZn7/QAqvqtQj8PpkfOawHPbWb04a6C01c8GIP/kmI+wV1JX0X1Rb5YkoUIL6b8ae9GUHnHWdAT+es/g51q+lQ3mgWMLpzo25YceVG6tsCGFDxQIzitKTszVCC8UMGytem93RzKz91cOV9X8FJab6e15MtAxhzstiJRclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=lP/rjKTD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WDi6SnGk; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="lP/rjKTD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WDi6SnGk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DA451D00063;
	Tue, 30 Dec 2025 09:33:40 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Tue, 30 Dec 2025 09:33:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767105220;
	 x=1767191620; bh=UWEAxSWNWEuHycAB+pYJpj+9StNL9N0do0UboNlo8vc=; b=
	lP/rjKTDZ3rK7O92L1+DZa/1lL0LmUhXHAWoxQGY+770+5in7FxWUfdqsZcLLWlj
	CdBCwJeNBYCTAnRm8PpeJki/IzTQiUisv79h7nbRQy2rQxFfZM+oyF+SwgDEWoHo
	18FOWP+4Nbe0KHrmBRlRJjuEq4vyzBpxcQqmAMpOf16TeuU5xQK29Qqdl0XGQBWi
	T2bcXv6vDboVuoltuFLQqLWJ7heEptRpqlX6LuNM0qubliZ80Qf+UhGURFAJ9FPK
	eqgUt2uPPkpVo6XwvjnVcUgvdV6WMX5IcNLK6U6XbNXAchtqP8MPrtY/weaoFbaE
	fdJSH1frQE6Nk+k8AI9rxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767105220; x=1767191620; bh=U
	WEAxSWNWEuHycAB+pYJpj+9StNL9N0do0UboNlo8vc=; b=WDi6SnGkHxEvhn1fk
	q6p0/d6Bag8JV2vILsna8TSsVZvb5IkWWnMKUwQRtwK3igRKuJP7a9RlAD0uZ7bS
	/flFmPiOKkXiG6gdA42nY3JrcBMVQin9PzgfG+ZFDll7OxumrimGsIJvRnHbPCDB
	JfKYw4JmJA7k94O+9WOzEdIgXHbLZYkRMN5yc3GaK2rgzzqXt8R9lcabrKtW/4m6
	0EpLSTSYrA3juuFFp6LZM8+RmvfquBvSlFq5OrJzp8kU9QF2St1vGHbW/GVT0Wcx
	X4p0p3dpHrMmwt5zkBfiHMDNbeSGwLsBkC70V3JUghZbPojDGj3SaEzGuIG/T8jj
	8H6kg==
X-ME-Sender: <xms:xOJTabHOnaGy5XnCsHHR0lQGlkoUFbVHMcYtv7if41R12nElS_n8Llc>
    <xme:xOJTaTLbnnz-ZkB0CehpUYEW-WyR97DyW3ti0pUm6QlpXKSraM1755JSsF0o7sMv7
    tQSsn8qq_Wv7iTPms14dIHYa9veKf2kgOpFg3GOQTTnVYPJ7r8fwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdektddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhepofggfffhvf
    fkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgr
    uhhgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmh
    grihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeffieeftefgheekgeeitedujefgveeh
    vdevieelfeeiiedttedtgfduhfejiefggfenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:xOJTaRxELUj4JbwxdA5LwscMVqweSZ26UbeuF5-7H6kMdz8BE2-Rxw>
    <xmx:xOJTafNwIaBsxIGB1cAVpatWXPJy9eJHqUfz5Nt-2o_KjKqUiwZoRQ>
    <xmx:xOJTaS7ngf1dDTAPqYGxfPz3Nm7srKcmZo5bxLHw9hbk6W9OMz0wsg>
    <xmx:xOJTaQOuAkY3nwWeqz0i4uzUrYPfyI58B7zbgEaJyQgyHhCdutdXSg>
    <xmx:xOJTae5HAjQAAdVUDr65jGxM4ktZGTHoKLFgDTHRO0IMC5hbpVC8dKYS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 600671EA0066; Tue, 30 Dec 2025 09:33:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABuEtyptUL1k
Date: Tue, 30 Dec 2025 15:33:19 +0100
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Message-Id: <460f1f96-4236-4d19-bdfa-6c86bad811c5@app.fastmail.com>
In-Reply-To: <xmqqa4z0f5dq.fsf@gitster.g>
References: <xmqqa4z0f5dq.fsf@gitster.g>
Subject: Re: What's cooking in git.git (Dec 2025, #09)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025, at 14:47, Junio C Hamano wrote:
> * kh/replay-invalid-onto-advance (2025-12-22) 2 commits
>  - t3650: add more regression tests for failure conditions
>  - replay: die descriptively when invalid commit-ish
>
>  Test coverage of "git replay" has been improved.

The main change is a better error message when you give a bad argument
to `--onto`.  The improved test coverage is secondary but related since
the coverage for simple die conditions (like bad `--onto` argument) is
poor. (Like the mistake that you pointed out;[1] I was about to make the
error message for `--advance` slightly worse. But the test for =E2=80=9C=
argument
to --advance must be a reference=E2=80=9D will make it harder for me to =
make
that mistake in the future.)

The second version is coming now.

=F0=9F=94=97 1: https://lore.kernel.org/git/xmqqpl85pb7k.fsf@gitster.g/

>
>  Expecting a rework on the bottom patch.
>  source: <CV_replay_die_descr.13f@msgid.xyz>
