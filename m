Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA86F33B946
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 19:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963788; cv=pass; b=ZCZxaz7ruERlI6C/a7ySqTeiEv+UW9CokYLmAGjxZXsPx4nwTXv/3qWaAiNtogxgVYk7UTqGiPb03jaDo0qLKecCG8E/3sS8yOi5KxqWX95M/X1TkUmoR1hW+QOPg0w1km7Iu2ee8dTesOsQnNaYLJFMj1kM8UFuLukYXg8d8xo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963788; c=relaxed/simple;
	bh=yZal9oOnSAUWC2bdqRuj2V4UDSfzQDw+jZG9Kf1S4zY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g0JABJC3Y+WybPfdWItbCmc7uyyHHO0XpWMF8NWJDArnRzh3JPFJCDmGAAlTJ8WW277MPkYo0Vhb1xTN4DL+S8Q88WWsYzr2V9Wtwo4QuvQlCLRy4sppqORVL3LGS8Dstt+kLBcqI/tU6PEBu8rFCy90IMYnuHFiVloLjgiXLf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=FIVGlOxB; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="FIVGlOxB"
ARC-Seal: i=1; a=rsa-sha256; t=1764963757; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GBWEbOFTcjKpd5V26K8NusHE38m966EvnQ5Y8pV19UdZQsUHV/WHR5g6XeCwrglyxwBwfBygQhkTpqCpdaUgIdFG9qRsnJZFdHVCuqgf7XtKm89zl+AmT1PjTMMPJ1oJDBkGdlojHqUrtzeGVqzqwk/pSZx4Nsy/aasv3/3K/NA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764963757; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yZal9oOnSAUWC2bdqRuj2V4UDSfzQDw+jZG9Kf1S4zY=; 
	b=FVvsCwI1WFgZY65tZIrRVaVlX8jJ9U9i1IiGpE6lQq4bAI8iH+DqEVHBn6NA/voZJDtYeGJDCLy4zoQri7md8/R6Oi/NqmpCjqxOcSukd2ua7T/QYobCXWc5FbtwL/fuxUZJ5g3N7fI9OIPUPxjvLVQJrb8Vx+a372ggDVbRmTY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764963757;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=yZal9oOnSAUWC2bdqRuj2V4UDSfzQDw+jZG9Kf1S4zY=;
	b=FIVGlOxB9uA+daDRi1iLVkH6i0RXYU64y+owygNK8zdtgHrpeGLWIz4TysBtQVhE
	2+J1HrRpjKtwdOrnAmGTsb6HDHUzCeOMZbHXnvah7fMUJ86MKdd5TpZ/NMYCxoLA4Pg
	8J8nsf4Oqrs1o7NUh9Oo8PEXgxIIcM9zVcdHzjE4=
Received: by mx.zohomail.com with SMTPS id 1764963756407831.5573673836942;
	Fri, 5 Dec 2025 11:42:36 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 7/7] meson/Makefile: allow setting submodule encoding
 at build time
In-Reply-To: <aTLNxlKh02T_1PYB@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-8-adrian.ratiu@collabora.com>
 <aTLNxlKh02T_1PYB@pks.im>
Date: Fri, 05 Dec 2025 21:42:32 +0200
Message-ID: <87sedoemvr.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Nov 19, 2025 at 11:10:30PM +0200, Adrian Ratiu wrote:
>> Some users find it difficult to distribute repo config changes for
>> enabling extensions.submoduleEncoding, or to enable it by passing
>> the config via cmdline, so we add a build-time option which can
>> enable the extension for convenience.
>
> Wouldn't it be more sensible to make this a runtime configuration key
> that users can configure in their gitconfig?

The request I got from a combination of feedback from Junio, Aaron and
Josh is to avoid any kind of required user intervention or manual
migration, to find ways to automate the transition as much as possible.

If possible without even having to change or distribute configs or set
cmdline parameters to enable the new extension (that is why I added this
off-by-default build option in v5).

We could add a runtime gitconfig key in addition to the build and repo
config options, I see no issue with that.

I have no horse in this race btw, just trying to make everyone happy. :)
