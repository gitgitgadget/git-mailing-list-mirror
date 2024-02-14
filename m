Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E308B5579B
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931991; cv=none; b=BcGt2ZWvgAWuj6KoZ6AFXtrvtldzP97i4D3C2AGcV899OwqrAWC6+3SUEVV+VxTxeipPbxdMhLuYLJCQhx0maRU+PGOkGjzTwFlUGjuaOQVV5gK2/Z4LO8qPIAU8ru0zZdcJIkXkl9YN81c3VeTS0fpVK415uPEsXUSNEJKPz8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931991; c=relaxed/simple;
	bh=N+7QOXslNlH9v8tmTCqar6WiK/mZMuS0EJ9Q+gcmvUU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OixS0Te/tMXdyCTU2pSCvOraCP1ntzz8fgPsI5jDCM4hV1LU/NF/vI5GJQ4/BmxLmCSbUjDbEIlAjVIHDE1VlHmHaBgAgP7VPDhCzCl1qYeQDD8fmef7fSTKoRrUGfEYc86+qmdrJ/XxGEzHjJwO5EcOPMuED7Rgo2VhT7+ETR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TwjZEd8y; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TwjZEd8y"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5918A1ECB1;
	Wed, 14 Feb 2024 12:33:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=N+7QOXslNlH9
	v8tmTCqar6WiK/mZMuS0EJ9Q+gcmvUU=; b=TwjZEd8y+5WuXpbcFrDtAUw60UaY
	tXtAml3vHgrVNsW00wM3zPdWvHkxrn6FxXHrTZhdbn5Lm4lCJLqRvdDRWHMOFBwb
	6My+LGUK/QGF+xKYkoFbatBQMHTe54Oa9la8Ozt1K/pJi8vqiKO4rGjeOcOjgUzn
	bQ0p1+7RnK6iP4k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 51B3B1ECB0;
	Wed, 14 Feb 2024 12:33:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2A2A21ECAF;
	Wed, 14 Feb 2024 12:33:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 1/1] diff: mark param1 and param2 as placeholders
In-Reply-To: <3a82f72f33663f162aa41cb20c0fb3b6786971c9.1707900029.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Wed, 14 Feb 2024 16:46:41 +0800")
References: <6e33b2b2-f0b1-46ba-bbd8-3ae4c87d35ba@free.fr>
	<cover.1707900029.git.worldhello.net@gmail.com>
	<3a82f72f33663f162aa41cb20c0fb3b6786971c9.1707900029.git.worldhello.net@gmail.com>
Date: Wed, 14 Feb 2024 09:33:03 -0800
Message-ID: <xmqq5xyrvtm8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 1C485080-CB5F-11EE-BE7C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Jiang Xin <worldhello.net@gmail.com> writes:

> Some l10n translators translated the parameters "files", "param1" and
> "param2" in the following message:
>
>     "synonym for --dirstat=3Dfiles,param1,param2..."
>
> Translating "param1" and "param2" is OK, but changing the parameter
> "files" is wrong. The parameters that are not meant to be used verbatim
> should be marked as placeholders, but the verbatim parameter not marked
> as a placeholder should be left as is.
>
> This change is a complement for commit 51e846e673 (doc: enforce
> placeholders in documentation, 2023-12-25).
>
> With the help of Jean-No=C3=ABl,some parameter combinations in one
> placeholder (e.g. "<param1,param2>...") are splited into seperate
> placeholders.
>
> Helped-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
> ---
>  diff.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Makes sense, thanks both.  This is from 2019 so it is not all that
urgent, but it still is a good change.

It is a bit unfortunate that we need to mark what *can* be
translated, not the other way around.  Because of that, something
like ...

>  			       N_("synonym for --dirstat=3Dcumulative"),

... has no marking, but that does not mean that any part of
"--dirstat=3Dcumulative" is up for translation, while "synonym for"
definitely is to be translated.

> +		OPT_CALLBACK_F(0, "dirstat-by-file", options, N_("<param1>,<param2>.=
.."),
> +			       N_("synonym for --dirstat=3Dfiles,<param1>,<param2>..."),
