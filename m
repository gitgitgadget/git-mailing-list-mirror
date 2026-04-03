Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03451A23A6
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775192693; cv=none; b=ag3D3yRvRhfBlTqN8T6n8Ve0gnVSqPQT6uNsD2VY07Zd3oed3JgPre7AraIrCqkZSr0dPpKTFKbhFaNC8N2CXANu4iZ/B05hBpFpPe2OHnEBODqOI6ZM2vLrx4hzGiqJ+ASO4enZhkUyJiBGBcgb7WRexhbLDzBTvWdkc9E3FCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775192693; c=relaxed/simple;
	bh=bvP7eRlKxGgUlD1IgrKkoG7buwaqwiYbVJTFmobrJ54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CcpiI+nj336j3s6ANoymqR/nzOoCbuf2P4xGBxJm16/I0kT25ZHb8cPMSL4dVAnUoSoaxjiTgs1mgBYMcRyfa9rpDRe4AMeTI4YRONE2als8nHVXwgEJ610RxrxxT+PJ4cfnaTCTt0KoLxXsI7kU9PAIcTvH5+NcH+n5snfFDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wi3yOKMw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qxyTEfkt; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wi3yOKMw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qxyTEfkt"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BCEA51D0020E;
	Fri,  3 Apr 2026 01:04:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 03 Apr 2026 01:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775192690; x=1775279090; bh=iE8LBwXoLt
	+JeHncCti+hafuD7UOYp/EsbzV3L+dZ9k=; b=Wi3yOKMwTJx+lgjQNIgZRlLF43
	Onzfow/Vf/zGe5a0yBCcpVrAgsESQ2CEC/nMHqH+xoKbNxDJNUkL9ODPma+hL6Md
	c4OhfFLiFdL4nmhCLfSJbdlZ//0SdRvKVNkJ2j8G/Q9qq7a0e7Ui+/kryMhafzqj
	odh/0F2DwL1m0EFbq3/Sh+jTbKrPJ6JRTZO6u0lnuHyNTzXAp0dVn4jA7EWJxmZX
	CZr5g+NsxF3EB+Nl1ZYfSJ1BEDv0qGoOMPkgQc1DSFTLMr35hBMoYlN4vIR4n4IP
	TGul3qEaynydSOVJIXh6zmsgf5rINppJg5JznEzq0lMBFINgABcctyZL+rCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775192690; x=1775279090; bh=iE8LBwXoLt+JeHncCti+hafuD7UOYp/Esbz
	V3L+dZ9k=; b=qxyTEfktCBg2GzLGxCw//vrCZeHvv/Ao5Y6fisy4eKlAEDr6sSM
	zcKeLeEU+pB7s7mjiLOC+4ebSXLshUBOn08wWtKouthI52623tVrODTziMzdkUyT
	PicKjEHXXVbut7CPrTFAvkHK21fJfYEMOh1RaKlk2AZI/02TQMnhxKV+a8gr4hj5
	4MI8zmUBOSSMhHRB87gyQqHcxyWKHIbDIPJUUtY3ZhbYnHQHluR2ax+7Eklmgma2
	xn4FVCINt5cImiTan+KYTCaowX6Gq3raITSGRo7ixVr0PVrpbs1+N8QZgWhbp5U0
	9QAHfWGpjGvTaJbkcPDCwQEGxDz6q9aSgXA==
X-ME-Sender: <xms:ckrPaZoaX1hExMtuhYMVuJOmQqoZlwzqn4lzcWs9quMXxpnmRJjq3g>
    <xme:ckrPaSiWiT8tLRzWUJGYYEwr9hoPLiTBXfuKka3waCZOktaZ55k00jiyzxR2V5TNQ
    jxoMMWPPGvMDO02vhuUalzP_kAXBlFoIoeNXaTTpV1KO3wa4GKHNA>
X-ME-Received: <xmr:ckrPaehxb2psf3MxMnDlmKLBQgQRUbWaKU5Shh5jaHCz0M6cFoIW0dyLZlMpthQo5hHD0htBCNGNTvAdzEP2vBvMLZ9ihkOY4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ckrPaQgaSynvU5v6FqLkin5fKmSKz2pPvBhIcwzxpL6iJZiZci-4DQ>
    <xmx:ckrPaWIC0zKwu6voR1101DFJGUFUAYfrjmnPKwzw38QsRLgaHtYSPg>
    <xmx:ckrPaXFpUGpx7Pb_LgWviWSmF4yVLReqBVAi1hbl8tfFlaAhIq_K-Q>
    <xmx:ckrPaSSzXQsMMYEaYONRcdryKeBN1W2D6vgO78_nDzT6JY2KxoXDpg>
    <xmx:ckrPab33iLrQXurCO-YDkMrD0s9XZrs0dzvBfEwsLccsBfDoQqJLqRJR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 01:04:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/4] Enable Rust by default
In-Reply-To: <20260403011249.4133372-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 3 Apr 2026 01:12:45 +0000")
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
Date: Thu, 02 Apr 2026 22:04:49 -0700
Message-ID: <xmqqldf4ocr2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Our breaking changes document said that we would enable Rust support by
> default in Git 2.53, while still leaving the ability for it to be
> disabled.  Unfortunately, we forgot to do that and my time machine is
> broken right now, so this series sets it up for Git 2.54.
>
> The first patch updates the documentation accordingly and the next two
> fix a few cases that are broken in our CI system.  The final patch
> simply enables Rust by default except for two jobs to make sure that we
> continue to build correctly without Rust for the moment.
>
> I didn't force Rust on with the breaking changes mode because it's
> already on by default with this series and it seemed unnecessary.

Thanks.

>
> The GitHub Actions CI passes on all platforms with this series.
>
> brian m. carlson (4):
>   docs: update version with default Rust support
>   ci: install cargo on Alpine
>   Linux: link against libdl
>   Enable Rust by default
>
>  Documentation/BreakingChanges.adoc |  2 +-
>  Makefile                           | 10 +++++-----
>  ci/install-dependencies.sh         |  2 +-
>  ci/lib.sh                          |  3 +++
>  ci/run-build-and-tests.sh          |  2 +-
>  config.mak.uname                   |  1 +
>  meson.build                        |  2 +-
>  meson_options.txt                  |  2 +-
>  8 files changed, 14 insertions(+), 10 deletions(-)
