Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0700C78F43
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742220083; cv=none; b=e7JBPcrV4tVbySDjZxgHn1DHd9PJoVTZ9ynXjBGS7PlmRjwatDYmlEpSHaqbe7byLsKT8Cu9QrWhdH8ebeloGgW6fzUC09iIhat/XHaZHCu/iq+z3Nu1tV8aeFfEN3bfmbuqR+Sf395aJEkMJPr9D8YsOIyKCk4LcJilKgHUkd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742220083; c=relaxed/simple;
	bh=ZFhZtPBLiq81mrZixdAXeeQ7jhlUSGyrwg7zBvl0OAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OCw8XkCIzyIW0Duqoh2PivCTqgnWIu2jDdzgPNGyu0Ple0wtHpJh5xTJoD7EpyivBAD3+p87CohYqahT/ql5+7wR3O4NdSt3w8UkIVCTeNi1A7EGAOZlCUnRl9rPPpP5mwyhJobfRX8FkpNIY+lhONLM8id6oQu9rdQdguB3EAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DqULB3ZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=8Az5yMeA; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DqULB3ZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="8Az5yMeA"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D64DA2540187;
	Mon, 17 Mar 2025 10:01:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 17 Mar 2025 10:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742220079; x=1742306479; bh=6szMwz3qwn
	0JsjI/6VvosrPAEjbJ0XIHBR65e9V9zVU=; b=DqULB3ZWod26qqBCZ2WfJ+61Tr
	dVNYno/K/vIalTyFp5s8zKamaHjnSvsnH/LM6d5dd25IeXNXJu6Mak7uLNVO/Ubn
	NJUQjqkMsl7aZwlxc0dC71A/NZZdKMfN4jerPHPOItcrRQoWdHmfi+JL421DZd10
	vE3V0A4iHHgW8MBA6qnWmqZ1huq4eoFuxpsJDS/xPGYpumPplKr2YGgSj0In9dgX
	LHSOA2wfRFfIol1Vn2cyYW8RSU+I5ahBRBMiNUAzh2OPkJ4hgh0EDt5T+74p5aKF
	iKio7WoTUlC34alWgxx93h36c6Z5g9K1CSoPzg74CEq6AcojPtvDQwE0GENA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742220079; x=1742306479; bh=6szMwz3qwn0JsjI/6VvosrPAEjbJ0XIHBR6
	5e9V9zVU=; b=8Az5yMeALaVuh/K6OK3PVk+pXuavAW21+cJz8MB0W7OeYszNd4C
	XrJfiIhKglZteh8+Fykggs1sOC81tadwa60uwFafPBK/1SkDsnLSmUkNh6Yn5a97
	pF8Wo4HBjgngfWze2BvYqzHjoJixN2crHT1YeoXnSQhGmFgfXr9rlSvYxZrsLjPy
	Zq/l1JQ2n9plXpo7tVLN19ffKRbExf8+llkWIIf8MHeqye1fe7KqP7RdHussGFF1
	iJY7jfGNy7WWD5bhzKkNNZUJ4v1d5u4OqLySCcBocukpfx2fTBLdNnLWzu/twrai
	vZRbsNTfc9bnxlFUgrBWLVbYZIZZCs+q2zg==
X-ME-Sender: <xms:LyvYZ1b4-PaoY41KwWYdBfi_iC8zrq3FO2_yHr1IXtItDkVDWUBM6w>
    <xme:LyvYZ8YcXaJbM7EGrVvUg9PfQJM_p4MOpz2XPMYNzELWROdIvABg2gbRmUZ9wmcsW
    cS8mrXotpOMl4PyMw>
X-ME-Received: <xmr:LyvYZ398Z_uuXvRhes6oUlH17L4n7Cxf4qqC0BVTuV_i8fkwx572AsxRuvnkOdDpLLBArOz8juQ2K5PmCDax9gNBcCcDJb9bv3DY3QJbln_YgtvC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepkeekledtgefhkeevffelieelteekudeitddtuddt
    fedtveevheeiteeugfelvdeinecuffhomhgrihhnpehgvghnthhoohdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:LyvYZzqI4TBX8LXVTPP5Ys8jqt7YZlLkCDAxFQl9lH9LS_Bpo0IXGQ>
    <xmx:LyvYZwrhJo5UCaaOemZ5fb2cLJfR97TmIlUf8MVnjdB3ba_A6gYDkw>
    <xmx:LyvYZ5Rp2xbWleCWt-GMg7PbPvoslR14_cvwN9bpjQFbJqTf6GMi8A>
    <xmx:LyvYZ4p9VPv0cLlu3i3FaZNdBSKOnilHJlmRVBpk9b4fhOHovec3IA>
    <xmx:LyvYZ7Xt50xpGUKT8gzT09fCCwtSqc50uctnZUhOFK5F9t1om7dSGiOW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 10:01:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b720205b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Mar 2025 14:01:17 +0000 (UTC)
Date: Mon, 17 Mar 2025 15:01:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>
Subject: Re: [PATCH] meson: fix perl detection when docs are enabled, but
 perl bindings aren't
Message-ID: <Z9grLNimSDd8-Pen@pks.im>
References: <20250316060605.166364-1-eschwartz@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316060605.166364-1-eschwartz@gentoo.org>

On Sun, Mar 16, 2025 at 02:06:05AM -0400, Eli Schwartz wrote:
> The `perl` variable in meson.build is assigned to a program lookup,
> which may have the value "not-found object" if configuring with
> `-Dperl=disabled`.
> 
> There is already a list of other cases where we do need a perl command,
> even when not building perl bindings. Building documentation should be
> one of those cases, but was missing from the list. Add it.
> 
> Fixes:
> 
> ```
> $ meson setup builddir/ -Ddocs=man -Dperl=disabled -Dtests=false
> [...]
> Documentation/meson.build:308:22: ERROR: Tried to use not-found external program in "command"
> ```
> 
> Bug: https://bugs.gentoo.org/949247

Nit: we typically don't include Bug trailers.

> Signed-off-by: Eli Schwartz <eschwartz@gentoo.org>
> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index efe2871c9d..c6241c7a12 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -772,7 +772,7 @@ endif
>  # features. It is optional if you want to neither execute tests nor use any of
>  # these optional features.
>  perl_required = get_option('perl')
> -if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
> +if get_option('tests') or get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
>    perl_required = true
>  endif

This change does indeed make sense. We require Perl in order to generate
command lists. Ideally we would get rid of this dependency so that it
does become possible to build documentation without Perl, as this is the
only part of the build system that requires it. But until then I'm fine
with making the requirement explicit here.

Patrick
