Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681192D1F5E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073769; cv=none; b=eo3eN54kG2oJ/eGdbFZfRssV104jnjc5kV4mxf0OwlwqeOIlibFLbSvGlMEY2nmIytsSqhUdTvzXhpz+Iz1I2exvcjZzj4sWtFuqxx9noTk4bWeTcJCgP/+T/5oXluoHA093++bRrbn5J9IF7glV9t0OfADfAlf/ogSOmBnZ+iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073769; c=relaxed/simple;
	bh=xMhpLkx2SNx8heNWT2hYFDBTfXyYXDds2DbYMjH5FGc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WErVbgCWNU7PS7JPQG0po3HI35j7ybTn9pzl0qWFzQUXRnFTNTMY4KSBjvbY7+HY6KcDxGDcNEMKKD5PEAq6g6Pd/D6aT6O0rlMlznNNNXpwN2VSniH4K/xdrTA2Uhtr4Q7tLbZXz0OMGdnG0Pp0Brq0tV4sa706oHgmK81nHDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WBTTg0Vf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCUstR1j; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WBTTg0Vf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCUstR1j"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7AE43EC04F4;
	Wed,  9 Jul 2025 11:09:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 09 Jul 2025 11:09:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752073766; x=1752160166; bh=hoPj+hF7/B
	OD8DOnGH++KR0ICSbN5a4V8wvCRlGVIPo=; b=WBTTg0Vf0pljiLgUnu45VbhvJQ
	ffEHl7GxZaCmUBPb7uk3TfUTWqbObn68MANDuJ1TlFZ/5vQFpOv7Jmue3y0pfFZA
	w185vY5wNmlHQFTL667uzpn2L1J1YSwEBuzLAQSMmvTd7mt3eOdv/UDeLXAKLUPy
	AmKboXNPu5Goi/czj74YdkkDmKLB+DDYyfLeRO9p3tx9oeax7eGCrsXAEX16+DM7
	eGLeCWGU+M0kYsqVw25NYcsfMRdKVxwjX1z9CK5ZwQAI0EyUySy0dBUaNwfQJ7rQ
	IkMJYEq+uXNmfH+IPtWlaEkp0Wr4IqjT84v4qTR26GHSVeIR0PrIbm6U/Y5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752073766; x=1752160166; bh=hoPj+hF7/BOD8DOnGH++KR0ICSbN5a4V8wv
	CRlGVIPo=; b=CCUstR1ju31+u4ej+2u6jWuWlCG1reOvtXZcmMKsa4vGW2Geufg
	pcs1NH9UYEONsntt8ZqcUbSCbHdgPeuyoOaLe34JvrYXJcoiuwz1i4+3t/IJm0Vb
	TDq4IV/VT2nNQaWJoRxdvdIdej6mFyG14R887DAMRHPsUPz008YU/xqrps9RcSxK
	c3ZchKWgXjBGgtMCQmgO1U9dMT/L+WMS1Y8+XTdlavD2pvsmfT3QfePoGcAeyuYR
	vU12rI97tVqNtKabWKLPpF1tTxbEAxcfLHt2A42lPSCWgThwFD9O2cmxU5eVEg9Q
	9ChH9iEsbN4MPUufzQngI9DJd3lnVOcEpAg==
X-ME-Sender: <xms:JYZuaIF1TyVo-Ot0dC9t4Xddh4J9c8naP6mS9KfpBgxk9qVKoFPa5A>
    <xme:JYZuaGh8kZ8QKskR9RE5-gXyAw20j3TJqW9k5-M3UGzv86xQeHzJPhAz5qRUb_e0z
    pNhguYGYgyq3whi6g>
