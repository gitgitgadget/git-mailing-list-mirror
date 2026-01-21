Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8131130F7E3
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012790; cv=none; b=Ls39AGTj88Aob9028znR8nHxIkAuNdLNOqQwE3U2ZwK3gR2MO9O2dMmFm4Wl3XJgVBa2q9iT5EZP+nRf3ycfTqb1ia/mQ6gjYe8zXfO/54do+pXdPeYG7dTR+nWxxNMjIvOFYOae2fD0K/n5zrcD7Lfm/Pz4ZBx2tV39W0LGnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012790; c=relaxed/simple;
	bh=0kYFiKpruaRUau/dWeVvVTCLRfRuSzYi79WRN8nEfw8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qDVIe19FOJR5nrUeTa3zRIU4eJwrC3Vb2uoVkSW5UZPJP+f4GTZD9HFBvc9LxuiHAnLiHwK9HOuhS5F9zPZV6YycfClJELKv/QCGkjOTiVSFytJefh8fbqG60SfON5WQHOGLqou/TF4RrDAuXUDqxbTG1IpTaRJLSYejbzHGhH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WlePODkB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uKZV5jTe; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WlePODkB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uKZV5jTe"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 929CEEC007B;
	Wed, 21 Jan 2026 11:26:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 21 Jan 2026 11:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1769012787;
	 x=1769099187; bh=JK4MBdO5Sg6/2C6CrzcxWOrTTEet6ncMEsXgJCFTdkA=; b=
	WlePODkBwVuSV7o1q9gl7c9wC9UQBTR97IhM4rLZL490hpIE4Em6bt426p6n4kaI
	ckN3d/Vr2DgBReo585ql3OFF2nUcTnyESr8KyDW+ii8PPiXb90RokfMORHrpq4Ix
	WAVU0cyXGE5ae3ApUVfHLD9gH5hXK/naKovHKTjB8rZIlsf8dcVTx9fVq5eGgSHt
	BaVuWE0G64fp9EAVaw5w9d9KFi0+r7Prcg0K4T1FemJfGhL8FAB222n06+3YvUtT
	h74GhaF5Bq45clNv3awIRBeQpB6YphLMt3ApxMZ/nY7JP2CTO5QlkZ5svFmk+8gJ
	YhQNearJRFPMm/icNTk+gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769012787; x=
	1769099187; bh=JK4MBdO5Sg6/2C6CrzcxWOrTTEet6ncMEsXgJCFTdkA=; b=u
	KZV5jTefeFs/92P4Nwgwzb72uK4XlVF9bPg6USRKDqbQ6rZfFvWSpBzONd7IMBfn
	iYall7clvnQXZCJwsVDDtv+ZT+tqOuNeLDY3avOzoUNAW04c+NhQruw71hoQa8Mj
	AX8tmuPwy2JLh/YBWOvjGzmVvjlW3nzkOi4HYWkROiflVYk0rypuOmxr1xCKTiPV
	p1GcuGhn9jfezAH3soFvu69gh0BjBYmC/grISNgC2TbgHKXt9lAit6JmB9P/EM+V
	MCsZn7vGt/clwLbSGUcfES1Ciek5VCRD39WhNL76ce/vnZ+fIo/Ao4erSBRfdYka
	Wli5FifRO5Yn91vnfu8FA==
X-ME-Sender: <xms:Mv5waY2kiMeWayk2d050CHV33Ry7I5gXTNgmwTK-LjmktdJp0tHZtA>
    <xme:Mv5waVqetONiXhcKxeGdXFb9-VCmPYemr_WdHtgTXbr27UQYmlA60ofCLpkIKvt6E
    jAXxAWRekxNiUbMmaLK9fcu6MMqEDWsFUzqFYTaofVHlMti_mek>
