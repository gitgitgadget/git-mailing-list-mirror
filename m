Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53152205502
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739419581; cv=none; b=YexVp7xqUDHmGe5wjDiHEUF6qQ4WH9RdAsM9wC0ZirFOnLPZUcn/wDkC9GyNd6XEYjYq0ydKBZGMPfEg5i0Ofjt+TPE/kNfWxQfObZNEhPhah2ttcfNDXuuVPEnQQprRgai9OK6fuOcRvmT6KiScHYeNnmeB9aA4qw+Q4Rdct8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739419581; c=relaxed/simple;
	bh=3uo5kcynq34yg+abFDvPd2IUfXrd5y70nkDE3zn46nw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sl9QttLvzE3CO2/LogcGE7fystR6FM5vPCTGhhSpWZ61FfgiEXJPcLsQlhwSFIKkwv5PaTw77XO1nvKhPP+g0m75Eplfx23NaNxRHTLwMIIQ+VvKc8yUNvMhp2G/NpepUmddgZRbYLmDx4u0vGljeb58T8EDoFkbqcaVXomEU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dggzOcwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTepcVj7; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dggzOcwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTepcVj7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 48E80114012C;
	Wed, 12 Feb 2025 23:06:18 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 12 Feb 2025 23:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739419578; x=1739505978; bh=/CBqGI6JOh
	y/6iP5HpuOXPDW/6lij2+8cFTMc/SaJuo=; b=dggzOcwyt7Smt+bgsFvYzTeQD6
	yj+DFoSSorV7y7m7USYfgks1QQvOn3zJsLcq+mjYu1fXuJN5YM8JKlXMtq7sLBD8
	+/dnAD5NEgYo+YSga9/dRmCQ8ofQuCD9i5bXRrzAonPBZg61ROxn1cneYkk4TqJC
	l51yHp/BKCh6xn/mcaO+B2GNgltyGNHBvPV6C9JoviIv7S4ESCA5wYbEUrJqhEOW
	IB7w1f/6I8OHrjPawevGsOa4rCdghbEE2b3Ign8+CO85qOK+AimVxTHHg/sZtkir
	mf2b6PBlLzMMFyYi5ffcWGR53HSBU+feMEjn25hy63+BfuY+Ak7cICW2iZkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739419578; x=1739505978; bh=/CBqGI6JOhy/6iP5HpuOXPDW/6lij2+8cFT
	Mc/SaJuo=; b=mTepcVj7Au2bCu2roufvhVv0ElehR7i7qpFX295WQoyQGN56q3S
	ZCj9ZvHFiXIy0XL9pXc5PvCtBKQ1E0LdANgOQaPgUdgAw+lbuirEvkFcyEvzGUrH
	uMLFc584ZeTYP+5CqXtKYfEW8o7WB3WovOFz8ZyJeKjq04glKdtb7lKjMT0bx2xT
	R2vA2PqBXcj/ZreAv/VnAsUssKd6VG6P0ZqVN1zXsPR8HxpV9uedwmWC69ltp3PB
	tRXPncSdI9alUzUSCt9stO1+evpNK9i97r3Pe2hahjV75LsPqmMRlwGete3uYk5B
	PhGC2Ci8KiiP4DrSSKLI2bC+LQ95gfNxeRQ==
X-ME-Sender: <xms:uW-tZzy-LskNj28JqxClnGffWg-7yPKQoyBDtZH0klrBg3KzcPMyHw>
    <xme:uW-tZ7QDF1cZBtBkP9YYGjYppsHQJXgsCOS5XNY5o3KQEPcoZJUplwrG8VEAxXT2L
    EvgwmzYgscpy8lZDw>
X-ME-Received: <xmr:uW-tZ9WjcDu90xhR9jcHtAICwTDTJkjbvmc0V1N6DHESi0sDJfO1KUL66NRVNwGbo0oG1f-XCBfjHBonVprgqiohApBARJQGiObo18Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehilhhlihgrrdgsoh
    gshihrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:uW-tZ9iLZoUTwFZVjCV5Q2HNxgpbn6OfWzJR5h690_h5_CsE9Y1PpQ>
    <xmx:um-tZ1BfsWXn7VzccCBu8bMJkOFMcY5xjb5NuiGW5Tm6JG-yvoXI4w>
    <xmx:um-tZ2IRzmYeU9R_uO5nm0e6Uyo7APmJMjX4mFICfvDPKOcFjLfEmA>
    <xmx:um-tZ0AEUV7W3cdJTP1xo2d1sJ_M9PJUuo8Gt2zpYpQ94EHlbhz9JQ>
    <xmx:um-tZ0OBLoTqUMGqAZiaowbIKktgeTZKkWv6vC7bz9jL5XGEFF8DLQ4y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 23:06:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Illia Bobyr <illia.bobyr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v5 01/10] t/t4209-log-pickaxe: Naming typo: -G takes a
 regex
In-Reply-To: <20250212032657.1807939-2-illia.bobyr@gmail.com> (Illia Bobyr's
	message of "Tue, 11 Feb 2025 19:26:45 -0800")
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-1-illia.bobyr@gmail.com>
	<20250212032657.1807939-2-illia.bobyr@gmail.com>
Date: Wed, 12 Feb 2025 20:06:16 -0800
Message-ID: <xmqqbjv6qyiv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Illia Bobyr <illia.bobyr@gmail.com> writes:

> Subject: Re: [PATCH v5 01/10] t/t4209-log-pickaxe: Naming typo: -G takes a regex

"Naming" -> "naming".  It is even more preferable if you can avoid
introducing the second colon.  E.g.

    Subject: t/t4209: call the value given to -G <regex>, not <string>

This applies to the titles of all the patches in the series, I suspect?

> Not effect on the test logic, but as "-G" argument is a regex it is more
> accurate to use "regex" as a dummy argument value rather than "string".
> In all the other case when "-G" is passed a dummy value it is spelled as
> "regex" rather than as "string".

I guess the -G tests are copied-and-pasted from existing tests for
the -S option when the -G option was introduced much later.  This
makes me wonder if we try to see what happens when a malformed
regular expression is fed to the -G option (I didn't check---if we
have no test for it, we might want to add one).

> ---

Missing sign-off.

Having said all that, I'd prefer to see the changes in one topic
focused only to give --patch-grep and --patch-modifies synonyms
to the existing option and do nothing else.  Certainly a change
like this is a distraction we do not have to discuss at the same
time.

If you can group all these "preliminary clean-up" changes together
into a separate series, without including any change to add the
longhand to -S/-G, that is also a viable alternative approach.  Once
such a series graduates to 'master', then you'd do the longhand on
top.

What we do not want is to see changes that are not directly
necessary to add the longhand intermixed in the same series.

>  t/t4209-log-pickaxe.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index a675ac..ed70c 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -89,7 +89,7 @@ test_expect_success 'usage: --no-pickaxe-regex' '
>  	test_expect_code 128 git log -Sstring --no-pickaxe-regex 2>actual &&
>  	test_cmp expect actual &&
>  
> -	test_expect_code 128 git log -Gstring --no-pickaxe-regex 2>err &&
> +	test_expect_code 128 git log -Gregex --no-pickaxe-regex 2>err &&
>  	test_cmp expect actual
>  '

Thanks.
