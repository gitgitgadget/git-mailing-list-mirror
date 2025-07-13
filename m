Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035401E9B29
	for <git@vger.kernel.org>; Sun, 13 Jul 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752421334; cv=none; b=toR9mGKf4uMOngPpCMeIVT8M5p0X82d+QlizBXhfipNXpitSYvDgWdyaX/QCSt1ateBBBfcz9BVo440dZw7moeeqOOsX/oYAm1zU02IpbYtQzep+JZ60a4/1xq1vpr31K5YDUrhjPv5inAk4cTEbqPE3TcAevubaRAz0NICLRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752421334; c=relaxed/simple;
	bh=T+Fkgwgdc/sHhnwhRl248id5EYZvOnY1HX8IHBS9mBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7bHFAdkhgy49HKDX09NGax6VpY2hNcguOOawoVF0ohxnWFOXgHW8NG4XXoeQXGMYTLzQMVB74DId9P6+SCKYQKc4jXIuJN2qRtoRk6Bkrl26kS0dkvlcYaoTMrDMcF7vSPf4zprMZ8B24fHtE3jzDVtmojoik9SXESXV/q3su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z+TPGtRt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msepPbuL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z+TPGtRt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msepPbuL"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAB67140014E;
	Sun, 13 Jul 2025 11:42:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 13 Jul 2025 11:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1752421330;
	 x=1752507730; bh=we4EFlmkcwZBshV0ns0LeYUD5TGUq5cN3jNq0mV35c8=; b=
	Z+TPGtRtHjLweZo/11bP5Q2hxtC4AW3nCky13vpdKN3TQeJX8BuXk0IVorFy9iFb
	ObAdrN2//GUnOW0ricXz1bxr3Rm8gHH+rJj9qHV8HCs4TXp9SkXeTWDRIHLucWrW
	YTT1YMF/vMguur/qv/NADj4dHaMM5wtgtfUdO+pT+Ju9lKxFp709JTw22kmzYSqf
	pKE1p00IxZLY2wZPrs3vPxBSo8J4+jg0po2bTllI4CvXZZRB9ugv1US+nQY6LUGn
	rcoAauvL8D5zjx8iGcQpeeYhdY2cfnGa12xF4l723nVzJ6ehFDmrwgbtIgTvm220
	t18t/708HczZe6mQWANYCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752421330; x=
	1752507730; bh=we4EFlmkcwZBshV0ns0LeYUD5TGUq5cN3jNq0mV35c8=; b=m
	sepPbuLBrvgQfGoa/kBYlMRBHeK5Uj8cRxBo9UMS5uykPKwExH1t/O4jdhdAE4Xw
	U9nuq16WfBsWITkvqRnDceaBP89N92wwn8AN0l3XBelMFK48EjorCM7Qwuo9J15I
	amuX5dFR10glXnKDMKsAyeo+08XSTY1ZgL0q2pnH6P52bOhyXdijsMfYUTtlCkgx
	hyYtgyYJUtklxmbYG1eN5tEV0jzg7mzxDWVL2SdKVb+TvzjBUNXZtySnSVHIKXN7
	LBF01RmUj6VP708Wl6g0VOPHwCjStkWXkzXfT4u2YQcJC4JPLDVwwdK52gP4NR22
	3MwtFkA7s+vtOqWo4wSsw==
X-ME-Sender: <xms:0tNzaE3c9XLUflY2x-_GHvzcvJbibHYzRC8rCesSg4oTZOUlk3G10Q>
    <xme:0tNzaJoIgiE9PNL8yggauq6emby8u62wicyK28CMczunArj5aFDLHQ86T74ebRrK4
    x70pNdyXlvsKLssQg>
