Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC6C35E1BA
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781276749; cv=none; b=fo8H/oogUo1SUWSsn7MOD/T0KzIjwRTszew7ZctjjLe26F+SLZW7sI8rlddPHJz1rRSuY5QmkwYP+1f39ngZTCvBlVegjKq53ITY2uWj2SSVC6husSglyd+W6tb8tCGrnwIp3NVu3AtXdedJZ4diIpgAJwBd2cJvlokv0AHnlQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781276749; c=relaxed/simple;
	bh=t9JqVfEPgBS+NknnEFy7RPjWLNRd1XIr9y/rU15LP18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G9Z8j9IsvjFhvJrKjDEKjfJ8VEFlzcVhFHVp19qJCYs2P3q3SG0vvnD1GqXaEnic1lOguVU417IZVcTlDF0fuspzhUiGWJyYjrTbBRXpbclSCh+j2FUTvnqqTZvS8aOGK/i089QW7mHcmV6TBahDAK+J8hA0t6alop3WMk9cDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=INHfzZ5l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gum7NSNw; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="INHfzZ5l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gum7NSNw"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 566911D0003A;
	Fri, 12 Jun 2026 11:05:47 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 12 Jun 2026 11:05:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781276747; x=1781363147; bh=LgOmjCPwfw
	HUEktoiPPlj1tPVPIQQqm1mHCODRgXWG0=; b=INHfzZ5le4Armloy100mETWNeU
	4nO5q2BcLKjR2jrznxgyA+M/ZulJ2dnM7RHHTGUL4UZOjpcE1wHHZMVzFhJWy17t
	DfIJjhwb1smqkU5nIk+8Ao0HBFDw+XOnlJZ85Ji+Teu8l3xAvYBPlZ8LlzXKcD8y
	jLtHI3E2z2bQ82rmT9RxypYioIROL3+wLVy4GrfJJWXgLfzEtwg2yoIgpaioA6Qa
	BnNSiLPU+wQiEgQ04dUX8F/lkAIWB8Bgg9aqxukAGz5iMgBBhWGQNSsdycgqs3pn
	PIp5dVKinjwFrlkG9uB6NP2RC/5stHSLdq3+orRREpaQPk2uddw8mVS2CzNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781276747; x=1781363147; bh=LgOmjCPwfwHUEktoiPPlj1tPVPIQQqm1mHC
	ODRgXWG0=; b=Gum7NSNwZ8mQuqnfj2UXhHUCnYsHn4EMLozhrQtaNrppuGLHXT/
	ef78erBFPhfWUFGOLhKt03i6cNkoErmrTcWgKPu5yeS2E77T2XqpdpJ/wGbVwB2k
	qeC91bn0RjiEbpbEbyKGoAwwzLHWIXIr0Cm4wlYlQnFCJ6QnMgnwvVJkoFKQxFxe
	o8dSS/jiN9qQPJePbQWVLyP+6Dnrwp01YWUby9uZsGPeJdTCKjOWGWkMWDWmU/q5
	9eSMqpOJdnbX2CdazjeA0Y+7mxNUNcdy10G5qJbMcPAsFxPZtOKj79hrJ4Z9vM3l
	yopzVZbPuYFy2YGHeoxTzopXHXDY6Bg6IPA==
X-ME-Sender: <xms:SyAsatIvXr1fSj1oC_eWIL10bLMaFb0StEIc5eDQkLUJ7EdXHJvC9g>
    <xme:SyAsas1JGmlzL89_uLjpwVQ5MjX5PhQmclV0BHWZ3tEPYfFWBmthGuNhJ2j0v0x9b
    VeKwPVac6D4QBu21RClVjgugoeH58xHqOlfr7yWTkWqG-SIUh9rFg>
X-ME-Received: <xmr:SyAsavj0Pnac3Pz4rIvvvM9Qtvx-vD3sk1p13G_dVgX8eVqmgXT6XX0_5SjRs7UskGyWiiygzNtiR_ZzCdXrbNBhyTkC9dme6Bn7>
X-ME-Proxy-Cause: dmFkZTFMvaHH3aEDh6KkK6KkcOlOHXrR8t8CxGe3XoatMmKm9YuUWkfE+Bh/qpKYGLBOqR
    8fdIjCY4pbbp7Ye9rzByw3LmMIjBP3XwlvqtM3tUSeJ3Nhdf73KQsv8sACursrdus/q6Yp
    xYsr9HKFBpRGfUBj/wc2CHq4Y7JkB+HnUymMBu6TAEdLV7W1WpjYelpfu4BEri4lBerQk3
    wXigUd3F/31ivi2OMKFa03TGjxzNRlNOKAnXxxZwrFdMEUdoXUGxVbZkzxH3fcsyET4Abo
    /NleEUDrgYwpd+8OwSaedoDd68JrMQcL9cRZ3w7yRR6sZibXv3lQ6cSWqym7E+Mnu38SQb
    bnqG9IVO7y1yyMZukVHgCo3gGmqhSd2InYnKaWJNaLEERTsVzQVDx5C+9kbh9tNaTc8pc5
    IwWu5gRM2wIO8bcAUacOQNC2xAA472Rv8xvgK15RYxg+HugNMwvhJ0UdWXuXTz/v5qTupo
    cAsi+W+zQ+XFlfoAgd+kPAPTusaDpaSH+PabGggccifqv7dep6FhfXGCKDlxs+tbL41Tjq
    r200H3GE3dH+o6HptbJw0OXLTlKjk0rbVPTleAGuyCr+McX9RKxCT4T/nNfTJMJ+XbZ32H
    OHTEZLb1KIL6q5oBXPHlZ2JQMwQ7Iw7gwrRdRr6Namau7uOIMvU6GgwvC7qA
X-ME-Proxy: <xmx:SyAsalWNcrH6bm8JA3GwiL7e96AxJSZYzBwb1ntsvmWfxbCru3UJvw>
    <xmx:SyAsamVakt_hz2njFed9h3wtdbg4uILzufOzsj2LT8Z9KqrDYkJKIg>
    <xmx:SyAsathZ0ygzMhUvnjVB2QxHoD5hg-_owXNciLI6E4EvrUN6nLBaSg>
    <xmx:SyAsapbH3XUvm0Yk7OF03zB2dXbls_eV2B-dYYQsX3jhaauVlwyrxQ>
    <xmx:SyAsaqtK0WkBkau7rX_tGd8ZiTamri_yNLh2t27NdeekbBCPvzB53_4A>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jun 2026 11:05:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v3 0/3] doc: config: fix AsciiDoc glitches
In-Reply-To: <20260612045329.GA593075@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 12 Jun 2026 00:53:29 -0400")
References: <20260610185148.23920-1-taahol@utu.fi>
	<20260611161946.12166-1-taahol@utu.fi>
	<20260612045329.GA593075@coredump.intra.peff.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 12 Jun 2026 08:05:45 -0700
Message-ID: <xmqq8q8jiyt2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> On Thu, Jun 11, 2026 at 07:19:43PM +0300, Tuomas Ahola wrote:
>
>> Tuomas Ahola (3):
>>   doc: config: terminate runaway lists
>>   doc: config/sideband: fix description list delimiter
>>   doc: git-config: escape erroneous highlight markup
>
> Thanks, this v3 looks good to me.

Yup this one nicely sidesteps the yucky \# thing, which is very
good.

Thanks.
