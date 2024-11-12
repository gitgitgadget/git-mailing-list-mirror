Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F5D41C7F
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378070; cv=none; b=g5Ite40aIb47NfRUDNB93DQ97bdgyriCyj12O5RaCGgLSBiSlRIgZcizAQn6UkNcnyvCC2JXmIb1wDI4EhNACSRek3ImgGVX9LPatFwmHY4i+itNhckwRpmGuFvucjHEZkGM45ZTY6A1GuGexKenRzzMafvC7ctUvCuGk1J4buY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378070; c=relaxed/simple;
	bh=fG0Dpzwm4DVEN6y9iKeeDEdWhNzqRSeM70xqWuvtzRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGCrpf7+6jDKXj0dQi5IvJKIr7Qt7H/bsUPm1wyXnE4kIsXJpjogiRz8r3OvZV46FEzxMcMnVbO6whtPadv3obaNLjdnP6I/vtwtZe8zvX52924gd1Gqu4E1Zkkd5NjwR73g2FNUha87mRZZpPVndB68/MSMxVa/lgxHy/9mQh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PsbgHTQ+; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PsbgHTQ+"
Received: (qmail 25896 invoked by uid 109); 12 Nov 2024 02:21:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=fG0Dpzwm4DVEN6y9iKeeDEdWhNzqRSeM70xqWuvtzRI=; b=PsbgHTQ+F6gz8nVqYeRrCh1wVEsBTIgzL8Uc9bGq7Va6Q1F7lH6rIDSMzkfbOE4O4UNdT1xPLAx70J3o0QpqbuZdG7ncySkEJp/PdpAkAC1T0IeYP8mRf+vREH2bOZ4EG4ci3MWqjn2CjpqntzwnOu2f5EVVA9DsY57o0/JyKHFwG1lmiHZQaJkpBpXY+So+EFd3AwiGbAkeYQBARDFRk9dUdX8NH1DTo4kLVJsQ2aWQ6KoCMkh3mVhHhhaNhYIhHG5+Gp+8GvKiOQeGNXZDWzdqI1VK4wzoEdJQsg5x1CMim9M6tH1lv/3f60EE+nRZHJRG6/6+kUTmUY0NnU6gtw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 02:21:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24246 invoked by uid 111); 12 Nov 2024 02:21:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2024 21:21:08 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 11 Nov 2024 21:21:04 -0500
From: Jeff King <peff@peff.net>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <20241112022104.GA77521@coredump.intra.peff.net>
References: <cover.1727881164.git.ps@pks.im>
 <cover.1729771605.git.ps@pks.im>
 <Zxv4osnjmuiGzy94@nand.local>
 <Zyi7PA2m2YX9MpBu@pks.im>
 <ZyjlvNJ4peffmGZ1@nand.local>
 <ZzHeLlYu8Gwk1FPj@pks.im>
 <20241111210629.GB5019@coredump.intra.peff.net>
 <bfc876ea-1a90-4e78-8756-efdcd53e7525@gentoo.org>
 <20241111221320.GF5019@coredump.intra.peff.net>
 <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3b00260-ec3d-4607-aaf7-9cfd9898434f@gentoo.org>

On Mon, Nov 11, 2024 at 06:55:38PM -0500, Eli Schwartz wrote:

> On 11/11/24 5:13 PM, Jeff King wrote:
> > No, they don't. I don't have msgfmt on my system at all, and always
> > build with NO_GETTEXT.
> 
> Well, even systems without msgfmt installed may have the gettext()
> family of symbols available. On various systems, it may even be built
> into their libc.
> 
> So, detecting and handling this case sensibly out of the box would be
> good, which I guess means checking for find_program('msgfmt') inside of
> po/meson.build

Yes, this is a glibc system where gettext() is in the libc. I agree the
fault is in po/meson.build which is not ready to handle the null return
from import('i18n'). So it is not handling the case where gettext() is
available but msgfmt is not.

Mostly I was responding to your original question, though, which is: do
the tests need translations. They definitely do not, as I do not
generally build Git with gettext support at all. So if there is a
dependency there, it seems wrong.

> That being said, the meson way to handle NO_GETTEXT is to use the build
> option
> 
> meson setup builddir -Dgettext=disabled

Yes, that does get "meson setup" to complete for me. That gives me two
other questions:

 - how would I know this option exists? I think you mentioned elsewhere
   in the thread the ability to ask about which options exist, but I
   couldn't find anything via "meson -h", etc.

 - is there a way to put configuration like this in a file, similar to
   our current config.mak?

-Peff
