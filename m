Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5EA8F6B
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750630; cv=none; b=FmW4kDZ9qnNfHPYCvK/aYQIRYvOof+Y27j0uXD21P4RhnyxjzoSmAtCMSwSjbUno4hJYH7QmGPNGo0c1NbWxp7o1mUKfZpbVDgeOH4KlFNVMdqzjtKyf0qTR1t/buMKIod6F05/OzvNRW7GrwJ5A625pLzy8ZEkJmCw8QouCw6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750630; c=relaxed/simple;
	bh=73sFtJoZRtrhiwSxvHPY/IiYcy6353aMdtHfqnkvk+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKcYH+TAvYMoFslbnNuuCDCEFMiVB12Fb4xe1Ihn0PL+cpTYbc1t6XNcXak+4kT0hRwNyzhX44uCR/OAG7898EUB/Y9SF978GsLOohWZXQmcwAIM5ygP5RdbjRSx+LwpgcaPp1I0Wm9rQoJkvx00fr05PmBzlLabuQyKNamfRKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E1wXuFW0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFDC0lcF; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E1wXuFW0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFDC0lcF"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D366254008E;
	Fri, 28 Feb 2025 08:50:27 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 28 Feb 2025 08:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740750627; x=1740837027; bh=v5h4RIQCrz
	OanSPceMoq6G0UU/9Bd8+JVzp62ABLOLQ=; b=E1wXuFW0qkOAYa+TEp8Kk0HlZx
	RgTdBYcx318RbmKvzUHVhgjLSxC/etGLStEj6Hex+YenVZfWozWVu0sHO8+h2TSu
	8Bl8F2mA8ZyhoDcLo3LfPwN6Kvw7fo2uY/kl8xDzXGzqnCLjxWPxQznaLLHY1zdF
	yUe9uR1tXzw3euy6HGmthLynalci7DRyAG/wDHNa5TcKlRmh+UQpNVJaE/xbmlt7
	Sae6o2QByGuKfB9S45gW1vwUNFBMRh7fVSk/qGhGVNpHUfw/CJ+Lrx1JgavskMS/
	jq5QwZHH/q5CEv1GZ7bovKgCkYzqHwDwhlnUlWqzUxwTi63mUWjy+RQp4CLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740750627; x=1740837027; bh=v5h4RIQCrzOanSPceMoq6G0UU/9Bd8+JVzp
	62ABLOLQ=; b=cFDC0lcFY4hzKxCl8bSynE477RvvQOj9tAxc34hrF0QNMy4MSH8
	Ak1MeCLQGHRp9uTqtzHMJc5ae9P7DI3aWlfdkSHc54Mf7g8TYX5B6+DCv+hOfpp+
	WcxCEidGaFYwcxd2y7l6NC0zuw3xArerV+YephBYvLD+BaeuAxdR1hO5zqRS2r7C
	N185mziKcSq+mb8CoPsppRIoMJk9siRH1ZUs0fsY5U59zjmnxbLm8IRm5gKz+5Ju
	Fd7E7JFxLqVCe0SmT3Yz50n94RWTt7i5Lo5DTFNmhmU28LNhMcWQekqGvu3qbI6p
	0jdaxazEgYdngMv7yBmJGTwBW1hsySLyY3A==
X-ME-Sender: <xms:Ir_BZxELvumL6UHaV5gjgCc80sBoj2QmGa6tnYb4WvK5SDfRkYNnSg>
    <xme:Ir_BZ2UYfn1xWHIAAaARD0QaHHAFeHkvJSTInNrC81rILwcGl-M7rURze-hgmcIkW
    b8tXSKgsOpsqsfpEA>
X-ME-Received: <xmr:Ir_BZzJ5F8OgI4JRTznMuIzgO6ziEWeRbKZhVDieeRGJIiTH9VRRN_oo44jI0EPHnVqP9AbvScJWrLa-1UfE8mqeHN4xs7QDWwc-rBgE4OPsSBuSz8uH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefvohguugcukghulhhlihhnghgvrhcuoehtmhiisehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpefgveefveeihfehhefhgeethfdvffehfeehueelheei
    ffeuvddvuefhveffiefgueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehtmhiisehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhs
    segtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:Ir_BZ3Hy3IJ7U0q6aoELuyVISSQBbrG19fHLTECZambghqPF1CGFSA>
    <xmx:I7_BZ3WEVPQO9AkLj64433AfX0T6MSvqbiVW5WI5XaWRU6jOe3B0rQ>
    <xmx:I7_BZyMgwAlOwdOVIfK14awyWz6tZQ-94HxMnG_xdW8iPT1LkCStUw>
    <xmx:I7_BZ22yjjD42grJrmWOXJKDcKlcC1rHTBLTRoD_z18qxdVkIfzlsQ>
    <xmx:I7_BZyRHcd1UWL2ut3rybT21qfM0re-fLvE0OaJKr9ravgURJAw2HnkA>
Feedback-ID: ia13843cf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 08:50:26 -0500 (EST)
Date: Fri, 28 Feb 2025 08:50:25 -0500
From: Todd Zullinger <tmz@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] contrib/subtree: rename .txt to .adoc
Message-ID: <Z8G_Ia-oXgRcgVvs@teonanacatl.net>
References: <20250228034713.203461-1-tmz@pobox.com>
 <20250228034713.203461-4-tmz@pobox.com>
 <Z8FwG_q7NmRDUqof@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8FwG_q7NmRDUqof@pks.im>

Patrick Steinhardt wrote:
> On Thu, Feb 27, 2025 at 10:47:06PM -0500, Todd Zullinger wrote:
>> The .txt extensions were changed to .adoc in 1f010d6bdf (doc: use .adoc
>> extension for AsciiDoc files, 2025-01-20).
> 
> Same here, we also need the following change on top:
> 
> diff --git a/contrib/subtree/meson.build b/contrib/subtree/meson.build
> index a752a188df1..9c72b236259 100644
> --- a/contrib/subtree/meson.build
> +++ b/contrib/subtree/meson.build
> @@ -32,7 +32,7 @@ if get_option('docs').contains('man')
>        '@INPUT@',
>      ],
>      depends: documentation_deps,
> -    input: 'git-subtree.txt',
> +    input: 'git-subtree.adoc',
>      output: 'git-subtree.xml',
>    )
>  
> @@ -63,7 +63,7 @@ if get_option('docs').contains('html')
>        '@INPUT@',
>      ],
>      depends: documentation_deps,
> -    input: 'git-subtree.txt',
> +    input: 'git-subtree.adoc',
>      output: 'git-subtree.html',
>      install: true,
>      install_dir: get_option('datadir') / 'doc/git-doc',

Thanks.  I have not yet looked at the meson build so I
didn't remember that should be checked.  I still build a
full set of packages for rpm-based systems and there were a
few remaining items which were not covered by meson in
2.49.0-rc0 (or so I thought). :)

In particular, it was contrib/contacts and contrib/subtree;
although the latter is obviously not true and the former
won't be for long.  I'll definitely have to take a stab at
building my local rpm's with meson very soon so I have some
better testing there.

-- 
Todd
