Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EBD20A5CA
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 06:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728629341; cv=none; b=CcUcSnyPrNqn1m22/cYWlBgBMxDyztxSjQ0wCOb6FdXIBF1hm2P5hd8mQIX2JL/tralnAmCglTW6QvX33NY4lthXYdaUSGrZupMFJkledQ+xrvd6MkTCz/0plWIBF6Ia70UjwXblM51SLJ3DypLjSZjKZih6IsYzKmps891W0CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728629341; c=relaxed/simple;
	bh=OYpddysyxopa89k7rYGNPX9vCNDcfV8Xh93vdKOM9nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9gWXdTytdZV0/yT+4LgR8z8DHIlY7l79v5YcibUGBUld858TlkgsM/CPVyPakmCAO7nUqFSLjrN3DxMKRN5eVJtJPcbsnqeMgmIqijsyNCm2UgeK7tHA7f5sDcKFiR9GrN1bQwUcseTcxLk4YoT5Kxl3CWhVArLh2RI7NzlCzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bYwdGGMc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WCEZWuPE; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bYwdGGMc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WCEZWuPE"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EC4811400EE;
	Fri, 11 Oct 2024 02:48:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 11 Oct 2024 02:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728629338; x=1728715738; bh=T9JPsTh3q7
	c7+l7utrrvZ36MVn9BtLfdkl8FTV3lT78=; b=bYwdGGMcLBNClK3mq3qH2ECHLo
	AOlyinw9Rzyto8wFLZWQdwRLQGik91EScCmshmBZaK3wSSP5o6cLQSkxVq29FLYa
	ZGquF2G1Ep3HW9lmd4WIZiIYocWM3SQ4jDNIG4GOKR20sg1ecpgEpqUGpLgcc7PH
	uwogwSZajeqHwCpmvHrDh3pdP61ADa55bVTWnDuh76lgalmMT/G3CCYQFZ3PPIoE
	IPEnGmfsHbIb22DvebuNHshJVIULXVSM6JcQDp9fsbpmGnw4g19yAj3pW4xcGsVi
	MOSr+dXFHSlBx9xOLQdR63gdV8uVs1m9bV2FfuM5TgCeHlWi33uJ4qW/Itow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728629338; x=1728715738; bh=T9JPsTh3q7c7+l7utrrvZ36MVn9B
	tLfdkl8FTV3lT78=; b=WCEZWuPE3l4uJDrt1hpN1M1XHoe/gtgOuTx4UaDrVzM6
	PbqV7+bLT5RfuCecNT/NUP3GjRlGSzFHFBa0owQ4rmwP/5LS6gig+92/7jlXdj8h
	auHPTQGK+88NXC1wK0+JjrJ8twSTbJplyjsNWjRso7ileQmHGzVFuIFLaYouBWTY
	fZrLnC1deQghOAhaqvpUfU7ibYG+9Z78GgoQRIeKoCe3yTO0ejUXENsAEckGAckI
	rltsCW4xagcWpBC5fa9OfyrgtNuUfGgs+pfMnzhCqDS5tP/GGD28sCiRDZtej1/I
	/QVrZOMEuqGOUkQVdO0AaNEJZtQ2UJtIHkIGMx//rA==
X-ME-Sender: <xms:WcoIZ5PjsSrUvGU2tNuRMvm0k0mCzIOSNAeMAlAC5F4DU3hiTLykSw>
    <xme:WcoIZ78Tro2TaYbcEJjoL2F0Kwq8h0rCMALk36C-EVeGp5Ew40iEQ4p8VVjmMXN5x
    npx7r3B_yEOhu-Wzg>
