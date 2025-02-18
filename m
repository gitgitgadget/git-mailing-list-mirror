Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D581E51E0
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 18:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739904911; cv=none; b=btdS4j0i/FmNnnM6vb0wI7Ab31m3V3JEHCyc7VE9jG9orhbZgSOYzLcWWxvg+J2bJVtG9p8u88VlJmaETU+SlBHcqHguJ3wewztW6yn92M+3anmYF63j3y5/C5CjVyJv4aJwkPAeu4tESC4ZLYYOxVw+Sd0sLvs8ov7VwZS1trQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739904911; c=relaxed/simple;
	bh=uED9btz4GY/hj+I0Tdg5qUo+hc9ZR3nkk5/n7Z7Xjaw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tg6RCa0rFZWyHyYb+ZAM9lqv4MeLVwk1BlMrOI+p8Wpe3RkiA4EihwmaV+PiTGKm1XeKAdkai1DVPN2Uczh1+heE9TWVa7fIsSwWuVoc7f+KUIbJwIHqjUUTXoogDaH8KNc6NHDDTDaTWBwr32OFB1BTTSx8968coPCegqgmAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F5k4N5Vx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCZ7kNMl; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F5k4N5Vx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCZ7kNMl"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id DEFD711401C2;
	Tue, 18 Feb 2025 13:55:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 13:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739904908; x=1739991308; bh=a1qDV8zKuA
	3Exjg0I6JUvMEjjWZ0ge3GvRTUQ1p9gBM=; b=F5k4N5VxIjb0XO0DSI7cNvdksJ
	P7T12Jz0G4XErjwK8WUgHvOtJkCLPg3tIYXEoOWrXKQSJeT+LIsM1087FO/glNcX
	WgqZqN2UWLVx9+bmUSmIyhFco2W6r2p6N+FNHhfp8nMF0vzRFjMJcQzJuMIYzqLb
	vtp11IY7qfKtSGrpkQjy9A7RvwqelGqGLmovIrS3mmEFDbN1fdt+kGhpfur4O05R
	TeHT5EUWsjZy4yPfivBmoqCDuqigapbacb7r0CnEjNG0wRJIv8DKVN0Iiuj4tlIH
	Dc+81jN66HNbJjPkF1x4FVuZiPI+LRl09MWTD6c7wPVmQaNK2uv7lLahItcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739904908; x=1739991308; bh=a1qDV8zKuA3Exjg0I6JUvMEjjWZ0ge3GvRT
	UQ1p9gBM=; b=NCZ7kNMlcp4Za6JkcdGCH1uNiBshXXRL3n6xiuMf2PGZiQCv0SQ
	DnGM/vptUTauOypXTasu3inGTZ3m/M/fmUA/b9dhMANj5mMpdxp2sHw7K1uYz6FX
	AsQO2GD8ZH6njXoIOX69/Hg31+q8ST09Odmmadp8zbKL7VAEh8sf5vhBzTXk6wza
	phhhGFpKXhUQzF2yD4KHejiNKAMsi3bL+muW5jIUbvImRyc/NFQJsVnMKLG+zilA
	53WYIT2aGUSpKEpU4mJVlebbu9dusHdHdey8t+L9zOa5QU5nk25IbFK7c0XdCNhx
	Vz8oJ2Pw0S5tFHW5hhFmmUIOxqalB3Mtekw==
X-ME-Sender: <xms:i9e0ZxDy_oG8g6EsEZcc4i47BG-A93zjWBNWccewZPhtUWDqnPyMoQ>
    <xme:i9e0Z_iMvbUnL5JUnTIDHBc9_gsBfFUAfq1xecfxXbX-3_BWo6haGu-CgpjR6J2Td
    7G2TC5LnowTb3rqMw>
X-ME-Received: <xmr:i9e0Z8ktXKrym5Aym1nExWgXQ6FPNjpQXvNxdgrM9OhDzbjvtLdgcWkc0mw3j1G563SjXCa2i9Lz_kGh6f9pR9YCTGkWvdHlwtIZWxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrug
    hthhhomhhsohhnrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepthhoohhnsehi
    ohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i9e0Z7yAkSKIi7bVYVx1hjttiwuFbpYqsda241OLtiFg3ZxYkinbrg>
    <xmx:i9e0Z2R8MGM7SOFvwVji0mhXEnFJoGy1Kkk0JhJMaW58ZU3H7_C1zQ>
    <xmx:i9e0Z-ZqfbBhx6OAmauwPYsbQYLD2yB05bRepl3_lKQeLQLOAluQJg>
    <xmx:i9e0Z3S5FkYdyKrLn8E7ju6mxLOtu-n8HmSmU2MCXCKO0gCBSPXz-g>
    <xmx:jNe0Z5EahlCoWMEA2nAgv8M1h9JD_CN79dMQ6uoB2K-N-SfwhsGbiTJQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 13:55:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  Justin Tobler <jltobler@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH v6 00/18] reftable: stop using "git-compat-util.h"
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
	(Patrick Steinhardt's message of "Tue, 18 Feb 2025 10:20:36 +0100")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	<20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
Date: Tue, 18 Feb 2025 10:55:06 -0800
Message-ID: <xmqqjz9nkrqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v6:
>   - I have rebased the patch series on top of "master" at 03944513488
>     (The eleventh batch, 2025-02-14). On the one hand this gets rid of
>     the conflict with the zlib-ng changes, which have meanwhile been
>     merged to that branch. And on the other hand it pulls in the new CI
>     build for MSVC+Meson, which allows me to have better test coverage
>     on Windows to better detect breakage there.
>   - Stop moving around Win32 files so that we do the minimum viable
>     change in this context. Hopefully, this makes it easier for Dscho to
>     integrate into Git for Windows. If it doesn't I don't really have
>     any other good ideas for how to do it, so the only alternative would
>     be to just ignore Windows altogether.
>   - Link to v5: https://lore.kernel.org/r/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im

Thanks.  I think the "unlink" thing on Windows I have was queued
depended on the previous iteration of this series so let me make
sure that I'd unentangle it while replacing the topic with this
round.

Will queue.  Thanks.
