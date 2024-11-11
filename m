Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D597F477
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 22:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731363204; cv=none; b=jwoKaebcmUg9GseP6iwuXy0TrPyywrf4Uvcd9RDvIZ6W2klKomPmpH2tOZVzyAr2ZdsaVIEQ5bInou8aCvt83/8Mkwxs62TSjvhLoceEWe+uJwTllTU7RO/tL6eIkXD6SF9NnFtYWYUFlGDW0wZnms3q4euh3q123tjThB1FjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731363204; c=relaxed/simple;
	bh=b91Fqw0D0IbvsE+2EPHlzdGgBQYtiVzTqUQtT53uBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4ynQdzCGp+WmV30qqU6TSlBeKh+KenCGCz18n5MTveQIjpQ4LnrKdBOys5dvF9xqzPrQZzgntsz7NE/588hZp4w5n6hCMSJypz0f1dWQkVDTljAzMuC7CbtpqJpdcO0NIqQFh/YqF32rsYyH35Bg9JiGE/4ainA9alOLU0MlrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hPq2WegX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hPq2WegX"
Received: (qmail 22106 invoked by uid 109); 11 Nov 2024 22:13:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=b91Fqw0D0IbvsE+2EPHlzdGgBQYtiVzTqUQtT53uBN8=; b=hPq2WegXHpmttNkdKkTJbvActJ4XGnnCNhPrHqKfC0D27jhj1zMwizxbfTc74pMaSH3GFhorWCzKCdAsZtuPTYkCEDJBTcmU8d19r6RSeXm3E5Bun1EBmfs2vi2gBOlyMT9UjbxpoRpLBhyIElJUkGscU4DA5Tk7uGyO/4xLe0VLbiMo7jBkpMmCVtC/cAkr5WqJx3a2j5gVXYgJpUhAh5RmGP4zE1hicOtVVMsp64QaTXJiHoVOv9wSzPisSXUxoMxQhqAOhqFK/Pk9KEa06khfZAjFtz/OrsFAjhkisNnlGpAMR6jmuYv0gsA3Q2+TFag1Y4oKKJu65jQPBUzxwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 11 Nov 2024 22:13:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20666 invoked by uid 111); 11 Nov 2024 22:13:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 17:13:23 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 17:13:20 -0500
From: Jeff King <peff@peff.net>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <20241111221320.GF5019@coredump.intra.peff.net>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>

On Mon, Nov 11, 2024 at 04:39:08PM -0500, Eli Schwartz wrote:

> > I hadn't tried it. I did now, checking out origin/ps/build^ (to drop the
> > "seen" resolution topic), but it didn't work:
> > 
> >   $ meson setup build
> >   [...]
> >   Program msgfmt found: NO
> >   po/meson.build:3: WARNING: Gettext not found, all translation (po) targets will be ignored.
> > 
> >   po/meson.build:3:20: ERROR: Can not assign void to variable.
> > 
> > I guess the assignment of "translations" there needs to be made
> > conditional?
> 
> 
> Yeah, this is an interesting quirk. Many projects would tend to figure
> that translation (po) targets are "optional" because if you don't have
> msgfmt installed then you can just install the project without any
> translations and then non-English speakers will be inconvenienced but at
> least the entire project isn't completely un-buildable. So meson
> automatically disables the target and logs a warning, but then this
> project *also* wants to depend on the translations for the testsuite.
> 
> So this should be taken into account. Do the tests actually need
> translations, though?

No, they don't. I don't have msgfmt on my system at all, and always
build with NO_GETTEXT.

-Peff
