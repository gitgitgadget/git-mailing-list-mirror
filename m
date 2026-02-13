Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D83E285C8E
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014876; cv=none; b=s5iMgXulNEuaFXw5CZ3FSIOdgkawe4FRUjGN8BNCyxar07rptYZN0DKym5ySQFRBKNBEXGhewejnGa3KDY1YGP7EiBqfalPFuSxm3xJN8GO0bb6tfWYy/l64uEFRetfiYKy0EMndc133I7Ys3LXuLmXAYATvDQyI+9BGHv5POvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014876; c=relaxed/simple;
	bh=lAmM7BjGEl9kUzLurmISPRCiR9bmuSgMKz5lcu2w3BA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UMKybAEAk99e0gFBnIME1/ssBZmAyy+NyogdJnp5Ht/zj3EocU3cSG8POp81dLlELDE4ErkMxhnVD5R1bVOHdwzjcNnHpEeUvvtIvJiYP9p+yLcG45IemqVDBfdnPW0UVX4TAlO2vVMzLJDITuYUxS7UYPO8t2JdFLgU8d5ULds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=vgo+MWbO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jyUvbRnq; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="vgo+MWbO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jyUvbRnq"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 021527A0123;
	Fri, 13 Feb 2026 15:34:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 13 Feb 2026 15:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771014871; x=1771101271; bh=/iVtD1LpyO
	vW+1Inh+xOI9+tbWvY1g/j2ZhRWcpgCl4=; b=vgo+MWbOJmdl4jsukJI94QsNrx
	ZtcDhG2x/FRSq54gLGn0iXn3wL/PRSuQQXFpBqfsVPx0nGixHfMj/8lFV0OCQK7e
	9thXaYaFC+nUm68l2zZxSr5F8O9k4an1B4xA356xofM2jx2JdCY1D8U3lnFe4onS
	x0xypZ30AmYB/QafT+qEW/AUQLDtZfakESVG8BI7HqsPALrLEOXRlCM5bq3yrZPg
	jSfgRLJelgwuTTHJ9/1zrODlpOUrnAIxZSCxsbmlbB16p7jtuOjdfbl1/FkB9oNj
	lE6qO+IRIKTzWpZ5SgB3DvjFe5VvBEoHNUIJ75K1ZE5xkE541yL5/G+kmlvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771014871; x=1771101271; bh=/iVtD1LpyOvW+1Inh+xOI9+tbWvY1g/j2Zh
	RWcpgCl4=; b=jyUvbRnqzwNl8a4imy7z6MNQYMpfYKLEssPv1nXmDK18vJei29r
	zHnhpokflgZtBsgDpzEBWxFWmy0I3iZznfvB8glv1RpXAfnKmC4w5XaUmz9VHoLe
	GZg/cClYmI2MyAkW2BGYbAPgOjRHecKTguUbY+svqTqd6x0yRNrpWfUiy46d8tkj
	aNKpJnRS/mGCKwq5OjH0fH/LOC2rFsw3jj130N2a4Yq1foNAWB8D3pHYqVaAZ48b
	yWl5Y+J/9x3hx8OVPuOptseHRPLjUOXViTRStcD1yqkoV+RVhIWvgkw02oLpPAyx
	1vk++LAnDk+T/ciMghA+Sj/rMXWBGakld0w==
X-ME-Sender: <xms:14qPaV-rFdrYw-pNR49Ta7BFbZZiZ2YjSx7TRsrQzZVqGa6GFJHgFw>
    <xme:14qPab9Vk6_P9NMOOshEHAe3Mf_dP73XXvqWpx6wp-WpNt5IMy8EMP-I5B72YQirH
    w9avhES9sWksmGJz8sYL0qzZ9LiWsGHhrGZvJ2h6sVBZeJTWTOD>
