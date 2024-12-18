Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953F82572
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483232; cv=none; b=LOGlyY4RWHcQgyVxxhdimZvldlLZR6Me5BPMUAYOSdHwX7dRstumTiyHXKXn0rAlxhzx1MA5uNbjAL80yGUZOtvNftmhSvPZd42Im0+RymeanXfjXBWYMft0qqL9hGQfPIMjSi463kEwWWK+oVp3XjftWklAsc3DrrazQQLa7pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483232; c=relaxed/simple;
	bh=sK5HbsI8LvubContYSSJ8vFXoR8VshsfSQgcQ8lXF3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R1dTSGwGD0zDIGW2oEjj95bHbnrlZh8l3dzbTgMNtPxVIzyzg3yFiShkjv6tN3HUj0JBrmzj1N6ny9TXGDV4Joiff4YoycI/FfgDnSJCblPbdVgmaGU1pDTeA2omX60xBVRSXxos00t3D8nTIhtkDw0VpWYHu/+UuFA43bjoLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UNwGF7OM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2Ug+85y; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UNwGF7OM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2Ug+85y"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96C93114010B;
	Tue, 17 Dec 2024 19:53:48 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 17 Dec 2024 19:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734483228; x=1734569628; bh=6e+aKu+meO
	dNb6yKs0EXro4ITcDMFmRj3nHNaCe6gyA=; b=UNwGF7OMbYfZ4DTIanG1sTX8sa
	kAqsMi/WY2w+aXkkR6mhvLWHkkeZyryvYG9eX1MjV9UeMWKPbk9remgz82mGeIX8
	vbskqnRgogjVX653VZiEwdb0Dp7gLo7qcHfrh1hsKBwPMhWccmh+H3v0I2BOn3Up
	xATgVW7HEBtY4GlxuonY7S+fezjTwYQM2KTr7N4TU2DxzX+XwTti55D7KRK1xiSo
	QLtRZyCj5MKzBcquoXWYNHb4Kgg1FwPPAmexNP1qZqDh0bMBjrvacaLqtHauv3rD
	SdgVgr3BUrlgSzRMEh6bA+NKfr8Qs8ucsBsniBdAIQNxhRYoZGa4uUhm1Ibw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734483228; x=1734569628; bh=6e+aKu+meOdNb6yKs0EXro4ITcDMFmRj3nH
	NaCe6gyA=; b=E2Ug+85yrha+QWa9axUW2/8scXdCe1jdLa9labr19OruUZHjFAG
	Rkh6jxqyrSyKzjHAFYomyOzQnVh6WHDFmfOXMC1HAQjRkzkcGBwd9lJFUPUbUDqn
	9NU6cjZd5JNggzh+hhj292xcv6QeYB6eK3gLT4AB5L3G2vuR+DKPbIdgDzRMtL4I
	NBZWKyCgfsoWjsAFwfuTren9sHD2al4fS2B6dRNlP0H/UBoGSj8N4J4ODS9BKX06
	HLN/5wP93WjM+Qnxirz3bSloCz1l0ZNZWj7ZncPYYUPNsJhU3ZgLIMQ9UQ3ddZ/E
	Ab4vg9jWf0ROU+b45VCOYmd79PAeLKKo08Q==
X-ME-Sender: <xms:HB1iZ6w7Ml8Pjb4vMZpNsKLLGp0J2Zzl3hUYIuUUoWLWUrS1LGaOoA>
    <xme:HB1iZ2QMhhwgO_HlVdYlgr8lJXNgArR5reMoTHjarbCL1GOxmF5MTwheJs9-Ph7kD
    g_L4lx-3KnCW3jzhw>
X-ME-Received: <xmr:HB1iZ8V2xa8eHKrlTWrRSBqCWTO7jynJ28EhYwEFt5a5oyvwrOSnvRdv3BATLxzmReZjJ5j3XCYwHr5y74bdj-4V1AfWotTehvkJiaU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeegudefffehleelhfekleehvedvhfefveekudev
    keegffevgeeihedvudfffeeijeenucffohhmrghinheptghonhhfrdhinhdpghhithhhuh
    gsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HB1iZwj8R9hPGdDXFLNIGE8QwZ2XEnPhwlTlBvgk9jv9PEPTp2tOGQ>
    <xmx:HB1iZ8BDuUaMuJsGp2NUZU0vDmCwlnCAKhvTb1NRwTC6y06LA6WalQ>
    <xmx:HB1iZxL1pgVLCaDaioU0uVMdirWx3qvzRPvrCcDVQacpOWCFmVknfg>
    <xmx:HB1iZzAWemP7ehz9Y4fVQzRZSjeM2G4FkwUwt1OSBLojDOpOe-uaqg>
    <xmx:HB1iZ_86ZgCGj3ebqIrZpYwcFao9b0JFN9cT6OjRO0HWZ59WvhomW-Bf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 19:53:48 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] doc: remove extra quotes in generated docs
In-Reply-To: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com> (Kyle
	Lippincott via GitGitGadget's message of "Tue, 17 Dec 2024 23:47:47
	+0000")
References: <pull.1847.git.git.1734479267736.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 16:53:46 -0800
Message-ID: <xmqqjzbxyfol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Kyle Lippincott <spectral@google.com>
>
> Commit <FILL THIS IN> moved these variables from the Makefile to

a38edab7 (Makefile: generate doc versions via GIT-VERSION-GEN,
2024-12-06)

> asciidoc.conf.in, and in doing so added some extraneous quotes. These
> are visible in the generated .xml files, at least, and possibly in other
> locations:
>
> ```
>
> ```

This is another <FILL THIS IN> that was missed?  Can you fill it in?

> Signed-off-by: Kyle Lippincott <spectral@google.com>
> ---
>     doc: remove extra quotes in generated docs
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1847%2Fspectral54%2Fdoc-remove-extra-quotes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1847/spectral54/doc-remove-extra-quotes-v1
> Pull-Request: https://github.com/git/git/pull/1847
>
>  Documentation/asciidoc.conf.in | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/asciidoc.conf.in b/Documentation/asciidoc.conf.in
> index dbe36a52eab..b89bccf2309 100644
> --- a/Documentation/asciidoc.conf.in
> +++ b/Documentation/asciidoc.conf.in
> @@ -21,9 +21,9 @@ tilde=&#126;
>  apostrophe=&#39;
>  backtick=&#96;
>  litdd=&#45;&#45;
> -manmanual='Git Manual'
> -mansource='Git @GIT_VERSION@'
> -revdate='@GIT_DATE@'
> +manmanual=Git Manual
> +mansource=Git @GIT_VERSION@
> +revdate=@GIT_DATE@

Since 226daba2 (Doc/Makefile: give mansource/-version/-manual
attributes, 2019-09-16), We used to pass

	-amanmanual='Git Manual'

as part of the command line to invoke asciidoc, but the commit in
question forgot that the single quotes are for the shell to strip
and we now have them around the value of the asciidoc attribute.

Well spotted.

Thanks.
