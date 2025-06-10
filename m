Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD8231856
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749569554; cv=none; b=Ju1/7RJ3kvepIk421YxgxKwCtdoAs84LbxuEXGhR14t2Mp6kNPfv9SR8xnronTaG4bqOH7ugo7wI+TjYJNGhHV7nw24lCB5R0n6ae+HBt2+xGZ1P/E5WrNN1dnVIMop/JgOkH0aIunD7zOW8fpxCepw3nC8/s5VBpg23GhJLEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749569554; c=relaxed/simple;
	bh=z/oB5xrP5Q7+gfg9KnTGjkxYh4PwAPxDGMpy1nbFsXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pemVlHl6cZZzbTjPhlfU5S7PDBIWkBQymMvwjyMZ+aLyMyBn3avWsP2VcVK7wbQ/CMf0QTItIZAIRnt4E01Nf6IyU8z7z5EOG/lCyKEihoigArolf8anAV+MiGDXbF7plpDpMQxtG6nDOZBEe4kXCw+Zo2LK0WJzd3g3ixEWzE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HbSpYVJc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eef3GIA5; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HbSpYVJc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eef3GIA5"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 3CB3C1380044;
	Tue, 10 Jun 2025 11:32:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 10 Jun 2025 11:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749569551;
	 x=1749655951; bh=GRut9Wi00isu4VoWpPNjpCoFG+ijJMfCdNocHYereNE=; b=
	HbSpYVJc+x6CmiNarpTPg40dAa9nNQudcenX5rR2EkyS1P3OfqHh95EByKiiMh9a
	FsPQ9h/nVlfA7kiagpjZhAoIfF6Vtmib8TlouMBYx8KUsuftr52OuXCNKV+UFs5x
	BmPhK1RBfjHWpr7FAUxsJ7IPoZapqNNc044c+ndvLd31jpKtRVXTJuEV+6Rp8PzD
	0tNMW6qDRPOA6F2FsbUHLuJaKRsz1HdEM1Wk2AQjqRXO6CEYIn4tkDoiNW84OENt
	2ZX9r2RxYzOsStvrRxPvFh5lDYiN6goOtGNgkeDwKbjwyRzDQsdUlx/NO2FjLARG
	S/XFdx+bMQqS8Y4Z5Hzj0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749569551; x=
	1749655951; bh=GRut9Wi00isu4VoWpPNjpCoFG+ijJMfCdNocHYereNE=; b=E
	ef3GIA5QGFu+WS4r8K2W2ajRDju5QEXf3raPI5wZrRT5mRmiy4we0zys3KOSwGKV
	TJJJP/La6sMnTFWJwaYJoRYaTEaiFOzJxqy+OP4vG0t6zq4Ok8e7cmpf1v4tt/o3
	zjMEXWlVIwSzL346ltMsK/EmJfi5D+crZhs/MyAiMaeUJoY/MmQ3t3MDEQGMwaqO
	dtJJY/zjYMuEVYwWDuIilDcjwa4qDagWTJJAh4C/hFAnYWeLO1Y6laEKYCQludeM
	BQLEh+UCGYdvDEjUdEP/nSLmbxLKOiIW94FU7UwFNWLp99wQNfpvygm1w2Cu4pe7
	O0bRXkme0m4Ttqeme5+VQ==
X-ME-Sender: <xms:DlBIaMGMl3HzLyp4VPAvu69-pfwxhtR-RaclvfU-VhiaoVsJN_jdjg>
    <xme:DlBIaFVw3u3Rju8NblafWP5dhCwvRwEb0mMwckpUhKUBoqaNOeQQE9bztSgsZyUq6
    iDM2X-P9sfbagQZqw>
X-ME-Received: <xmr:DlBIaGKKXlzAQo4_WO_eilpjLDO0HUCkI8_ttt3XcIk0tF0TRVvBjidNu4wQU-tlWVtiV1lfZaJOv7F3Ba0GpjnsZpS7NiPIDaO1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphht
    thhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:DlBIaOFj0BdDoSwh-jwKNpUVL_Pz3CjIelOJl-APyMuqhnB_I598nw>
    <xmx:DlBIaCVxJstUt8Gcvl_FB0wxMfhIlJMMCohWvEg4I8YZpZAbN1uxMg>
    <xmx:DlBIaBMHCO6Brhe_XdOkniHidjmbA5xA5C7axV0U4wJCBaAtpIe1Sw>
    <xmx:DlBIaJ2m5wG_hjxVVXFVKoOGwpAxtZaFsgypSAtbACheS7yWl2Ni8Q>
    <xmx:D1BIaMAY6n6C9_OvgRtGL23DnO2LeU8BuoMimd-AB29Oft3BCJLQm1qw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jun 2025 11:32:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ramsay Jones
 <ramsay@ramsayjones.plus.com>,  GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [RFC PATCH] test-lib: add missing prerequisites for Darwin
In-Reply-To: <CALnO6CD-2sMOkCgaucB1SYq9Cwiu4hvc-QPa9nUN=GsmozWh8g@mail.gmail.com>
	(D. Ben Knoble's message of "Tue, 10 Jun 2025 09:34:36 -0400")
References: <aEcq7sbPx57r-qKK@pks.im>
	<9E2E7CDE-907F-40A5-8C4D-BBE57F7BA08E@gmail.com>
	<CALnO6CD-2sMOkCgaucB1SYq9Cwiu4hvc-QPa9nUN=GsmozWh8g@mail.gmail.com>
Date: Tue, 10 Jun 2025 08:32:28 -0700
Message-ID: <xmqq8qlzobn7.fsf@gitster.g>
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

>> If I have some time today I will run the test suite with this patch from Junio’s tree on my (old enough to be unsupported hardware) Macbook and report back.
>>
>> D. Ben Knoble
>
> I am happy to report that my run passed (log attached). I also
> spot-checked a few test scripts that use the prereqs mentioned in the
> patch, and those executed cases with the prereqs (e.g.,
> t1700-split-index.sh exercises POSIX_PERM via 'same mode for index &
> split index'; t3700-add.sh exercises BSLASHPSPEC via "git add
> 'fo\\[ou\\]bar' ignores foobar"; t7502-commit-porcelain.sh exercises
> EXECKEEPSPID via 'a SIGTERM should break locks').
>
> All tests successful.
> Files=1023, Tests=31723, 1197 wallclock secs (13.48 usr  5.16 sys +
> 2162.62 cusr 2883.19 csys = 5064.45 CPU)
> Result: PASS
>
> Acked-by: D. Ben Knoble <ben.knoble+github@gmail.com>

Thanks.