X-ME-Received: <xmr:Mv5waUgdQsiE5KxiU6Hhyrw256ajrBvEPk026wJlqh6nMGgGT1zGMs3PhLuZqLVcP5a7D27pI65ayKXNen-sw5vGxyjgW3jt0Dx9vFk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefjeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrih
    hstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgr
    uhhgshgsrghkkhdrnhgrmhgvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhn
    vghtpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Mv5waR_dYSan8S-YcN0Mw0eGhDcKz2Te26BV5okPvRGRZx5gXZsd1w>
    <xmx:Mv5waQUwaYAVXfuSfi5yXxJJ3aZeQ26qcntVKHG_mPdMs8aVOEXJIA>
    <xmx:Mv5waVCmK9pzHEoKbq7hejUtGe40weHEIawBwI99XIkRytzeoXmx8w>
    <xmx:Mv5waVGsyJZ0ZZU0kuEsiQiDtvGewHrBV78UMSzIKlKVij_WSkKL1w>
    <xmx:M_5waVpRyAggygOuUI12AMjiuytjiN8snNQum6geaYRLGb2ogqgPxzYd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 11:26:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>,  Elijah Newren <newren@gmail.com>,  "brian m.
 carlson" <sandals@crustytoothpaste.net>,  Sergey Organov
 <sorganov@gmail.com>
Subject: Re: [PATCH] replay: drop rev-list formatting options from manual
In-Reply-To: <adfdcc47-470a-4424-9268-31699decee16@free.fr> (=?utf-8?Q?=22?=
 =?utf-8?Q?Jean-No=C3=ABl?=
	Avila"'s message of "Wed, 21 Jan 2026 14:27:05 +0100")
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
	<xmqqldht2fgd.fsf@gitster.g>
	<CALnO6CCaVdJQ2xSPfvxQzVCfPsjbWHhMFUiLoiPQtVn9MeKFOw@mail.gmail.com>
	<xmqq5x8w2t3o.fsf@gitster.g> <xmqq3440x8da.fsf@gitster.g>
	<xmqqy0lrx4l2.fsf@gitster.g>
	<adfdcc47-470a-4424-9268-31699decee16@free.fr>
Date: Wed, 21 Jan 2026 08:26:24 -0800
Message-ID: <xmqq8qdrvsnj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jean-Noël Avila <jn.avila@free.fr> writes:

>> The original comes from f81a574f (doc: test linkgit macros for
>> well-formedness, 2025-08-11); its author Cc'ed for better ideas.
>> 
>
> The initial motive for this script was to catch malformed linkgit
> occurrences that were present in the docs: stray git-foo[1], without
> the linkgit macro and misnamed gitlink:git-foo[1]. Not knowing what
> would come next, the regex was coined very broad, with the assumed risk
> of raising false positives.
>
> The issue here is in handling the ifdef macros which are block macros
> and are more easily detected as such. I would reject preemtively lines
> with '^ifn?def::' instead.

Yup, that is much cleaner.  Thanks!

> ----- >8 -----
> Subject: [PATCH] lint-gitlink: preemptively ignore all /ifn?def|endif/ macros
>
> Instead of testing if the macro name is ifn?def:: as if it were a inline
> macro, it is faster and safer to just ignore such block macro lines before
> hand.
>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/lint-gitlink.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/lint-gitlink.perl b/Documentation/lint-gitlink.perl
> index f183a18df..b5d982e8e 100755
> --- a/Documentation/lint-gitlink.perl
> +++ b/Documentation/lint-gitlink.perl
> @@ -41,10 +41,11 @@ sub report {
>  @ARGV = $to_check;
>  while (<>) {
>  	my $line = $_;
> +	next if $line =~ /^\s*(ifn?def|endif)::/;
>  	while ($line =~ m/(.{,8})((git[-a-z]+|scalar)\[(\d)*\])/g) {
>  	    my $pos = pos $line;
>  	    my ($macro, $target, $page, $section) = ($1, $2, $3, $4);
> -		if ( $macro ne "linkgit:" && $macro !~ "ifn?def::" && $macro ne "endif::" ) {
> +		if ( $macro ne "linkgit:" ) {
>  			report($pos, $line, $target, "linkgit: macro expected");
>  		}
>  	}
