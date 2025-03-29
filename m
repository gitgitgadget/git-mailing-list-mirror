Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B034182D2
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743271011; cv=none; b=aofvoYXLwdM09GiuW/gjuVMlSE0ak5ZFYXJ28ggZsqI2A9e76vIHmyPlV6+1uq8HukyahCqotMjZ0BnNCPj6weSI+oSK7Sk6Rnb2r/RDINP4iD7VKDieTTyZDwIZgvZ1kKbfFbX75FEDufM2IPctWZlA0+cWCszl7Jgiq81wrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743271011; c=relaxed/simple;
	bh=dnY+QerG0n+38i1Uo4QUg+HEDoiUkVQXbSqGGUqNigU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C9SQFBIAUwdFlvx5Q0mohrD7fM+hYClFRzUI0JFpKyHcat1wK9WjdWbYYg/xE1kSMwZBmtAe89bZw/QHWUyyIuLnHkm469SgVT2FKJeRE7HY/riN3/Aduo4CgckfqL4tILYQ2GEgYwxdIRJGqmzgXQfmqlAebbmiNlkwYEGJMVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qjs+XzVL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2iilTaL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qjs+XzVL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2iilTaL"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CA451140114;
	Sat, 29 Mar 2025 13:56:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 29 Mar 2025 13:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743271007; x=1743357407; bh=hWDSXmSJK/
	tVx+NUQomzw1TjuQbILt6GAe1wyO6DQ/o=; b=qjs+XzVLMpz5pTo4u5AlDx0fdX
	d8K+5xVD74Coj/+Y9QXhGIm1Uu3CcqymzMFVnABObWvYbawvFfbEyVHmsM8UjLM/
	TW/dM/oPk1VAjmF5hapxDasr3fe5BqTYbGKQSYZosf2qD2wtpXK+7e3v/862Ir16
	MGmBcgviaBURNm+AV5YyTiLZpOioLY4yRxs+NUGouTpdBI9TaHJM3OGsDfitHJzW
	3el8Mv86pNMg26U07tcaiNyjqd/vHxckmx/pRJ8401iUf/mKm26RWVrV2+Y4hAEf
	vZpr0FLCWN24XqO6Krt4JHXcJ+FknXTIHcumqLAZgNyRcRQ4O+lRjk2MzzOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743271007; x=1743357407; bh=hWDSXmSJK/tVx+NUQomzw1TjuQbILt6GAe1
	wyO6DQ/o=; b=H2iilTaL79lmn/+NjQPMzFjaKuOi7kPaROEX27wTjhT8EEsXnh+
	nAZs1+WNhzbtiVb3JfHBETR/XRhsHXyGb68jP9TiaqTwAb1rDnEa0Y9PAQqx6rnu
	t9TNflIhAEiU2iagxIq9giygxkYUaEH7BGExFD7sXffw+gFqhTYkDuzMysVMiaPY
	TgxFOZ6YlqFES7aVLd+zSrKzxNQdEAng5ImBtb/fBfjFjZTO6SV/ClxCKf2lOKrF
	SSyTh6VZV0sj3hr6OXU6G7C/SjZHQLC+CiEDUbJf5RYXKWYtTKaaqPooprxLyfhY
	PHyZbv9d4zUV0n90zlE4RzSOpKAoJUW5htg==
X-ME-Sender: <xms:XzToZ0N71e3QJ9JV6Nh5icCdYzTUudaf1xa9zpmLvleZfW0PPKGjSw>
    <xme:XzToZ6_JXRRgfaOz0qWxnsCqbL1TXbLlv7EY2j0wgP9vAAPc-pdmc1VGLr2HU3T3-
    3NTtVhaZSYERiU5Ww>
X-ME-Received: <xmr:XzToZ7Rx1pVdyR8YOam-cgg2crvmPik9azWdysGu_3AUYR9LKyaFI9PD4w5amt48cJ3CB2XqLF9GXjMqhaLFAv7O1i9lfWCbgPDw6y8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeegkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrmhesghgvnhhtohhordhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesgh
    gvnhhtohhordhorhhgpdhrtghpthhtohepthhgseguvggsihgrnhdrohhrghdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XzToZ8uNSaUFBwbGASpLnyesQsY-dpFEemZyfOkbs6gDJAm-0lBliw>
    <xmx:XzToZ8eFHXOustLHO2z_De2n2avrSKGKmRbqaY3hsv1ra4CDzhWTaQ>
    <xmx:XzToZw1cHfCtRZ5aar9m79caffKmmRX6gPq9N0iofJScyQcDZb-WJA>
    <xmx:XzToZw9xzTGwqLHFqO2PGIvv3q2WfmoA46Xz2zO5VTOr91PTkYQDwQ>
    <xmx:XzToZ6sdGd1-SMPg5ShAZ4Jz_9iHQBmY1KpJ_frSZp4Mpl7s9EVBSK5B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 29 Mar 2025 13:56:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Sam James <sam@gentoo.org>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Thorsten Glaser <tg@debian.org>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/4] meson: require Perl when building docs
In-Reply-To: <20250328-b4-pks-collect-build-fixes-v1-3-ead9deda3fbc@pks.im>
	(Patrick Steinhardt's message of "Fri, 28 Mar 2025 09:38:37 +0100")
References: <20250328-b4-pks-collect-build-fixes-v1-0-ead9deda3fbc@pks.im>
	<20250328-b4-pks-collect-build-fixes-v1-3-ead9deda3fbc@pks.im>
Date: Sat, 29 Mar 2025 10:56:45 -0700
Message-ID: <xmqqwmc7d8ki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> From: Eli Schwartz <eschwartz@gentoo.org>
>
> When building our documentation we require Perl to generate the list of
> commands via "cmd-list.perl". Having a Perl interpreter available is
> thus mandatory when building documentation, but Meson does not enforce
> this prerequisite. Thus, when all optional features that depend on Perl
> are disabled, we won't look up the Perl interpreter, which will in the
> end lead to an error at setup time:
>
> ```
> $ meson setup builddir/ -Ddocs=man -Dperl=disabled -Dtests=false
> [...]
> Documentation/meson.build:308:22: ERROR: Tried to use not-found external program in "command"
> ```
>
> There is already a list of other cases where we do need the Perl
> interpreter. Building documentation should be one of those cases, but
> is missing from the list. Add it to fix the issue.
>
> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> Commit-message-edited-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Two puzzling things.

 * How is this different from 7c8cd9c1 (meson: fix perl detection
   when docs are enabled, but perl bindings aren't, 2025-03-16)?

 * This uses get_options('docs'); shouldn't it be
   get_option('docs')?  With that changed, the patch becomes
   identical to the patch from May 16th, but the proposed log
   message seems to be vastly different.

I'll drop this step from the series for now, as the other one
already has been in 'next'.

Thanks.

> diff --git a/meson.build b/meson.build
> index a8d1e63ccc6..51013c70de9 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -772,7 +772,7 @@ endif
>  # features. It is optional if you want to neither execute tests nor use any of
>  # these optional features.
>  perl_required = get_option('perl')
> -if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
> +if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_options('docs') != []
>    perl_required = true
>  endif
