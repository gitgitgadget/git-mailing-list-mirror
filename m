Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4311A328BA
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610677; cv=none; b=faeR84l6ucr0wxf0BkuiBZ6F8k5cXetVGLP4ZCdmWE3keQwJlFzFMGVwIoeh/LnbNoFB8aiuyDt6lbVFOA3A0Ocr9xJiAqkuODdV6wKqz1dNizIbADR19ShB4Neu8D8VZh6yZMuj1Ju9Rnc++BlFprTI+/jf6VhJC/RKhVrKyd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610677; c=relaxed/simple;
	bh=x3fi0pUaD4X4phq782civkzIbMYXqYV/NqhDosZ8mYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rJj18GBb0KJuziJBt/Y+aeBuFDy46VTjFwYQcKTbkg1ttyFQaeEpr8EICjUVsFdzekHWKrAWF/rU6pRH84NOo8/zaAXlOYR5M252FJKMTRXBiMw22cMdCwHaLZUs5nMfYGmFPwsCL6Ti4aw0q5FpXP+Uqo67RyQ7fEQSQlbDEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jSVS0Sy9; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jSVS0Sy9"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 953B11CC459;
	Thu, 18 Jan 2024 15:44:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x3fi0pUaD4X4phq782civkzIbMYXqYV/NqhDos
	Z8mYc=; b=jSVS0Sy9orZh4PTr5/EBhJ3rA3LLbAn9YD/vkMoSSs07S6/I9/47zl
	e8+Rkhfbs14M98s3fna9vYie4zWtOQeOnC2QTRapgOdfVIv5JWnwMGidOF4UYkhx
	i67eG4DoHUdFWMJhtN7WquJJY/4u1/ATwBKrUWDGAXoPW2K1uQhBQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C9231CC458;
	Thu, 18 Jan 2024 15:44:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE8171CC457;
	Thu, 18 Jan 2024 15:44:33 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 2/4] test-submodule: remove command line handling for
 check-name
In-Reply-To: <14e8834c38bcddc21856772b09f6fa77fa924b48.1705542918.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Thu, 18 Jan 2024 01:55:16
	+0000")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
	<14e8834c38bcddc21856772b09f6fa77fa924b48.1705542918.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 12:44:32 -0800
Message-ID: <xmqqplxype1b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 62FD7186-B642-11EE-A073-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> The 'check-name' subcommand to 'test-tool submodule' is documented as being
> able to take a command line argument '<name>'. However, this does not work -
> and has never worked - because 'argc > 0' triggers the usage message in
> 'cmd__submodule_check_name()'. To simplify the helper and avoid future
> confusion around proper use of the subcommand, remove any references to
> command line arguments for 'check-name' in usage strings and handling in
> 'check_name()'.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/helper/test-submodule.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)

Excellent, both of you.
