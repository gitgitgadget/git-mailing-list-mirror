Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1B220FA9B
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284494; cv=none; b=frPdVcYp/Cov9N/1Mf/bGdG7Sjx0ev+j0pH4lZkW/7tt4j4Tv+jG9cfxE8n7I15o20YG4OmSUgYWXNX9mfl0OVo/BjIrqUPh64Rux/mE3pJ06y7HiYnQVjD78RgsLHfMLGNIR7JuXrz0HUc78q83AxwGBOY1g7jc049GVhFDkwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284494; c=relaxed/simple;
	bh=QqB/epwPqWWIZxXL366WZQBfGlhdvtK10FUphZ1pBMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeWhQZ8JrGqgJ5dRLp/h4x6O6AByzn3lju5tnVX5ohoUJ5sM1C54ElVjGaZpjuRLw48f2KFlfKfpxuUV6XegBh23IZ+9eXFbH5tuUadanuD7t7z2a82Iv1H7YYpMDjsIN8mlQNMuVJZfbAZ777co4x5En4TqumGYy+U/MmNGj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aJDCibhv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHeKsM3G; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aJDCibhv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHeKsM3G"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 416791140237;
	Mon,  2 Sep 2024 09:41:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 02 Sep 2024 09:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725284491; x=1725370891; bh=QxI6OBhCJk
	4hi5TBhD7w26dhmIe9agJpeHDCDVZjpIQ=; b=aJDCibhv29/yG1YtChO7J/J2dA
	TQ+CzhdU3oZVv7fHsHn1RZkACE87OIYz52/JvZO+jtFyiw7+hJlIAHeMEmDHDgk1
	DWFWFh3aUJH/aZBmdnWLiQMGDzv279oF84nh4DI6ZDfGUxzhZ1iL35M3Y23I7g6z
	Cm5X3Sqrzvb6PcFd1+B/Z0KYXYGP7k1i9I3g1m8i+ITij57AyYGXxyJEhDtO0Xlw
	cAmbxKOKC85GuRbeMt8n9KxFu+uWUM98Tvi8Y5X76ZU7jO/TItEO0ftVlXhttvbg
	mqF3psfFd2/T6jVjCmNWcncPkBF9Ci+OZ+D2WxVjwECqEoOc5Wdoj7FwtaAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725284491; x=1725370891; bh=QxI6OBhCJk4hi5TBhD7w26dhmIe9
	agJpeHDCDVZjpIQ=; b=FHeKsM3GtYuqF6FM0wu0wOoxAocLJBhLqw9En3D5H207
	67D5zfPhtSiK5hybyQWMFIWfFfSHAWsXCTA7zh7LI9//2ik4s6uIYk1HgcvlRT44
	tNNSeN64Lq019my8K7x8OzJyJsLuk+3zU2drv9HY+SmNMRQkkTNC5vm8kLUKE2nC
	I7DAqAu7B8TqEgTBgKl/qt/3RacoKZo14BH1F6B6qNMEZcjRXkQ/8cKwvdNUXWPF
	044cJamXLuP8+caHTXH5TrD+TLYqUuq9jWo7mB7zqprbFXDhck2dnAo9HBq/VVzB
	QDkoXLEI+6a21sQEjexvR6wSpxLFp4K2rRt66L3iYg==
X-ME-Sender: <xms:i8DVZo51MmoT6XQQANHiyLT87kn20RzuKojZFNWgWViDoYwOUuHE5A>
    <xme:i8DVZp6991e0ArDYFcKLIm2FLWGkHtGF2z7KsDZAwdYzoY9zzQSuOo3FXt0N4gYIp
    Yr2M9siZLv3apSJOg>
X-ME-Received: <xmr:i8DVZncI4NEwu6gemtBvBvsJYV9NOqGIj2Ubay0xUh2Qw550n91JQH2dcWpwsGK6vL_pUhwzzRORPv4DJzfK761Z6MOeCnJRaKn_JJ3O9xqaJIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiudelueel
    gfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:i8DVZtLwlei15lcuSC71Ubcw4n8kaSp2WrdYDvVDQ961DlFbsjSasg>
    <xmx:i8DVZsL5Dxh6msPBWcPQn7S2b_lWhk-hA392Jj32jqr6Gys97Qtzlg>
    <xmx:i8DVZuw_8JTjeMLd9MD9w3jHFP0Fj_gi2sKQ9r8sbQZPmjKqNv7yVg>
    <xmx:i8DVZgLR5kvr13TqRYiHEVWtyhtb5s9BzpOnnwUvMb-XdMeZEARKsA>
    <xmx:i8DVZk9agIufkpr26xF2CyYBkjAKpXMIXFYV7jV621RewzDQNOp1GkwW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Sep 2024 09:41:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 95b9dab0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 13:41:24 +0000 (UTC)
