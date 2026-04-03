Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691D28F50F
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 17:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775237730; cv=none; b=Nd/qQq/XEs8XniVaZH4IkUgNx3EgX8UYiYrvBUiwLvHPdGZfwnDvdQmnj5pVcSpnyzM+Pfftxsjnt6h0R5lW6cbXqJDuvT14sw4O8WLt7zk6adMTZrnvWtpx9VpUZdruzHRZ/3o4ya7E1CHuvrvcKP5svAbQVpsn84gwVb+sfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775237730; c=relaxed/simple;
	bh=/gYu1y0Runsnmmj9lyrij/bbX7p6E6gD+uv7FwS1pBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=POwhTG15+n7y7hHo4mDVj5vjlIAP6i+1hsX8S/mejEnsMVaHM0Ih2DuP3aT06t8aNkCr8fvt34NHWLDSYMGB/DE9874K5HrXQNIKfQ0Qfa6bMzqgO2/WnFOhaMsmIaggAO55qKGRioh4fErQ8b7uIZ9xHInEVliTN3uUlbWl7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=np8VDuK9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FDujzPmJ; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="np8VDuK9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FDujzPmJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id CF11B1D00071;
	Fri,  3 Apr 2026 13:35:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 03 Apr 2026 13:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775237726; x=1775324126; bh=KBLGj7iwGm
	H09keArAZJyY0UjTREwbGoVTY+pw4QQcc=; b=np8VDuK9cEnZ2/sySm6XK4hrmB
	NSlf5yWZccvh6ZsGjBwa5dJAtcT5UE/YgAsKw3OBeC8CiBNxq5SCfezW1xpQfQYS
	wvx24ZD1MtY8XpS6yXXmdaoSc4B//tzES2oc1nZXarpso7jbUs+ZU76MumLNqBVU
	6UGGkPPjpxquZko7ws1urC+4P4i+TS49DEKCRB3HfuN4YKnnkwQkE/cLDb2uNqBy
	kqnp2f1raya5ye8XNVUIN1qotq5HVEotHcUPLvo+5rOEpBdv8udBV54Xwql7Y0rK
	5vw0qhoFg1kMPnX+aKq+CYLTzQL3BQtHHYV227gSFyldooHZimzQBRkSDaxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775237726; x=1775324126; bh=KBLGj7iwGmH09keArAZJyY0UjTREwbGoVTY
	+pw4QQcc=; b=FDujzPmJZjOiiwCbSoE9OhxqPn65jc6BstMJuP0BiZjy7PNou2h
	aegQe3+kWo3M0qGpkR+vlIMkUUDrmP1LVu8jLLWKHs/OGKRh1g3QH26KqZaKyyen
	so3U1cG3ZC6siEzV9LlKV4IQDUwC/6TaW0C54AtU2vBE2nMNETSs7cFYCeFilqhf
	4tVe2wV7AXWo++6GH32Jw4FsaqciMEUGQ1ENbTFfBEVfBGVT4DKMfMbSmKZtPDKb
	dw6huxV3CrywGZkNLTgqa1ZqQGD5W5pw7x/RvX4XLqXaG+ZswXpTRDjXnmljppxT
	USD3SRmu22fMvf0+ynhZO/Zief6LhKy3Ccw==
X-ME-Sender: <xms:XvrPaWCnJPbQLFqhj-Csm20zbj76dCx_odSJuErJzgdCXXX3317-WA>
    <xme:XvrPaXZqqGNVnCsZm_FoLbQY9EHq1lTUoSUeJN4iu1_keSVlBa6Eq6FWyE_ldptlH
    8YfntQG7TZ7LLrNMeUQ0_bB4AOzvBOMfcdNSxQHCclF_13wP116>
X-ME-Received: <xmr:XvrPaR7rNdphB7kDcold7MAEQ3IuoUNqfnstDE5NctiRTjzn7yMC2ZdU7Wiy0eM5tBWywiyjjNCBvtkok7inGelqU4hb6MAy7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedt
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlh
    hinhesghhmgidruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XvrPaQY6e6MKWNzLsL2ODPyhqhbrVjVSSWdHHidAMlUnSvY9DMV2YQ>
    <xmx:XvrPaYjVNjjdCsQZjGoW_UTOoYD76WA5ide5n7E5ukt3iT63tjL9Mw>
    <xmx:XvrPaZ90jQCqFxYWu-jbv2R0PwvVHaT5p1cBRJrhopgN2323o2l3KA>
    <xmx:XvrPabrJzg1LfVBnQ8DdhstxM4M30r0HMIAW3nirQ0U5umpWbHMF1w>
    <xmx:XvrPaWwVYmKN5z-KEthMXFx7wlVmwn79RfJ0rbHbVGivGtsKNSx79rAp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Apr 2026 13:35:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] cmake: use writev(3p) wrapper as needed
In-Reply-To: <pull.2078.git.1775206502134.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 03 Apr 2026 08:55:02
	+0000")
References: <pull.2078.git.1775206502134.gitgitgadget@gmail.com>
Date: Fri, 03 Apr 2026 10:35:24 -0700
Message-ID: <xmqq5x68ne03.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is a companion patch of 3b9b2c2a29a (compat/posix: introduce
> writev(3p) wrapper, 2026-03-13) where support for using the `writev()`
> wrapper was introduced in the `Makefile` and the Meson-based build, but
> the CMake build still needs that treatment, too.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: use writev(3p) wrapper as needed
>     
>     This was necessary to get Git for Windows v2.54.0-rc0's CI builds to
>     pass successfully.

Thanks.

I should have been paying a bit more attention when I saw a patch
that touches meson.build files, I think.  Sorry about the slippage.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2078%2Fdscho%2Fwritev-vs-cmake-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2078/dscho/writev-vs-cmake-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2078
>
>  contrib/buildsystems/CMakeLists.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
> index c6cfb874ef..dce9c84d0b 100644
> --- a/contrib/buildsystems/CMakeLists.txt
> +++ b/contrib/buildsystems/CMakeLists.txt
> @@ -376,7 +376,7 @@ endif()
>  #function checks
>  set(function_checks
>  	strcasestr memmem strlcpy strtoimax strtoumax strtoull
> -	setenv mkdtemp poll pread memmem)
> +	setenv mkdtemp poll pread memmem writev)
>  
>  #unsetenv,hstrerror are incompatible with windows build
>  if(NOT WIN32)
> @@ -421,6 +421,10 @@ if(NOT HAVE_MEMMEM)
>  	list(APPEND compat_SOURCES compat/memmem.c)
>  endif()
>  
> +if(NOT HAVE_WRITEV)
> +	list(APPEND compat_SOURCES compat/writev.c)
> +endif()
> +
>  if(NOT WIN32)
>  	if(NOT HAVE_UNSETENV)
>  		list(APPEND compat_SOURCES compat/unsetenv.c)
>
> base-commit: 6e8d538aab8fe4dd07ba9fb87b5c7edcfa5706ad