X-ME-Received: <xmr:WcoIZ4RaUIbHev61VmRb_0wOUXIr0wzAbpLvN6XqaRWzJzRDwwX5cZxX-2ctM3nQOpGrLjl-pAR7Mr6dOqQT-LPcFfFZBKF_T-w3-i6CQFugrAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepveekkeffhf
    eitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:WcoIZ1uOHJAgDmuMzSNHgJWhY38mtwAvtEy5_gwtlY6K2FZLASQSiw>
    <xmx:WcoIZxcjNmYIltdbV8Qstvush1Zu2PzJdJPYfSW-9rlVpIoJ4-4JNg>
    <xmx:WcoIZx03rvSw7140c-qSeqTX5NhvGlUlrqNhxTydaPh2C4k1IR4Gww>
    <xmx:WcoIZ98WCxtg1QPZ9V8Zkr3WyoGziTLtea0dHW7ECbHMkjLV-Lur6g>
    <xmx:WsoIZ44Cz4MtmpKmyfhCh4m0B1IoMjUZIuUQsyHi58UOASQm_lOxOf4l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 02:48:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2852969f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Oct 2024 06:47:47 +0000 (UTC)
Date: Fri, 11 Oct 2024 08:48:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH 09/13] git-curl-compat: remove check for curl 7.56.0
Message-ID: <ZwjKTJye2OmQClSW@pks.im>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241010235621.738239-10-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010235621.738239-10-sandals@crustytoothpaste.net>

On Thu, Oct 10, 2024 at 11:56:17PM +0000, brian m. carlson wrote:
> libcurl 7.56.0 was released in September 2017, which is over seven years
> ago, and no major operating system vendor is still providing security
> support for it.  Debian 10, which is out of mainstream security support,
> has supported a newer version, and Ubuntu 20.04 and RHEL 8, which are
> still in support, also have a newer version.
> 
> Remove the check for this version and use this functionality
> unconditionally.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  git-curl-compat.h | 8 --------
>  http.c            | 2 --
>  2 files changed, 10 deletions(-)
> 
> diff --git a/git-curl-compat.h b/git-curl-compat.h
> index 65ba1ee0f8..703756ba85 100644
> --- a/git-curl-compat.h
> +++ b/git-curl-compat.h
> @@ -28,14 +28,6 @@
>   * introduced, oldest first, in the official version of cURL library.
>   */
>  
> -/**
> - * CURLSSLSET_{NO_BACKENDS,OK,TOO_LATE,UNKNOWN_BACKEND} were added in
> - * 7.56.0, released in September 2017.
> - */
> -#if LIBCURL_VERSION_NUM >= 0x073800
> -#define GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
> -#endif
> -
>  /**
>   * Versions before curl 7.66.0 (September 2019) required manually setting the
>   * transfer-encoding for a streaming POST; after that this is handled
> diff --git a/http.c b/http.c
> index c5fdf1cd4c..4d59f11ad2 100644
> --- a/http.c
> +++ b/http.c
> @@ -1275,7 +1275,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	free(normalized_url);
>  	string_list_clear(&config.vars, 1);
>  
> -#ifdef GIT_CURL_HAVE_CURLSSLSET_NO_BACKENDS
>  	if (http_ssl_backend) {
>  		const curl_ssl_backend **backends;
>  		struct strbuf buf = STRBUF_INIT;
> @@ -1300,7 +1299,6 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  			break; /* Okay! */
>  		}
>  	}
> -#endif
>  
>  	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
>  		die("curl_global_init failed");
> 

I wonder whether we want to have something like the below patch to give
people a better error message in case they have a version that is too
old now.

Other than that I agree with the sentiment of this patch series.
Supporting ancient dependency versions that aren't used by any
still-supported and available distro doesn't feel sensible to me, and
scenarios like this are why we have introduced the platform support
policy in the first place.

Patrick

diff --git a/git-curl-compat.h b/git-curl-compat.h
index e1d0bdd2735..d65b5f55126 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -143,4 +143,8 @@
 #define GIT_CURL_HAVE_CURLOPT_PROTOCOLS_STR 1
 #endif
 
+#if LIBCURL_VERSION_NUM < 0x073d00
+# error "Your version of curl is too old. You need to have at least curl 7.61.0"
+#endif
+
 #endif
