Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB06C8F3
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393570; cv=none; b=QDBmaUqCTCdK6wXD3LmyhYDguQOkEnFIQk96E+8NpWbYTGgtGAXdyMCZWAxAi4vovbtA9yTUMkOkd67BodP7dnVEIdMmwuGJ9c6ySsbVD13dZW5gZpelFz5CcSALSiwn9kpO17l0TjEdzIwuFwlx2QD5jBzo+VEnDmB0VsVFy70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393570; c=relaxed/simple;
	bh=3TX07d9Jv+Nvy6p8hhLoY1IAKStfpW1ENcfQS1vqQEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KHx7AoYKEH8RN72H0L2sW9ech5vu3HBEZSlZ0YwAKw4k1WuE0Qtussz5ogINiEiHmiary6i86lbvMtfq0Jkw64/CapJH8uNurljOoW2QyoQEEyOa9Ddm2AZ4b2q+2ULkhl1rXuUGXl40fQI+JpcaHM2DvNbcddjfe0d9QEXYs20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sYCniqqb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sYCniqqb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AECD81E96B3;
	Mon, 25 Mar 2024 15:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3TX07d9Jv+Nvy6p8hhLoY1IAKStfpW1ENcfQS1
	vqQEA=; b=sYCniqqbliY+3NBKbuu0mTlDFJDa05JAwWMiH8hamVOy31zN75bYag
	dXP8NOpvTajRTVRTBosuJFmfKTy+ioUl97bUJT9n4xEC+8PLqQOkvvgQ2EC8/xfx
	bDEtdIzwdxJWnhxCjORkPxqgRAWeCfWpzhnEx4GRtARKkGxBUDod4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A39061E96B2;
	Mon, 25 Mar 2024 15:06:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F154A1E96B1;
	Mon, 25 Mar 2024 15:06:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  jn.avila@free.fr
Subject: Re: [PATCH v2 2/3] grep docs: describe --recurse-submodules further
 and improve formatting a bit
In-Reply-To: <cf9d3f4833f121b271fd8aacf4c0e2e4a9920585.1711302588.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sun, 24 Mar 2024 18:51:12 +0100")
References: <cover.1711302588.git.dsimic@manjaro.org>
	<cf9d3f4833f121b271fd8aacf4c0e2e4a9920585.1711302588.git.dsimic@manjaro.org>
Date: Mon, 25 Mar 2024 12:06:03 -0700
Message-ID: <xmqqo7b2jfms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BAA2F24A-EADA-11EE-895F-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Clarify that --recurse-submodules cannot be used together with --untracked,
> and improve the formatting in a couple of places, to make it visually clear
> that those are the commands or the names of configuration options.
>
> While there, change a couple of "<tree>" placeholders to "_<tree>_", to help
> with an ongoing translation improvement effort. [1]

These are all clear improvements.  Will queue.  Thanks

