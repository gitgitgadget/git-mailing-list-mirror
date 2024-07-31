Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5EB1AD3FD
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722444781; cv=none; b=hQu8rRiiX3oB8N/0ytfaxVGx1JuvH7GAJAnbeQ9Er3/LfzzP3I2CA4aUAlVHZUDnih44KlhV4DNTG4VyGL8YPN52oB62DCezOxDWzeKf1AJegtdnpSDPa2MCH55jYCBsgnEtctVfC0Wibk5gj9MLa1HnIpP8CD2b1gjWon6w3AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722444781; c=relaxed/simple;
	bh=XzG1IjXYUjkTeS4Dr6oMbdNivaEhHyduHa5L7CyJaqQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hfj4n3qCWE+WYhxPTtpJqdfhZjLCyRVCLp6WKr/jR1dIVQc00rLDFoILbKkRKVY8K3n+EBPaeHlxqQnXy2uhrwgsXT7SofBCJI6X5devBlz8k+Hys+1/kY6tVDAaIewiqkDebi2gNdXM8MVjszivjn1WtJqQkEggsflH4WVU2SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HxUkww9W; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HxUkww9W"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 45D381CF20;
	Wed, 31 Jul 2024 12:52:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XzG1IjXYUjkTeS4Dr6oMbdNivaEhHyduHa5L7C
	yJaqQ=; b=HxUkww9WpYTapPEJg6wbhD6WkP7vHE//9qUhOKB9w4dCmH/pyURb2i
	Xlca16G4YIJYX1bbKrMmVwlyBlp0JbR3/3mOKc7Kg6eq4KraOxB7+t9xEgFFUE55
	GrVVVutq9LPBFSHEGqz68cm6vD8LjOZjd2ch/rCH1IGTE/TmTaIcU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 356981CF1F;
	Wed, 31 Jul 2024 12:52:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4141D1CF1E;
	Wed, 31 Jul 2024 12:52:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: <rsbecker@nexbridge.com>
Cc: "'Patrick Steinhardt'" <ps@pks.im>,  <git@vger.kernel.org>,
  =?utf-8?Q?'Ren=C3=A9_Scharfe'?= <l.s.r@web.de>,  "'Kyle Lippincott'"
 <spectral@google.com>,
  "'Phillip Wood'" <phillip.wood@dunelm.org.uk>,  "'Josh Steadmon'"
 <steadmon@google.com>
Subject: Re: [RFC PATCH 0/3] Introduce clar testing framework
In-Reply-To: <008901dae362$386ae280$a940a780$@nexbridge.com>
	(rsbecker@nexbridge.com's message of "Wed, 31 Jul 2024 11:56:29
	-0400")
References: <cover.1722415748.git.ps@pks.im> <xmqq7cd18srf.fsf@gitster.g>
	<008901dae362$386ae280$a940a780$@nexbridge.com>
Date: Wed, 31 Jul 2024 09:52:53 -0700
Message-ID: <xmqqfrrp7bbu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 55438BCA-4F5D-11EF-B98C-92D9AF168FA5-77302942!pb-smtp20.pobox.com

<rsbecker@nexbridge.com> writes:

> I'm sorry for being so behind the curve... what is clar and where does it run?

We have t/unit-test/test-lib.[ch] that are our home-grown unit test
framework.  A handful of tests have been written to use it, when you
say "make test", or "(cd t && make)", unit tests binaries linked
with the home-grown unit test framework run.

clar is a _potential_ replacement for our home-grown framework,
suggested here because it would be nicer if we can use off-the-shelf
component instead of having to enhance and maintain our own.

Where and how it runs does not change even after clar turns out to
be good enough for our purpose and we commit to replace our
home-grown unit test framework with it.

