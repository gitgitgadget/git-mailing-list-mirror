Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C371AC423
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 17:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727199559; cv=none; b=niMz5bqt5BHDS9prw/E8E8z7OadiqHXGomsaA/obZwYadzDmYp9/8UQdqOtg/yb5hKIqGzhHP7pJljABxHeUbrCdiY+fDJgph/CEscmGQ4w1EM28bysGfiytTTGjzlehfggm1Zq4redaz9CTa+H0ZWpvCwA1WJ6OhH1InxmWayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727199559; c=relaxed/simple;
	bh=Ly8wiJVOtbU/ALYxyDSMD1Yrwfq9ymaR/TuTxm+eufs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=clnDTocUa2SAGodYJ3ymJZk+tzPf76IRNdISwJy17qfphw/bDmZS0D0rRw7RDpbmBP/TdaD2E/BD0V+JqUrKdnyp8EVOEhhBYix+f07aYxa68RRxw0yY6KzqKP2v3qd/+RZIGAbF1QahT8KHMiehxdgJR4oVRUehLkbYZfM9rbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JeP/gspn; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JeP/gspn"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B403436BF6;
	Tue, 24 Sep 2024 13:39:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Ly8wiJVOtbU/
	ALYxyDSMD1Yrwfq9ymaR/TuTxm+eufs=; b=JeP/gspn631kpS2YYoBmNwmIRqR6
	Dfv6sFMq3iNS8pMZuLBsmluwYIzJchY20472inSYBTOzvpA0oO6Ws204ZoNoVKjW
	EmGpxS+QwZZqiK2ekSBWy2Z5IKZRB4QFdAOuukmXsCNxwzRlKMkenu9DNsY/Y0TV
	0dKlB05jqodYUN4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AB72836BF5;
	Tue, 24 Sep 2024 13:39:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16C5836BF4;
	Tue, 24 Sep 2024 13:39:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Henrik Holst
 <henrik.holst@outlook.com>,  "git@vger.kernel.org" <git@vger.kernel.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Eli Schwartz
 <eschwartz@gentoo.org>,  Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: ./configure fails to link test program due to missing dependencies
In-Reply-To: <ZvKsH1Ct-YwBPA_f@pks.im> (Patrick Steinhardt's message of "Tue,
	24 Sep 2024 14:10:14 +0200")
References: <GV1PR02MB848925A79A9DD733848182D58D662@GV1PR02MB8489.eurprd02.prod.outlook.com>
	<xmqqldzsrhyp.fsf@gitster.g> <ZufjWR6AJM-DIWPR@pks.im>
	<29c5c9c0-aa61-415a-9cfa-d64a6b946a48@gmail.com>
	<xmqqy13oa8oe.fsf@gitster.g> <ZvKsH1Ct-YwBPA_f@pks.im>
Date: Tue, 24 Sep 2024 10:39:14 -0700
Message-ID: <xmqqwmj1t0hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 EB7CCF20-7A9B-11EF-B346-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> I'm not really sure whether distros _do_ actually use autoconf. Checkin=
g
> a few distros:
>
>   - Arch doesn't.
>   - Cygwin uses autoconf.
>   - Debian doesn't.
>   - FreeBSD uses autoconf.
>   - Gentoo doesn't.
>   - NixOS uses autoconf.
>   - OpenBSD uses autoconf.
>   - Ubuntu doesn't.
>
> So basically, we'd be making the life harder of anybody who doesn't
> conform to the "standard" way of doing things in Linux, which I think i=
s
> not exactly a nice thing to do.

If we stopped shipping configure (in our tarballs) and configure.in
(in the sources), would distros in the above list that do currently
use autoconf be able to build purely by having reasonable setting in
config.mak.uname already?

> And that's why I think we should have an alternative way to configure
> and build Git that can act as a replacement for autoconf, with my vote
> going to either CMake or Meson.

I guess the above question from me is a semi- tongue-in-cheek vote
for config.mak.uname as that alternative way.

> They are a proper replacement for autoconf that makes the
> downstream maintainer's jobs easier while also bringing additional
> features to the table that we don't currently have.
>
> Eli makes a couple of good remarks in [1] about things that both CMake
> and Meson bring to the table in addition to that, while also mentioning
> some of the benefits of Meson over CMake.
>
> I would be okay to make Git work with such a build system myself. The
> current CMake build instructions can be used to _build_ Git, but AFAIU
> they cannot yet run the Git test suite. Dscho pointed me to a couple of
> patches from =C3=86var that work into this direction, and I'd be happy =
to
> revive them. I'd also be okay with picking Meson over CMake if that is
> what people want. But my ultimate goal would then be that we have at
> least one CI job build and test against such a build system and give it
> the "official blessing" as an alternative way to build Git.

I already said that having to support two is better than having to
support three in another thread ;-).  If adding the fourth would
allow us to drop all other three eventually, that would be nice.

Our dependance of heavy use of GNU-ism in our Makefiles makes an
argument that make is the common denominator a fairly weak one, so
the single one that eventually we use does not have to be "make",
but it has to be something available widely and easy to learn.

Thanks.

