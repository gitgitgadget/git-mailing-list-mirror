Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40702045A1
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170105; cv=none; b=iRSwctv6h58iXh4Jaoea+lc7PaV/v0REodoilNSrQUzy2O1A/sNylh9wXgisvrrwCGFmOE6iat+oNN7bGfRB+RUf27DPFNhWmKy1OhvES5W80dP6IndGb+KLZXkNhg+qx5vB+o4ItX78mognqmhBQrrAdn9vFMHIJNNi72VpXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170105; c=relaxed/simple;
	bh=8yYgL3L7QCA6CVjAQhnvTrGRBlt+XaQ2vy8GN5HkI6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i/Z/1i6R1N2DIAqhwd48a6vptkEW2zX6rexTNxvoUKeVWFyieQ1iRwpL3dhjAzT4d8lJ2gQxOOYWNPVMr5ya9OmZ4paNjBOYBgTZFvSdW1ztz2czHI1Y5tYHRFleR3hwE/LOw70QxicC9PZVKlCuRkOSMwRQx8MSO5rA+b2wSxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=w5yJwYCW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cM3BssBW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="w5yJwYCW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cM3BssBW"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2E8C2540192;
	Fri, 21 Feb 2025 15:35:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 21 Feb 2025 15:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740170101; x=1740256501; bh=bEtzOJE38U
	/GgvNhR/EBy3xm8hrrSM7+uULs+aF6uLs=; b=w5yJwYCW4uIahPuWc0ZgsW2Po6
	iWSvbsnS7+z2QJggRCLE+jSVdrCpkQL6t15ZCqbi4XTypqNzh6x5esYOolQyjFZ3
	2olUO+mAnmXb9qzbyWUubXX2bHOcyAlhl1dX1eJ1Om7VYCjmeSANQV+NvwO0PhGV
	OVvuCOHN6p0PKpMdYllTmOgI0G/wTHoZzEbCMt1wg5vRv1e7KmAkWgtFkkxU9v87
	+fPWZaIlqmmuoG48Sf3pnYY1G6SkpV4nsOK9vnxDe0S/VPUJrFMQlahedJM7ZqVQ
	fx4j5UviJUOnOzbN/nJr7Qnlaei884zg1hd0dE90bYdl1RyeoLLuStslAmVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740170101; x=1740256501; bh=bEtzOJE38U/GgvNhR/EBy3xm8hrrSM7+uUL
	s+aF6uLs=; b=cM3BssBWC/KbJyVM5w1qBRRsrQo8Yry2oItemwPErP9OafAdewa
	7Wvgpp9colQ5dJTEMWO2TACDalQcxWBsYjfIFCUkcXM15S9eGjqfvn5hYZ04PI1s
	XemyRsa3qoR327RJY1UrtupUNkUJx+mCSWPqcFQ04F+eCLlGLMw+LK08nlxNFgk4
	wUimUFG8DoDwwZeeB6I5YbURVUHgYTBAEtjSZg32mP5feqx6CYkCB6UoeFDnUFx1
	bUNc2DKO/Aoz18gM0pTxDYFrnD8zWUFEBkv2dix205B26AlNlz9SBabo+IikTyky
	RGLWEVpD9By2HSq1iPU/yEnfBhx4vlQaCwA==
X-ME-Sender: <xms:deO4Zyd4iENeCRpBzygaB5LsglmgHPnweXlBEFqL041zdbN2WClF1w>
    <xme:deO4Z8NO-Do86Cc-EyBv29BpAj98BfNWr3yV2A2J5ZSfmCVcd_nbCTc_pC6VjeTGG
    53ijVEVYgEJqr2FNw>
X-ME-Received: <xmr:deO4ZzgTod_A8UAtTmHDoKyv9tCxbzbO95EuUudlEwHbwz_rbVcvdwgKY1h5QIUG2kXvrbS48KA5XJ5646XPA5vbRajfa_tPGu3GahA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeef
    hfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheprghuughrvgihsehrhhgvlhhmohhtrdhiohdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:deO4Z__qXHuh8rmTX2AurbmgMxWoVo0AjEcoPNO9yhWqxDUR5ROfFw>
    <xmx:deO4Z-vsCAO9iAhyIS6DRSoFZmk1ZAlwWyLdj-o5B6ZNjF8lE0vJ5w>
    <xmx:deO4Z2GeMgMx5IbH96egVaaUmjwZHSv8PQs3Wil2bwhJ8O0c_X9Zyw>
    <xmx:deO4Z9Mm4mhQozpoTeBDDcU1I8uHFPmFadON1uxE99zstDiNaLgiTw>
    <xmx:deO4ZyIPkuIpURfPBPMK65XxhPrehpgvkMypASEp1o-x4R6PzoEpx4bP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 15:35:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Audrey Dutcher <audrey@rhelmot.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] git-compat-util.h: Bump _XOPEN_SOURCE on OpenBSD
In-Reply-To: <20250221180225.3176533-1-audrey@rhelmot.io> (Audrey Dutcher's
	message of "Fri, 21 Feb 2025 11:02:25 -0700")
References: <20250221180225.3176533-1-audrey@rhelmot.io>
Date: Fri, 21 Feb 2025 12:34:59 -0800
Message-ID: <xmqqeczr9guk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Audrey Dutcher <audrey@rhelmot.io> writes:

> On OpenBSD, getdelim() in <stdio.h> is behind __POSIX_VISIBLE >= 200809,
> which is in turn locked behind _XOPEN_SOURCE >= 700. Without this patch,
> compiling on OpenBSD 7.5 or 7.6, we get implicit declaration errors
> when compiling with -Werror=implicit-function-declaration (default in
> clang 19).

Is this a recent regression?  Blaming these two line ranges ...

>
> [1] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/include/stdio.h#L236-L237
> [2] https://github.com/openbsd/src/blob/6a403588e27467d1f271831ca1de62a3befea6a0/sys/sys/cdefs.h#L299-L302

... in the OpenBSD repository says they haven't changed for many
years, and I am wondering what triggered this all of a sudden.

If we know how we used to have no issue, in addition to how we now
have issue with the current OpenBSD (which you outlined very well
above), and when the situation changed, please add to the proposed
log message.  That would help people on OpenBSD to decide when they
want to upgrade their copy of Git.

> Signed-off-by: Audrey Dutcher <audrey@rhelmot.io>
> ---
>  git-compat-util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e123288e8f..f6902ca2e8 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -195,7 +195,7 @@ DISABLE_WARNING(-Wsign-compare)
>        !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
>        !defined(__TANDEM) && !defined(__QNX__) && !defined(__MirBSD__) && \
>        !defined(__CYGWIN__)
> -#define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
> +#define _XOPEN_SOURCE 700 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 700 for getdelim() */

Also, I am wondering if this "A and B needs only 500 but C needs
600, hence require 600 from all three" is a healthy thing to
continue.  How bad it would become to split C at least from A and B,
to give it an independent status, i.e. leaving the above line as-is,
but insert

	#elif defined(OPENBSD)
	#define _XOPEN_SOURCE 700

before the existing catchall
"#elif !defined(__APPLE__) && !defined(__FreeBSD__) ..."  line?

If there is somebody stilll on AIX who can test, we might go further
by separating it out as well, but that would be a separate project
that should be handled outside the scope of adjusting for OpenBSD.

Thanks.


>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
>  #endif
>  #define _ALL_SOURCE 1