X-ME-Received: <xmr:0tNzaJcTMGujFdeTMGMpveJH_K-38rA6xz5aqBFfeslnhZh3DT1Ou3jsNk_jg-w6EfvQq7scM6NpNOzB2WfZXyTAiclqCU4iAdZkyCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegleegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgu
    rghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0tNzaAo3h4OU4qFj8J7HT5IzGJQsnZt5mjU8IyLdMPQuVU7B-kTyOw>
    <xmx:0tNzaCG50zM6HDg9e3S79khnNoTPOC2YGDrJklK2KzQSxscL6ZrpWA>
    <xmx:0tNzaIuM0BmPlxB4AmS6Lt1ZvpByqlBtI3s-zIKqQ6gk7ZuQ-f-Apw>
    <xmx:0tNzaMWfYZGAR2D78VMQ0VFt8lTTpKCGNNAw8v8Tiyka-pbLbxaqsQ>
    <xmx:0tNzaOG5biGZEKYBLDJFAKT9XFJx-5nHkxKqvyGZDdoNeZGve1oK8cBi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Jul 2025 11:42:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc: git@vger.kernel.org,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v2] meson: disable PCRE2 dependency by default in macOS
In-Reply-To: <20250713122341.17976-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
	=?utf-8?Q?Bel=C3=B3n=22's?= message of "Sun, 13 Jul 2025 05:23:41 -0700")
References: <20250712172615.11364-1-carenas@gmail.com>
	<20250713122341.17976-1-carenas@gmail.com>
Date: Sun, 13 Jul 2025 08:42:08 -0700
Message-ID: <xmqqtt3gw10v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:

> Makefile requires the user to provide the USE_LIBPCRE2 flag to
> enable this dependency, but meson has it enabled by default,
> which can be problematic, at least in macOS.
>
> macOS provides a PCRE2 library in base that is not usable and not
> configured properly, as it installs a pkgconf module that
> points to a non existent pcre2.h header in /usr/local/include.
>
> Add an option that will need to be turned to true once an
> alternative PCRE2 library is installed (which hopefully provides
> its own pkgconf module earlier in PKG_CONFIG_PATH) or meson has
> been instructed to use the wrap by `--force-fallback-for=pcre2`

Here, and ...

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  meson.build       | 3 ++-
>  meson_options.txt | 4 +++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 7fea4a34d6..e1475be6c8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1055,7 +1055,8 @@ else
>    build_options_config.set('NO_ICONV', '1')
>  endif
>  
> -pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
> +pcre2_feature = get_option('pcre2').disable_auto_if(host_machine.system() == 'darwin' and not get_option('macos_workaround_system_pcre2'))
> +pcre2 = dependency('libpcre2-8', required: pcre2_feature, default_options: ['default_library=static', 'test=false'])
>  if pcre2.found()
>    libgit_dependencies += pcre2
>    libgit_c_args += '-DUSE_LIBPCRE2'
> diff --git a/meson_options.txt b/meson_options.txt
> index e7f768df24..9c0cb6bbfa 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -45,7 +45,7 @@ option('gitweb', type: 'feature', value: 'auto',
>    description: 'Build Git web interface. Requires Perl.')
>  option('iconv', type: 'feature', value: 'auto',
>    description: 'Support reencoding strings with different encodings.')
> -option('pcre2', type: 'feature', value: 'enabled',
> +option('pcre2', type: 'feature', value: 'auto',
>    description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
>  option('perl', type: 'feature', value: 'auto',
>    description: 'Build tools written in Perl.')
> @@ -73,6 +73,8 @@ option('breaking_changes', type: 'boolean', value: false,
>    description: 'Enable upcoming breaking changes.')
>  option('macos_use_homebrew_gettext', type: 'boolean', value: true,
>    description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
> +option('macos_workaround_system_pcre2', type: 'boolean', value: false,
> +  description: 'A working PCRE2 was provided or the fallback to the wrap is being forced.')

... here, I do not understand what you wanted to refer to with the
noun "wrap".  Can you please rephrase them to clarify?

Thanks.

>  
>  # gitweb configuration.
>  option('gitweb_config', type: 'string', value: 'gitweb_config.perl')
