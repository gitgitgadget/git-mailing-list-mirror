Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0B326D42
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353276; cv=none; b=ia5jRAlE2tyslvwTEZSGakGOjzZCzfwlApF+PR5Aui2lD3BtiOiP7cm0yOPGAq7H87kuKJqWs0LYZlHO4DgGRQc43Ka++aOL4pqHjkR3UvX9o9bUn8WCvND65aW4Wnn4z/acOozZ/9UAHTz2ScrZ3SGC+D7arAyAQE5ZFUNQWbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353276; c=relaxed/simple;
	bh=NfSlaOIZMqb7JTlfegA36GXD3Wfe0V+7pmLJZ7eogI8=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ofxJdaW/vDgRxb+1MER47RjqzYGxXMM/RGj4DofM0l4gf7jyIDtJvlk5rOHWQRehyCJQOoQ5UVrLix1BXwoY0m1bpvpmroeb8/lCt2TBsImmIW/wvoIuDegZTYQqRAoJKSf4bLtRPID0NzKgqHIJWtIqPItLrcaQYtRytAMiVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=SHjCHtsi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rw2cLma5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="SHjCHtsi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rw2cLma5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D7A8C7A0189;
	Wed,  5 Nov 2025 09:34:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 05 Nov 2025 09:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762353272; x=1762439672; bh=2cTt5WoHQO
	9UxUxNlxU+ARYubWg761t11D9n5coLcxE=; b=SHjCHtsif6gaL62YNtksSj3DQ6
	W4D8BFmEhDNlj2gJO1FfhGlPe0CTT1TTgAR8h/t0JxGZTI3jXXWacmhZAsdKtbHE
	SYBeAl6U+PJOtqknMxe2OTm08RM0OpjEZaxE1f5oynKZmB5VxqgCa9eBP+Gf9i2o
	Mo6URpGvAGB45FWd0JD3SQb1qrKqYvC3W/vHBHPQcTXzglVAHkJ5e92kLx7ZDS5F
	Fm4C1x1MU7XFeVjgu9sGno4rBKk6G/gGFTDNFxSLk5oqybFuivdjCuFmk7WmG43S
	dtFHaKwyTRvlgVb7K9LG+eNLjYeMVvSitN4z8ZZoGTMbUhNKbwbrMnbgvk/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762353272; x=1762439672; bh=2cTt5WoHQO9UxUxNlxU+ARYubWg761t11D9
	n5coLcxE=; b=rw2cLma5L8Xj6AnkbpzafcBnz/jjV6+38+wGMUz+T70Swxfj9p5
	hwiwql0e60LWY6LjUEDuEHWH54dmGJ5qSCCs9Kboi4RHX79Wq16ZnN2NEG8Gyz1P
	pZZ5kOJhAENFbzcV/7j7DOfDJa7959NwRHilnrC/j9RVY/y7tn0qIQ75bDgoMDeN
	He0NMUs3B9M0GszZQUNuYRs6EuXat6ux8OqYFeaDAa4E2zwk6zhIhXcspQK4Le5X
	0ktMLXDm4ho1MyctKpjlO93de5THYEq5YRD4ZLD23dElzoTEhfE9BsLEI+xh4yxJ
	1ESyqGrLbt/JrLezBXT59tgAWvFGXJu0TMA==
X-ME-Sender: <xms:eGALab2ROEXKH5pR4rVuTs1U1rBkb3MYhKio_-s8fFm8IgRU1BrekQ>
    <xme:eGALaQF71WQ4x-EywLhXsdN36K7AhhRoJR97ejPLtZV01fS9C1T0JkFTlPI8W4bix
    0RP2MdycW_yK60icXk1kzTFD3Ab4ZKqDmwLLmqbwBEY8uWOO--2eko>
X-ME-Received: <xmr:eGALaZg7nTKllhyQxnHYZ8VTIpWe88ftA456xyICn1sEe8Ky6jXtzybbkyirtf0Ac03m5Gf6LB-8qf7VQSFr_-77nFpLkTLSwhQu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepudfhhfduvddujeffveefhfetieelue
    ffheehfefghfffleeguedvgeevjeehgeegnecuffhomhgrihhnpehvvggtthhorhdrtggt
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:eGALab84d7jjTeeL5TRviT1150gTScP_x1rvG63piUX2YVvhr0yx8Q>
    <xmx:eGALaQpBmYM7WgrSxPOYOS9iA_g280kbILGpiMNQc_WPJf-0h_XErQ>
    <xmx:eGALaa-Yf_dVu0aQej5uQbPu78Js2K7fC2kK9EGmP0LPk35lNAXs0w>
    <xmx:eGALaUXvaWNB7OcBG51-EMbLLCiEsXMMj43gt1578dS3oVlmtfGBNw>
    <xmx:eGALaXNCMgEZqSx84Ucn8vM_LUWZwWO9Jjo9Ct3vEqoMupXAww1csoRZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 09:34:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH] GitHub CI: macos-13 images are no more
In-Reply-To: <xmqqh5v9o0hb.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	04 Nov 2025 15:13:20 -0800")
References: <xmqqh5v9o0hb.fsf@gitster.g>
Date: Wed, 05 Nov 2025 06:34:30 -0800
Message-ID: <xmqqo6pgmtu1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> As this image was deprecated on Sep 22nd, and will be dropped on Dec
> 4th, replace these jobs to use macos-14 images instead.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * This is a monkey-see-monkey-do patch.  There may be additional
>    adjustment necessary (versions of tools available on the system
>    may be different, for example).

This, when test-merged to 'master' and also to 'next', seems to be
enough to get GitHub Actions based CI pass.  I'll fast-track it in
order to allow us to run it with the upcoming -rc1, and eventually
down to 'maint',

>  .github/workflows/main.yml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index aa6bce673b..f2af90ad31 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -313,16 +313,16 @@ jobs:
>          vector:
>            - jobname: osx-clang
>              cc: clang
> -            pool: macos-13
> +            pool: macos-14
>            - jobname: osx-reftable
>              cc: clang
> -            pool: macos-13
> +            pool: macos-14
>            - jobname: osx-gcc
>              cc: gcc-13
> -            pool: macos-13
> +            pool: macos-14
>            - jobname: osx-meson
>              cc: clang
> -            pool: macos-13
> +            pool: macos-14
>      env:
>        CC: ${{matrix.vector.cc}}
>        CC_PACKAGE: ${{matrix.vector.cc_package}}
