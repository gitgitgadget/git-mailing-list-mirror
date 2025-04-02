Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0211B7F4
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579501; cv=none; b=qRMb8xCDbr7vTC6odo4n/8pQj+7swxt2Op/HbOO+nIbclu0nKNWheWPa4FnJBwKVWQRdg9cCaARoohmm918kS1FlPdJaL515TESLjK6wTrNwT/RVOR25SjknorWvl9lzKm/rWDyBSA5+weHdbb6iiEtH9JagepqGszBZ46GIhjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579501; c=relaxed/simple;
	bh=Edm98PSDjATTIejieN8r/KU83CjJm+ZOhd/chYcddR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6zn1ExkUe2NkXtVlqc4lyMkFc3vsi2x0zQTmuL5+3w+nzZUy5fSbd6ZDcPbluXShTBDLRP+KXeya2nXgyt2opjuKqAbAIqML47rDZU/a5w8feL/XocoqFbcnx4O+56O9L/ud+tbvTp80+X0GDBqtstx6F1O8NBwsNx/0vB+DV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AXHU9E4q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dZKt/+a3; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AXHU9E4q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dZKt/+a3"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E1B92540127;
	Wed,  2 Apr 2025 03:38:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 02 Apr 2025 03:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743579498; x=1743665898; bh=Qq62e+cUeh
	9rkEScYqmE7Si1RpA2roY1663kt5yRZxE=; b=AXHU9E4qGN20ajKvZD/xNW3W2C
	jQTByVsybx/A1qOvlLfq3SuPNRDz0kvgfjpDS/KB3bLi2T2MTlfPcbpFb9KyKyfw
	HNqS9sSbTsum3K5WGs5QJUOgyYrWXA6LYepIR0jA8aA3ar1H+/3XhiLkefOFbjNs
	c1jop/+UYYT1DDs6BIKlBqzS5W/YiNIMyGlUNiqPPxoCD3vk2fO952Z6evtvryRr
	/6EKD3v/0WaC3VFl70YibMyHU+Y5LRhOMPHmaBnIj/oMMdUJwYpgn6VIKeUHMcSd
	zzh8ireYZAAa/XjbfCE6mN+TWk5urIsKtvZ3Rr8iM8hwPb1WOszyePBPGHwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743579498; x=1743665898; bh=Qq62e+cUeh9rkEScYqmE7Si1RpA2roY1663
	kt5yRZxE=; b=dZKt/+a3nRtjL+YcCOQyYxIrAoDRFETzCzIA2LZo0SwvKbl1yAa
	3Uue6VAfF6wf6xkbttcsw/mNUqQbJja3rYLxSNKmDIGqVC5oz5YtgKBSnCLWAl3L
	PpYZlK3A4/HwrHLKy/fej+iPaJjwayvFg/QHvCggzHPoXFidJUYEBGss6jpHilGY
	sbqg73vcHDupdNKem2DkqPVCjoTFrDtRaGIZr/tJpAS+pIE9MaAFhX0QSmCUVcwQ
	k6G38LlGBJESPIO2mkbHCPldp9i6HbSLOM7bzymx3cCqQ05oIoK/rkr9ZZIfbTZZ
	oKRGq2Y8MX4Yw1xx1iid8E5lP4r8GrHEtnQ==
X-ME-Sender: <xms:aunsZ3E0Ab9OESyfmDqg8NtNl1kSZknc_h_MooORGLhPMIbZtcSRkQ>
    <xme:aunsZ0X2wgY57XbFJZODWpszrFXFCY3QOf-H6aQS9qSKeZteKk6yiVKEFRXLFg9jv
    gwnDj2_QOtHTBPa4A>
