Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1723434545
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631744; cv=none; b=BjKKjUWPkbotH6TtdNyMyfk+PYu2Fvwrwqzkxdll1VdtNhmKkaYU4nXd46ZDfnk2gqPXVokSLU15886NPR+JrUTyYYQLbMeJPhTpR+AL/IYT5F2auhk2cQF2pAY/MPnMXgW7X7cUbEvVBttUeep6o9EKTa0edFPqBg64M1ne31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631744; c=relaxed/simple;
	bh=Avd9llKnhQKmeqpMKT7EHkBgNSpCm2VTmmfBXBO2WmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DdwjzWfvgwL6UvcIakJSGlOMn3v56ZrFpo2TJrE3CfCv2TJqEaIlv/jgBC0+5EFoxq9H2IoF55hTpwid/z+1VhUrbr1nz4NXD9e2GoABY8TJG7JOC+IZEVfQA60gRKqulQAzLBf+sw8gn7dYbMTJyJTOoEO6K2iBnY38ss3NqkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oih/kek9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oih/kek9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 99D0F2E541;
	Wed, 10 Jul 2024 13:15:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Avd9llKnhQKmeqpMKT7EHkBgNSpCm2VTmmfBXB
	O2WmU=; b=oih/kek9lTowkBmHh7wSgvCa1fz2nZ9r1Mc22u3ocCcdjcxmZKOv2p
	DEiqkmFhVt7evmQ9dKUkzeE6eagSo5rV1Or8bioomP7iTrJDFbnD/0o0FHMI3tPv
	qqz7LL7LvdLkeHrtDr0/6WCGGrLMiqfl4BNyYOUhwNmgqJ/gdUaW0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9201C2E540;
	Wed, 10 Jul 2024 13:15:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 243DA2E53F;
	Wed, 10 Jul 2024 13:15:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>,
  =?utf-8?Q?Ren=C3=A9?=
 Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 10/9] t/.gitattributes: ignore whitespace in
 chainlint expect files
In-Reply-To: <20240710084704.GA2061142@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 10 Jul 2024 04:47:04 -0400")
References: <20240701220815.GA20293@coredump.intra.peff.net>
	<20240710083416.GA2060328@coredump.intra.peff.net>
	<20240710084704.GA2061142@coredump.intra.peff.net>
Date: Wed, 10 Jul 2024 10:15:37 -0700
Message-ID: <xmqq5xtdxj5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0786C204-3EE0-11EF-92FB-DFF1FEA446E2-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Jul 10, 2024 at 04:34:17AM -0400, Jeff King wrote:
>
>>   [5/9]: chainlint.pl: check line numbers in expected output
>
> I just noticed that this one throws off a bunch of whitespace errors
> when you apply it. We might want this on top of the series:

Or at the bottom ;-)  I do agree with the reasoning.

Thanks.

> -- >8 --
> Subject: t/.gitattributes: ignore whitespace in chainlint expect files
>
> The ".expect" files in t/chainlint/ are snippets of expected output from
> the chainlint script, and do not necessarily conform to our usual code
> style. Especially with the recent change to retain line numbers, blank
> lines in the input script end up with trailing whitespace as we print
> "3 " for line 3, for example. The point of these files is to match the
> output verbatim, so let's not complain about the trailing spaces.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/.gitattributes | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/.gitattributes b/t/.gitattributes
> index b9cea1795d..7664c6e027 100644
> --- a/t/.gitattributes
> +++ b/t/.gitattributes
> @@ -1,5 +1,5 @@
>  t[0-9][0-9][0-9][0-9]/* -whitespace
> -/chainlint/*.expect eol=lf
> +/chainlint/*.expect eol=lf -whitespace
>  /t0110/url-* binary
>  /t3206/* eol=lf
>  /t3900/*.txt eol=lf
