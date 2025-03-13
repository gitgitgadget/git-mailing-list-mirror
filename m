Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868DB15DBC1
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 17:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888407; cv=none; b=LMSdF46HKFSD5Y31cimoc9c1uNiY64FLtRUo5CK8njxUZYXuUAYluhw2MkZ0QLK7WpvqBQsZH9SVPSjRvk2qgW2e65ZJJA5F6cvdBuTpwv+oyDP3txgNO3CgrPmVKVjO8blbkqr0n7tu12CTH2xvVJrggkeFxnDd/2fOjGQiw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888407; c=relaxed/simple;
	bh=bQkPPNcdhZPcDxLlR2Nqa2DidCnqRVx9dxFuojlWtoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R/blJ+DWnlITWxfZ15SdCHRNO5dD5LVkumJLOtUSnpKA1alZ5YZHVXnQ5ceSZb9028UBOHztyw1B1anQPSrlfMu4dvpnXmF2KdkS5Cl6mvO+MMiPC3365/uYpKceMW94ho6aquBXUJqE5y5Z0vWNFva/8uJuAl/9nHXB8ap8ZLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ic2NHPOU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bjV8HAgo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ic2NHPOU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bjV8HAgo"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A9C01382D13;
	Thu, 13 Mar 2025 13:52:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 13 Mar 2025 13:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741888339; x=1741974739; bh=+huKEPwwQK
	sHhh+oxe6Ldo4bXTSyPacVxFKVdw6RJkc=; b=ic2NHPOUiYO7LljVQoTrPmxXot
	l+nLzrkW9mF+4cc8/Wb3RnBJ+f/dNbVeO1oMAt8Nyog98ylLOndDvZMFW568KPun
	UU6sNnXZfK8U1f4Znakc+a+ZcMItOrdDr6ib7ZMKw+4G4XVOh1z50PqgBqP+v0Eb
	W0NPfFiyg/CeflAz1AJryPfxX0vRUjt2PhGBMh/r+RKAUOhpwZue/KjN0htF5cmd
	xzamXVjbhWjPRUw8S1WGNSvnXHDVoLs6EvDdZ7LVcwKY6uikhL7q6schfEUIsWu+
	/9nlymWENX76kpHPlJcbFap1wurAKfDtI1eQCag7/dHpsUyA05ch/ZK89wrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741888339; x=1741974739; bh=+huKEPwwQKsHhh+oxe6Ldo4bXTSyPacVxFK
	Vdw6RJkc=; b=bjV8HAgocoTkD1UBrgW0TxOt99XtkOOJMkXtO+dfS9oKP5sI/xz
	lQgolOlkkSdVrWVDAE+sr+0ftSEwLvl33YaMsekCFCTSoeGwoa/QKgw0snH2h0i1
	3TczQXzQxDjr35PEslreGtcBDbBiUFRSxdnxZAovLTNtsqEapt05AupPD/I2vm7E
	6k81taEsckICzESoc95gRmFELMkyL0mwx47loZlilH+Y4+3Mb2ETLyLykSRinQ4R
	GwVSXCZosw/kfRV0xo+74UU5or8fyinuf08Fpn7J3EnRgGJt4jSIZ5vTk5cm7C1V
	a/WyqYXf0Q6G2g5T24d9vu5Ou0YO2bJL7gA==
X-ME-Sender: <xms:UxvTZ0elysr8DLnb7PhmalgmPiC5-nMm6yWJAQhtqHHWKNYc2mbRoQ>
    <xme:UxvTZ2NFMKCmlFuFpGqw97JM4q8_rHWitBzbX9d4OHPj4kPgUh6pstL-24X9cI4Eh
    jCoKZh8lgMThTgNYw>
X-ME-Received: <xmr:UxvTZ1jViFtREs81jmK6XhQCxeKNn9RcWjcleKhRODdetAbrxfY_8CJ1POb2z9gl0ZU6hvzewOjeveHq2jTGl-NWgkNQfdlyZhqme8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhih
    hnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:UxvTZ59S8yriqhQ-MKa3y-0Ad9TK5_DrB0wu3Sh0W4eOthw6IulBNg>
    <xmx:UxvTZwvMrC5tFbXDJqP8_WwTzJXoS2R61u2nN4J-mqbkyIcUOdeQ6w>
    <xmx:UxvTZwFf70OO49UCnLhlmm58pIfAuofSOt4C04hYmsnPCh5zQQnoww>
    <xmx:UxvTZ_Pqz-EPEANgg52lIRk32N2_5gT8c_wVAOBo_gJBngZB0DOlig>
    <xmx:UxvTZ6VxE8CbGWugIatKyht5XBLR20kCpFQoAza1WwYNQJqd2c756TrM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 13:52:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Johannes Sixt <j6t@kdbg.org>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] compat/mingw: handle O_CLOEXEC in
 `mingw_open_existing()`
In-Reply-To: <20250313-b4-pks-mingw-lockfile-flake-v1-1-bc5d3e70f516@pks.im>
	(Patrick Steinhardt's message of "Thu, 13 Mar 2025 15:17:43 +0100")
References: <20250313-b4-pks-mingw-lockfile-flake-v1-0-bc5d3e70f516@pks.im>
	<20250313-b4-pks-mingw-lockfile-flake-v1-1-bc5d3e70f516@pks.im>
Date: Thu, 13 Mar 2025 10:52:17 -0700
Message-ID: <xmqqo6y4om26.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Our MinGW emulation of the open(3p) syscall uses one of three different
> code paths depending on the flags passed by the caller. Ideally, we
> would just use `_wopen()` for all of these directly and instead rely on
> the Windows SDK to implement the logic for us. But unfortunately, this
> interface does not allow us to set the `FILE_SHARING_*` flags, which we
> need to have control over to implement POSIX semantics.
>
> One of the code paths is for opening existing files, where we end up
> calling `mingw_open_existing()`. While this code path is executed when
> the user passes `O_NOINHERIT`, we don't know to handle `O_CLOEXEC` yet,
> which causes a couple of code paths that use the flag to not use the
> emulation. The consequence is that those code paths do not support POSIX
> semantics because we don't know to set the sharing mode correctly.
>
> Supporting `O_CLOEXEC` is quite trivial: we don't have to do anything,
> as Windows already closes the file handle by default when exec'ing into
> another process. This is further supported by the fact that we indeed
> define `O_CLOEXEC` as `O_NOINHERIT` in case the former isn't defined in
> "compat/mingw.h".
>
> Adapt the code so that we know to handle `O_CLOEXEC` in case it has a
> different definition than `O_NOINHERIT` to improve our POSIX semantics
> handling.

This one looks quite sensible and straight-forward even to a
non-Windows person like me.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  compat/mingw.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index f524c54d06d..101e380c5a3 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -560,7 +560,7 @@ static int mingw_open_existing(const wchar_t *filename, int oflags, ...)
>  	int fd;
>  
>  	/* We only support basic flags. */
> -	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
> +	if (oflags & ~(O_ACCMODE | O_NOINHERIT | O_CLOEXEC)) {
>  		errno = ENOSYS;
>  		return -1;
>  	}
> @@ -632,7 +632,7 @@ int mingw_open (const char *filename, int oflags, ...)
>  
>  	if ((oflags & O_APPEND) && !is_local_named_pipe_path(filename))
>  		open_fn = mingw_open_append;
> -	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT)))
> +	else if (!(oflags & ~(O_ACCMODE | O_NOINHERIT | O_CLOEXEC)))
>  		open_fn = mingw_open_existing;
>  	else
>  		open_fn = _wopen;