X-ME-Received: <xmr:aunsZ5IxQd_ej7blqpXEoRmLGJivnm7faoI9WMmmHYwO9y-iTYyJuirg7xyUl0BpKGN8uYtmRYCeTOX3Rk7Nap2cWCSVuRqNAnftmE2EsrsZnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aunsZ1GzxjSOc8I5gkKJiMeEo6j9InccJYg229DDGVTg-5dXyCjcWA>
    <xmx:aunsZ9XjpMagy53cRfaDMvZfefz_dVCuQtJWYBk6vATnlPF1Cfcqcg>
    <xmx:aunsZwP8KPhgskFXGlrgd8FaXPD2tsd7lOYqmtyz9eIF-yR0Zaz1nQ>
    <xmx:aunsZ82QP9t7GtnqYKg7GCXSCpBvz3553MTU6Bo8iJd0UAJOwTn3SQ>
    <xmx:aunsZ3-fFyiGdrEl6YAZ8MltiSQo1BqxMANGZ4Ws6rWsDtzQBh7QgLfE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:38:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bd801cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:38:15 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:38:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH v2 1/2] help: include SHA implementation in version info
Message-ID: <Z-zpY3D01Fg4q0Je@pks.im>
References: <20250328170121.157563-1-jltobler@gmail.com>
 <20250401203630.285451-1-jltobler@gmail.com>
 <20250401203630.285451-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401203630.285451-2-jltobler@gmail.com>

On Tue, Apr 01, 2025 at 03:36:29PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/git-version.adoc b/Documentation/git-version.adoc
> index 80fa7754a6..f06758a7cf 100644
> --- a/Documentation/git-version.adoc
> +++ b/Documentation/git-version.adoc
> @@ -22,6 +22,9 @@ OPTIONS
>  --build-options::
>  	Include additional information about how git was built for diagnostic
>  	purposes.
> ++
> +Note that the SHA1 options `SHA1_APPLE`, `SHA1_OPENSSL`, and `SHA1_BLK` do not
> +have collision detection.
>  
>  GIT
>  ---

I think this note is somewhat funny for an unsuspecting reader. On the
one hand they're going to be puzzled why you're talking about SHA1 in
the first place because it isn't mentioned at all beforehand. And on the
other hand they will wonder what collision detection even is in the
first place.

So I would either drop this paragraph completely or expand it to give a
bit more context.

> diff --git a/hash.h b/hash.h
> index 4367acfec5..51cd0ec7b6 100644
> --- a/hash.h
> +++ b/hash.h
> @@ -2,16 +2,20 @@
>  #define HASH_H
>  
>  #if defined(SHA1_APPLE)
> +#define SHA1_BACKEND "SHA1_APPLE (No collision detection)"
>  #include <CommonCrypto/CommonDigest.h>
>  #elif defined(SHA1_OPENSSL)
> +#  define SHA1_BACKEND "SHA1_OPENSSL (No collision detection)"
>  #  include <openssl/sha.h>
>  #  if defined(OPENSSL_API_LEVEL) && OPENSSL_API_LEVEL >= 3
>  #    define SHA1_NEEDS_CLONE_HELPER
>  #    include "sha1/openssl.h"
>  #  endif
>  #elif defined(SHA1_DC)
> +#define SHA1_BACKEND "SHA1_DC"
>  #include "sha1dc_git.h"
>  #else /* SHA1_BLK */
> +#define SHA1_BACKEND "SHA1_BLK (No collision detection)"
>  #include "block-sha1/sha1.h"
>  #endif
>  

This feels way less fragile indeed, thanks for adapting.

> diff --git a/help.c b/help.c
> index c54bd9918a..3aebfb3681 100644
> --- a/help.c
> +++ b/help.c
> @@ -768,6 +769,12 @@ char *help_unknown_cmd(const char *cmd)
>  	exit(1);
>  }
>  
> +static void get_sha_impl(struct strbuf *buf)
> +{
> +	strbuf_addf(buf, "SHA-1: %s\n", SHA1_BACKEND);
> +	strbuf_addf(buf, "SHA-256: %s\n", SHA256_BACKEND);
> +}
> +
>  void get_version_info(struct strbuf *buf, int show_build_options)
>  {
>  	/*
> @@ -803,6 +810,7 @@ void get_version_info(struct strbuf *buf, int show_build_options)
>  #elif defined ZLIB_VERSION
>  		strbuf_addf(buf, "zlib: %s\n", ZLIB_VERSION);
>  #endif
> +		get_sha_impl(buf);

I don't quite see the need for a new function, but don't mind it too
much, either.

Patrick
