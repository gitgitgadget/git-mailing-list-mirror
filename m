Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402BE5CB8
	for <git@vger.kernel.org>; Thu,  8 May 2025 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746740909; cv=none; b=sUDX6UQNl9wEyZMN79+oOOnUAmOlZ8PSXrdfeR6VdK1MCdiVmIKa5iScsiawCxhIWU/nOhDhu5tr3L4bqoQrnTZG0Famo7UQjL73pGiNPN93n5+uZw/nlKks9UYn15Qol8c5pUgMtw86ADLjbHhvYrbt6MvPkSmGqyeXF4g/hiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746740909; c=relaxed/simple;
	bh=A+aEXL9ky3AS65cw2GussEzQcfE40HGGiXiuQab9Htw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hjTG9N3S2Z3XYyns6O9XhdDgncB87GLro3sU03S+R6bkuJGsaJr3s0RrTdYdDYIwC90Sv21JU+p2Bn+DN6rBYQ/3nM7nAgwos0oC6m8EjCsrHlOcH43BdjHMrUjsoBvy1+pQL6efMKtly1VfzXh9M0Fn7/yBa0cX0ZWEWnfWpC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=N7YQSdpP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CQZMzuLf; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="N7YQSdpP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CQZMzuLf"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 184652540104;
	Thu,  8 May 2025 17:48:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 08 May 2025 17:48:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746740904; x=1746827304; bh=UKn1C/Sqqj
	ea7kvcW5eMJ6LOipuVys9hASp001MB1ew=; b=N7YQSdpPjb6qQLwNf40z+CyqJV
	0cvc36rXzyawIN2K3+2b6ghsPH0IdPvKzkEkk8YvBtjDL9kWjm+29OsYtkq4Xt+P
	E+QQsN2dRfH7YxVzbv5fsautbuzUJD3GW+fgfhUjAFvevfL2eubkBY01E8xmZUT8
	wkYRgUsPA+xYcbbk3Y7Y7QQpLyoKdN+CS3h/zSZEbpdm6mcwiwT1TKUeNYD8GQ5t
	INip72upMgoiJqy+2jvdzpLKcaPSnlJZlAE2Aj8x+1K553IKErQbeNr7qh6IT8wr
	jKRYBOV7dQq0Yc2I7Whs1pkSrdCiN5puzlKJNBjxNJREs88OoL2NmhROibbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746740904; x=1746827304; bh=UKn1C/Sqqjea7kvcW5eMJ6LOipuVys9hASp
	001MB1ew=; b=CQZMzuLf4hvkOqUn71UqnOGylWG7vw8BCVV+n3oN0WyfhPLcwoF
	K5vbyRZf16CQDwWdDW+ZACsFjRNZ48TRxrixkUSwvcqe5upa58O/7UyAua40C2UG
	BUuNN/Xh4u69LRDRVn6ZkEEW8eaO1FMomQkBaSdqHg3em4AhBu0BUFA9dBiXk9xO
	YieTT0RTcY5w+WdSJ8oLfzQV49jLJ45Hu0cD/19beYGIpcBuWmx2ByV8r2IQMkLm
	n1r6LdXdvvZUr++Icg9+y+p5o83aBNY5DcsbXo1+wrXGGI6dVFAE9OjSJEeVhg4H
	5W3FhfpI/FAoWWO45wm3DfGXstkWCrO3xyA==
X-ME-Sender: <xms:qCYdaCqcuP-g0GUrSd62i_GtSugBae7fGwtjOzBpMIzQO7ixWMCslw>
    <xme:qCYdaApWlmjkFAq3A0E6l8qhdAmcV1TQt3fs18GnD0MR-foSFxzLXvrIZ3Pu_e5XL
    qVta59qqL-uPzKKgA>
X-ME-Received: <xmr:qCYdaHP2543ET4691MsG3CwOLQOQDiR9dtL3VN5V50lpykUVHHF5f9hDft4XRbc-PvWzAYpkj9R_z4TPzqbiJYHJnQsgkvEJIw82>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledtkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopegtohhnghgu
    rghnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:qCYdaB6tFgQHxhoHY9JRdOmKB1eJRNRNusOgoD1uBEbGZn06QNKJjw>
    <xmx:qCYdaB5uHPX4c82g8DWayjkk8sfkkOSzy5SaiOdQbG7uorswsPV6uQ>
    <xmx:qCYdaBhzmPBNwRpAxKooq78UUbjEEUF1Z56keL3fn3_ivb--32f96g>
    <xmx:qCYdaL4iDsUJFsKqkmmzX4sTfN1ivWLkbqJ4uJoNuLXd2C9QCOKcEA>
    <xmx:qCYdaBlIfHTRNDQocLFZFtixKL9IMnLo1j9hRFPERGWxo-eh7ZmuKC1Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 17:48:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,
  Eli Schwartz <eschwartz@gentoo.org>,  =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?=
 =?utf-8?B?Zw==?= Danh
 <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
In-Reply-To: <20250508164443.1506440-4-ramsay@ramsayjones.plus.com> (Ramsay
	Jones's message of "Thu, 8 May 2025 17:44:37 +0100")
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
Date: Thu, 08 May 2025 14:48:22 -0700
Message-ID: <xmqqr00y4vvd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

> -  '-DETC_GITATTRIBUTES="' + get_option('gitattributes') + '"',
> -  '-DETC_GITCONFIG="' + get_option('gitconfig') + '"',
> ...
> +system_attributes = get_option('gitattributes')
> +if system_attributes != ''
> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + system_attributes + '"'
> +else
> +  libgit_c_args += '-DETC_GITATTRIBUTES="' + get_option('sysconfdir') + '/gitattributes"'
> +endif

Just out of curiosity (because this cannot be a regression, since
the original removed one used the same constructs).

I am guessing from the presence of double quote around the value
that these strings are not directly used to invoke the compiler
without involving any shell (in other words, you wouldn't want these
quotes if you are shoving these strings in argv[] yourself to feed
execv()).

How does the above, and get_option() in particular, cope with a
pathname that has letters with special meanings to the shell when
they appear inside double-quote pair (like backquote or backslash or
even a dollar sign)?  On the Makefile side we give VAR_SQ for a raw
variable VAR and use the latter to write something like

        -DETC_GITATTRIBUTES='"$(ETC_GITATTRIBUTES_SQ)"'

to make sure we won't be broken by them.  Is Meson giving us an
equivalent to us for free by simply using get_option() here?

Thanks.
