Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C14211460
	for <git@vger.kernel.org>; Mon, 19 May 2025 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747682357; cv=none; b=LbDDdlcYUwDg1+yLiYYWdnDD8FwHyKbgqh7nwrp7BahQYHRZYQKeEYIZmIwbF4xpyEGlnfkaCtIF0e6LQnDWYbASa1r+uV8hnBsMHA1bcCkv3x6nyDiBUY2b2MDR3N/6ZDwVuCG+ET++HsjCnIpWdhYCotpjBuMkK4pqkCMnYCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747682357; c=relaxed/simple;
	bh=Gh9ZnUK5Q8S1hZm/Ep9L7CX91DrnqyPTI0mFsPqc1Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFbaD0Q3jvINHmLzX1UWg5EyuHNvEDWsbcMjF8DrI/XsAJ4r5T/UPBW87EOJZNR7e/7DWII7374yC/46T/9WIrZx3pJNpzWw7Xk1oiLzGX9KpdrTmHCurry1NGrfeRwxuugUAHjPPZgUu+pX/Tncr+RXgqt7guS2C9L2M2cV4Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=2EjRAsAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jREa2UUu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="2EjRAsAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jREa2UUu"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 869C11140152;
	Mon, 19 May 2025 15:19:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 19 May 2025 15:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747682353; x=1747768753; bh=H1pyPRVq4J
	IpkH/u+uyZRKLR8RRGHlqCVS7BjpMlTaI=; b=2EjRAsAaJyZsXrXRzoDS/oJe2V
	cj15a2OX6EUgsKvWed3w+cMzG4Jo7inZzulPCeJiXlKTWIjO4CITHRIgfzmhoJ3I
	DoRIU0K8cmXFhzdHF/VkxKAyC6IM476gx/6X81ROP16Xs1SkYDcLwdFJrics35O3
	OhYmNkv2GMxpSqbyJcYHXOGHzcFh3IZcNEmZlQi0SV5W8JFbEf+DFevLkywME4zU
	nSSnjiZ47kitVC9fQOcBUoNSEFjEWJPlyaVX5Yn4OqjA0zaWQwhvfpXr5uiwnC7p
	N4TAEm8wETYql52uWVpO1+DQOQu2qCtog5oQ0LCWdpyXFBlIdI+jWhXuLCsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747682353; x=1747768753; bh=H1pyPRVq4JIpkH/u+uyZRKLR8RRGHlqCVS7
	BjpMlTaI=; b=jREa2UUue7F1m1cL8PHFSuEHRXdGy3jGJXFU2sduViQ6d8f8SM+
	lAIDODzcPjjK+WrKhMlauP3n1402qSpBxfxc4Ki04sby7r97+wPUfXeX4C2FMXNu
	MaiV7GrPkXTxsZgV4ZCZeZ4uiZs5WXnhFRl67oaIPTFNJNDjpfJ7dOIO8RT7dEXV
	uxma6PZJ0MwoPMF9n/Wp+l61BJqecLT/1+wbBH0cVBak7T38O8EhM1TggC2l27Sp
	ElfxC4nVJzBUapFAaEhu5/hNSwTNDv6ax7qPkKyWlMaJ/pv5sIMIaY+KiqFJxf5K
	s/z0nXTY3KnfMXhkFzzAl31A+KrsEXF/FMQ==
X-ME-Sender: <xms:MIQraBrTQvnn-H2UorqQl6RwsmjpjOSLsxNKD8JS5P9N7E_6iftmYA>
    <xme:MIQraDpaC5uILuG4Mv4_Etny0ByLUdPGvjnnht0lWASz4uRG3Dlk-5Sgu6lrhLItl
    yL8wPfFPzfhn2JERA>
X-ME-Received: <xmr:MIQraOPevaeGz4LLGk5dGZDsIunPyJBa5hZ13hxun21XEkTWS1wmzHIIwQW7p1HKC87rHBeK46HmuZLad4Z53Q_j3HsurZFbL7szii4vrqy3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephfeigfdvffdvtdeuhfelgfelhefgfeevueetffdu
    gfehtefgveelhfeuueevuedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjoh
    hnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:MIQraM5EP5p8VwgXC7kPLxOdh-eYJ_lEBMZkWwJGefoDHloxr_hqHg>
    <xmx:MIQraA4k7dKIS2YseZaZxUKw1HkqXFqMS8iYP5QoG5uRlCzCfK-h1Q>
    <xmx:MIQraEiKK7-q1MWfDtZvli80WjDPQe0uj-q2422FtxzASWwmV-89jQ>
    <xmx:MIQraC4ixOAMIybAsXlsPKRLeJ88CRs78S1SLjdJcqza9h-J41WGGg>
    <xmx:MYQraLxJVxiCzTFzr7bDpxBdwvt0gmL5KV7uO7n9o-0pRN9GkFQX2CSY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 May 2025 15:19:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1a436fe9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 19 May 2025 19:19:09 +0000 (UTC)
Date: Mon, 19 May 2025 21:19:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: reformat default options to workaround bug in
 `meson configure`
Message-ID: <aCuELL0SLUkszicn@pks.im>
References: <20250519170945.57746-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519170945.57746-1-eschwartz@gentoo.org>

On Mon, May 19, 2025 at 01:09:42PM -0400, Eli Schwartz wrote:
> Since 13cb20fc46 ("meson: fix compilation with Visual Studio",
> 2025-01-22) it has not been possible to list build options via `meson
> configure`.

Nit: it _is_ possible to do this in the build directory. What doesn't
work is to do this in the source directory.

> This is due to Meson's static analysis of build options
> failing to handle constant folding, and thinking we set a totally
> invalid default `-std=`.

Interesting.

> This is reported upstream but we anyways need to work with existing
> versions. It turns out there is a simple solution: turn the entire
> default option into a conditional branch, which means Meson sees either
> nothing, or everything.
> 
> As a result, Git users can once again see pretty-printed options before
> building.

Nice.

> Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Bug: https://github.com/mesonbuild/meson/issues/14623
> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index a1476e5b32..43fc3afdf5 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -215,14 +215,12 @@ project('git', 'c',
>      capture: true,
>      check: true,
>    ).stdout().strip() : 'unknown',
> -  default_options: [
> -    # Git requires C99 with GNU extensions, which of course isn't supported by
> -    # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
> -    # learned to define __STDC_VERSION__ with C11 and later. We thus require
> -    # GNU C99 and fall back to C11. Meson only learned to handle the fallback
> -    # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
> -    'c_std=' + (meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99'),
> -  ],
> +  # Git requires C99 with GNU extensions, which of course isn't supported by
> +  # MSVC. Funny enough, C99 doesn't work with MSVC either, as it has only
> +  # learned to define __STDC_VERSION__ with C11 and later. We thus require
> +  # GNU C99 and fall back to C11. Meson only learned to handle the fallback
> +  # with version 1.3.0, so on older versions we use GNU C99 unconditionally.
> +  default_options: meson.version().version_compare('>=1.3.0') ? ['c_std=gnu99,c11'] : ['c_std=gnu99'],
>  )

Makes sense. It doesn't really make much of a difference for us in which
of the two ways we format this, so let's just stick with what works. We
could of course link to the upstream bug here in the comment, but on the
other hand I don't expect that we'll have to touch these anytime soon
anyway.

So this patch looks good to me, thanks!

Patrick
