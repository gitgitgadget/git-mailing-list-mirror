Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F92033BBC5
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775643152; cv=none; b=ecrGhGnr0xRasOWfLITRe1IbM/yCylUufQLPbIX9PxcEfNd7xKa4vIK6AxAftOAcNJUtaT7zP34tiOX3ZC8FFypgnw3jPvep389dE0ZDE+htelx0Rk0O6FEiEsWwextMs9MaDz5l2vO4DSL/Z8sNwh78ipOvs2SapBO7VGGymfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775643152; c=relaxed/simple;
	bh=XP9ef0C55spkPP1Xy+KooydzcseN657JJXNnAA2oIVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KsHwRmVEzTY3F3gEvufRV8+i+Xbf+4RqaLkd0QJwxMnF2vYFTLVTdZU6abW2SFD+XayyM05HqmCW3zQni3UvLl4kNUGm7I7NKRq+nb/LEEjWZtaJ/iPGnJMd45WXt7fTj8+2V2awcS288n4veG/KJReVvn7DyJrgL4PdFOGjccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WfiDjWUO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fZcZTDLY; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WfiDjWUO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fZcZTDLY"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F2A47EC01D7;
	Wed,  8 Apr 2026 06:12:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Apr 2026 06:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1775643147; x=1775729547; bh=YawQiYKgX7
	CfifEuBEEJhkHQct4AoO0114XTRQEOGeM=; b=WfiDjWUObMmjtWK+SA65I/LXG4
	dJ5FsshU+en/QdhxQnnu7+jiYvbBAM1ZaeYzGyXk2qYCjmPlyiMg1ilvLajVPA8s
	KnOhHLRBxr8ZZYEiOdrZi0cjpkDg+9OQcz56QrLfd5yAPJMqvq1VGD2TOMptfvO9
	vSXI6nfpd7zfXpi+jCagdR1hYQrxm7qzvugWexpxd5FrKet28Rg/iZ434Ptjbf4E
	gf78BlNYnsPu6gsLPKC8IJhivFS2Y/QL/2BeSe7jOUuo8bvOyiQQABYjRGdFd2ED
	d+ce44GEwL3lk/lAUuaNRmS3k2d1pmNgO7W+BL5pKJza4N7o+lTovorItDWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775643147; x=1775729547; bh=YawQiYKgX7CfifEuBEEJhkHQct4AoO0114X
	TRQEOGeM=; b=fZcZTDLY8aBxlAuKA4noLGYW0PKwn+c5UIvbVD20SvWX7C5pXkL
	Zu1OL52YUr3OJa0N8xlWlC+wLvycO75R4Pcd/ACCzIqkWPeT02GLeu6swfmXVTbv
	aaoajq7QwaORA+gHinlZ6NauQy0tOzdm2/O7MDFkmcyUM0DY+B+L4BjICR+QeOnf
	kuJpI8SyEcW9GsgvLTUd+rZIqpqQFoQib8N/s+52iGdqt+9nqWzmiqaIvfA/Fs/3
	Jex21tT0GrVD992z4yWZDs/V0zKuaG7aweKwa+rM4tNtJME+khB8XFq39e3hoHjc
	ubfNvVSdpTvmoSl3jALxOrEbuPauO7dRF1Q==
X-ME-Sender: <xms:CyrWaZe20frUe90o-8zA6hD6w1-7cRgKbAFusx7fMFNrTzKsJYUdUg>
    <xme:CyrWaeMoud0qjtKUFfuH1zRSJGBjIZDPTkyRMkvkK0OlrJkH2tgXI4TkJ8UaRdYqK
    q97HOxAzrMLW6lpeYCnVxn3Tc0XImHXMcu4fOz45QumOGmRlDBS2g>
X-ME-Received: <xmr:CyrWaXhowLtsO6n76tFX3ZA5xnGG579yg2XAEVWlezOH6nWcaB-tTNdUauTqlvDjJiR9LxCjfgwcozJKUdUeC4SjO8Bt8cHJsCMPCc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvfeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohho
    thhhphgrshhtvgdrnhgvthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:CyrWaR1ZiAbVcMWI3meunUccVH2YVdjwNMDu1XYnXj51D_NzoqYQPA>
    <xmx:CyrWaRg1G0IF1ZVFqP-8A7wg6AxwIO2wTQOi84eEYN-vWe-kT6LZxQ>
    <xmx:CyrWaRd5_6c8hBrWSbipgWeNb5QfTGKXKCqORCDHPIElx5C4pdooEg>
    <xmx:CyrWaUlMsClSFNuOl8dVzHFBS9i7nffbMnW5GJpEZbGW8Xyxq6uS5g>
    <xmx:CyrWafQaCTge6vwzP7H1yuBZ3j74dvPFX5hdonXnJokKWw8pD3Cgj9AN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 06:12:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d319d65d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Apr 2026 10:12:26 +0000 (UTC)
Date: Wed, 8 Apr 2026 12:12:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 4/4] Enable Rust by default
Message-ID: <adYqB0Ba65FEGHNB@pks.im>
References: <20260403011249.4133372-1-sandals@crustytoothpaste.net>
 <20260403011249.4133372-5-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403011249.4133372-5-sandals@crustytoothpaste.net>

On Fri, Apr 03, 2026 at 01:12:49AM +0000, brian m. carlson wrote:
> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
> index 28cfe730ee..bf1fdbe968 100755
> --- a/ci/run-build-and-tests.sh
> +++ b/ci/run-build-and-tests.sh
> @@ -10,7 +10,6 @@ export TEST_CONTRIB_TOO=yes
>  case "$jobname" in
>  fedora-breaking-changes-musl|linux-breaking-changes)
>  	export WITH_BREAKING_CHANGES=YesPlease
> -	export WITH_RUST=YesPlease
>  	MESONFLAGS="$MESONFLAGS -Dbreaking_changes=true"
>  	MESONFLAGS="$MESONFLAGS -Drust=enabled"

I guess we can drop this flag, as well.

> @@ -30,6 +29,7 @@ linux-TEST-vars)
>  	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
>  	;;
>  linux-clang)
> +	export NO_RUST=UnfortunatelyYes
>  	export GIT_TEST_DEFAULT_HASH=sha1
>  	;;
>  linux-sha256)

Do we also want to to adjust one of the Meson-based jobs to not run with
Rust?

> diff --git a/meson.build b/meson.build
> index 8309942d18..4e1a58ee01 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1746,7 +1746,7 @@ version_def_h = custom_target(
>  libgit_sources += version_def_h
>  
>  cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))

We should probably move this line into "src/meson.build".

> -rust_option = get_option('rust').disable_auto_if(not cargo.found())
> +rust_option = get_option('rust')
>  if rust_option.allowed()
>    subdir('src')
>    libgit_c_args += '-DWITH_RUST'

Patrick