X-ME-Received: <xmr:JYZuaDBmT2dWu9vxU0cQec7vnf9CiJZ7HTqx3CpWyayRgcqPpmUfDMXLIa9SE8JUHjv8mwinztAgzvrTYWJ4UO6exzPEprY4tudjdtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvveeiueeljeeiiefhheeukeeklefhtdejtdffveelueegheeltdeluefgudel
    ueenucffohhmrghinhepmhgvshhonhgsuhhilhgurdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidr
    tghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtg
    homhdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhmrghilhdrtghomhdprhgtphht
    thhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:JYZuaATzoKnPq32zbjm2K7tm95d5cKDIVZI5N5hrUrtgtdvLMW7Xsw>
    <xmx:JYZuaAXxQIb3_q7NDonS_Ed5ezFRdSPw9ZHSmB_U4c38KGu1xU_nqg>
    <xmx:JYZuaBfy6o_YjK9IX30-AJhSctkjaTH2IdYS8aBaHEQe5N3v2Esd4w>
    <xmx:JYZuaEJzSolCfyE4BXuOwLodIVBsg7oD2UTol-7PiILZsX7RZCyBnA>
    <xmx:JoZuaHdsE529D5sutgI72Qws_Att33m73kWzjO_UEq8U4U_WksyDMxUC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 11:09:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  irecca.kun@gmail.com,  Eli Schwartz <eschwartz@gentoo.org>,  Jeff King
 <peff@peff.net>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 1/8] meson: stop discovering native version of Python
In-Reply-To: <20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
	(Patrick Steinhardt's message of "Wed, 09 Jul 2025 08:23:35 +0200")
References: <20250709-b4-pks-meson-cleanups-v3-0-29ab15b9ab85@pks.im>
	<20250709-b4-pks-meson-cleanups-v3-1-29ab15b9ab85@pks.im>
Date: Wed, 09 Jul 2025 08:09:24 -0700
Message-ID: <xmqqikk1pfiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> When Python features are enabled we search both for a native and
> non-native version of Python. This is wrong though: we don't use Python
> in our build process, so there is no need to search for it in the first
> place.
>
> There is one location where we use the native version of Python, namely
> when deciding whether or not we want to wire up git-p4(1). This check is
> invalid though, as we shouldn't check for the build host to have Python,
> but for the target host.
>
> Fix this invalid check to use the non-native version of Python and stop
> searching for a native version of Python altogether.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

The above explains the reasoning very nicely.

> -python = import('python').find_installation('python3', required: get_option('python'))
> -target_python = find_program('python3', native: false, required: python.found())
> -if python.found()
> +# Python is not used for our build system, but exclusively for git-p4.
> +# Consequently we only need to determine whether Python is available for the
> +# build target.
> +target_python = find_program('python3', native: false, required: get_option('python'))
> +if target_python.found()
>    build_options_config.set('NO_PYTHON', '')
>  else
>    libgit_c_args += '-DNO_PYTHON'

We ask explicitly for Python 3 here.

Does find_program() have some magic to deal with installations where
Python3 is simply called /usr/bin/python (and worse yet, not as a
symbolic link to /usr/bin/python3)?

I found

    "Since 0.50.0 if the "python3" program is requested and it is
    not found in the system, Meson will return its current
    interpreter",

which I suspect refers to the path to python3 used during the build
and is not what we want, at

https://mesonbuild.com/Reference-manual_functions.html#find_program

which got me a bit worried.

Perhaps everybody with Python3 has it at /usr/bin/python3 these
days, and my worries are unfounded? ;-)

Thanks.


> @@ -1979,7 +1981,7 @@ if perl_features_enabled
>    subdir('perl')
>  endif
>  
> -if python.found()
> +if target_python.found()
>    scripts_python = [
>      'git-p4.py'
>    ]
> @@ -2202,7 +2204,7 @@ summary({
>    'iconv': iconv.found(),
>    'pcre2': pcre2.found(),
>    'perl': perl_features_enabled,
> -  'python': python.found(),
> +  'python': target_python.found(),
>  }, section: 'Auto-detected features')
>  
>  summary({
