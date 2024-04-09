Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF01763F1
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712697834; cv=none; b=ebjP/ZWdtkeyPMcqHfhVLeKNDOu6HP5tl1qnIXEQem4eZRNlnjQVgrN2Pu/TYk00TWjdUaJaI9UZxJWcP8jGwFreBjlxF7kM8b8gzgWX2cSWJFPodul5Vrm8zcxHhHjT28yJkYst/4ae2DEu2YB86YvsIm6QKYYaELWl1v5g2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712697834; c=relaxed/simple;
	bh=o91M+DFWNXtArUQlnxaLQ/vTreMkdJAcpa+1zxN8fRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qXpaMsGd8WnKHHhaYALQGJbJsAE1TyaMwPAhgmM5P/XvXrRoh+HC2+TM6IVcYhKr5/hGBqjG8zhy/aMAEEZpG3NVCVLMeCK0KCVFudkVoV5999mGaB0t/ojcDj0G0cX73CCK4k1PoCIBUm9cDyxFXwRqABBuMR9rSeOJA6mmHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cHS7GVSk; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cHS7GVSk"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 337AA1D717C;
	Tue,  9 Apr 2024 17:23:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o91M+DFWNXtArUQlnxaLQ/vTreMkdJAcpa+1zx
	N8fRw=; b=cHS7GVSkBdTG/+a0V9mgKyxKw0Rvgs1Kh8nn+uAbJ5mGW9/UASeYdX
	FCzbEIuK9pGQO/WH0opki9tFepZFDxWhArRdEueyaiPRJm7OkdNFy0SNCXulmP9E
	W4eCfWkbC96gVF93WGNvUlPAG4mjNvRn/IsctYaOP9sjZoqGfPJ5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A09D1D717B;
	Tue,  9 Apr 2024 17:23:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86C191D717A;
	Tue,  9 Apr 2024 17:23:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Smith <psmith@gnu.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] Makefile(s): avoid recipe prefix in conditional statements
In-Reply-To: <95f2454e449cc0126aaa40d2ab08c76b55ee3c31.camel@gnu.org> (Paul
	Smith's message of "Tue, 09 Apr 2024 16:42:14 -0400")
References: <CAJm4QYOxn_s8ktJiC6ju2j4OyEYaM2ay7Ca--ZWFWa7APVnTbA@mail.gmail.com>
	<9d14c08ca6cc06cdf8fb4ba33d2470053dca3966.1712591504.git.me@ttaylorr.com>
	<xmqqle5n8rcr.fsf@gitster.g>
	<606990048585347654f3b4b187ec27f4dc1b85e3.camel@gnu.org>
	<xmqqcyqz5sie.fsf@gitster.g>
	<95f2454e449cc0126aaa40d2ab08c76b55ee3c31.camel@gnu.org>
Date: Tue, 09 Apr 2024 14:23:44 -0700
Message-ID: <xmqqil0q1b8f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7282AA76-F6B7-11EE-9C94-25B3960A682E-77302942!pb-smtp2.pobox.com

Paul Smith <psmith@gnu.org> writes:

> I'm not sure I understand the suggestion here.  If I preserve the
> current parsing behavior what do I tell people who cannot get their
> makefiles to work because the current parsing doesn't allow it?

Their Makefiles were not working (perhaps began with HT followed by
a command whose name happened to be "ifdef" installed in ~/bin/ifdef
or something silly like that) before your "fix" to forbid using HT
to indent conditional, so your "fix" is not breaking them any
further.

If you optionally allow .if/.else etc., you can tell them to replace
their "ifdef" with ".ifdef".  Of course you can also tell them to
replace their HT indent before "ifdef" to spaces.

But the point is that those whose Makefiles were not parsed correctly
even before your "fix" need to fix their Makefiles anyway.  The
suggestion was about helping those whose Makefiles were happily been
grokked somehow before your "fix".  If you preserve the current code,
their Makefiles that indent their "ifdef" with HT will continue to
work, so you do not have to tell them anything, no?