X-ME-Received: <xmr:14qPaVT4HLr88gEfNKKuXN1Uj2grLuCP-NLjV8EKx-l2dPTlDtG63_fwjBINF9kiR6G6VJUu2aRm2fTSRoSAkfsqaiOYG8VtBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrsh
    gthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehkrhhishhtohhffhgvrhhh
    rghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmjhgthhgvvg
    hthhgrmhesohhuthhlohhokhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:14qPafehkJlbTPY1Q4XstTCR2nslNUvSpHzcVhiOl1k61qxlhU_tuw>
    <xmx:14qPaZC0gR1RuSgoXJ0R0cI3S7_Jv2mrmdVUk0LIvdQOMwdT5PAlMA>
    <xmx:14qPaRmhgL-MJq1Vo--MAlj4nWDZ82P4JyTSbd61H7dGplCeJn9Qbg>
    <xmx:14qPaUdpZ79bnYaK3GXE6q6D8QfShlkOPoBrOoc8_nL4e8tpqyk5qQ>
    <xmx:14qPaaixXUOZEBw9CeA6RZ7l7tUuFgzi7sbwvLBpe7r3cajBllvFGmYM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 15:34:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  johannes.schindelin@gmx.de,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Matthew John
 Cheetham <mjcheetham@outlook.com>
Subject: Re: [PATCH v2 2/6] build: include procinfo.c impl for macOS
In-Reply-To: <546fcc3446508eb56312fa195483816d94ea0d41.1771012500.git.gitgitgadget@gmail.com>
	(Matthew John Cheetham via GitGitGadget's message of "Fri, 13 Feb 2026
	19:54:56 +0000")
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
	<pull.2040.v2.git.1771012500.gitgitgadget@gmail.com>
	<546fcc3446508eb56312fa195483816d94ea0d41.1771012500.git.gitgitgadget@gmail.com>
Date: Fri, 13 Feb 2026 12:34:30 -0800
Message-ID: <xmqqy0kwl6w9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Matthew John Cheetham <mjcheetham@outlook.com>
>
> Include an implementation of trace2_collect_process_info for macOS.
>
> Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
> ---
>  config.mak.uname                    | 2 ++
>  contrib/buildsystems/CMakeLists.txt | 2 ++
>  meson.build                         | 2 ++
>  3 files changed, 6 insertions(+)

Looking good.  I wondered if the first two steps should be a single
patch (as the tree will be with a totally unused file until the
second patch is applied), but this organization will give better
chances for the second patch to be viewed by folks who are good at
build infrastructure who are not necessarily interested in macOS
specific programming, so it probably is better presented this way.

>
> diff --git a/config.mak.uname b/config.mak.uname
> index 1691c6ae6e..baa5018461 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -148,6 +148,8 @@ ifeq ($(uname_S),Darwin)
>  	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
>  	CSPRNG_METHOD = arc4random
>  	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS = YesPlease
> +	HAVE_PLATFORM_PROCINFO = YesPlease
> +	COMPAT_OBJS += compat/darwin/procinfo.o
>  
>  	# Workaround for `gettext` being keg-only and not even being linked via
>  	# `brew link --force gettext`, should be obsolete as of
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index edb0fc04ad..d489f0cada 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -274,6 +274,8 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
>  elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
>  	add_compile_definitions(PROCFS_EXECUTABLE_PATH="/proc/self/exe" HAVE_DEV_TTY )
>  	list(APPEND compat_SOURCES unix-socket.c unix-stream-server.c compat/linux/procinfo.c)
> +elseif(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
> +	list(APPEND compat_SOURCES compat/darwin/procinfo.c)
>  endif()
>  
>  if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
> diff --git a/meson.build b/meson.build
> index 1f95a06edb..32d470e4f7 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1292,6 +1292,8 @@ if host_machine.system() == 'linux'
>    libgit_sources += 'compat/linux/procinfo.c'
>  elif host_machine.system() == 'windows'
>    libgit_sources += 'compat/win32/trace2_win32_process_info.c'
> +elif host_machine.system() == 'darwin'
> +  libgit_sources += 'compat/darwin/procinfo.c'
>  else
>    libgit_sources += 'compat/stub/procinfo.c'
>  endif
