Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11419D062
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245169; cv=none; b=LNf5CX3STHM1LwEqvTO4CC80n7s8M+u7V7J8UKSH5lZ4tYGZ3kNyv1t+LWmflt5vn9LjT5jWLqX8w6GypvsQQsE2zklGQSwlcTkIx8mLopQhHy077MJbiLGhraDefiuN7NKlyKwE+dYRDdrkIQ7eLC3Slv59ASyM0Hv5ufg8vgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245169; c=relaxed/simple;
	bh=MVjhQIOmsSGhUNb72ykUHxKchof1ITMDWJHwNV+v9X8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YFOOSTAbfWLeyq6S54TFht6cvhPS5slHGVxHuN0Cb2p5cUfLjX86J4gLMtSa8kbPk3vTJS0B4M9d+Xp79TCddgK7Dnw5ZmS40SoUwR8pIRsJCRMKZiV9NpihIJgjcAjiJxrSpFh4W2jdAlKKKaqX5OqMp+Vj/Nj5hKxs5uovcRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k3iqo4pC; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k3iqo4pC"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE5E72F4F5;
	Mon, 24 Jun 2024 12:06:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MVjhQIOmsSGhUNb72ykUHxKchof1ITMDWJHwNV
	+v9X8=; b=k3iqo4pCXqC2clBfW3OYWEs6UTpsFo2IQWZwQSzC9RC3H1nyPH7Yvi
	FbfqwKwcc37zKccUPHp1FDWYe6/bCV15Smo4E//00uCvyTDi9ThwZFft0rAY8XM7
	Hysr2Bc6s+CEDnk4Exsr15RUhYBwv/RHU+b7vskMuou60roP3IguQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B64542F4F4;
	Mon, 24 Jun 2024 12:06:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DCE662F4F3;
	Mon, 24 Jun 2024 12:06:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: "Randall S. Becker" <the.n.e.key@gmail.com>,  git@vger.kernel.org,
  "Randall S. Becker" <randall.becker@nexbridge.ca>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
In-Reply-To: <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de> (Johannes
	Schindelin's message of "Mon, 24 Jun 2024 16:13:23 +0200 (CEST)")
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
	<20240621180947.64419-2-randall.becker@nexbridge.ca>
	<f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
Date: Mon, 24 Jun 2024 09:06:03 -0700
Message-ID: <xmqqed8me36c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A8DF8A72-3243-11EF-B08C-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +#if defined LIBCURL_VERSION
>> +		strbuf_addf(buf, "libcurl: %s\n", LIBCURL_VERSION);
>
> I am not sure that this is the most helpful information Git can provide:
> It reports the version against which Git was _compiled_, whereas the
> version it is _running against_ might be quite different.

An unstated question is that we are not reporting the version of
openssl we happened to find at runtime, and if it is better to
report it, not the version Git was compiled to work with?

I obviously do not care about runtime performance of "git version
--build-options", but I am not enthused by the idea of forcing
dynamic-linking with libcURL and all of its dependencies when a
script runs a simple "git rev-parse HEAD".

        $ ldd git | wc -l
        6
        $ ldd git-remote-http | wc -l
        34

> Wouldn't calling `curl_version()` make more sense here?

I wouldn't give that question an outright "no", but unless "git
version" is split out of the builtin suite of commands and made into
a standalone binary, I would *not* be able to give an unconditional
"yes".

For now, let's stop at the simplest solution---if the library
project gives us a CPP macro to use for _this exact purpose_, let's
take the offer.

