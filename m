Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FF87FBAC
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640180; cv=none; b=O90KAtTaTtknVxVMqKG48Ak0dKPwFMZBXqPQqVt8eAko5gWtWV118Dr9G3nNo3k8zwH4RyfP/zoL7yalKUak2Nvmh7J5WhT9b766oPvniAbmEMKjmEqA72KYIjnBwtBdbpuBx8m7J/XZ6vzK7e3c/TrOCv810PGIvcRVc2jPb7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640180; c=relaxed/simple;
	bh=8kU6X89qZwqQMUh+mtW2sluld1Z0LokHsHSVjF+O454=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1j95e/W7+mvKOYvzZKvuDE5UVB4pBtXkgJ0Fq4wzUbGPHFSNIn/sKwpE6hhvGvsov2uZdazTDpY4goTef5g5nn0Q14vemavp45Kpd+j6ZTMVl38mODMuilfs5bF+iXcvBPwEt728D//rVWzjA4kiIhlqIE+acibk2HU+HYlGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XuBZkxKG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gl9tVGcV; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XuBZkxKG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gl9tVGcV"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 03E9EEC04BC;
	Tue, 19 Aug 2025 17:49:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 19 Aug 2025 17:49:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755640177;
	 x=1755726577; bh=Le+0Kv5/zUXFVHYbWxM/Pz5YIY96yx9C9sT5MyZSrDI=; b=
	XuBZkxKGkmsso3OGcrdtNTvzxbYd31e42n1eZtp6S2wlIoUXSPv4Z64VYiVOFazq
	Zsy25mq/1S0n5hyiLfnFQwPPvorSc1eatXQUsQ9ZtaFD6AWc/hM92He7WfNOd7sc
	oHo0rV2wej44D31pl2hqIsNnmNjmN8XKmPdiZbcNLdcj4xuzVH35Ly1CqmW987+2
	BE1WNIoa+cwzeXbYgIs57XJRQJ7eTI3aCegg7JPmINee6v3Ma1ZnTtgz6OrHOBJx
	1SRRubCkpjaMPkXGtVgMd8IOyxMCexbvb5FEk95s4dVdqYoq9xDK5BuaFhKr79OJ
	fURbXetJU8bZnCjrrw6GjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755640177; x=
	1755726577; bh=Le+0Kv5/zUXFVHYbWxM/Pz5YIY96yx9C9sT5MyZSrDI=; b=g
	l9tVGcV2RlES4kM0EBoBn1kHAtHpluTgBp2z1jeCVkHc3zHpR5VCQ9K63ltMeL2X
	Z28ixPr/0izgc3EiuD+Bfm+qWJdy11Te7nkGjLA287OPTSmIV9nq4XoMot+ii2Ab
	zYtltIihbkSqNGtkLumptQjjhM7rIGba60g0hIxT7iH4vTcOiIZ2w9HJt3ws7UVo
	7F0PAy9AgrA9JnDVlaRNp9PrWrBJXwsUWHdYTzsEKafX/1Z5AqYyreH6hk13LbPq
	3H3KYNQZrT52A67PakHM8ADBLMYKCPFDUFMCMBWPeLXdbFuX1WuX9/VvvG3oBl6n
	u2IACp4Cy0QkigNTwG0Xg==
X-ME-Sender: <xms:cfGkaM0GqZmGuORexec83boPUHYUhGfOwfdpWebxnem3eIw8Ik3dxw>
    <xme:cfGkaCmmIvcEY6K8MrDv8G6tLmDmrLh18N-mylc4sBqAgFxAm-xnsRanBZ5L9HNqI
    6AeM0R1dXq3abQ7VQ>
X-ME-Received: <xmr:cfGkaLW_dpwGhnHuEsIw01oIwozcaFMEP18RWQXXg8vmrFbSjCFUT1oyJBtcjeFXkhc6TCil9cA3nrMnFMb6ENpcGTDemMkeIOkHRdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeiieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhs
    thhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:cfGkaAv7vTSjcn95mcqvMXoU_oiqkgM-Uo3AHdZHPyJ_SEbDI_vFmg>
    <xmx:cfGkaGYfkCDXjY6HJ9e5pqPxTo4kXY06SRWnSZwofoPuIvKVdiXFuw>
    <xmx:cfGkaHVK1BUKuppFLI_tn5QDnBq80deILCXQ8_Zix1cyibgXeg2rWQ>
    <xmx:cfGkaDQTlhdRkpCdORhYbe50_eaZufNiMHtin8PcfG7CrsBkkaHERg>
    <xmx:cfGkaDBH78lkuYFl7ene6vql6FRX35qZvYHjLrq3vFDiy9Sjeix5QGRE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 17:49:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH] doc: fix asciidoc format compatibility in
 pretty-formats.adoc
In-Reply-To: <20250819212340.73886-1-jn.avila@free.fr> (=?utf-8?Q?=22Jean-?=
 =?utf-8?Q?No=C3=ABl?= Avila"'s
	message of "Tue, 19 Aug 2025 23:22:33 +0200")
References: <aKJJs7OkBIg7Y9J0@szeder.dev>
	<20250819212340.73886-1-jn.avila@free.fr>
Date: Tue, 19 Aug 2025 14:49:36 -0700
Message-ID: <xmqqa53vc77z.fsf@gitster.g>
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

> Asciidoc.py and Asciidoctor do not process the same '+' verbatim syntax in
> the same way. For most usages, Asciidoctor requires a double '+'.

The word "same" on the first line is probably unwanted?

> Unfortunately, the postprocessing of verbatim synopsis in asciidoctor cannot
> be bypassed and formatting of the parentheses is forced in syntax sign
> instead of keywords, unless a proper grammar analyzer is used.

Sorry, I've read the above three times, but it would not explain why
the change is needed for the "prefix" line, but no change is needed
for the "suffix" line or for the "separator" line, even though they
look quite similar.  Is open-parenthesis somehow special?  And '>'
also special in the same way?

>
> Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> ---
>  Documentation/pretty-formats.adoc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/pretty-formats.adoc b/Documentation/pretty-formats.adoc
> index 9ed0417fc8..618ddc4a0c 100644
> --- a/Documentation/pretty-formats.adoc
> +++ b/Documentation/pretty-formats.adoc
> @@ -233,11 +233,11 @@ colon and zero or more comma-separated options. Option values may contain
>  literal formatting codes. These must be used for commas (`%x2C`) and closing
>  parentheses (`%x29`), due to their role in the option syntax.
>  +
> -** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}+(+".
> +** `prefix=<value>`: Shown before the list of ref names.  Defaults to "{nbsp}++(++".
>  ** `suffix=<value>`: Shown after the list of ref names.  Defaults to "+)+".
>  ** `separator=<value>`: Shown between ref names.  Defaults to "+,+{nbsp}".
>  ** `pointer=<value>`: Shown between HEAD and the branch it points to, if any.
> -		      Defaults to "{nbsp}+->+{nbsp}".
> +		      Defaults to "{nbsp}++->++{nbsp}".
>  ** `tag=<value>`: Shown before tag names. Defaults to "`tag:`{nbsp}".
>  
>  +