Date: Mon, 2 Sep 2024 15:41:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Makefile: allow specifying a SHA-1 for
 non-cryptographic uses
Message-ID: <ZtXAiIwLgtQNkwyH@tanuki>
References: <cover.1725206584.git.me@ttaylorr.com>
 <682e4c2cc3581c72262ea6a9b488a246fc6fde28.1725206584.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <682e4c2cc3581c72262ea6a9b488a246fc6fde28.1725206584.git.me@ttaylorr.com>

On Sun, Sep 01, 2024 at 12:03:28PM -0400, Taylor Blau wrote:
> diff --git a/Makefile b/Makefile
> index e298c8b55ec..d24f9088802 100644
> @@ -1982,6 +1986,27 @@ endif
>  endif
>  endif
>  
> +ifdef OPENSSL_SHA1_FAST
> +ifndef OPENSSL_SHA1
> +	EXTLIBS += $(LIB_4_CRYPTO)
> +	BASIC_CFLAGS += -DSHA1_OPENSSL_FAST
> +endif
> +else
> +ifdef BLK_SHA1_FAST
> +ifndef BLK_SHA1
> +	LIB_OBJS += block-sha1/sha1.o
> +	BASIC_CFLAGS += -DSHA1_BLK_FAST
> +endif
> +else
> +ifdef APPLE_COMMON_CRYPTO_SHA1_FAST
> +ifndef APPLE_COMMON_CRYPTO_SHA1
> +	COMPAT_CFLAGS += -DCOMMON_DIGEST_FOR_OPENSSL
> +	BASIC_CFLAGS += -DSHA1_APPLE_FAST
> +endif
> +endif
> +endif
> +endif
> +

What a cascade of `endif`s :)

Do we also want to wire up support in config.mak.uname such that the
fast variants are default-enabled? Or is there a good reason to not do
that?

> diff --git a/hash.h b/hash.h
> index f255e5c1e8a..450e579b405 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -15,6 +15,31 @@
>  #include "block-sha1/sha1.h"
>  #endif
>  
> +#if defined(SHA1_APPLE_FAST)
> +#include <CommonCrypto/CommonDigest.h>
> +#define platform_SHA_CTX_fast CC_SHA1_CTX
> +#define platform_SHA1_Init_fast CC_SHA1_Init
> +#define platform_SHA1_Update_fast CC_SHA1_Update
> +#define platform_SHA1_Final_fast CC_SHA1_Final
> +#elif defined(SHA1_OPENSSL_FAST)
> +#  include <openssl/sha.h>
> +#  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
> +#    define SHA1_NEEDS_CLONE_HELPER_FAST
> +#    include "sha1/openssl.h"
> +#  endif
> +#  define platform_SHA_CTX_fast openssl_SHA1_CTX
> +#  define platform_SHA1_Init_fast openssl_SHA1_Init
> +#  define platform_SHA1_Clone_fast openssl_SHA1_Clone
> +#  define platform_SHA1_Update_fast openssl_SHA1_Update
> +#  define platform_SHA1_Final_fast openssl_SHA1_Final
> +#elif defined(SHA1_BLK_FAST)
> +#include "block-sha1/sha1.h"
> +#define platform_SHA_CTX_fast blk_SHA_CTX
> +#define platform_SHA1_Init_fast blk_SHA1_Init
> +#define platform_SHA1_Update_fast blk_SHA1_Update
> +#define platform_SHA1_Final_fast blk_SHA1_Final
> +#endif
> +
>  #if defined(SHA256_NETTLE)
>  #include "sha256/nettle.h"
>  #elif defined(SHA256_GCRYPT)

Curiously, some of the nested statements here are indented whereas
others aren't. We should aim to make that consistent.

Patrick
