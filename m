Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED386198A29
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737020610; cv=none; b=AxidVAo+tC80yWPG3GxYwQYsFy0zHEZx+nBEdoWcxA7MpD9WUgYQgjlwEQJQ3TEnWUyVlvgxbjrdYAnpeI3pQNcM88boAGv1q92bTUIUuqBwvmXkFKgFKeQqey9WKx603ITnXzfcpItELNB6WTC0P2rLKt6WH3yBaATfWJ5+MzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737020610; c=relaxed/simple;
	bh=Z2pbaLOykuy7uVMDvPB/Fcx2S/cNLX6w51+0hSHqrKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEY+u/WfXQLIwgvQUPwTkT/tw/PmlguvmGRi2qOYe9/fK6CYvR8LNd3iJo77fOBTWbHbYNeeBUCZUZdTWKRsCQT9sa7S8HoKYMUa9ZZLFZ1a6ktwwoCSleROFKBQm+bPYvkDG5T8JqiPpQOCXaW9I/b8VhSQmQ8DKDyCtw0ENOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fbPNHdTz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wcMplqrz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fbPNHdTz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wcMplqrz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 1252A114017C;
	Thu, 16 Jan 2025 04:43:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 16 Jan 2025 04:43:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737020605; x=1737107005; bh=NmPC+yrYsl
	TUgh8sN0+OyRFu9K8ekgnvrzPcGtcsGzQ=; b=fbPNHdTz6QWbb8bWdr0d2suZvQ
	9PvOOQG/LOhHDW55LlEIYmB+4d0bwW6kJvMuV7nYRiZf3+3RCpDaDjULLYY+bkQe
	pvn1aVlsBee6NwD2Ewu9IPuVN3TYeVn6XOJ49lhsBjWJPRcMZEKKLxuxjR6uSizt
	9Sgzv1tNQ3MzlRm8SlyI5QuCe6JBKNEENRF6qJOM9p0kM+8oamsl7zzoQMhRGPrd
	NIQzuIQzlC/uu5dJ9S60UxjbOtuG5cRASkcw735Ksgjt/4E4KT721nDb5ChbRWf3
	jawu8JtkXPj6alJU/BXrgJdiClQiSB9JNMWUo/vWSrBaHPK7WeheGeJVndtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737020605; x=1737107005; bh=NmPC+yrYslTUgh8sN0+OyRFu9K8ekgnvrzP
	cGtcsGzQ=; b=wcMplqrzgZ/ssPh8SoZGflCGVsenYLv5D56Kp9tDpCRa/D2KSDq
	bBKZvgtphQs5TyVsv/w4akRwst2PoaOSpF3OlEVuxhd9yKxOX1FQTlN13Tm6PeIK
	FMhUftlAjd4HK6oBLIE9Coobga+B+PtpSR1snpoA0cR9qzxd6tHu9rRIaAzvsZjT
	5tIO+NPcwDSW3+3hrKea0ISLavlgvGSU4SGrBbQ+ddDOgT6yGPo+Onph/B/ssFN8
	dV9TjcbsywVht/DUyzsWMgkoQIvUU3OYBz1HneujTBLGpUVGPPb4eVcUL/wBxtyI
	hYGooWzDHaqo/04YFZxGAjeYYVsIAkQ/Z2g==
X-ME-Sender: <xms:vNSIZ0EcjvrDMWwNdwuWtO5c9tSTWtmLFljWXm549yjxthTaFcs1fQ>
    <xme:vNSIZ9WJxg1Coja4wZyk3Bx7uyeBObtdMWIdHihCXuXolltoQG3PKuN0Vrz-3BtKD
    enSIgIVNcRJGOv7SQ>
X-ME-Received: <xmr:vNSIZ-JlGvujBrmlg856M4JB8td6jylbWX8EBiac8U-Pir8EexASfnJV-2IY57_W6zCgIuXokz2UnggtJFt6ZPCvkqkSSn_1V08xW9iuiz7728r-XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhn
    sehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:vdSIZ2HZAc96C0XxR2lJ-65xbodMf0jR1cqeBo-GOlKgg-rjhl9jyA>
    <xmx:vdSIZ6V4xoz89GAnQ-TMtaL19WIVcdepQ6qe3hIxRJ26y2MD_IdXdg>
    <xmx:vdSIZ5M46A-HERBehlgHiIS2ma1jbbTgAQ29wJAwL_dfl_YxXlb_qQ>
    <xmx:vdSIZx261Xx7x-1CJT88KoO4iYnFmMdqdBcTpawxc2GLoLbZsRGhVA>
    <xmx:vdSIZ5T9-acUsCA5K9SHf11nWjf5lknrmPxluYrXz9l0Vw6v3OKdutfx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:43:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9e404ac8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:43:21 +0000 (UTC)
Date: Thu, 16 Jan 2025 10:43:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] meson: ensure correct version-def.h is used
Message-ID: <Z4jUsd77AFih24OW@pks.im>
References: <20250113-toon-fix-meson-version-v1-1-9637e2be32e3@iotcl.com>
 <20250114-toon-fix-meson-version-v2-1-66ddb1a82c28@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114-toon-fix-meson-version-v2-1-66ddb1a82c28@iotcl.com>

On Tue, Jan 14, 2025 at 12:15:23PM +0100, Toon Claes wrote:
> diff --git a/meson.build b/meson.build
> index 0064eb64f546a6349a8694ce251bd352febda6fe..db27afa99986598aab22ada718f76a7a49238f24 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1493,7 +1493,9 @@ libgit_version_library = static_library('git-version',
>      'version.c',
>      version_def_h,
>    ],
> -  c_args: libgit_c_args,
> +  c_args: libgit_c_args + [
> +    '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
> +  ],
>    dependencies: libgit_dependencies,
>    include_directories: libgit_include_directories,
>  )
> diff --git a/version.c b/version.c
> index 4d763ab48dd76c0445e5ea390ff4c1f35c1a4b12..4786c4e0a54093ca947da27f8b712bd1ea351203 100644
> --- a/version.c
> +++ b/version.c
> @@ -1,8 +1,13 @@
>  #include "git-compat-util.h"
>  #include "version.h"
> -#include "version-def.h"
>  #include "strbuf.h"
>  
> +#ifndef GIT_VERSION_H
> +# include "version-def.h"
> +#else
> +# include GIT_VERSION_H
> +#endif
> +
>  const char git_version_string[] = GIT_VERSION;
>  const char git_built_from_commit_string[] = GIT_BUILT_FROM_COMMIT;

Yup, this looks as expected. I'm fine with the solution (well,
obviously, I proposed it), so this looks good to me.

Thanks!

Patrick
